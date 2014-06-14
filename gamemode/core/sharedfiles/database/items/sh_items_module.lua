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

local Item = QuickCreateItemTable(BaseArmor, "module_smallbag", "Small Bag Module", "It will add inventory space", "icons/bt/item_box2")
Item.SellPrice = 600
Item.ItemColor = clrMagic
Item = AddStats(Item, "slot_module", 0)
Item = AddBuff(Item, "stat_maxweight", 10)
Register.Item(Item)