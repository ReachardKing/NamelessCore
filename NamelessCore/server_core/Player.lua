
function removeCharacter(character)
    local new = {}

    for k, v in pairs(character) do
        if type(v) ~= "string" then
            new[k] = v
        end
    end
    return new
end

function CreateCharacterTables(info)
    local PlayerInfo = PlayersInfo and PlayersInfo[info.source] or {}

    local self = {
        id = info.id,
        source = info.source,
        identifier = info.identifier,
        identifiers = info.identifiers,
        name = info.name,
        firstname = info.firstname,
        lastname = info.lastname,
        fullname = ("%s %s"):format(info.firstname or "", info.lastname or ""),
        dob = info.dob,
        gender = info.gender,
        job = info.job or info.department,
        rank = info.rank,
        callsign = info.callsign,
        cash = info.cash,
        bank = info.bank,
        phonenumber = info.phonenumber,
        metadata = info.metadata,
        inventory = info.inventory
    }
    
    function self.metadata(metadata)
        if type(metadata) ~= "table" then
            return self.meatdata[metadata]
        end
    end

    function self.setmetadata(key, value)
        if(key) == "table" then
            for k, v in pairs(key) do
                self.metadat[k] = v
            end
        else
            self.metadata[key] = value
        end
    end
    
    return self
end

function NewCharacter(src, info)
    local identifier = GetPlayerIdentifierByType(src, Config.characterIdentifier)
    if not identifier then return end

    local charInfo = {
        source = src,
        identifier = identifier,
        name = ("%s %s"):format(info.firstname or "", info.lastname or ""),
        firstname = info.firstname or "",
        lastname = info.lastname or "",
        fullname = ("%s %s"):format(info.firstname or "", info.lastname or ""),
        dob = info.dob or "",
        gender = info.gender or "",
        cash = info.cash or 0,
        bank = info.bank or 0,
        phonenumber = info.phonenumber,
        metadata = info.metadata or {},
        inventory = info.inventory or {}
    }

    charInfo.id = MySQL.insert('INSERT INTO characters (identifier, firstname, lastname, dob, gender, department, csn) VALUES (?, ?, ?, ?, ?, ?, ?)', {
		charInfo.identifier,charInfo,fullname, charInfo.firstname, charInfo.name,charInfo.lastname, charInfo.dob, charInfo.gender
	})


    return CreateCharacterTables(charInfo)
end

function FetchCharacters(id, src)
    local result
    if src then
        result = MySQL.query.await("SELECT * FROM characters WHERE charid = ? and identifier = ?", {id, GetPlayerIdentifierByType(src, Config.characterIdentifier)})
    else
        result = MySQL.query.await("SELECT * FROM characters WHERE charid = ?", {id})
    end

    if not result or not result[1] then return end
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
        job = info.job or info.department,
        rank = info.rank, 
        callsign = info.callsign,
        cash = info.cash,
        bank = info.bank,
        phonenumber = info.phonenumber,
        metadata = json.decode(info.metadata),
        inventory = json.decode(info.inventory)
    })
end

function SetActiveCharacter(src, id)
    local char = NamelessCore.players and NamelessCore.players[src]
    if not src or (char and char.id == id) then return end

    local character = NamelessCore.FetchCharacters(id, src)
    if not character then return end
    
    character.name = GetPlayerName(src)
    return character
end

function FetchAllCharacters(src)
    local characters = {}
    local result = MySQL.query.await("SELECT * FROM characters WHERE identifier = ?", {GetPlayerIdentifierByType(src, self.characterIdentifier)})

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

function SetData(src)
    Citizen.CreateThread(SetActiveCharacter(src))
end

exports("NewCharacter", NewCharacter)
exports("FetchCharacters", FetchCharacters)
exports("SetActiveCharacter", SetActiveCharacter)
exports("FetchAllCharacters", FetchAllCharacters)
exports("SetData", SetData)