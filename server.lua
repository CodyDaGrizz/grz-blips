RegisterServerEvent("grz-blips:saveBlip")
AddEventHandler("grz-blips:saveBlip", function(blipData)
    local filePath = GetResourcePath(GetCurrentResourceName()) .. "/config.lua"

    local configFile = LoadResourceFile(GetCurrentResourceName(), "config.lua")
    
    if not configFile then
        print("^1[GRZ-BLIPS] Error: Could not load config.lua!^0")
        return
    end

    local blipEntry = string.format(
        '{title = "%s", colour = %d, id = %d, size = %.1f, coords = vec3(%.2f, %.2f, %.2f)},',
        blipData.title, blipData.colour, blipData.id, blipData.size,
        blipData.coords.x, blipData.coords.y, blipData.coords.z
    )

    local updatedConfig = string.gsub(configFile, "Config.Blips = {", "Config.Blips = {
    " .. blipEntry, 1)

    SaveResourceFile(GetCurrentResourceName(), "config.lua", updatedConfig, -1)

    print("^2[GRZ-BLIPS] Saved new blip: " .. blipData.title .. "^0")
end)