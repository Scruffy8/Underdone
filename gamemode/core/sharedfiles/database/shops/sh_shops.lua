local Shop = {}
Shop.Name = "shop_recipe"
Shop.PrintName = "Crafting Goods"
Shop.Inventory = {}
Shop.Inventory["book_fuse"] = {}
Shop.Inventory["book_grenade_tier1"] = {}
Shop.Inventory["book_coppercircuit"] = {}
Shop.Inventory["book_coppercog"] = {}
Shop.Inventory["book_r_wood"] = {}
Shop.Inventory["book_r_dbarrel"] = {}
Shop.Inventory["book_r_qbarrel"] = {}
Shop.Inventory["book_ironcog"] = {}
Shop.Inventory["book_silvercog"] = {}
Shop.Inventory["book_goldcog"] = {}
Shop.Inventory["book_m_cleaver"] = {}
Shop.Inventory["book_m_leadpipe"] = {}
Shop.Inventory["mat_mp_basic"] = {}
Shop.Inventory["book_r_iron"] = {}
Shop.Inventory["book_b_barrel"] = {}
Shop.Inventory["book_r_drummer"] = {}
Shop.Inventory["book_turret_tier1"] = {}
Shop.Inventory["book_b_iron"] = {}
Shop.Inventory["book_btt_tier1"] = {}
Shop.Inventory["book_a_helmet_cardboard"] = {}
Shop.Inventory["book_a_belt_cardboard"] = {}
Shop.Inventory["book_a_chest_cardboard"] = {}
Register.Shop(Shop)

local Shop = {}
Shop.Name = "shop_general"
Shop.PrintName = "Shop General"
Shop.Inventory = {}
Shop.Inventory["item_smallammo_small"] = {}
Shop.Inventory["item_sniperammo_small"] = {}
Shop.Inventory["item_rifleammo_small"] = {}
Shop.Inventory["item_portal_otcnl_1"] = {}
Shop.Inventory["item_portal_otcnl_2"] = {}
Shop.Inventory["item_portal_otcnl_3"] = {}
Shop.Inventory["item_buckshotammo_small"] = {}
Shop.Inventory["item_smallammo_big"] = {}
Shop.Inventory["item_sniperammo_big"] = {}
Shop.Inventory["item_rifleammo_big"] = {}
Shop.Inventory["item_buckshotammo_big"] = {}
Shop.Inventory["item_launcher_nade_big"] = {}
Shop.Inventory["item_launcher_nade"] = {}
Shop.Inventory["item_healthkit"] = {}
Shop.Inventory["item_antivirus"] = {}
Shop.Inventory["book_wooddistilation"] = {}
Shop.Inventory["item_firestarting_kit"] = {}
Shop.Inventory["item_grenade2"] = {}
Register.Shop(Shop)

local Shop = {}
Shop.Name = "shop_armor"
Shop.PrintName = "Armor Shop"
Shop.Inventory = {}
Shop.Inventory["armor_chest_junkarmor"] = {}
Shop.Inventory["armor_chest_cplate"] = {}
Shop.Inventory["armor_helm_fancyhat"] = {}
Shop.Inventory["armor_belt_howtofight"] = {}
Shop.Inventory["armor_chest_solidmetal"] = {}
Shop.Inventory["armor_helm_cwatcher"] = {}
Shop.Inventory["armor_helm_kocixa1"] = {}
Shop.Inventory["armor_helm_musicgear"] = {}
Shop.Inventory["armor_belt_autoloader"] = {}
Shop.Inventory["armor_lite_plat"] = {}
Shop.Inventory["armor_belt_strength"] = {}
Shop.Inventory["armor_shield_wood"] = {}
Shop.Inventory["armor_shield_plastic"] = {}
Shop.Inventory["armor_ring_carvedwood"] = {}
Register.Shop(Shop)

local Shop = {}
Shop.Name = "shop_armor2"
Shop.PrintName = "Advanced Armor Shop"
Shop.Inventory = {}
Shop.Inventory["armor_shield_metal"] = {}
Shop.Inventory["armor_shield_doublemetal"] = {}
Shop.Inventory["armor_belt_alakajam"] = {}
Shop.Inventory["armor_shoulder_alakajam"] = {}
Shop.Inventory["armor_chest_alakajam"] = {}
Shop.Inventory["armor_helm_alakajam"] = {}
Register.Shop(Shop)

local Shop = {}
Shop.Name = "shop_armor3"
Shop.PrintName = "Master Armor Shop"
Shop.Inventory = {}
Shop.Inventory["armor_helm_brithat"] = {}
Shop.Inventory["armor_shield_refractor"] = {}
Shop.Inventory["armor_shield_rotator"] = {}
Register.Shop(Shop)

local Shop = {}
Shop.Name = "shop_token1"
Shop.PrintName = "Boss Token Exchanger"
Shop.Inventory = {}
Shop.Inventory["armor_belt_skull"] = { Price = 75 }
Shop.Inventory["armor_chest_skull"] = { Price = 200 }
Shop.Inventory["armor_helm_skull"] = { Price = 75 }
Shop.Inventory["armor_shoulder_skull"] = { Price = 50 }
Shop.Inventory["weapon_melee_sawblade"] = { Price = 50 }
Shop.Inventory["weapon_melee_deadblade"] = { Price = 250 }
Shop.Inventory["weapon_ranged_mp40"] = { Price = 50 }
Shop.Inventory["weapon_ranged_fomos"] = { Price = 250 }
Register.Shop(Shop)

local Shop = {}
Shop.Name = "shop_token2"
Shop.PrintName = "Space Token Exchanger"
Shop.Inventory = {}
Shop.Inventory["armor_belt_skull"] = { Price = 50 }
Register.Shop(Shop)

local Shop = {}
Shop.Name = "shop_sptoken"
Shop.PrintName = "Space Token Exchanger"
Shop.Inventory = {}
Shop.Inventory["weapon_ranged_eagle"] = { Price = 50 }
Register.Shop(Shop)

-------------------------------------

local Shop = {}
Shop.Name = "shop_weapons"
Shop.PrintName = "Arms Dealer"
Shop.Inventory = {}
Shop.Inventory["weapon_ranged_junkpistol"] = { Price = 20 }
Shop.Inventory["weapon_ranged_hloader"] = {}
Shop.Inventory["weapon_ranged_prohandle"] = {}
Shop.Inventory["weapon_ranged_thethree"] = {}
Shop.Inventory["weapon_ranged_autocannon"] = {}
Shop.Inventory["weapon_ranged_rustysmg"] = {}
Shop.Inventory["weapon_ranged_rhynosmg"] = {}
Shop.Inventory["weapon_ranged_bughunter"] = {}
Shop.Inventory["weapon_ranged_hrifle"] = {}
Shop.Inventory["weapon_ranged_choitok"] = {}
Shop.Inventory["weapon_ranged_scarface"] = {}
Shop.Inventory["weapon_ranged_tbusiness"] = {}
Shop.Inventory["weapon_melee_ladel"] = {}
Shop.Inventory["weapon_melee_axe"] = {}
Shop.Inventory["weapon_melee_metalmace"] = {}
Shop.Inventory["weapon_melee_meathook"] = {}
Shop.Inventory["craft_btt_1"] = {}
Register.Shop(Shop)

local Shop = {}
Shop.Name = "shop_weapons2"
Shop.PrintName = "Advanced Arms Dealer"
Shop.Inventory = {}
Shop.Inventory["weapon_ranged_hwarang"] = {}
Shop.Inventory["weapon_ranged_sr25"] = {}
Shop.Inventory["weapon_ranged_raider"] = {}
Shop.Inventory["weapon_ranged_tbusiness_gl"] = {}
Shop.Inventory["weapon_ranged_farseer"] = {}
Shop.Inventory["weapon_ranged_farseer_gl"] = {}
Shop.Inventory["weapon_ranged_acrate"] = {}
Shop.Inventory["weapon_melee_steelcutter"] = {}
Shop.Inventory["weapon_melee_sharpnel"] = {}
Shop.Inventory["weapon_melee_horn"] = {}
Shop.Inventory["weapon_melee_outlander"] = {}

Register.Shop(Shop)

local Shop = {}
Shop.Name = "shop_weapons3"
Shop.PrintName = "Master Arms Dealer"
Shop.Inventory = {}
Shop.Inventory["weapon_melee_thebigdeal"] = {}
Shop.Inventory["weapon_melee_crystalcollapse"] = {}
Shop.Inventory["weapon_melee_thebower"] = {}
Shop.Inventory["weapon_ranged_theparrot"] = {}
Shop.Inventory["weapon_ranged_silencer"] = {}
Shop.Inventory["weapon_ranged_smiter"] = {}
Shop.Inventory["weapon_ranged_pmaker"] = {}
Register.Shop(Shop)



local Shop = {}
Shop.Name = "shop_developer"
Shop.PrintName = "Developer Shop"
Shop.Inventory = {}
for name, _ in pairs( GM.DataBase.Items ) do
	Shop.Inventory[ name ] = {Price = 1}
end
Register.Shop(Shop)