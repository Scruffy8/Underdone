local function AddModel(tblAddTable, strModel, vecPostion, angAngle, clrColor, strMaterial, vecScale)
	tblAddTable.Model = tblAddTable.Model or {}
	if type(tblAddTable.Model) != "table" then tblAddTable.Model = {} end
	table.insert(tblAddTable.Model, {Model = strModel, Position = vecPostion, Angle = angAngle, Color = clrColor, Material = strMaterial, Scale = vecScale})
	return tblAddTable
end
local function AddStats(tblAddTable, strSlot, intArmor)
	tblAddTable.Slot = strSlot
	tblAddTable.Armor = intPower
	return tblAddTable
end
local function AddBuff(tblAddTable, strBuff, intAmount)
	tblAddTable.Buffs[strBuff] = intAmount
	return tblAddTable
end

-- set/lootable

local Item = QuickCreateItemTable(BaseArmor, "armor_belt_skull", "Nasty Ass", "It will add inventory space", "icons/bt/item_skull")
Item.SellPrice = 1
Item.Currency = "token_boss1"
Item = AddStats(Item, "slot_waist", 20)
Item = AddBuff(Item, "stat_strength", 3)
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_belt_robo", "Robo Useful", "It will add inventory space", "icons/bt/item_saw")
Item.SellPrice = 300
Item = AddStats(Item, "slot_waist", 0)
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_belt_combine", "Combine Ammo Belt", "It will add inventory space", "icons/bt/item_ar2cart")
Item.SellPrice = 300
Item = AddStats(Item, "slot_waist", 0)
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_belt_steam", "Cog-cog Cogi Cig", "It will add inventory space", "icons/junk_cog")
Item.SellPrice = 300
Item = AddStats(Item, "slot_waist", 0)
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_belt_healer", "Kind Healer", "It will add inventory space", "icons/junk_cog")
Item.SellPrice = 300
Item = AddStats(Item, "slot_waist", 5)
Item = AddBuff(Item, "stat_maxhealth", 30)
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_belt_cardboard", "Butt Ruckers", "Ultimate Defender", "icons/bt/item_box2")
Item.SellPrice = 3000
Item.Level = 15
Item.ItemColor = clrMagic
Item = AddStats(Item, "slot_waist", 20)
Item = AddBuff(Item, "stat_dexterity", 1)
Item = AddBuff(Item, "stat_strength", 1)
Register.Item(Item)

-- shop items

local Item = QuickCreateItemTable(BaseArmor, "armor_belt_howtofight", "How to Fight Guide Book", "It will add inventory space", "icons/junk_cog")
Item.SellPrice = 300
Item = AddStats(Item, "slot_waist", 4)
Item = AddBuff(Item, "stat_dexterity", 1)
Item = AddBuff(Item, "stat_strength", 1)
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_belt_alakajam", "Alakajam Belt", "Alakajam's Belt. Damaged but it works..", "icons/junk_cog")
Item.SellPrice = 4500
Item.Level = 16
Item = AddStats(Item, "slot_waist", 16)
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_belt_autoloader", "Portable Auto Loader", "Makes fresh bullets with used brass in your inventory.", "icons/junk_cog")
Item.SellPrice = 5000
Item.Level = 10
Item.ItemColor = clrMagic
Item = AddStats(Item, "slot_waist", 2)
Item = AddBuff(Item, "stat_dexterity", 2)
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_belt_strength", "Belt of Ogre", "The Leather of the belt is looks like ogre's one.", "icons/junk_cog")
Item.SellPrice = 5000
Item.Level = 10
Item.ItemColor = clrMagic
Item = AddStats(Item, "slot_waist", 2)
Item = AddBuff(Item, "stat_strength", 2)
Register.Item(Item)