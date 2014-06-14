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

--Chef Hat Madness--
local Item = QuickCreateItemTable(BaseArmor, "armor_helm_brithat", "British Hat", "It means you cool like that", "icons/hat_cheifshat")
Item = AddStats(Item, "slot_helm", 3)
Item.Weight = 1
Item.SellPrice = 25
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_helm_fancyhat", "Fancy Hat", "Cotton does not defends you from the sharpenels", "icons/hat_cheifshat")
Item = AddStats(Item, "slot_helm", 1)
Item.Weight = 1
Item.SellPrice = 25
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_helm_musicgear", "Alien Music Gear", "SWAG is for pussies", "icons/hat_cheifshat")
Item = AddStats(Item, "slot_helm", 5)
Item.Weight = 1
Item.SellPrice = 100
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_helm_cwatcher", "Combine Watcher Helmet", "Makes you more stronger and faster", "icons/bt/item_mask")
Item = AddStats(Item, "slot_helm", 12)
Item.Level = 6
Item.Weight = 1
Item.SellPrice = 300
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_helm_alakajam", "Ancient Helmet", "You haven't seen something like this", "icons/bt/item_mask")
Item = AddStats(Item, "slot_helm", 22)
Item.Level = 16
Item.Weight = 1
Item.SellPrice = 300
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_helm_cardboard", "Cardboard Curiosity", "You haven't seen something like this", "icons/bt/item_box2")
Item = AddStats(Item, "slot_helm", 35)
Item.Level = 14
Item.Weight = 1
Item.SellPrice = 3000
Register.Item(Item)


local Item = QuickCreateItemTable(BaseArmor, "armor_helm_racist", "Blackey Afro", "Makes you more stronger and faster", "icons/hat_cheifshat")
Item = AddStats(Item, "slot_helm", 5)
Item.Weight = 1
Item.SellPrice = 25
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_helm_skull", "Skull Helm", "Makes you more stronger and faster", "icons/bt/item_skull")
Item = AddStats(Item, "slot_helm", 50)
Item = AddBuff(Item, "stat_dexterity", 3)
Item.Weight = 1
Item.SellPrice = 1
Item.Currency = "token_boss1"
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_helm_robo", "Robo Helm", "Makes you more stronger and faster", "icons/bt/item_module")
Item = AddStats(Item, "slot_helm", 5)
Item.Weight = 1
Item.SellPrice = 25
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_helm_combine", "Advanced Combine Mask", "Makes you more stronger and faster", "icons/bt/item_mask")
Item = AddStats(Item, "slot_helm", 5)
Item.Weight = 1
Item.SellPrice = 25
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_helm_steam", "Steam Punk Hat", "Makes you more british and smarter.", "icons/junk_cog")
Item = AddStats(Item, "slot_helm", 5)
Item.Weight = 1
Item.SellPrice = 25
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_helm_headcrab", "Headcrab", "Apply direct on your forehead.", "icons/bt/item_crab") -- loootable
Item = AddStats(Item, "slot_helm", 30)
Item.Weight = 1
Item.SellPrice = 500
Item.ItemColor = clrRare
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_helm_pheadcrab", "Posion Headcrab", "Apply direct on your forehead.", "icons/bt/item_crab")  -- lootable
Item = AddStats(Item, "slot_helm", 50)
Item.Weight = 1
Item.SellPrice = 1000
Item.ItemColor = clrRare
Register.Item(Item)

--

local Item = QuickCreateItemTable(BaseArmor, "armor_helm_why", "Why", "Makes you more stronger and faster", "icons/bt/item_mask")
Item = AddStats(Item, "slot_helm", 20)
Item.Weight = 1
Item.SellPrice = 500
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_helm_devilchan", "Devil-Chan", "Makes you more stronger and faster", "icons/bt/item_mask")
Item = AddStats(Item, "slot_helm", 5)
Item.Weight = 1
Item.SellPrice = 25
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_helm_mhell", "Monitor From Hell", "Makes you more stronger and faster", "icons/bt/item_mask")
Item = AddStats(Item, "slot_helm", 80)
Item.ItemColor = clrUnique
Item.Weight = 1
Item.SellPrice = 25
Register.Item(Item)


local Item = QuickCreateItemTable(BaseArmor, "armor_helm_kocixa1", "Kocixa's Glass-Glasses", "Makes you more stronger and faster", "icons/bt/item_mask")
Item = AddStats(Item, "slot_helm", 5)
Item = AddBuff(Item, "stat_dexterity", 2)
Item.ItemColor = clrMagic
Item.Level = 8
Item.Weight = 1
Item.SellPrice = 5000
Register.Item(Item)


local Item = QuickCreateItemTable(BaseArmor, "armor_helm_boinghead", "Garry Man Boing Head", "Makes you more stronger and faster", "icons/bt/item_mask")
Item = AddStats(Item, "slot_helm", 5)
Item.Weight = 1
Item.SellPrice = 25
Register.Item(Item)


