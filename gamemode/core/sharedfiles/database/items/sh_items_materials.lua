local function AddModel(tblAddTable, strModel, vecPostion, angAngle, clrColor, strMaterial, vecScale)
	tblAddTable.Model = tblAddTable.Model or {}
	if type(tblAddTable.Model) != "table" then tblAddTable.Model = {} end
	table.insert(tblAddTable.Model, {Model = strModel, Position = vecPostion, Angle = angAngle, Color = clrColor, Material = strMaterial, Scale = vecScale})
	return tblAddTable
end
local function specialGrenade(  strItem, plyPlayer, intForce, intTimer, intDamage, intRange, strMention )
		
	plyPlayer.NextGrenade = plyPlayer.NextGrenade or CurTime()
	plyPlayer.NextMessage = plyPlayer.NextMessage or CurTime()
	
	if plyPlayer.NextGrenade > CurTime() then
		if plyPlayer.NextMessage > CurTime() then
			return
		end
		bliperror( plyPlayer, "You have to wait " .. math.abs( math.floor( CurTime() - plyPlayer.NextGrenade ) ) .. " second(s)."  )
		plyPlayer.NextMessage = CurTime() + 0.8
		return
	end
	plyPlayer.NextGrenade = CurTime() + 5
	
	plyPlayer:EmitSound( "weapons/357/357_reload1.wav", 100, 150 )
	plyPlayer:CreateIndacator( "Fire_in_the_hole!", plyPlayer:GetPos() + Vector( 0, 0, 70 ), "red" , true)
	plyPlayer:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE)
	plyPlayer:AddItem( strItem, -1 )
	
	umsg.Start( "skill_pusheffect" )
		umsg.Entity( plyPlayer )
		umsg.String( "skill_a_m_grenadetoss" )
	umsg.End()
	
	timer.Simple( 0.4, function()
	
		plyPlayer:EmitSound( "weapons/357/357_reload3.wav", 100, 150 )
		plyPlayer:EmitSound( "npc/fast_zombie/claw_miss2.wav", 100, 80 )
		if ( ( not plyPlayer:Alive() ) ) then return end
		local ent = ents.Create( "proj_explosive" )
		ent:SetPos( plyPlayer:EyePos() )
		ent:SetAngles(Angle(math.random(1, 100), math.random(1, 100), math.random(1, 100)))
		ent:SetOwner( plyPlayer )
		ent:Spawn()
		ent:SetTimer( intTimer )
		ent:SetDamage( intDamage )
		ent:SetRadius( intRange )
		
		local phys = ent:GetPhysicsObject()
		
		phys:ApplyForceCenter( plyPlayer:GetAimVector() * intForce * 1.2 )
		phys:AddAngleVelocity(Vector(math.random(-500, 500), math.random(-500, 500), math.random(-500, 500)))
		
	end)
	
end
local function specialTurret( plyPlayer, strItem )

		plyPlayer:AddItem( strItem, -1 )
		local vecPosition = plyPlayer:EyePos() + plyPlayer:GetAimVector() * 50
		local vecDir = Vector( 0, 0, -1 )
		local tracedata = {}
		tracedata.start = vecPosition
		tracedata.endpos = vecPosition + vecDir * 100
		tracedata.filter = plyPlayer
		local trace = util.TraceLine(tracedata)		

		local ent = ents.Create( "npc_turret2" )
		ent:SetPos( trace.HitPos )
		ent:SetOwner( plyPlayer )
		ent:Spawn()
		ent.Second:SetOwner( plyPlayer )
		ent:SetAngles( ( Vector( plyPlayer:GetAimVector().x, plyPlayer:GetAimVector().y, 0 ) ):Angle() )
		ent.Pipe:SetAngles( ent:GetAngles() + Angle( 0, 180, 0 )  )
		
		local effectdata2 = EffectData()
			effectdata2:SetStart( ent:GetPos())
			effectdata2:SetOrigin( ent:GetPos())
			effectdata2:SetNormal( Vector( 0, 0, 10 ) )
			effectdata2:SetScale( 1.5 )
		util.Effect("turret_install", effectdata2)
	
		ent:EmitSound( "doors/heavy_metal_stop1.wav" )
		timer.Simple( 30, function() if ent:IsValid() then ent:GoHome() end end)
		
end
local function AddStats(tblAddTable, intPower, intFireRate)
	tblAddTable.Power = intPower
	tblAddTable.FireRate = intFireRate
	tblAddTable.HoldType = "melee2"
	tblAddTable.Melee = true
	return tblAddTable
end
local function AddBuff(tblAddTable, strBuff, intAmount)
	tblAddTable.Buffs[strBuff] = intAmount
	return tblAddTable
end
local function AddSound(tblAddTable, strShootSound)
	tblAddTable.Sound = strShootSound
	return tblAddTable
end

local normalvein = {
	dice = { 1, 500 },
	
	occ = {
		["mat_copper"] = { 0, 20 },
		["mat_iron"] = { 20, 30 },
		["mat_silver"] = { 40, 43 },
		["mat_gold"] = { 44,44 },
	}
}

local flamevein = {
	dice = { 1, 2000 },
	occ = {
		["mat_pyromite"] = { 0, 10 },
		["mat_pyrocore"] = { 10, 11 },
		["mat_iron"] = { 11, 70 },
		["mat_silver"] = { 70,150 },
		["mat_gold"] = { 150,200 },
	}
}

local tblVeinModel = {
	[ "models/props_wasteland/rockcliff_cluster01a.mdl" ] = normalvein,
	[ "models/props_wasteland/rockcliff_cluster01b.mdl" ] = normalvein,
	[ "models/props_wasteland/rockcliff_cluster02a.mdl" ] = normalvein,
	[ "models/props_wasteland/rockcliff_cluster02b.mdl" ] = normalvein,
	[ "models/props_wasteland/rockcliff_cluster02c.mdl" ] = normalvein,
	[ "models/props_wasteland/rockcliff_cluster03a.mdl" ] = normalvein,
	[ "models/props_wasteland/rockcliff_cluster03b.mdl" ] = normalvein,
	[ "models/props_wasteland/rockcliff_cluster03c.mdl" ] = normalvein,
	[ "models/props_wasteland/rockcliff07e.mdl" ] = flamevein,
}


local Item = QuickCreateItemTable(BaseWeapon, "special_drill", "Metal Drill", "Allows you to gather resources from rocks", "icons/weapon_sniper1")
Item = AddStats(Item, 1, 8)
Item.HoldType = "physgun"
Item.ItemColor = clrMagic
Item.Dropable = false
Item.Giveable = false
Item = AddSound(Item, "npc/dog/dog_servo1.wav")
Item.Level = 1
function Item:PostShoot( plyPlayer, entWeapon )
	entWeapon:SetNextPrimaryFire( CurTime() + 0.12 )
end
Item.CallBack = function( tblItem, plyPlayer, tblTrace )
	if ( tblTrace.Entity:GetClass() == "prop_dynamic" || tblTrace.Entity:GetClass() == "prop_physics" ) then
		local tblVein = tblVeinModel[ string.lower( tblTrace.Entity:GetModel() ) ]
		if tblVein then
				local dice = math.random( tblVein.dice[1], tblVein.dice[2] )
				local dat = tblVein.occ
				local master = plyPlayer:GetMasterLevel( "master_mining" )
				local mply = 1 + ( master * 0.05 )
				local mply2 = 1 + ( master * 0.1 )
				
				for name, data in pairs( dat ) do
					
					if ( ( !data[ 1 ] || dice > data[ 1 ] * mply ) && ( !data[ 2 ] || dice <= data[ 2 ] * mply2) ) then 
						if ( plyPlayer:CanBurden( ItemTable(name).Weight ) ) then
							plyPlayer:EmitSound(  "physics/concrete/rock_impact_hard" .. math.random( 1, 4 ) ..".wav", 300 )
							plyPlayer:AddItem( name, 1 )
							plyPlayer:CreateNotification( "Gathered one " ..  ItemTable(name).PrintName .. " from the Ore Vein")
							plyPlayer:AddMaster( "master_mining" , 1)
						else
							plyPlayer:CreateNotification(  "Not enough Inventory space" )
						end
						break;
					end
					
				end

		end
	end
end
Item.Weight = 1
Item.SellPrice = 1
Register.Item(Item)



/*--------------------------------------------------------------------------
												Ores
--------------------------------------------------------------------------*/
local tblOreTable = {

	{ "mat_armourflesh", "Armour Flesh", "A Hardened flesh from the rock.", "icons/bt/mat_armourflesh", 500, 2 },
	{"mat_iron", "Iron", "The basic material for crafting items.", "icons/bt/mat_iron", 12, 1 },
	{"mat_copper", "Copper", "The basic material for crafting items.", "icons/bt/mat_copper", 8, 1 },
	{ "mat_silver", "Silver", "The basic material for crafting items.", "icons/bt/mat_silver", 20 , 1 },
	{ "mat_gold", "Gold", "The basic material for crafting items.", "icons/bt/mat_gold", 40, 1 },
	{"mat_pyrocore", "Pyrocore", "Really hot and light. Touch it with care.", "icons/bt/mat_pyrocore", 750, .2 },
	{"mat_pyromite", "Pyromite", "Really hot and light. Touch it with care.", "icons/bt/mat_pyromite", 150, .2 },
	{ "mat_rhynomite", "Rhynomite", "Really Heavy. Feels like combine metals.", "icons/bt/mat_rhynomite", 3000, 3 },
	{"mat_glass", "Rhynomite", "Usually used for electonic stuffs.", "icons/bt/mat_glass", 200, 3 },
	{"mat_mp_basic", "Basic Metal Polisher", "Usually used for metal crafting.", "icons/Quest_ZombieBlood", 150, .2 },
	-- Item Stacks
	{"mat_r_iron", "Refined Iron", "The basic material for crafting items.", "icons/bt/mat_iron", 50, .5, clrMagic },
	{"mat_b_iron", "Iron Bar", "The basic material for crafting items.", "icons/bt/mat_iron", 50, .5, clrRare },
	{"mat_r_copper", "Refined Copper", "The basic material for crafting items.", "icons/bt/mat_copper", 50, .5, clrMagic },
	{"mat_r_wood", "Reinforced Wood", "The basic material for crafting items.", "icons/item_wood", 50, .3, clrMagic },

}

local tblCraftResources = {

	{"craft_fuse", "Mechanical Fuse", "Some parts for explosives.", "icons/bt/item_plug", 200, 1 },
	{"craft_b_barrel", "Basic Barrel", "Basic Barrel for the guns.", "icons/bt/mat_barrel", 200, 1 },
	{ "craft_coppercog", "Copper Cog", "A useful part for mechanical gadgets.", "icons/bt/mat_smallcog", 40, .1 },
	{"craft_ironcog", "Iron Cog", "A useful part for mechanical gadgets.", "icons/bt/mat_smallcog", 80, .1 },
	{"craft_silvercog", "Silver Cog", "A useful part for mechanical gadgets.", "icons/junk_cog", 120, .1 },
	{"craft_goldcog", "Gold Cog", "A useful part for mechanical gadgets.", "icons/junk_cog", 500, .1 },
	{"craft_coppercircuit", "Copper Circuit Board", "Useful Electonic part.", "icons/bt/mat_board", 200, 1 },
	{ "craft_advcoppercircuit", "Advanced Copper Circuit Board", "Useful Electonic part.", "icons/bt/mat_board", 400, 1 },
	{"craft_goldcircuit", "Gold Circuit Board", "Useful Electonic part.", "icons/bt/mat_board", 600, 1 },
	{ "craft_advgoldcircuit", "Gold Copper Circuit Board", "Useful Electonic part.", "icons/bt/mat_board",800,1 },
	{"craft_fibercircuit", "Fiber Circuit Board", "Rare Useful Electonic part.", "icons/bt/mat_board2", 1200, 1 },
	{"craft_advfibercircuit", "Advanced Fiber Circuit Board", "Rare Useful Electonic part.", "icons/bt/mat_board2", 1500, 1 },
	{"craft_reciever", "Reciever", "Recieves the signal from the Transmitter.", "icons/bt/mat_board", 1500, 1 },
	{"craft_transmitter", "Transmitter", "Transmits the signal to the Reciever.", "icons/bt/mat_board", 1600, 1 },
	{"craft_storagedevice", "Storage Device", "Rare Useful Electonic part.", "icons/bt/mat_drive", 1200, 1 },
	{"craft_nitro", "Nitro", "Caution: Threat it carefully.", "icons/bt/mat_drive", 1, 1, nil, "token_boss1" },
	{"craft_junk", "Ruined Part", "There was an attempt.", "icons/bt/mat_failed", 20, .1 },
	
	{"craft_gasoline", "Gasoline", "Gasoline. You can craft something with this.", "icons/bt/mat_failed", 50, 1 },
	
}

local tblRewards = {

	{"token_boss1", "Ceasar Token", "You can see the ceasar's face on the coin.", "icons/bt/token_1", 20, 0, clrRare },
	{"token_space", "Space Token", "SPACE JAM.", "icons/bt/token_1", 20, 0, clrUnique },
	{"key_rust", "Rust Key", "Can't be used in facepunch.", "icons/bt/item_key", 20, 0, clrMagic },
	
}

local tblItemTableList = {
	tblOreTable,
	tblCraftResources,
	tblRewards,
}
-- How do i add some translations? 
-- ADD MORE TABLES
for _, tbl in pairs( tblItemTableList ) do
	for k, v in pairs( tbl ) do
		local Item = QuickCreateItemTable(BaseItem, v[1], v[2], v[3], v[4])
		Item.Stackable = true
		Item.SellPrice = v[5]
		Item.Weight = v[6]
		if v[7] then
			Item.ItemColor = v[7]
		end
		if v[8] then
			Item.Currency = v[8]
		end
		Register.Item(Item)
	end
end
/*--------------------------------------------------------------------------
												Crafting Materials
--------------------------------------------------------------------------*/


/*--------------------------------------------------------------------------
												The Actual Gadget
--------------------------------------------------------------------------*/


local Item = QuickCreateItemTable(BaseItem, "craft_grenade_tier1", "Rock Hard Grenade", "Deals 100 damage within range 200.", "icons/bt/weapon_grenade")
Item.gForce = 1000
Item.gDamage = 100
Item.gRange = 200
Item.gTimer = 3
function Item:Use( plyPlayer, item )
	 specialGrenade(  Item.Name, plyPlayer, Item.gForce, Item.gTimer, Item.gDamage, Item.gRange, strMention )
end
Item.SellPrice = 16
Item.Weight = .5
Item.ItemColor = clrMagic
Register.Item(Item)



local Item = QuickCreateItemTable(BaseItem, "craft_turret_tier1", "Stolen Combine Turret", "Delas 10 Damage. Lasts 60 sec.", "icons/bt/item_turret")
Item.gForce = 1000
Item.gDamage = 100
Item.gRange = 200
Item.gTimer = 3
function Item:Use( plyPlayer, item )
	 specialTurret(  plyPlayer, Item.Name )
end
Item.SellPrice = 700
Item.ItemColor = clrMagic
Item.Weight = .5
Register.Item(Item)


local function bttSpawn( plyPlayer, tblItemTable )

		if plyPlayer.spawnedTurret then return end
		local vecPosition = plyPlayer:EyePos() 
		local tracedata = {}
		tracedata.start = vecPosition
		tracedata.endpos = vecPosition + plyPlayer:GetAimVector() * 100
		tracedata.filter = plyPlayer
		local trace = util.TraceLine(tracedata)		

		local ent = ents.Create( "npc_fturret" )
		ent:SetPos( trace.HitPos )
		ent:SetOwner( plyPlayer )
		ent:Spawn()
		ent:SetOwner( plyPlayer )
	
		ent.intDamage = 5 + plyPlayer:GetLevel() * tblItemTable.tLDam
		ent.intAmmoCap = tblItemTable.tMag
		ent.intReloadTime = tblItemTable.tRelSpd
		ent.intFireRate = tblItemTable.tWepSpd
		
		plyPlayer.spawnedTurret = ent
		
		ent:EmitSound( "doors/heavy_metal_stop1.wav" )
		timer.Simple( 150, function() if ent:IsValid() then plyPlayer.spawnedTurret = nil ent:Remove() end end)
		
end

local Item = QuickCreateItemTable(BaseItem, "craft_btt_1", "Black Tea Turret (Tier 1)", "Delas 10 Damage. Lasts 60 sec.", "icons/bt/item_turret")
Item.tLDam = 3
Item.tMag = 3
Item.tRelSpd = 1
Item.tWepSpd = .1
function Item:Use( plyPlayer, item )
	 bttSpawn( plyPlayer, item )
end
Item.SellPrice = 600
Item.ItemColor = clrRare
Item.Weight = .5
Register.Item(Item)






