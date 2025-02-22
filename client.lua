CreateThread(function()
    for _, info in pairs(Config.Blips) do
        local blip = AddBlipForCoord(info.coords.x, info.coords.y, info.coords.z)
        SetBlipSprite(blip, info.id)         -- Blip Icon
        SetBlipDisplay(blip, 4)              -- Blip Display Type
        SetBlipScale(blip, info.size)        -- Blip Size
        SetBlipColour(blip, info.colour)     -- Blip Color
        SetBlipAsShortRange(blip, true)      -- Only Visible on Mini-Map
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)   -- Blip Title
        EndTextCommandSetBlipName(blip)
    end
end)

RegisterCommand("cblip", function(source, args)
    if #args < 4 then
        TriggerEvent("chatMessage", "^3Usage: /cblip [name] [size] [id] [color]")
        TriggerEvent("chatMessage", "^3Example: /cblip Store 1.0 52 2")
        TriggerEvent("chatMessage", "^3Blip List: https://docs.fivem.net/docs/game-references/blips/")
        return
    end

    local player = GetPlayerPed(-1)
    local coords = GetEntityCoords(player)

    local newBlip = {
        title = args[1],
        size = tonumber(args[2]),
        id = tonumber(args[3]),
        colour = tonumber(args[4]),
        coords = vec3(coords.x, coords.y, coords.z)
    }

    -- Add blip in real-time
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, newBlip.id)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, newBlip.size)
    SetBlipColour(blip, newBlip.colour)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(newBlip.title)
    EndTextCommandSetBlipName(blip)

    -- Send blip to server to save it
    TriggerServerEvent("grz-blips:saveBlip", newBlip)

    -- Confirm the blip was added
    TriggerEvent("chatMessage", "^2Blip created successfully: " .. newBlip.title)
end, false)