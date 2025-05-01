-- Load _08c31e UI
if not game:IsLoaded() then game.Loaded:Wait() end

local success, RayfieldLib = pcall(function()
    return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
end)

if not success or not RayfieldLib then
    warn("Failed to load _08c31e UI Library")
    return
end

local _08c31e = RayfieldLib

local _c89686 = _08c31e:CreateWindow({
    Name = "Shadow Hub | Basketball Zero",
    LoadingTitle = "Shadow Hub Loading...",
    LoadingSubtitle = "by Shadow",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "BBZConfig",
        FileName = "ShadowHub"
    },
    Discord = {
        Enabled = true,
        Invite = "nz442RKQBd",
        RememberJoins = false
    },
    KeySystem = false,
    Theme = "Amethyst"
})

-- Delay Settings
local _c41ae6 = {
    Steal = 0.5,
    Dribble = 0.5,
    Block = 0.5
}

-- Main Tab
local _3a2593 = _c89686:CreateTab("Main Features", 7733960981)
_3a2593:CreateSection("Main Features")

_3a2593:CreateToggle({
    Name = "Auto Dunk",
    CurrentValue = false,
    Callback = function(_689202)
        Rayfield:Notify("Shadow Hub", "Auto Dunk " .. (_689202 and "Enabled" or "Disabled"), 3)
        while _689202 and task.wait(0.5) do
            pcall(function()
                game.ReplicatedStorage.Packages.Knit.Services.BallService.RE.Dunk:FireServer()
            end)
        end
    end
})

_3a2593:CreateToggle({
    Name = "Auto Dribble",
    CurrentValue = false,
    Callback = function(_689202)
        Rayfield:Notify("Shadow Hub", "Auto Dribble " .. (_689202 and "Enabled" or "Disabled"), 3)
        while _689202 and task.wait(_c41ae6.Dribble) do
            game.ReplicatedStorage.Packages.Knit.Services.BallService.RE.Dribble:FireServer()
        end
    end
})

_3a2593:CreateToggle({
    Name = "Auto Steal",
    CurrentValue = false,
    Callback = function(_689202)
        Rayfield:Notify("Shadow Hub", "Auto Steal " .. (_689202 and "Enabled" or "Disabled"), 3)
        while _689202 and task.wait(_c41ae6.Steal) do
            game.ReplicatedStorage.Packages.Knit.Services.BallService.RE.Steal:FireServer()
        end
    end
})

_3a2593:CreateToggle({
    Name = "Auto Block",
    CurrentValue = false,
    Callback = function(_689202)
        Rayfield:Notify("Shadow Hub", "Auto Block " .. (_689202 and "Enabled" or "Disabled"), 3)
        while _689202 and task.wait(_c41ae6.Block) do
            game.ReplicatedStorage.Packages.Knit.Services.BallService.RE.Block:FireServer()
        end
    end
})

-- Abilities Tab
local _701a6d = _c89686:CreateTab("Abilities", 4483362458)
_701a6d:CreateSection("Abilities")

_701a6d:CreateToggle({
    Name = "No Cooldown Ability",
    CurrentValue = false,
    Callback = function(_689202)
        Rayfield:Notify("Shadow Hub", "No Cooldown Ability " .. (_689202 and "Enabled" or "Disabled"), 3)
        local _4144e0 = require(game.ReplicatedStorage.Controllers.AbilityController)
        local _29a4b6 = _4144e0.CDS
        if _689202 then
            _4144e0.CDS = setmetatable({}, {
                __index = function() return 0 end,
                __newindex = function(_, k, v) _29a4b6[k] = v end
            })
        else
            _4144e0.CDS = _29a4b6
        end
    end
})

_701a6d:CreateToggle({
    Name = "Auto Zone",
    CurrentValue = false,
    Callback = function(_689202)
        Rayfield:Notify("Shadow Hub", "Auto Zone " .. (_689202 and "Enabled" or "Disabled"), 3)
        while _689202 and task.wait(2) do
            game.ReplicatedStorage.Packages.Knit.Services.ZoneService.RE.Activate:FireServer()
        end
    end
})

_701a6d:CreateToggle({
    Name = "Auto Awaken",
    CurrentValue = false,
    Callback = function(_689202)
        Rayfield:Notify("Shadow Hub", "Auto Awaken " .. (_689202 and "Enabled" or "Disabled"), 3)
        while _689202 and task.wait(2) do
            game.ReplicatedStorage.Packages.Knit.Services.AwakeningService.RE.Awaken:FireServer()
        end
    end
})

-- Spin & Zone Tab
local _e68e0d = _c89686:CreateTab("Spin & Zone", 4483362458)
_e68e0d:CreateSection("Spin Actions")

_e68e0d:CreateButton({
    Name = "Spin Style",
    Callback = function()
        game.ReplicatedStorage.Packages.Knit.Services.StyleService.RE.Spin:FireServer()
    end
})

_e68e0d:CreateButton({
    Name = "Spin Zone",
    Callback = function()
        game.ReplicatedStorage.Packages.Knit.Services.ZoneService.RE.Spin:FireServer()
    end
})

_e68e0d:CreateButton({
    Name = "Auto Rejoin",
    Callback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(
            game.PlaceId,
            game.JobId,
            game.Players.LocalPlayer
        )
    end
})

-- FE Style Tab
local _16d452 = _c89686:CreateTab("FE Style [Need Copycat]", 7734068321)
_16d452:CreateSection("Select Style")

local styles = {"Clutch", "Chuck", "Phantom", "Playmaker", "Star", "Sniper", "Flash", "Lock", "Giant", "Ace", "Jackpot", "Copycat"}

for _, style in ipairs(styles) do
    _16d452:CreateButton({
        Name = style,
        Callback = function()
            game.Players.LocalPlayer.Style._689202 = style
        end
    })
end

-- Settings Tab
local _bf3d0f = _c89686:CreateTab("Settings", 4483362458)
_bf3d0f:CreateSection("Delay Settings")

_bf3d0f:CreateInput({
    Name = "Auto Steal Delay",
    PlaceholderText = "Enter delay in seconds (e.g. 0.5)",
    RemoveTextAfterFocusLost = false,
    Callback = function(_9dffbf)
        local _0fc3cf = tonumber(_9dffbf)
        if _0fc3cf then _c41ae6.Steal = _0fc3cf end
    end
})

_bf3d0f:CreateInput({
    Name = "Auto Dribble Delay",
    PlaceholderText = "Enter delay in seconds (e.g. 0.5)",
    RemoveTextAfterFocusLost = false,
    Callback = function(_9dffbf)
        local _0fc3cf = tonumber(_9dffbf)
        if _0fc3cf then _c41ae6.Dribble = _0fc3cf end
    end
})

_bf3d0f:CreateInput({
    Name = "Auto Block Delay",
    PlaceholderText = "Enter delay in seconds (e.g. 0.5)",
    RemoveTextAfterFocusLost = false,
    Callback = function(_9dffbf)
        local _0fc3cf = tonumber(_9dffbf)
        if _0fc3cf then _c41ae6.Block = _0fc3cf end
    end
})