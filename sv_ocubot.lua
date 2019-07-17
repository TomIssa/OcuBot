local parameters = {}
local DEBUG = false
local StaffRoll = "Staff on duty"
local PollRate = 10
local Repeat = 0

--[[Player IDs]]--
local User = 0
local Staff = 1
local OnDuty = 2

-- Keyed list of ULX rolls that are not active duty Staff roles -- true = not staff
local Staff = {
		[ 'founder'] = true,
		[ 'superadmin' ] = true,
		[ 'servermanager' ] = true,
		[ 'staffmanager' ] = true,
		[ 'head admin' ] = true,
		[ 'trusted-donator' ] = true,
		[ 'trusted' ] = true,
		[ 'donator' ] = true,
		[ 'user' ] = true
	}


local function Collectinfo()
	-- Clear tables to default
	local Players = {} -- Array of all players
	local serverinfo = {Pcount = 0, staffcount = 0, SoD = 0} -- Server object
	local Player = {Name = '', Steam = '', ID = User} -- Player object
	
	
	-- Iterate through all players, collect data and instert to Players table
	for _, ply in pairs( player.GetAll() ) do
		Player.Name = ply:Nick() -- get ingame name
		Player.Steam = ply:SteamID() -- get Steam ID
		
		if not Staff[ply:GetNWString("usergroup")] then 
			Player.ID = Staff
			serverinfo.staffcount = serverinfo.staffcount + 1
		end
		
		if team.GetName(ply:Team()) == StaffRoll then
			Player.ID = OnDuty
			serverinfo.SoD = serverinfo.SoD + 1
		end
		
		table.insert(Players, Player)
	end
	serverinfo.Pcount = #Players
	
	-- Debug mode printouts
	if DEBUG then
		print.table(Players)
	end
end

-- Timer controls rate of collection and reporting
timer.Create( "BotInfo", PollRate, Repeat, Collectinfo())
