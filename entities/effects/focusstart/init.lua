
function EFFECT:Init( data ) 
	
	self.Player = data:GetEntity()
	self.Origin = self.Player:GetPos()
	self.DirVec = self.Player:GetUp()
	self.Scale = data:GetScale()	
	self.Duration = CurTime() + 1.1
	self.Emitter = ParticleEmitter( self.Origin )
	self.EffectDelay = CurTime()
		
 end 
   
function EFFECT:Think( )
	
	if !( self.Player:IsValid() && self.Player:Alive() ) then return false end
	if self.EffectDelay < CurTime() then
		local Angle = Vector( 0, 0, 1 ):Angle()
		for i=0, 8 do	
			local Smoke = self.Emitter:Add( "particle/fire",  self.Player:GetPos() + vecRand() * 30 )
			if (Smoke) then
				local speed = vecRand() * 500 
				speed.z = 0
				Smoke:SetVelocity( speed )
				Smoke:SetDieTime( .5)
				Smoke:SetStartAlpha( 255 )
				Smoke:SetEndAlpha( 0 )
				Smoke:SetStartSize( 10 )
				Smoke:SetEndSize( 0 )	
				Smoke:SetAirResistance( 0 ) 			 
				Smoke:SetGravity( Vector( 0, 0, 300) )			
				Smoke:SetStartLength( math.Rand( 10, 24 ) )
				Smoke:SetEndLength( math.Rand( 24, 30 ) )
				Smoke:SetColor( 255,0,0 )
			end	
		end
		
		
		local Angle = Vector( 0, 0, 1 ):Angle()
		for i=0, 3 do	
			local Light = self.Emitter:Add( "particle/fire",  self.Player:GetPos() + Vector( 0, 0, 20 ) + vecRand() * 20 )
			if (Light) then
				local speed = vecRand() * 500 
				speed.z = 0
				Light:SetVelocity( speed )
				Light:SetDieTime( .5)
				Light:SetStartAlpha( 255 )
				Light:SetEndAlpha( 0 )
				Light:SetStartSize( 0 )
				Light:SetEndSize( 25 )	
				Light:SetAirResistance( 0 ) 			 	
				Light:SetGravity( Vector( 0, 0, 300) )			
				Light:SetColor( 255,255,255 )
				Light:SetColor( 255,0,0 )
			end	
		end
		 self.EffectDelay = CurTime() + 0.1
	end
	
	return self.Duration > CurTime() 
	
end

function EFFECT:Render()
end
