ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local open = false
local mainMenu = RageUI.CreateMenu('Coke', 'interaction', nil, nil, "root_cause1", "img_blue")
mainMenu.Display.Header = true
mainMenu.Closed = function()
    open = false
    FreezeEntityPosition(PlayerPedId(), false)
end

function recoltecoke()
    local recolte = true

    if open then
        open = false
        RageUI.Visible(mainMenu, false)
    else
        open = true
        RageUI.Visible(mainMenu, true)
        Citizen.CreateThread(function()
            while open do
                Wait(0)
                RageUI.IsVisible(mainMenu, function()
                    if recolte == true then
                        RageUI.ButtonWithStyle('Recolter de la coca', nil, {RightBadge = RageUI.BadgeStyle.Coke}, true, function(Hovered, s, Selected)                                                                                                                   
                            if Selected then
                                exports['progressBars']:startUI(5000, "Récolte en cours...")
                                TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_GARDENER_PLANT', 0, true)
                                Wait(5000)
                                TriggerServerEvent('xDrugs:recoltecoke')
                                recolte = false
                                Wait(1000)
                                recolte = true
                                ClearPedTasksImmediately(PlayerPedId())
                            end
                        end)
                    else
                    end
                end)
            end
        end)
    end
end

Citizen.CreateThread(function()
    while true do
        local wait = 750
        for k in pairs(Config.Position.Coke.Recolte) do
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        local pos = Config.Position.Coke.Recolte
        local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)

        if dist <= Config.MarkerDistance then
            wait = 0
            DrawMarker(Config.MarkerType, pos[k].x, pos[k].y, pos[k].z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  
        end

        if dist <= 3.0 then
            wait = 0
            Visual.Subtitle(Config.TextAll, 1)
            if IsControlJustPressed(1,51) then
                FreezeEntityPosition(PlayerPedId(-1), true)
                recoltecoke()
            end
        end
    end
    Citizen.Wait(wait)
    end
end)

--- Xed#1188