AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()

	self:SetPos(self:GetPos() + Vector(0,0,30))
	self:DrawShadow( false )
	self:SetModel( "models/Combine_Scanner.mdl" )
	
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		
	self.PhysObj = self:GetPhysicsObject()
	self.PhysObj:EnableGravity( false )
	self.PhysObj:Wake()
	
	self.ttt = false
	
	self.timeNextFire = CurTime() -- don't touch
	self.timeReloading = CurTime() -- don't touch
	self.timePing = CurTime() -- don't touch
	self.timeNextSearch = CurTime() -- don't touch
	
	self.maxhp = 100
	self:SetNWInt( "maxhp", self.maxhp )
	self:SetNWInt( "hp", self.maxhp )
	self.intDamage = 5 -- damage
	self.intFireRate = .1 -- firerate
	self.intPingRate = 1 -- ping rate ( sound ping rate )
	self.intReloadTime = .8 -- reloading time
	self.intAmmoCap = 5 -- max ammo
	self.searchrange = 1000 -- search range
	self.intAmmo = self.intAmmoCap -- current ammo ( don't need to be modified )
	
	self.Owner.spawnedTurret = self
	
end

local tblFilter = {     -- Example of filter.
	["npc_breen"] = "It's breen!",
	["npc_citizen"] = "It's our side citizen!",
	["npc_eli"] = "It's Eli!",
	["npc_kleiner"] = "It's just an placeholder/comment!",
	--[ entityclass ] = <comment or something>,
	--[ entityclass ] = <comment or something>,
	--[ entityclass ] = <comment or something>,
}

-- Change targetable entity
function ENT:Targetable( target )
	if self.ttt then
		if !target:IsPlayer() then return end
		if target:IsTraitor() then return end
	else
		if target.Base == "base_nextbot" then return true end
		if !target:IsNPC() then return false end -- don't target something not NPC
		if tblFilter[ target:GetClass() ] then return false end -- don't target something on the filter.
	end
	return true
end

hook.Add( "Think", "TurretKey", function()
	for k, v in pairs( player.GetAll() ) do
		if v:KeyDown( IN_USE ) then
			if v.spawnedTurret and v.spawnedTurret:IsValid() then
				v.spawnedTurret:WeaponThink()
			end
		end
	end
end)
-- Fire Bullet
-- About spec of bullet of this turret.
function ENT:FireBullet()
	local tblBullet = {}
	tblBullet.Src 		= self:GetPos()
	tblBullet.Dir 		= self.targetAng
	tblBullet.Force		= 5
	tblBullet.Spread 	= Vector( 1, 1, 1 ) * math.Rand( -.15, .15 ) -- accuracy.
	--tblBullet.Spread 	= Vector( 0, 0, 0 )
	tblBullet.Num 		= 1
	tblBullet.Damage	= self.intDamage
	tblBullet.TracerName = "AR2Tracer"
	tblBullet.Tracer	= 2
	self:FireBullets(tblBullet)
end

-- Trace
-- It does moving and things || DON'T TOUCH UNLESS YOU'RE SURE WHAT YOU'RE DOING!
function ENT:Trace( target)
	local vecPosition = self:GetPos()
	local vecPosition2 = target:GetPos() + target:OBBCenter()
	local tracedata = {}
	tracedata.start = vecPosition
	tracedata.endpos = vecPosition2
	tracedata.filter = { self }
	local trace = util.TraceLine(tracedata)
	return trace
end

function ENT:OwnerTrace()
	local ply = self.Owner
	local vecPosition = ply:GetShootPos()
	local vecPosition2 = ply:GetShootPos() + ply:GetAimVector() * 700000
	local tracedata = {}
	tracedata.start = vecPosition
	tracedata.endpos = vecPosition2
	tracedata.filter = { self, ply }
	local trace = util.TraceLine(tracedata)
	local thit = trace.HitPos
	local norm = thit - self:GetPos()
	norm:Normalize()
	return norm
end

-- Get Target
-- It does targeting things. YOU CAN MOD THE TARGET AT ent:Targetable( target )!!! || DON'T TOUCH UNLESS YOU'RE SURE WHAT YOU'RE DOING!
function ENT:GetTarget( drange )

		if self.timeNextSearch < CurTime() then 
		
			local close = drange
			local final = 0
			local targets = {}
			for _, ply in pairs ( ents.GetAll() ) do
					if self:Targetable( ply ) then
						local aim = ( ply:GetPos() - self:GetPos() ):Normalize()
							if ( (ply:GetPos():Distance( self:GetPos() ) < close ) and ( ply:GetPos():Distance( self:GetPos() ) < drange ) )then
								if ply:IsNPC() then if ply:GetNPCState(  ) == 7 then continue end end
									if self:Trace( ply ).Entity == ply then
										close = ply:GetPos():Distance( self:GetPos() ) 
										final = ply
									end
							end
					end
			end	
			
			if final != 0 then
				self:EmitSound( "npc/turret_floor/active.wav" )
				self.Target = final
			else
				self.Target = nil
			end
			
			self.timeNextSearch = CurTime() + .5
		
		end
end

-- Losing Target
-- If turret can't see the target || DON'T TOUCH UNLESS YOU'RE SURE WHAT YOU'RE DOING!
function ENT:IsLosing( target, dist )
	local trace = self:Trace( target )
	local distance = self:GetPos():Distance( target:GetPos() )
	if ( self:Trace( target ).Entity != target ) || ( distance > dist ) then
		return true
	end
end

function ENT:WeaponThink()
			if self:GetNWBool( "inactive" ) then return end 
			if self.intAmmo <= 0 then
				self.timeReloading = CurTime() + self.intReloadTime
				self.intAmmo = self.intAmmoCap
				self:EmitSound( "Weapon_Shotgun.Reload" )
			end
			
			if ( self.timeNextFire < CurTime() && self.timeReloading < CurTime() ) then
				self:EmitSound( "Weapon_Pistol.NPC_Single" )
				self:FireBullet()
				self.timeNextFire = CurTime() + self.intFireRate
				self.intAmmo = self.intAmmo - 1
			end
end

-- Thinking
-- It does thinking || DON'T TOUCH UNLESS YOU'RE SURE WHAT YOU'RE DOING!
function ENT:Think()

	self.Owner = self:GetOwner()
	
	if !self:GetNWBool( "inactive" ) then
		if self.Owner:IsValid() and self.Owner:Alive() then
			self:ResetSequence( "idle" )
			self.targetPos = self.Owner:GetPos() + self.Owner:GetUp()*80 + self.Owner:GetRight() * 30 + self.Owner:GetForward() * 10
			if self.Target && self.Target:IsValid() then
		
				self.targetAng = ( self.Target:GetPos() + self.Target:OBBCenter() - self:GetPos() )
				--self:WeaponThink()
				if self:IsLosing( self.Target, 1000 ) then
					self.Target = nil
					self:EmitSound( "npc/roller/mine/rmine_blip1.wav" )
				end
				
			else
				if self.timePing < CurTime() then
					self:EmitSound("npc/scanner/scanner_scan4.wav")
					self.timePing = CurTime() + self.intPingRate
				end
				self.targetAng = self:OwnerTrace()
				self:GetTarget( self.searchrange )
			end
		else	
			self:Remove()
		end
	end
	
	self.PhysObj:Wake() 
	self:NextThink(CurTime()+0.01)
	return true
	
end

-- Physics Update
-- It does moving and things || DON'T TOUCH UNLESS YOU'RE SURE WHAT YOU'RE DOING!
function ENT:PhysicsUpdate( phys )

	self.PhysObj = phys
	
	if self:GetNWBool( "inactive" ) then
		phys:EnableGravity( true )
	return end
	
	
	if (phys:GetAngleVelocity():Length() > 0) then
		phys:AddAngleVelocity(phys:GetAngleVelocity( )*-1)
	end
	
	if self.targetPos then
		phys:AddVelocity((self.targetPos - phys:GetPos()))
		phys:AddVelocity(phys:GetVelocity() * -0.01)
	end
	
	if self.targetAng then
		self:SetAngles( LerpAngle( .1, self:GetAngles(), self.targetAng:Angle() ) )
	end
		
	
end

function ENT:OnRemove()
	self.Owner = self:GetOwner()
	self.Owner.spawnedTurret = nil
end

function ENT:OnTakeDamage( dmginfo )
	local dmg = dmginfo:GetDamage()
	local hp = self:GetNWInt( "hp" )
	self:SetNWInt( "hp", math.Clamp( hp - dmg, 0, self.maxhp ) )
	if self:GetNWInt( "hp" ) <= 0 and !self:GetNWBool( "inactive" ) then
		self:SetNWBool( "inactive", true )
		self:EmitSound( "ambient/machines/thumper_shutdown1.wav", 80, 150 )
		timer.Simple( 4, function()
			if self:IsValid() then
				local e = EffectData()
					e:SetOrigin( self:GetPos() )
					e:SetStart( self:GetPos() )
				util.Effect("Explosion", e)
				self:Remove()
			end
		end)
	end
end

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create( "npc_fturret" )
		ent:SetPos( SpawnPos )
		ent:Spawn()
		ent:SetOwner( ply )
	ent:Activate()
	return ent
end
