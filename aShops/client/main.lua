ESX = nil

function initBlips()
    for _,blip in pairs(Config.shops.zones) do
        local Blip = AddBlipForCoord(blip.x, blip.y, blip.z);
        SetBlipSprite(Blip, blip.blipSprite);
        SetBlipDisplay(Blip, 4);
        SetBlipScale(Blip, blip.blipScale);
        SetBlipColour(Blip, blip.blipColor);
        SetBlipAsShortRange(Blip, true);
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(blip.blipName)
        EndTextCommandSetBlipName(Blip)
    end
end

function initNPC()
    for _,npc in pairs(Config.shops.npc) do
        RequestModel(npc.model)
        while not HasModelLoaded(npc.model) do Wait(10) end
        RequestAnimDict(npc.dict);
        while not HasAnimDictLoaded(npc.dict) do Wait(10) end
        local createNPC =  CreatePed(4, npc.model, npc.x, npc.y, npc.z-1.0, npc.model, 0, 1)
        SetEntityHeading(createNPC, npc.heading)
        FreezeEntityPosition(createNPC, 1)
        SetEntityInvincible(createNPC, 1)
        SetBlockingOfNonTemporaryEvents(createNPC, 1)
        TaskPlayAnim(createNPC, npc.dict, npc.anim, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    end
end

CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config.getESX, function(obj) ESX = obj end)
        Wait(10)
    end
    if Config.enableBlip then
        initBlips()
    end
    if Config.enableNPC then
        initNPC()
    end
end)

CreateThread(function()
    local interval = 250
    while true do
        local pPos = GetEntityCoords(PlayerPedId())
        for _,coord in pairs(Config.shops.zones) do
            local posZones = vector3(coord.x, coord.y, coord.z)
            local distance = #(pPos - posZones)
            if distance <= Config.shops.marker.distanceMarker then
                interval = 0
                DrawMarker(Config.shops.marker.markerType, posZones, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, Config.shops.marker.markerColor.r, Config.shops.marker.markerColor.g, Config.shops.marker.markerColor.b, Config.shops.marker.markerColor.opacity, 5, 0, 1, 2, 0, 0, 0, 0)
                if distance <= 1.5 then
                    ESX.ShowHelpNotification(Config.notif:format("~INPUT_CONTEXT~"))
                    if IsControlJustPressed(1, 51) then
                        OpenShopMenu()
                        isMenuOpen = true
                    end
                else
                    isMenuOpen = false
                end
            else
                interval = 250
            end
        end
        Wait(interval)
    end
end)