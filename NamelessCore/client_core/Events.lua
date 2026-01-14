 RegisterNetEvent("updateMoney", function(cash, bank)
    if not NamelessCore.player then return end

    NamelessCore.player.cash = cash
    NamelessCore.player.bank = bank
end)

RegisterNetEvent("NamelessCore:Characterloaded", function(character)
    NamelessCore.player = character 
end)

RegisterNetEvent("NamelessCore:updateCharacter", function(character)
    NamelessCore.player = character
end)

RegisterNetEvent("NamelessCore:updatelastLocation", function(location)
    if not NamelessCore.player then return end
    NamelessCore.lastLocation = location
end)