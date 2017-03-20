local Player = FindMetaTable("Player")

function Player:AddStat(strStat, intAmount)
	self.Stats = self.Stats or {}
	if intAmount != 0 then
		local intDirection = math.abs(intAmount) / intAmount
		self:SetStat(strStat, self:GetStat(strStat) + (intDirection * math.ceil(math.abs(intAmount))))
	end
end

util.AddNetworkString( 'ud_pl.syncstat' );
function Player:SetStat(strStat, intAmount)
	local tblStatTable = GAMEMODE.DataBase.Stats[strStat]
	self.Stats = self.Stats or {}
	local intOldStat = self.Stats[strStat] or 1
	self.Stats[strStat] = intAmount
	if SERVER then
		if tblStatTable.OnSet then
			tblStatTable:OnSet(self, intAmount, intOldStat)
		end
		net.Start( 'ud_pl.syncstat' )
			net.WriteString( strStat );
			net.WriteInt( intAmount, 32 );
		net.Send( self );
	end
end

function Player:GetStat(strStat)
	self.Stats = self.Stats or {}
	if self.Stats && self.Stats[strStat] then
		return self.Stats[strStat]
	end
	return StatTable(strStat).Default
end

if SERVER then
	hook.Add("PlayerSpawn", "PlayerSpawn_Stats", function(ply)
		for name, stat in pairs(GAMEMODE.DataBase.Stats) do
			if ply.Stats then
				ply:SetStat(name, ply:GetStat(name))
				if stat.OnSpawn then
					stat:OnSpawn(ply, ply:GetStat(name))
				end
			end
		end
		ply:AddStat("stat_agility", ply.ToMakeUpAgility or 0)
		ply.ToMakeUpAgility = 0
	end)
end

if CLIENT then
	net.Receive( 'ud_pl.syncstat', function( )
		LocalPlayer():SetStat(net.ReadString(), net.ReadInt(32));
	end);
end
