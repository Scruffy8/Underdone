
function EFFECT:Init( data ) 
	
	self.Origin = data:GetOrigin()
	self.DirVec = data:GetNormal()
	self.Scale = data:GetScale()
	self.Emitter = ParticleEmitter( self.Origin )

		for i=0,14 do
		local Smoke = self.Emitter:Add("particle/smokesprites_000"..math.random(1,9), self.Origin)
		Smoke:SetVelocity(150*i*self.DirVec)
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
	
	
		for i=0, 2 do
		local Gas = self.Emitter:Add( "effects/muzzleflash"..math.random(1,4), self.Origin )
		Gas:SetVelocity ( self.DirVec *i*700*self.Scale  )
		Gas:SetDieTime( math.Rand(0.06, 0.08) )
		Gas:SetStartAlpha( 170 )
		Gas:SetEndAlpha( 0 )
		Gas:SetStartSize( (30 - i*1.5)*self.Scale )
		Gas:SetEndSize( (50 - i*1.5)*self.Scale/2 )
		Gas:SetRoll( math.Rand(0, 360) )
		Gas:SetRollDelta( math.Rand(-50, 50) )			
		Gas:SetAirResistance( 100 ) 			 		
		Gas:SetColor( 250,250,200 )
		end
	
 end 
   
function EFFECT:Think( )
	return false
end

function EFFECT:Render()
end
