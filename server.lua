local QBCore = exports['qb-core']:GetCoreObject()

local function getLocationById(locationId)
    for _, location in pairs(Config.Locations) do
        if location.id == locationId then
            return location
        end
    end
    return nil
end

RegisterNetEvent("customDispatch:sendAlert")
AddEventHandler("customDispatch:sendAlert", function(locationId)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local location = getLocationById(locationId)

    if player and location then
        local playerCoords = GetEntityCoords(GetPlayerPed(src))
        
        local dispatchData = {
            message = location.dispatch.message,
            information = string.format(location.dispatch.information_template, player.PlayerData.charinfo.firstname, player.PlayerData.charinfo.lastname),
            codeName = location.dispatch.codeName,
            code = location.dispatch.code,
            icon = location.dispatch.icon,
            priority = location.dispatch.priority,
            coords = playerCoords,
            alertTime = nil,
            jobs = location.dispatch.jobs
        }
        TriggerEvent('ps-dispatch:server:notify', dispatchData)
        TriggerClientEvent('okokNotify:Alert', src, location.dispatch.message, location.success_message, Config.UI.notification_duration, Config.UI.success_color)
    end
end)
