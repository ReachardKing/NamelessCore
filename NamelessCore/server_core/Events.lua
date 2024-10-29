

NamelessCore = {}
NamelessCore.players = {}
NamelessCore.functions = {}

function getResourceObjects()
    return NamelessCore
end

function NamelessCore.functions.update(player)
    local player = tonumber(player)
    if result then
        local cash = result[1].cash
        local bank = result[1].bank
        NamelessCore.players[player].cash = cash
        NamelessCore.players[player].bank = bank
        TriggerClientEvent("Updatemoney", player, cash, bank)
    end
end

function NamelessCore.functions.transfer(amount, player, traget)
    local amount = tonumber(anount)
    local player = tonumber(player)
    local traget = tonumber(traget)

    if player == traget then
        TriggerClientEvent("chat:addMessage", player, {
            color = {255, 0, 0},
            args = {"Error", "You can not sent money to yourself"}
        })
        return false
    elseif GetPlayerPing(traget) == 0 then
        TriggerClientEvent("chat:addmessage", player, {
            color = {255, 0, 0},
            args = {"Error", "That player does not exsit"}
        })
        return false
    elseif amount <= 0 then
        TriggerClientEvent("chat:addMessage", player, {
            color = {255, 0, 0},
            args = {"Error", "You can not sent that amount"}
        })
        return false
    elseif NamelessCore.players[player].bank < amount then
        TriggerClientEvent("chat:addMessage", player, {
            color = {255, 0, 0},
            args = {"Error", "You do not have enough money"}
        })
    else
        NamelessCore.functions.update(player)
        NamelessCore.functions.update(traget)
        TriggerClientEvent("chat:addMessage", player, {
            color = {0, 255, 0},
            args = {"Success", "You paid "..GetPlayerName(traget).. " $".. amount.. "."}
        })
        TriggerClientEvent("chat:addMessage", player, {
            color = {0, 255, 0},
            args = {"Success ", GetPlayerName(player).. "Sent you $"..amount.. "."}
        })
        return true
    end
end

function NamelessCore.functions.GiveCash(amount, player)
    local player = tonumber(player)
    local amount = tonumber(amount)
    local IsPlayer = false
    local playercords = GetEntityCoords(GetPlayerPed(player))
    if NamelessCore.players[player].cash < amount then
        TriggerClientEvent("chat:addMessage", player, {
            color = {255, 0, 0},
            args = {"Error", "You do not have enough money"}
        })
        return false
    else 
        for _, traget in pairs(GetPlayers()) do
            local tragetID = tonumber(traget)
            local tragetcoords = GetEntityCoords(GetPlayerPed(tragetID))
            if(#(playercords - tragetcoords) < 2.0) and (traget ~= player) and not IsPlayer then
                money.functions.update(player)
                money.functions.update(tragetID)
                TriggerClientEvent("chat:addMessage", player, {
                    color = {0, 255, 0},
                    args = {"Success", "You gave "..GetPlayerName(traget).." $" ..amount.. "."}
                })
                TriggerClientEvent("chat:addMessage", tragetID, {
                    color = {0, 255, 0}, 
                    args = {"Success ", GetPlayerName(player).. "Gave you $".. amount .. "."}
                })
                break
            end
        end
        if not IsPlayer then
            TriggerClientEvent("chat:addMessage", player, {
                color = {255, 0, 0},
                args = {"Error", "Count not find players"}
            })
            return false
        end
        IsPlayer = false
        return true
    end
end 

function NamelessCore.functions.deduct(amount, player, form)
    local amount = tonumber(amount)
    local player = tonumber(player)
    if form == "bank" then
        NamelessCore.functions.update(player)
    elseif form == "cash" then
        NamelessCore.functions.update(player)
    end
end

function NamelessCore.functions.add(amount, player, to)
    local amount = tonumber(amount)
    local player = tonumber(player)
    if to == "bank" then
        NamelessCore.functions.update(player)
    elseif to == "cash" then
        NamelessCore.functions.update(player)
    end
end

function NamelessCore.functions.withdraw(amount, player)
    local amount = tonumber(amount)
    local player = tonumber(player)

    if NamelessCore.players[player].cash >= amount then
        NamelessCore.functions.update(player)
        return true 
    end
    return false
end

function NamelessCore.functions.deposit(amount, player)
    local player = tonumber(player)
    local amount = tonumber(amount)

    if NamelessCore.playerss[player].cash >= amount then
        NamelessCore.functions.update(player)
        return true
    end
    return false
end

RegisterNetEvent("getMoney")
AddEventHandler("getMoney", function()
    local player = source
    local cash = nil
    local bank = nil

    if result then
        if not result[1] then
            TriggerClientEvent("Updatemoney", player, config.StartingCash, config.StartingBank)
            NamelessCore.players[player] = {["cash"] = config.StartingCash, ["bnk"] = config.StartingBank}
            return
        end
        local cash = result[1].cash
        local bank = result[1].bank

        NamelessCore.players[player] = {["cash"] =  cash, ["bank"] = bank}
        TriggerClientEvent("Updatemoney", player, cash, bank)
    end
end)