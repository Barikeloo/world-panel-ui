
RegisterCommand('worlds', function(source, args, rawCommand)
    print('[c-main] /worlds')
    SendNUIMessage({
        type = 'opened',
        worlds = worlds,
        inVeh = IsPedInAnyVehicle(PlayerPedId(), false),
    })
    SetNuiFocus(true, true)
end, false)

RegisterNUICallback('closed', function()
    print('[c-main] /worlds closed')
    SetNuiFocus(false, false)
end)

RegisterNUICallback('enter', function(cb)
    TriggerServerEvent('world-panel:sendToDimension', cb.world)
    SetNuiFocus(false, false)
end)
RegisterNUICallback('comeback', function()
    TriggerServerEvent('world-panel:ComeBack')
    SetNuiFocus(false, false)
end)