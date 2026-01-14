
RegisterNetEvent("NamelessCore:ReceivePlayerInfo")
AddEventHandler("NamelessCore:ReceivePlayerInfo", function(PlayerInfo, playerData)

    TriggerServerEvent("GetServerObjects", 1, {
        playerData = {
            charsinfo = {
                firstName = PlayerInfo.info.firstName,
                lastName  = PlayerInfo.info.lastName,         
            },
            metadata = {
                callsign = PlayerInfo.metadata.callsign
            },
            citizenid = PlayerInfo.info.citizenid,
            job = {
                type = PlayerInfo.info.job.type,
                name = PlayerInfo.info.job.name,
                label = PlayerInfo.info.job.label
            },
        }
    })
end)