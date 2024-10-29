
NamelessCore = {}
NamelessCore.player = {}
PlayersInfo = {}

function GetServerobjects()
    return NamelessCore
end

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

    local characters = NamelessCore.FeatchAllCharacters(src)
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

function removeCharacter(character)
    local new = {}

    for k, v in pairs(character) do
        if type(v) ~= " " then
            new = v
        end
    end
end 

function CreateCharacterTables(info)
    local PlayerInfo = PlayersInfo[info.source] or {}

    local self = {
        id = info.id,
        sourcee = info.source,
        identifier = info.identifier,
        identifiers = info.identifiers,
        discord = info.discord or {},
        name = info.name,
        firstName = info.firstName,
        lastName = info.lastName,
        fullname = ("%s %s"):format(info.firstname, info.lastname),
        dob = info.dob,
        gender = info.gender,
        job = job or info.department,
        rank = info.rank, 
        callsign = info.callsign,
        cash = info.cash,
        bank = info.bank,
        metadata = info.metadata,
        inventory = info.inventory
    }

    return self
end 

function NamelessCore.newCharacter(src, info)
    local identifier = GetPlayerIdentifierByType(src, Config.characterIdentifier)
    if not identifier then return end

    local charInfo = {
        source = src,
        identifier = identifier,
        name = ("%s %s"):format(info.firstname) or "",
        firstname = info.firstname or "",
        lastname = info.lastname or "",
       fullname = ("%s %s"):format(info.firstname, info.lastname),
        dob = info.dob or "",
        gender = info.gender or "",
        cash = info.cash or 0,
        bank = info.bank or 0,
        phonenumber = info.phonenumber,
        metadata = info.metadata or {},
        inventory = info.inventory or {}
    }

    charInfo.id = MySQL.insert.await("INSERT INTO nd_characters (identifier, name, firstname, lastname, dob, gender, cash, bank, phonenumber, metadata, inventory) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", {
        identifier,
        charInfo.name,
        charInfo.firstname,
        charInfo.lastname,
        charInfo.fullname = ("%s %s"):format(info.firstname, info.lastname),
        charInfo.dob,
        charInfo.gender,
        charInfo.cash,
        charInfo.bank,
        charInfo.phonenumber,
        json.encode(charInfo.metadata),
        json.encode(charInfo.inventory)
    })

    return CreateCharacterTables(charInfo)
end

function NamelessCore.FeatchCharacters(id, src)
    local result
    if src then
        result = MySQL.query.await("SELECT * FROM nd_characters WHERE charid = ? and identifier = ?", {id, GetPlayerIdentifierByType(src, Config.characterIdentifier)})
    else
        result = MySQL.query.await("SELECT * FROM nd_characters WHERE charid = ?", {id})
    end

    if not result then return end
    local info = result[1]
    return CreateCharacterTables({
        source = src,
        id = info.charid,
        identifier = info.identifier,
        name = info.name,
        firstname = info.firstname,
        lastname = info.lastname,
        fullname = ("%s %s"):format(info.firstname, info.lastname),
        dob = info.dob,
        gender = info.gender,
        job = job or info.department,
        rank = info.rank, 
        callsign = info.callsign,
        cash = info.cash,
        bank = info.bank,
        phonenumber = info.phonenumber,
        metadata = json.decode(info.metadata),
        inventory = json.decode(info.inventory)
    })
end

function NamelessCore.SetActiveCharacter(src, id)
    local char = NamelessCore.players[src]
    if not src or char and char.id == id then return end

    local character = NamelessCore.FeatchCharacters(id, src)
    if not character then return end
    
    character.name = GetPlayerName(src)
    character.active()
    return character
end

function NamelessCore.FeatchAllCharacters(src)
    local characters = {}
    local result = MySQL.query.await("SELECT * FROM nd_characters WHERE identifier = ?", {GetPlayerIdentifierByType(src, Config.characterIdentifier)})

    for i=1, #result do
        local info = result[i]
        characters[info.charid] = createCharacterTable({
            source = src,
            id = info.charid,
            identifier = info.identifier,
            name = info.name,
            firstname = info.firstname,
            lastname = info.lastname,
            fullname = ("%s %s"):format(info.firstname, info.lastname),
            dob = info.dob,
            gender = info.gender,
            job = job or info.department,
            rank = info.rank, 
            callsign = info.callsign,
            cash = info.cash,
            bank = info.bank,
            phonenumber = info.phonenumber,
            metadata = json.decode(info.metadata),
            inventory = json.decode(info.inventory)
        })
    end
    return characters
end

function NamelessCore.SetData(src)
    Citizen.CreateThread(SetActiveCharacter(src))
end