local robtime = 140 -- Time to rob (in seconds) now its 3.3mins
local timerCount = robtime
local isRobbing = false
local speaked = false
local started = false
local maksettu = false
local Blowedynamite = false
local missionCompleted = false


Citizen.CreateThread(function() --Valentine starting location
    while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local betweencoords = GetDistanceBetweenCoords(coords,198.82, 1002.86, 189.04, true)
		if betweencoords < 2.0 and speaked == false then
			DrawTxt(" PRESS [~e~ENTER~q~] TO START ", 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
			if IsControlJustReleased(0, 0xC7B5340A) then
				speaked = true
                started = true    
				TriggerServerEvent("fists_robbery:valentine", function() 
			end)
			end
		end
	end
end)



RegisterNetEvent('fists_robbery:info')
AddEventHandler('fists_robbery:info', function()	
    while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local betweencoords = GetDistanceBetweenCoords(coords,198.82, 1002.86, 189.04, true)
		if betweencoords < 2.0 and maksettu == false and started == true then
			DrawTxt(" PRESS [~e~ENTER~q~] ACCEPT ", 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
			if IsControlJustReleased(0, 0xC7B5340A) then
            started = true
		    maksettu = true 
            isRobbing = true        
			TriggerServerEvent("fists_robbery:pay", function()                
			end)
			end
		end
	end
end)

RegisterNetEvent('fists_robbery:go')
AddEventHandler('fists_robbery:go', function()	
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
	if started == true then
		DrawTxt("", 0.50, 0.50, 0.7, 0.7, true, 255, 255, 255, 255, true)
		Citizen.InvokeNative(0x3D3D15AF7BCAAF83, 6, true, true)
		Citizen.InvokeNative(0x64C59DD6834FA942, 1290.0882568359, -1312.4019775391, 76.039939880371)
		Citizen.InvokeNative(0x4426D65E029A4DC0, true) 
	end
end)

RegisterNetEvent("Witness:ToggleNotification2")
AddEventHandler("Witness:ToggleNotification2", function(coords, alert)
	--print('store name '..tostring(alert))
	TriggerEvent("vorp:TipBottom", 'Telegram of Robbery in Progress at ' .. alert, 15000)
	local blip = Citizen.InvokeNative(0x45f13b7e0a15c880, -1282792512, coords.x, coords.y, coords.z, 50.0)
	Wait(90000)--Time till notify blips dispears, 1 min
	RemoveBlip(blip)
end)


function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

--Robbery startpoint
Citizen.CreateThread(function() 
    while true do
	Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local betweencoords = GetDistanceBetweenCoords(coords,-307.71, 746.99, 120.30, true)
		if betweencoords < 2.0 and isRobbing == true then
				DrawTxt(Config.rob, 0.50, 0.95, 0.7, 0.7, true, 255, 255, 255, 255, true)
				if IsControlJustReleased(0, 0x760A9C6F) then
				TriggerServerEvent("fists_robbery:startrobbery", function()          
				end)
				Citizen.Wait(2000)
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
    local testplayer = exports["syn_minigame"]:taskBar(4000,7)
    local testplayer2
    local testplayer3
    local testplayer4
    Wait(1000)
    if testplayer == 100 then
    testplayer2 = exports["syn_minigame"]:taskBar(3500,7)
    end
    Wait(1000)
    if testplayer2 == 100 then
    testplayer3 = exports["syn_minigame"]:taskBar(3200,7)
    end
    Wait(1000)
    if testplayer3 == 100 then
    testplayer4 = exports["syn_minigame"]:taskBar(2900,7)
    end
    if testplayer4 == 100 then   
	BlowDynamite()
    TriggerServerEvent("fists_robbery:loot", function()
    maksettu = false 
    started = true
    Blowedynamite = true                
    end)                
	else
	Wait(1000)
	TriggerEvent('fists_robbery:startAnimation2')
    --Blowedynamite = false 
    --isRobbing = false
   -- speaked = false
    --started = false
    --maksettu = false     
	--Citizen.Wait(6000)
	--ClearPedTasksImmediately(PlayerPedId())
	--ClearPedSecondaryTask(PlayerPedId())            
    end        
end)

RegisterNetEvent('fists_robbery:valentineloot')
AddEventHandler('fists_robbery:valentineloot', function()	
	while true do
		Citizen.Wait(0)
        local _source = source    
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local betweencoords = GetDistanceBetweenCoords(coords,1290.0882568359, -1312.4019775391, 76.039939880371, true)
		if betweencoords < 2.0 and Blowedynamite == true then
			DrawTxt("Press [~e~ENTER~q~] to take loot", 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
			if IsControlJustReleased(0, 0xC7B5340A) then
			 FreezeEntityPosition(playerPed, true)
              TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), Config.LockpickTime, true, false, false, false)
	          exports['progressBars']:startUI(Config.LockpickTime, "Getting The Loot...")     
              Blowedynamite = false 
              isRobbing = false
              speaked = false
              started = false
              maksettu = false     
			  Citizen.Wait(6000)
	          ClearPedTasksImmediately(PlayerPedId())
	          ClearPedSecondaryTask(PlayerPedId())
	          TriggerServerEvent("fists_robbery:valentinepayout", function()
              end)   
			  FreezeEntityPosition(playerPed, false)         
			end
		end
	end
end)              
            


Citizen.CreateThread(function()
    while not HasModelLoaded( GetHashKey("CS_johnmarston") ) do
        Wait(500)
        RequestModel( GetHashKey("CS_johnmarston") )
    end
    local npc = CreatePed(GetHashKey("CS_johnmarston"),1589.78, -1838.80, 51.50,false, false, 0, 0)
    while not DoesEntityExist(npc) do
        Wait(300)
    end
    Citizen.InvokeNative(0x283978A15512B2FE, npc, true)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    TaskStandStill(npc, -1)
    SetEntityCanBeDamagedByRelationshipGroup(npc, false, `PLAYER`)
    SetEntityAsMissionEntity(npc, true, true)
    SetModelAsNoLongerNeeded(GetHashKey("CS_johnmarston"))
end)

function DrawTxt(text,x,y)
    SetTextScale(0.35,0.35)
    SetTextColor(255,255,255,255)--r,g,b,a
    SetTextCentre(true)
    SetTextDropshadow(1,0,0,0,200)
    SetTextFontForCurrentCommand(0)
    DisplayText(CreateVarString(10, "LITERAL_STRING", text), x, y)
end


Citizen.CreateThread(function()
	if Config.BlipValentine == true then
   local blip = N_0x554d9d53f696d002(1664425300,198.82, 1002.86, 189.04)
    SetBlipSprite(blip, 90287351, 1)
         Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Start Bank Heist")
	
 	end
end)

function BlowDynamite()
			
	local playerPed = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	itemDynamiteprop = CreateObject(GetHashKey('p_dynamite01x'), x, y, z+0.2,  true,  true, true)
	AttachEntityToEntity(itemDynamiteprop, playerPed, GetPedBoneIndex(playerPed, 54565), 0.06, 0.0, 0.06, 90.0, 0.0, 0.0, true, true, false, true, 1, true)
	SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"),true)
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
			
	AddExplosion(1290.0882568359, -1312.4019775391, 76.039939880371, 25 , 5000.0 ,true , false , 27)
	Blowedynamite = true
	local playerPed2 = PlayerPedId()
    local coords = GetEntityCoords(playerPed2)        
	
end