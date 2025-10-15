local locationStates = {}
local textUIOpen = false
local currentLocationId = nil

for _, location in pairs(Config.Locations) do
    locationStates[location.id] = {
        notified = false,
        lastNotificationTime = 0
    }
end

Citizen.CreateThread(function()
    local playerPed, playerCoords
    while true do
        playerPed = PlayerPedId()
        playerCoords = GetEntityCoords(playerPed)
        local currentTime = GetGameTimer() / 1000
        local inAnyLocation = false
        local activeLocation = nil

        for _, location in pairs(Config.Locations) do
            if #(playerCoords - location.coords) < location.distance then
                inAnyLocation = true
                activeLocation = location
                currentLocationId = location.id
                break
            end
        end

        if inAnyLocation and activeLocation then
            local locationState = locationStates[activeLocation.id]
            local cooldownRemaining = activeLocation.cooldown - (currentTime - locationState.lastNotificationTime)

            if cooldownRemaining <= 0 then
                if not locationState.notified then
                    locationState.notified = true
                    exports['okokTextUI']:Open(activeLocation.ui_message, Config.UI.info_color, Config.UI.text_position)
                    textUIOpen = true
                end

                if IsControlJustReleased(0, 38) then -- Eキー
                    TriggerServerEvent("customDispatch:sendAlert", activeLocation.id)
                    locationState.lastNotificationTime = currentTime
                    exports['okokTextUI']:Close()
                    exports['okokTextUI']:Open(activeLocation.cooldown_message, Config.UI.error_color, Config.UI.text_position)
                    Wait(Config.UI.cooldown_message_duration)
                    exports['okokTextUI']:Close()
                    textUIOpen = false
                end
                Citizen.Wait(0)
            else
                local minutes = math.floor(cooldownRemaining / 60)
                local seconds = math.floor(cooldownRemaining % 60)
                local timeText = ""

                if minutes > 0 then
                    timeText = minutes .. '分'
                end
                if seconds > 0 then
                    timeText = timeText .. (minutes > 0 and "" or "") .. seconds .. "秒"
                end

                if not locationState.notified and timeText ~= "" then
                    exports['okokTextUI']:Open(string.format(activeLocation.cooldown_remaining_message, timeText), Config.UI.error_color, Config.UI.text_position)
                    textUIOpen = true
                    locationState.notified = true
                end
                Citizen.Wait(1000)
            end
        else
            if textUIOpen then
                exports['okokTextUI']:Close()
                textUIOpen = false
            end

            if currentLocationId then
                locationStates[currentLocationId].notified = false
                currentLocationId = nil
            end
            Citizen.Wait(500)
        end
    end
end)
