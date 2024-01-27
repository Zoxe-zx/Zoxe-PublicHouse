local Ox_Lib = GetResourceState('ox_lib'):find('start') or false

local Ox_Inventory = GetResourceState('ox_inventory'):find('start') or false

local Fivem_Appearance = GetResourceState('fivem-appearance'):find('start') or false

local Illenium_Appearance = GetResourceState('illenium-appearance'):find('start') or false

function Blip(Name, Type, Scale, color, Coords) --{'Public House', (470.08, -1564.24, 28.28)}
    local Blip = AddBlipForCoord(Coords)

    SetBlipSprite(Blip, Type)
    SetBlipScale(Blip, Scale)
    SetBlipColour(Blip, color)
    SetBlipAsShortRange(Blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Name)
    EndTextCommandSetBlipName(Blip)
end

function Npc(Name, Coords) --{'cs_mrk', (470.08, -1564.24, 28.28, 196.12)}
    if (not Ox_Lib and PublicHouse.Config.System == 'Auto') or (not Ox_Lib or not PublicHouse.Config.System) then
        if not HasModelLoaded(Name) then
            RequestModel(Name)
            while not HasModelLoaded(Name) do
                Citizen.Wait(5)
            end
        end

        local Npc = CreatePed(0, Name, Coords, false, true) --4

        FreezeEntityPosition(Npc, true)
        SetEntityInvincible(Npc, true)
        SetBlockingOfNonTemporaryEvents(Npc, true)

        CreateThread(function()
            while true do
                local Distance = #(GetEntityCoords(PlayerPedId()) - vector3(Coords.x, Coords.y, Coords.z))

                if Distance >= 5.0 then
                    Sleep = 1000
                else
                    Sleep = 0

                    DrawMarker(2, Coords.x, Coords.y, Coords.z + 2.4, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.5, 1.5, 0.5, 255, 128, 0, 50, true, true, 2, nil, nil, false)

                    if IsControlJustReleased(0, PublicHouse.Config.KeyPress) then
                        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "PublicHouse_ShopKey", {
                            title    = PublicHouse.Translation["ShopHouse"],
                            align    = 'top-left',
                            elements = {
                                { label = PublicHouse.Translation["SetOfKey"] .. PublicHouse.Config.ItemPrice .. PublicHouse.Config.PriceValue, name = "element1" },
                            }
                        }, function(data, menu)
                            if data.current.name == "element1" then
                                TriggerServerEvent('PublicHouse:ShopKey')
                                menu.close()
                            end
                        end, function(data, menu)
                            menu.close()
                        end)
                    end
                end

                Wait(Sleep)
            end
        end)
    else
        local Load = lib.requestModel(Name)

        if not Load then return end

        local Npc = CreatePed(0, Name, Coords, false, true)

        FreezeEntityPosition(Npc, true)
        SetEntityInvincible(Npc, true)
        SetBlockingOfNonTemporaryEvents(Npc, true)

        exports.ox_target:addLocalEntity(Npc, {
            {
                icon = 'fa-solid fa-key',
                label = PublicHouse.Translation["Key"],
                -- event = 'Event',
                --groups = 'Group',
                canInteract = function(entity)
                    return not IsEntityDead(entity)
                end,
                onSelect = function()
                    local input = lib.inputDialog(PublicHouse.Translation["ShopHouse"], {
                        {
                            type = 'select',
                            label = PublicHouse.Translation["House"],
                            options = {
                                { label = PublicHouse.Translation["SetOfKey"] .. PublicHouse.Config.ItemPrice .. PublicHouse.Config.PriceValue },
                            }
                        }
                    })
                    if not input then return end
                    TriggerServerEvent('PublicHouse:ShopKey', input[1])
                end
            }
        })
    end
end

function House()
    for k, v in pairs(PublicHouse.House) do
        if (not Ox_Lib and PublicHouse.Config.System == 'Auto') or (not Ox_Lib or not PublicHouse.Config.System) then
            CreateThread(function()
                while true do
                    local Distance = #(GetEntityCoords(PlayerPedId()) - v.Join)

                    if Distance >= PublicHouse.Config.BigDistance then
                        Sleep = 1000
                    else
                        Sleep = 0

                        DrawMarker(
                            PublicHouse.Config.BigMarker[1],
                            v.Join,
                            PublicHouse.Config.BigMarker[3],
                            PublicHouse.Config.BigMarker[4],
                            PublicHouse.Config.BigMarker[5],
                            PublicHouse.Config.BigMarker[6],
                            PublicHouse.Config.BigMarker[7],
                            PublicHouse.Config.BigMarker[8],
                            PublicHouse.Config.BigMarker[9],
                            PublicHouse.Config.BigMarker[10],
                            PublicHouse.Config.BigMarker[11],
                            PublicHouse.Config.BigMarker[12],
                            PublicHouse.Config.BigMarker[13],
                            PublicHouse.Config.BigMarker[14],
                            PublicHouse.Config.BigMarker[15],
                            PublicHouse.Config.BigMarker[16],
                            PublicHouse.Config.BigMarker[17],
                            PublicHouse.Config.BigMarker[18],
                            PublicHouse.Config.BigMarker[19],
                            PublicHouse.Config.BigMarker[20],
                            PublicHouse.Config.BigMarker[21]
                        )

                        if IsControlJustReleased(0, PublicHouse.Config.KeyPress) then
                            if HasItem(PublicHouse.Config.Item) then
                                DoScreenFadeOut(800)
                                while not IsScreenFadedOut() do
                                    Citizen.Wait(0)
                                end
                                TriggerServerEvent('PublicHouse:JoinHouse')
                                SetEntityCoords(PlayerPedId(), v.Interior)
                                DoScreenFadeIn(800)
                            end
                        end
                    end

                    Wait(Sleep)
                end
            end)

            CreateThread(function()
                while true do
                    local Distance = #(GetEntityCoords(PlayerPedId()) - v.Interior)

                    if Distance >= PublicHouse.Config.BigDistance then
                        Sleep = 1000
                    else
                        Sleep = 0

                        DrawMarker(
                            PublicHouse.Config.BigMarker[1],
                            v.Interior,
                            PublicHouse.Config.BigMarker[3],
                            PublicHouse.Config.BigMarker[4],
                            PublicHouse.Config.BigMarker[5],
                            PublicHouse.Config.BigMarker[6],
                            PublicHouse.Config.BigMarker[7],
                            PublicHouse.Config.BigMarker[8],
                            PublicHouse.Config.BigMarker[9],
                            PublicHouse.Config.BigMarker[10],
                            PublicHouse.Config.BigMarker[11],
                            PublicHouse.Config.BigMarker[12],
                            PublicHouse.Config.BigMarker[13],
                            PublicHouse.Config.BigMarker[14],
                            PublicHouse.Config.BigMarker[15],
                            PublicHouse.Config.BigMarker[16],
                            PublicHouse.Config.BigMarker[17],
                            PublicHouse.Config.BigMarker[18],
                            PublicHouse.Config.BigMarker[19],
                            PublicHouse.Config.BigMarker[20],
                            PublicHouse.Config.BigMarker[21]
                        )

                        if IsControlJustReleased(0, PublicHouse.Config.KeyPress) then
                            if HasItem(PublicHouse.Config.Item) then
                                DoScreenFadeOut(800)
                                while not IsScreenFadedOut() do
                                    Citizen.Wait(0)
                                end
                                TriggerServerEvent('PublicHouse:LeaveHouse')
                                SetEntityCoords(PlayerPedId(), v.Join)
                                DoScreenFadeIn(800)
                            end
                        end
                    end

                    Wait(Sleep)
                end
            end)

            CreateThread(function()
                while true do
                    local Distance = #(GetEntityCoords(PlayerPedId()) - v.Stash)

                    if Distance >= PublicHouse.Config.BigDistance then
                        Sleep = 1000
                    else
                        Sleep = 0

                        DrawMarker(
                            PublicHouse.Config.BigMarker[1],
                            v.Stash,
                            PublicHouse.Config.BigMarker[3],
                            PublicHouse.Config.BigMarker[4],
                            PublicHouse.Config.BigMarker[5],
                            PublicHouse.Config.BigMarker[6],
                            PublicHouse.Config.BigMarker[7],
                            PublicHouse.Config.BigMarker[8],
                            PublicHouse.Config.BigMarker[9],
                            PublicHouse.Config.BigMarker[10],
                            PublicHouse.Config.BigMarker[11],
                            PublicHouse.Config.BigMarker[12],
                            PublicHouse.Config.BigMarker[13],
                            PublicHouse.Config.BigMarker[14],
                            PublicHouse.Config.BigMarker[15],
                            PublicHouse.Config.BigMarker[16],
                            PublicHouse.Config.BigMarker[17],
                            PublicHouse.Config.BigMarker[18],
                            PublicHouse.Config.BigMarker[19],
                            PublicHouse.Config.BigMarker[20],
                            PublicHouse.Config.BigMarker[21]
                        )

                        if IsControlJustReleased(0, PublicHouse.Config.KeyPress) then
                            PublicHouse_Stash(k, Ox_Inventory)
                        end
                    end

                    Wait(Sleep)
                end
            end)

            CreateThread(function()
                while true do
                    local Distance = #(GetEntityCoords(PlayerPedId()) - v.Wardrobe)

                    if Distance >= PublicHouse.Config.BigDistance then
                        Sleep = 1000
                    else
                        Sleep = 0

                        DrawMarker(
                            PublicHouse.Config.BigMarker[1],
                            v.Wardrobe,
                            PublicHouse.Config.BigMarker[3],
                            PublicHouse.Config.BigMarker[4],
                            PublicHouse.Config.BigMarker[5],
                            PublicHouse.Config.BigMarker[6],
                            PublicHouse.Config.BigMarker[7],
                            PublicHouse.Config.BigMarker[8],
                            PublicHouse.Config.BigMarker[9],
                            PublicHouse.Config.BigMarker[10],
                            PublicHouse.Config.BigMarker[11],
                            PublicHouse.Config.BigMarker[12],
                            PublicHouse.Config.BigMarker[13],
                            PublicHouse.Config.BigMarker[14],
                            PublicHouse.Config.BigMarker[15],
                            PublicHouse.Config.BigMarker[16],
                            PublicHouse.Config.BigMarker[17],
                            PublicHouse.Config.BigMarker[18],
                            PublicHouse.Config.BigMarker[19],
                            PublicHouse.Config.BigMarker[20],
                            PublicHouse.Config.BigMarker[21]
                        )

                        if IsControlJustReleased(0, PublicHouse.Config.KeyPress) then
                            PublicHouse_Wardrobe(Fivem_Appearance, Illenium_Appearance)
                        end
                    end

                    Wait(Sleep)
                end
            end)

            CreateThread(function()
                while true do
                    local Distance = #(GetEntityCoords(PlayerPedId()) - v.Toilet)

                    if Distance >= PublicHouse.Config.SmallDistance then
                        Sleep = 1000
                    else
                        Sleep = 0

                        DrawMarker(
                            PublicHouse.Config.SmallMarker[1],
                            vector3(v.Toilet.x, v.Toilet.y, v.Toilet.z + 1.2),
                            PublicHouse.Config.SmallMarker[3],
                            PublicHouse.Config.SmallMarker[4],
                            PublicHouse.Config.SmallMarker[5],
                            PublicHouse.Config.SmallMarker[6],
                            PublicHouse.Config.SmallMarker[7],
                            PublicHouse.Config.SmallMarker[8],
                            PublicHouse.Config.SmallMarker[9],
                            PublicHouse.Config.SmallMarker[10],
                            PublicHouse.Config.SmallMarker[11],
                            PublicHouse.Config.SmallMarker[12],
                            PublicHouse.Config.SmallMarker[13],
                            PublicHouse.Config.SmallMarker[14],
                            PublicHouse.Config.SmallMarker[15],
                            PublicHouse.Config.SmallMarker[16],
                            PublicHouse.Config.SmallMarker[17],
                            PublicHouse.Config.SmallMarker[18],
                            PublicHouse.Config.SmallMarker[19],
                            PublicHouse.Config.SmallMarker[20],
                            PublicHouse.Config.SmallMarker[21]
                        )

                        if IsControlJustReleased(0, PublicHouse.Config.KeyPress) then
                            local Text = { 'Pee', 'Poop' }
                            local Random = math.random(1, #Text)

                            if Text[Random] == 'Pee' then
                                FreezeEntityPosition(PlayerPedId(), true)

                                local hashSkin = GetHashKey("mp_m_freemode_01")

                                if GetEntityModel(PlayerPedId()) == hashSkin then
                                    Pee(PlayerPedId(), 'male')
                                else
                                    SetEntityCoords(PlayerPedId(), v.Toilet)

                                    FreezeEntityPosition(PlayerPedId(), true)

                                    Pee(PlayerPedId(), 'female')

                                    FreezeEntityPosition(PlayerPedId(), false)
                                end

                                FreezeEntityPosition(PlayerPedId(), false)
                            elseif Text[Random] == 'Poop' then
                                SetEntityCoords(PlayerPedId(), v.Toilet)

                                FreezeEntityPosition(PlayerPedId(), true)

                                Poop(PlayerPedId())

                                FreezeEntityPosition(PlayerPedId(), false)
                            end
                        end
                    end

                    Wait(Sleep)
                end
            end)

            CreateThread(function()
                while true do
                    local Distance = #(GetEntityCoords(PlayerPedId()) - v.Shower)

                    if Distance >= PublicHouse.Config.SmallDistance then
                        Sleep = 1000
                    else
                        Sleep = 0

                        DrawMarker(
                            PublicHouse.Config.SmallMarker[1],
                            vector3(v.Shower.x, v.Shower.y, v.Shower.z + 1.56),
                            PublicHouse.Config.SmallMarker[3],
                            PublicHouse.Config.SmallMarker[4],
                            PublicHouse.Config.SmallMarker[5],
                            PublicHouse.Config.SmallMarker[6],
                            PublicHouse.Config.SmallMarker[7],
                            PublicHouse.Config.SmallMarker[8],
                            PublicHouse.Config.SmallMarker[9],
                            PublicHouse.Config.SmallMarker[10],
                            PublicHouse.Config.SmallMarker[11],
                            PublicHouse.Config.SmallMarker[12],
                            PublicHouse.Config.SmallMarker[13],
                            PublicHouse.Config.SmallMarker[14],
                            PublicHouse.Config.SmallMarker[15],
                            PublicHouse.Config.SmallMarker[16],
                            PublicHouse.Config.SmallMarker[17],
                            PublicHouse.Config.SmallMarker[18],
                            PublicHouse.Config.SmallMarker[19],
                            PublicHouse.Config.SmallMarker[20],
                            PublicHouse.Config.SmallMarker[21]
                        )

                        if IsControlJustReleased(0, PublicHouse.Config.KeyPress) then
                            Shower(PlayerPedId(), vector3(v.Shower.x, v.Shower.y, v.Shower.z + 1.2))
                        end
                    end

                    Wait(Sleep)
                end
            end)

            CreateThread(function()
                while true do
                    local Distance = #(GetEntityCoords(PlayerPedId()) - v.Bed)

                    if Distance >= PublicHouse.Config.SmallDistance then
                        Sleep = 1000
                    else
                        Sleep = 0

                        DrawMarker(
                            PublicHouse.Config.SmallMarker[1],
                            vector3(v.Bed.x, v.Bed.y, v.Bed.z - 0.5),
                            PublicHouse.Config.SmallMarker[3],
                            PublicHouse.Config.SmallMarker[4],
                            PublicHouse.Config.SmallMarker[5],
                            PublicHouse.Config.SmallMarker[6],
                            PublicHouse.Config.SmallMarker[7],
                            PublicHouse.Config.SmallMarker[8],
                            PublicHouse.Config.SmallMarker[9],
                            PublicHouse.Config.SmallMarker[10],
                            PublicHouse.Config.SmallMarker[11],
                            PublicHouse.Config.SmallMarker[12],
                            PublicHouse.Config.SmallMarker[13],
                            PublicHouse.Config.SmallMarker[14],
                            PublicHouse.Config.SmallMarker[15],
                            PublicHouse.Config.SmallMarker[16],
                            PublicHouse.Config.SmallMarker[17],
                            PublicHouse.Config.SmallMarker[18],
                            PublicHouse.Config.SmallMarker[19],
                            PublicHouse.Config.SmallMarker[20],
                            PublicHouse.Config.SmallMarker[21]
                        )

                        if IsControlJustReleased(0, PublicHouse.Config.KeyPress) then
                            Sleeps(PlayerPedId(), vector3(v.Bed.x, v.Bed.y, v.Bed.z - 1.7))
                        end
                    end

                    Wait(Sleep)
                end
            end)

            CreateThread(function()
                while true do
                    local Distance = #(GetEntityCoords(PlayerPedId()) - v.Cooking)

                    if Distance >= PublicHouse.Config.SmallDistance then
                        Sleep = 1000
                    else
                        Sleep = 0

                        DrawMarker(
                            PublicHouse.Config.SmallMarker[1],
                            vector3(v.Cooking.x, v.Cooking.y, v.Cooking.z - 0.5),
                            PublicHouse.Config.SmallMarker[3],
                            PublicHouse.Config.SmallMarker[4],
                            PublicHouse.Config.SmallMarker[5],
                            PublicHouse.Config.SmallMarker[6],
                            PublicHouse.Config.SmallMarker[7],
                            PublicHouse.Config.SmallMarker[8],
                            PublicHouse.Config.SmallMarker[9],
                            PublicHouse.Config.SmallMarker[10],
                            PublicHouse.Config.SmallMarker[11],
                            PublicHouse.Config.SmallMarker[12],
                            PublicHouse.Config.SmallMarker[13],
                            PublicHouse.Config.SmallMarker[14],
                            PublicHouse.Config.SmallMarker[15],
                            PublicHouse.Config.SmallMarker[16],
                            PublicHouse.Config.SmallMarker[17],
                            PublicHouse.Config.SmallMarker[18],
                            PublicHouse.Config.SmallMarker[19],
                            PublicHouse.Config.SmallMarker[20],
                            PublicHouse.Config.SmallMarker[21]
                        )

                        if IsControlJustReleased(0, PublicHouse.Config.KeyPress) then
                            Cooking(PlayerPedId(), v.Cooking)
                        end
                    end

                    Wait(Sleep)
                end
            end)

            CreateThread(function()
                while true do
                    local Distance = #(GetEntityCoords(PlayerPedId()) - v.Cleaning)

                    if Distance >= PublicHouse.Config.SmallDistance then
                        Sleep = 1000
                    else
                        Sleep = 0

                        DrawMarker(
                            PublicHouse.Config.SmallMarker[1],
                            vector3(v.Cleaning.x, v.Cleaning.y, v.Cleaning.z - 0.5),
                            PublicHouse.Config.SmallMarker[3],
                            PublicHouse.Config.SmallMarker[4],
                            PublicHouse.Config.SmallMarker[5],
                            PublicHouse.Config.SmallMarker[6],
                            PublicHouse.Config.SmallMarker[7],
                            PublicHouse.Config.SmallMarker[8],
                            PublicHouse.Config.SmallMarker[9],
                            PublicHouse.Config.SmallMarker[10],
                            PublicHouse.Config.SmallMarker[11],
                            PublicHouse.Config.SmallMarker[12],
                            PublicHouse.Config.SmallMarker[13],
                            PublicHouse.Config.SmallMarker[14],
                            PublicHouse.Config.SmallMarker[15],
                            PublicHouse.Config.SmallMarker[16],
                            PublicHouse.Config.SmallMarker[17],
                            PublicHouse.Config.SmallMarker[18],
                            PublicHouse.Config.SmallMarker[19],
                            PublicHouse.Config.SmallMarker[20],
                            PublicHouse.Config.SmallMarker[21]
                        )

                        if IsControlJustReleased(0, PublicHouse.Config.KeyPress) then
                            Cleaning(PlayerPedId(), v.Cleaning)
                        end
                    end

                    Wait(Sleep)
                end
            end)
        else
            exports.ox_target:addSphereZone({
                coords = v.Join,
                size = vec3(2, 2, 2),
                radius = 1,
                rotation = 45,
                -- debug = true,
                options = {
                    {
                        distance = 1.5,
                        icon = 'fa-solid fa-house-circle-check',
                        label = PublicHouse.Translation["Join"],
                        onSelect = function(data)
                            if HasItem(PublicHouse.Config.Item) then
                                DoScreenFadeOut(800)
                                while not IsScreenFadedOut() do
                                    Citizen.Wait(0)
                                end
                                TriggerServerEvent('PublicHouse:JoinHouse')
                                SetEntityCoords(PlayerPedId(), v.Interior)
                                DoScreenFadeIn(800)
                            end
                        end,
                    }
                }
            })

            exports.ox_target:addSphereZone({
                coords = v.Interior,
                size = vec3(2, 2, 2),
                radius = 1,
                rotation = 45,
                -- debug = true,
                options = {
                    {
                        distance = 1.5,
                        icon = 'fa-solid fa-house-circle-xmark',
                        label = PublicHouse.Translation["Leave"],
                        onSelect = function(data)
                            if HasItem(PublicHouse.Config.Item) then
                                DoScreenFadeOut(800)
                                while not IsScreenFadedOut() do
                                    Citizen.Wait(0)
                                end
                                TriggerServerEvent('PublicHouse:LeaveHouse')
                                SetEntityCoords(PlayerPedId(), v.Join)
                                DoScreenFadeIn(800)
                            end
                        end,
                    }
                }
            })

            exports.ox_target:addSphereZone({
                coords = v.Stash,
                size = vec3(2, 2, 2),
                radius = 1,
                rotation = 45,
                -- debug = true,
                options = {
                    {
                        distance = 1.0,
                        icon = 'fa-solid fa-box-open',
                        label = PublicHouse.Translation["Inventory"],
                        onSelect = function(data)
                            PublicHouse_Stash(k, Ox_Inventory)
                        end,
                    }
                }
            })

            exports.ox_target:addSphereZone({
                coords = v.Wardrobe,
                size = vec3(2, 2, 2),
                radius = 1,
                rotation = 45,
                -- debug = true,
                options = {
                    {
                        distance = 1.0,
                        icon = 'fa-solid fa-shirt',
                        label = PublicHouse.Translation["Dressing"],
                        onSelect = function(data)
                            PublicHouse_Wardrobe(Fivem_Appearance, Illenium_Appearance)
                        end,
                    }
                }
            })

            exports.ox_target:addSphereZone({
                coords = vector3(v.Toilet.x, v.Toilet.y, v.Toilet.z + 0.8),
                size = vec3(2, 2, 2),
                radius = 1,
                rotation = 45,
                -- debug = true,
                options = {
                    {
                        distance = 1.0,
                        icon = 'fa-solid fa-toilet-paper',
                        label = PublicHouse.Translation["Toilet"],
                        onSelect = function(data)
                            local Text = { 'Pee', 'Poop' }
                            local Random = math.random(1, #Text)

                            if Text[Random] == 'Pee' then
                                FreezeEntityPosition(PlayerPedId(), true)

                                local hashSkin = GetHashKey("mp_m_freemode_01")

                                if GetEntityModel(PlayerPedId()) == hashSkin then
                                    Pee(PlayerPedId(), 'male')
                                else
                                    SetEntityCoords(PlayerPedId(), v.Toilet)

                                    FreezeEntityPosition(PlayerPedId(), true)

                                    Pee(PlayerPedId(), 'female')

                                    FreezeEntityPosition(PlayerPedId(), false)
                                end

                                FreezeEntityPosition(PlayerPedId(), false)
                            elseif Text[Random] == 'Poop' then
                                SetEntityCoords(PlayerPedId(), v.Toilet)

                                FreezeEntityPosition(PlayerPedId(), true)

                                Poop(PlayerPedId())

                                FreezeEntityPosition(PlayerPedId(), false)
                            end
                        end,
                    }
                }
            })

            exports.ox_target:addSphereZone({
                coords = vector3(v.Shower.x, v.Shower.y, v.Shower.z + 0.8),
                size = vec3(2, 2, 2),
                radius = 1,
                rotation = 45,
                -- debug = true,
                options = {
                    {
                        distance = 1.0,
                        icon = 'fa-solid fa-shower',
                        label = PublicHouse.Translation["Shower"],
                        onSelect = function(data)
                            Shower(PlayerPedId(), vector3(v.Shower.x, v.Shower.y, v.Shower.z + 1.2))
                        end,
                    }
                }
            })

            exports.ox_target:addSphereZone({
                coords = vector3(v.Bed.x, v.Bed.y, v.Bed.z - 1),
                size = vec3(2, 2, 2),
                radius = 1,
                rotation = 45,
                -- debug = true,
                options = {
                    {
                        distance = 1.5,
                        icon = 'fa-solid fa-bed',
                        label = PublicHouse.Translation["Bed"],
                        onSelect = function(data)
                            Sleeps(PlayerPedId(), vector3(v.Bed.x, v.Bed.y, v.Bed.z - 1.7))
                        end,
                    }
                }
            })

            exports.ox_target:addSphereZone({
                coords = vector3(v.Cooking.x, v.Cooking.y, v.Cooking.z - 1),
                size = vec3(2, 2, 2),
                radius = 1,
                rotation = 45,
                -- debug = true,
                options = {
                    {
                        distance = 1.5,
                        icon = 'fa-solid fa-fire-burner',
                        label = PublicHouse.Translation["Cooking"],
                        onSelect = function(data)
                            Cooking(PlayerPedId(), v.Cooking)
                        end,
                    }
                }
            })

            exports.ox_target:addSphereZone({
                coords = vector3(v.Cleaning.x, v.Cleaning.y, v.Cleaning.z - 1),
                size = vec3(2, 2, 2),
                radius = 1,
                rotation = 45,
                -- debug = true,
                options = {
                    {
                        distance = 1.5,
                        icon = 'fa-solid fa-spray-can-sparkles',
                        label = PublicHouse.Translation["Cooking"],
                        onSelect = function(data)
                            Cleaning(PlayerPedId(), v.Cleaning)
                        end,
                    }
                }
            })
        end
    end
end

function HasItem(ItemName)
    local inventory = ESX.GetPlayerData().inventory
    for i = 1, #inventory do
        local item = inventory[i]
        if item and item.name == ItemName then
            return true
        end
    end
    return false
end
