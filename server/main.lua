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
		TriggerClientEvent('mushy_robbery:info', _source)
end)


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
		TriggerClientEvent('mushy_robbery:info', _source)
end)


RegisterServerEvent('mushy_robbery:pay')
AddEventHandler('mushy_robbery:pay', function()
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
    TriggerClientEvent('mushy_robbery:go', _source)    
end)

RegisterNetEvent("mushy_robbery:startrobbery")
AddEventHandler("mushy_robbery:startrobbery", function(robtime)
    local _source = source
    local Character = VorpCore.getUser(source).getUsedCharacter
    local count = VORP.getItemCount(_source, "dynamite")

    if count >= 1 then      
        VORP.subItem(_source,"dynamite", 1)
        isRobbing = false    
        TriggerClientEvent('mushy_robbery:startAnimation2', _source)
        TriggerClientEvent('marshal_rob:endprompt',_source)
        Wait(5000)
        TriggerClientEvent("vorp:TipBottom", _source, "Sheriffs Have Been Alerted",6000)
    else   
        TriggerClientEvent("vorp:TipBottom", _source, "You dont have a dynamite", 6000)
    end     
end)

RegisterServerEvent('mushy_robbery:loot')
AddEventHandler('mushy_robbery:loot', function()
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    Blowedynamite = Blowedynamite    
        
    if Blowedynamite == true then
    end        
    TriggerClientEvent('mushy_robbery:loot2', _source)    
end)

RegisterNetEvent("mushy_robbery:payout")
AddEventHandler("mushy_robbery:payout", function()
    TriggerEvent('vorp:getCharacter', source, function(user)
        local _source = source
        local _user = user
       -- randommoney = math.random(10,20)
        ritem = math.random(5,5)
        local randomitempull = math.random(1, #Config.Items)
        local itemName = Config.Items[randomitempull]
           VORP.addItem(_source, itemName, ritem)
    end)
        --iggerClientEvent("vorp:TipBottom", _source, 'You Got The Loot', 5000)
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