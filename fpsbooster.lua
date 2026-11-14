local env = (getgenv and getgenv()) or _G
if env.ResonanceFPSBooster then
    warn("[SH | STUDIO] FPS Booster is already running.")
    return
end

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local GuiService = game:GetService("GuiService")
local MarketplaceService = game:GetService("MarketplaceService")
local Stats = game:GetService("Stats")

local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    task.wait()
    LocalPlayer = Players.LocalPlayer
end

local TAB_ICON = 4483362458
local HUB_NAME = "SH | STUDIO"
local LOGO_IMAGE = "rbxassetid://91665116750253"

local Theme = {
    ContentColor = Color3.fromRGB(196, 161, 255),
    TitlingColor = Color3.fromRGB(196, 161, 255),
    ActionColor = Color3.fromRGB(196, 161, 255),
    TabColor = Color3.fromRGB(196, 161, 255),
    PlaceholderColor = Color3.fromRGB(181, 124, 255),

    WindowColor = Color3.fromRGB(18, 8, 42),
    ShadowColor = Color3.fromRGB(12, 5, 30),

    TabBackground = Color3.fromRGB(108, 52, 195),
    TabStroke = Color3.fromRGB(90, 38, 165),

    ElementGradient = Color3.fromRGB(24, 10, 55),
    ElementStroke = Color3.fromRGB(108, 52, 195),
    StatBackground = Color3.fromRGB(18, 8, 45),

    SliderBackground = Color3.fromRGB(90, 38, 165),
    SliderProgress = Color3.fromRGB(142, 68, 255),
    SliderStroke = Color3.fromRGB(169, 112, 255),

    ToggleTrack = Color3.fromRGB(22, 10, 52),
    ToggleKnobOff = Color3.fromRGB(55, 28, 100),
    AccentColor = Color3.fromRGB(142, 68, 255),
    AccentStroke = Color3.fromRGB(169, 112, 255),

    DropdownHighlight = Color3.fromRGB(108, 52, 195),

    FieldBackground = Color3.fromRGB(24, 10, 55),
    FieldGlow = Color3.fromRGB(142, 68, 255),
}

local brandConnections = {}
local brandApplied = false

local function stopBranding()
    for _, connection in ipairs(brandConnections) do
        connection:Disconnect()
    end
    table.clear(brandConnections)
end

local function brandLoadingGui(gui)
    if brandApplied or not gui:IsA("ScreenGui") or not gui.Name:match("^%x+%-%x+%-%x+%-%x+%-%x+$") then
        return
    end
    task.spawn(function()
        local banner = gui:WaitForChild("Banner", 3)
        if brandApplied or not banner or not banner:IsA("ImageLabel") then
            return
        end
        brandApplied = true

        local logo = Instance.new("ImageLabel")
        logo.Name = "SHStudioLogo"
        logo.BackgroundTransparency = 1
        logo.BorderSizePixel = 0
        logo.AnchorPoint = Vector2.new(0.5, 0.5)
        logo.Position = UDim2.fromScale(0.5, 0.5)
        logo.Size = UDim2.fromScale(1, 1)
        logo.Image = LOGO_IMAGE
        logo.ScaleType = Enum.ScaleType.Fit
        logo.Parent = banner
        banner.ImageTransparency = 1

        stopBranding()
    end)
end

do
    local containers = {}
    local okHui, hui = pcall(function()
        return gethui and gethui()
    end)
    if okHui and typeof(hui) == "Instance" then
        containers[#containers + 1] = hui
    end
    local coreGui = game:GetService("CoreGui")
    if not table.find(containers, coreGui) then
        containers[#containers + 1] = coreGui
    end
    local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if playerGui and not table.find(containers, playerGui) then
        containers[#containers + 1] = playerGui
    end
    for _, container in ipairs(containers) do
        brandConnections[#brandConnections + 1] = container.ChildAdded:Connect(brandLoadingGui)
    end
end

local loaded, Rayfield = pcall(function()
    return loadstring(
        game:HttpGet("https://raw.githubusercontent.com/dunnook/SpectacleHub/refs/heads/main/RayfieldUiEdited")
    )()
end)
if not loaded or type(Rayfield) ~= "table" then
    warn("[SH | STUDIO] Failed to load Rayfield: " .. tostring(Rayfield))
    stopBranding()
    return
end

local created, Window = pcall(function()
    return Rayfield:CreateWindow({
        name = HUB_NAME,
        subtitle = "FPS Booster",
        theme = Theme,
        showName = HUB_NAME,
        showIcon = LOGO_IMAGE,
        configuration = { customFolder = "ShadowHub", fileName = "ShadowHubConfig" },
    })
end)
if not created or not Window then
    warn("[SH | STUDIO] Failed to create window: " .. tostring(Window))
    stopBranding()
    return
end
env.ResonanceFPSBooster = true
task.delay(3, stopBranding)

local keybindOk = pcall(function()
    Window.settings.toggleKeybind = Enum.KeyCode.K
end)
if not keybindOk then
    warn("[SH | STUDIO] This Rayfield build does not expose a settable toggle keybind; the default key is unchanged.")
end

local WATCH = true
local FRAME_BUDGET = 0.004
local FOV_LIMIT = 180
local ORDER = { "low", "shadows", "saturation", "antipause", "shake", "night", "fullbright", "fov" }
local SEQ = {}
for _, owner in ipairs(ORDER) do
    SEQ[owner] = owner .. "Seq"
end

local Records = setmetatable({}, { __mode = "k" })
local Tokens = {}
local Active = { low = false, shadows = false, saturation = false }
local Hooks = {}
local KindCache = {}
local Handlers = {}
local Features = {}
local qualityOrig = nil
local claimCounter = 0

local function getTime()
    local t = os.date("*t")
    return string.format("%02d:%02d:%02d", t.hour, t.min, t.sec)
end

local function getExecutor()
    local name = "Unknown"
    if identifyexecutor then
        local ok, result = pcall(identifyexecutor)
        if ok and result then
            name = tostring(result)
        end
    end
    return name
end

local function getGameName()
    local ok, info = pcall(function()
        return MarketplaceService:GetProductInfo(game.PlaceId)
    end)
    if ok and info and info.Name then
        return info.Name
    end
    return "Unknown"
end

local function getPlayerCount()
    return #Players:GetPlayers() .. "/" .. Players.MaxPlayers
end

local function getPing()
    return math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
end

local function same(a, b)
    if type(a) == "number" and type(b) == "number" then
        return math.abs(a - b) < 1e-4
    end
    return a == b
end

local function getProp(inst, prop)
    return inst[prop]
end

local function setProp(inst, prop, value)
    inst[prop] = value
end

local function readAny(inst, prop)
    local ok, value = pcall(getProp, inst, prop)
    if ok then
        return true, value
    end
    if gethiddenproperty then
        local okHidden, hiddenValue = pcall(gethiddenproperty, inst, prop)
        if okHidden then
            return true, hiddenValue
        end
    end
    return false
end

local function writeAny(inst, prop, value)
    if pcall(setProp, inst, prop, value) then
        return true
    end
    if sethiddenproperty then
        return (pcall(sethiddenproperty, inst, prop, value))
    end
    return false
end

local function resolve(entry)
    local best, bestSeq
    for i = 1, #ORDER do
        local owner = ORDER[i]
        local value = entry[owner]
        if value ~= nil then
            local seq = entry[SEQ[owner]] or 0
            if not bestSeq or seq > bestSeq then
                best, bestSeq = value, seq
            end
        end
    end
    return best
end

local function dropEntry(inst, prop)
    local rec = Records[inst]
    local entry = rec and rec[prop]
    if not entry then
        return
    end
    if entry.conn then
        entry.conn:Disconnect()
    end
    rec[prop] = nil
    if next(rec) == nil then
        Records[inst] = nil
    end
end

local function enforce(inst, prop)
    local rec = Records[inst]
    local entry = rec and rec[prop]
    if not entry then
        return
    end
    local want = resolve(entry)
    if want == nil then
        return
    end
    local ok, current = readAny(inst, prop)
    if ok and not same(current, want) then
        entry.o = current
        writeAny(inst, prop, want)
    end
end

local function claim(inst, prop, owner, value, watch)
    local rec = Records[inst]
    local entry = rec and rec[prop]
    if not entry then
        local ok, current = readAny(inst, prop)
        if not ok then
            return false
        end
        if not watch and same(current, value) then
            return false
        end
        entry = { o = current }
        if not rec then
            rec = {}
            Records[inst] = rec
        end
        rec[prop] = entry
    end

    claimCounter += 1
    entry[owner] = value
    entry[SEQ[owner]] = claimCounter
    if not writeAny(inst, prop, resolve(entry)) then
        entry[owner] = nil
        entry[SEQ[owner]] = nil
        if resolve(entry) == nil then
            dropEntry(inst, prop)
        end
        return false
    end

    if watch and not entry.conn then
        local ok, conn = pcall(function()
            return inst:GetPropertyChangedSignal(prop):Connect(function()
                enforce(inst, prop)
            end)
        end)
        if ok then
            entry.conn = conn
        end
    end
    return true
end

local function release(inst, prop, owner)
    local rec = Records[inst]
    local entry = rec and rec[prop]
    if not entry or entry[owner] == nil then
        return
    end
    entry[owner] = nil
    entry[SEQ[owner]] = nil
    local want = resolve(entry)
    if want ~= nil then
        writeAny(inst, prop, want)
    else
        writeAny(inst, prop, entry.o)
        dropEntry(inst, prop)
    end
end

local function classify(inst)
    if inst:IsA("BasePart") then
        if inst:IsA("Terrain") then
            return "terrain"
        end
        if inst:IsA("MeshPart") then
            return "mesh"
        end
        if inst:IsA("PartOperation") then
            return "union"
        end
        return "part"
    end
    if inst:IsA("Decal") then
        return "decal"
    end
    if inst:IsA("ParticleEmitter") then
        return "particle"
    end
    if inst:IsA("Trail") then
        return "trail"
    end
    if inst:IsA("Beam") then
        return "beam"
    end
    if inst:IsA("Fire") or inst:IsA("Smoke") or inst:IsA("Sparkles") then
        return "emitter"
    end
    if inst:IsA("Explosion") then
        return "explosion"
    end
    if inst:IsA("Highlight") then
        return "highlight"
    end
    if inst:IsA("Light") then
        return "light"
    end
    if inst:IsA("SpecialMesh") then
        return "specialmesh"
    end
    if inst:IsA("SurfaceAppearance") then
        return "surface"
    end
    if inst:IsA("ColorCorrectionEffect") then
        return "cc"
    end
    if inst:IsA("PostEffect") then
        return "post"
    end
    if inst:IsA("Atmosphere") then
        return "atmosphere"
    end
    if inst:IsA("Clouds") then
        return "clouds"
    end
    if inst:IsA("Sky") then
        return "sky"
    end
    return false
end

local function kindOf(inst)
    local className = inst.ClassName
    local kind = KindCache[className]
    if kind == nil then
        kind = classify(inst)
        KindCache[className] = kind
    end
    return kind
end

Handlers.low = function(inst, kind)
    if kind == "part" or kind == "mesh" or kind == "union" then
        claim(inst, "Material", "low", Enum.Material.Plastic)
        claim(inst, "Reflectance", "low", 0)
        claim(inst, "CastShadow", "low", false)
        if kind == "mesh" then
            claim(inst, "RenderFidelity", "low", Enum.RenderFidelity.Performance)
            claim(inst, "TextureID", "low", "")
        elseif kind == "union" then
            claim(inst, "RenderFidelity", "low", Enum.RenderFidelity.Performance)
        end
    elseif kind == "decal" then
        claim(inst, "Transparency", "low", 1)
    elseif kind == "particle" then
        claim(inst, "Enabled", "low", false)
        claim(inst, "Lifetime", "low", NumberRange.new(0, 0))
    elseif kind == "trail" then
        claim(inst, "Enabled", "low", false)
        claim(inst, "Lifetime", "low", 0)
    elseif kind == "beam" then
        claim(inst, "Enabled", "low", false)
        claim(inst, "Width0", "low", 0)
        claim(inst, "Width1", "low", 0)
    elseif kind == "emitter" or kind == "highlight" or kind == "post" or kind == "cc" or kind == "clouds" then
        claim(inst, "Enabled", "low", false)
    elseif kind == "explosion" then
        claim(inst, "Visible", "low", false)
    elseif kind == "light" then
        claim(inst, "Enabled", "low", false)
        claim(inst, "Shadows", "low", false)
    elseif kind == "specialmesh" then
        claim(inst, "TextureId", "low", "")
    elseif kind == "surface" then
        claim(inst, "ColorMap", "low", "")
        claim(inst, "NormalMap", "low", "")
        claim(inst, "MetalnessMap", "low", "")
        claim(inst, "RoughnessMap", "low", "")
    elseif kind == "atmosphere" then
        claim(inst, "Density", "low", 0)
        claim(inst, "Haze", "low", 0)
        claim(inst, "Glare", "low", 0)
    elseif kind == "sky" then
        claim(inst, "StarCount", "low", 0)
        claim(inst, "CelestialBodiesShown", "low", false)
    elseif kind == "terrain" then
        claim(inst, "WaterWaveSize", "low", 0)
        claim(inst, "WaterWaveSpeed", "low", 0)
        claim(inst, "WaterReflectance", "low", 0)
        claim(inst, "Decoration", "low", false)
    end
end

Handlers.shadows = function(inst, kind)
    if kind == "part" or kind == "mesh" or kind == "union" then
        claim(inst, "CastShadow", "shadows", false)
    elseif kind == "light" then
        claim(inst, "Shadows", "shadows", false)
    end
end

Handlers.saturation = function(inst, kind)
    if kind == "cc" then
        claim(inst, "Saturation", "saturation", 0, WATCH)
    end
end

local function onDescendantAdded(inst)
    local kind = kindOf(inst)
    if not kind then
        return
    end
    if Active.low then
        Handlers.low(inst, kind)
    end
    if Active.shadows then
        Handlers.shadows(inst, kind)
    end
    if Active.saturation then
        Handlers.saturation(inst, kind)
    end
end

local function updateHooks()
    local needed = Active.low or Active.shadows or Active.saturation
    if needed and not Hooks.workspace then
        Hooks.workspace = Workspace.DescendantAdded:Connect(onDescendantAdded)
        Hooks.lighting = Lighting.DescendantAdded:Connect(onDescendantAdded)
    elseif not needed and Hooks.workspace then
        Hooks.workspace:Disconnect()
        Hooks.lighting:Disconnect()
        Hooks.workspace = nil
        Hooks.lighting = nil
    end
end

local function startMass(owner, roots)
    local token = {}
    Tokens[owner] = token
    task.spawn(function()
        local handler = Handlers[owner]
        local frameStart = os.clock()
        for _, root in ipairs(roots) do
            local descendants = root:GetDescendants()
            for i = 1, #descendants do
                if Tokens[owner] ~= token then
                    return
                end
                local inst = descendants[i]
                local kind = kindOf(inst)
                if kind then
                    handler(inst, kind)
                end
                if os.clock() - frameStart > FRAME_BUDGET then
                    RunService.Heartbeat:Wait()
                    frameStart = os.clock()
                end
            end
        end
    end)
end

local function stopMass(owner)
    local token = {}
    Tokens[owner] = token
    task.spawn(function()
        local list, count = {}, 0
        for inst in pairs(Records) do
            count += 1
            list[count] = inst
        end
        local props = {}
        local frameStart = os.clock()
        for i = 1, count do
            if Tokens[owner] ~= token then
                return
            end
            local inst = list[i]
            local rec = Records[inst]
            if rec then
                table.clear(props)
                for prop in pairs(rec) do
                    props[#props + 1] = prop
                end
                for j = 1, #props do
                    release(inst, props[j], owner)
                end
            end
            if os.clock() - frameStart > FRAME_BUDGET then
                RunService.Heartbeat:Wait()
                frameStart = os.clock()
            end
        end
    end)
end

local function setLowQuality(on)
    pcall(function()
        local rendering = settings().Rendering
        if on then
            if qualityOrig == nil then
                qualityOrig = rendering.QualityLevel
            end
            rendering.QualityLevel = Enum.QualityLevel.Level01
        elseif qualityOrig ~= nil then
            rendering.QualityLevel = qualityOrig
            qualityOrig = nil
        end
    end)
end

Features.low = {
    title = "Low Graphics",
    enable = function()
        Active.low = true
        claim(Lighting, "GlobalShadows", "low", false, WATCH)
        setLowQuality(true)
        startMass("low", { Workspace, Lighting })
        updateHooks()
        return true
    end,
    disable = function()
        Active.low = false
        release(Lighting, "GlobalShadows", "low")
        setLowQuality(false)
        stopMass("low")
        updateHooks()
        return true
    end,
}

Features.shadows = {
    title = "No Shadows",
    enable = function()
        Active.shadows = true
        claim(Lighting, "GlobalShadows", "shadows", false, WATCH)
        startMass("shadows", { Workspace })
        updateHooks()
        return true
    end,
    disable = function()
        Active.shadows = false
        release(Lighting, "GlobalShadows", "shadows")
        stopMass("shadows")
        updateHooks()
        return true
    end,
}

Features.saturation = {
    title = "No Saturation",
    enable = function()
        Active.saturation = true
        local roots = { Lighting }
        if Workspace.CurrentCamera then
            roots[#roots + 1] = Workspace.CurrentCamera
        end
        startMass("saturation", roots)
        updateHooks()
        return true
    end,
    disable = function()
        Active.saturation = false
        stopMass("saturation")
        updateHooks()
        return true
    end,
}

local NIGHT_PROPS = {
    ClockTime = 0,
    Brightness = 1,
    Ambient = Color3.fromRGB(30, 30, 45),
    OutdoorAmbient = Color3.fromRGB(30, 30, 45),
}

Features.night = {
    title = "Night Mode",
    enable = function()
        for prop, value in pairs(NIGHT_PROPS) do
            claim(Lighting, prop, "night", value, WATCH)
        end
        return true
    end,
    disable = function()
        for prop in pairs(NIGHT_PROPS) do
            release(Lighting, prop, "night")
        end
        return true
    end,
}

local FULLBRIGHT_PROPS = {
    Brightness = 2,
    ClockTime = 14,
    FogEnd = 100000,
    GlobalShadows = false,
    Ambient = Color3.fromRGB(178, 178, 178),
    OutdoorAmbient = Color3.fromRGB(128, 128, 128),
}

Features.fullbright = {
    title = "Fullbright",
    enable = function()
        for prop, value in pairs(FULLBRIGHT_PROPS) do
            claim(Lighting, prop, "fullbright", value, WATCH)
        end
        return true
    end,
    disable = function()
        for prop in pairs(FULLBRIGHT_PROPS) do
            release(Lighting, prop, "fullbright")
        end
        return true
    end,
}

local AntiPause = { prop = nil, value = nil, conn = nil, noticeHidden = false }

local function getEnum(name)
    return Enum[name]
end

local function resolveStreamingMode()
    if AntiPause.prop then
        return AntiPause.prop, AntiPause.value
    end
    for _, name in ipairs({ "StreamingIntegrityMode", "StreamingPauseMode" }) do
        local okEnum, enumType = pcall(getEnum, name)
        if okEnum and enumType then
            local okItem, item = pcall(getProp, enumType, "Disabled")
            if okItem and item and readAny(Workspace, name) then
                AntiPause.prop = name
                AntiPause.value = item
                return name, item
            end
        end
    end
    return nil
end

local function setPauseNotice(enabled)
    return (pcall(function()
        GuiService:SetGameplayPausedNotificationEnabled(enabled)
    end))
end

local function clearPaused()
    local ok, paused = readAny(LocalPlayer, "GameplayPaused")
    if ok and paused then
        writeAny(LocalPlayer, "GameplayPaused", false)
    end
end

Features.antipause = {
    title = "Anti-Gameplay Pause",
    enable = function()
        local applied = false

        local prop, mode = resolveStreamingMode()
        if prop and claim(Workspace, prop, "antipause", mode, WATCH) then
            applied = true
        end

        if setPauseNotice(false) then
            AntiPause.noticeHidden = true
            applied = true
        end

        if not AntiPause.conn then
            local ok, conn = pcall(function()
                return LocalPlayer:GetPropertyChangedSignal("GameplayPaused"):Connect(clearPaused)
            end)
            if ok then
                AntiPause.conn = conn
                applied = true
            end
        end
        clearPaused()

        return applied
    end,
    disable = function()
        if AntiPause.prop then
            release(Workspace, AntiPause.prop, "antipause")
        end
        if AntiPause.conn then
            AntiPause.conn:Disconnect()
            AntiPause.conn = nil
        end
        if AntiPause.noticeHidden then
            setPauseNotice(true)
            AntiPause.noticeHidden = false
        end
        return true
    end,
}

local Shake = { active = false, humanoid = nil, added = nil, removing = nil }

local function unbindHumanoid()
    if Shake.humanoid then
        release(Shake.humanoid, "CameraOffset", "shake")
        Shake.humanoid = nil
    end
end

local function bindHumanoid(character)
    task.spawn(function()
        local humanoid = character:FindFirstChildOfClass("Humanoid") or character:WaitForChild("Humanoid", 10)
        if not humanoid or not Shake.active or LocalPlayer.Character ~= character then
            return
        end
        unbindHumanoid()
        Shake.humanoid = humanoid
        claim(humanoid, "CameraOffset", "shake", Vector3.zero, WATCH)
    end)
end

Features.shake = {
    title = "No Camera Shake",
    enable = function()
        Shake.active = true
        Shake.added = LocalPlayer.CharacterAdded:Connect(bindHumanoid)
        Shake.removing = LocalPlayer.CharacterRemoving:Connect(unbindHumanoid)
        if LocalPlayer.Character then
            bindHumanoid(LocalPlayer.Character)
        end
        return true
    end,
    disable = function()
        Shake.active = false
        if Shake.added then
            Shake.added:Disconnect()
            Shake.added = nil
        end
        if Shake.removing then
            Shake.removing:Disconnect()
            Shake.removing = nil
        end
        unbindHumanoid()
        return true
    end,
}

local FOV = { active = false, value = 70, camera = nil, conn = nil }

local function fovTarget()
    return math.min(FOV.value, FOV_LIMIT)
end

local function currentFov()
    local camera = Workspace.CurrentCamera
    local fov = camera and camera.FieldOfView or 70
    return math.clamp(math.floor(fov + 0.5), 40, FOV_LIMIT)
end

local function bindCamera()
    local camera = Workspace.CurrentCamera
    if FOV.camera and FOV.camera ~= camera then
        release(FOV.camera, "FieldOfView", "fov")
        FOV.camera = nil
    end
    if camera and FOV.camera ~= camera then
        FOV.camera = camera
        claim(camera, "FieldOfView", "fov", fovTarget(), WATCH)
    end
    return FOV.camera ~= nil
end

Features.fov = {
    title = "FOV Changer",
    enable = function()
        FOV.active = true
        if not bindCamera() then
            FOV.active = false
            return false
        end
        if not FOV.conn then
            FOV.conn = Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(bindCamera)
        end
        return true
    end,
    disable = function()
        FOV.active = false
        if FOV.conn then
            FOV.conn:Disconnect()
            FOV.conn = nil
        end
        if FOV.camera then
            release(FOV.camera, "FieldOfView", "fov")
            FOV.camera = nil
        end
        return true
    end,
}

FOV.value = currentFov()

local FEATURE_ORDER = { "low", "antipause", "shake", "fov", "saturation", "shadows", "night", "fullbright" }
local featureState = {}
for _, key in ipairs(FEATURE_ORDER) do
    featureState[key] = false
end

local toggles = {}
local sliders = {}
local silent = false
local notifyEnabled = true

local function notify(title, content)
    if silent or not notifyEnabled then
        return
    end
    pcall(function()
        Window:Notify({ title = title, content = content, duration = 2.5 })
    end)
end

local function syncToggle(key)
    local handle = toggles[key]
    if handle then
        pcall(handle.Set, handle, featureState[key], true)
    end
end

local function setFeature(key, state)
    local feature = Features[key]
    if not feature or featureState[key] == state then
        return
    end

    local ok, result = pcall(state and feature.enable or feature.disable)
    if not ok then
        warn(string.format("[SH | STUDIO] %s failed: %s", feature.title, tostring(result)))
    end

    if state and (not ok or result == false) then
        pcall(feature.disable)
        featureState[key] = false
        syncToggle(key)
        notify(feature.title, "Not available in this game")
        return
    end

    featureState[key] = state
    notify(feature.title, state and "Enabled" or "Disabled")
end

local function addToggle(tab, key, description)
    toggles[key] = tab:CreateToggle({
        name = Features[key].title,
        description = description,
        value = false,
        forgetState = true,
        callback = function(state)
            setFeature(key, state == true)
        end,
    })
end

local function resetFov()
    silent = true
    setFeature("fov", false)
    silent = false
    syncToggle("fov")
    FOV.value = currentFov()
    local slider = sliders.fov
    if slider then
        pcall(slider.Set, slider, FOV.value, true)
    end
    notify("FOV Changer", "Reset to " .. FOV.value)
end

local function disableAll()
    silent = true
    for _, key in ipairs(FEATURE_ORDER) do
        setFeature(key, false)
        syncToggle(key)
    end
    silent = false
    FOV.value = currentFov()
    local slider = sliders.fov
    if slider then
        pcall(slider.Set, slider, FOV.value, true)
    end
    notify(HUB_NAME, "All features disabled")
end

local InfoTab = Window:CreateTab({ name = "Info", icon = TAB_ICON })

local timeLabel = InfoTab:CreateText({ name = "Time: " .. getTime() })
InfoTab:CreateText({ name = "Executor: " .. getExecutor() })
local fpsLabel = InfoTab:CreateText({ name = "FPS: Calculating..." })
local pingLabel = InfoTab:CreateText({ name = "Ping: Calculating..." })
local gameLabel = InfoTab:CreateText({ name = "Game: Loading..." })
InfoTab:CreateText({ name = "Game ID: " .. tostring(game.PlaceId) })
local playersLabel = InfoTab:CreateText({ name = "Players: " .. getPlayerCount() })

local shownInfo = {}
local function setInfo(key, label, text)
    if shownInfo[key] ~= text then
        shownInfo[key] = text
        pcall(label.SetTitle, label, text)
    end
end

task.spawn(function()
    setInfo("game", gameLabel, "Game: " .. getGameName())
end)

local infoFrames, infoElapsed = 0, 0
RunService.RenderStepped:Connect(function(deltaTime)
    infoFrames += 1
    infoElapsed += deltaTime
    if infoElapsed < 0.5 then
        return
    end

    local fps = math.floor(infoFrames / infoElapsed + 0.5)
    infoFrames, infoElapsed = 0, 0

    local okPing, ping = pcall(getPing)
    setInfo("fps", fpsLabel, "FPS: " .. fps)
    setInfo("ping", pingLabel, "Ping: " .. (okPing and (ping .. "ms") or "N/A"))
    setInfo("time", timeLabel, "Time: " .. getTime())
    setInfo("players", playersLabel, "Players: " .. getPlayerCount())
end)

local performanceTab = Window:CreateTab({ name = "Performance" })
addToggle(
    performanceTab,
    "low",
    "Strips materials, textures, particles, trails, beams, explosions, post effects, lights and shadows to raise FPS."
)
addToggle(
    performanceTab,
    "antipause",
    "Stops streaming-based gameplay pauses and hides the pause notice. Only affects games with streaming enabled."
)

local cameraTab = Window:CreateTab({ name = "Camera" })
addToggle(cameraTab, "shake", "Locks the character camera offset to remove offset-based shake.")
addToggle(cameraTab, "fov", "Applies the field of view chosen below. Roblox caps FOV at 120.")
sliders.fov = cameraTab:CreateSlider({
    name = "Field of View",
    range = { 40, 180 },
    increment = 1,
    value = FOV.value,
    suffix = "°",
    forgetState = true,
    callback = function(value)
        FOV.value = value
        if FOV.active and FOV.camera then
            claim(FOV.camera, "FieldOfView", "fov", fovTarget(), WATCH)
        end
    end,
})
cameraTab:CreateButton({
    name = "Reset FOV",
    description = "Turns the changer off and returns to the game's own FOV.",
    callback = resetFov,
})

local visualsTab = Window:CreateTab({ name = "Visuals" })
addToggle(visualsTab, "saturation", "Neutralizes saturation changes from color correction effects.")
addToggle(visualsTab, "shadows", "Disables global, part and light shadows.")
addToggle(visualsTab, "night", "Darkens the lighting and sets the time to midnight.")
addToggle(visualsTab, "fullbright", "Removes darkness: bright ambient light, daytime clock, no fog or global shadows.")

local settingsTab = Window:CreateTab({ name = "Settings" })
settingsTab:CreateToggle({
    name = "Notifications",
    description = "Show a notification whenever a feature is switched.",
    value = true,
    forgetState = true,
    callback = function(state)
        notifyEnabled = state == true
    end,
})
settingsTab:CreateButton({
    name = "Disable All Features",
    description = "Turns every feature off and restores the original game settings.",
    callback = disableAll,
})

notify(HUB_NAME, "FPS Booster loaded")
