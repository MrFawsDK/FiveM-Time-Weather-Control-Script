local timeFrozen = false
local frozenHour = 12
local frozenMinute = 0
local weatherFrozen = false
local currentWeather = "CLEAR"

local weatherTypes = {
    "CLEAR", "EXTRASUNNY", "CLOUDS", "OVERCAST", "RAIN", "CLEARING", 
    "THUNDER", "SMOG", "FOGGY", "XMAS", "SNOWLIGHT", "BLIZZARD"
}

function isValidWeather(weather)
    for i = 1, #weatherTypes do
        if weatherTypes[i]:upper() == weather:upper() then
            return weatherTypes[i]
        end
    end
    return false
end

RegisterCommand('fawsfreeze', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'superadmin' then
        if not timeFrozen then
            timeFrozen = true
            if args[1] then
                frozenHour = tonumber(args[1]) or 12
            end
            if args[2] then
                frozenMinute = tonumber(args[2]) or 0
            end
            
            TriggerClientEvent('timefreeze:freezeTime', -1, true, frozenHour, frozenMinute)
            xPlayer.showNotification('Tiden er nu frosset på ' .. frozenHour .. ':' .. string.format("%02d", frozenMinute))
            print('[TimeFreeze] ' .. xPlayer.getName() .. ' har frosset tiden på ' .. frozenHour .. ':' .. string.format("%02d", frozenMinute))
        else
            timeFrozen = false
            TriggerClientEvent('timefreeze:freezeTime', -1, false, frozenHour, frozenMinute)
            xPlayer.showNotification('Tiden er nu unfrosset')
            print('[TimeFreeze] ' .. xPlayer.getName() .. ' har unfrosset tiden')
        end
    else
        xPlayer.showNotification('~r~Du har ikke tilladelse til at bruge denne kommando!')
    end
end, false)

RegisterCommand('fawstime', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'superadmin' then
        if args[1] and args[2] then
            local hour = tonumber(args[1])
            local minute = tonumber(args[2])
            
            if hour and minute and hour >= 0 and hour <= 23 and minute >= 0 and minute <= 59 then
                frozenHour = hour
                frozenMinute = minute
                
                if timeFrozen then
                    TriggerClientEvent('timefreeze:freezeTime', -1, true, frozenHour, frozenMinute)
                else
                    TriggerClientEvent('timefreeze:setTime', -1, frozenHour, frozenMinute)
                end
                
                xPlayer.showNotification('Tiden er sat til ' .. frozenHour .. ':' .. string.format("%02d", frozenMinute))
            else
                xPlayer.showNotification('~r~Ugyldig tid! Brug: /fawstime [time 0-23] [minut 0-59]')
            end
        else
            xPlayer.showNotification('~r~Brug: /fawstime [time 0-23] [minut 0-59]')
        end
    else
        xPlayer.showNotification('~r~Du har ikke tilladelse til at bruge denne kommando!')
    end
end, false)

RegisterCommand('fawsweather', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'superadmin' then
        if not weatherFrozen then
            local weather = "CLEAR"
            if args[1] then
                local validWeather = isValidWeather(args[1])
                if validWeather then
                    weather = validWeather
                else
                    xPlayer.showNotification('~r~Ugyldigt vejr! Tilgængelige: ' .. table.concat(weatherTypes, ', '))
                    return
                end
            end
            
            weatherFrozen = true
            currentWeather = weather
            TriggerClientEvent('timefreeze:freezeWeather', -1, true, currentWeather)
            xPlayer.showNotification('Vejret er nu frosset på: ' .. currentWeather)
            print('[TimeFreeze] ' .. xPlayer.getName() .. ' har frosset vejret på ' .. currentWeather)
        else
            weatherFrozen = false
            TriggerClientEvent('timefreeze:freezeWeather', -1, false, currentWeather)
            xPlayer.showNotification('Vejret er nu unfrosset')
            print('[TimeFreeze] ' .. xPlayer.getName() .. ' har unfrosset vejret')
        end
    else
        xPlayer.showNotification('~r~Du har ikke tilladelse til at bruge denne kommando!')
    end
end, false)

RegisterCommand('fawssetweather', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'superadmin' then
        if args[1] then
            local validWeather = isValidWeather(args[1])
            if validWeather then
                currentWeather = validWeather
                
                if weatherFrozen then
                    TriggerClientEvent('timefreeze:freezeWeather', -1, true, currentWeather)
                else
                    TriggerClientEvent('timefreeze:setWeather', -1, currentWeather)
                end
                
                xPlayer.showNotification('Vejret er sat til: ' .. currentWeather)
                print('[TimeFreeze] ' .. xPlayer.getName() .. ' har sat vejret til ' .. currentWeather)
            else
                xPlayer.showNotification('~r~Ugyldigt vejr! Tilgængelige: ' .. table.concat(weatherTypes, ', '))
            end
        else
            xPlayer.showNotification('~r~Brug: /fawssetweather [vejrtype]')
            xPlayer.showNotification('Tilgængelige vejrtyper: ' .. table.concat(weatherTypes, ', '))
        end
    else
        xPlayer.showNotification('~r~Du har ikke tilladelse til at bruge denne kommando!')
    end
end, false)

RegisterCommand('fawsweatherlist', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'superadmin' then
        xPlayer.showNotification('Tilgængelige vejrtyper:')
        Wait(1000)
        for i = 1, #weatherTypes do
            xPlayer.showNotification(i .. '. ' .. weatherTypes[i])
            Wait(500)
        end
    else
        xPlayer.showNotification('~r~Du har ikke tilladelse til at bruge denne kommando!')
    end
end, false)

AddEventHandler('playerConnecting', function()
    local source = source
    Wait(5000)
    if timeFrozen then
        TriggerClientEvent('timefreeze:freezeTime', source, true, frozenHour, frozenMinute)
    end
    if weatherFrozen then
        TriggerClientEvent('timefreeze:freezeWeather', source, true, currentWeather)
    end
end)