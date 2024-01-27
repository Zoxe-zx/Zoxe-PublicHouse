PublicHouse = {} -- Zoxe House® --

PublicHouse.Config = {

    System = 'Auto',

    Blip = vector3(470.08, -1564.24, 28.28),
    BlipName = 'Public House',
    BlipType = 475,
    BlipScale = 0.8,
    BlipColor = 56,

    Npc = vector4(470.08, -1564.24, 28.28, 196.12),
    NpcName = 'cs_mrk',

    KeyPress = 38,
    BigMarker = { 2, Value, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.5, 1.5, 0.5, 255, 128, 0, 50, true, true, 2, nil, nil, false },
    SmallMarker = { 2, Value, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.2, 0.2, 0.2, 255, 128, 0, 50, true, true, 2, nil, nil, false },
    BigDistance = 2.0,
    SmallDistance = 1.20,

    Item = 'keys',
    PriceValue = '$',
    ItemPrice = 1,

    AddHealth = true,
    PercentHealth = 200,
    PercentSetHealth = 25,
}

PublicHouse.House = {
    ["House"] = {
        Join = vector3(460.7803, -1573.5823, 32.7928),
        Interior = vector3(266.02584, -1007.537, -101.0087),
        Wardrobe = vector3(259.61526, -1004.039, -99.00855),
        Toilet = vector3(256.2837, -1000.2222, -100.3139),
        Shower = vector3(254.5470, -1000.3011, -98.9275),
        Bed = vector3(262.4566, -1004.2775, -98.2644),
        Cooking = vector3(266.4787, -995.8928, -98.0448),
        Cleaning = vector3(265.5347, -994.9930, -98.0448),
        Stash = vector3(265.68, -997.76, -99.0),
        StashName = true,
        MaxSlots = 80,
        MaxWeight = 150000
    },
}

function PublicHouse_Stash(k, Ox_Inventory)
    if Ox_Inventory then
        exports.ox_inventory:openInventory('stash', { id = k, owner = ESX.GetPlayerData().identifier })
    else
        print('No Detected, Insert Export System Here: ' .. debug.getinfo(1, "S").source:match("@(.*)$"))
    end
end

function PublicHouse_Wardrobe(Fivem_Appearance, Illenium_Appearance)
    if Fivem_Appearance then
        exports['fivem-appearance']:openWardrobe()
    elseif Illenium_Appearance then
        TriggerEvent('illenium-appearance:client:openOutfitMenu')
    else
        print('No Detected, Insert Export System Here: ' .. debug.getinfo(1, "S").source:match("@(.*)$"))
    end
end

function PublicHouse_Health(PlayerPed)
    local Health = GetEntityHealth(PlayerPed)

    if Health < PublicHouse.Config.PercentHealth then
        SetEntityHealth(PlayerPed, Health + PublicHouse.Config.PercentSetHealth)
    end
end

PublicHouse.Translation = {

    ["Key"] = 'Key',
    ["SetOfKey"] = '🔑 - Set of keys, ',
    ["House"] = '🏡 - House',
    ["ShopHouse"] = 'Tecnocasa',

    ["Stash"] = 'Stash',
    ["StashName"] = '\'s House',

    ["Join"] = "Join",
    ["Leave"] = "Leave",
    ["Rent"] = "Rent",
    ["Inventory"] = "Inventory",
    ["Dressing"] = "T-Shirt",
    ["Toilet"] = "Toilet",
    ["Shower"] = "Shower",
    ["Bed"] = "Bed",
    ["Cooking"] = "Cooking",
}

-- function MyExport()
--     return
-- end
