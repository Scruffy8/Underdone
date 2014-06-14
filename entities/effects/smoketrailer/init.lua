
function EFFECT:Init( data ) 
	
	self.Origin = data:GetOrigin()
	self.DirVec = data:GetNormal()
	self.Scale = data:GetScale()
	self.Emitter = ParticleEmitter( self.Origin )

		for i=0,14 do
		local Smoke = self.Emitter:Add("particle/smokesprites_000"..math.random(1,4), self.Origin)
		Smoke:SetVelocity(120*i*self.DirVec)
		Smoke:SetDieTime(math.Rand(0.5,1.3)*self.Scale)
		Smoke:SetStartAlpha(math.Rand(10,20))
		Smoke:SetEndAlpha(0)
		Smoke:SetStartSize(math.random(40,50)*self.Scale)
		Smoke:SetEndSize(math.Rand(80,110)*self.Scale)
		Smoke:SetRoll(math.Rand(180,480))
		Smoke:SetRollDelta(math.Rand(-3,3))
		Smoke:SetColor(200,200,200)
		Smoke:SetAirResistance(500)
		end
		
 end 
   
function EFFECT:Think( )
	return false
end

function EFFECT:Render()
end