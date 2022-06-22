VORP = exports.vorp_inventory:vorp_inventoryApi()

data = {}
TriggerEvent("vorp_inventory:getData",function(call)
    data = call
end)

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)


RegisterServerEvent('fists_robbery:rhodes')
AddEventHandler('fists_robbery:rhodes', function()
        local _source = source
        local Character = VorpCore.getUser(_source).getUsedCharacter
        TriggerClientEvent("vorp:TipBottom", _source, "JOHN: I have a job for you ", 5000)
		Citizen.Wait(5000)
		TriggerClientEvent("vorp:TipBottom", _source, "JOHN: The only problem is that you need some dynamite", 5000)
		Citizen.Wait(5000)
		TriggerClientEvent("vorp:TipBottom", _source, "JOHN: You want to do this ? ", 5000)
		Citizen.Wait(5000)
		TriggerClientEvent('fists_robbery:rhodesinfo', _source)
end)

 --########## Being worked on ##########
RegisterServerEvent('fists_robbery:valentine')
AddEventHandler('fists_robbery:valentine', function()
        local _source = source
        local Character = VorpCore.getUser(_source).getUsedCharacter
        TriggerClientEvent("vorp:TipBottom", _source, "Buck: I have special job a job for you ", 5000)
		Citizen.Wait(5000)
		TriggerClientEvent("vorp:TipBottom", _source, "Buck: I hope you have you the dynamite", 5000)
		Citizen.Wait(5000)
		TriggerClientEvent("vorp:TipBottom", _source, "Buck: lets ride out ? ", 5000)
		Citizen.Wait(5000)
		TriggerClientEvent('fists_robbery:valentineinfo', _source)
end)
--[[
RegisterServerEvent('fists_robbery:valentine')
AddEventHandler('fists_robbery:valentine', function()
        local _source = source
        local Character = VorpCore.getUser(_source).getUsedCharacter
        TriggerClientEvent("vorp:TipBottom", _source, "Buck: I have special job a job for you ", 5000)
		Citizen.Wait(5000)
		TriggerClientEvent("vorp:TipBottom", _source, "Buck: I hope you have you the dynamite", 5000)
		Citizen.Wait(5000)
		TriggerClientEvent("vorp:TipBottom", _source, "Buck: lets ride out ? ", 5000)
		Citizen.Wait(5000)
		TriggerClientEvent('fists_robbery:info', _source)
end)]]


RegisterServerEvent('fists_robbery:rhodespay')
AddEventHandler('fists_robbery:rhodespay', function()
        local _source = source
        local Character = VorpCore.getUser(_source).getUsedCharacter
        u_money = Character.money

    if u_money <= 0 then
        TriggerClientEvent("vorp:TipBottom", _source, "You have no money", 9000)
        return
    end

    TriggerEvent("vorp:removeMoney", _source, 0, 0)
    TriggerClientEvent("vorp:TipBottom", _source, "JOHN: Now Go To Rhodes Bank!", 5000)
	Citizen.Wait(1000)
    TriggerClientEvent('fists_robbery:rhodesgo', _source)    
end)


-- #### Valentine ####
RegisterServerEvent('fists_robbery:valentinepay')
AddEventHandler('fists_robbery:valentinepay', function()
        local _source = source
        local Character = VorpCore.getUser(_source).getUsedCharacter
        u_money = Character.money

    if u_money <= 0 then
        TriggerClientEvent("vorp:TipBottom", _source, "You have no money", 9000)
        return
    end

    TriggerEvent("vorp:removeMoney", _source, 0, 0)
    TriggerClientEvent("vorp:TipBottom", _source, "Buck: Now Go To Valentine Bank!", 5000)
	Citizen.Wait(1000)
    TriggerClientEvent('fists_robbery:valentinego', _source)    
end)

RegisterNetEvent("fists_robbery:startrhodesrobbery")
AddEventHandler("fists_robbery:startrhodesrobbery", function(robtime)
    local _source = source
    local Character = VorpCore.getUser(source).getUsedCharacter
    local count = VORP.getItemCount(_source, "dynamite")

    if count >= 1 then      
        VORP.subItem(_source,"dynamite", 1)
        isRobbing = false    
        TriggerClientEvent('fists_robbery:startAnimation2', _source)
        TriggerClientEvent('fists_robbery:endprompt',_source)
        Wait(5000)
        TriggerClientEvent("vorp:TipBottom", _source, "Sheriffs Have Been Alerted",6000)
    else   
        TriggerClientEvent("vorp:TipBottom", _source, "You dont have a dynamite", 6000)
    end     
end)


-- #### Valentine ####
RegisterNetEvent("fists_robbery:startvalentinerobbery")
AddEventHandler("fists_robbery:startvalentinerobbery", function(robtime)
    local _source = source
    local Character = VorpCore.getUser(source).getUsedCharacter
    local count = VORP.getItemCount(_source, "dynamite")

    if count >= 1 then      
        VORP.subItem(_source,"dynamite", 1)
        isRobbing = false    
        TriggerClientEvent('fists_robbery:startAnimation2', _source)
        TriggerClientEvent('fists_robbery:endprompt',_source)
        Wait(5000)
        TriggerClientEvent("vorp:TipBottom", _source, "Sheriffs Have Been Alerted",6000)
    else   
        TriggerClientEvent("vorp:TipBottom", _source, "You dont have a dynamite", 6000)
    end     
end)

RegisterServerEvent('fists_robbery:rhodesloot')
AddEventHandler('fists_robbery:rhodesloot', function()
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    Blowedynamite = Blowedynamite    
        
    if Blowedynamite == true then
    end        
    TriggerClientEvent('fists_robbery:rhodesloot2', _source)    
end)

RegisterNetEvent("fists_robbery:rhodespayout")
AddEventHandler("fists_robbery:rhodespayout", function()
    TriggerEvent('vorp:getCharacter', source, function(user)
        local _source = source
        local _user = user
        ritem = math.random(1,2)
        local randomitempull = math.random(1, #Config.RhodesItems)
        local itemName = Config.RhodesItems[randomitempull]
           VORP.addItem(_source, itemName, ritem)
    end)
end)

RegisterNetEvent("fists_robbery:valentinepayout")
AddEventHandler("fists_robbery:valentinepayout", function()
    TriggerEvent('vorp:getCharacter', source, function(user)
        local _source = source
        local _user = user
        ritem = math.random(1,2)
        local randomitempull = math.random(1, #Config.ValentineItems)
        local itemName = Config.ValentineItems[randomitempull]
           VORP.addItem(_source, itemName, ritem)
    end)
end)



RegisterNetEvent("policenotify")
AddEventHandler("policenotify", function(players, coords, alert)
    local Character = VorpCore.getUser(source).getUsedCharacter
    for each, player in ipairs(players) do
        if Character ~= nil then
			if Character.job == 'police' or Character.job == 'marshal' or Character.job == 'sheriff' then
				TriggerClientEvent("Witness:ToggleNotification2", player, coords, alert)
			end
        end
    end
end)