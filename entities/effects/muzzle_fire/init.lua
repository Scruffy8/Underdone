
function EFFECT:Init( data ) 
	
	local f_mult = math.Clamp( 60 - 1/FrameTime(), 0, 60 )/60 -- for who has shitty computer 
	-- Thanks Generic Default. Your code was really helpful!
	self.WeaponEnt = data:GetEntity()
	self.Scale = data:GetScale()
	
	if !self.WeaponEnt:IsValid() then return end
	local ply = self.WeaponEnt:GetOwner()
	if not ply:IsValid() then return end
	local pos, ang = ply:GetPACPartPosAng( pac_luamodel[ GAMEMODE.PapperDollEnts[ply:EntIndex()]["slot_primaryweapon"] ], "muzzleflash")
	if not pos then return end
	self.Origin = pos
	self.DirVec = Vector( 0, 0, 1 )
	self.DirVec2 = ang:Up()*1
	self.Emitter = self.WeaponEnt.MuzzleEmitter
	self.Emitter2 =ParticleEmitter( pos )
	
	if not self.Emitter then return end 
	local WeaponTable = GAMEMODE.DataBase.Items[ ply:GetSlot("slot_primaryweapon") ]
	if WeaponTable then
		self.MuzzleType = WeaponTable.MuzzleType or 1
	else
		self.MuzzleType = 1
	end

		local Heatwave = self.Emitter:Add("sprites/heatwave", Vector( 0, 0, 0 ) )
		Heatwave:SetVelocity(130*self.DirVec)
		Heatwave:SetDieTime(math.Rand(0.15,0.2))
		Heatwave:SetStartSize(math.random(50,60)*self.Scale)
		Heatwave:SetEndSize(0)
		Heatwave:SetRoll(math.Rand(180,480))
		Heatwave:SetRollDelta(math.Rand(-1,1))
		Heatwave:SetGravity(Vector(0,0,100))
		Heatwave:SetAirResistance(160)


		for i=0,5 do
		local Smoke = self.Emitter2:Add("particle/smokesprites_000"..math.random(1,9), pos )
		Smoke:SetVelocity(120*i*self.DirVec2*(self.Scale*1.5))
		Smoke:SetDieTime(math.Rand(0.5,1.3)*self.Scale)
		Smoke:SetStartAlpha(math.Rand(10,20))
		Smoke:SetEndAlpha(0)
		Smoke:SetStartSize(math.random(40,50)*self.Scale)
		Smoke:SetEndSize(math.random(60,65)*self.Scale*i/2)
		Smoke:SetRoll(math.Rand(180,480))
		Smoke:SetRollDelta(math.Rand(-3,3))
		Smoke:SetColor(200,200,200)
		Smoke:SetGravity( Vector( 0, 0, 430 ) )
		Smoke:SetAirResistance(501)
		end
	
		if ( self.MuzzleType == 1 || self.MuzzleType == 4 ) then
			
			if self.MuzzleType == 4 then
				local ang = self.DirVec:Angle()
				ang:RotateAroundAxis( self.DirVec:Angle():Forward(), math.random( -15, 15 ) )
				for a=0, 2 do
					ang:RotateAroundAxis( self.DirVec:Angle():Forward(), 120 )
					local Flash = self.Emitter:Add("effects/muzzleflash"..math.random(1,4), Vector( 0, 0, 0 ) )
					Flash:SetVelocity( ang:Up()*100*(self.Scale*3) )
					Flash:SetDieTime( math.Rand(0.06, 0.08) )
					Flash:SetStartAlpha(255)
					Flash:SetEndAlpha(0)
					Flash:SetStartSize(20*self.Scale)
					Flash:SetEndSize(80*self.Scale )
					Flash:SetRoll(math.Rand(180,480))
					Flash:SetRollDelta(math.Rand(-1,1))
					Flash:SetColor(255,255,255)	
					Flash:SetStartLength( math.Rand( 20, 50 )*self.Scale  )
					Flash:SetEndLength( math.Rand( 20, 50  )*self.Scale  )
				end
			end
			
			
			for i=0, 3 do
			local Gas = self.Emitter:Add( "effects/muzzleflash"..math.random(1,4), Vector( 0, 0, 0 ) )
			--local Gas = self.Emitter:Add( "effects/combinemuzzle1", self.Origin )
			local fac = 1
			if ply == LocalPlayer() then
				fac = fac + 1.5
			end
			Gas:SetVelocity ( self.DirVec *i*600*self.Scale/1.05 * fac )
			Gas:SetDieTime( math.Rand(0.06, 0.08)  )
			Gas:SetStartAlpha( 170 )
			Gas:SetEndAlpha( 0 )
			Gas:SetStartSize( (60 - i*1.5)*self.Scale )
			Gas:SetEndSize( (50 - i*1.5)*self.Scale/2 )
			Gas:SetRoll( math.Rand(0, 360) )
			Gas:SetRollDelta( math.Rand(-50, 50) )			
			Gas:SetAirResistance( 500 ) 			 		
			Gas:SetColor( 255,220,220 )
			end
			
			
				for i = 1, 5 do
					local Flak = self.Emitter:Add("effects/spark", Vector( 0, 0, 0 ) )
					local goAfter = math.random( 100, 1200 )
					if ply == LocalPlayer() then
						goAfter = math.random( 200, 2500 )
					end
					Flak:SetVelocity ( self.DirVec*goAfter*self.Scale+ Vector( math.random( -100, 100 ) / 100, math.random( -100, 100 ) / 100, 0 ) * 65 )
					Flak:SetDieTime(math.Rand(0.06, 0.08) )
					Flak:SetStartAlpha(100)
					Flak:SetEndAlpha(0)
					Flak:SetStartSize(math.Rand( 5, 10 )*self.Scale*1.5  )
					Flak:SetEndSize(2*self.Scale )
					Flak:SetColor(255,200,200)	
					Flak:SetStartLength( math.Rand( 0, 1 )*self.Scale  )
					Flak:SetEndLength( math.Rand( 10, 20 )*self.Scale*1.1 )
				end
			
			local Spear = self.Emitter:Add("effects/muzzleflash"..math.random(1,4), Vector( 0, 0, 0 ) )
				--local Flash = self.Emitter:Add("effects/combinemuzzle1", self.Origin)
			Spear:SetVelocity ( self.DirVec )
			Spear:SetDieTime(math.Rand(0.06, 0.08) )
			Spear:SetStartAlpha(255)
			Spear:SetEndAlpha(0)
			Spear:SetStartSize(50*self.Scale  )
			Spear:SetEndSize(0*self.Scale )
			Spear:SetColor(255,150,150)	
			Spear:SetStartLength( math.Rand( 20, 50 )*self.Scale  )
			local erand = math.Rand( 230, 200  )*self.Scale 
			if ply == LocalPlayer() then
				erand = erand + 60
			end
			Spear:SetEndLength( erand )
			
			
		elseif ( self.MuzzleType == 2 || self.MuzzleType == 3 ) then
				
			for i=0, 5 do
			local Gas = self.Emitter:Add( "effects/combinemuzzle2", Vector( 0, 0, 0 ) )
			Gas:SetVelocity ( self.DirVec *i*500*self.Scale/1.5 )
			Gas:SetDieTime( math.Rand(0.06, 0.08) )
			Gas:SetStartAlpha( 170 )
			Gas:SetEndAlpha( 0 )
			Gas:SetStartSize( (60 - i*1.6)*self.Scale )
			Gas:SetEndSize( (40 - i*1.5)*self.Scale/3  )
			Gas:SetRoll( math.Rand(0, 360) )
			Gas:SetRollDelta( math.Rand(-50, 50) )			
			Gas:SetAirResistance( 100 ) 			 		
			Gas:SetColor( 250,250,200 )
			end
			
			if self.MuzzleType == 2 then
				local ang = self.DirVec:Angle()
				ang:RotateAroundAxis( self.DirVec:Angle():Forward(), math.random( -15, 15 ) )
				for a=0, 2 do
					ang:RotateAroundAxis( self.DirVec:Angle():Forward(), 120 )
					for i=0,2 do 
						local Flash = self.Emitter:Add("effects/combinemuzzle1", Vector( 0, 0, 0 ) )
						Flash:SetVelocity( ang:Up()*i*100*(self.Scale*3) * (1-f_mult) )
						Flash:SetDieTime( math.Rand(0.06, 0.08) )
						Flash:SetStartAlpha(255)
						Flash:SetEndAlpha(0)
						Flash:SetStartSize(0*self.Scale)
						Flash:SetEndSize(35*self.Scale )
						Flash:SetRoll(math.Rand(180,480))
						Flash:SetRollDelta(math.Rand(-1,1))
						Flash:SetColor(255,255,255)	
					end
				end
				
			end
		
		end
	
 end 
   
function EFFECT:Think( )
end

function EFFECT:Render()
end