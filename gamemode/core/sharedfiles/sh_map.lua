include'sh_newspawns.lua'

GM.MapEntities = {}
GM.MapEntities.NPCSpawnPoints = {}
GM.MapEntities.WorldProps = {}
GM.bitEditor = true

function GM:CreateSpawnPoint(vecPosition, angAngle, strNPC, intLevel, intSpawnTime)
	table.insert(GAMEMODE.MapEntities.NPCSpawnPoints, {})
	local intNumSpawns = #GAMEMODE.MapEntities.NPCSpawnPoints
	GAMEMODE:UpdateSpawnPoint(intNumSpawns, vecPosition, angAngle, strNPC, intLevel, intSpawnTime)
end
function GM:RemoveSpawnPoint(intKey)
	local tblSpawnPoint = GAMEMODE.MapEntities.NPCSpawnPoints[intKey]
	if tblSpawnPoint then
		if tblSpawnPoint.Monster then tblSpawnPoint.Monster:Remove() end
		table.remove(GAMEMODE.MapEntities.NPCSpawnPoints, intKey)
	end
end
function GM:UpdateSpawnPoint(intKey, vecPosition, angAngle, strNPC, intLevel, intSpawnTime)
	local tblNPCTable = NPCTable(strNPC)
	local tblToUpdateSpawn = GAMEMODE.MapEntities.NPCSpawnPoints[intKey]
	if tblToUpdateSpawn then
		tblToUpdateSpawn.Postion = vecPosition or tblToUpdateSpawn.Postion
		tblToUpdateSpawn.Angle = angAngle or tblToUpdateSpawn.Angle or Angle(0, 0, 0)
		tblToUpdateSpawn.NPC = strNPC or tblToUpdateSpawn.NPC or "zombie"
		tblToUpdateSpawn.Level = intLevel or tblToUpdateSpawn.Level or 5
		tblToUpdateSpawn.SpawnTime = intSpawnTime or tblToUpdateSpawn.SpawnTime or 0
		if IsValid(tblToUpdateSpawn.Monster) then
			tblToUpdateSpawn.Monster:SetAngles(tblToUpdateSpawn.Angle)
		end
		if SERVER && game.SinglePlayer() && IsValid(player.GetByID(1)) then
			SendUsrMsg("UD_UpdateSpawnPoint", player.GetByID(1), {intKey, tblToUpdateSpawn.Postion, tblToUpdateSpawn.Angle, tblToUpdateSpawn.NPC, tblToUpdateSpawn.Level, tblToUpdateSpawn.SpawnTime})
		end
	else
		GAMEMODE:CreateSpawnPoint(vecPosition, angAngle, strNPC, intLevel, intSpawnTime)
	end
end

function GM:CreateWorldProp( strModel, vecPostion, angAngle )
	if SERVER then
	
		local dmy = {}
		dmy.Model = strModel
		dmy.Postion = vecPostion
		dmy.Angle = angAngle
		table.insert(self.MapEntities.WorldProps, dmy)
		
		local entProp = ents.Create( "prop_physics" )
		entProp:SetModel( strModel )
		entProp:SetPos( vecPostion )
		entProp:SetAngles( angAngle )
		entProp:PhysicsInit(SOLID_VPHYSICS)
		entProp:SetMoveType(MOVETYPE_NONE)
		entProp:DrawShadow(false)
		entProp:SetKeyValue("spawnflags", 8)
		entProp:SetSkin(math.random(0, entProp:SkinCount()))
		entProp:Spawn()
		entProp.IntKey = #self.MapEntities.WorldProps
		entProp.Respawn = true
		
		dmy.Entity = entProp
		return entProp
		
	end
end
	
function GM:RemoveWorldProp(intKey)

	for k, v in pairs( ents.GetAll() ) do
		if v.IntKey == intKey then v:Remove() end
	end
	table.remove(GAMEMODE.MapEntities.WorldProps, intKey)
	
end

function GM:UpdateWorldProp(intKey, strModel, vecPosition, angAngle, entEntity, boolLoad)
	local tblToUpdateProp = GAMEMODE.MapEntities.WorldProps[intKey]
	if tblToUpdateProp && IsValid(tblToUpdateProp.Entity) then
		local entProp = tblToUpdateProp.Entity
		if SERVER then
			local strPreModel = entProp:GetModel()
			entProp:SetModel(strModel or "models/props_junk/garbage_metalcan001a.mdl")
			entProp:SetPos(vecPosition or entProp:GetPos())
			if strPreModel != entProp:GetModel() && !boolLoad then entProp:SetPos(GetFlushToGround(entProp)) end
			entProp:SetAngles(angAngle or entProp:GetAngles())
			entProp:PhysicsInit(SOLID_VPHYSICS)
			entProp:SetMoveType(MOVETYPE_NONE)
			entProp:DrawShadow(false)
			entProp:SetKeyValue("spawnflags", 8)
			entProp.ObjectKey = intKey
			if game.SinglePlayer() && player.GetByID(1) && player.GetByID(1):IsValid() then
				SendUsrMsg("UD_UpdateWorldProp", player.GetByID(1), {intKey, entProp:GetModel(), entProp:GetPos(), entProp:GetAngles(), entProp})
			end
		end
		tblToUpdateProp.Model = entProp:GetModel()
		tblToUpdateProp.Postion = entProp:GetPos()
		tblToUpdateProp.Angle = entProp:GetAngles()
	else
		GAMEMODE:CreateWorldProp(strModel, vecPosition, angAngle)
	end
end




net.Receive( "c2s_CreateProp", function( l, p )     

	local strModel = net.ReadString()
	local vecPosition = net.ReadVector()
	local angAngle = net.ReadAngle()
	
	GAMEMODE:CreateWorldProp( strModel, vecPosition, angAngle )
	p:ChatPrint( "Created Prop" )
	

end)

net.Receive( "c2s_RemoveProp", function( l, p )     

	local intKey = net.ReadFloat()
	GAMEMODE:RemoveWorldProp(intKey)
	p:ChatPrint( "Removed Prop" )

end)


net.Receive( "c2s_CreateSpawnPoint", function( l, p )     

	local vecPosition = net.ReadVector()
	local angAngle = net.ReadAngle()
	local strNPC = net.ReadString()
	local intLevel = net.ReadFloat()
	local intSpawnTime = net.ReadFloat()
	p:ChatPrint( "Created SpawnPoint" )
	
	GAMEMODE:CreateSpawnPoint(vecPosition, angAngle, strNPC, intLevel, intSpawnTime)

end)

net.Receive( "c2s_RemoveSpawnPoint", function( l, p )     

	local intKey = net.ReadFloat()
	GAMEMODE:RemoveSpawnPoint(intKey)
	p:ChatPrint( "Removed SpawnPoint" )

end)


if SERVER then

	function GM:InitPostEntity()
	
		for _, pp in pairs ( ents.FindByClass( "prop_physics" ) ) do
			pp:Remove()
		end
		
		if luamap then
			if luamap[ string.lower( game.GetMap() ) ] then
				print( 'Luamap Loaded.' )
				pac.SpawnMapOutfit( luamap[ string.lower( game.GetMap() ) ] )
			else
				print( 'no luamap assaigned.' )
			end
		else
			print( 'NO LUAMAP!' )
		end
		
	end
	print( string.lower( game.GetMap() ) )
	function GM:LoadMapObjects()
		
		local strFileName = "underdone/maps/" .. game.GetMap() .. ".txt"
		if !file.Exists(strFileName, "DATA") then return end
		local tblDecodedTable = glon.decode(file.Read(strFileName, "DATA"))
		for _, SpawnPoint in pairs(tblDecodedTable.NPCSpawnPoints or {}) do
			GAMEMODE:CreateSpawnPoint(SpawnPoint.Postion, SpawnPoint.Angle or Angle(0, 90, 0), SpawnPoint.NPC, SpawnPoint.Level, SpawnPoint.SpawnTime)
		end
		for k, WorldProp in pairs(tblDecodedTable.WorldProps or {}) do
			timer.Simple(0.05 * k, function() GAMEMODE:CreateWorldProp(WorldProp.Model, WorldProp.Postion, WorldProp.Angle, nil, true) end)
		end
	end
	hook.Add("Initialize", "LoadMapObjects", function() GAMEMODE:LoadMapObjects() end)
	function GM:SaveMapObjects()
		print( ": Saved." )
		local strFileName = "underdone/maps/" .. game.GetMap() .. ".txt"
		local tblSaveTable = table.Copy(GAMEMODE.MapEntities)
		for _, SpawnPoint in pairs(tblSaveTable.NPCSpawnPoints or {}) do
			SpawnPoint.Monster = nil
			SpawnPoint.NextSpawn = nil
		end
		for _, WorldProp in pairs(tblSaveTable.WorldProps or {}) do
			WorldProp.Entity = nil
			WorldProp.SpawnProp = nil
		end
		file.Write(strFileName, glon.encode(tblSaveTable))
	end
	concommand.Add( "ud_savesex", function() GAMEMODE:SaveMapObjects() end)
	
	function GM:SpawnMapEntities()
		for _, Spawn in pairs(GAMEMODE.MapEntities.NPCSpawnPoints) do
			if !Spawn.Monster or !Spawn.Monster:IsValid() && #ents.FindByClass("npc_*") < 500 && !GAMEMODE.EventHasStarted then
				if !Spawn.NextSpawn then Spawn.NextSpawn = CurTime() + Spawn.SpawnTime end
				if Spawn.SpawnTime > 0 && CurTime() >= Spawn.NextSpawn then
					Spawn.Monster = GAMEMODE:CreateNPC(Spawn.NPC, Spawn)
					Spawn.NextSpawn = nil
				end
			end
		end
	end
	hook.Add("Tick", "SpawnMapEntities", function() GAMEMODE:SpawnMapEntities() end)

	function GM:CreateNPC(strNPC, tblSpawnPoint)
		local tblNPCTable = NPCTable(strNPC)
		if !tblNPCTable then return end
		if tblNPCTable.SpawnName == "npc_turret_floor" then return end
		local entNewMonster = ents.Create(tblNPCTable.SpawnName)
		if tblNPCTable.AdjustSpawn then
			entNewMonster:SetPos( tblSpawnPoint.Postion + tblNPCTable.AdjustSpawn )
		else
			entNewMonster:SetPos( tblSpawnPoint.Postion )
		end
		entNewMonster:Spawn()
		if tblNPCTable.Drops then
			entNewMonster:SetAngles( Angle(0, 90, 0) )
		else
			entNewMonster:SetAngles( tblSpawnPoint.Angle or Angle(0, 90, 0) )
		end
		entNewMonster:SetKeyValue("spawnflags","512")
		entNewMonster:DrawShadow(false)
		if tblNPCTable.PreInit then
			tblNPCTable.PreInit( entNewMonster )
		end
		if tblNPCTable.Weapon then
			entNewMonster:Give(tblNPCTable.Weapon )
			entNewMonster:SetKeyValue( "additionalequipment", tblNPCTable.Weapon)
			entNewMonster:SetKeyValue("spawnflags","8192")
		end
		if tblNPCTable.Accuracy then
			entNewMonster:SetCurrentWeaponProficiency( tblNPCTable.Accuracy )
		end
		if tblNPCTable.Model then
			entNewMonster:SetModel(tblNPCTable.Model)
		end
		if tblNPCTable.RealModel then
			entNewMonster:SetNWString( "m_realmodel", tblNPCTable.RealModel )
		end
		if tblNPCTable.Outfit then
			print( "111" )
			entNewMonster:SetNWString( "m_outfit", tblNPCTable.Outfit )
		end
		if tblNPCTable.Nextbot then
			entNewMonster:SetNWBool( "nextbot", true )
		end
		if tblNPCTable.Color then
			local r = tblNPCTable.Color[1]
			local g = tblNPCTable.Color[2]
			local b = tblNPCTable.Color[3]
			local a = tblNPCTable.Color[4]
			entNewMonster:SetColor(r,g,b,a)
		end
		if tblNPCTable.DeathDistance then
			for _, ent in pairs(ents.FindInSphere( tblSpawnPoint.Postion, tblNPCTable.DeathDistance )) do
				if IsValid(ent) && ent:IsPlayer() then
					ent:SetPos( ent:GetPos() + Vector( 0, 0, 80 ) )
				end
			end
		end
				
		if  tblNPCTable.Resistance then
			entNewMonster.Resistance = tblNPCTable.Resistance
		end
		entNewMonster.Name = tblNPCTable.Name
		entNewMonster.Position = tblSpawnPoint.Postion
		entNewMonster.Race = tblNPCTable.Race
		entNewMonster.Invincible = tblNPCTable.Invincible
		entNewMonster.Shop = tblNPCTable.Shop
		entNewMonster.Bank = tblNPCTable.Bank
		entNewMonster.Quest = tblNPCTable.Quest
		entNewMonster.Auction = tblNPCTable.Auction
		entNewMonster.Appearance = tblNPCTable.Appearance
		
		local intTotalFlags = 1 + 8192
		if tblNPCTable.Idle and !tblNPCTable.NextBot then
			entNewMonster:SetNPCState(NPC_STATE_IDLE)
			intTotalFlags = intTotalFlags + 16 + 128
		end
		entNewMonster:SetKeyValue("spawnflags", intTotalFlags)
		entNewMonster:SetNWString("npc", tblNPCTable.Name)
		local intLevel = math.Clamp(tblSpawnPoint.Level + math.random(-2, 2), 1, tblSpawnPoint.Level + 2)
		entNewMonster:SetNWInt("level", intLevel)
		local intHealth = intLevel * (tblNPCTable.HealthPerLevel or 10)
		entNewMonster:SetMaxHealth(intHealth)
		entNewMonster:SetNWInt("MaxHealth", intHealth)
		entNewMonster:SetHealth(intHealth)
		entNewMonster:SetNWInt("Health", intHealth)
		entNewMonster:Activate()
		if tblNPCTable.SpecialMove then
			if tblNPCTable.SetupMoveTable then
				tblNPCTable.SetupMoveTable( entNewMonster )
			end
			SpecialMoveNPC[ entNewMonster:EntIndex() ] = entNewMonster
		end
		return entNewMonster
	end
	
	function GM:bitEditor_Info2Client( ply )
		if self.bitEditor then
		
			net.Start( "s2c_SpawnPointTable")
				net.WriteTable( self.MapEntities.NPCSpawnPoints )
				net.WriteTable( self.MapEntities.WorldProps )
			net.Send(  ply )
			
			ply:ChatPrint( "Info Pushed to the Client" )
			
		end
	end
	
	concommand.Add( "bitEditor_Push", function( ply, args, cmd )
		GAMEMODE:bitEditor_Info2Client( ply )
	end)
	
end