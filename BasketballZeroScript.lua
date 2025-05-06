local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/main/source.lua", true))()

local Window = Luna:CreateWindow({
	Name = "Shadow Hub | Basketball Zero",
	Subtitle = "By Shadow",
	LogoID = "82795327169782",
	LoadingTitle = "Shadow Hub Loading...",
	LoadingSubtitle = "by Shadow",
	ConfigSettings = {
		ConfigFolder = "Shadow Hub"
	},
	KeySystem = false
})

local Tab = Window:CreateTab({
	Name = "Main",
	Icon = "view_in_ar",
	ImageSource = "Material",
	ShowTitle = true -- This will determine whether the big header text in the tab will show
})

local dS = { Steal = 0.5, Dribble = 0.5, Block = 0.5, Dunk = 0.5 }

Tab:CreateSection("Main Features")

-- Initialize variables
local isEnabled = false
local radius = 20
local shotSpeed = 80
local goalParts = {}
local ballParts = {}
local ballCooldowns = {}
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Players = game:GetService('Players')
local LocalPlayer = Players.LocalPlayer

-- Notification function
local function notify(message, success)
    -- You can replace this with your preferred notification system
    if success then
        print("[SUCCESS] " .. message)
    else
        print("[ERROR] " .. message)
    end
end

local Toggle = Tab:CreateToggle({
	Name = "Always In + Aim Assist",
	Description = nil,
	CurrentValue = false,
	Callback = function(Value)
		isEnabled = Value
		updateGoals()
	end,
})

local RadiusInput = Tab:CreateInput({
	Name = "Radius",
	Description = "Enter a number between 0-100",
	PlaceholderText = "Enter radius (e.g. 20)",
	CurrentValue = "", 
	Numeric = true,
	MaxCharacters = nil,
	Enter = false,
	Callback = function(text)
		local num = tonumber(text)
		if num and num > 0 then
			radius = num
		end
	end,
})

local SpeedInput = Tab:CreateInput({
	Name = "Shot Speed",
	Description = "Enter a number between 1-1000",
	PlaceholderText = "Enter speed (e.g. 80)",
	CurrentValue = "",
	Numeric = true,
	MaxCharacters = nil,
	Enter = false,
	Callback = function(text)
		local num = tonumber(text)
		if num and num >= 1 and num <= 1000 then
			shotSpeed = num
		end
	end,
})

-- Remove any old velocity forces
local function removeBodyMovers(part)
	if not part then return end
	for _, child in ipairs(part:GetChildren()) do
		if child:IsA('BodyVelocity') then
			child:Destroy()
		end
	end
end

-- Update goal positions
function updateGoals()
	goalParts = {}
	if not isEnabled then return end
	for _, obj in ipairs(Workspace:GetDescendants()) do
		if obj:IsA("BasePart") and obj.Name == "Goal" then
			table.insert(goalParts, obj)
		end
	end
end

-- Update balls list
local lastBallUpdate = 0
local function updateBalls()
	ballParts = {}
	for _, obj in ipairs(Workspace:GetDescendants()) do
		if obj:IsA("BasePart") and obj.Name == "Ball" then
			table.insert(ballParts, obj)
		end
	end
end

-- Main logic
RunService.Heartbeat:Connect(function()
	if not isEnabled then return end

	if tick() - lastBallUpdate > 1 then
		updateBalls()
		lastBallUpdate = tick()
	end

	for _, ball in ipairs(ballParts) do
		if not ball or not ball.Parent then
			ballCooldowns[ball] = nil
			continue
		end

		if ballCooldowns[ball] and tick() < ballCooldowns[ball] then
			continue
		end

		for _, goal in ipairs(goalParts) do
			if not goal or not goal.Parent then continue end

			local goalPos = goal.Position + Vector3.new(0, 1, 0)
			if (ball.Position - goalPos).Magnitude < radius then
				removeBodyMovers(ball)

				local dir = (goalPos - ball.Position).Unit
				local bv = Instance.new("BodyVelocity")
				bv.Velocity = dir * shotSpeed
				bv.MaxForce = Vector3.new(4000, 4000, 4000)
				bv.P = 1250
				bv.Parent = ball

				task.delay(0.25, function()
					if ball and ball.Parent then
						removeBodyMovers(ball)
					end
				end)

				ballCooldowns[ball] = tick() + 1.25
				break
			end
		end
	end
end)

-- Cleanup on goal/ball removal
Workspace.DescendantRemoving:Connect(function(descendant)
	if descendant:IsA("BasePart") then
		if descendant.Name == "Ball" then
			ballCooldowns[descendant] = nil
		elseif descendant.Name == "Goal" then
			for i, g in ipairs(goalParts) do
				if g == descendant then
					table.remove(goalParts, i)
					break
				end
			end
		end
	end
end)

-- Initial goal detection
updateGoals()

-- Variables to track toggle states
local autoDribbleEnabled = false
local autoDunkEnabled = false
local autoStealEnabled = false
local autoBlockEnabled = false

local Toggle = Tab:CreateToggle({
	Name = "Auto Dribble",
	Description = "You can adjust this on the settings",
	CurrentValue = false,
    Callback = function(Value)
        autoDribbleEnabled = Value
        
        -- Start a loop when enabled
        if autoDribbleEnabled then
            task.spawn(function()
                while autoDribbleEnabled do
                    task.wait(dS.Dribble)
                    game.ReplicatedStorage.Packages.Knit.Services.BallService.RE.Dribble:FireServer()
                end
            end)
        end
    end
})

local Toggle = Tab:CreateToggle({
	Name = "Auto Dunk",
	Description = nil,
	CurrentValue = false,
    Callback = function(Value)
        autoDunkEnabled = Value
        
        -- Start a loop when enabled
        if autoDunkEnabled then
            task.spawn(function()
                while autoDunkEnabled do
                    task.wait(dS.Dunk)
                    pcall(function()
                        game.ReplicatedStorage.Packages.Knit.Services.BallService.RE.Dunk:FireServer()
                    end)
                end
            end)
        end
    end
})

local Toggle = Tab:CreateToggle({
	Name = "Auto Steal",
	Description = "You can adjust this on the settings",
	CurrentValue = false,
    Callback = function(Value)
        autoStealEnabled = Value
        
        -- Start a loop when enabled
        if autoStealEnabled then
            task.spawn(function()
                while autoStealEnabled do
                    task.wait(dS.Steal)
                    game.ReplicatedStorage.Packages.Knit.Services.BallService.RE.Steal:FireServer()
                end
            end)
        end
    end
})

local Toggle = Tab:CreateToggle({
	Name = "Auto Block",
	Description = "You can adjust this on the settings",
	CurrentValue = false,
    Callback = function(Value)
        autoBlockEnabled = Value
        
        -- Start a loop when enabled
        if autoBlockEnabled then
            task.spawn(function()
                while autoBlockEnabled do
                    task.wait(dS.Block)
                    game.ReplicatedStorage.Packages.Knit.Services.BallService.RE.Block:FireServer()
                end
            end)
        end
    end
})

local Tab = Window:CreateTab({
	Name = "Abilities",
	Icon = "view_in_ar",
	ImageSource = "Material",
	ShowTitle = true
})
Tab:CreateSection("Abilities")

local Toggle = Tab:CreateToggle({
	Name = "No Cd Abilities",
	Description = nil,
	CurrentValue = false,
    Callback = function(Value)
        local ac = require(game.ReplicatedStorage.Controllers.AbilityController)
        local ocds = ac.CDS
        if Value then
            ac.CDS = setmetatable({}, {
                __index = function() return 0 end,
                __newindex = function(_, k, val) ocds[k] = val end
            })
        else
            ac.CDS = ocds
        end
    end
})

local autoZoneEnabled = false

local Toggle = Tab:CreateToggle({
	Name = "Auto Zone",
	Description = nil,
	CurrentValue = false,
    Callback = function(Value)
        autoZoneEnabled = Value
        
        -- Start a loop when enabled
        if autoZoneEnabled then
            task.spawn(function()
                while autoZoneEnabled do
                    task.wait(2)
                    game.ReplicatedStorage.Packages.Knit.Services.ZoneService.RE.Activate:FireServer()
                end
            end)
        end
    end
})

local Toggle = Tab:CreateToggle({
	Name = "Auto Awaken",
	Description = nil,
	CurrentValue = false,
    Callback = function(Value)
        -- Store the toggle state in a variable to control the loop
        _G.AutoAwakenEnabled = Value
        
        -- Function to handle the awakening process
        local function processAwakening()
            while _G.AutoAwakenEnabled and task.wait(2) do
                -- Play cutscene before awakening
                game.ReplicatedStorage.Packages.Knit.Services.AbilityService.RE.Cutscene:FireServer("Awakening")
                
                -- Wait for cutscene to finish (adjust time as needed)
                task.wait(1.5)
                
                -- Trigger the awakening
                game.ReplicatedStorage.Packages.Knit.Services.AwakeningService.RE.Awaken:FireServer()
            end
        end
        
        -- Start the awakening process in a separate thread to prevent blocking
        if Value then
            coroutine.wrap(processAwakening)()
        end
    end
})

local Tab = Window:CreateTab({
	Name = "Auto Abilities",
	Icon = "view_in_ar",
	ImageSource = "Material",
	ShowTitle = true
})
Tab:CreateSection("Auto Abilities")

local fullCourtLoop = nil
local autoFullCourtEnabled = false

local Toggle = Tab:CreateToggle({
	Name = "Auto Full Court",
	Description = nil,
	CurrentValue = false,
    Callback = function(Value)
        autoFullCourtEnabled = Value
        
        if autoFullCourtEnabled then
            fullCourtLoop = task.spawn(function()
                while autoFullCourtEnabled do
                    local remote = game.ReplicatedStorage.Packages.Knit.Services.AbilityService.RE.Ability
                    
                    remote:FireServer({  
                        ["Ability"] = {  
                            [1] = "FullCourt",  
                            [2] = {  
                                ["timeSent"] = tick()  
                            }  
                        }  
                    })  
                    
                    task.wait(5) -- Adjust frequency (in seconds)  
                end  
            end)  
        else  
            if fullCourtLoop then  
                task.cancel(fullCourtLoop)  
            end  
        end  
    end
})

local Tab = Window:CreateTab({
	Name = "Spin & Zone",
	Icon = "view_in_ar",
	ImageSource = "Material",
	ShowTitle = true
})
Tab:CreateSection("Spin Actions")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit")
local StyleService = Knit.Services.StyleService
local ZoneService = Knit.Services.ZoneService
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Variables to hold selected styles/zones and toggles
local selectedStyle = "Clutch"
local selectedZone = "Hustle"
local styleSpinning = false
local zoneSpinning = false

local Dropdown = Tab:CreateDropdown({
	Name = "Select a Style",
    Description = nil,
	Options = { "Clutch", "Chuck", "Phantom", "Playmaker", "Star", "Sniper", "Flash", "Lock", "Giant", "Ace", "Jackpot", "Copycat", "Perfection" },
    CurrentOption = selectedStyle,
    MultipleOptions = false,
    SpecialType = nil,
    Callback = function(Option)
        -- Check if Option is a table (from dropdown) or a string
        if type(Option) == "table" then
            selectedStyle = Option[1]
        else
            selectedStyle = Option
        end
        StyleService.RF.SetLocked:InvokeServer(selectedStyle)
    end
})

local Toggle = Tab:CreateToggle({
	Name = "Auto Spin for Style",
	Description = nil,
	CurrentValue = false,
    Callback = function(Value)
        styleSpinning = Value
        if styleSpinning then
            StyleService.RF.SetLocked:InvokeServer(selectedStyle)
            task.spawn(function()
                while styleSpinning do
                    if LocalPlayer:WaitForChild("Style").Value == selectedStyle then
                        StyleService.RE.Spin:FireServer()
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})

local Dropdown = Tab:CreateDropdown({
	Name = "Select a Zone",
    Description = nil,
	Options = { "Hustle", "Sprinter", "Lockdown", "Dime", "Quick Draw", "Limitless", "Speed Dribble", "Posterizer", "Street Dribbler", "777", "Unbreakable", "Perfectionist" },
    CurrentOption = selectedZone,
    MultipleOptions = false,
    SpecialType = nil,
    Callback = function(Option)
        -- Check if Option is a table (from dropdown) or a string
        if type(Option) == "table" then
            selectedZone = Option[1]
        else
            selectedZone = Option
        end
        ZoneService.RF.SetLocked:InvokeServer(selectedZone)
    end
})

local Toggle = Tab:CreateToggle({
	Name = "Auto Spin for Zone",
	Description = nil,
	CurrentValue = false,
    Callback = function(Value)
        zoneSpinning = Value
        if zoneSpinning then
            ZoneService.RF.SetLocked:InvokeServer(selectedZone)
            task.spawn(function()
                while zoneSpinning do
                    if LocalPlayer:WaitForChild("Zone").Value == selectedZone then
                        ZoneService.RE.Spin:FireServer()
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})

local Button = Tab:CreateButton({
	Name = "Manual Spin Style",
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
    game.ReplicatedStorage.Packages.Knit.Services.StyleService.RE.Spin:FireServer()
  end
})

local Button = Tab:CreateButton({
	Name = "Manual Spin Zone",
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
    game.ReplicatedStorage.Packages.Knit.Services.ZoneService.RE.Spin:FireServer()
  end
})

local Button = Tab:CreateButton({
	Name = "Style Lucky Spin",
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
        local args = {
            [1] = {
                ["Spin"] = true
            }
        }

        local remote = game.ReplicatedStorage:WaitForChild("Packages")
            .Knit.Services.StyleService.RE.Spin

        remote:FireServer(unpack(args))
    end,
})

local Button = Tab:CreateButton({
	Name = "Zone Lucky Spin",
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
        local args = {
            [1] = {
                ["Spin"] = true
            }
        }

        local remote = game.ReplicatedStorage:WaitForChild("Packages")
            .Knit.Services.ZoneService.RE.Spin

        remote:FireServer(unpack(args))
    end,
})

-- Attempt to get the Remote
local success, PackRemote = pcall(function()
    return game:GetService("ReplicatedStorage")
        :WaitForChild("Packages")
        :WaitForChild("Knit")
        :WaitForChild("Services")
        :WaitForChild("PacksService")
        :WaitForChild("RE")
        :WaitForChild("Pack")
end)

if not success or not PackRemote then
    warn("PackRemote not found. Make sure you're in the correct game and structure hasn't changed.")
end

-- State variables
local spinning = false
local selectedPackType = "Emotes"

local Tab = Window:CreateTab({
	Name = "Spinning Packs",
	Icon = "view_in_ar",
	ImageSource = "Material",
	ShowTitle = true -- This will determine whether the big header text in the tab will show
})
Tab:CreateSection("Packs Features")

local Dropdown = Tab:CreateDropdown({
	Name = "Dropdown Example",
    	Description = nil,
	Options = {"Emotes", "GoalEffects", "Cards"},
    	CurrentOption = {"Option 1"},
    	MultipleOptions = false,
    	SpecialType = "PackType",
    	Callback = function(Value)
        selectedPackType = tostring(Value[1])
    end,
})

local Toggle = Tab:CreateToggle({
	Name = "Auto Spin Packs",
	Description = nil,
	CurrentValue = false,
    	Callback = function(Value)
        spinning = Value
        if spinning then
            task.spawn(function()
                while spinning do
                    if PackRemote then
                        PackRemote:FireServer(selectedPackType)
                    else
                        warn("PackRemote is nil, cannot fire.")
                        break
                    end
                    task.wait(0.5)
                end
            end)
        end
    end,
})

local Tab = Window:CreateTab({
	Name = "FE Style [Need Copycat]",
	Icon = "view_in_ar",
	ImageSource = "Material",
	ShowTitle = true -- This will determine whether the big header text in the tab will show
})
Tab:CreateSection("Select Style")
for _, s in ipairs({ "Clutch", "Chuck", "Phantom", "Playmaker", "Star", "Sniper", "Flash", "Lock", "Giant", "Ace", "Jackpot", "Copycat", "Perfection" }) do
local Button = Tab:CreateButton({
	Name = s,
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
      game.Players.LocalPlayer.Style.Value = s
    end
  })
end

local Tab = Window:CreateTab({
	Name = "FE Zone [Need Copycat]",
	Icon = "view_in_ar",
	ImageSource = "Material",
	ShowTitle = true -- This will determine whether the big header text in the tab will show
})
Tab:CreateSection("Select Zone")
for _, s in ipairs({ "Hustle", "Sprinter", "Lockdown", "Dime", "Quick Draw", "Limitless", "Speed Dribble", "Posterizer", "Street Dribbler", "777", "Unbreakable", "Perfectionist" }) do
local Button = Tab:CreateButton({
	Name = s,
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
      game.Players.LocalPlayer.Zone.Value = s
    end
  })
end

local Tab = Window:CreateTab({
	Name = "Misc",
	Icon = "view_in_ar",
	ImageSource = "Material",
	ShowTitle = true -- This will determine whether the big header text in the tab will show
})
Tab:CreateSection("Utilities")

local SpinWheelRF = game.ReplicatedStorage.Packages.Knit.Services.SpinWheelService.RF.SpinWheel
local GetNextFreeSpinRF = game.ReplicatedStorage.Packages.Knit.Services.SpinWheelService.RF.GetNextFreeSpin

local autoSpin = false
local autoClaim = false

local Toggle = Tab:CreateToggle({
	Name = "Auto Spin Wheel",
	Description = nil,
	CurrentValue = false,
    	Callback = function(Value)
        autoSpin = Value
        
        -- Create a separate thread for auto spinning
        task.spawn(function()
            while autoSpin do
                -- Check if a free spin is available first
                local nextFreeSpin = GetNextFreeSpinRF:InvokeServer()
                
                -- If there's a free spin available (time is 0 or less), use it
                if nextFreeSpin and (typeof(nextFreeSpin) == "number" and nextFreeSpin <= 0) then
                    local success, result = pcall(function()
                        return SpinWheelRF:InvokeServer()
                    end)
                    
                    if success then
                        print("Successfully used spin wheel! Result:", result)
                    else
                        print("Failed to use spin wheel:", result)
                    end
                else
                    -- Print how much time is left until next free spin
                    if typeof(nextFreeSpin) == "number" then
                        print("Next free spin available in:", nextFreeSpin, "seconds")
                    end
                end
                
                -- Wait before checking again
                task.wait(5)
            end
        end)
    end,
})

local Button = Tab:CreateButton({
	Name = "Auto Rejoin",
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
  end
})

local Button = Tab:CreateButton({
	Name = "Claim Daily Reward",
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
        pcall(function()
            game.ReplicatedStorage.Packages.Knit.Services.DailyRewardsService.RF.ClaimDailyReward:InvokeServer()
        end)
        notify("Claimed Daily Reward", true)
    end
})

local Button = Tab:CreateButton({
	Name = "Redeem All Codes",
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
        local codes = {"PERFECTION", "200KPERFECT", "CODE3"}
        for _, code in ipairs(codes) do
            pcall(function()
                game.ReplicatedStorage.Packages.Knit.Services.CodesService.RF.RedeemCode:InvokeServer(code)
            end)
            task.wait(0.3)
        end
        notify("Redeemed All Codes", true)
    end
})

local Tab = Window:CreateTab({
	Name = "Settings",
	Icon = "view_in_ar",
	ImageSource = "Material",
	ShowTitle = true -- This will determine whether the big header text in the tab will show
})
Tab:CreateSection("Delay Settings")

local Input = Tab:CreateInput({
	Name = "Auto Steal Delay",
	Description = nil,
	PlaceholderText = "e.g. 0.5",
	CurrentValue = "", -- the current text
	Numeric = true, -- When true, the user may only type numbers in the box (Example walkspeed)
	MaxCharacters = nil, -- if a number, the textbox length cannot exceed the number
	Enter = false, -- When true, the callback will only be executed when the user presses enter.
    	Callback = function(t) local n = tonumber(t) if n then dS.Steal = n end end
})

local Input = Tab:CreateInput({
	Name = "Auto Dribble Delay",
	Description = nil,
	PlaceholderText = "e.g. 0.5",
	CurrentValue = "", -- the current text
	Numeric = true, -- When true, the user may only type numbers in the box (Example walkspeed)
	MaxCharacters = nil, -- if a number, the textbox length cannot exceed the number
	Enter = false, -- When true, the callback will only be executed when the user presses enter.
    	Callback = function(t) local n = tonumber(t) if n then dS.Dribble = n end end
})

local Input = Tab:CreateInput({
	Name = "Auto Block Delay",
	Description = nil,
	PlaceholderText = "e.g. 0.5",
	CurrentValue = "", -- the current text
	Numeric = true, -- When true, the user may only type numbers in the box (Example walkspeed)
	MaxCharacters = nil, -- if a number, the textbox length cannot exceed the number
	Enter = false, -- When true, the callback will only be executed when the user presses enter.
    	Callback = function(t) local n = tonumber(t) if n then dS.Block = n end end
})