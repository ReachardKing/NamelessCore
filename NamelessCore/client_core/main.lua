
NamelessCore = {}

--[[RegisterCommand("cash", function()
end)]]


	if NamelessCore.players and IsPauseMenuActive() then
        BeginScaleformMovieMethodOnFrontendHeader("SET_HEADING_DETAILS")
        ScaleformMovieMethodAddParamPlayerNameString(("%s %s"):format(NamelessCore.players.firstname, NamelessCore.players.lastname))
        ScaleformMovieMethodAddParamTextureNameString(("Cash: $%d"):format(NamelessCore.players.cash))
        ScaleformMovieMethodAddParamTextureNameString(("Bank: $%d"):format(NamelessCore.players.bank))
    end
