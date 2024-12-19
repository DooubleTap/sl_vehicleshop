local QBCore = exports['qb-core']:GetCoreObject()
local function ApplyCustomizations(veh, customizations)
    if customizations then
        if customizations.colours then
            SetVehicleColours(veh, customizations.colours.primary, customizations.colours.secondary)
        end
        if customizations.livery then
            SetVehicleLivery(veh, customizations.livery)
        end
        if customizations.tint then
            SetVehicleWindowTint(veh, customizations.tint)
        end
        if customizations.upgrades then
            SetVehicleMod(veh, 11, customizations.upgrades.engine or -1)       -- Engine
            SetVehicleMod(veh, 12, customizations.upgrades.brakes or -1)       -- Brakes
            SetVehicleMod(veh, 15, customizations.upgrades.suspension or -1) -- Suspension
            SetVehicleMod(veh, 18, customizations.upgrades.turbo or -1)      -- Turbo
            SetVehicleMod(veh, 13, customizations.upgrades.transmission or -1) -- Transmission
        end
        if customizations.extras then
            for extra, state in pairs(customizations.extras) do
                SetVehicleExtra(veh, extra, state)
            end
        end
    end
end

local function SpawnShowroomVehicles()
    for _, vehicle in pairs(Config.ShowroomVehicles) do
        QBCore.Functions.LoadModel(vehicle.model)
        local veh = CreateVehicle(vehicle.model, vehicle.coords.x, vehicle.coords.y, vehicle.coords.z, vehicle.coords.w, false, false)
        FreezeEntityPosition(veh, true)
        SetEntityInvincible(veh, true)
        SetVehicleDoorsLocked(veh, 2)
        SetVehicleNumberPlateText(veh, 'W00TW00T')
        ApplyCustomizations(veh, vehicle.customizations)
        exports.ox_target:addLocalEntity(veh, {
            {
                name = 'showroom_' .. vehicle.model,
                label = ('%s\nPrix: $%d\n[Achetez Maintenant]'):format(vehicle.model, vehicle.price),
                icon = 'fa-solid fa-car',
                onSelect = function()
                    TriggerServerEvent('showroom:attemptPurchase', vehicle.model, vehicle.price)
                end,
                canInteract = function()
                    local playerData = QBCore.Functions.GetPlayerData()
                    return playerData.job.name == vehicle.job.name and playerData.job.grade.level >= vehicle.job.grade
                end
            }
        })
    end
end

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    SpawnShowroomVehicles()
end)

RegisterNetEvent('showroom:spawnPurchasedVehicle', function(model, spawnCoords, customizations)
    QBCore.Functions.LoadModel(model)
    local veh = CreateVehicle(model, spawnCoords.x, spawnCoords.y, spawnCoords.z, spawnCoords.w, true, false)
    local plate = ('%s%d'):format('GOV', math.random(10000, 99999))
    SetVehicleNumberPlateText(veh, plate)
    TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
    SetEntityAsMissionEntity(veh, true, true)
    SetVehicleDirtLevel(veh, 0)
    ApplyCustomizations(veh, customizations)

    -- Add keys to the player's inventory with your designated export. (i use dusa_vehiclekeys but any works)
    exports['dusa_vehiclekeys']:AddKey(plate)
end)
