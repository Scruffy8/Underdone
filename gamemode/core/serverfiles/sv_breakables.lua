local tblBreakables = {}
local function AddItem(strModel, strItem, intChance, intMin, intMax)
	tblBreakables[strModel] = tblBreakables[strModel] or {}
	table.insert(tblBreakables[strModel], {Item = strItem, Chance = intChance or 100, Min = intMin or 1, Max = intMax or intMin or 1})
end
AddItem("models/props_junk/wood_crate001a.mdl", "wood", 80, 1, 3)
AddItem("models/props_junk/wood_crate002a.mdl", "wood", 80, 1, 3)
AddItem("models/props_junk/wood_crate002a.mdl", "item_smallammo_small", 10)
AddItem("models/props_junk/wood_crate002a.mdl", "item_rifleammo_small", 10)
AddItem("models/props_junk/wood_crate002a.mdl", "item_buckshotammo_small", 10)
AddItem("models/props_junk/wood_crate002a.mdl", "item_canmeat", 30)

function GM:AllowPlayerPickup( player, ent )
	return false
end

local function PropAdjustDamage(entVictim, tblDamageInfo)
	local entInflictor = tblDamageInfo:GetInflictor()
	local entAttacker = tblDamageInfo:GetAttacker()
	local intAmount	= tblDamageInfo:GetDamage()
	if IsValid(entVictim) && entVictim:GetClass() == "prop_physics" then
		local tblBreakTable = tblBreakables[entVictim:GetModel()]
		if tblBreakTable && entAttacker:IsPlayer() then
			tblDamageInfo:ScaleDamage(2)
			return
		end
		tblDamageInfo:SetDamage(0)
	else
		if entVictim.MapProp then
			tblDamageInfo:SetDamage(0)
		end
	end
end
hook.Add("EntityTakeDamage", "PropAdjustDamage", PropAdjustDamage)

local function OnPropBreak(entBreaker, entProp)
	if entBreaker:IsValid() and entBreaker:IsPlayer() and entProp:IsValid() then
		local tblBreakTable = tblBreakables[entProp:GetModel()]
		if tblBreakTable then
			for _, tblBreakItem in pairs(tblBreakTable) do
				if math.random(1, 100 / tblBreakItem.Chance) == 1 then
					local strItem = tblBreakItem.Item
					local intMaxAmount = tblBreakItem.Max
					strItem, intMaxAmount = entBreaker:CallSkillHook("resouce_mod", strItem, intMaxAmount)
					for i = 1, math.random(tblBreakItem.Min, intMaxAmount) do
						local entLoot = CreateWorldItem(strItem)
						entLoot:SetPos(entProp:GetPos())
						entLoot:SetOwner(entBreaker)
						entLoot:GetPhysicsObject():ApplyForceCenter(Vector(math.random(-100, 100), math.random(-100, 100), math.random(350, 400)))
					end
				end
			end
		end
		if ( entProp.ObjectKey && GAMEMODE.MapEntities.WorldProps[entProp.ObjectKey] ) || entProp.Respawn then
		
				local pos = entProp:GetPos()
				local ang = entProp:GetAngles()
				local model = entProp:GetModel()
				timer.Simple(math.Rand( 60, 70 ), function()
					local entProp2 = ents.Create( "prop_physics" )
					entProp2:SetModel( model )
					entProp2:SetPos( pos )
					entProp2:SetAngles( ang )
					entProp2:PhysicsInit(SOLID_VPHYSICS)
					entProp2:SetMoveType(MOVETYPE_NONE)
					entProp2:DrawShadow(false)
					entProp2:SetKeyValue("spawnflags", 8)
					entProp2:SetSkin(math.random(0, entProp2:SkinCount()))
					entProp2:Spawn()
					entProp2.Respawn = true
				end)
				
		end
	end
end
hook.Add("PropBreak", "OnPropBreak", OnPropBreak)