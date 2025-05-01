-- Shadow Hub | Basketball Zero

if not game:IsLoaded() then game.Loaded:Wait() end

local suc, rf = pcall(function() return loadstring(game:HttpGet("https://sirius.menu/rayfield"))() end)
if not suc or not rf then return warn("Rayfield UI not loaded.") end
local r = rf

local w = r:CreateWindow({
  Name = "Shadow Hub | Basketball Zero",
  LoadingTitle = "Shadow Hub Loading...",
  LoadingSubtitle = "by Shadow",
  ConfigurationSaving = { Enabled = true, FolderName = "BBZConfig", FileName = "ShadowHub" },
  Discord = { Enabled = true, Invite = "nz442RKQBd", RememberJoins = false },
  KeySystem = false, Theme = "Amethyst"
})

local dS = { Steal = 0.5, Dribble = 0.5, Block = 0.5 }

local function notify(name, state)
  r:Notify({ Title = name, Content = name .. " is now " .. (state and "Enabled" or "Disabled"), Duration = 3 })
end

-- Main Features
local mt = w:CreateTab("Main Features", 7733960981)
mt:CreateSection("Main Features")

mt:CreateToggle({
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

mt:CreateToggle({
  Name = "Auto Dribble", CurrentValue = false,
  Callback = function(v)
    notify("Auto Dribble", v)
    while v and task.wait(dS.Dribble) do
      game.ReplicatedStorage.Packages.Knit.Services.BallService.RE.Dribble:FireServer()
    end
  end
})

mt:CreateToggle({
  Name = "Auto Steal", CurrentValue = false,
  Callback = function(v)
    notify("Auto Steal", v)
    while v and task.wait(dS.Steal) do
      game.ReplicatedStorage.Packages.Knit.Services.BallService.RE.Steal:FireServer()
    end
  end
})

mt:CreateToggle({
  Name = "Auto Block", CurrentValue = false,
  Callback = function(v)
    notify("Auto Block", v)
    while v and task.wait(dS.Block) do
      game.ReplicatedStorage.Packages.Knit.Services.BallService.RE.Block:FireServer()
    end
  end
})

-- Abilities
local at = w:CreateTab("Abilities", 4483362458)
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
local st = w:CreateTab("Spin & Zone", 4483362458)
st:CreateSection("Spin Actions")

st:CreateButton({
  Name = "Spin Style", Callback = function()
    game.ReplicatedStorage.Packages.Knit.Services.StyleService.RE.Spin:FireServer()
  end
})

st:CreateButton({
  Name = "Spin Zone", Callback = function()
    game.ReplicatedStorage.Packages.Knit.Services.ZoneService.RE.Spin:FireServer()
  end
})

st:CreateButton({
  Name = "Auto Rejoin", Callback = function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
  end
})

-- Style Selection
local ft = w:CreateTab("FE Style [Need Copycat]", 7734068321)
ft:CreateSection("Select Style")
for _, s in ipairs({ "Clutch", "Chuck", "Phantom", "Playmaker", "Star", "Sniper", "Flash", "Lock", "Giant", "Ace", "Jackpot", "Copycat" }) do
  ft:CreateButton({
    Name = s, Callback = function()
      game.Players.LocalPlayer.Style.Value = s
    end
  })
end

-- Settings
local set = w:CreateTab("Settings", 4483362458)
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
