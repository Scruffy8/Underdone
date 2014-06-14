function newspawns()
	--GAMEMODE:CreateSpawnPoint(Vector(-1251.182983, 1233.241577, 3.827278), Angle(0, 90, 0), "rebel_smg", 1, 15)
end
hook.Add( "Initialize", "UD_NewSpawnTables", newspawns)



--[[GM:CreateWorldProp( strModel, vecPostion, angAngle )'
Example  GAMEMODE:CreateWorldProp( models/buggy.mdl, -1251.182983, 1233.241577, 3.827278, Angle(0, 90, 0) )

---GAMEMODE:CreateSpawnPoint(Vector(-1251.182983, 1233.241577, 3.827278), Angle(0, 90, 0), "rebel_smg", 1, 15)
 Get a area to spawn the NPC, Leave the angle as it is, pick a NPC from the database/npcs,  1 is spawntime, 15 is level of NPC
 
 Place everything in function newspawns!]]