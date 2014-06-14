-- skill
-- passive / active / togga
-- mastery arcane move
-- name

function lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
	
	if ( !load ) then
		plyPlayer:CreateIndacator( "Skill_Level_Up!", plyPlayer:GetPos() + Vector( 0, 0, 70 ), "blue" , true)
		local effectdata2 = EffectData()
		effectdata2:SetStart( plyPlayer :GetPos())
		effectdata2:SetOrigin( plyPlayer:GetPos())
		effectdata2:SetNormal( Vector( 0, 0, 150 ) )
		effectdata2:SetEntity( plyPlayer )
		effectdata2:SetScale( 2 )
		util.Effect("levelup", effectdata2)
		plyPlayer:EmitSound( "blacktea/skillup.wav" )
	end
	
end
function cl_pusheffect( um )

	local p = um:ReadEntity()
	local name = um:ReadString()
	local level = um:ReadFloat()
	
	if ( p:IsValid() && name ) then
		local tblSkillTable = SkillTable( name )
		
		if tblSkillTable.clEffect then
			tblSkillTable:clEffect( p, level ) 
		end
	end
	
end
usermessage.Hook( "skill_pusheffect", cl_pusheffect )
function notengcool( um )

	surface.PlaySound( "Friends/friend_join.wav" )
	
end
usermessage.Hook( "notengcool", notengcool )
function bliperror( plyPlayer, strMessage )

		umsg.Start( "notengcool", plyPlayer )
		umsg.End()
		plyPlayer:CreateNotification( strMessage )
		
end


local Skill = {}
Skill.Name = "skill_p_m_firearm"
Skill.PrintName = "Firearm Mastery"
Skill.Icon = "icons/weapon_pistol"
Skill.Desc = {}
Skill.Desc["story"] = "Gives you better aim and critical bullets"

Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Level =  i*4
end

for i = 1, 7 do
Skill.Desc[i] = "Increase Dexterity by ".. i*3 .. "\n\nLevel Requirement " .. Skill.Requirements[i].Level - 4
end
Skill.Category = CATEGORY_RANGED_PASSIVE
Skill.Active = false
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)

	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
	local tblStatTable = {}
	for i = 0, 7 do
		tblStatTable[i] = i*3
	end
	plyPlayer:AddStat("stat_dexterity", tblStatTable[intSkillLevel] - tblStatTable[intOldSkillLevel])
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )
	return
end
Register.Skill(Skill)


local Skill = {}
Skill.Name = "skill_p_m_fastrecharge"
Skill.PrintName = "Fast Recharge"
Skill.Icon = "icons/bt/item_module"
Skill.Desc = {}
Skill.Desc["story"] = "Gives you faster aim and faster reloads"
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Level = i*2
end
for i = 1, 7 do
Skill.Desc[i] = "Increases Aim and Slightly decreases cooltime." .. "\n\nLevel Requirement " .. Skill.Requirements[i].Level - 2
end
Skill.Category = CATEGORY_RANGED_PASSIVE
Skill.Active = false
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)
	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )
	return
end
Register.Skill(Skill)


local Skill = {}
Skill.Name = "skill_p_m_hq"
Skill.PrintName = "H.Q Licence Upgrade"
Skill.Icon = "icons/bt/item_module"
Skill.Desc = {}
Skill.Desc["story"] = "Gives you more previlege"
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Level = i*4
end
for i = 1, 7 do
Skill.Desc[i] = "Allows you to use more Commando Skills."  .. "\n\nLevel Requirement " .. Skill.Requirements[i].Level - 4
end
Skill.Category = CATEGORY_RANGED_PASSIVE
Skill.Active = false
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)
	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )
	return
end
Register.Skill(Skill)


local Skill = {}
Skill.Name = "skill_p_m_circle"
Skill.PrintName = "Inner Circle"
Skill.Icon = "icons/bt/skill_inner"
Skill.Desc = {}
Skill.Desc["story"] = "Gives you more gunmaster skill damage"
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Level = i*3
end
for i = 1, 7 do
Skill.Desc[i] = "Gives gunmaster skills more damage." .. "\n\nLevel Requirement " .. Skill.Requirements[i].Level - 3
end
Skill.Category = CATEGORY_RANGED_PASSIVE
Skill.Active = false
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)
	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )
	return
end
Register.Skill(Skill)


local Skill = {}
Skill.Name = "skill_p_m_hqbullets"
Skill.PrintName = "High Quality Bullets"
Skill.Icon = "icons/bt/skill_advammo"
Skill.Desc = {}
Skill.Desc["story"] = "Gives you more ammo skill damage"
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Level = i*3
end
for i = 1, 7 do
Skill.Desc[i] = "Higher damage in bullets." .. "\n\nLevel Requirement " .. Skill.Requirements[i].Level - 3
end
Skill.Category = CATEGORY_RANGED_PASSIVE
Skill.Active = false
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)
	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )
	return
end
Register.Skill(Skill)


local Skill = {}
Skill.Name = "skill_p_m_ecogunner"
Skill.PrintName = "Eco Gunner"
Skill.Icon = "icons/bt/skill_eco"
Skill.Desc = {}
Skill.Desc["story"] = "Gives you chance to not spend a bullet when shoot"
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Level = i*4
end
for i = 1, 7 do
Skill.Desc[i] = "Small chance of not using ammo when firing a gun" .. "\n\nLevel Requirement " .. Skill.Requirements[i].Level - 4
end
Skill.Category = CATEGORY_RANGED_PASSIVE
Skill.Active = false
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)
	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )
	return
end
Register.Skill(Skill)

local Skill = {}
Skill.Name = "skill_p_m_commando"
Skill.PrintName = "Commando"
Skill.Icon = "icons/bt/item_module"
Skill.Desc = {}
Skill.Desc["story"] = "Gives you chance to not spend a bullet when shoot"
Skill.Requirements = {}
Skill.Requirements[1] = {}
Skill.Requirements[1].Skills = {}
Skill.Requirements[1].Skills["skill_p_m_hq"] = 7
Skill.Requirements[1].Skills["skill_p_m_firearm"] = 7
Skill.Requirements[1].Level = 40
Skill.Desc[1] = "Higher chance of not using ammo when you shoot." .. "\n\nLevel Requirement " .. Skill.Requirements[1].Level
Skill.Category = CATEGORY_RANGED_PASSIVE
Skill.NumName = {}
Skill.NumName[0] = ""
Skill.NumName[1] = "M"
Skill.Active = false
Skill.Levels = 1 -- M a b c d e f
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)
	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )
	return
end
Register.Skill(Skill)

local Skill = {}
Skill.Name = "skill_p_m_proranger"
Skill.PrintName = "Pro Ranger"
Skill.Icon = "icons/bt/item_module"
Skill.Desc = {}
Skill.Desc["story"] = "Gives you chance to not spend a bullet when shoot"
Skill.Requirements = {}
Skill.Requirements[1] = {}
Skill.Requirements[1].Skills = {}
Skill.Requirements[1].Skills["skill_p_m_hqbullets"] = 7
Skill.Requirements[1].Skills["skill_p_m_firearm"] = 7
Skill.Requirements[1].Level = 40
Skill.Desc[1] = "Farther increases the chance of not using ammo when shooting." .. "\n\nLevel Requirement " .. Skill.Requirements[1].Level
Skill.Category = CATEGORY_RANGED_PASSIVE
Skill.NumName = {}
Skill.NumName[0] = ""
Skill.NumName[1] = "M"
Skill.Active = false
Skill.Levels = 1 -- M a b c d e f
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)
	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )
	return
end
Register.Skill(Skill)