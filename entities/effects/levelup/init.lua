
function EFFECT:Init( data ) 
	
	self.Origin = data:GetOrigin()
	self.DirVec = Vector( 0, 0, 1 )
	self.Scale = data:GetScale()
	self.Player = data:GetEntity()
	self.Emitter = self.Player.FixedEmitter
	self.EffectDelay = CurTime()
	self.Duration = CurTime() + 1.4
	if !self.Emitter then return end

		for i=0,14 do
			local Smoke = self.Emitter:Add("sprites/glow04_noz", Vector( 0, 0, 0 ) )
			Smoke:SetVelocity(70*i*self.DirVec)
			Smoke:SetDieTime(math.Rand(0.5,1.3)*self.Scale)
			Smoke:SetStartAlpha(math.Rand(100,150))
			Smoke:SetEndAlpha(0)
			Smoke:SetStartSize(math.random(20,30)*self.Scale)
			Smoke:SetEndSize( ( math.Rand(10,30)*self.Scale ))
			Smoke:SetRoll(math.Rand(180,480))
			Smoke:SetRollDelta(math.Rand(-3,3))
			Smoke:SetColor(200,200,200)
			Smoke:SetAirResistance(500)
		end
	
 end 
      
function EFFECT:Think( )
	
	if !( self.Player:IsValid() ) or !( self.Emitter )  then return false end
	
	if self.EffectDelay < CurTime() then
		for i=0, 10 do	
			local Smoke = self.Emitter:Add( "sprites/glow04_noz",  vecRand() * 15 )
			if (Smoke) then
				Smoke:SetVelocity( Vector( 0, 0, 200 )  )
				Smoke:SetDieTime( .2)
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
				Smoke:SetColor( 255,255,255 )
			end	
		end
		 self.EffectDelay = CurTime() + 0.1
	end
	
	return self.Duration > CurTime() 
	
end
	


function EFFECT:Render()
end