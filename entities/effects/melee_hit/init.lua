
function EFFECT:Init( data ) 
	
	-- Thanks Generic Default. Your code was really helpful!
	self.WeaponEnt = data:GetEntity()
	self.HitPos = data:GetOrigin()
	self.HitNormal = data:GetStart()
	self.Scale = data:GetScale()
	
	if !self.WeaponEnt:IsValid() then return end
	local ply = self.WeaponEnt:GetOwner()
	if not ply:IsValid() then return end
	
	--self.DirVec = self.HitNormal
	self.DirVec = Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), math.Rand( 0, 1 ) )
	self.Emitter = ParticleEmitter( self.HitPos )
	self.HitType = 1

		for i=0,2 do
		local Smoke = self.Emitter:Add("particle/smokesprites_000"..math.random(1,9), self.HitPos)
		Smoke:SetVelocity(120*i*self.DirVec*(self.Scale*1.5))
		Smoke:SetDieTime(math.Rand(0.5,1.3)*self.Scale)
		Smoke:SetStartAlpha(math.Rand(100,200))
		Smoke:SetEndAlpha(0)
		Smoke:SetStartSize(math.random(20,30)*self.Scale)
		Smoke:SetEndSize(math.random(30,32)*self.Scale*i/2)
		Smoke:SetRoll(math.Rand(180,480))
		Smoke:SetRollDelta(math.Rand(-3,3))
		Smoke:SetColor(200,200,200)
		Smoke:SetLighting( true )
		Smoke:SetGravity( Vector( 0, 0, 430 ) )
		Smoke:SetAirResistance(501)
		end
		
		sound.Play( "weapons/knife/knife_hit" .. math.random( 1, 4 ) ..".wav", self.HitPos, 75, 100, 1 )
		sound.Play( "physics/flesh/flesh_squishy_impact_hard"  .. math.random( 1, 3 ) ..".wav", self.HitPos, 75 , 150 )
		
		
		local Bloodz = self.Emitter:Add("effects/blood_core", self.HitPos)
		Bloodz:SetVelocity(120*self.DirVec)
		Bloodz:SetDieTime(math.Rand(0.2,.3)*self.Scale)
		Bloodz:SetStartAlpha(255)
		Bloodz:SetEndAlpha(0)
		Bloodz:SetStartSize(math.random(40,50)*self.Scale)
		Bloodz:SetEndSize(math.Rand(80,110)*self.Scale)
		Bloodz:SetRoll(math.Rand(180,480))
		Bloodz:SetRollDelta(math.Rand(-3,3))
		Bloodz:SetColor(80,15,15)
		Bloodz:SetAirResistance(500)
		
		for i=0,8 do
		local flare = self.Emitter:Add("decals/blood".. math.random( 1, 5 ), self.HitPos)
		flare:SetVelocity( ( self.DirVec + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), math.Rand( -1, 1 ) ) ) * math.Rand( 100, 400 ))
		flare:SetDieTime(math.Rand(.1,.3)*self.Scale)
		flare:SetStartAlpha(255)
		flare:SetEndAlpha(0)
		flare:SetStartSize(math.random(1,1)*self.Scale)
		flare:SetEndSize(math.random(1,1)*self.Scale*i/2)
		flare:SetStartLength( 0 )
		flare:SetEndLength( math.Rand( 10, 24 ) )
		flare:SetGravity( Vector( 0, 0, -10 ) )
		flare:SetColor(200,200,200)
		flare:SetAirResistance(500)
		end
		
		local spread = .2
		for i=0,8 do
		local blood = self.Emitter:Add("effects/mh_blood".. math.random( 1, 3 ), self.HitPos)
		blood:SetVelocity( ( self.DirVec + Vector( math.Rand( -.1, .1 ), math.Rand( -.1, .1 ), math.Rand( -spread+.2, spread+.2 ) ) ) * math.Rand( 200, 500 ))
		blood:SetDieTime(math.Rand(.1,.2)*self.Scale)
		blood:SetStartAlpha(255)
		blood:SetEndAlpha(0)
		blood:SetStartSize(math.random(30,90)*self.Scale)
		blood:SetEndSize(0)
		blood:SetStartLength( 0 )
		blood:SetEndLength( math.Rand( 40, 60 ) )
		blood:SetGravity( Vector( 0, 0, 0) )
		blood:SetColor(200,200,200)
		blood:SetAirResistance(500)
		end
	
 end 
   
   
/*---------------------------------------------------------
   THINK
---------------------------------------------------------*/
function EFFECT:Think( )
	return false
end

/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render()
end

