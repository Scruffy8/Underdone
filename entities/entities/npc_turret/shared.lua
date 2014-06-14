AddCSLuaFile( 'shared.lua' )

ENT.Type   = "anim"
ENT.Base                = "base_anim"
ENT.PrintName           = "Towie^2"

function ENT:Initialize()

    if ( SERVER ) then
        self.Target = NULL
        
        
        self.Entity:SetModel( "models/props_c17/TrapPropeller_Engine.mdl" )
        self.Entity:PhysicsInit(SOLID_VPHYSICS)
        self.Entity:SetMoveType(MOVETYPE_NOCLIP)
        
		self.Entity.Spin = CreateSound(self.Entity, "ambient/machines/spin_loop.wav")
            
		self.Entity.Pipe = ents.Create("prop_physics")
        self.Entity.Pipe:SetModel("models/props_canal/mattpipe.mdl")
        self.Entity.Pipe:SetPos(self.Entity:GetPos()+Vector(-0.5,-2.4,12))
        self.Entity.Pipe:Spawn()
        self.Entity.Pipe:SetParent(self.Entity)
        
        self.Entity.Head = ents.Create("prop_physics")
        self.Entity.Head:SetModel("models/props_lab/reciever01b.mdl")
        self.Entity.Head:SetPos(self.Entity.Pipe:GetPos()+Vector(0,0,15))
        self.Entity.Head:Spawn()
        self.Entity.Head:SetParent(self.Entity.Pipe)
        
        self.Entity.First = ents.Create("prop_physics")
        self.Entity.First:SetModel("models/Airboatgun.mdl")
        self.Entity.First:SetPos(self.Entity.Head:GetPos()+Vector(0,-10,0))
        self.Entity.First:Spawn()
        self.Entity.First:SetParent(self.Entity.Head)
        
        self.Entity.Second = ents.Create("prop_physics")
        self.Entity.Second:SetModel("models/Airboatgun.mdl")
        self.Entity.Second:SetPos(self.Entity.Head:GetPos()+Vector(0,10,0))
        self.Entity.Second:SetAngles(Angle(0,0,180))
        self.Entity.Second:Spawn()
        self.Entity.Second:SetParent(self.Entity.Head)
        
		
		self.HeadSpin = 0
		self.Blip = 0
		self.Bullet = 0
		self.BlipRate = 0.8
		self.ShotRate = 0.05
		self.Target = nil
		self.DetectRange = 1024
		self.Idle = true
		self.TE = true
		self.Shot = false
		self.ResetTime = 0
		self.ResetRate = 3
	end
end

function ENT:ShootTurretBullet( pos, ang, ent )

	local bullet = {}
	bullet.Num 		= 1
	bullet.Src 		= pos
	bullet.Dir 		= ang
	bullet.Spread 	= Vector( 0.05, 0.05, 0 )			// Aim Cone
	bullet.Tracer	= 1			
	bullet.TracerName = "Ar2Tracer"// Show a tracer on every x bullets 
	bullet.Force	= 50	
	
	bullet.Damage = 7
	
	bullet.Callback = function(attacker, tr, dmginfo)
		
		local MetalBounce = {
		MAT_CLIP,
		MAT_METAL,
		MAT_VENT,
		MAT_GRATE,
		}
		
		local BloodSplat = {
		MAT_ALIENFLESH,
		MAT_ANTLION,
		MAT_BLOODYFLESH,
		MAT_FLESH,
		}
		
		local RockDerbis = {
		MAT_TILE,
		MAT_CONCRETE,
		}

		local DustAsshole = {
		MAT_PLASTIC,
		MAT_SAND,
		MAT_WOOD,
		MAT_DIRT,
		}
		
		local Electric = {
		MAT_COMPUTER,
		}
		
		
			if table.HasValue(MetalBounce, tr.MatType) then
			
				local effectdata = EffectData()
				effectdata:SetStart(tr.HitPos)
				effectdata:SetNormal(tr.Normal)
				effectdata:SetScale(0.4)
				util.Effect("rico_trace", effectdata)
			
			elseif table.HasValue(BloodSplat, tr.MatType) then
			
				tr.Entity:EmitSound( "physics/flesh/flesh_squishy_impact_hard3.wav", 100, 100 )
				tr.Entity:EmitSound( "physics/flesh/flesh_squishy_impact_hard4.wav", 110, 110 )
				tr.Entity:EmitSound( "physics/flesh/flesh_squishy_impact_hard3.wav", 120, 120 )
				
				local effectdata = EffectData()
				effectdata:SetOrigin(tr.HitPos)
				effectdata:SetNormal(tr.HitNormal)
				effectdata:SetScale(1)
				util.Effect("headshot", effectdata)
				
			elseif table.HasValue(DustAsshole, tr.MatType) then
				
				local effectdata = EffectData()
				effectdata:SetOrigin(tr.HitPos)
				effectdata:SetNormal(tr.HitNormal)
				effectdata:SetScale(1)
				util.Effect("hitsmoke", effectdata)
				
			elseif table.HasValue(RockDerbis, tr.MatType) then
				
				local effectdata = EffectData()
				effectdata:SetOrigin(tr.HitPos)
				effectdata:SetNormal(tr.HitNormal)
				effectdata:SetMagnitude( 0.5 )
				effectdata:SetScale(67)
				util.Effect("concsp", effectdata)
				
				local effectdata = EffectData()
				effectdata:SetOrigin(tr.HitPos)
				effectdata:SetNormal(tr.HitNormal)
				effectdata:SetScale(1)
				util.Effect("hitsmoke", effectdata)
				
			elseif table.HasValue(Electric, tr.MatType) then
			
				tr.Entity:EmitSound( "ambient/energy/zap".. math.random(1, 9) ..".wav", 100, 100 )
				
				local effectdata = EffectData()
				effectdata:SetOrigin(tr.HitPos)
				util.Effect("electric_bigzap", effectdata)
				
			else
			
			end
		
		
		
	end
	
	ent:FireBullets(bullet)

end

function ENT:Shoot()

	if CurTime() > self.Bullet then
		local left = self.First
		local right = self.Second
		local e = EffectData()
		
		if self.Shot then
			e:SetStart( left:GetPos()+left:GetForward() * 62 )
			e:SetOrigin( left:GetPos()+left:GetForward() * 62 )
			e:SetEntity( left )
			e:SetAttachment(1)
			left:EmitSound("Weapon_MP5Navy.Single")
			self:ShootTurretBullet( left:GetPos()+left:GetForward() * 62, left:GetAngles():Forward(), left )
			self.Shot = false
		else
			e:SetStart( right:GetPos()+right:GetForward() * 62 )
			e:SetOrigin( right:GetPos()+right:GetForward() * 62 )
			e:SetEntity( right )
			e:SetAttachment(1)
			right:EmitSound("Weapon_MP5Navy.Single")
			self:ShootTurretBullet( right:GetPos()+right:GetForward() * 62, right:GetAngles():Forward(), right )
			self.Shot = true
		end
		
		util.Effect( "ChopperMuzzleFlash", e )
		self.Bullet = CurTime() + self.ShotRate
	end

end

function ENT:Think()
	if SERVER then
		if self:IsValid() then
		
			if self.Target then
				if !self.Target:IsValid() then
					self.Target = nil
				end
				if self.Target then
					if self.Target:GetNPCState( ) == 7 then
						self.Target = nil
					end
				end
				
				self:Shoot()
			end
			
			if self.Idle then
				if self.HeadSpin > 360 then
					self.HeadSpin = self.HeadSpin - 360
				end

				self.HeadSpin = self.HeadSpin + 1
				self.Head:SetAngles( self.Head:GetAngles() + Angle( 0, 1, 0 ) )
				self.BlipRate = 0.8
			else
				if !self.Target then
					self.Target = nil
					self.Idle = true
				else
					local targetangle = (self.Target:LocalToWorld(self.Target:OBBCenter()) - self.Head:GetPos()):Angle() + Angle(0,0,0)
					self.Head:SetAngles( targetangle )
					self.BlipRate = 0.2
				end
			end
			
			if CurTime() > self.Blip then
				self:EmitSound( "HL1/fvox/beep.wav", 300, 250 )
				self.Blip = CurTime() + self.BlipRate
			end
			
			local detection = ents.FindInSphere( self:GetPos(), self.DetectRange )
			local npctable = {}
			for _, ent in pairs ( detection ) do
				if ent:IsNPC() and  ent:GetNPCState( ) != 7 then
					table.insert( npctable, ent )
				end
			end
			
			local TempDist = 0
			for _, ent in pairs ( npctable ) do
				local dist = self:GetPos():Distance(ent:GetPos())
				if dist > TempDist then
					if !self.Target then
						self.Target = ent
					end
				end
			end
			
			if CurTime() > self.ResetTime then
				self.Target = nil
				self.ResetTime = CurTime() + self.ResetRate
			end
			
			if #npctable == 0 then
				self.Target = nil
				self.Idle = true
			else
				self.Idle = false
			end
			
			self:NextThink( CurTime() )
			return true
		end
	end
end

function ENT:SpawnFunction( ply, tr )

    if ( !tr.Hit ) then return end
    
    local SpawnPos = (tr.HitPos + tr.HitNormal * 16)-Vector(0,0,50)
    
    local ent = ents.Create( ClassName )
    ent:SetPos( SpawnPos )
    ent:Spawn()
    ent:Activate()
    
    ent.Owner = ply
    
    return ent
    
end

function ENT:OnRemove()
end

function ENT:Use( activator )
end


if CLIENT then
	
	function ENT:Draw()
		self.Entity:DrawModel()
	end

end
