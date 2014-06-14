
function EFFECT:Init( data ) 
	
	self.Player = data:GetEntity()
	self.Origin = self.Player:GetPos()
	self.DirVec = self.Player:GetUp()
	self.Scale = data:GetScale()	
	self.Duration = CurTime() + data:GetMagnitude()	
	self.Emitter = self.Player.FixedEmitter
	self.EffectDelay = CurTime()
		
 end 
   
function EFFECT:Think( )
	
	if !( self.Player:IsValid() && self.Player:Alive() ) then return false end
	
	self.Weapon = self.Player:GetActiveWeapon()
	if self.Weapon:IsValid() then
		if self.Weapon.WeaponTable then
			if !self.Weapon.WeaponTable.Melee then
				return false
			end
		end
	else
		return false
	end
	
	if self.EffectDelay < CurTime() then
		local Density = 20					/// This part is for the shockwave ///
		local Angle = Vector( 0, 0, 1 ):Angle()
		for i=0, Density - 1 do	
			Angle:RotateAroundAxis(Angle:Forward(), (360/Density))
			local ShootVector = Angle:Up()
			local Smoke = self.Emitter:Add( "particle/fire", ShootVector* self.Scale)
			if (Smoke) then
				Smoke:SetVelocity( Vector( 0, 0, 10 )  )
				Smoke:SetDieTime( .2 )
				Smoke:SetStartAlpha( 255 )
				Smoke:SetEndAlpha( 0 )
				Smoke:SetStartSize( 30 )
				Smoke:SetEndSize( 60 )
				Smoke:SetRoll( math.Rand(0, 360) )
				Smoke:SetRollDelta( math.Rand(-5, 5) )			
				Smoke:SetAirResistance( 0 ) 			 
				Smoke:SetGravity( Vector( 0, 0, 300) )			
				Smoke:SetColor( 255,0,0 )
			end	
		end
		 self.EffectDelay = CurTime() + 0.1
	end
	return self.Duration > CurTime() 
	
end

function EFFECT:Render()
end