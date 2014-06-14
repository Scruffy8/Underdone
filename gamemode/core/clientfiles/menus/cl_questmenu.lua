GM.QuestMenu = nil
PANEL = {}
PANEL.Frame = nil
PANEL.QuestList = nil
PANEL.QuestDescription = nil
PANEL.ItemIconSize = 39

function PANEL:Init()
	self.Frame = CreateGenericFrame("Quest Menu", false, true)
	self.Frame.btnClose.DoClick = function(btn)
		self:SetPos( -self.Frame:GetWide(), self.Frame:GetTall() )
		GAMEMODE.QuestMenu.Frame:Close()
		GAMEMODE.QuestMenu = nil
	end
	self.Frame:MakePopup()
	
	self.QuestList = CreateGenericList(self.Frame, 2, false, true)
	self.QuestDescription = CreateGenericList(self.Frame, 5, false, true)
	self.QuestDescription:SetSpacing(1)
	
	self:PerformLayout()
end

function PANEL:LoadQuests(tblQuests)
	tblQuests = self.QuestTable or tblQuests
	self.QuestTable = tblQuests
	self.QuestList:Clear()
	for _, strQuest in pairs(tblQuests) do
		local tblQuestTable = QuestTable(strQuest)
		if !tblQuestTable.QuestNeeded or (tblQuestTable.QuestNeeded && LocalPlayer():HasCompletedQuest(tblQuestTable.QuestNeeded)) then
			local ltmQuest = vgui.Create("FListItem")
			ltmQuest:SetHeaderSize(20)
			ltmQuest:SetFont("UiBold")
			ltmQuest:SetNameText(tblQuestTable.PrintName)
			ltmQuest:SetDescText("level " .. tblQuestTable.Level .. "+")
			ltmQuest.DoClick = function() self:SellectQuest(strQuest) end
			if LocalPlayer():CanAcceptQuest(strQuest) then
				ltmQuest:AddButton("gui/accept", "Accept Quest", function() RunConsoleCommand("UD_AcceptQuest", strQuest) end)
			else
				if LocalPlayer():GetQuest(strQuest) then
					if ( LocalPlayer():GetQuest(strQuest).Done && !tblQuestTable.Repeat ) then
						ltmQuest:SetDescText(langopt[lang_cur].qust_completed)
					else
						if LocalPlayer():CanTurnInQuest(strQuest) then
							ltmQuest:AddButton("gui/arrow_in", "Turn In Quest", function()
								RunConsoleCommand("UD_TurnInQuest", strQuest)
								self:SellectQuest(strQuest)
								if !self.Pressed then
									self.Pressed = true
									timer.Simple( .1, function() self:LoadQuests( self.tblQuests ) self.Pressed = false end)
								end
							end)
						else
							local btnTurnInButton = ltmQuest:AddButton("gui/arrow_in", "Can't Turn In Quest", function() end)
							btnTurnInButton:SetAlpha(100)
						end
					end
				else
					--ltmQuest.DoClick = function() end
					ltmQuest:SetAlpha(100)
				end
			end
			self.QuestList:AddItem(ltmQuest)
		end
	end
end

function PANEL:SellectQuest(strQuest)
	self.QuestDescription:Clear()
	local tblQuestTable = QuestTable(strQuest)
	local tblPlayerQuestTable = LocalPlayer():GetQuest(strQuest) or {}
	if !tblQuestTable or !tblPlayerQuestTable then return end
	self.QuestDescription:AddItem(CreateGenericLabel(nil, "MenuLarge", tblQuestTable.PrintName, clrWhite))
	self.QuestDescription:AddItem(CreateGenericLabel(nil, nil, tblQuestTable.Story, clrDrakGray))
	if tblPlayerQuestTable.Done && tblQuestTable.TurnInStory then
		self.QuestDescription:AddItem(CreateGenericLabel(nil, nil, tblQuestTable.TurnInStory, clrDrakGray))
	end
	for strNPC, intAmount in pairs(tblQuestTable.Kill or {}) do
		local tblNPCTable = NPCTable(strNPC)
		local tblKillTable = tblPlayerQuestTable.Kills or {}
		local intKillsGot = tblKillTable[strNPC] or 0
		local strText = Format( langopt[lang_cur].qust_kill, tblNPCTable.PrintName, math.Clamp(intKillsGot, 0, intAmount), intAmount )  
		if tblPlayerQuestTable.Done or intKillsGot >= intAmount then strText = strText .. langopt[lang_cur].qust_done end
		self.QuestDescription:AddItem(CreateGenericLabel(nil, nil, strText, clrDrakGray))
	end
	for strItem, intAmount in pairs(tblQuestTable.ObtainItems or {}) do
		local tblItemTable = ItemTable(strItem)
		local intItemsGot = LocalPlayer():GetItem(strItem) or 0
		local strText = Format( langopt[lang_cur].qust_get, tblItemTable.PrintName, math.Clamp(intItemsGot, 0, intAmount), intAmount ) 
		if tblPlayerQuestTable.Done or intItemsGot >= intAmount then strText = strText .. langopt[lang_cur].qust_done end
		self.QuestDescription:AddItem(CreateGenericLabel(nil, nil, strText, clrDrakGray))
	end
	self.QuestDescription:AddItem(CreateGenericLabel(nil, nil, "/n Rewards:", clrDrakGray))
	if tblQuestTable.GainedExp or 0 > 0 then
		if tblQuestTable.AdjustExp then
			self.QuestDescription:AddItem(CreateGenericLabel(nil, nil, get_realexp( tblQuestTable.Level, LocalPlayer():GetLevel(), tblQuestTable.GainedExp ) .. " Exp", clrDrakGray))
		else
			self.QuestDescription:AddItem(CreateGenericLabel(nil, nil, tblQuestTable.GainedExp .. " Exp", clrDrakGray))
		end
	end
	local lstItemReward = nil
	for strItem, intAmount in pairs(tblQuestTable.GainedItems or {}) do
		if !lstItemReward then
			lstItemReward = CreateGenericList(nil, 1, true, false)
			lstItemReward:SetTall(self.ItemIconSize + 2)
			lstItemReward.Paint = function() end
			self.QuestDescription:AddItem(lstItemReward)
		end
		local tblItemTable = ItemTable(strItem)
		local icnItem = vgui.Create("FIconItem")
		icnItem:SetSize(self.ItemIconSize, self.ItemIconSize)
		icnItem:SetItem(tblItemTable, intAmount, "")
		icnItem:SetDragable(false)
		lstItemReward:AddItem(icnItem)
	end
	
	self.QuestDescription:InvalidateLayout()
end

function PANEL:PerformLayout()
	self.Frame:SetPos(self:GetPos())
	self.Frame:SetSize(self:GetSize())
	
	self.QuestList:SetPos(5, 25)
	self.QuestList:SetSize(self.Frame:GetWide() * 0.4, self.Frame:GetTall() - 30)
	self.QuestDescription:SetPos(self.QuestList:GetWide() + 10, 25)
	self.QuestDescription:SetSize(self.Frame:GetWide() - self.QuestList:GetWide() - 15, self.Frame:GetTall() - 30)
end
vgui.Register("questmenu", PANEL, "Panel")

concommand.Add("UD_OpenQuestMenu", function(ply, command, args)
	local npc = ply:GetEyeTrace().Entity
	local tblNPCTable = NPCTable(npc:GetNWString("npc"))
	if !IsValid(npc) or !tblNPCTable or !tblNPCTable.Quest then return end
	GAMEMODE.QuestMenu = GAMEMODE.QuestMenu or vgui.Create("questmenu")
	GAMEMODE.QuestMenu:SetSize(525, 320)
	GAMEMODE.QuestMenu:Center()
	GAMEMODE.QuestMenu.tblQuests = NPCTable(args[1]).Quest
	GAMEMODE.QuestMenu:LoadQuests( GAMEMODE.QuestMenu.tblQuests )
end)