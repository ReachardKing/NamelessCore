
local Core = nil
NamelessCore = {}
CreateThread(function()
    while Core == nil do
        Wait(100) -- check every 0.1s
        TriggerServerEvent("NamelessCore:GetServerObjects", Core, NamelessCore)
    end
    print("[Bootstrap] NamelessCore loaded for " .. GetCurrentResourceName())
end)

-- Export it for the rest of this resource
exports("GetServerObjects", function()
    return Core
end)


-- used in local core = exports['your_resource_name']:GetServerObjects() print(core.players) other resources