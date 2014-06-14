local tblSharedFolders = {}
tblSharedFolders[1] = "underdone/gamemode/core/sharedfiles/"
tblSharedFolders[2] = "underdone/gamemode/core/sharedfiles/database/"
tblSharedFolders[3] = "underdone/gamemode/core/sharedfiles/database/items/"
tblSharedFolders[4] = "underdone/gamemode/core/sharedfiles/database/npcs/"
tblSharedFolders[5] = "underdone/gamemode/core/sharedfiles/database/quests/"
tblSharedFolders[6] = "underdone/gamemode/core/sharedfiles/database/shops/"
tblSharedFolders[7] = "underdone/gamemode/core/sharedfiles/database/skills/"
tblSharedFolders[8] = "underdone/gamemode/core/sharedfiles/database/stats/"
tblSharedFolders[9] = "underdone/gamemode/core/sharedfiles/database/recipes/"
tblSharedFolders[10] = "underdone/gamemode/core/sharedfiles/database/masters/"
tblSharedFolders[11] = "underdone/gamemode/core/sharedfiles/database/events/"

tblSharedFolders[11] = "underdone/gamemode/core/sharedfiles/database/models/"

local tblClientFolders = {}
tblClientFolders[1] = "underdone/gamemode/core/clientfiles/"
tblClientFolders[2] = "underdone/gamemode/core/clientfiles/menus/"
tblClientFolders[3] = "underdone/gamemode/core/clientfiles/vgui/"
tblClientFolders[4] = "underdone/gamemode/core/clientfiles/menutabs/"
tblClientFolders[5] = "underdone/gamemode/core/clientfiles/menutabs/helpmenu/"
tblClientFolders[6] = "underdone/gamemode/core/clientfiles/menutabs/auctionmenu/"

local tblServerFolders = {}
tblServerFolders[1] = "underdone/gamemode/core/serverfiles/"
tblServerFolders[2] = "underdone/gamemode/core/serverfiles/commands/"

if SERVER then

	function adddir( path )
		for _, file in pairs( file.Find( path, "GAME" )  ) do
			path = string.Replace( path , "*", "")
			resource.AddFile( path .. file )
			--print(  path .. "" .. file )
		end
	end
	
	local pathtbl = {
		"materials/face/*",
		"materials/icons/bt/*",
		"models/*",
		"materials/models/prowler/*",
	}
	for _, strPath in pairs( pathtbl ) do
		adddir( strPath )
	end
	
	
	local tblTotalFolder = {}
	table.Add(tblTotalFolder, tblSharedFolders)
	table.Add(tblTotalFolder, tblClientFolders)
	table.Add(tblTotalFolder, tblServerFolders)
	for _, path in pairs(tblTotalFolder) do
		for _, file in pairs(file.Find(path .. "*.lua", "LUA")) do
			if table.HasValue(tblClientFolders, path) or table.HasValue(tblSharedFolders, path) then
				AddCSLuaFile(path .. file)
			end
			if table.HasValue(tblSharedFolders, path) or table.HasValue(tblServerFolders, path)  then
				include(path .. file)
			end
		end
	end
	
	function resource.AddDir( dir, ext )
		local folder = string.Replace( GM.Folder, "gamemodes/", "" )
		for _, f in pairs( file.Find( folder.."/content/*" .. (ext or ""), "GAME" ) ) do
			resource.AddFile( dir .. "/" .. _ )
		end
	end
	
	resource.AddWorkshop(144908675)
	resource.AddWorkshop(119420070)
	
end

if !SERVER then

	local tblTotalFolder = {}
	table.Add(tblTotalFolder, tblSharedFolders)
	table.Add(tblTotalFolder, tblClientFolders)
	for _, path in pairs(tblTotalFolder) do
		for _, file in pairs(file.Find(path .. "*.lua", "LUA")) do
			include(path .. file)
		end
	end
	
end



