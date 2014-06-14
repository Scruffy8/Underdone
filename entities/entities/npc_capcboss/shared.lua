

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Bouncy Ball"
ENT.Author			= "Garry Newman"
ENT.Information		= "An edible bouncy ball"
ENT.Category		= "Fun + Games"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

AddCSLuaFile( "shared.lua" )

if CLIENT then


/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()
	end

/*---------------------------------------------------------
   Name: DrawPre
---------------------------------------------------------*/
function ENT:Draw()
		self:DrawModel()
end



end

// This is the spawn function. It's called when a client calls the entity to be spawned.
// If you want to make your SENT spawnable you need one of these functions to properly create the entity
//
// ply is the name of the player that is spawning it
// tr is the trace from the player's eyes 
//
function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	
	local ent = ents.Create( "sent_ball" )
		ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end


/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()

	// Use the helibomb model just for the shadow (because it's about the same size)
	self.Entity:SetModel( "models/combine_apc.mdl" )
	
	// Don't use the model's physics - create a sphere instead
	self:PhysicsInitBox( Vector() * -4, Vector() * 4 )
	
	local phys = self:GetPhysicsObject()
	phys:Sleep()
	phys:SetMass( 1000 )
	
	self:SetMoveType( MOVETYPE_NONE )
	// Wake the physics object up. It's time to have fun!
	// Set collision bounds exactly
	--self.Entity:SetCollisionBounds( Vector( -16, -16, -16 ), Vector( 16, 16, 16 ) )
	--self.Entity:SetCollisionBounds( Vector( -16, -16, -16 ), Vector( 16, 16, 16 ) )

		self.HeadSpin = 0
		self.NextSearch = CurTime()
		self.Blip = 0
		self.Bullet = 0
		self.BlipRate = 0.8
		self.ShotRate = 0.3
		self.Target = nil
		self.DetectRange = 2000
		self.Idle = true
		self.TE = true
		self.Shot = false
		self.ResetTime = 0
		self.ResetRate = 3
		self.HP = 300
		self.GunFire = CreateSound( self, "npc/combine_gunship/gunship_weapon_fire_loop6.wav" )
	    self.NextGrenade = CurTime() + 1
	    self.NextPower = CurTime() + 1
		self.NextRampage = CurTime() + 10
		self.RampageDuration = CurTime()
		
end


function ENT:Trace( target)
		local vecPosition = self:GetPos() + Vector( 0, 0, 70 )
		local vecPosition2 = target:GetPos() + Vector( 0, 0, 50 )
		local tracedata = {}
		tracedata.start = vecPosition
		tracedata.endpos = vecPosition2
		tracedata.filter = { self }
		local trace = util.TraceLine(tracedata)
			return trace
end

function ENT:GetTarget()

		if self.NextSearch < CurTime() then 
		
			local close = 70000
			local final = 0
			local targets = {}
			for _, ply in pairs ( ents.GetAll() ) do
					if ply:IsPlayer() then
						local aim = ( ply:GetPos() - self:GetPos() + Vector( 0, 0, 70 ) )
						aim:Normalize()
								if ( (ply:GetPos():Distance( self:GetPos() ) < close ) and ( ply:GetPos():Distance( self:GetPos() ) < self.DetectRange ) )then
									if ply:Alive() then
										if self:Trace( ply ).Entity == ply then
												close = ply:GetPos():Distance( self:GetPos() ) 
												final = ply
										end
									end
								end
					end
			end	
			
			if final != 0 then
				self.Target = final
			else
				self.Target = nil
			end
			
			self.NextSearch = CurTime() + .5
		
		end
end

function ENT:ShootTurretBullet( pos, ang, ent )

	local bullet = {}
	bullet.Num 		= 1
	bullet.Src 		= pos
	bullet.Dir 		= ang
	bullet.Spread 	= Vector( .07, 0.07, 0 )			// Aim Cone
	bullet.Tracer	= 1		
	bullet.Attacker = ent
	bullet.TracerName = "gotracer"// Show a tracer on every x bullets 
	bullet.Force	= 100	
	bullet.Damage = 15

	ent:FireBullets(bullet)

end

function ENT:Artillery( )

		local effectdata = EffectData()
		local muz =  self:LookupAttachment( "damage2" )
		local muz2 =  self:GetAttachment( muz )
		effectdata:SetOrigin( muz2.Pos +  self:GetUp() * 10 )
		effectdata:SetNormal( self:GetUp() * 1)
		effectdata:SetScale( 3 )
		util.Effect( "muzzle_fire" , effectdata)
		
			local targetpos = self.Target:GetPos()
			self:EmitSound( "npc/env_headcrabcanister/launch.wav", 500  )
			
			local trace = {}
			trace.start = targetpos
			trace.endpos = targetpos + Vector( 0, 0, 60000 )
			trace.filter = self.Target
			local tr = util.TraceLine( trace )
		
			timer.Simple( .4, function()
			
				local proj = ents.Create( "proj_projectile" )
				proj:EmitSound( "npc/env_headcrabcanister/incoming.wav", 500  )
				proj:SetPos( tr.HitPos - Vector( 0, 0, 90 ) + Vector( math.random( -100, 100), math.random( -100, 100), 0 ) )
				proj:Spawn()
				proj:SetAngles( Angle( 90, 0, 0 ) )
				proj:SetSpeed( 100 )
				proj:SetRadius( 300  )
				proj:SetDamage( 100 )
				proj:SetOwner( self )
			
			end)
			
end

function ENT:Grenade()

		local muz =  self:LookupAttachment( "muzzle" )
		local muz2 =  self:GetAttachment( muz )
		
		local ent = ents.Create( "proj_explosive" )
		ent:SetPos( muz2.Pos )
		ent:SetAngles(Angle(math.random(1, 100), math.random(1, 100), math.random(1, 100)))
		ent:SetOwner( self )
		ent:Spawn()
		ent:SetTimer( 1 )
		ent:SetDamage( 50 )
		ent:SetRadius( 200 )
		
		self:EmitSound( "weapons/grenade_launcher1.wav", 100 )
		local phys = ent:GetPhysicsObject()
		local aimang = muz2.Pos - self.Target:GetPos()
		
		phys:ApplyForceCenter( aimang * self:GetPos():Distance( self.Target:GetPos() )  * .7 * -1 )
		phys:AddAngleVelocity(Vector(math.random(-500, 500), math.random(-500, 500), math.random(-500, 500)))
		
end

function ENT:Shoot()

	if CurTime() > self.Bullet then
		local right = self.Second
		local e = EffectData()
		local muz =  self:LookupAttachment( "muzzle" )
		local muz2 =  self:GetAttachment( muz )
     		e:SetStart( muz2.Pos )
			e:SetOrigin( muz2.Pos  )
			e:SetEntity( self )
			e:SetAttachment( muz )
			self:EmitSound( "Weapon_AR2.Single" )
			local aimang =muz2.Pos - self.Target:GetPos() - Vector( 0, 0, 40 )
			aimang:Normalize()
			self:ShootTurretBullet(  muz2.Pos, aimang*-1, self )
		
		util.Effect( "ChopperMuzzleFlash", e )
		self.Bullet = CurTime() + .1
	end

end

function ENT:AimGunAt( aimpos )

			local aimang = self:GetPos() + Vector( 0, 0, 70 ) - aimpos
			aimang:Normalize()
			local aimvector = aimang
			aimang = aimang:Angle() - self:GetAngles()
			aimang:RotateAroundAxis( self:GetUp(), 90 )
			self:SetPoseParameter( "vehicle_weapon_pitch", aimvector.z*45 )
			self:SetPoseParameter( "vehicle_weapon_yaw", aimang.y )
			
			
end

function ENT:Think()
	if SERVER then
		if self:IsValid() then
		
			
			if CurTime() > self.Blip then
				self:EmitSound( "npc/dog/dog_idle3.wav", 390, 100 )
				self.Blip = CurTime() + self.BlipRate
			end
			
			self:GetTarget()
			
			if self.Target then
				if not self.Target:IsValid() then return end
	
				self:AimGunAt( self.Target:GetPos() )
				
				if self:GetPos():Distance( self.Target:GetPos() ) < 1000 and self:GetPos():Distance( self.Target:GetPos() ) > 150 then
					self:Shoot()
				end
				
				self.ResetTime = CurTime() + 30
				
				if self:GetPos():Distance( self.Target:GetPos() ) < 1500 then
					if self.NextGrenade < CurTime() then
						self:Grenade()
						self.NextGrenade = CurTime() + 1
					end
				end
				
				if self.RampageDuration > CurTime() then
					if self.NextPower < CurTime() then
						self:Artillery()
						self.NextPower = CurTime() + .3
					end
				end
				
				if self.NextRampage < CurTime() then
					self.RampageDuration = CurTime() + 5
					self.NextRampage = CurTime() + 10
				end
				
			else
				if self.ResetTime < CurTime() then
					self.NextGrenade = CurTime() + 1
					self.NextRampage = CurTime() + 10
					--print( 'resetted' )
				end
			end
			
			self:NextThink( CurTime()  )
			return true
		end
	end
end

/*---------------------------------------------------------
   Name: OnTakeDamage
---------------------------------------------------------*/
function ENT:OnTakeDamage( dmginfo )

	self.Entity:TakePhysicsDamage( dmginfo )
	
end


/*---------------------------------------------------------
   Name: Use
---------------------------------------------------------*/
function ENT:Use( activator, caller )

end



