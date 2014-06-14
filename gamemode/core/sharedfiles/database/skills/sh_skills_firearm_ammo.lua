

local Skill = {}
Skill.Name = "skill_a_b_ammobelt"
Skill.PrintName = "Special Ammo Belt"
Skill.Icon = "icons/bt/skill_ammobelt"
Skill.Desc = {}
Skill.Desc["story"] = "Equip Special Ammo belt"
Skill.Desc[1] = "Equip Special Ammo belt to use special ammo" .. "\n\nLevel Requirement 1"
Skill.Category = CATEGORY_RANGED_RANGER
Skill.NumName = {}
Skill.NumName[0] = ""
Skill.NumName[1] = "M"
Skill.Active = true
Skill.Levels = 1-- M a b c d e f

function Skill:clEffect( plyPlayer, intSkillLevel )
end
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)

	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
	
end
function Skill:CanUse( plyPlayer )

	plyPlayer.tblSkillCool = plyPlayer.tblSkillCool or {}
	plyPlayer.tblSkillCool[ Skill.Name ] = plyPlayer.tblSkillCool[ Skill.Name ] or CurTime()
	plyPlayer.NextMessage = plyPlayer.NextMessage or CurTime()

	local wep = plyPlayer:GetActiveWeapon()
	if !wep:IsValid() then return end
	if wep.OnSkill then return end
	local wep = plyPlayer:GetActiveWeapon()
	if not wep:IsValid() then return end
	
	if plyPlayer.tblSkillCool[ Skill.Name ] > CurTime() then
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		bliperror( plyPlayer, "You have to wait " .. math.abs( math.floor( CurTime() - plyPlayer.tblSkillCool[ Skill.Name ] ) ) .. " second(s)."  )
		plyPlayer.NextMessage = CurTime() + 0.8
	return end
	
	if plyPlayer.AmmoBelt then
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		bliperror( plyPlayer, "Already worn Special Ammo Belt."  )
		plyPlayer.NextMessage = CurTime() + 0.8
		return 
	end
	
	return true
	
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )

	if not Skill:CanUse( plyPlayer ) then return end
	local wep = plyPlayer:GetActiveWeapon()
	
	wep:SetNextPrimaryFire(CurTime() + 1 )
	
	umsg.Start( "skill_pusheffect" )
		umsg.Entity( plyPlayer )
		umsg.String( Skill.Name )
	umsg.End()
		
	plyPlayer:CreateIndacator( "Equipped_Special_Ammo_Belt!", plyPlayer:GetPos() + Vector( 0, 0, 70 ), "green" , false)
	plyPlayer:EmitSound( "items/ammopickup.wav" )
	
	plyPlayer.AmmoBelt = true
	plyPlayer.tAmmoBelt = CurTime() + 120
	hook.Add( "Think", "AmmoBelt_"..plyPlayer:EntIndex(), function()
		if ( !plyPlayer:IsValid() or !plyPlayer:Alive() or plyPlayer.tAmmoBelt < CurTime() ) then
			if plyPlayer:IsValid() then
				plyPlayer:CreateIndacator( "Special_Ammo_Belt_has_been_worn_off!", plyPlayer:GetPos() + Vector( 0, 0, 70 ), "green" , false)
				plyPlayer.AmmoBelt = false
				plyPlayer:SetNWInt( "sammo", 0 )
			end
			hook.Remove( "Think", "AmmoBelt_"..plyPlayer:EntIndex() )
		end
	end)
	
	plyPlayer.tblSkillCool[ Skill.Name ] = CurTime() + 150
	plyPlayer.NextMessage = CurTime()
	
	return
end
Register.Skill(Skill)

tblAmmoList = {}
tblAmmoList[ 1 ] = 
{
	Name = "Hollow Point",
	Tracer = 1
}
tblAmmoList[ 2 ] = 
{
	Name = "Armour Pierce",
	Tracer = 5
}
tblAmmoList[ 3 ] = 
{
	Name = "High Explosive",
	Tracer = 2
}
tblAmmoList[ 4 ] = 
{
	Name = "Uranium Tip",
	Tracer = 3
}

local Skill = {}
Skill.Name = "skill_a_b_hollowpoint"
Skill.PrintName = "Load Hollow Point"
Skill.Icon = "icons/bt/skill_ammo"
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Level = 3 + i*2
	Skill.Requirements[i].Skills["skill_a_b_ammobelt"] = 1
end

Skill.Desc = {}
Skill.Desc["story"] = "Load Hollow Point Ammo that deals more damage"
for i = 1, 7 do
Skill.Desc[i] = "Load Hollow Point Ammo that deals " .. i*10 .."% of more damage" .. "\n\nLevel Requirement " .. Skill.Requirements[i].Level
end
Skill.Category = CATEGORY_RANGED_RANGER
Skill.Active = true
Skill.SelAmmo = 1
function Skill:clEffect( plyPlayer, intSkillLevel )
end
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)

	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
	
end
function Skill:CanUse( plyPlayer )

	plyPlayer.tblSkillCool = plyPlayer.tblSkillCool or {}
	plyPlayer.NextMessage = plyPlayer.NextMessage or CurTime()
	plyPlayer.tblSkillCool[ "skill_selectammo" ] = plyPlayer.tblSkillCool[ "skill_selectammo" ] or CurTime()
	local wep = plyPlayer:GetActiveWeapon()
	if not wep:IsValid() then return end
	
	if plyPlayer.tblSkillCool[ "skill_selectammo" ] > CurTime() then
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		bliperror( plyPlayer, "You have to wait " .. math.abs( math.floor( CurTime() - plyPlayer.tblSkillCool[ "skill_selectammo" ] ) ) .. " second(s)."  )
		plyPlayer.NextMessage = CurTime() + 0.8
	return end	
	if not plyPlayer.AmmoBelt then
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		bliperror( plyPlayer, "You have to wear Special Ammo Belt to load Special Ammo."  )
		plyPlayer.NextMessage = CurTime() + 0.8
		return 
	end
	if ( plyPlayer:GetNWInt( "sammo" ) == Skill.SelAmmo ) then
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		bliperror( plyPlayer, tblAmmoList[ Skill.SelAmmo ].Name .. " is already loaded to your guns."  )
		plyPlayer.NextMessage = CurTime() + 0.8
		return 
	end
	return true 
	
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )

	if not Skill:CanUse( plyPlayer ) then return end
	local wep = plyPlayer:GetActiveWeapon()
	wep:SetNextPrimaryFire(CurTime() + 1 )
	
	umsg.Start( "skill_pusheffect" )
		umsg.Entity( plyPlayer )
		umsg.String( Skill.Name )
	umsg.End()
	
	local strAmmoName = tblAmmoList[ Skill.SelAmmo ].Name
	strAmmoName = string.Replace( strAmmoName, " ", "_" )
	plyPlayer:CreateIndacator( "Selected_" .. strAmmoName .. "!", plyPlayer:GetPos() + Vector( 0, 0, 70 ), "green" , false)
	plyPlayer:SetNWInt( "sammo", Skill.SelAmmo )
	plyPlayer:EmitSound( "items/itempickup.wav" )
	
	plyPlayer.tblSkillCool[ "skill_selectammo" ] = CurTime() + 1
	plyPlayer.NextMessage = CurTime()
	
	return
end
Register.Skill(Skill)


local Skill = {}
Skill.Name = "skill_a_b_armorpierce"
Skill.PrintName = "Load Armour Pierce"
Skill.Icon = "icons/bt/skill_ammo"
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Level = 4 + i*3
	Skill.Requirements[i].Skills["skill_a_b_ammobelt"] = 1
end
Skill.Desc = {}
Skill.Desc["story"] = "Load Armour Pierce Ammo that deals more damage"
for i = 1, 7 do
Skill.Desc[i] = "Load  Armour Pierce Ammo that deals " .. i*2 .."% of your weapon damage that ignores enemy's armour" .. "\n\nLevel Requirement " .. Skill.Requirements[i].Level
end
Skill.Category = CATEGORY_RANGED_RANGER
Skill.Active = true
Skill.SelAmmo = 2
function Skill:clEffect( plyPlayer, intSkillLevel )
end
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)

	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
	
end
function Skill:CanUse( plyPlayer )

	plyPlayer.tblSkillCool = plyPlayer.tblSkillCool or {}
	plyPlayer.NextMessage = plyPlayer.NextMessage or CurTime()
	plyPlayer.tblSkillCool[ "skill_selectammo" ] = plyPlayer.tblSkillCool[ "skill_selectammo" ] or CurTime()
	local wep = plyPlayer:GetActiveWeapon()
	if not wep:IsValid() then return end
	
	if plyPlayer.tblSkillCool[ "skill_selectammo" ] > CurTime() then
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		bliperror( plyPlayer, "You have to wait " .. math.abs( math.floor( CurTime() - plyPlayer.tblSkillCool[ "skill_selectammo" ] ) ) .. " second(s)."  )
		plyPlayer.NextMessage = CurTime() + 0.8
	return end	
	if not plyPlayer.AmmoBelt then
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		bliperror( plyPlayer, "You have to wear Special Ammo Belt to load Special Ammo."  )
		plyPlayer.NextMessage = CurTime() + 0.8
		return 
	end
	if ( plyPlayer:GetNWInt( "sammo" ) == Skill.SelAmmo ) then
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		bliperror( plyPlayer, tblAmmoList[ Skill.SelAmmo ].Name .. " is already loaded to your guns."  )
		plyPlayer.NextMessage = CurTime() + 0.8
		return 
	end
	return true 
	
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )

	plyPlayer.tblSkillCool = plyPlayer.tblSkillCool or {}
	plyPlayer.NextMessage = plyPlayer.NextMessage or CurTime()
	
	local selammo = 2
	local wep = plyPlayer:GetActiveWeapon()
	if not wep:IsValid() then return end
	
	plyPlayer.tblSkillCool[ "skill_selectammo" ] = plyPlayer.tblSkillCool[ "skill_selectammo" ] or CurTime()
	if plyPlayer.tblSkillCool[ "skill_selectammo" ] > CurTime() then
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		bliperror( plyPlayer, "You have to wait " .. math.abs( math.floor( CurTime() - plyPlayer.tblSkillCool[ "skill_selectammo" ] ) ) .. " second(s)."  )
		plyPlayer.NextMessage = CurTime() + 0.8
	return end	
	if not plyPlayer.AmmoBelt then
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		bliperror( plyPlayer, "You have to wear Special Ammo Belt to load Special Ammo."  )
		plyPlayer.NextMessage = CurTime() + 0.8
		return 
	end
	if ( plyPlayer:GetNWInt( "sammo" ) == selammo ) then
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		bliperror( plyPlayer, tblAmmoList[ selammo ].Name .. " is already loaded to your guns."  )
		plyPlayer.NextMessage = CurTime() + 0.8
		return 
	end
	
	wep:SetNextPrimaryFire(CurTime() + 1 )
	
	umsg.Start( "skill_pusheffect" )
		umsg.Entity( plyPlayer )
		umsg.String( Skill.Name )
	umsg.End()
	
	local strAmmoName = tblAmmoList[ selammo ].Name
	strAmmoName = string.Replace( strAmmoName, " ", "_" )
	plyPlayer:CreateIndacator( "Selected_" .. strAmmoName .. "!", plyPlayer:GetPos() + Vector( 0, 0, 70 ), "green" , false)
	plyPlayer:SetNWInt( "sammo", selammo )
	plyPlayer:EmitSound( "items/itempickup.wav" )
	
	plyPlayer.tblSkillCool[ "skill_selectammo" ] = CurTime() + 1
	plyPlayer.NextMessage = CurTime()
	
	return
end
Register.Skill(Skill)

local Skill = {}
Skill.Name = "skill_a_b_uta"
Skill.PrintName = "Load Uranium Tip Ammo"
Skill.Icon = "icons/bt/skill_ammo"

Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Level = 6 + i*5
	Skill.Requirements[i].Skills["skill_a_b_ammobelt"] = 1
end

Skill.Desc = {}
Skill.Desc["story"] = "Load Uranium Tip Ammo that deals more damage"
for i = 1, 7 do
Skill.Desc[i] = "Load Uranium Tip Ammo that deals " .. i*10 .."% of your weapon damage and " ..  2*i .. " of absolute damage" .. "\n\nLevel Requirement " .. Skill.Requirements[i].Level
end
Skill.Category = CATEGORY_RANGED_RANGER
Skill.Active = true
Skill.SelAmmo = 4
function Skill:clEffect( plyPlayer, intSkillLevel )
end
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)

	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
	
end
function Skill:CanUse( plyPlayer )

	plyPlayer.tblSkillCool = plyPlayer.tblSkillCool or {}
	plyPlayer.NextMessage = plyPlayer.NextMessage or CurTime()
	plyPlayer.tblSkillCool[ "skill_selectammo" ] = plyPlayer.tblSkillCool[ "skill_selectammo" ] or CurTime()
	local wep = plyPlayer:GetActiveWeapon()
	if not wep:IsValid() then return end
	
	if plyPlayer.tblSkillCool[ "skill_selectammo" ] > CurTime() then
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		bliperror( plyPlayer, "You have to wait " .. math.abs( math.floor( CurTime() - plyPlayer.tblSkillCool[ "skill_selectammo" ] ) ) .. " second(s)."  )
		plyPlayer.NextMessage = CurTime() + 0.8
	return end	
	if not plyPlayer.AmmoBelt then
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		bliperror( plyPlayer, "You have to wear Special Ammo Belt to load Special Ammo."  )
		plyPlayer.NextMessage = CurTime() + 0.8
		return 
	end
	if ( plyPlayer:GetNWInt( "sammo" ) == Skill.SelAmmo ) then
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		bliperror( plyPlayer, tblAmmoList[ Skill.SelAmmo ].Name .. " is already loaded to your guns."  )
		plyPlayer.NextMessage = CurTime() + 0.8
		return 
	end
	return true 
	
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )

	plyPlayer.tblSkillCool = plyPlayer.tblSkillCool or {}
	plyPlayer.NextMessage = plyPlayer.NextMessage or CurTime()
	
	local selammo = 4
	local wep = plyPlayer:GetActiveWeapon()
	if not wep:IsValid() then return end
	
	plyPlayer.tblSkillCool[ "skill_selectammo" ] = plyPlayer.tblSkillCool[ "skill_selectammo" ] or CurTime()
	if plyPlayer.tblSkillCool[ "skill_selectammo" ] > CurTime() then
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		bliperror( plyPlayer, "You have to wait " .. math.abs( math.floor( CurTime() - plyPlayer.tblSkillCool[ "skill_selectammo" ] ) ) .. " second(s)."  )
		plyPlayer.NextMessage = CurTime() + 0.8
	return end	
	if not plyPlayer.AmmoBelt then
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		bliperror( plyPlayer, "You have to wear Special Ammo Belt to load Special Ammo."  )
		plyPlayer.NextMessage = CurTime() + 0.8
		return 
	end
	if ( plyPlayer:GetNWInt( "sammo" ) == selammo ) then
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		bliperror( plyPlayer, tblAmmoList[ selammo ].Name .. " is already loaded to your guns."  )
		plyPlayer.NextMessage = CurTime() + 0.8
		return 
	end
	
	wep:SetNextPrimaryFire(CurTime() + 1 )
	
	umsg.Start( "skill_pusheffect" )
		umsg.Entity( plyPlayer )
		umsg.String( Skill.Name )
	umsg.End()
	
	local strAmmoName = tblAmmoList[ selammo ].Name
	strAmmoName = string.Replace( strAmmoName, " ", "_" )
	plyPlayer:CreateIndacator( "Selected_" .. strAmmoName .. "!", plyPlayer:GetPos() + Vector( 0, 0, 70 ), "green" , false)
	plyPlayer:SetNWInt( "sammo", selammo )
	plyPlayer:EmitSound( "items/itempickup.wav" )
	
	plyPlayer.tblSkillCool[ "skill_selectammo" ] = CurTime() + 1
	plyPlayer.NextMessage = CurTime()
	
	return
end
Register.Skill(Skill)