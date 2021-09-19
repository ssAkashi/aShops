ESX = nil
TriggerEvent(Config.getESX, function(obj) ESX = obj end)

RegisterServerEvent('aShops:buyItem')
AddEventHandler('aShops:buyItem', function(label, name, price, category, moneyType)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local pMoney = xPlayer.getMoney()
    local pMoneyBank = xPlayer.getAccount(Config.bankType).money
    local pPos = GetEntityCoords(GetPlayerPed(source))
    for _,coord in pairs(Config.shops.zones) do
        local posZones = vector3(coord.x, coord.y, coord.z)
        local distance = #(pPos - posZones)
        if distance <= 15.0 then
            if moneyType == Config.cashType then
                if pMoney >= price then
                    xPlayer.removeMoney(price)
                    xPlayer.addInventoryItem(name, 1)
                    TriggerClientEvent('esx:showNotification', _src, Config.messages.notifBuy:format(label, price, category))
                else
                    TriggerClientEvent('esx:showNotification', _src, Config.messages.dontHaveMoney:format(price - pMoney))
                end
            end
            if moneyType == Config.bankType then
                if pMoneyBank >= price then
                    xPlayer.removeAccountMoney('bank', price)
                    xPlayer.addInventoryItem(name, 1)
                    TriggerClientEvent('esx:showNotification', _src, Config.messages.notifBuy:format(label, price, category))
                else
                    TriggerClientEvent('esx:showNotification', _src, Config.messages.dontHaveMoney:format(price - pMoney))
                end
            end
        else
            DropPlayer(_src, "Vous avez été kick pour cheater.")
        end
    end
end)

ESX.RegisterServerCallback('aShops:getMoney', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local pMoney = xPlayer.getMoney()
    cb(pMoney)
end)