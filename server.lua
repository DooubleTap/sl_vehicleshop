local QBCore = exports['qb-core']:GetCoreObject()
RegisterNetEvent('showroom:attemptPurchase', function(model, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local playerMoney = Player.Functions.GetMoney('bank')
    if playerMoney >= price then
        Player.Functions.RemoveMoney('bank', price)
        local plate = ('%s%d'):format('FED', math.random(1000, 9999))
        local citizenid = Player.PlayerData.citizenid
        TriggerClientEvent('QBCore:Notify', src, 'Vous avez acheté le véhicule!', 'success')
        local vehicleConfig = nil
        for _, vehicle in pairs(Config.ShowroomVehicles) do
            if vehicle.model == model then
                vehicleConfig = vehicle
                break
            end
        end
        if vehicleConfig then
            local vehicleHash = GetHashKey(model)
            MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
                Player.PlayerData.license,
                citizenid,
                model,
                vehicleHash,
                json.encode(vehicleConfig.customizations or {}),
                plate,
                'Central', -- Default garage (you might wanna edit this)
                0
            })
            TriggerClientEvent('showroom:spawnPurchasedVehicle', src, model, vector4(838.1, -1320.73, 25.89, 53.97), vehicleConfig.customizations)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'Manque de fonds', 'error')
    end
end)
