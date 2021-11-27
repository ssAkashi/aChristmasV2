ESX = nil
CreateThread(function()
    while ESX == nil do TriggerEvent(ChristmasConfig.getESX, function(lib) ESX = lib end)
        Wait(10)
    end
end)

Keys.Register(ChristmasConfig.commands.keyOpen, ChristmasConfig.commands.commandName, ChristmasConfig.messages["command_description"], function()
    if not isMenuOpened then
        openMenu()
        isMenuOpened = true
        if ChristmasConfig.enableMusic then
            PlayUrl("christmasMusic", "https://www.youtube.com/watch?v=f61Q4tGLeCQ", 0.2, false)
        end
    else
        isMenuOpened = false
        if ChristmasConfig.enableMusic then
            Destroy("christmasMusic")
        end
    end
end)

RegisterNetEvent('christmas:AccessCalendar')
AddEventHandler('christmas:AccessCalendar', function(access)
    if access then
        ChristmasConfig.accessCalendar = true
    else
        ChristmasConfig.accessCalendar = false
    end
end)

if ChristmasConfig.time.enableSnow then
    CreateThread(function()
        while true do
            SetOverrideWeather('XMAS')
            Wait(5000)
        end
    end)
end

function Outfit(action)
    if ChristmasConfig.useCalifornia then
        if action then
            helmet = {
                ['helmet_1'] = ChristmasConfig.outfits.helmet1, ['helmet_2'] =  ChristmasConfig.outfits.helmet2,
            }
            for k,v in pairs(helmet) do
                TriggerEvent('::{korioz#0110}::skinchanger:change', k, v)
            end
        else
            ESX.TriggerServerCallback('::{korioz#0110}::esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('::{korioz#0110}::skinchanger:loadSkin', skin)
            end)
        end
    else
        if action then
            helmet = {
                ['helmet_1'] = ChristmasConfig.outfits.helmet1, ['helmet_2'] =  ChristmasConfig.outfits.helmet2,
            }
            for k,v in pairs(helmet) do
                TriggerEvent(ChristmasConfig.events.skinchangerchange, k, v)
            end
        else
            ESX.TriggerServerCallback(ChristmasConfig.events.getPlayerSkin, function(skin)
                TriggerEvent(ChristmasConfig.events.loadskin, skin)
            end)
        end
    end
end

CreateThread(function()
    Wait(2000)
    if ChristmasConfig.accessCalendar then
        Christmas.consoleLog("^2CHECK ACCESS CALENDAR^0...")
        TriggerServerEvent('christmas:checkAccessCalendar')
    end
end)