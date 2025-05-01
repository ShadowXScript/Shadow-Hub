-- Load _rf UI
if not game:IsLoaded() then game.Loaded:Wait() end

local success, _r = pcall(function()
    return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
end)

if not success or not _r then
    warn("Failed to load _rf UI Library")
    return
end

local _rf = _r

local _w = _rf:CreateWindow({
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
local _ds = {
    Steal = 0.5,
    Dribble = 0.5,
    Block = 0.5
}

-- Main Tab
local _mt = _w:CreateTab("Main Features", 7733960981)
_mt:CreateSection("Main Features")

_mt:CreateToggle({
    Name = "Auto Dunk",
    CurrentValue = false,
    Callback = function(Value)
            _rf:Notify({Title = "Shadow Hub", Content = "Auto Dunk Toggled", Duration = 3})

        while Value and task.wait(0.5) do
            pcall(function()
                game.ReplicatedStorage.Packages.Knit.Services.BallService.RE.Dunk:FireServer()
            end)
        end
    end
})

_mt:CreateToggle({
    Name = "Auto Dribble",
    CurrentValue = false,
    Callback = function(Value)
            _rf:Notify({Title = "Shadow Hub", Content = "Auto Dribble Toggled", Duration = 3})

        while Value and task.wait(_ds.Dribble) do
            game.ReplicatedStorage.Packages.Knit.Services.BallService.RE.Dribble:FireServer()
        end
    end
})

_mt:CreateToggle({
    Name = "Auto Steal",
    CurrentValue = false,
    Callback = function(Value)
            _rf:Notify({Title = "Shadow Hub", Content = "Auto Steal Toggled", Duration = 3})

        while Value and task.wait(_ds.Steal) do
            game.ReplicatedStorage.Packages.Knit.Services.BallService.RE.Steal:FireServer()
        end
    end
})

_mt:CreateToggle({
    Name = "Auto Block",
    CurrentValue = false,
    Callback = function(Value)
            _rf:Notify({Title = "Shadow Hub", Content = "Auto Block Toggled", Duration = 3})

        while Value and task.wait(_ds.Block) do
            game.ReplicatedStorage.Packages.Knit.Services.BallService.RE.Block:FireServer()
        end
    end
})

-- Abilities Tab
local _at = _w:CreateTab("Abilities", 4483362458)
_at:CreateSection("Abilities")

_at:CreateToggle({
    Name = "No Cooldown Ability",
    CurrentValue = false,
    Callback = function(Value)
            _rf:Notify({Title = "Shadow Hub", Content = "No Cooldown Ability Toggled", Duration = 3})

        local _ac = require(game.ReplicatedStorage.Controllers.AbilityController)
        local _oc = _ac.CDS
        if Value then
            _ac.CDS = setmetatable({}, {
                __index = function() return 0 end,
                __newindex = function(_, k, v) _oc[k] = v end
})
        else
            _ac.CDS = _oc
        end
    end
})

_at:CreateToggle({
    Name = "Auto Zone",
    CurrentValue = false,
    Callback = function(Value)
            _rf:Notify({Title = "Shadow Hub", Content = "Auto Zone Toggled", Duration = 3})

        while Value and task.wait(2) do
            game.ReplicatedStorage.Packages.Knit.Services.ZoneService.RE.Activate:FireServer()
        end
    end
})

_at:CreateToggle({
    Name = "Auto Awaken",
    CurrentValue = false,
    Callback = function(Value)
            _rf:Notify({Title = "Shadow Hub", Content = "Auto Awaken Toggled", Duration = 3})

        while Value and task.wait(2) do
            game.ReplicatedStorage.Packages.Knit.Services.AwakeningService.RE.Awaken:FireServer()
        end
    end
})

-- Spin & Zone Tab
local _st = _w:CreateTab("Spin & Zone", 4483362458)
_st:CreateSection("Spin Actions")

_st:CreateButton({
    Name = "Spin Style",
    Callback = function()
        game.ReplicatedStorage.Packages.Knit.Services.StyleService.RE.Spin:FireServer()
    end
})

_st:CreateButton({
    Name = "Spin Zone",
    Callback = function()
        game.ReplicatedStorage.Packages.Knit.Services.ZoneService.RE.Spin:FireServer()
    end
})

_st:CreateButton({
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
local _ft = _w:CreateTab("FE Style [Need Copycat]", 7734068321)
_ft:CreateSection("Select Style")

local _sl = {"Clutch", "Chuck", "Phantom", "Playmaker", "Star", "Sniper", "Flash", "Lock", "Giant", "Ace", "Jackpot", "Copycat"}

for _, style in ipairs(_sl) do
    _ft:CreateButton({
        Name = style,
        Callback = function()
            game.Players.LocalPlayer.Style.Value = style
        end
    })
end

-- Settings Tab
local _set = _w:CreateTab("Settings", 4483362458)
_set:CreateSection("Delay Settings")

_set:CreateInput({
    Name = "Auto Steal Delay",
    PlaceholderText = "Enter delay in seconds (e.g. 0.5)",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        local num = tonumber(Text)
        if num then _ds.Steal = num end
    end
})

_set:CreateInput({
    Name = "Auto Dribble Delay",
    PlaceholderText = "Enter delay in seconds (e.g. 0.5)",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        local num = tonumber(Text)
        if num then _ds.Dribble = num end
    end
})

_set:CreateInput({
    Name = "Auto Block Delay",
    PlaceholderText = "Enter delay in seconds (e.g. 0.5)",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        local num = tonumber(Text)
        if num then _ds.Block = num end
    end
})