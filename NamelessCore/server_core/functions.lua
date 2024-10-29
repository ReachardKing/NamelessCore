function NamelessCore.GetCurrenttPlayers(src)
	return NamelessCore.players[src]
end

function NamelessCore.GetCurrenttPlayers(key, value, arry)
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