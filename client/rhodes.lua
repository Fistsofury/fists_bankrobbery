local robTime = 140 -- Time to rob (in seconds)
local timerCount = robTime
local isRobbing = false
local speaking = false
local started = false
local maksettu = false
local blowedynamite = false
local missionCompleted = false
local currentLocation = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)

        -- Check if the player is near any location
        for locationIndex, location in ipairs(Config.Locations) do
            local locationCoords = location.Coordinates
            local locationName = location.Name
            local robText = location.RobText

            if GetDistanceBetweenCoords(coords, locationCoords.x, locationCoords.y, locationCoords.z, true) < Config.ZoneSize and speaking == false then
                currentLocation = locationIndex
                DrawTxt(" PRESS [~e~ENTER~q~] TO START ", 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
                if IsControlJustReleased(0, 0xC7B5340A) then
                    speaking = true
                    started = true
                    TriggerServerEvent("fists_robbery:" .. locationName, function()
                    end)
                end
            end
        end
    end
end)

RegisterNetEvent('fists_robbery:endprompt')
AddEventHandler('fists_robbery:endprompt', function()
    isRobbing = false
end)

RegisterNetEvent('fists_robbery:startAnimation2')
AddEventHandler('fists_robbery:startAnimation2', function()
    local _source = source
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local testplayer = exports["syn_minigame"]:taskBar(4000, 7)
    local testplayer2
    local testplayer3
    local testplayer4
    Wait(1000)
    if testplayer == 100 then
        testplayer2 = exports["syn_minigame"]:taskBar(3500, 7)
    end
    Wait(1000)
    if testplayer2 == 100 then
        testplayer3 = exports["syn_minigame"]:taskBar(3200, 7)
    end
    Wait(1000)
    if testplayer3 == 100 then
        testplayer4 = exports["syn_minigame"]:taskBar(2900, 7)
    end
    if testplayer4 == 100 then
        BlowDynamite()
        TriggerServerEvent("fists_robbery:" .. Config.Locations[currentLocation].Name .. "loot", function()
            maksettu = false
            started = true
            blowedynamite = true
        end)
    else
        Wait(1000)
        TriggerEvent('fists_robbery:startAnimation2')
    end
end)

RegisterNetEvent('fists_robbery:rhodesloot2')
AddEventHandler('fists_robbery:rhodesloot2', function()
    while true do
        Citizen.Wait(0)
        local _source = source
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)

        if blowedynamite and GetDistanceBetweenCoords(coords, Config.Locations[currentLocation].Coordinates.x, Config.Locations[currentLocation].Coordinates.y, Config.Locations[currentLocation].Coordinates.z, true) < Config.ZoneSize then
            DrawTxt("Press [~e~ENTER~q~] to take loot", 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
            if IsControlJustReleased(0, 0xC7B5340A) then
                FreezeEntityPosition(playerPed, true)
                TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), Config.LockpickTime, true, false, false, false)
                exports['progressBars']:startUI(Config.LockpickTime, "Getting The Loot...")
                blowedynamite = false
                isRobbing = false
                speaking = false
                started = false
                maksettu = false
                Citizen.Wait(6000)
                ClearPedTasksImmediately(PlayerPedId())
                ClearPedSecondaryTask(PlayerPedId())
                TriggerServerEvent("fists_robbery:" .. Config.Locations[currentLocation].Name .. "payout", function()
                end)
                FreezeEntityPosition(playerPed, false)
            end
        end
    end
end)
