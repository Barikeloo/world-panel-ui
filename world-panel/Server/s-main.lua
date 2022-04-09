RegisterServerEvent('world-panel:sendToDimension', function(world)
    SetPlayerRoutingBucket(source, tonumber(world))
end)

RegisterServerEvent('world-panel:ComeBack', function()
    SetPlayerRoutingBucket(source, 0)
end)