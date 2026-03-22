 metadata = {
    name        = "Kill Streak",
    author      = "Nurislam Aibekuly",
    description = "Kill streak announcements",
    version     = "1.0.0",
}

local streaks = {}

local streakMessages = {
    [3]  = { text = "KILLING SPREE!",  r = 255, g = 100, b = 0   },
    [5]  = { text = "DOMINATING!",     r = 255, g = 50,  b = 50  },
    [7]  = { text = "RAMPAGE!",        r = 255, g = 0,   b = 0   },
    [10] = { text = "UNSTOPPABLE!",    r = 200, g = 0,   b = 255 },
    [15] = { text = "GODLIKE!",        r = 255, g = 215, b = 0   },
    [20] = { text = "CRAZY!",          r = 0,   g = 255, b = 255 },
}

onEvent("playerDied", function(victim)
    local vid = victim.Id
    local killer = victim.Killer

    if streaks[vid] and streaks[vid] >= 3 then
        printTalk(victim.Name .. "'s kill streak of " .. streaks[vid] .. " was ended")
    end
    streaks[vid] = 0

    if killer then
        local kid = killer.Id
        local killerName = killer.Name
        streaks[kid] = (streaks[kid] or 0) + 1
        local count = streaks[kid]
        local msg = streakMessages[count]
        if msg then
            printTalk("\x04" .. killerName .. " " .. msg.text)
            local hud = {
                channel     = 4,
                x           = -1,
                y           = 0.35,
                effect      = 2,
                fxTime      = 0.1,
                r1          = msg.r,
                g1          = msg.g,
                b1          = msg.b,
                a1          = 255,
                fadeinTime  = 0.05,
                fadeoutTime = 1.5,
                holdTime    = 3.0,
            }
            printHud(hud, killerName .. " is " .. msg.text)
        end
    end
end)

onEvent("playerRemoved", function(player)
    streaks[player.Id] = nil
end)
