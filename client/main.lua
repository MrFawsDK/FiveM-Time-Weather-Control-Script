local timeFrozen = false
local frozenHour = 12
local frozenMinute = 0
local weatherFrozen = false
local currentWeather = "CLEAR"

local weatherTypes = {
    "CLEAR", "EXTRASUNNY", "CLOUDS", "OVERCAST", "RAIN", "CLEARING", 
    "THUNDER", "SMOG", "FOGGY", "XMAS", "SNOWLIGHT", "BLIZZARD"
}

Citizen.CreateThread(function()
    while true do
        if timeFrozen then
            NetworkOverrideClockTime(frozenHour, frozenMinute, 0)
        end
        
        if weatherFrozen then
            SetWeatherTypeNow(currentWeather)
            SetWeatherTypeNowPersist(currentWeather)
        end
        
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('timefreeze:freezeTime')
AddEventHandler('timefreeze:freezeTime', function(freeze, hour, minute)
    timeFrozen = freeze
    frozenHour = hour
    frozenMinute = minute
    
    if freeze then
        NetworkOverrideClockTime(frozenHour, frozenMinute, 0)
        ESX.ShowNotification('Tiden er frosset på ' .. frozenHour .. ':' .. string.format("%02d", frozenMinute))
    else
        ESX.ShowNotification('Tiden er ikke længere frosset')
    end
end)

RegisterNetEvent('timefreeze:setTime')
AddEventHandler('timefreeze:setTime', function(hour, minute)
    NetworkOverrideClockTime(hour, minute, 0)
    ESX.ShowNotification('Tiden er sat til ' .. hour .. ':' .. string.format("%02d", minute))
end)

RegisterNetEvent('timefreeze:freezeWeather')
AddEventHandler('timefreeze:freezeWeather', function(freeze, weather)
    weatherFrozen = freeze
    currentWeather = weather
    
    if freeze then
        SetWeatherTypeNow(currentWeather)
        SetWeatherTypeNowPersist(currentWeather)
        ESX.ShowNotification('Vejret er frosset på: ' .. currentWeather)
    else
        ESX.ShowNotification('Vejret er ikke længere frosset')
    end
end)

RegisterNetEvent('timefreeze:setWeather')
AddEventHandler('timefreeze:setWeather', function(weather)
    currentWeather = weather
    SetWeatherTypeNow(currentWeather)
    SetWeatherTypeNowPersist(currentWeather)
    ESX.ShowNotification('Vejret er sat til: ' .. currentWeather)
end)