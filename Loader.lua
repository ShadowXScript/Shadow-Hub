local RunService = game:GetService('RunService')
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function createShadowLoader()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "Shadow Hub | Loader"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local blurEffect = Instance.new("BlurEffect")
    blurEffect.Size = 0
    blurEffect.Parent = game:GetService("Lighting")
    
    local mainContainer = Instance.new("Frame")
    mainContainer.Size = UDim2.new(0, 380, 0, 200)
    mainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    mainContainer.BorderSizePixel = 0
    mainContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    mainContainer.BackgroundTransparency = 1
    mainContainer.Parent = screenGui
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 8)
    mainCorner.Parent = mainContainer
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 35)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 25))
    })
    gradient.Rotation = 45
    gradient.Parent = mainContainer
    
    local borderGlow = Instance.new("UIStroke")
    borderGlow.Color = Color3.fromRGB(138, 43, 226)
    borderGlow.Thickness = 1.5
    borderGlow.Parent = mainContainer
    
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 45)
    header.BackgroundColor3 = Color3.fromRGB(30, 20, 50)
    header.BorderSizePixel = 0
    header.Parent = mainContainer
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 8)
    headerCorner.Parent = header
    
    local cornerFix = Instance.new("Frame")
    cornerFix.Size = UDim2.new(1, 0, 0, 15)
    cornerFix.Position = UDim2.new(0, 0, 1, -15)
    cornerFix.BackgroundColor3 = Color3.fromRGB(30, 20, 50)
    cornerFix.BorderSizePixel = 0
    cornerFix.ZIndex = 0
    cornerFix.Parent = header
    
    local logoContainer = Instance.new("Frame")
    logoContainer.Size = UDim2.new(0, 32, 0, 32)
    logoContainer.Position = UDim2.new(0, 10, 0, 6)
    logoContainer.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    logoContainer.BorderSizePixel = 0
    logoContainer.Parent = header
    
    local logoCorner = Instance.new("UICorner")
    logoCorner.CornerRadius = UDim.new(1, 0)
    logoCorner.Parent = logoContainer
    
    local logoText = Instance.new("TextLabel")
    logoText.Size = UDim2.new(1, 0, 1, 0)
    logoText.BackgroundTransparency = 1
    logoText.Text = "SH"
    logoText.Font = Enum.Font.GothamBold
    logoText.TextColor3 = Color3.fromRGB(255, 255, 255)
    logoText.TextSize = 15
    logoText.Parent = logoContainer
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0, 220, 0, 45)
    title.Position = UDim2.new(0, 52, 0, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 17
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Text = "Shadow Hub | Loader"
    title.Parent = header
    
    local versionInfo = Instance.new("TextLabel")
    versionInfo.Size = UDim2.new(0, 60, 0, 20)
    versionInfo.Position = UDim2.new(1, -70, 0.5, -10)
    versionInfo.BackgroundTransparency = 1
    versionInfo.Font = Enum.Font.Gotham
    versionInfo.TextColor3 = Color3.fromRGB(180, 180, 180)
    versionInfo.TextSize = 12
    versionInfo.Text = "v2.0"
    versionInfo.Parent = header
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0, 320, 0, 22)
    statusLabel.Position = UDim2.new(0.5, -160, 0, 58)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Font = Enum.Font.GothamSemibold
    statusLabel.TextColor3 = Color3.fromRGB(230, 190, 255)
    statusLabel.TextSize = 16
    statusLabel.Text = "INITIALIZING LOADER"
    statusLabel.Parent = mainContainer
    
    local operationStatus = Instance.new("TextLabel")
    operationStatus.Size = UDim2.new(0, 320, 0, 20)
    operationStatus.Position = UDim2.new(0.5, -160, 0, 82)
    operationStatus.BackgroundTransparency = 1
    operationStatus.Font = Enum.Font.Gotham
    operationStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
    operationStatus.TextSize = 14
    operationStatus.Text = "Connecting to server..."
    operationStatus.Parent = mainContainer
    
    local timeRemaining = Instance.new("TextLabel")
    timeRemaining.Size = UDim2.new(0, 320, 0, 20)
    timeRemaining.Position = UDim2.new(0.5, -160, 0, 104)
    timeRemaining.BackgroundTransparency = 1
    timeRemaining.Font = Enum.Font.Gotham
    timeRemaining.TextColor3 = Color3.fromRGB(180, 180, 180)
    timeRemaining.TextSize = 13
    timeRemaining.Text = "Estimated time: ~5s"
    timeRemaining.Parent = mainContainer
    
    local progressBarContainer = Instance.new("Frame")
    progressBarContainer.Size = UDim2.new(0.88, 0, 0, 10)
    progressBarContainer.Position = UDim2.new(0.5, 0, 0, 138)
    progressBarContainer.AnchorPoint = Vector2.new(0.5, 0)
    progressBarContainer.BackgroundColor3 = Color3.fromRGB(40, 35, 50)
    progressBarContainer.BorderSizePixel = 0
    progressBarContainer.Parent = mainContainer
    
    local progressBarCorner = Instance.new("UICorner")
    progressBarCorner.CornerRadius = UDim.new(0, 5)
    progressBarCorner.Parent = progressBarContainer
    
    local progressBarFill = Instance.new("Frame")
    progressBarFill.Name = "Fill"
    progressBarFill.Size = UDim2.new(0, 0, 1, 0)
    progressBarFill.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    progressBarFill.BorderSizePixel = 0
    progressBarFill.Parent = progressBarContainer
    
    local progressBarFillCorner = Instance.new("UICorner")
    progressBarFillCorner.CornerRadius = UDim.new(0, 5)
    progressBarFillCorner.Parent = progressBarFill
    
    local progressGradient = Instance.new("UIGradient")
    progressGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(158, 63, 246)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(118, 23, 206))
    })
    progressGradient.Parent = progressBarFill
    
    local statusDetails = Instance.new("TextLabel")
    statusDetails.Size = UDim2.new(0, 340, 0, 20)
    statusDetails.Position = UDim2.new(0.5, -170, 0, 160)
    statusDetails.BackgroundTransparency = 1
    statusDetails.Font = Enum.Font.Code
    statusDetails.TextColor3 = Color3.fromRGB(130, 130, 150)
    statusDetails.TextSize = 11
    statusDetails.Text = ">> System: loader.init"
    statusDetails.Parent = mainContainer
    
    local percentLabel = Instance.new("TextLabel")
    percentLabel.Size = UDim2.new(0, 50, 0, 20)
    percentLabel.Position = UDim2.new(0.5, -25, 0, 175)
    percentLabel.BackgroundTransparency = 1
    percentLabel.Font = Enum.Font.GothamBold
    percentLabel.TextColor3 = Color3.fromRGB(138, 43, 226)
    percentLabel.TextSize = 13
    percentLabel.Text = "0%"
    percentLabel.Parent = mainContainer
    
    local particlesContainer = Instance.new("Frame")
    particlesContainer.Size = UDim2.new(1, 0, 1, 0)
    particlesContainer.BackgroundTransparency = 1
    particlesContainer.ClipsDescendants = true
    particlesContainer.ZIndex = 0
    particlesContainer.Parent = mainContainer
    
    local function createParticle()
        local particle = Instance.new("Frame")
        particle.Size = UDim2.new(0, math.random(1, 3), 0, math.random(1, 3))
        particle.Position = UDim2.new(math.random(0, 100)/100, 0, 1, 0)
        particle.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
        particle.BackgroundTransparency = math.random(40, 80)/100
        particle.BorderSizePixel = 0
        particle.ZIndex = 0
        
        local particleCorner = Instance.new("UICorner")
        particleCorner.CornerRadius = UDim.new(1, 0)
        particleCorner.Parent = particle
        
        particle.Parent = particlesContainer
        
        local targetPosition = UDim2.new(particle.Position.X.Scale, 0, -0.1, 0)
        local tweenInfo = TweenInfo.new(
            math.random(3, 6),
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.Out
        )
        
        local tween = TweenService:Create(particle, tweenInfo, {
            Position = targetPosition,
            BackgroundTransparency = 1
        })
        
        tween:Play()
        
        tween.Completed:Connect(function()
            particle:Destroy()
        end)
    end
    
    local particleConnection
    particleConnection = RunService.Heartbeat:Connect(function()
        if math.random(1, 8) == 1 then
            createParticle()
        end
    end)
    
    screenGui.Parent = game:GetService("CoreGui")
    
    mainContainer.BackgroundTransparency = 1
    header.BackgroundTransparency = 1
    cornerFix.BackgroundTransparency = 1
    logoContainer.BackgroundTransparency = 1
    borderGlow.Transparency = 1
    statusLabel.TextTransparency = 1
    operationStatus.TextTransparency = 1
    timeRemaining.TextTransparency = 1
    progressBarContainer.BackgroundTransparency = 1
    progressBarFill.BackgroundTransparency = 1
    statusDetails.TextTransparency = 1
    percentLabel.TextTransparency = 1
    logoText.TextTransparency = 1
    title.TextTransparency = 1
    versionInfo.TextTransparency = 1
    
    task.wait(0.2)
    
    TweenService:Create(blurEffect, TweenInfo.new(0.5), {Size = 5}):Play()
    TweenService:Create(mainContainer, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
    
    task.wait(0.1)
    TweenService:Create(header, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
    TweenService:Create(cornerFix, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
    TweenService:Create(borderGlow, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 0}):Play()
    
    task.wait(0.2)
    TweenService:Create(logoContainer, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
    TweenService:Create(logoText, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
    
    task.wait(0.1)
    TweenService:Create(title, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
    TweenService:Create(versionInfo, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
    
    task.wait(0.2)
    TweenService:Create(statusLabel, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
    
    task.wait(0.1)
    TweenService:Create(operationStatus, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
    TweenService:Create(timeRemaining, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
    
    task.wait(0.1)
    TweenService:Create(progressBarContainer, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
    TweenService:Create(progressBarFill, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
    
    task.wait(0.1)
    TweenService:Create(statusDetails, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
    TweenService:Create(percentLabel, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
    
    local stages = {
        {percent = 15, status = "Connecting to server...", detail = ">> System: network.connect", time = 0.4},
        {percent = 30, status = "Fetching configuration...", detail = ">> System: config.fetch", time = 0.5},
        {percent = 50, status = "Loading game configuration...", detail = ">> System: game.config.load", time = 0.6},
        {percent = 70, status = "Verifying game compatibility...", detail = ">> System: game.verify", time = 0.5},
        {percent = 85, status = "Initializing modules...", detail = ">> System: modules.init", time = 0.4},
        {percent = 100, status = "Loading script...", detail = ">> System: script.execute", time = 0.3}
    }
    
    for _, stage in ipairs(stages) do
        operationStatus.Text = stage.status
        statusDetails.Text = stage.detail
        percentLabel.Text = stage.percent .. "%"
        
        TweenService:Create(progressBarFill, TweenInfo.new(stage.time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(stage.percent / 100, 0, 1, 0)
        }):Play()
        
        task.wait(stage.time)
    end
    
    local success, config = pcall(function()
        return game:HttpGet("https://raw.githubusercontent.com/ShadowXScript/Shadow-Hub/refs/heads/main/GameConfig.lua")
    end)
    
    if success then
        pcall(function()
            loadstring(config)()
        end)
        
        if getgenv().logo then
            print(getgenv().logo)
        end
        
        local currentPlaceId = game.PlaceId
        local gameFound = false
        
        if getgenv().gamechecker and getgenv().gamesConfig then
            for _, gameConfig in ipairs(getgenv().gamesConfig) do
                if gameConfig.placeId == currentPlaceId then
                    gameFound = true
                    statusLabel.Text = "GAME DETECTED"
                    operationStatus.Text = "Loading " .. gameConfig.gameName
                    
                    task.wait(0.5)
                    
                    pcall(function()
                        loadstring(gameConfig.ConfigScript)()
                    end)
                    break
                end
            end
        end
        
        if not gameFound then
            statusLabel.Text = "UNIVERSAL MODE"
            operationStatus.Text = "Loading universal script..."
            
            task.wait(0.5)
            
            if getgenv().UniversalScript then
                pcall(function()
                    loadstring(getgenv().UniversalScript)()
                end)
            end
        end
        
        statusLabel.TextColor3 = Color3.fromRGB(130, 255, 170)
        statusLabel.Text = "LOADED SUCCESSFULLY"
        operationStatus.Text = "Shadow Hub initialized"
        statusDetails.Text = ">> System: complete"
        
        local successGradient = Instance.new("UIGradient")
        successGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 230, 150)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 200, 120))
        })
        progressGradient:Destroy()
        successGradient.Parent = progressBarFill
        
    else
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        statusLabel.Text = "CONNECTION FAILED"
        operationStatus.Text = "Could not reach server"
    end
    
    task.wait(1.5)
    
    local allElements = {
        mainContainer, header, cornerFix, logoContainer, statusLabel, operationStatus,
        timeRemaining, progressBarContainer, statusDetails, percentLabel, borderGlow,
        logoText, title, versionInfo
    }
    
    for _, element in ipairs(allElements) do
        if element:IsA("Frame") then
            TweenService:Create(element, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
        elseif element:IsA("TextLabel") then
            TweenService:Create(element, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
        elseif element:IsA("UIStroke") then
            TweenService:Create(element, TweenInfo.new(0.5), {Transparency = 1}):Play()
        end
    end
    
    TweenService:Create(blurEffect, TweenInfo.new(0.5), {Size = 0}):Play()
    
    if particleConnection then
        particleConnection:Disconnect()
    end
    
    task.wait(0.6)
    blurEffect:Destroy()
    screenGui:Destroy()
end

createShadowLoader()
