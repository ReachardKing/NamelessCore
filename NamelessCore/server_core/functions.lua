function NamelessCore.GetCurrentPlayers(src)
	return NamelessCore.players[src]
end

function NamelessCore.GetCurrentPlayers(key, value, arry)
	if not key or not value then return end
	
	local players = {}
	local keytypes = {id = id, firstName = "firstName", lastName = "lastName", gender = "gender"}
	
	local findby = keytypes[key] or "metadata"
	
	if findby then
		for src, info in pairs(NamelessCore.players) do
			if findby == "metadata" and info["metadata"][key] == value or info[findby] == value then
				if arry then
					players[#players+1] = info
				else
					players[src] = info
				end
			end
		end
	end
	return players
end

function NamelessSQL(resource, filelocation)
	local resourceName = resource or GetInvokingResource() or  GetCurrentResourceName()

    if type(filelocation) == "string" then
        local file = LoadResourceFile(resourceName, filelocation)
        if not file then return end
        MySQL.query(file)
        return true
    end
    
    for i=1, #filelocation do
        local file = LoadResourceFile(resourceName, filelocation[i])
        if file then
            MySQL.query(file)
            Wait(100)
        end
    end
    return true
end

function GetPlayersServerInfo(src)
	return PlayersInfo[src]
end

function GetConfig(info)
	if not info then
		return config
	else
		return config[info]
	end
end

for name, func in pairs(NamelessCore) do
	if type(func) == "function" then
		exports(name, func)
	end
end