AddCSLuaFile( 'shared.lua' )
ENT.Type   = "anim"
ENT.Base                = "base_anim"
ENT.PrintName           = "Towie^2"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

function ENT:Initialize()

    if ( SERVER ) then
        self.Target = NULL
        
        
        self.Entity:SetModel( "models/props_combine/combine_mortar01b.mdl" )
        self.Entity:PhysicsInit(SOLID_VPHYSICS)
        self.Entity:SetMoveType(MOVETYPE_NOCLIP)
            
        self.Entity.Pipe = ents.Create("prop_dynamic")
        self.Entity.Pipe:SetModel("models/props_combine/combine_light001a.mdl")
        self.Entity.Pipe:SetPos(self.Entity:GetPos()+Vector(-0.5,-2.4,10))
        self.Entity.Pipe:Spawn()
        self.Entity.Pipe:SetParent(self.Entity)
        
            self.Entity.Head = ents.Create("prop_dynamic")
            self.Entity.Head:SetModel("models/props_combine/combine_binocular01.mdl")
            self.Entity.Head:SetPos(self.Entity.Pipe:GetPos()+Vector(0,0,15))
            self.Entity.Head:Spawn()
            self.Entity.Head:SetParent(self.Entity.Pipe)
        

            self.Entity.First = ents.Create("prop_dynamic")
            self.Entity.First:SetModel("models/Combine_turrets/ground_turret.mdl")
            self.Entity.First:SetPos(self.Entity.Head:GetPos() + Vector(0,0,20))
            self.Entity.First:Spawn()
            self.Entity.First:SetParent(self.Entity.Head)
        

            self.Entity.Second = ents.Create("prop_dynamic")
            self.Entity.Second:SetModel("models/Airboatgun.mdl")
            self.Entity.Second:SetPos(self.Entity.Head:GetPos()+Vector(20,0,5))
            self.Entity.Second:Spawn()
            self.Entity.Second:SetParent(self.Entity.Head)

            self.Entity.Part = ents.Create("prop_dynamic")
            self.Entity.Part:SetModel("models/props_junk/metal_paintcan001a.mdl")
            self.Entity.Part:SetPos(self.Entity.Head:GetPos()+Vector(-8,0,4))
            self.Entity.Part:SetAngles(Angle(0,90,90))
            self.Entity.Part:Spawn()
            self.Entity.Part:SetParent(self.Entity.Head)


            self.Entity.Part2 = ents.Create("prop_dynamic")
            self.Entity.Part2:SetModel("models/props_junk/propane_tank001a.mdl")
            self.Entity.Part2:SetPos(self.Entity.Head:GetPos()+Vector(-9,2,5))
            self.Entity.Part2:SetAngles(Angle(0,90,90))
            self.Entity.Part2:Spawn()
            self.Entity.Part2:SetParent(self.Entity.Head)
		
	end
		self.HeadSpin = 0
		self.NextSearch = CurTime()
		self.Blip = 0
		self.Bullet = 0
		self.BlipRate = 0.8
		self.ShotRate = 0.3
		self.Target = nil
		self.DetectRange = 700
		self.Idle = true
		self.TE = true
		self.Shot = false
		self.ResetTime = 0
		self.ResetRate = 3
		self.HP = 300
		self.GunFire = CreateSound( self, "npc/combine_gunship/gunship_weapon_fire_loop6.wav" )
end

function ENT:ShootTurretBullet( pos, ang, ent )

	local bullet = {}
	bullet.Num 		= 1
	bullet.Src 		= pos
	bullet.Dir 		= ang
	bullet.Spread 	= Vector( 0.09, 0.09, 0 )			// Aim Cone
	bullet.Tracer	= 1			
	bullet.TracerName = "HelicopterTracer"// Show a tracer on every x bullets 
	bullet.Force	= 100	
	bullet.Damage = 10

	ent:FireBullets(bullet)

end

function ENT:isitNPC( target )
	return target:IsNPC()
end

function ENT:Trace( target)
		local vecPosition = self.Pipe:GetPos()
		local vecPosition2 = target:GetPos() + Vector( 0, 0, 50 )
		local tracedata = {}
		tracedata.start = vecPosition
		tracedata.endpos = vecPosition2
		tracedata.filter = { self, self.Pipe, self.Part, self.Part2, self.First, self.Second}
		local trace = util.TraceLine(tracedata)
			return trace
end

local tblFilter = {
	["npc_breen"] = 1,
	["npc_citizen"] = 1,
	["npc_eli"] = 1,
	["npc_kleiner"] = 1,
}
function ENT:GetTarget()

		if self.NextSearch < CurTime() then 
		
			local close = 70000
			local final = 0
			local targets = {}
			for _, ply in pairs ( ents.GetAll() ) do
					if self:isitNPC( ply ) then
						local aim = ( ply:GetPos() - self.Pipe:GetPos() )
						aim:Normalize()
						if ( aim:DotProduct( self.Pipe:GetForward() ) < -.7  ) then
								if ( (ply:GetPos():Distance( self:GetPos() ) < close ) and ( ply:GetPos():Distance( self:GetPos() ) < self.DetectRange ) )then
									if ply:GetNPCState(  ) != 7 then
										if self:Trace( ply ).Entity == ply then
											if not tblFilter[ ply:GetClass() ] then
												close = ply:GetPos():Distance( self:GetPos() ) 
												final = ply
											end
										end
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

function ENT:Shoot()

	if CurTime() > self.Bullet then
		local right = self.Second
		local e = EffectData()
		
			e:SetStart( right:GetPos()+right:GetForward() * 62 )
			e:SetOrigin( right:GetPos()+right:GetForward() * 62 )
			e:SetEntity( right )
			e:SetAttachment(1)
			right:EmitSound("npc/strider/strider_minigun.wav")
			self:ShootTurretBullet( right:GetPos()+right:GetForward() * 62, right:GetAngles():Forward(), right )
			self.Shot = true
		
		util.Effect( "ChopperMuzzleFlash", e )
		self.Bullet = CurTime() + self.ShotRate
	end

end

function ENT:GoHome()

		local effectdata2 = EffectData()
			effectdata2:SetStart(self.Entity:GetPos())
			effectdata2:SetOrigin(self.Entity:GetPos())
			effectdata2:SetScale(1)
		util.Effect("Explosion", effectdata2)
		
		local effectdata2 = EffectData()
			effectdata2:SetStart(self.Entity:GetPos() )
			effectdata2:SetOrigin(self.Entity:GetPos())
			effectdata2:SetScale( 2 )
		util.Effect("epicboom", effectdata2)
		
		self:Remove()
		
end

function ENT:Think()
	if SERVER then
		if self:IsValid() then
		
			if !self.Target then
				self.Head:SetAngles( self.Pipe:GetAngles() + Angle( 0, -180, 0 ) + Angle( 0, math.sin( CurTime() ) * 45, 0 ) )
				self.BlipRate = 0.8
			else
				if self.Target:IsValid() then
					self:Shoot()
					local targetangle = (self.Target:LocalToWorld(self.Target:OBBCenter()) - self.Head:GetPos()):Angle() + Angle(0,0,0)
					self.Head:SetAngles( targetangle )
				end
			end
			
			if CurTime() > self.Blip then
				self:EmitSound( "npc/dog/dog_idle3.wav", 390, 100 )
				self.Blip = CurTime() + self.BlipRate
			end
			
			self:GetTarget()
			
			if self.Target then
				self.Idle = false
			end
			
			self:NextThink( CurTime() + 0.1 )
			return true
		end
	end
end

function ENT:OnTakeDamage( dmginfo )
	self.HP = self.HP - dmginfo:GetDamage()
	if self.HP <= 0 then self:Remove() end
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
	
	local beem = Material( "trails/laser" )
	function ENT:Draw()
		self.Entity:DrawModel()
		render.SetMaterial( beem )
		local spos = self:GetPos() + Vector( 0, 0, 30 ) + self:GetRight() * 2
		local forward = self:GetAngles()
		self:SetRenderBoundsWS(  spos, spos + self:GetForward()*self.DetectRange )
		render.DrawBeam( spos, spos + forward:Forward()*self.DetectRange , 2, 1, 0, Color( 255, 255, 0, 255 ) )
		forward:RotateAroundAxis( forward:Up(), 45 )
		render.DrawBeam( spos, spos + forward:Forward()*self.DetectRange , 2, 1, 0, Color( 255, 255, 0, 255 ) )
		forward:RotateAroundAxis( forward:Up(), -90 )
		render.DrawBeam( spos, spos + forward:Forward()*self.DetectRange , 2, 1, 0, Color( 255, 255, 0, 255 ) )
	end

end
