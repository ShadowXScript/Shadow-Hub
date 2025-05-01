-- Shadow Hub | Basketball Zero

local success, RayfieldLib = pcall(function()
    return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)

if not success or not RayfieldLib then
    warn("Failed to load Rayfield Library")
    return
end

local Window = RayfieldLib:CreateWindow({
    Name = "Shadow Hub | Basketball Zero",
    Icon = 0,
    LoadingTitle = "Shadow Hub Loading...",
    LoadingSubtitle = "by Shadow",
    Theme = "Amethyst",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "BBZConfig",
        FileName = "Shadow Hub"
    },
    Discord = {
        Enabled = true,
        Invite = "https://discord.gg/nz442RKQBd",
        RememberJoins = true
    }
})

local dS = { Steal = 0.5, Dribble = 0.5, Block = 0.5 }

local function notify(name, state)
    RayfieldLib:Notify({
        Title = name,
        Content = name .. " is now " .. (state and "Enabled" or "Disabled"),
        Duration = 3
    })
end

local MainTab = Window:CreateTab("Main Features", 7733960981)
MainTab:CreateSection("Main Features")

MainTab:CreateToggle({
  Name = "Auto Dunk", CurrentValue = false,
  Callback = function(v)
    notify("Auto Dunk", v)
    while v and task.wait(0.5) do
      pcall(function()
        game.ReplicatedStorage.Packages.Knit.Services.BallService.RE.Dunk:FireServer()
      end)
    end
  end
})

MainTab:CreateToggle({
  Name = "Auto Dribble", CurrentValue = false,
  Callback = function(v)
    notify("Auto Dribble", v)
    while v and task.wait(dS.Dribble) do
      game.ReplicatedStorage.Packages.Knit.Services.BallService.RE.Dribble:FireServer()
    end
  end
})

MainTab:CreateToggle({
  Name = "Auto Steal", CurrentValue = false,
  Callback = function(v)
    notify("Auto Steal", v)
    while v and task.wait(dS.Steal) do
      game.ReplicatedStorage.Packages.Knit.Services.BallService.RE.Steal:FireServer()
    end
  end
})

MainTab:CreateToggle({
  Name = "Auto Block", CurrentValue = false,
  Callback = function(v)
    notify("Auto Block", v)
    while v and task.wait(dS.Block) do
      game.ReplicatedStorage.Packages.Knit.Services.BallService.RE.Block:FireServer()
    end
  end
})

-- Abilities
local at = Window:CreateTab("Abilities", 4483362458)
at:CreateSection("Abilities")

at:CreateToggle({
  Name = "No Cooldown Ability", CurrentValue = false,
  Callback = function(v)
    notify("No Cooldown Ability", v)
    local ac = require(game.ReplicatedStorage.Controllers.AbilityController)
    local ocds = ac.CDS
    if v then
      ac.CDS = setmetatable({}, {
        __index = function() return 0 end,
        __newindex = function(_, k, val) ocds[k] = val end
      })
    else
      ac.CDS = ocds
    end
  end
})

at:CreateToggle({
  Name = "Auto Zone", CurrentValue = false,
  Callback = function(v)
    notify("Auto Zone", v)
    while v and task.wait(2) do
      game.ReplicatedStorage.Packages.Knit.Services.ZoneService.RE.Activate:FireServer()
    end
  end
})

at:CreateToggle({
  Name = "Auto Awaken", CurrentValue = false,
  Callback = function(v)
    notify("Auto Awaken", v)
    while v and task.wait(2) do
      game.ReplicatedStorage.Packages.Knit.Services.AwakeningService.RE.Awaken:FireServer()
    end
  end
})

-- Spin & Zone
local SettingsTab = Window:CreateTab("Spin & Zone", 4483362458)
SettingsTab:CreateSection("Spin Actions")

SettingsTab:CreateButton({
  Name = "Spin Style", Callback = function()
    game.ReplicatedStorage.Packages.Knit.Services.StyleService.RE.Spin:FireServer()
  end
})

SettingsTab:CreateButton({
  Name = "Spin Zone", Callback = function()
    game.ReplicatedStorage.Packages.Knit.Services.ZoneService.RE.Spin:FireServer()
  end
})

SettingsTab:CreateButton({
  Name = "Auto Rejoin", Callback = function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
  end
})

-- Style Selection
local ft = Window:CreateTab("FE Style [Need Copycat]", 7734068321)
ft:CreateSection("Select Style")
for _, s in ipairs({ "Clutch", "Chuck", "Phantom", "Playmaker", "Star", "Sniper", "Flash", "Lock", "Giant", "Ace", "Jackpot", "Copycat" }) do
  ft:CreateButton({
    Name = s, Callback = function()
      game.Players.LocalPlayer.Style.Value = s
    end
  })
end

-- === MISC ===
local MiscTab = Window:CreateTab("Misc", 4483362460)
local MiscSection = MiscTab:CreateSection("Utilities")

MiscSection:CreateButton({
  Name = "Auto Rejoin", Callback = function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
  end
})

MiscSection:CreateButton({
    Name = "Claim Daily Reward",
    Callback = function()
        pcall(function()
            game.ReplicatedStorage.Packages.Knit.Services.DailyRewardsService.RF.ClaimDailyReward:InvokeServer()
        end)
        notify("Claimed Daily Reward", true)
    end
})

MiscSection:CreateButton({
    Name = "Redeem All Codes",
    Callback = function()
        local codes = {"2.5MLIKES", "TATLISPATCHWOW", "CODE3"}
        for _, code in ipairs(codes) do
            pcall(function()
                game.ReplicatedStorage.Packages.Knit.Services.CodesService.RF.RedeemCode:InvokeServer(code)
            end)
            task.wait(0.3)
        end
        notify("Redeemed All Codes", true)
    end
})

-- Settings
local set = Window:CreateTab("Settings", 4483362458)
set:CreateSection("Delay Settings")

set:CreateInput({
  Name = "Auto Steal Delay", PlaceholderText = "e.g. 0.5", RemoveTextAfterFocusLost = false,
  Callback = function(t) local n = tonumber(t) if n then dS.Steal = n end end
})

set:CreateInput({
  Name = "Auto Dribble Delay", PlaceholderText = "e.g. 0.5", RemoveTextAfterFocusLost = false,
  Callback = function(t) local n = tonumber(t) if n then dS.Dribble = n end end
})

set:CreateInput({
  Name = "Auto Block Delay", PlaceholderText = "e.g. 0.5", RemoveTextAfterFocusLost = false,
  Callback = function(t) local n = tonumber(t) if n then dS.Block = n end end
})
