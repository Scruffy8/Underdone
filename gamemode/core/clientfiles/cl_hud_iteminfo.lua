local grad = surface.GetTextureID( "sprites/glow04_noz" )
surface.CreateFont( "ItemDisp" ,
{ font = "BigNoodleTitling",
	 size = 25,
	 weight = 300,
	 antialias = true,
	 outline  = false,
 } );

local function DrawItemInfo()
	for _, ent in pairs(ents.FindByClass("prop_*")) do 
		if !IsValid(ent) then return end
		if ent:GetNWString("PrintName") && ent:GetNWInt("Amount") > 0 then
		
			if ent:GetPos():Distance(LocalPlayer():GetPos()) < 300 then
			
				local posENTpos = (ent:GetPos() + Vector(0, 0, 10)):ToScreen()
				local strText = ent:GetNWString("ItemName")
				local tblItemTable = ItemTable(strText)
				local DispText = tblItemTable.PrintName 
				if ent:GetNWInt("Amount") > 1 then DispText = DispText .. " x" .. ent:GetNWInt("Amount") end
				if ent:GetOwner() == LocalPlayer() or !IsValid(ent:GetOwner()) or LocalPlayer():IsInSquad(ent:GetOwner()) then
					if tblItemTable.ItemColor then
						ent:SetColor( tblItemTable.ItemColor )
						draw.SimpleTextOutlined(DispText, "ItemDisp", posENTpos.x, posENTpos.y - 10, tblItemTable.ItemColor, 1, 1, 1, clrDrakGray)
					else
						if tblItemTable.Slot or ( strText == "money" ) or tblItemTable.GainRecipes then
							draw.SimpleTextOutlined(DispText, "ItemDisp", posENTpos.x, posENTpos.y - 10, clrWhite, 1, 1, 1, clrDrakGray)
							ent:SetColor( Color(255, 255, 255, 255) )
						else
							draw.SimpleTextOutlined(DispText, "ItemDisp", posENTpos.x, posENTpos.y - 10, clrGray, 1, 1, 1, Color( 0, 0, 0 ))
							ent:SetColor( Color(100, 100, 100, 255) )
						end
					end
				else
					ent:SetColor( Color(255, 0, 0, 0) ) 
				end
				
			end
			
		end
		
	
	local dist = ent:GetPos():Distance(LocalPlayer():GetPos())
	if dist < 400 then
		for _,info in pairs(GAMEMODE.QuestObject) do 
			if ent:GetModel() == info.Model then
				local posENTpos = (ent:GetPos() + Vector(0, 0, info.Height)):ToScreen()
				draw.SimpleTextOutlined(info.PrintName, "NPCDisp", posENTpos.x, posENTpos.y, Color( 255, 255, 255, math.Clamp( ( 400 - dist ), 0, 255 )  ), 1, 1, 1, clrDrakGray)
			end
		end
	end
	
end	
end
hook.Add("HUDPaint", "DrawItemInfo", DrawItemInfo)