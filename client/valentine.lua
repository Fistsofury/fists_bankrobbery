local robtimev = 140 -- Time to rob (in seconds) now its 3.3mins
local timerCountv = robtimev
local isRobbingv = false
local speakedv = false
local startedv = false
local maksettuv = false
local BlowedynamiteV = false
local missionCompletedv = false


Citizen.CreateThread(function() --Valentine starting location
    while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local betweencoords = GetDistanceBetweenCoords(coords,233.43, 991.45, 189.48, true)
		if betweencoords < 2.0 and speakedv == false then
			DrawTxt(" PRESS [~e~ENTER~q~] TO START ", 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
			if IsControlJustReleased(0, 0xC7B5340A) then
				speakedv = true
                startedv = true    
				TriggerServerEvent("fists_robbery:valentine", function() 
			end)
			end
		end
	end
end)

RegisterNetEvent('fists_robbery:valentineinfo')
AddEventHandler('fists_robbery:valentineinfo', function()	
    while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local betweencoords = GetDistanceBetweenCoords(coords,233.43, 991.45, 189.48, true)
		if betweencoords < 2.0 and maksettuv == false and startedv == true then
			DrawTxt(" PRESS [~e~ENTER~q~] ACCEPT ", 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
			if IsControlJustReleased(0, 0xC7B5340A) then
            startedv = true
		    maksettuv = true 
            isRobbingv = true        
			TriggerServerEvent("fists_robbery:valentinepay", function()                
			end)
			end
		end
	end
end)

RegisterNetEvent('fists_robbery:valentinego') -- Set GPS Function
AddEventHandler('fists_robbery:valentinego', function()	
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
	if startedv == true then
		DrawTxt("", 0.50, 0.50, 0.7, 0.7, true, 255, 255, 255, 255, true)
		Citizen.InvokeNative(0x3D3D15AF7BCAAF83, 6, true, true)
		Citizen.InvokeNative(0x64C59DD6834FA942, -309.14, 789.23, 117.67)
		Citizen.InvokeNative(0x4426D65E029A4DC0, true) 
	end
end)

RegisterNetEvent("Witness:ToggleNotification2")
AddEventHandler("Witness:ToggleNotification2", function(coords, alert)

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
		local betweencoords = GetDistanceBetweenCoords(coords,-310.31, 775.43, 118.80, true) -- marker location for prompt
		if betweencoords < 2.0 and isRobbingv == true then
				DrawTxt(Config.rob, 0.50, 0.95, 0.7, 0.7, true, 255, 255, 255, 255, true)
				if IsControlJustReleased(0, 0x760A9C6F) then
				TriggerServerEvent("fists_robbery:startvalentinerobbery", function()          
				end)
				Citizen.Wait(2000)
			end
		end
	end
end)

--[[
	RegisterNetEvent('fists_robbery:endprompt')
AddEventHandler('fists_robbery:endprompt', function()	
	isRobbing = false
end)
]]
RegisterNetEvent('fists_robbery:startvalentineAnimation2')
AddEventHandler('fists_robbery:startvalentineAnimation2', function()	
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
	BlowDynamiteV()
    TriggerServerEvent("fists_robbery:valentineloot", function()
    maksettuv = false 
    startedv = true
    BlowedynamiteV = true                
    end)                
	else
	Wait(1000)
	TriggerEvent('fists_robbery:startAnimation2')          
    end        
end)

RegisterNetEvent('fists_robbery:valentineloot2')
AddEventHandler('fists_robbery:valentineloot2', function()	
	while true do
		Citizen.Wait(0)
        local _source = source    
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local betweencoords = GetDistanceBetweenCoords(coords,-310.31, 775.43, 118.80, true) -- actual loot prompt
		if betweencoords < 2.0 and BlowedynamiteV == true then
			DrawTxt("Press [~e~ENTER~q~] to take loot", 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
			if IsControlJustReleased(0, 0xC7B5340A) then
			 FreezeEntityPosition(playerPed, true)
              TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), Config.LockpickTime, true, false, false, false)
	          exports['progressBars']:startUI(Config.LockpickTime, "Getting The Loot...")     
              BlowedynamiteV = false 
              isRobbingv = false
              speakedv = false
              startedv = false
              maksettuv = false     
			  Citizen.Wait(6000)
	          ClearPedTasksImmediately(PlayerPedId())
	          ClearPedSecondaryTask(PlayerPedId())
	          TriggerServerEvent("fists_robbery:valentineloot", function()
              end)   
			  FreezeEntityPosition(playerPed, false)         
			end
		end
	end
end)              
            


Citizen.CreateThread(function()
    while not HasModelLoaded( GetHashKey("A_M_M_BlWForeman_01") ) do
        Wait(500)
        RequestModel( GetHashKey("A_M_M_BlWForeman_01") )
    end
    local npc = CreatePed(GetHashKey("A_M_M_BlWForeman_01"),233.43, 991.45, 189.48,false, false, 0, 0)
    while not DoesEntityExist(npc) do
        Wait(300)
    end
    Citizen.InvokeNative(0x283978A15512B2FE, npc, true)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    TaskStandStill(npc, -1)
    SetEntityCanBeDamagedByRelationshipGroup(npc, false, `PLAYER`)
    SetEntityAsMissionEntity(npc, true, true)
    SetModelAsNoLongerNeeded(GetHashKey("A_M_M_BlWForeman_01"))
end)

function DrawTxt(text,x,y)
    SetTextScale(0.35,0.35)
    SetTextColor(255,255,255,255)--r,g,b,a
    SetTextCentre(true)
    SetTextDropshadow(1,0,0,0,200)
    SetTextFontForCurrentCommand(0)
    DisplayText(CreateVarString(10, "LITERAL_STRING", text), x, y)
end


Citizen.CreateThread(function() -- Create blip, checks config to make sure it set to true
	if Config.BlipValentine == true then
   local blip = N_0x554d9d53f696d002(1664425300,233.43, 991.45, 189.48)
    SetBlipSprite(blip, 90287351, 1)
         Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Start Bank Heist")
	
 	end
end)

function BlowDynamiteV()
			
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
			
	AddExplosion(-310.31, 775.43, 118.80, 25 , 5000.0 ,true , false , 27)
	BlowedynamiteV = true
	local playerPed2 = PlayerPedId()
    local coords = GetEntityCoords(playerPed2)        
	
end