ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local open = false
local mainMenu = RageUI.CreateMenu('Weed', 'interaction', nil, nil, "root_cause1", "img_blue")
mainMenu.Display.Header = true
mainMenu.Closed = function()
    open = false
    FreezeEntityPosition(PlayerPedId(), false)
end

RegisterNetEvent('xDrugs:weedOn')
AddEventHandler('xDrugs:weedOn',function()
    exports['progressBars']:startUI(1000, "Traitement en cours...")
    RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
    TaskPlayAnim((GetPlayerPed(-1)),"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer", 8.0, -8, -1, 16, 0, 0, 0, 0)
    Wait(1000)
    TriggerServerEvent('xDrugs:traiterweed')
    ClearPedTasksImmediately(PlayerPedId())
end)

function traiterweed()
    local traiter = true

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
                    if traiter == true then
                        RageUI.ButtonWithStyle('Traiter de la weed', nil, {RightBadge = RageUI.BadgeStyle.Weed}, true, function(Hovered, s, Selected)                                                                                                                   
                            if Selected then
                                local type = 1
                                TriggerServerEvent('xDrugs:check', type)
                                traiter = false
                                Wait(1000)
                                traiter = true
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
        for k in pairs(Config.Position.Weed.Traitement) do
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        local pos = Config.Position.Weed.Traitement
        local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)

        if dist <= Config.MarkerDistance then
            wait = 0
            DrawMarker(Config.MarkerType, pos[k].x, pos[k].y, pos[k].z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  
        end

        if dist <= 1.5 then
            wait = 0
            Visual.Subtitle(Config.TextAll, 1)
            if IsControlJustPressed(1,51) then
                FreezeEntityPosition(PlayerPedId(-1), true)
                traiterweed()
            end
        end
    end
    Citizen.Wait(wait)
    end
end)

--- Xed#1188