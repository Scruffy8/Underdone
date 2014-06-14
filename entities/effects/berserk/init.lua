
function EFFECT:Init( data ) 
	
	self.Player = data:GetEntity()
	self.Origin = self.Player:GetPos()
	self.DirVec = self.Player:GetUp()
	self.Scale = data:GetScale()	
	self.Duration = CurTime() + data:GetMagnitude()
	self.Emitter = self.Player.FixedEmitter
	self.EffectDelay = CurTime()
		
	for i=0, 15 do	
		local Smoke = self.Emitter:Add( "sprites/ar2_muzzle".. math.random( 3, 4 ),  Vector( 0, 0, math.random( 0, 10 ) )+vecRand() * 2 )
		if (Smoke) then
			Smoke:SetVelocity(  vecRand()  * 600  )
			Smoke:SetDieTime( .2)
			Smoke:SetStartAlpha( 255 )
			Smoke:SetEndAlpha( 0 )
			Smoke:SetStartSize( 30 )
			Smoke:SetEndSize( 0 )
			Smoke:SetRoll( math.Rand(0, 360) )
			Smoke:SetRollDelta( math.Rand(-5, 5) )			
			Smoke:SetAirResistance( 400 ) 			 
			Smoke:SetGravity( Vector( 0, 0, 300) )			
			Smoke:SetStartLength( math.Rand( 5, 12 ) )
			Smoke:SetEndLength( math.Rand( 10, 24 ) )
			--Smoke:SetColor( 255,0,0 )
		end	
	end
		
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
		local Angle = Vector( 0, 0, 1 ):Angle()
		sound.Play( "ambient/energy/zap" .. math.random( 5, 9 ) ..".wav", self.Player:GetPos(), 75, 220 )
		for i=0, 10 do	
			local Smoke = self.Emitter:Add( "sprites/ar2_muzzle".. math.random( 3, 4 ),  Vector( 0, 0, math.random( 0, 60 ) )+vecRand() * 2 )
			if (Smoke) then
				Smoke:SetVelocity(  vecRand()  * 100  )
				Smoke:SetDieTime( .1)
				Smoke:SetStartAlpha( 255 )
				Smoke:SetEndAlpha( 0 )
				Smoke:SetStartSize( 30 )
				Smoke:SetEndSize( 0 )
				Smoke:SetRoll( math.Rand(0, 360) )
				Smoke:SetRollDelta( math.Rand(-5, 5) )			
				Smoke:SetAirResistance( 5 ) 			 
				Smoke:SetGravity( Vector( 0, 0, 300) )			
				Smoke:SetStartLength( math.Rand( 5, 12 ) )
				Smoke:SetEndLength( math.Rand( 10, 24 ) )
				--Smoke:SetColor( 255,0,0 )
			end	
		end
		 self.EffectDelay = CurTime() + 0.1
	end
	
	return self.Duration > CurTime() 
	
end

function EFFECT:Render()
end