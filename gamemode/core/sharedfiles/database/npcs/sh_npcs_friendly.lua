local function QuickNPC(strName, strPrintName, strSpawnName, strRace, intDistance, strModel)
	local NPC = {}
	NPC.Name = strName
	NPC.PrintName = strPrintName
	NPC.SpawnName = strSpawnName
	NPC.Race = strRace
	NPC.DistanceRetreat = intDistance
	NPC.Model = strModel
	return NPC
end
local function AddBool(Table, strFrozen, strInvincible, strIdle)
		Table.Frozen = strFrozen
		Table.Invincible = strInvincible
		Table.Idle = strIdle
	return Table
end
local function AddMultiplier(Table, strHealth, strDamage)
	Table.HealthPerLevel = strHealth
	Table.DamagePerLevel = strDamage
	return Table
end
local function AddDrop(Table, strName, strChance, strMin, strMax,strDefaultChance)
	Table.Drops = Table.Drops or {}
	Table.Drops[strName] = {Chance = strChance, Min = strMin, Max = strMax}
	return Table
end

local NPC = QuickNPC("rebel_smg", "Rebel Guard", "npc_combine_s", "human", 30, "models/Humans/Group03/Male_02.mdl")
NPC = AddBool(NPC, false, true, false)
NPC = AddMultiplier(NPC, 100, 7)
NPC.DeathDistance = 140
NPC.Race = "human"
NPC.Weapon = "ai_weapon_smg1"
Register.NPC(NPC)

local NPC = QuickNPC("medic", "Medic", "npc_breen", "human", 30, "models/Humans/Group03/Male_02.mdl")
NPC.Title = "Professional Doctor"
NPC = AddBool(NPC, false, true, false)
NPC = AddMultiplier(NPC, 100, 7)
NPC.DeathDistance = 14
NPC.SpecialMove = true
NPC.SetupMoveTable = function( npc )
	npc.nextHeal = CurTime()
	npc.HealCool = 1
end
NPC.SpecialMoveData = function( npc )
	for k, v in pairs( player.GetAll() ) do
		local dist = v:GetPos():Distance( npc:GetPos() )
		if npc.nextHeal < CurTime() then
			if dist < 200 then
				v:SetHealth( math.Clamp( v:Health() + v:GetMaxHealth() / 10, 0, v:GetMaxHealth() ) )
			end
			npc.nextHeal = CurTime() + 1
		end
	end
end
Register.NPC(NPC)

local NPC = QuickNPC("human_turret(f)", "Human Turret(Floor)", "npc_turret_floor", "human")
NPC = AddMultiplier(NPC, 20, 3)
NPC = AddBool(NPC, true, false, false)
NPC.Accuracy = WEAPON_PROFICIENCY_POOR
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("shop_general", "Jay", "npc_eli", "human")
NPC = AddBool(NPC, false, true, true)
NPC.Shop = "shop_general"
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("shop_weapons", "Claire", "npc_breen", "human", nil, "models/Humans/Group03/Female_06.mdl")
NPC = AddBool(NPC, false, true, true)
NPC.Shop = "shop_weapons"
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("shop_weapons2", "Samantha", "npc_breen", "human", nil, "models/Humans/Group03/Female_06.mdl")
NPC = AddBool(NPC, false, true, true)
NPC.Shop = "shop_weapons2"
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("shop_weapons3", "Emmy", "npc_breen", "human", nil, "models/Humans/Group03/Female_06.mdl")
NPC = AddBool(NPC, false, true, true)
NPC.Shop = "shop_weapons3"
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("shop_developer", "DEV SHOP", "npc_breen", "human", nil, "models/breen.mdl" )
NPC = AddBool(NPC, false, true, true)
--NPC.RealModel = "models/r_eng_mxss1/r_eng_mxss1.mdl"
NPC.Shop = "shop_developer"
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("shop_recipe", "Jackson", "npc_breen", "human", nil, "models/breen.mdl" )
NPC = AddBool(NPC, false, true, true)
--NPC.RealModel = "models/r_eng_mxss1/r_eng_mxss1.mdl"
NPC.Shop = "shop_recipe"
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("shop_koxica", "Koxica", "npc_breen", "human", nil, "models/Humans/Group03/Male_07.mdl")
NPC = AddBool(NPC, false, true, true)
--NPC.RealModel = "models/r_eng_mxss1/r_eng_mxss1.mdl"
NPC.Shop = "shop_sptoken"
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("shop_blacktea", "Black Tea", "npc_breen", "human", nil, "models/breen.mdl" )
NPC = AddBool(NPC, false, true, true)
--NPC.RealModel = "models/r_eng_mxss1/r_eng_mxss1.mdl"
NPC.Shop = "shop_token1"
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("shop_armor", "Crystal", "npc_breen", "human", nil, "models/Humans/Group03/Female_04.mdl")
NPC = AddBool(NPC, false, true, true)
NPC.Shop = "shop_armor"
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("shop_armor2", "Emerald", "npc_breen", "human", nil, "models/Humans/Group03/Female_04.mdl")
NPC = AddBool(NPC, false, true, true)
NPC.Shop = "shop_armor2"
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("shop_armor3", "Sapphire", "npc_breen", "human", nil, "models/Humans/Group03/Female_04.mdl")
NPC = AddBool(NPC, false, true, true)
NPC.Shop = "shop_armor3"
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("bank_npc", "Egmont", "npc_citizen", "human", nil, "models/Humans/Group03/Male_01.mdl")
NPC = AddBool(NPC, false, true, true)
NPC.Bank = true
NPC.Title = "Bank Manager"
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("appearance_npc", "Faith", "npc_breen", "human", nil, "models/alyx.mdl")
NPC = AddBool(NPC, false, true, true)
NPC.Appearance = true
NPC.DeathDistance = 14
NPC.Title = "Daugther of Whiteforest"
Register.NPC(NPC)

local NPC = QuickNPC("npc_auctionhouse", "Camron", "npc_citizen", "human", nil, "models/Humans/Group03/Male_05.mdl")
NPC = AddBool(NPC, false, true, true)
NPC.Auction = true
NPC.Title = "Auction House"
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("quest_jose", "Josephina", "npc_breen", "human", nil, "models/alyx.mdl")
NPC = AddBool(NPC, false, true, true)
NPC.Title = "Collector"
--NPC.RealModel = "models/r_med_fxss2/r_med_fxss2.mdl"
NPC.Quest = {"quest_miner"}
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("quest_rd", "SeePower", "npc_breen", "human", nil, "models/Humans/Group03/Male_02.mdl")
NPC = AddBool(NPC, false, true, true)
NPC.Title = "Resource Distributor"
NPC.Quest = { "quest_r_wood", "quest_r_junk", "quest_r_urgent"  }
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("quest_magi", "Jello Fish", "npc_breen", "human", nil, "models/Humans/Group03/Male_02.mdl")
NPC = AddBool(NPC, false, true, true)
NPC.Title = "Great Magi"
NPC.Quest = { "quest_j_zom" }
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("quest_miner", "Jack Stoner", "npc_breen", "human", nil, "models/Humans/Group03/Male_02.mdl")
NPC = AddBool(NPC, false, true, true)
NPC.Title = "Adequate Miner"
NPC.Quest = {"quest_miner"}
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("quest_Odessa", "Kriss", "npc_breen", "human", nil, "models/breen.mdl" )
NPC = AddBool(NPC, false, true, true)
NPC.Title = "Alien Researcher"
--NPC.RealModel = "models/r_sol_mxss1/r_sol_mxss1.mdl"
NPC.Quest = {"quest_killvorts", "quest_killvorts2", "quest_killvorts3", "quest_killantlion", "quest_killantlion2", "quest_killantlion3", "quest_killantworker", "quest_killantworker2", "quest_killantworker3", "quest_killantlionboss"}
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("quest_Adam", "Adam", "npc_breen", "human", nil, "models/breen.mdl" )
NPC = AddBool(NPC, false, true, true)
NPC.Quest = {"quest_killzombies", "quest_killzombies2", "quest_killzombies3", "quest_killfirezombies", "quest_killfirezombies2", "quest_killfirezombies3", "quest_killicezombies", "quest_killicezombies2", "quest_killicezombies3", "quest_killfastzombies", "quest_killfastzombies2", "quest_killfastzombies3", "quest_zombieblood", "quest_killzombine"}
NPC.DeathDistance = 14
--NPC.RealModel = "models/r_nor_m/resis_normal_male.mdl"
NPC.Title = "The Zombie Hunter"
Register.NPC(NPC)

local NPC = QuickNPC("quest_kleiner", "Dr. Kleiner", "npc_kleiner", "human")
NPC = AddBool(NPC, false, true, true)
NPC.Quest = {"quest_toolwrench", "quest_revolver", "quest_armorupgrade", "quest_missionthors", "quest_fortification", "quest_oil", "quest_crafting", "quest_arsenalupgrade", "quest_monkeybusiness", "quest_cooking", "quest_beer"}
NPC.DeathDistance = 14
NPC.Title = "Exiled Doctor"
Register.NPC(NPC)

local NPC = QuickNPC("quest_eli", "Brian", "npc_breen", "human", nil, "models/breen.mdl" )
--NPC.RealModel = "models/r_sni_mxss2/r_sni_mxss2.mdl"
NPC = AddBool(NPC, false, true, true)
NPC.Quest = {"quest_killcombinethumper", "quest_killcombine", "quest_killcombine2", "quest_killcombine3", "quest_killmanhack", "quest_killmanhack2", "quest_killmanhack3", "quest_killelite", "quest_killelite2", "quest_killelite3", "quest_killbreen"}
NPC.Title = "Anti-Combine Rebel"
NPC.DeathDistance = 14
Register.NPC(NPC)