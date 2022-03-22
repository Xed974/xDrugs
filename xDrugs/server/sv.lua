ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('xDrugs:recolteweed')
AddEventHandler('xDrugs:recolteweed', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addInventoryItem('weed', 1)
end)

RegisterServerEvent('xDrugs:traiterweed')
AddEventHandler('xDrugs:traiterweed',function()
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('weed', 2)
    xPlayer.addInventoryItem('weedtraite', 1)
end)

--

RegisterServerEvent('xDrugs:recoltecoke')
AddEventHandler('xDrugs:recoltecoke', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addInventoryItem('coke', 1)
end)

RegisterServerEvent('xDrugs:traitercoke')
AddEventHandler('xDrugs:traitercoke', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('coke', 2)
    xPlayer.addInventoryItem('coketraite', 1)
end)

--

RegisterServerEvent('xDrugs:check')
AddEventHandler('xDrugs:check', function(type)
    local xPlayer = ESX.GetPlayerFromId(source)

    if type == 1 then
        local drugs = xPlayer.getInventoryItem('weed').count
        if drugs > 1 then
            TriggerClientEvent('xDrugs:weedOn', source)
        else
            TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez de ~r~feuille de weed~s~ !')
        end
    elseif type == 2 then
        local drugs = xPlayer.getInventoryItem('coke').count
        if drugs > 1 then
            TriggerClientEvent('xDrugs:cokeOn', source)
        else
            TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez de ~r~feuille de coca~s~ !')
        end
    end
end)

--- Xed#1188