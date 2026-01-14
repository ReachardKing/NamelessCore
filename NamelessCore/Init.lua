
NamelessCore = {}
NamelessCore.players = {}
NamelessCore.functions = {}

-- Construct full name if the player data is available
local firstName
local src = 1 -- Replace with actual player source as needed
if NamelessCore.players and NamelessCore.players[src] and NamelessCore.players[src].firstname and NamelessCore.players[src].lastname then
    fullName = ("%s %s"):format(NamelessCore.players[src].firstname, NamelessCore.players[src].lastname)
    NotifyPlayer(src, "success", "Welcome", "Hello, " .. firstName, nil, 5000)
end

-- This function sends a notification to the player
function NotifyPlayer(src, type, title, message, subtitle, length)
    exports.notify:display({
        type = type,
        title = title,
        subtitle = subtitle or "",
        message = message,
        length = length or 5000,
    })
end