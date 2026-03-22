metadata = {
    name        = "Kill Streak",
    author      = "Nurislam Aibekuly",
    description = "Kill streak announcements",
    version     = "1.0.0",
}

local streaks = {}

local streakMessages = {
    [3]  = "is on a KILLING SPREE!",
    [5]  = "is DOMINATING!",
    [7]  = "is on a RAMPAGE!",
    [10] = "is UNSTOPPABLE!",
    [15] = "is GODLIKE!",
    [20] = "is CRAZY!
}

onEvent("playerDied", function(victim)
    local vid = victim.Id
    local killer = victim.Killer

    if streaks[vid] and streaks[vid] > 0 then
        if streaks[vid] >= 3 then
            printTalk(victim.Name .. "'s kill streak of " .. streaks[vid] .. " was ended")
        end
        streaks[vid] = 0
    end

    if killer then
        local kid = killer.Id
        streaks[kid] = (streaks[kid] or 0) + 1
        local count = streaks[kid]

        local msg = streakMessages[count]
        if msg then
            printTalk("\x04" .. killer.Name .. " " .. msg)
        end
    end
end)

onEvent("playerRemoved", function(player)
    streaks[player.Id] = nil
end)

onEvent("playerSpawned", function(player)
end)
