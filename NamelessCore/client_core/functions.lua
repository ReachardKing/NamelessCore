
function NamelessCore.GetPlayers()
	return NamelessCore.players
end

function NamelessCore.GetCharacters()
    return NamelessCore.characters 
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