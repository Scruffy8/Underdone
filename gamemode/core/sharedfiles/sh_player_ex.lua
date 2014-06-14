local Player = FindMetaTable("Player")

function Player:IsMelee()
	if ItemTable(self:GetSlot("slot_primaryweapon")) then
		return ItemTable(self:GetSlot("slot_primaryweapon")).Melee
	end
	return
end

function Player:GetActiveAmmoType()
	if ItemTable(self:GetSlot("slot_primaryweapon")) && ItemTable(self:GetSlot("slot_primaryweapon")).AmmoType then
		return ItemTable(self:GetSlot("slot_primaryweapon")).AmmoType
	end
	return
end

function Player:IsDonator()
	if self:IsUserGroup("donator") then
		return true
	else
		return false
	end
end

function Player:GetMaximumHealth()
	return self:GetStat("stat_maxhealth")
end

function Player:GetMaxWeight()
	return self:GetStat("stat_maxweight")
end

function Player:GetArmorRating()
	local intTotalArmor = 1
	if !self.Data then return end
	for strSlot, strItem in pairs(self.Data.Paperdoll or {}) do
		local tblItemTable = ItemTable(strItem)
		if tblItemTable && tblItemTable.Armor then
			intTotalArmor = intTotalArmor + tblItemTable.Armor
		end
	end
	return intTotalArmor
end

if CLIENT then
	function Player:FollowPlayer(args)
		if !args then return end
		if !args[1] then return end
		LocalPlayer().SFollowing = false
		local function Follow()
			local OtherPlayer = ents.GetByIndex(args[1])
			if IsValid(OtherPlayer) then
				if LocalPlayer():GetPos():Distance(OtherPlayer:GetPos()) > 80 then
					local AimVec = OtherPlayer:GetPos() - LocalPlayer():GetPos()
					LocalPlayer():SetEyeAngles(AimVec:Angle())
					RunConsoleCommand("+forward")
				elseif LocalPlayer():GetPos():Distance(OtherPlayer:GetPos()) < 80 then
					RunConsoleCommand("-forward")
				end
				if LocalPlayer():KeyPressed( IN_FORWARD ) || LocalPlayer():KeyPressed( IN_MOVELEFT ) || LocalPlayer():KeyPressed( IN_MOVERIGHT ) || LocalPlayer():KeyPressed( IN_BACK ) then
					LocalPlayer():StopFollowing()
				end
				LocalPlayer().IsFollowingPlayer = true
				if LocalPlayer().SFollowing then return end
				timer.Simple(0.1, Follow, args[1])
			end
		end
		Follow()
	end
	concommand.Add("UD_FollowPlayer", function(ply, command, args) ply:FollowPlayer(args) end)

	function Player:StopFollowing()
		if LocalPlayer().IsFollowingPlayer then
			LocalPlayer().SFollowing = true
			RunConsoleCommand("-forward")
			LocalPlayer().IsFollowingPlayer = false
		end
	end
	concommand.Add("UD_StopFollowingPlayer", function(ply, command, args) ply:StopFollowing() end)
end

if SERVER then

	function Player:SkillReset()
		if self:HasItem("money", 1000) then
			for skill,lvl in pairs(self.Data.Skills or {}) do
				if lvl > 0 then
					self:SetSkill(skill, 0)
				end
			end
			self:RemoveItem("money", 1000)
			self:SetNWInt("SkillPoints", self:GetDeservedSkillPoints())
			self:SaveGame()
		end
	end
	concommand.Add("UD_ResetSkills", function(ply, command, args) ply:SkillReset() end)

	local intSec = 2
	function Player:SearchQuestProp(Ent, strModel, strItem, strAmount)
		if !IsValid(Ent) then return end
		if Ent:GetModel() == strModel then
			if self:QuestItem(strItem) then
				local tblItemTable = ItemTable(strItem)
				self:CreateNotification("Searching")
				self:ConCommand( 'UD_AddProgressBar "Searching Object" '.. intSec )
				self:Freeze( true ) 
				timer.Simple(intSec, function()
					self:CreateNotification("Found " .. tblItemTable.PrintName)
					self:AddItem(strItem, strAmount)
					self:Freeze( false )
				end)
			end
		end
	end
	
	local tblComplements = {}
	tblComplements[1] = "Holy_Shit_Your_Cool"
	tblComplements[2] = "Nice_Man!"
	tblComplements[3] = "You_Are_Epic!"
	tblComplements[4] = "I_Wish_I_Was_As_Cool_As_You!"
	tblComplements[5] = "I_Jizzed!"
	tblComplements[6] = "Gratz!"
	tblComplements[7] = "I_Just_Shat_My_Pants!"
	tblComplements[8] = "Call_Me!"
	tblComplements[9] = "You_Should_Model!"
	tblComplements[10] = "God_Damn_I_Love_You!"
	tblComplements[11] = "You_Make_Me_Hot"
	tblComplements[12] = "I_Wish_I_Could_Touch_You"
	tblComplements[13] = "You_Now_With_10%_More_Cowbell"
	tblComplements[14] = "My_Girlfriend_Left_Me_For_You"
	tblComplements[15] = "Lets_Make_Party"
	local tblColors = {}
	tblColors[1] = "purple"
	tblColors[2] = "blue"
	tblColors[3] = "orange"
	tblColors[4] = "red"
	tblColors[5] = "green"
	tblColors[6] = "white"
	function Player:GiveExp(intAmount, boolShowExp)
		local PlayerExp = tonumber(self:GetNWInt("exp")) or 0
		local intCurrentExp = PlayerExp
		local intPreExpLevel = self:GetLevel()
		local intAmount = tonumber(intAmount)
		--Player:GiveExp(-3000000);
		if intCurrentExp + intAmount >= 0 then
			local intTotal = math.Clamp(intCurrentExp + intAmount, toExp(intPreExpLevel), intCurrentExp + intAmount)
			self:SetNWInt("exp", tonumber(intTotal))
			if boolShowExp then
				self:CreateIndacator("+_" .. intAmount .. "_Exp", self:GetPos() + Vector(0, 0, 70), "green")
			end
			--if exp < 0 then exp = 0 end
			local intPostExpLevel = self:GetLevel()
			if intPreExpLevel < intPostExpLevel then
				
				self:CreateIndacator( "Level_Up!", self:GetPos() + Vector( 0, 0, 70 ), "green" , true)
				local effectdata2 = EffectData()
					effectdata2:SetStart( self :GetPos())
					effectdata2:SetOrigin( self:GetPos())
					effectdata2:SetNormal( Vector( 0, 0, 1 ) )
					effectdata2:SetScale( 2 )
				util.Effect("levelup", effectdata2)
				self:EmitSound( "blacktea/levelup.wav" )
	
				hook.Call("UD_Hook_PlayerLevelUp", GAMEMODE, self, intPostExpLevel - intPreExpLevel)
				self:SetHealth(self:GetMaximumHealth())
				for i = 1, 3 do
					self:CreateIndacator(tblComplements[math.random(1, #tblComplements)], self:GetPos() + Vector(0, 0, 70), tblColors[math.random(1, #tblColors)], true)
				end
			end
		end
	end
	
	function GM:PlayerDeath(victim, weapon, killer)
		--self:GetNWInt( exp, exp - 300)
		victim:Freeze(true)
		if victim.tblSkillCool then
			for k, v in pairs ( victim.tblSkillCool ) do
				victim.tblSkillCool[ k ] = CurTime()
			end
		end
		
		timer.Simple(10, function()
			if IsValid(victim) then
				victim:Freeze(false)
				victim:ConCommand("+attack")
				timer.Simple(0.1, function() if IsValid(victim) then victim:ConCommand("-attack") end end)
			end
		end)
		if killer:IsNPC() && victim:IsPlayer() then
			if killer.Race == victim.Race then
				killer:AddEntityRelationship(victim, GAMEMODE.RelationLike, 99)
			end
		end
	end
	
	local function PlayerAdjustDamage(entVictim, tblDamageInfo)
		local entInflictor = tblDamageInfo:GetInflictor()
		local entAttacker = tblDamageInfo:GetAttacker()
		local intAmount	= tblDamageInfo:GetDamage()
		if !entVictim:IsPlayer() then return end
		if !entAttacker:IsPlayer() && entAttacker:GetOwner():IsPlayer() then
			entAttacker = entAttacker:GetOwner()
		end
		
		local clrDisplayColor = "red"
		local tblNPCTable = NPCTable(entAttacker:GetNWString("npc"))
		if entAttacker:IsPlayer() and entAttacker:GetInfoNum( "ud_pvp", 0 ) == 1 and entVictim:GetInfoNum( "ud_pvp", 0 ) == 1 then 
			if entAttacker == entVictim then 
				tblDamageInfo:SetDamage(0)
			end
		else
			tblDamageInfo:SetDamage(0)
		end
		if tblNPCTable then
			for strNPC,_ in pairs(GAMEMODE.DataBase.NPCs or {}) do
				local tblNPCTable = NPCTable(strNPC)
				if tblNPCTable.DamageCallBack && entVictim && entAttacker.Name && entAttacker.Name ==  tblNPCTable.Name then
					tblNPCTable:DamageCallBack(entAttacker, entVictim)
				end
			end
			tblDamageInfo:SetDamage((tblNPCTable.DamagePerLevel or 0) * entAttacker:GetNWInt("level"))
			tblDamageInfo:SetDamage(tblDamageInfo:GetDamage() * (1 / (((entVictim:GetArmorRating() - 1) / 10) + 1)))
			tblDamageInfo:SetDamage( melee_ironskin( entVictim, tblDamageInfo:GetDamage() ) )
			tblDamageInfo:SetDamage( melee_berserk( entVictim, tblDamageInfo:GetDamage() ) )
			if entVictim.DefensiveBuff then
				tblDamageInfo:SetDamage( tblDamageInfo:GetDamage() - ( tblDamageInfo:GetDamage() * 0.05 * entVictim.DefensiveBuff ) ) 
			end
			
			tblDamageInfo:SetDamage(math.Clamp(math.Round(tblDamageInfo:GetDamage() + math.random(-1, 1)), 0, 9999))
			
			if tblNPCTable.Race == "human" then tblDamageInfo:SetDamage(0) end
			
			if tblDamageInfo:GetDamage() > 0 then
				entVictim:CreateIndacator(tblDamageInfo:GetDamage(), entVictim:GetPos() + Vector( 0, 0, 40 ), clrDisplayColor)
			else
				entVictim:CreateIndacator("Miss!", tblDamageInfo:GetDamagePosition(), "orange")
			end
			
		end		
	end
	hook.Add("EntityTakeDamage", "PlayerAdjustDamage", PlayerAdjustDamage)

	
	
	
	
	------------------------------------
	local function broadcastText( strText )
		for k,v in pairs( player.GetAll() ) do
			v:ChatPrint( strText )
		end
	end
	
	local function calcLoots( intDice, tblLoot, plyPlayer, bdcast )
		local dice = math.random( intDice[1], intDice[2] )
		for name, data in pairs( tblLoot ) do
					
			if ( ( !data.chance[ 1 ] || dice >= data.chance[ 1 ]  ) && ( !data.chance[ 2 ] || dice <= data.chance[ 2 ] ) ) then 
					local amt = math.random( data.amount[1], data.amount[2] )
					plyPlayer:EmitSound(  "HL1/fvox/bell.wav" )
					
					local tblItemTable = ItemTable( name )
					if bdcast then
						broadcastText( plyPlayer:Name() .. " <== " .. tblItemTable.PrintName .. " x " .. amt .. "( test func )" )
					else
						plyPlayer:AddItem( name )
					end
					
				break;
			end
			
		end
		
	end
	
    function Player:SearchWorldProp(Ent)	
		if !IsValid(Ent) then return end
		local tblLoot = LootTable( string.lower( Ent:GetModel() ) )
		if tblLoot then
			local strMdl = Ent:GetModel()
			local intDice = tblLoot.Loot.dice
			local tblChance = tblLoot.Loot.loot
			local intSec = tblLoot.Option.timetoopen or 3
			local strKey = tblLoot.Option.key
			if strKey then
				if !self:HasItem( strKey ) then
					self:ChatPrint( "You don't have the key to open this." )
					return 
				else
					self:RemoveItem( strKey, 1 )
					self:ChatPrint( "You have used the key." )
				end
			end
			if !Ent.IsBeingSearched then
			
				self:ConCommand( 'UD_AddProgressBar "Searching Object" '.. intSec )
				Ent.IsBeingSearched = true
				self:Freeze( true )
				timer.Simple(intSec, function()
					if tblLoot.Option.change then
						Ent:EmitSound( Sound("items/ammocrate_open.wav") )
						Ent:SetModel( tblLoot.Option.change )
						calcLoots( intDice, tblChance, self, true )
					else
						self:Freeze( false )
						Ent.IsBeingSearched = false
						calcLoots( intDice, tblChance, self )
					end
				end)
				
				timer.Simple(intSec + 1, function()
					if IsValid(self) then
						self:Freeze( false )
						Ent.IsBeingSearched = false
						if tblLoot.Option.change then
							Ent:EmitSound( Sound("items/ammocrate_close.wav") )
							Ent:SetModel( strMdl )
						end
					end
				end)
			end
			
		end
	end
	
end


------------------ DEVEL

if SERVER then

	hook.Add("PlayerInitialSpawn", "SpawnSound", function( ply )
		if ply:SteamID() == "STEAM_0:0:49573971" then
			umsg.Start( "deploymusic" )
			umsg.End()	
		end
	end)

else
	
	usermessage.Hook( "deploymusic", function()
		local url = "http://112.149.126.146:1337/your_team_won.mp3"
		sound.PlayURL( url , "mono", function(a) end)
		chat.AddText( Color( 255, 0, 0 ) , "Developer Fluffy Puncakes has entered the game.")
		chat.AddText( Color( 255, 0, 0 ) , "(OLD DEV) Black Tea")
	end)
	
end



	-- ALL ABOUT GAMBLES
