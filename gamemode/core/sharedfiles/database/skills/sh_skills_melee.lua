-- skill
-- passive / active / togga
-- mastery arcane move
-- name

local Skill = {}
Skill.Name = "skill_p_m_melee"
Skill.PrintName = "Melee Mastery"
Skill.Category = CATEGORY_MELEE_PASSIVE
Skill.Icon = "icons/bt/weapon_sword"
Skill.Desc = {}
Skill.Desc["story"] = "Gives you better strength and critical slashes. Can carry more burden."
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Level =  i*4
end
for i=1, 7 do
	Skill.Desc[i] = "Increase Strength by "..i*3 .." and Carry Weight by ".. i*2 .. "\n\nLevel Requirement " .. Skill.Requirements[i].Level - 4
end
Skill.Active = false
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)
	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
	local tblStatTable = {}
	for i=0, 7 do
		tblStatTable[i] = i*3
	end
	plyPlayer:AddStat("stat_strength", tblStatTable[intSkillLevel] - tblStatTable[intOldSkillLevel])
	for i=0, 7 do
		tblStatTable[i] = i*2
	end
	plyPlayer:AddStat("stat_maxweight", tblStatTable[intSkillLevel] - tblStatTable[intOldSkillLevel])
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )
	return
end
Register.Skill(Skill)


local Skill = {}
Skill.Name = "skill_p_m_ironskin"
Skill.PrintName = "Iron Skin"
Skill.Category = CATEGORY_MELEE_PASSIVE
Skill.Icon = "icons/bt/weapon_sword"
Skill.Desc = {}
Skill.Desc["story"] = "Maks your armor and skin harder and durable."
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Skills[ "skill_p_m_melee" ] = i
end
for i=1, 7 do
	Skill.Desc[i] = "Makes your Armor "..i*3 .. " more efficient. (yet)" .. "\n\nLevel Requirement 1" 
end
Skill.Active = false
function melee_ironskin( plyPlayer, dam )
	--print( dam )
	--print( ( dam ) * ( 1 - .02 * plyPlayer:GetSkill( "skill_p_m_ironskin" ) ) )
	return ( dam ) * ( 1 - .02 * plyPlayer:GetSkill( "skill_p_m_ironskin" ) ) -- 1% per level
end
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)
	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )
	return
end
Register.Skill(Skill)


local Skill = {}
Skill.Name = "skill_p_m_yinyan"
Skill.PrintName = "Yin-Yan Training"
Skill.Category = CATEGORY_MELEE_PASSIVE
Skill.Icon = "icons/bt/weapon_sword"
Skill.Desc = {}
Skill.Desc["story"] = "By knowing yin-yan's real mean, You finally understood how to control the energy efficiently."
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Skills[ "skill_p_m_melee" ] = i
end
for i=1, 7 do
	Skill.Desc[i] = "Decreases Active Skill Cooldown by "..i*5 .."%." .. "\n\nLevel Requirement 1"
end
Skill.Active = false
function melee_adjcool( plyPlayer, cool )
	return ( cool ) * ( 1 - .05 * plyPlayer:GetSkill( "skill_p_m_yinyan" ) )
end
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)
	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )
	return
end
Register.Skill(Skill)


local Skill = {}
Skill.Name = "skill_p_m_qui"
Skill.PrintName = "Qui Training"
Skill.Category = CATEGORY_MELEE_PASSIVE
Skill.Icon = "icons/bt/weapon_sword"
Skill.Desc = {}
Skill.Desc["story"] = "You can make your skills better with training your Qui. ( WARRIOR ONLY )"
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Skills[ "skill_p_m_melee" ] = i
end
for i=1, 7 do
	Skill.Desc[i] = "Increases Active Skill Damage by "..i*5 .."%." .. "\n\nLevel Requirement 1"
end
Skill.Active = false
function melee_wardam( plyPlayer, dam )
	return ( dam ) * ( 1 + .1 * plyPlayer:GetSkill( "skill_p_m_qui" ) )
end
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)
	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )
	return
end
Register.Skill(Skill)


local Skill = {}
Skill.Name = "skill_p_m_st"
Skill.PrintName = "Sword Skill Training"
Skill.Category = CATEGORY_MELEE_PASSIVE
Skill.Icon = "icons/bt/weapon_sword"
Skill.Desc = {}
Skill.Desc["story"] = "You can make your skills better with training your Sword Skill ( GLADIATOR ONLY )."
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Skills[ "skill_p_m_melee" ] = i
end
for i=1, 7 do
	Skill.Desc[i] = "Increases Active Skill Damage by "..i*5 .."%."  .. "\n\nLevel Requirement 1"
end
Skill.Active = false
function melee_gladam( plyPlayer, dam )
	return ( dam ) * ( 1 + .05 * plyPlayer:GetSkill( "skill_p_m_st" ) )
end
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)
	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )
	return
end
Register.Skill(Skill)
