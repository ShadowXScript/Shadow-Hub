
if not game:IsLoaded() then game.Loaded:Wait() end
local aigJDD, XJwZOo = pcall(function()
    return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
end)
if not aigJDD or not XJwZOo then
    warn("Failed to load iJLDIC UI Library")
    return
end
local iJLDIC = XJwZOo
local ENMvMe = iJLDIC:CreateWindow({
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
local qQAitZ = {
    Steal = 0.5,
    Dribble = 0.5,
    Block = 0.5
}
local MNnuEj = ENMvMe:CreateTab("Main Features", 7733960981)
MNnuEj:CreateSection("Main Features")
MNnuEj:CreateToggle({
    Name = "Auto Dunk",
    CurrentValue = false,
    Callback = function(Value)
        while Value and task.wait(0.5) do
            pcall(function()
                game.ReplicatedStorage.Packages.Knit.Services.BallService.RE.Dunk:FireServer()
            end)
        end
    end
})
MNnuEj:CreateToggle({
    Name = "Auto Dribble",
    CurrentValue = false,
    Callback = function(Value)
        while Value and task.wait(qQAitZ.Dribble) do
            game.ReplicatedStorage.Packages.Knit.Services.BallService.RE.Dribble:FireServer()
        end
    end
})
MNnuEj:CreateToggle({
    Name = "Auto Steal",
    CurrentValue = false,
    Callback = function(Value)
        while Value and task.wait(qQAitZ.Steal) do
            game.ReplicatedStorage.Packages.Knit.Services.BallService.RE.Steal:FireServer()
        end
    end
})
MNnuEj:CreateToggle({
    Name = "Auto Block",
    CurrentValue = false,
    Callback = function(Value)
        while Value and task.wait(qQAitZ.Block) do
            game.ReplicatedStorage.Packages.Knit.Services.BallService.RE.Block:FireServer()
        end
    end
})
local WFOYvY = ENMvMe:CreateTab("Abilities", 4483362458)
WFOYvY:CreateSection("Abilities")
WFOYvY:CreateToggle({
    Name = "No Cooldown Ability",
    CurrentValue = false,
    Callback = function(Value)
        local aAObKb = require(game.ReplicatedStorage.Controllers.AbilityController)
        local nsepJH = aAObKb.CDS
        if Value then
            aAObKb.CDS = setmetatable({}, {
                __index = function() return 0 end,
                __newindex = function(_, k, v) nsepJH[k] = v end
            })
        else
            aAObKb.CDS = nsepJH
        end
    end
})
WFOYvY:CreateToggle({
    Name = "Auto Zone",
    CurrentValue = false,
    Callback = function(Value)
        while Value and task.wait(2) do
            game.ReplicatedStorage.Packages.Knit.Services.ZoneService.RE.Activate:FireServer()
        end
    end
})
WFOYvY:CreateToggle({
    Name = "Auto Awaken",
    CurrentValue = false,
    Callback = function(Value)
        while Value and task.wait(2) do
            game.ReplicatedStorage.Packages.Knit.Services.AwakeningService.RE.Awaken:FireServer()
        end
    end
})
local VWQvYe = ENMvMe:CreateTab("Spin & Zone", 4483362458)
VWQvYe:CreateSection("Spin Actions")
VWQvYe:CreateButton({
    Name = "Spin Style",
    Callback = function()
        game.ReplicatedStorage.Packages.Knit.Services.StyleService.RE.Spin:FireServer()
    end
})
VWQvYe:CreateButton({
    Name = "Spin Zone",
    Callback = function()
        game.ReplicatedStorage.Packages.Knit.Services.ZoneService.RE.Spin:FireServer()
    end
})
VWQvYe:CreateButton({
    Name = "Auto Rejoin",
    Callback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(
            game.PlaceId,
            game.JobId,
            game.Players.LocalPlayer
        )
    end
})
local lnvRNA = ENMvMe:CreateTab("FE Style [Need Copycat]", 7734068321)
lnvRNA:CreateSection("Select Style")
local styles = {"Clutch", "Chuck", "Phantom", "Playmaker", "Star", "Sniper", "Flash", "Lock", "Giant", "Ace", "Jackpot", "Copycat"}
for _, style in ipairs(styles) do
    lnvRNA:CreateButton({
        Name = style,
        Callback = function()
            game.Players.LocalPlayer.Style.Value = style
        end
    })
end
local GaeDkQ = ENMvMe:CreateTab("Settings", 4483362458)
GaeDkQ:CreateSection("Delay Settings")
GaeDkQ:CreateInput({
    Name = "Auto Steal Delay",
    PlaceholderText = "Enter delay in seconds (e.g. 0.5)",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        local num = tonumber(Text)
        if num then qQAitZ.Steal = num end
    end
})
GaeDkQ:CreateInput({
    Name = "Auto Dribble Delay",
    PlaceholderText = "Enter delay in seconds (e.g. 0.5)",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        local num = tonumber(Text)
        if num then qQAitZ.Dribble = num end
    end
})
GaeDkQ:CreateInput({
    Name = "Auto Block Delay",
    PlaceholderText = "Enter delay in seconds (e.g. 0.5)",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        local num = tonumber(Text)
        if num then qQAitZ.Block = num end
    end
})