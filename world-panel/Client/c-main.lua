Config = {}
Config.WhenKey = true
Config.Key = 'f10'
Config.Debug = false

local WorldPanel = {}
local opened = false

function WorldPanel:Debug(str)
    print("^5[WorldPanel]^0 " .. str)
end

RegisterCommand('worlds', function(source, args, rawCommand)
    if not opened then 
        opened = true
        if Config.Debug then
            WorldPanel:Debug('Panel oppened')
        end
        SendNUIMessage({
            type = 'opened',
            worlds = worlds,
            inVeh = IsPedInAnyVehicle(PlayerPedId(), false),
        })
        SetNuiFocus(true, true)
    else
        TriggerEvent('chatMessage', '[WorldPanel]', {10, 132, 255}, 'Panel is already opened')
    end
end)

RegisterNUICallback('closed', function()
    if opened then 
        opened = false
        if Config.Debug then
            WorldPanel:Debug('Panel closed')
        end
        SetNuiFocus(false, false)
    end
end)

RegisterNUICallback('enter', function(cb)
    if opened then 
        opened = false
        TriggerServerEvent('world-panel:sendToDimension', cb.world)
        SetNuiFocus(false, false)
        if Config.Debug then
            WorldPanel:Debug('Entering world dimension ' .. cb.world)
        end
    end
end)

RegisterNUICallback('comeback', function()
    if opened then 
        opened = false
        TriggerServerEvent('world-panel:ComeBack')
        SetNuiFocus(false, false)
    end
end)

if Config.WhenKey then 
    RegisterKeyMapping('worlds', 'Open World Panel', 'keyboard', Config.Key)
end