local Ox_Lib = GetResourceState('ox_lib'):find('start') or false

function Pee(ped, sex)
    local PlayerPed = ped

    local particleDictionary = "core"
    local particleName = "ent_amb_peeing"

    local animDictionary = 'misscarsteal2peeing'
    local animName = 'peeing_loop'

    local animDictionary2 = 'missfbi3ig_0'
    local animName2 = 'shit_loop_trev'

    if (not Ox_Lib and PublicHouse.Config.System == 'Auto') or (not Ox_Lib or not PublicHouse.Config.System) then
        RequestNamedPtfxAsset(particleDictionary)

        while not HasNamedPtfxAssetLoaded(particleDictionary) do
            Citizen.Wait(0)
        end

        RequestAnimDict(animDictionary)

        while not HasAnimDictLoaded(animDictionary) do
            Citizen.Wait(0)
        end

        RequestAnimDict(animDictionary2)

        while not HasAnimDictLoaded(animDictionary2) do
            Citizen.Wait(0)
        end
    else
        lib.requestNamedPtfxAsset(particleDictionary)

        lib.requestAnimDict(animDictionary)

        lib.requestAnimDict(animDictionary2)
    end

    if sex == 'male' then
        SetPtfxAssetNextCall(particleDictionary)

        local bone = GetPedBoneIndex(PlayerPed, 11816)

        local heading = GetEntityPhysicsHeading(PlayerPed)

        TaskPlayAnim(PlayerPed, animDictionary, animName, 8.0, -8.0, -1, 0, 0, false, false, false)

        local effect = StartParticleFxLoopedOnPedBone(particleName, PlayerPed, 0.0, 0.2, 0.0, -140.0, 0.0, 0.0, bone, 2.5, false, false, false)

        Wait(3500)

        StopParticleFxLooped(effect, 0)
        ClearPedTasks(PlayerPed)
    else
        SetPtfxAssetNextCall(particleDictionary)

        bone = GetPedBoneIndex(PlayerPed, 11816)

        local heading = GetEntityPhysicsHeading(PlayerPed)

        TaskPlayAnim(PlayerPed, animDictionary2, animName2, 8.0, -8.0, -1, 0, 0, false, false, false)

        local effect = StartParticleFxLoopedOnPedBone(particleName, PlayerPed, 0.0, 0.0, -0.55, 0.0, 0.0, 20.0, bone, 2.0, false, false, false)

        Wait(3500)

        Citizen.Wait(100)
        StopParticleFxLooped(effect, 0)
        ClearPedTasks(PlayerPed)
    end
end

function Poop(ped)
    local PlayerPed = ped

    local particleDictionary = "scr_amb_chop"
    local particleName = "ent_anim_dog_poo"

    local animDictionary = 'missfbi3ig_0'
    local animName = 'shit_loop_trev'

    if (not Ox_Lib and PublicHouse.Config.System == 'Auto') or (not Ox_Lib or not PublicHouse.Config.System) then
        RequestNamedPtfxAsset(particleDictionary)

        while not HasNamedPtfxAssetLoaded(particleDictionary) do
            Citizen.Wait(0)
        end

        RequestAnimDict(animDictionary)

        while not HasAnimDictLoaded(animDictionary) do
            Citizen.Wait(0)
        end
    else
        lib.requestNamedPtfxAsset(particleDictionary)

        lib.requestAnimDict(animDictionary)
    end

    SetPtfxAssetNextCall(particleDictionary)

    bone = GetPedBoneIndex(PlayerPed, 11816)

    TaskPlayAnim(PlayerPed, animDictionary, animName, 8.0, -8.0, -1, 0, 0, false, false, false)

    effect = StartParticleFxLoopedOnPedBone(particleName, PlayerPed, 0.0, 0.0, -0.6, 0.0, 0.0, 20.0, bone, 2.0, false, false, false)
    Wait(3500)

    effect2 = StartParticleFxLoopedOnPedBone(particleName, PlayerPed, 0.0, 0.0, -0.6, 0.0, 0.0, 20.0, bone, 2.0, false, false, false)
    Wait(1000)

    StopParticleFxLooped(effect, 0)

    Wait(10)

    StopParticleFxLooped(effect2, 0)
end

function Sleeps(ped, coords)
    local PlayerPed = ped

    local animDictionary = 'timetable@tracy@sleep@'
    local animName = 'idle_c'

    local animDictionary2 = 'switch@franklin@bed'
    local animName2 = 'sleep_getup_rubeyes'

    if (not Ox_Lib and PublicHouse.Config.System == 'Auto') or (not Ox_Lib or not PublicHouse.Config.System) then
        RequestAnimDict(animDictionary)

        while not HasAnimDictLoaded(animDictionary) do
            Citizen.Wait(0)
        end

        RequestAnimDict(animDictionary2)

        while not HasAnimDictLoaded(animDictionary2) do
            Citizen.Wait(0)
        end
    else
        lib.RequestAnimDict(animDictionary)

        lib.RequestAnimDict(animDictionary2)
    end

    SetEntityCoords(PlayerPed, coords)

    TaskPlayAnim(PlayerPed, animDictionary, animName, 8.0, 8.0, -1, 0, 0.0, false, false, false)

    DoScreenFadeOut(5000)
    Citizen.Wait(9000)
    DoScreenFadeIn(5000)

    TaskPlayAnim(PlayerPed, animDictionary2, animName2, 8.0, 8.0, -1, 0, 0.0, false, false, false)

    Citizen.Wait(9000)

    if PublicHouse.Config.AddHealth then
        PublicHouse_Health(PlayerPed)
    end

    ClearPedTasks(PlayerPed)
end

function Shower(ped, coords)
    local PlayerPed = ped

    local Ptfx = "core"
    local Scenario = "PROP_HUMAN_STAND_IMPATIENT"
    local Particle = "ent_sht_water"

    if (not Ox_Lib and PublicHouse.Config.System == 'Auto') or (not Ox_Lib or not PublicHouse.Config.System) then
        if not HasNamedPtfxAssetLoaded(Ptfx) then
            RequestNamedPtfxAsset(Ptfx)
            while not HasNamedPtfxAssetLoaded(Ptfx) do
                Wait(1)
            end
        end
    else
        lib.requestNamedPtfxAsset(Ptfx)
    end

    FreezeEntityPosition(PlayerPed, true)

    TaskStartScenarioInPlace(PlayerPed, Scenario, 0, true)

    local particles = {}

    for i = 1, 5 do
        UseParticleFxAssetNextCall(Ptfx)
        particles[i] = StartParticleFxLoopedAtCoord(Particle, coords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
        Citizen.Wait(3000)
    end

    FreezeEntityPosition(PlayerPed, false)
    ClearPedTasksImmediately(PlayerPed)

    for i = 1, 5 do
        StopParticleFxLooped(particles[i], 0)
    end
end

function Cooking(ped, coords)
    local PlayerPed = ped

    local Name = "prop_kitch_pot_med"
    local Scenario = "PROP_HUMAN_BBQ"

    if (not Ox_Lib and PublicHouse.Config.System == 'Auto') or (not Ox_Lib or not PublicHouse.Config.System) then
        if not HasModelLoaded(Name) then
            RequestModel(Name)
            while not HasModelLoaded(Name) do
                Citizen.Wait(5)
            end
        end
    else
        lib.requestModel(Name)
    end

    local Object = CreateObject(Name, vector3(coords.x, coords.y, coords.z - 0.95))

    TaskStartScenarioInPlace(PlayerPed, Scenario, 0, false)

    Citizen.Wait(3000)

    ClearPedTasksImmediately(PlayerPed)
    DeleteObject(Object)
    ClearAreaOfObjects(coords, 2.0, 0)
end

function Cleaning(ped, coords)
    local PlayerPed = ped

    local animDictionary = "anim@amb@machinery@lathe@"
    local animName = 'clean_surface_01_amy_skater_01'

    if (not Ox_Lib and PublicHouse.Config.System == 'Auto') or (not Ox_Lib or not PublicHouse.Config.System) then
        RequestAnimDict(animDictionary)

        while not HasAnimDictLoaded(animDictionary) do
            Citizen.Wait(0)
        end
    else
        lib.requestAnimDict(animDictionary)
    end

    TaskPlayAnim(PlayerPed, animDictionary, animName, 8.0, 8.0, -1, 0, 0.0, false, false, false)

    Citizen.Wait(3500)

    ClearPedTasksImmediately(PlayerPed)
    ClearAreaOfObjects(coords, 2.0, 0)
end

-- RegisterCommand('Pee', function()
--     local hashSkin = GetHashKey("mp_m_freemode_01")

--     if GetEntityModel(PlayerPedId()) == hashSkin then
--         Pee(PlayerPedId(), 'male')
--     else
--         Pee(PlayerPedId(), 'female')
--     end
-- end)

-- RegisterCommand('Poop', function()
--     Poop(PlayerPedId())
-- end)


-- RegisterCommand('Sleep', function()
--     Sleep(PlayerPedId(), vector3(coords.x, coords.y, coords.z + 1.2))
-- end)

-- RegisterCommand('Shower', function()
--     local PlayerCoords = GetEntityCoords(PlayerPedId())
--     Shower(PlayerPedId(), vector3(coords.x, coords.y, coords.z + 1.2))
-- end)

-- RegisterCommand('Cooking', function()
--     Cooking(PlayerPedId(), vector3(coords.x, coords.y, coords.z + 1.2))
-- end)

-- RegisterCommand('Cleaning', function()
--     Cleaning(PlayerPedId(), vector3(coords.x, coords.y, coords.z + 1.2))
-- end)
