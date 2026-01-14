
AddEventHandler("playerSpawned", function(core)
    TriggerServerEvent("GetServerObjects", core)
    print("\n this works!".. core)

    HideHudComponentThisFrame(19)
end)