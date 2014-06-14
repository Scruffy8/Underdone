do -- meta
	if SERVER then
		util.AddNetworkString( "s2c_Slow" )
		util.AddNetworkString( "s2c_AbsSlow" )
	else
		net.Receive( "s2c_Slow", function( len )
			local pl = net.ReadEntity()
			pl.SlowTime = CurTime() + net.ReadFloat()
		end)
		net.Receive( "s2c_AbsSlow", function( len )
			local pl = net.ReadEntity()
			pl.AbsSlowTime = CurTime() + net.ReadFloat()
		end)
	end

	local Player = FindMetaTable("Player")

	intDefaultPlayerSpeed = 210
	intDefaultSlowSpeed = 30

	function Player:SlowDown(intTime, scl)
		self.SlowTime = CurTime() + intTime
		if SERVER then
			if scl then
				net.Start( "s2c_Slow" )
					net.WriteEntity( self )
					net.WriteFloat( intTime )
				net.Send( self )
			end
		end
	end
	
	function Player:AbsSlowDown(intTime, scl)
		self.AbsSlowTime = CurTime() + intTime
		if SERVER then
			if scl then
				net.Start( "s2c_AbsSlow" )
					net.WriteEntity( self )
					net.WriteFloat( intTime )
				net.Send( self )
			end
		end
	end
	
	function Player:SetMoveSpeed(intAmount)
		self.MoveSpeed = intDefaultPlayerSpeed
		self.MoveSpeed = math.Clamp(intAmount or self.MoveSpeed, 0, 1000)
		self:SetWalkSpeed(math.Clamp(self.MoveSpeed, 0, 1000))
		self:SetRunSpeed(math.Clamp(self.MoveSpeed, 0, 1000))
	end
	
	hook.Add("PlayerSpawn", "PlayerSpawn_Movement", function(ply)
		ply:SetMoveSpeed()
	end)
	
end

-- animation
do 
	hook.Add("KeyPress", "walk", function(ply, key)
		if key == IN_WALK and ply:GetSlot( "slot_offhand" ) and ply:GetSlot( "slot_primaryweapon" ) and ply:GetActiveWeapon().WeaponTable.HoldType == "pistol" then
			ply:SetLuaAnimation( "shield_idle" )
		end
	end)

	hook.Add("KeyRelease", "walk", function(ply, key)
		if key == IN_WALK and ply:GetSlot( "slot_offhand" ) and ply:GetSlot( "slot_primaryweapon" ) then
		
			ply:ResetLuaAnimation( "shield_idle", .1 )
			ply:SetLuaAnimation( "shield_lower" )
		--	SuppressHostEvents(ply)
		--	SuppressHostEvents(NULL)

		end	
	end) 
end

do -- move hook
	local mult = 0.1	
	local function isWalk( ply )
		if  ( ply:KeyDown(IN_ATTACK) and ply:GetActiveWeapon() )  || ply:KeyDown(IN_WALK) || ( ply.SlowTime && ply.SlowTime > CurTime()) || ( ply.AbsSlowTime && ply.AbsSlowTime > CurTime())  || ( ply:GetActiveWeapon()  && ply:GetActiveWeapon().Aiming ) then --or ( ply.SlowTime and ply.SlowTime > CurTime() ) then
			return true
		else
			return false
		end
	end

	hook.Add("Move", "PlayerSlowdown", function(ply, move)

		local fwd = move:GetForwardSpeed()
		local sid = move:GetSideSpeed()

		if isWalk( ply ) then
		
			if fwd>0 then
				local szx = -ply:GetMaxSpeed() * -mult

				if fwd>szx then
					move:SetForwardSpeed(szx)
				end		
			end
			
			if fwd<0 then			
				local szg = -ply:GetMaxSpeed() * mult
				
				if fwd<szg then
					move:SetForwardSpeed(szg)
				end
				
			end
			
			if sid>0 then		
				local sidszg = -ply:GetMaxSpeed() * -mult
				
				if sid>sidszg then
					move:SetSideSpeed(sidszg)
				end			
			end
			
			if sid<0 then
				local sidszgh = -ply:GetMaxSpeed() * mult
				
				if sid<sidszgh then
					move:SetSideSpeed(sidszgh)
				end
			end
		end
		
	end)
end