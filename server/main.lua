VORPcore = {}
TriggerEvent("getCore", function(core)
    VORPcore = core
end)

RegisterServerEvent('fists_robbery:bank')
AddEventHandler('fists_robbery:bank', function()
        local _source = source
        local Character = VorpCore.getUser(_source).getUsedCharacter
        TriggerClientEvent("vorp:TipBottom", _source, "JOHN: I have a job for you ", 5000)
		Citizen.Wait(5000)
		TriggerClientEvent("vorp:TipBottom", _source, "JOHN: The only problem is that you need some dynamite", 5000)
		Citizen.Wait(5000)
		TriggerClientEvent("vorp:TipBottom", _source, "JOHN: You want to do this ? ", 5000)
		Citizen.Wait(5000)
		TriggerClientEvent('fists_robbery:bankinfo', _source)
end)


RegisterServerEvent('fists_robbery:bankpay')
AddEventHandler('fists_robbery:bankpay', function()
        local _source = source
        local Character = VorpCore.getUser(_source).getUsedCharacter
        u_money = exports.VorpCore:char_money
        

    if u_money <= 0 then
        TriggerClientEvent("vorp:TipBottom", _source, "You have no money", 9000)
        return
    end

    TriggerEvent("vorp:removeMoney", _source, 0, 0)
    TriggerClientEvent("vorp:TipBottom", _source, "JOHN: Now Go To Rhodes Bank!", 5000)
	Citizen.Wait(1000)
    TriggerClientEvent('fists_robbery:bankgo', _source)    
end)


RegisterNetEvent("fists_robbery:startbankrobbery")
AddEventHandler("fists_robbery:startbankrobbery", function(robtime)
    local _source = source
    local Character = VorpCore.getUser(source).getUsedCharacter
    local count = exports.vorp_inventory:getItemCount(source, "dynamite")

    if count >= 1 then      
        exports.vorp_inventory:exports.vorp_inventory:subItem(source, "dynamite", 1, nil)
        isRobbing = false    
        TriggerClientEvent('fists_robbery:startAnimation2', _source)
        TriggerClientEvent('fists_robbery:endprompt',_source)
        Wait(5000)
        TriggerClientEvent("vorp:TipBottom", _source, "Sheriffs Have Been Alerted",6000)
    else   
        TriggerClientEvent("vorp:TipBottom", _source, "You dont have a dynamite", 6000)
    end     
end)


RegisterServerEvent('fists_robbery:bankloot')
AddEventHandler('fists_robbery:bankloot', function()
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    Blowedynamite = Blowedynamite    
        
    if Blowedynamite == true then
    end        
    TriggerClientEvent('fists_robbery:bankloot2', _source)    
end)

RegisterNetEvent("fists_robbery:bankpayout")
AddEventHandler("fists_robbery:bankpayout", function()
    TriggerEvent('vorp:getCharacter', source, function(user)
        local _source = source
        local _user = user
        ritem = math.random(1,2)
        local randomitempull = math.random(1, #Config.bankItems)
        local itemName = Config.bankItems[randomitempull]
           exports.vorp_inventory:exports.vorp_inventory:addItem(source, itemName, ritem, nil)
           
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