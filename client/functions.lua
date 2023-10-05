function BlowDynamiteV(locationName)
    local playerPed = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(playerPed))
    local itemDynamiteprop = CreateObject(GetHashKey('p_dynamite01x'), x, y, z + 0.2, true, true, true)
    AttachEntityToEntity(itemDynamiteprop, playerPed, GetPedBoneIndex(playerPed, 54565), 0.06, 0.0, 0.06, 90.0, 0.0, 0.0, true, true, false, true, 1, true)
    SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), true)
    Citizen.Wait(700)
    FreezeEntityPosition(playerPed, true)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 40000, true, false, false, false)

    exports['progressBars']:startUI(40000, "PLACING DYNAMITE")
    Citizen.Wait(40000)

    ClearPedTasks(playerPed)
    DetachEntity(itemDynamiteprop)
    FreezeEntityPosition(playerPed, false)
    Citizen.Wait(500)

    exports['progressBars']:startUI(35000, "DYNAMITE LIT STAND BACK")
    TriggerEvent('vorp:TipRight', "DYNAMITE LIT STAND BACK!!!", 35000)
    Citizen.Wait(35000)

    -- Assuming you have multiple locations, handle the explosion location based on the 'locationName' parameter
    local explosionCoords = Config.Locations[locationName].ExplosionCoords
    AddExplosion(explosionCoords.x, explosionCoords.y, explosionCoords.z, 25, 5000.0, true, false, 27)
    BlowedynamiteV = true

    local playerPed2 = PlayerPedId()
    local coords = GetEntityCoords(playerPed2)
end
