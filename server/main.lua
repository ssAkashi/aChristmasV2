ESX = nil
TriggerEvent(ChristmasConfig.getESX, function(lib) ESX = lib  end)

local actionLimit = {}
local accessToGift = {}
local vehicleToSpawn = {}
local identifier
local gift

function getIdentifier(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    identifier = xPlayer.identifier
    return identifier
end

RegisterNetEvent('christmas:checkAccessCalendar')
AddEventHandler('christmas:checkAccessCalendar', function()
    local _src = source
    local days = os.date("%d")
    getIdentifier(_src)
    Wait(10)
    MySQL.Async.fetchAll('SELECT * FROM calendar WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(result)
        if result[1] then
            if result[1].days ~= days then
                MySQL.Async.execute('DELETE FROM calendar WHERE identifier = @identifier', {
                    ['@identifier'] = identifier
                })
                TriggerClientEvent('christmas:AccessCalendar', _src, true)
                accessToGift[identifier] = true
            else
                TriggerClientEvent('christmas:AccessCalendar', _src, false)
                accessToGift[identifier] = false
            end
        else
            TriggerClientEvent('christmas:AccessCalendar', _src, true)
            accessToGift[identifier] = true
        end
    end)
end)

RegisterNetEvent('christmas:collectSnowballs')
AddEventHandler('christmas:collectSnowballs', function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    if actionLimit[xPlayer.identifier] then return end
    christmasServerEntity:collectSnowballs(_src)
    actionLimit[xPlayer.identifier] = false
end)

RegisterNetEvent('christmas:actionVehicle')
AddEventHandler('christmas:actionVehicle', function(action)
    local _src = source
    local pPos = GetEntityCoords(GetPlayerPed(_src))
    local pHeading = GetEntityHeading(GetPlayerPed(_src))
    getIdentifier(_src)
    Wait(10)
    if action == 'spawn' then
        vehicleToSpawn[identifier] = christmasServerEntity:createVehicle(ChristmasConfig.vehicle, pPos, pHeading)
        SetVehicleCustomPrimaryColour(vehicleToSpawn[identifier]:getId(), 255, 0, 0)
        SetVehicleCustomSecondaryColour(vehicleToSpawn[identifier]:getId(), 255, 0, 0)
        TaskWarpPedIntoVehicle(_src, vehicleToSpawn[identifier]:getId(), -1)
    elseif action == 'delete' then
        DeleteEntity(vehicleToSpawn[identifier]:getId())
        vehicleToSpawn[identifier] = nil
    end
end)

RegisterNetEvent('christmas:gift')
AddEventHandler('christmas:gift', function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local days = os.date("%d")
    local randomReward = math.random(1,3)
    local reward = ChristmasConfig.rewards[randomReward]
    if reward.name == 'money' then
        gift = "Money | "..reward.quantity.." $"
        if ChristmasConfig.useCalifornia then
            xPlayer.addAccountMoney('cash', tonumber(reward.quantity))
        else
            xPlayer.addMoney(tonumber(reward.quantity))
        end
        TriggerClientEvent('christmas:notify', _src, ChristmasConfig.messages["reward_money_message"]:format(reward.quantity))
        ChristmasServer.log("**Player** : "..GetPlayerName(_src).."\n**ID** : ".._src.."\n**Gift Calendar** : x"..reward.quantity.."$")
    elseif reward.name == 'weapon' then
        local weapon = ChristmasConfig.giftList.weaponList[math.random(1, ChristmasConfig.maxWeapon)]
        gift = "Weapon | "..weapon.label.." - x"..reward.weaponAmmo
        xPlayer.addWeapon(weapon.name, reward.weaponAmmo)
        TriggerClientEvent('christmas:notify', _src, ChristmasConfig.messages["reward_weapon_message"]:format(weapon.label, reward.weaponAmmo))
        ChristmasServer.log("**Player** : "..GetPlayerName(_src).."\n**ID** : ".._src.."\n**Gift Calendar** : "..weapon.label.." ("..reward.weaponAmmo..")")
    elseif reward.name == 'item' then
        local item = ChristmasConfig.giftList.itemList[math.random(1, ChristmasConfig.maxItem)]
        gift = "Item | "..item.label.." - x"..reward.quantity
        xPlayer.addInventoryItem(item.name, tonumber(reward.quantity))
        TriggerClientEvent('christmas:notify', _src, ChristmasConfig.messages["reward_item_message"]:format(reward.quantity, item.label))
        ChristmasServer.log("**Player** : "..GetPlayerName(_src).."\n**ID** : ".._src.."\n**Gift Calendar** : "..item.label.." (x"..reward.quantity..")")
    end
    getIdentifier(_src)
    Wait(10)
    if accessToGift[identifier] then
        MySQL.Async.execute('INSERT INTO calendar (identifier,gift,days) VALUES (@identifier,@gift,@days)', {
            ['@identifier'] = identifier,
            ['@gift'] = gift,
            ['@days'] = days,
        })
        TriggerClientEvent('christmas:AccessCalendar', _src, false)
        accessToGift[identifier] = false
    else
        DropPlayer(_src, "Kick pour utilisation de triggers.")
    end
end)