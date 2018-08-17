-- DO NOT CHANGE ANY OF THIS CODE! IF SOMETHING DOESNT WORK CONTACT @lukepollie ON THE FIVEM FORUMS!!!
-- DO NOT CHANGE ANY OF THIS CODE! IF SOMETHING DOESNT WORK CONTACT @lukepollie ON THE FIVEM FORUMS!!!
-- DO NOT CHANGE ANY OF THIS CODE! IF SOMETHING DOESNT WORK CONTACT @lukepollie ON THE FIVEM FORUMS!!!
-- DO NOT CHANGE ANY OF THIS CODE! IF SOMETHING DOESNT WORK CONTACT @lukepollie ON THE FIVEM FORUMS!!!


RegisterCommand("onduty", function(source, args, rawCommand)
    Stuff() 
end, false)


function Stuff()
    local model = GetHashKey("S_M_Y_Fireman_01") -- Change model name here <--
    RequestModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(0)
    end
    SetPlayerModel(PlayerId(), model)
    SetModelAsNoLongerNeeded(model)
    local ped = PlayerPedId()
    local name = GetPlayerName(_source)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HATCHET"), 1000, false) -- Change weapon hash here <--
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLASHLIGHT"), 1000, false) -- Change weapon hash here <--
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FIREEXTINGUISHER"), 1000, false) -- Change weapon hash here <--
    SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
    TriggerEvent('chatMessage', "^*FireFighter", { 255, 26, 71 }, name .. " IS NOW ONDUTY!") -- Change chatmessage here <--
end

RegisterCommand("offduty", function(source, args, rawCommand)
    Other()
end, false)

function Other()
    local model = GetHashKey("a_m_m_business_01") -- Change model name here <--
    RequestModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(0)
    end
    SetPlayerModel(PlayerId(), model)
    SetModelAsNoLongerNeeded(model)
    local Ped = PlayerPedId()
    local name = GetPlayerName(_source)
    RemoveAllPedWeapons(GetPlayerPed(-1))
    TriggerEvent('chatMessage', "^*FireFighter", { 255, 26, 71 }, name .. " IS NOW OFFDUTY!") -- Change chatmessage here <--
end


function ShowNotification( text )
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(false, false)
end

RegisterCommand('spawn', function(source, args, rawCommand)
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 3.0, 0.5))
    local veh = args[1]
    if veh == nil then veh = "adder" end
    vehiclehash = GetHashKey(veh)
    RequestModel(vehiclehash)
    
    Citizen.CreateThread(function() 
        local waiting = 0
        while not HasModelLoaded(vehiclehash) do
            waiting = waiting + 100
            Citizen.Wait(100)
            if waiting > 5000 then
                ShowNotification("~r~Could not load the vehicle model in time, a crash was prevented.")
                break
            end
        end
        CreateVehicle(vehiclehash, x, y, z, GetEntityHeading(PlayerPedId())+10, 1, 0)
    end)
end)
