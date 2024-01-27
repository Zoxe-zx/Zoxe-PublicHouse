local Ox_Lib = GetResourceState('ox_lib'):find('start') or false

RegisterServerEvent('PublicHouse:ShopKey')
AddEventHandler('PublicHouse:ShopKey', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getMoney() >= PublicHouse.Config.ItemPrice then
        xPlayer.removeMoney(PublicHouse.Config.ItemPrice)
        xPlayer.addInventoryItem(PublicHouse.Config.Item, 1)
    end
end)

-- AddEventHandler('onServerResourceStart', function(source)
--     if source then
--         Stash(source)
--     end
-- end)

-- AddEventHandler('playerConnecting', function(source)
--     if source then
--         Stash(source)
--     end
-- end)

AddEventHandler('esx:playerLoaded', function(source)
    if source then
        Stash(source)
    end
end)

RegisterServerEvent('PublicHouse:JoinHouse', function()
    SetPlayerRoutingBucket(source, source)
end)

RegisterServerEvent('PublicHouse:LeaveHouse', function()
    SetPlayerRoutingBucket(source, 0)
end)

function Stash(source)
    for k, v in pairs(PublicHouse.House) do
        if Ox_Lib then
            Wait(100)
            if v.StashName == true then
                local PlayerName = GetPlayerName(source):gsub("(%a)([%w_']*)", function(first, rest)
                    return first:upper() .. rest:lower()
                end)
                print(PlayerName .. PublicHouse.Translation["StashName"])

                exports.ox_inventory:RegisterStash(k, PlayerName .. PublicHouse.Translation["StashName"], v.MaxSlots, v.MaxWeight, true)
            elseif v.StashName == false then
                exports.ox_inventory:RegisterStash(k, PublicHouse.Translation["Stash"], v.MaxSlots, v.MaxWeight, true)
            else
                if v.StashName == '' then return end
                exports.ox_inventory:RegisterStash(k, v.StashName, v.MaxSlots, v.MaxWeight, true)
            end
        end
    end
end
