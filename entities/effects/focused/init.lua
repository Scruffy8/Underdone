
function EFFECT:Init( data ) 
	
	self.Player = data:GetEntity()
	self.Origin = self.Player:GetPos()
	self.DirVec = self.Player:GetUp()
	self.Scale = data:GetScale()	
	self.Duration = CurTime() + .9
	self.Emitter = self.Player.FixedEmitter
	self.EffectDelay = CurTime()
		
 end 
   
function EFFECT:Think( )
	
	if !( self.Player:IsValid() && self.Player:Alive() ) then return false end
	if self.EffectDelay < CurTime() then
		local Angle = Vector( 0, 0, 1 ):Angle()
		for i=0, 2 do	
			local Smoke = self.Emitter:Add( "particle/fire",  vecRand() * 15 )
			if (Smoke) then
				Smoke:SetVelocity( Vector( 0, 0, 75 )  )
				Smoke:SetDieTime( .5)
				Smoke:SetStartAlpha( 255 )
				Smoke:SetEndAlpha( 0 )
				Smoke:SetStartSize( 5 )
				Smoke:SetEndSize( 0 )
				Smoke:SetRoll( math.Rand(0, 360) )
				Smoke:SetRollDelta( math.Rand(-5, 5) )			
				Smoke:SetAirResistance( 0 ) 			 
				Smoke:SetGravity( Vector( 0, 0, 300) )			
				Smoke:SetStartLength( math.Rand( 5, 12 ) )
				Smoke:SetEndLength( math.Rand( 10, 24 ) )
				Smoke:SetColor( 255,0,0 )
			end	
		end
		 self.EffectDelay = CurTime() + 0.1
	end
	
	return self.Duration > CurTime() 
	
end

function EFFECT:Render()
end