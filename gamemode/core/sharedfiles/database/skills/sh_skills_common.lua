-- skill
-- passive / active / togga
-- mastery arcane move
-- name

local Skill = {}
Skill.Name = "skill_p_m_endurance"
Skill.PrintName = "Endurance"
Skill.Icon = "icons/bt/item_elite"
Skill.Desc = {}
Skill.Desc["story"] = "You can take more damage and stresses from the outside."
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Level =  i*4
end
for i = 1, 7 do
Skill.Desc[i] = "Increase Max Health by ".. i*10 .. "\n\nLevel Requirement " .. Skill.Requirements[i].Level - 4
end
Skill.Category = CATEGORY_COMMON_PASSIVE
Skill.Active = false
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)

	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
	local tblStatTable = {}
	tblStatTable[0] = 10
	tblStatTable[1] = 20
	tblStatTable[2] = 30
	tblStatTable[3] = 50
	tblStatTable[4] = 70
	tblStatTable[5] = 90
	tblStatTable[6] = 120
	tblStatTable[7] = 150
	plyPlayer:AddStat("stat_maxhealth", tblStatTable[intSkillLevel] - tblStatTable[intOldSkillLevel])
	plyPlayer:SetHealth( plyPlayer:GetMaxHealth() )
	
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )
	return
end
Register.Skill(Skill)


local Skill = {}
Skill.Name = "skill_p_m_agility"
Skill.PrintName = "Agility Training"
Skill.Icon = "icons/bt/skill_agility"
Skill.Desc = {}
Skill.Desc["story"] = "Gives you faster aim and faster reloads"
Skill.Requirements = {}
for i = 0, 7 do
	Skill.Requirements[i] = {}
	Skill.Requirements[i].Skills = {}
	Skill.Requirements[i].Level = i*6
end
for i = 1, 7 do
Skill.Desc[i] = "Increase Agility by ".. i*1 .. "\n\nLevel Requirement " .. Skill.Requirements[i].Level - 6
end
Skill.Category = CATEGORY_COMMON_PASSIVE
Skill.Active = false

function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel, load)
	lvl_effect( plyPlayer, intSkillLevel, intOldSkillLevel, load )
	local tblStatTable = {}
	for i = 0, 7 do
		tblStatTable[i] = i
	end
	plyPlayer:AddStat("stat_agility", tblStatTable[intSkillLevel] - tblStatTable[intOldSkillLevel])
end
function Skill:OnUse( plyPlayer, intSkillLevel, boolSwitch )
	return
end
Register.Skill(Skill)
