
function EFFECT:Init( data ) 
	
	self.Origin = data:GetOrigin()
	self.DirVec = data:GetNormal()
	self.Scale = data:GetScale()	
	self.Emitter = ParticleEmitter( self.Origin )

	local Density = 40*self.Scale					/// This part is for the shockwave ///
	local Angle = Vector( 0, 0, 1 ):Angle()
	for i=0, Density do	
		Angle:RotateAroundAxis(Angle:Forward(), (360/Density))
		local ShootVector = Angle:Up()
		local Smoke = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), self.Origin )
		if (Smoke) then
			Smoke:SetVelocity( ShootVector * math.Rand(700,1000) )
			Smoke:SetDieTime( math.Rand( 7, 8 )/ 20  )
			Smoke:SetStartAlpha( math.Rand( 90, 120 ) )
			Smoke:SetEndAlpha( 0 )
			Smoke:SetStartSize( 30*self.Scale )
			Smoke:SetEndSize( 60*self.Scale )
			Smoke:SetRoll( math.Rand(0, 360) )
			Smoke:SetRollDelta( math.Rand(-5, 5) )			
			Smoke:SetAirResistance( 0 ) 			 
			Smoke:SetGravity( Vector( 0, 0, -300) )			
			Smoke:SetColor( 120,120,120 )
		end	
	end
		
 end 
   
function EFFECT:Think( )
	return false
end

function EFFECT:Render()
end