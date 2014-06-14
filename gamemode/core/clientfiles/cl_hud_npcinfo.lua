
	surface.CreateFont( "NPCDisp" ,
	{ font = "Arial Rounded MT",
	  size = 15,
	  weight = 1000,
	  antialias = true,
	  outline  = false,
	  shadow  = true,
	 } );
	 
local textfont = "NPCDisp"
local function DrawNPCIcon(entNPC, posNPCPos)
	local strIcon = "icon16/emoticon_smile.png"
	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(Material(strIcon))
	surface.DrawTexturedRect(posNPCPos.x, posNPCPos.y - 25, 16, 16)
end

local function DrawNameText(entNPC, posNPCPos, boolFriendly)
	local tblNPCTable = NPCTable(entNPC:GetNWInt("npc"))
	local intLevel = entNPC:GetNWInt("level")
	local plylevel = math.Clamp(LocalPlayer():GetLevel(),0,99999)
	local clrDrawColor = clrWhite
	if intLevel < plylevel then clrDrawColor = clrGreen end
	if intLevel > plylevel then clrDrawColor = clrRed end
	if boolFriendly then clrDrawColor = clrWhite end
	local strTitle = tblNPCTable.Title or ""
	if tblNPCTable.Shop then strTitle = ShopTable(tblNPCTable.Shop).PrintName end
	draw.SimpleTextOutlined(strTitle, textfont, posNPCPos.x, posNPCPos.y - 25, clrDrawColor, 1, 1, 1, clrDrakGray)

	local strDrawText = tblNPCTable.PrintName
	if !boolFriendly && !entNPC:IsBuilding() then strDrawText = strDrawText .. " lv. " .. intLevel end
	if tblNPCTable.Boss then
		draw.SimpleTextOutlined(strDrawText, textfont, posNPCPos.x, posNPCPos.y - 10, clrRed, 1, 1, 1, clrDrakGray)
	elseif !tblNPCTable.Boss then
		draw.SimpleTextOutlined(strDrawText, textfont, posNPCPos.x, posNPCPos.y - 10, clrDrawColor, 1, 1, 1, clrDrakGray)
	end
end

local function DrawNPCHealthBar(entNPC, posNPCPos)
	local clrBarColor = clrGreen
	local intHealth = math.Clamp(entNPC:GetNWInt("Health"),0,99999)
	local intMaxHealth = entNPC:GetNWInt("MaxHealth")
	if intHealth <= (intMaxHealth * 0.2) then clrBarColor = clrRed end
	local NpcHealthBar = jdraw.NewProgressBar()
	NpcHealthBar:SetDemensions(posNPCPos.x  - (80 / 2), posNPCPos.y, 80, 11)
	NpcHealthBar:SetStyle(4, clrBarColor)
	NpcHealthBar:SetBoarder(1, clrDrakGray)
	NpcHealthBar:SetText("UiBold", intHealth, clrDrakGray)
	NpcHealthBar:SetValue(intHealth, intMaxHealth)
	jdraw.DrawProgressBar(NpcHealthBar)
end

local function DrawNPCInfo()
	for _, ent in pairs(ents.GetAll()) do 
		if IsValid(ent) && ( ent:IsNPC() || ent:IsBuilding() || ent:GetNWBool( "nextbot" ) ) && ent:GetNWInt("level") > 0 then
			if ent:GetPos():Distance(LocalPlayer():GetPos()) < 500 then
				local tblNPCTable = NPCTable(ent:GetNWInt("npc"))
				if !tblNPCTable then return end
				local boolFriendly = tblNPCTable.Race == "human"
				local posNPCPos = (ent:GetPos() + Vector(0, 0, 80)):ToScreen()
				DrawNameText(ent, posNPCPos, boolFriendly)
				if !boolFriendly then DrawNPCHealthBar(ent, posNPCPos) end
			end
		end
	end
end
hook.Add("HUDPaint", "DrawNPCInfo", DrawNPCInfo)