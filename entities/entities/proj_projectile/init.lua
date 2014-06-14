
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')


function ENT:Trail()
	util.SpriteTrail( self,
											1, 
											Color( 255, 0, 0, 200 ),  //Color
											false, // bAdditive
											20, //fStartWidth
											1, //fEndWidth
											0.3, //fLifetime
											1 / ((10) * 0.5), //fTextureRes
											"trails/laser.vmt" ) //strTexture
end

function ENT:Initialize()

	self.Entity:SetModel("models/Items/grenadeAmmo.mdl")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:DrawShadow( false )
	
	// Don't collide with the player
	self.Entity:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	
	local phys = self.Entity:GetPhysicsObject()
	
	if (phys:IsValid()) then
		phys:Wake()
	end
	
	self.timer = CurTime() + 10
	self.intDamage = 10
	self.intRadius = 10
	self.solidify = CurTime() + 1
	
	self:Trail()

																	
end

function ENT:SetDamage( intDamage )
	self.intDamage = intDamage
end
 
function ENT:SetRadius( intRadius )
	self.intRadius = intRadius
end

function ENT:SetSpeed( intSpeed )
	self.intSpeed = intSpeed
end
 
function ENT:Blast()

		if self.funcExplosion then
			self:funcExplosion()
		else
			self:DefaultExplosion()
		end
		
end

function ENT:OnHit( vecHitPos )

	local owner = self.Owner or self
	--
	if owner:IsPlayer() then
		util.BlastDamage( self.Entity, self.Owner , vecHitPos, self.intRadius, self.intDamage )
	else
		dmgRound2( self.Entity, vecHitPos, self.intRadius, self.intDamage )
	end
	
	local effectdata2 = EffectData()
		effectdata2:SetStart( vecHitPos )
		effectdata2:SetOrigin( vecHitPos )
		effectdata2:SetScale(1)
	util.Effect("Explosion", effectdata2)
		
	local effectdata2 = EffectData()
		effectdata2:SetStart( vecHitPos )
		effectdata2:SetOrigin( vecHitPos )
		effectdata2:SetScale( 2 )
	util.Effect("epicboom", effectdata2)
		
	self.Entity:EmitSound( "weapons/hegrenade/explode"..math.random(3,5)..".wav", 300)
	util.ScreenShake( vecHitPos, 1000, 100, 1.1, self.intRadius * 1.2 )
	self.Entity:Remove()
end

function ENT:OnHitEntity()
end

function ENT:FlyThink()

end

function ENT:Think()	

		local trace = {}
			trace.start = self.Entity:GetPos()
			trace.endpos = self.Entity:GetPos() + self:GetForward() * self.intSpeed
			trace.filter = { self.Entity, self:GetOwner() } 
			local tr = util.TraceLine( trace )

			if tr.HitSky then
				self.Entity:Remove()
				return true
			end	
			
			
			self.Entity:FlyThink()
			
			if tr.Hit then
				if tr.Entity:IsValid() then
					self:OnHitEntity( tr.HitPos )
				else
					self:OnHit( tr.HitPos )
				end
			end

	self.Entity:SetPos(self.Entity:GetPos() + self:GetForward() * self.intSpeed)
--	self.Entity:SetAngles(self.flightvector:Angle() + Angle(90,0,0))
	self.Entity:NextThink( CurTime() )
	return true
end

function ENT:OnTakeDamage( dmginfo )
end

function ENT:Use( activator, caller, type, value )
end

function ENT:StartTouch( entity )
end

function ENT:EndTouch( entity )
end

function ENT:Touch( entity )
end
