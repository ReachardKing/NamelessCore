
NamelessCore = {}
NamelessCore.players = {}
NamelessCore.functions = {}

AddEventHandler("NamelessCore:GetServerObjects", function(core, cb)
    NamelessCore = core
    if cb then cb(NamelessCore) end
end)

exports('GetServerObjects', function()
    return NamelessCore
end )