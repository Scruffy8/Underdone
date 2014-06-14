local Player = FindMetaTable("Player")

function Player:HasSet(strSet)
	if !IsValid(self) then return false end
	local tblSetTable = EquipmentSetTable(strSet)
	if !tblSetTable then return false end
	for _, strItem in pairs(tblSetTable.Items or {}) do
		if !table.HasValue(self.Data.Paperdoll or {}, strItem) then return false end
	end
	return true
end

function Player:SetPaperDoll(strSlot, strItem)
	if !self or !self:IsValid() && !self:Alive() then return false end
	local tblItemTable = ItemTable(strItem) or {}
	self.Data = self.Data or {}
	self.Data.Paperdoll = self.Data.Paperdoll or {}
	if !strItem or self:GetSlot(strSlot) == strItem then
		if tblItemTable.Set && self:HasSet(tblItemTable.Set) then
			print( 1 )
			local tblSetTable = EquipmentSetTable(tblItemTable.Set)
			self:ApplyBuffTable(tblSetTable.Buffs, -1)
		end
		self.Data.Paperdoll[strSlot] = nil
		self:ApplyBuffTable(tblItemTable.Buffs, -1)
	else
		if self:GetSlot(strSlot) then
			if ItemTable(self:GetSlot(strSlot)).Set && self:HasSet(ItemTable(self:GetSlot(strSlot)).Set) then
				local tblSetTable = EquipmentSetTable(ItemTable(self:GetSlot(strSlot)).Set)
				self:ApplyBuffTable(tblSetTable.Buffs, -1)
			end
			self:ApplyBuffTable(ItemTable(self:GetSlot(strSlot)).Buffs, -1)
		end
		self.Data.Paperdoll[strSlot] = strItem
		if tblItemTable.Set && self:HasSet(tblItemTable.Set) then
			local tblSetTable = EquipmentSetTable(tblItemTable.Set)
			self:ApplyBuffTable(tblSetTable.Buffs)
		end
		self:ApplyBuffTable(tblItemTable.Buffs)
	end
	if SERVER then
		for strChkSlot, strChkItem in pairs(self.Data.Paperdoll or {}) do
			local tblSlotTable = GAMEMODE.DataBase.Slots[strChkSlot]
			if strChkSlot != strSlot && tblSlotTable.ShouldClear && tblSlotTable:ShouldClear(self, tblItemTable) then
				self:UseItem(strChkItem)
			end
		end
		SendUsrMsg("UD_UpdatePapperDoll", player.GetAll(), {self, strSlot, self:GetSlot(strSlot)})
		self:SaveGame()
	end
end

function Player:GetSlot(strSlot)
	if self.Data && self.Data.Paperdoll && self.Data.Paperdoll[strSlot] then return self.Data.Paperdoll[strSlot] end
	return
end

if SERVER then

		net.Receive( "c2s_RequestPaperdoll", function( len, sendto )
		
			local tblEquip = {}
			for _, ply in pairs( player.GetAll() ) do
					if sendto == ply then continue end
					
					tblEquip[ ply:EntIndex() ]  = {}
					for slot, name in pairs( GAMEMODE.DataBase.Slots ) do
							if ply:GetSlot( slot ) then
									tblEquip[ply:EntIndex()][slot] = ply:GetSlot( slot ) 
							end
					end
			end
			
			net.Start( "s2c_PushPaperdoll" )
				net.WriteTable( tblEquip )
			net.Send( sendto )
			
		end)

		hook.Add("PlayerInitialSpawn", "SpawnSound", function( ply )
			umsg.Start( "welcomeserver", ply )
			umsg.End()
		end)
		
	
end

if CLIENT then
								
	net.Start( "c2s_RequestPaperdoll" )
	net.SendToServer()
			
			
	usermessage.Hook( "welcomeserver", function()
			net.Start( "c2s_RequestPaperdoll" )
			net.SendToServer()
	end)
	
	hook.Add( "Think", "pac_joinpac", function()
		
		for k, npc in pairs( ents.FindByClass"npc_*" ) do
			
			if npc:GetNWString( "m_realmodel" ) != "" and !npc.Applied then
				npc.Applied = true
				pac.SetupENT( npc )
				local parent = math.random( 1, 200000 )
					local tbl = {
							[1] = {
							["children"] = {
								[1] = {
									["children"] = {
									},
									["self"] = {
										["ParentName"] = "my outfit",
										["UniqueID"] = math.random( 1, 200000 ),
										["Name"] = math.random( 1, 1000 ),
										["ClassName"] = "model",
										["BoneMerge"] = true,
										["GlobalID"] = math.random( 1, 200000 ),
										["ParentUID"] = parent,
										["Model"] = npc:GetNWString( "m_realmodel" ),
									},
								},
								[2] = {
									["children"] = {
									},
									["self"] = {
										["GlobalID"] = math.random( 1, 200000 ),
										["HideEntity"] = true,
										["UniqueID"] = math.random( 1, 200000 ),
										["ParentUID"] = parent,
										["Name"] = math.random( 1, 1000 ),
										["ClassName"] = "entity",
									},
								},
							},
							["self"] = {
								["ClassName"] = "group",
								["GlobalID"] = math.random( 1, 200000 ),
								["UniqueID"] = parent,
								["Name"] = math.random( 1, 1000 ),
							},
						},
					}	
				npc:AttachPACPart( tbl )
			end
			
			if npc:GetNWString( "m_outfit" ) != "" and !npc.Applied then
				npc.Applied = true
				pac.SetupENT( npc )
				npc:AttachPACPart( pac_luamodel[npc:GetNWString( "m_outfit" )] )
			end
			
		end
			
			
	end)
	
	-- 테이블 머지 순서
	-- 1. 테이블을 서버로부터 받는다.
	-- 2. 모든 플레이어를 임시 띵크 후크로 받는다.
	-- 3. 찾으면 그 플레이어가 장비를 바뀌어 꼈을경우에 있는 슬롯을 뺀다.
	-- 4. 그리고 입힌다.
	
	local t_plyOutfit = {}
	net.Receive( "s2c_PushPaperdoll", function() 
		local tblInfo = net.ReadTable()		
		t_plyOutfit = table.Copy( tblInfo )
		for _, p in pairs( player.GetAll() ) do
			pac.SetupENT( p )
		end
	end)
	
	hook.Add( "Think", "pac_playerapply", function()
		if #t_plyOutfit == 0 then hook.Remove( "Think", "pac_playerapply" ) return end
		for key, outfits in pairs( t_plyOutfit ) do
			local player = player.GetByID( key )
			if player:IsValid() then
				for slot, name in pairs( outfits ) do
					if LocalPlayer() == player then continue end
					GAMEMODE.PapperDollEnts[ key ] = GAMEMODE.PapperDollEnts[ key ]  or {}
					if !GAMEMODE.PapperDollEnts[ key ][ slot ] then
						GAMEMODE.PapperDollEnts[ key ][ slot ] = name
						local outfit = pac_luamodel[ name ]
						player:AttachPACPart( outfit )
						if slot == "slot_primaryweapon" then
							if player:GetActiveWeapon():IsValid() then
								local wep = player:GetActiveWeapon()
								local wepdat = GAMEMODE.DataBase.Items[ name ]
								wep:SetWeapon( ItemTable( name ) )
								wep:Initialize()
							end
						end
					end
				end	
				t_plyOutfit[ key ] = nil
			end
		end
	end)
		
	GM.PapperDollEnts = {}
	function UpdatePapperDollUsrMsg(usrMsg)
	

		if LocalPlayer() && !LocalPlayer().Data then LocalPlayer().Data = {} end
		if LocalPlayer() && LocalPlayer().Data && !LocalPlayer().Data.Paperdoll then LocalPlayer().Data.Paperdoll = {} end
	
		local plyPlayer = usrMsg:ReadEntity()
		if !IsValid(plyPlayer) then return end
		local strSlot = usrMsg:ReadString()
		local strItem = usrMsg:ReadString()
		if strItem == "" then strItem = nil end
		plyPlayer:SetPaperDoll(strSlot, strItem)
		plyPlayer:PapperDollBuildSlot(strSlot, strItem)
		if plyPlayer == LocalPlayer() && GAMEMODE.MainMenu then
			GAMEMODE.MainMenu.Inventory:LoadInventory()
		end
		
	end
	usermessage.Hook("UD_UpdatePapperDoll", UpdatePapperDollUsrMsg)
	
	function Player:PapperDollBuildSlot(strSlot, strItem)
		if !self:Alive() then return end
		GAMEMODE.PapperDollEnts[self:EntIndex()] = GAMEMODE.PapperDollEnts[self:EntIndex()] or {}
		local tblPlayerTable = GAMEMODE.PapperDollEnts[self:EntIndex()]
		tblPlayerTable = tblPlayerTable or {}
		
		local entPapperDollEnt = tblPlayerTable[strSlot]
	
			
		if strItem && strSlot then
		
			local tblItemTable = ItemTable(strItem)
			local tblSlotTable = SlotTable(strSlot)
			
			if tblItemTable && tblSlotTable then -- debug
				
				pac.SetupENT( self )
				
				local outfit = pac_luamodel[ GAMEMODE.PapperDollEnts[self:EntIndex()][strSlot] ]
			
				if outfit then
					self:RemovePACPart( outfit )
				end
				
				local outfit = pac_luamodel[ strItem ]
				if outfit then
					self:AttachPACPart( outfit )
				end
				
				self.curoutfit = strItem
				GAMEMODE.PapperDollEnts[self:EntIndex()][strSlot] = strItem -- un equip slot
			end
			
		else
			if strSlot then
				
				pac.SetupENT( self )
				local outfit = pac_luamodel[ GAMEMODE.PapperDollEnts[self:EntIndex()][strSlot] ]
				if outfit then
					self:RemovePACPart( outfit )
				end
					
				GAMEMODE.PapperDollEnts[self:EntIndex()][strSlot] = nil -- un equip slot
			end
		end
	end
end