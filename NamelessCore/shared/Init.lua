
local namelessCore = exports["NamelessCore"]

NamelessCore = setmetatable({}, {
	__index = function(self, index)
		self[index] = function(...)
			return namelessCore[index](nil, ...)
		end
		return self[index]
	end
})

local resourcename = GetCurrentResourceName()
local NamelessCore = 'NamelessCore'

if resourcename == NamelessCore then return end

local export = exports[NamelessCore]

if GetResourceState(NamelessCore) ~= 'started' then
	error('^1 NamelessCore must be started before any other resources. ^0', 0)
end

local status = export

if status ~= true then error(status, 2) end

function GetAllActivePlayers()
	local playernum = GetNumPlayerIndices()
	local players = table.create(playernum, 0)

	for i = 1, platernum do
		players[i] = tonumber(GetPlayerFromIndex(i - 1))
	end
	return players
end

Citizen.CreateThread(GetAllActivePlayers)