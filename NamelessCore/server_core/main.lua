
NamelessCore = {}
NamelessCore.players = {}
PlayersInfo = {}
local tempPlayersInfo = {}

function GetIdentifier(src)
	local thislist = {}
	
	for i = 0, GetNumPlayerIdentifiers(src) do
		local thisidentifiers = GetPlayerIdentifier(src, i)
		
		if thisidentifiers then
			local midle = thisidentifiers:find(":")
			local thisidentifiertype = thisidentifiers:sub(1, midle-1)
			thislist[thisidentifiertype] = thisidentifiers
		end
	end
end	

AddEventHandler("playerJoining", function(oldId)
    local src = source
    local oldTempId = tonumber(oldId)
    PlayersInfo[src] = tempPlayersInfo[oldTempId]
    tempPlayersInfo[oldTempId] = nil

    Wait(3000)

    local characters = NamelessCore.FetchAllCharacters(src)
    local id = next(characters)
    if id then
        return NamelessCore.SetActiveCharacter(src, id)
    end

    local player = NamelessCore.newCharacter(src, {
        firstname = GetPlayerName(src),
        lastname = "",
        dob = "",
        gender = ""
    })
    NamelessCore.SetActiveCharacter(src, player.id)
end)

-- MySQL.ready(function()
--         namelessCore.loadsql({
--             "client/character.sql",
--             "client/vehicles.sql"
--         }, resourceName)
-- end)