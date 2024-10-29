
function NamelessCore.GetPlayer()
    return NamelessCore.player
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