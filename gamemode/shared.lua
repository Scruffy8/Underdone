langopt = {}

include'preinit/1.lua'
include'preinit/2.lua'
include'preinit/3.lua'
include'preinit/4.lua'
include'preinit/5.lua'
include'preinit/npc.lua'
include'preinit/langs/en.lua'
include'preinit/langs/kr.lua'

AddCSLuaFile'preinit/1.lua'
AddCSLuaFile'preinit/2.lua'
AddCSLuaFile'preinit/3.lua'
AddCSLuaFile'preinit/4.lua'
AddCSLuaFile'preinit/5.lua'
AddCSLuaFile'preinit/npc.lua'
AddCSLuaFile'preinit/langs/en.lua'
AddCSLuaFile'preinit/langs/kr.lua'

-------------------------
----------Colors---------

CATEGORY_MELEE_PASSIVE = 1
CATEGORY_MELEE_WARRIOR = 2
CATEGORY_MELEE_WARLOCK = 3
CATEGORY_MELEE_GLADIATOR = 4
CATEGORY_RANGED_PASSIVE = 5
CATEGORY_RANGED_RANGER = 6
CATEGORY_RANGED_COMMANDO = 7
CATEGORY_RANGED_GUNMASTER = 8
CATEGORY_COMMON_PASSIVE = 9
CATEGORY_COMMON_ACTIVE = 10

clrMagic = Color( 0, 128, 255 )
clrRare = Color( 171, 242, 0 )
clrUnique = Color( 255, 100, 255 )
clrEpic = Color( 255, 94, 0 )
clrHero = Color( 255, 187, 0 )

clrGray = Color(97, 95, 90, 255)
clrDrakGray = Color(43, 42, 39, 255)
clrGreen = Color(194, 255, 72, 255)
clrOrange = Color(255, 137, 44, 255)
clrPurple = Color(135, 81, 201, 255)
clrBlue = Color(59, 142, 209, 255)
clrRed = Color(191, 75, 37, 255)
clrTan = Color(178, 161, 126, 255)
clrCream = Color(245, 255, 154, 255)
clrMooca = Color(107, 97, 78, 255)
clrWhite = Color(242, 242, 242, 255)

--To change the MOTD Url go to underdone\gamemode\core\clientfiles\menus\cl_motd.lua Line 67, Feel free to change it, but I'd perfer you dont so you can see important updates.
WelcomeUrl = "http://snsservers.com/wp/"
WelcomeAddChat = function()
	chat.AddText( clrWhite , "Welcome to the ", clrRed, "Underdone Reborn",  clrWhite, ". SNS serves you High Quality Gamemodes.")
end


-----Global Vars---------
GM.MonsterViewDistance = 200
GM.RelationHate = 1
GM.RelationFear = 2
GM.RelationLike = 3
GM.RelationNeutral = 4
GM.AuctionsPerPage = 20
lang_cur = "en"
CreateClientConVar( "ud_pvp", "0", true, true ) -- DO NOT EDIT THIS
--If you edit this client CVAR it'll break the game.
--------------------Do not EDIT anything under this line.------------

---------Generic---------
GM.Name 		= "Underdone: Reborn"
GM.Author 		= "Black Tea"
GM.Email 		= "polkmpolkmpolkm@gmail.com"
GM.Website 		= "http://shellshocked.net46.net/"
GM.MaxSlots		= 50
clrBoarderColor = Color(255, 255, 255, 255) -- do not change this, unless you know what you're doing.   


--DO not edit this, unless you want chaos to be unleashed. 
hook.Add( "PrePACEditorOpen", "RestrictToSuperadmin", function( ply )
    if not ply:IsSuperAdmin( ) then
        return false
    end
end )   
--------DataBase---------
Register = {}
GM.DataBase = {}
GM.DataBase.Items = {}
function Register.Item(tblItem) 
	if !tblItem.Currency then
		tblItem.Currency = "money"
	end
	GM.DataBase.Items[tblItem.Name] = tblItem
end
function ItemTable(strItem) return GAMEMODE.DataBase.Items[strItem] end

GM.DataBase.Slots = {}
function Register.Slot(tblItem) GM.DataBase.Slots[tblItem.Name] = tblItem end
function SlotTable(strSlot) return GAMEMODE.DataBase.Slots[strSlot] end

GM.DataBase.EquipmentSets = {}
function Register.EquipmentSet(tblEquipmentSet) GM.DataBase.EquipmentSets[tblEquipmentSet.Name] = tblEquipmentSet end
function EquipmentSetTable(strEquipmentSet) return GAMEMODE.DataBase.EquipmentSets[strEquipmentSet] end

GM.DataBase.Stats = {}
local intStatIndex = 1
function Register.Stat(tblItem)
	GM.DataBase.Stats[tblItem.Name] = tblItem
	GM.DataBase.Stats[tblItem.Name].Index = intStatIndex
	intStatIndex = intStatIndex + 1
end
function StatTable(strStat) return GAMEMODE.DataBase.Stats[strStat] end

GM.DataBase.NPCs = {}
function Register.NPC(tblItem)
	GM.DataBase.NPCs[tblItem.Name] = tblItem
 end
function NPCTable(strNPC) return GAMEMODE.DataBase.NPCs[strNPC] end

GM.DataBase.Shops = {}
function Register.Shop(tblShop) GM.DataBase.Shops[tblShop.Name] = tblShop end
function ShopTable(strShop) return GAMEMODE.DataBase.Shops[strShop] end

GM.DataBase.Quests = {}
function Register.Quest(tblQuest) GM.DataBase.Quests[tblQuest.Name] = tblQuest end
function QuestTable(strQuest) return GAMEMODE.DataBase.Quests[strQuest] end

GM.DataBase.Skills = {}
function Register.Skill(tblSkill) 
	if !tblSkill.Levels then
		tblSkill.Levels = 7
	end
	if !tblSkill.NumName then
		tblSkill.NumName = {}
		tblSkill.NumName[0] = ""
		tblSkill.NumName[1] = "Lv. 1"
		tblSkill.NumName[2] = "Lv. 2"
		tblSkill.NumName[3] = "Lv. 3"
		tblSkill.NumName[4] = "Lv. 4"
		tblSkill.NumName[5] = "Lv. 5"
		tblSkill.NumName[6] = "Lv. 6"
		tblSkill.NumName[7] = "Lv. 7 "
	end
	GM.DataBase.Skills[tblSkill.Name] = tblSkill 
end
function SkillTable(strSkill) return GAMEMODE.DataBase.Skills[strSkill] end

GM.DataBase.Recipes = {}
function Register.Recipe(tblRecipe) GM.DataBase.Recipes[tblRecipe.Name] = tblRecipe end
function RecipeTable(strRecipe) return GAMEMODE.DataBase.Recipes[strRecipe] end

GM.DataBase.Masters = {}
function Register.Master(tblMaster) GM.DataBase.Masters[tblMaster.Name] = tblMaster end
function MasterTable(strMaster) return GAMEMODE.DataBase.Masters[strMaster] end

GM.DataBase.Events = {}
function Register.Event(tblEvent) GM.DataBase.Events[tblEvent.Name] = tblEvent end
function EventTable(strEvent) return GAMEMODE.DataBase.Events[strEvent] end

function AddPlayerModel(strModel)
	table.insert(GM.PlayerModel, {strModel})
end

function AddQuestObject(PrintName, strModel, Heightoffset)
	table.insert(GM.QuestObject, {PrintName = PrintName, Model = strModel, Height = Heightoffset})
end

function AddLootableObject( strModel, tblLoot, tblOption )
	GM.LootTable[ strModel ] = { Loot = tblLoot, Option = tblOption }
end

function LootTable( strModel )
	return GAMEMODE.LootTable[ strModel ]
end

GM.QuestObject = {}
GM.LootTable = {}

-----Quest Objects-------
AddQuestObject("Case of Beer","models/props/cs_militia/caseofbeer01.mdl", 20)

AddLootableObject( "models/props/cs_militia/caseofbeer01.mdl", { 
	dice = { 1, 1 },
	loot = {
		[ "quest_beer" ] = { chance = {1,1} , amount = {1,1} }
	},
}, {
	 quest = "quest_beer",
	 timetoopen = 2,
 } )
 
AddQuestObject("Oil Drum","models/props_c17/oildrum001.mdl", 60)

AddLootableObject( "models/props_c17/oildrum001.mdl", { 
	dice = { 1, 1 },
	loot = {
		[ "quest_oil" ] = { chance = {1,1} , amount = {1,1} }
	},
}, {
	 quest = "quest_oil",
	 timetoopen = 2,
 } )


AddQuestObject("Cooking Oven","models/props/de_inferno/clayoven.mdl", 60)
AddQuestObject("Craft Table","models/props_junk/garbage_carboard002a.mdl", 10, "Craft Table allows you to craft more things in Q menu.")
AddQuestObject("Wooden Crate", "models/props_junk/wood_crate001a.mdl", 60)
AddQuestObject("Wooden Crate", "models/props_junk/wood_crate002a.mdl", 60)

-- Gathering
AddQuestObject("Resource Distribution Crate", "models/props/cs_militia/footlocker01_closed.mdl", 35, "Can be opened with 'Rust Key'" )
AddQuestObject("Resource Distribution Crate", "models/props/cs_militia/footlocker01_open.mdl", 35, "Can be opened with 'Rust Key'" )	

AddLootableObject( "models/props/cs_militia/footlocker01_closed.mdl", { 
	dice = { 1, 200 },
	loot = {
		[ "wood" ] = { chance = { 1, 100 }, amount = { 5, 150 } },
	},
}, {
	 change = "models/props/cs_militia/footlocker01_open.mdl",
	 key = "key_rust",
	 quest = nil,
	 timetoopen = 2,
 } )


AddQuestObject("Gas Pump", "models/props_wasteland/gaspump001a.mdl", 50 )

AddLootableObject( "models/props_wasteland/gaspump001a.mdl", { 
	dice = { 1, 100 },
	loot = {
		[ "wood" ] = { chance = {1,10} , amount = {1,3} },
		[ "craft_gasoline" ] = { chance = {11,20} , amount = {1,2} },
	},
}, {
	 timetoopen = 10,
 } )

 
-- Mining
AddQuestObject("Ore Vein", "models/props_wasteland/rockcliff_cluster01a.mdl", 40)
AddQuestObject("Ore Vein", "models/props_wasteland/rockcliff_cluster01b.mdl", 40)
AddQuestObject("Ore Vein", "models/props_wasteland/rockcliff_cluster02a.mdl", 40)
AddQuestObject("Ore Vein", "models/props_wasteland/rockcliff_cluster02b.mdl", 40)
AddQuestObject("Ore Vein", "models/props_wasteland/rockcliff_cluster02c.mdl", 40)
AddQuestObject("Ore Vein", "models/props_wasteland/rockcliff_cluster03a.mdl", 40)
AddQuestObject("Ore Vein", "models/props_wasteland/rockcliff_cluster03b.mdl", 40)
AddQuestObject("Ore Vein", "models/props_wasteland/rockcliff_cluster03c.mdl", 40)
AddQuestObject("Flaming Vein", "models/props_wasteland/rockcliff07e.mdl", 40)

GM.PlayerModel = {}
---------Models----------
//Citizen
AddPlayerModel( "models/player/group01/male_01.mdl" )
AddPlayerModel( "models/player/group01/male_02.mdl" )
AddPlayerModel( "models/player/group01/male_03.mdl" )
AddPlayerModel( "models/player/group01/male_04.mdl" )
AddPlayerModel( "models/player/group01/male_05.mdl" )
AddPlayerModel( "models/player/group01/male_06.mdl" )
AddPlayerModel( "models/player/group01/male_07.mdl" )
AddPlayerModel( "models/player/group01/male_08.mdl" )
AddPlayerModel( "models/player/group01/male_09.mdl" )
AddPlayerModel( "models/player/group01/female_01.mdl" )
AddPlayerModel( "models/player/group01/female_02.mdl" )
AddPlayerModel( "models/player/group01/female_03.mdl" )
AddPlayerModel( "models/player/group01/female_04.mdl" )
AddPlayerModel( "models/player/group01/female_06.mdl" )
AddPlayerModel( "models/player/group01/female_07.mdl" )
//Test
AddPlayerModel( "models/player/breen.mdl" )
AddPlayerModel( "models/player/group01/male_07.mdl" )

//Rebel
AddPlayerModel( "models/player/group03/male_01.mdl" )
AddPlayerModel( "models/player/group03/male_02.mdl" )
AddPlayerModel( "models/player/group03/male_03.mdl" )
AddPlayerModel( "models/player/group03/male_04.mdl" )
AddPlayerModel( "models/player/group03/male_05.mdl" )
AddPlayerModel( "models/player/group03/male_06.mdl" )
AddPlayerModel( "models/player/group03/male_07.mdl" )
AddPlayerModel( "models/player/group03/male_08.mdl" )
AddPlayerModel( "models/player/group03/male_09.mdl" )
AddPlayerModel( "models/player/group03/female_01.mdl" )
AddPlayerModel( "models/player/group03/female_02.mdl" )
AddPlayerModel( "models/player/group03/female_03.mdl" )
AddPlayerModel( "models/player/group03/female_04.mdl" )
AddPlayerModel( "models/player/group03/female_06.mdl" )
AddPlayerModel( "models/player/group03/female_07.mdl" )


local Entity = getmetatable( "Entity" )
function Entity:IsNPC()
        local name = self:GetClass()
        
        if ( ( string.lower( string.sub(name, 1, 4) ) == "npc_" ) ) then
            return true
        else
            return false
        end
		
end

