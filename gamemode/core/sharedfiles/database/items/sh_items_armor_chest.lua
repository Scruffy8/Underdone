local function AddModel(tblAddTable, strModel, vecPostion, angAngle, clrColor, strMaterial, vecScale)
	tblAddTable.Model = tblAddTable.Model or {}
	if type(tblAddTable.Model) != "table" then tblAddTable.Model = {} end
	table.insert(tblAddTable.Model, {Model = strModel, Position = vecPostion, Angle = angAngle, Color = clrColor, Material = strMaterial, Scale = vecScale})
	return tblAddTable
end
local function AddStats(tblAddTable, strSlot, intArmor)
	tblAddTable.Slot = strSlot
	tblAddTable.Armor = intArmor
	return tblAddTable
end
local function AddBuff(tblAddTable, strBuff, intAmount)
	tblAddTable.Buffs[strBuff] = intAmount
	return tblAddTable
end

local Item = QuickCreateItemTable(BaseArmor, "armor_chest_junkarmor", "Junky Armor", "Protects your heart and lungs from gettin pwnd", "icons/amor_junkyarmor")
Item = AddStats(Item, "slot_chest", 15)
Item = AddBuff(Item, "stat_maxhealth", 5)
Item.Weight = 2
Item.SellPrice = 420
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_chest_cplate", "Combine Chest Plate", "Especially British Name", "icons/amor_junkyarmor")
Item = AddStats(Item, "slot_chest", 25)
Item = AddBuff(Item, "stat_maxhealth", 10)
Item.Level = 5	
Item.Weight = 2
Item.SellPrice = 900
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_chest_solidmetal", "Heavy Solid Metal Armor", "Especially British Name", "icons/amor_junkyarmor")
Item = AddStats(Item, "slot_chest", 45)
Item = AddBuff(Item, "stat_maxhealth", 10)
Item.Level = 11
Item.Weight = 2
Item.SellPrice = 1750
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_lite_plat", "Rhynomite Armor", "This will prevent you from getting pwned", "icons/amor_junkyarmor")
Item = AddStats(Item, "slot_chest", 76)
Item = AddBuff(Item, "stat_maxhealth", 20)
Item.Level = 15
Item.Weight = 2
Item.SellPrice = 4200
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_chest_alakajam", "Alakajam Armor", "This will prevent you from getting pwned", "icons/amor_junkyarmor")
Item = AddStats(Item, "slot_chest", 99)
Item = AddBuff(Item, "stat_maxhealth", 25)
Item.Level = 21
Item.Weight = 2
Item.SellPrice = 8900
Register.Item(Item)

--- craftable / lootable

local Item = QuickCreateItemTable(BaseArmor, "armor_chest_cardboard", "Reinforced Hobo Protector", "Especially British Name", "icons/item_box2")
Item = AddStats(Item, "slot_chest", 150)
Item = AddBuff(Item, "stat_maxhealth", 10)
Item.Level = 14
Item.Weight = 2
Item.ItemColor = clrMagic
Item.SellPrice = 5000
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_chest_racist", "KFC Bucket", "Not Offensive", "icons/bt/misc_basket")
Item = AddStats(Item, "slot_chest", 25)
Item = AddBuff(Item, "stat_maxhealth", 10)
Item.Level = 14
Item.Weight = 2
Item.SellPrice = 1020
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_chest_skull", "Death Below", "Not Offensive", "icons/bt/item_skull")
Item = AddStats(Item, "slot_chest", 200)
Item = AddBuff(Item, "stat_maxhealth", 50)
Item.Level = 14
Item.Weight = 2
Item.SellPrice = 1
Item.Currency = "token_boss1"
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_chest_robo", "Radiant Heater Robo Parts", "Not Offensive", "icons/bt/item_armour_1")
Item = AddStats(Item, "slot_chest", 25)
Item = AddBuff(Item, "stat_maxhealth", 10)
Item.Level = 14
Item.Weight = 2
Item.SellPrice = 1020
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_chest_combine", "Combine V-1 Chest Armor", "Not Offensive", "icons/bt/item_elite")
Item = AddStats(Item, "slot_chest", 25)
Item = AddBuff(Item, "stat_maxhealth", 10)
Item.Level = 14
Item.Weight = 2
Item.SellPrice = 1020
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_chest_steam", "Steam Punk Steamer Armour", "Especially British Name", "icons/junk_cog")
Item = AddStats(Item, "slot_chest", 40)
Item = AddBuff(Item, "stat_maxhealth", 10)
Item.Level = 14
Item.Weight = 2
Item.SellPrice = 1020
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_chest_efever", "Electronic Fever", "Especially British Name", "icons/junk_cog") -- Quested.
Item = AddStats(Item, "slot_chest", 110)
Item = AddBuff(Item, "stat_maxhealth", 40)
Item.Level = 20
Item.Weight = 2
Item.SellPrice = 900
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_chest_healthcare", "Granny's Health Care", "Especially British Name", "icons/junk_cog")
Item = AddStats(Item, "slot_chest", 600)
Item = AddBuff(Item, "stat_maxhealth", 80)
Item.Level = 14
Item.Weight = 2
Item.SellPrice = 1020
Register.Item(Item)
