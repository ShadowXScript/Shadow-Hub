if not _g:IsLoaded() then _g.Loaded:Wait() end
local success, _RFLDLib = pcall(function()
return loadstring(_g:HttpGet("https://sirius.menu/rayfield"))()
end)
if not success or not _RFLDLib then
warn("Failed to load _rF UI Library")
return
end
local _rF = _RFLDLib
local _wD = _rF:Create_WND({
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
local _dS = {
Steal = 0.5,
Dribble = 0.5,
Block = 0.5
}
local _mT = _wD:CreateTab("Main Features", 7733960981)
_mT:CreateSection("Main Features")
_mT:CreateToggle({
Name = "Auto Dunk",
_cv = false,
_cb = function(_v)
_rF:Notify({
Title = "Auto Dunk",
Content = "Toggled " .. (_v and "Enabled" or "Disabled"),
Duration = 4
})
while _v and _t.wait(0.5) do
pcall(function()
_g.ReplicatedStorage.Packages.Knit.Services.BallService.RE.Dunk:FireServer()
end)
end
end
})
_mT:CreateToggle({
Name = "Auto Dribble",
_cv = false,
_cb = function(_v)
_rF:Notify({
Title = "Auto Dribble",
Content = "Toggled " .. (_v and "Enabled" or "Disabled"),
Duration = 4
})
while _v and _t.wait(_dS.Dribble) do
_g.ReplicatedStorage.Packages.Knit.Services.BallService.RE.Dribble:FireServer()
end
end
})
_mT:CreateToggle({
Name = "Auto Steal",
_cv = false,
_cb = function(_v)
_rF:Notify({
Title = "Auto Steal",
Content = "Toggled " .. (_v and "Enabled" or "Disabled"),
Duration = 4
})
while _v and _t.wait(_dS.Steal) do
_g.ReplicatedStorage.Packages.Knit.Services.BallService.RE.Steal:FireServer()
end
end
})
_mT:CreateToggle({
Name = "Auto Block",
_cv = false,
_cb = function(_v)
_rF:Notify({
Title = "Auto Block",
Content = "Toggled " .. (_v and "Enabled" or "Disabled"),
Duration = 4
})
while _v and _t.wait(_dS.Block) do
_g.ReplicatedStorage.Packages.Knit.Services.BallService.RE.Block:FireServer()
end
end
})
local _aT = _wD:CreateTab("Abilities", 4483362458)
_aT:CreateSection("Abilities")
_aT:CreateToggle({
Name = "No Cooldown Ability",
_cv = false,
_cb = function(_v)
_rF:Notify({
Title = "No Cooldown Ability",
Content = "Toggled " .. (_v and "Enabled" or "Disabled"),
Duration = 4
})
local AC = require(_g.ReplicatedStorage.Controllers.AbilityController)
local originalCDS = AC.CDS
if _v then
AC.CDS = setmetatable({}, {
__index = function() return 0 end,
__newindex = function(_, k, v) originalCDS[k] = v end
})
else
AC.CDS = originalCDS
end
end
})
_aT:CreateToggle({
Name = "Auto Zone",
_cv = false,
_cb = function(_v)
_rF:Notify({
Title = "Auto Zone",
Content = "Toggled " .. (_v and "Enabled" or "Disabled"),
Duration = 4
})
while _v and _t.wait(2) do
_g.ReplicatedStorage.Packages.Knit.Services.ZoneService.RE.Activate:FireServer()
end
end
})
_aT:CreateToggle({
Name = "Auto Awaken",
_cv = false,
_cb = function(_v)
_rF:Notify({
Title = "Auto Awaken",
Content = "Toggled " .. (_v and "Enabled" or "Disabled"),
Duration = 4
})
while _v and _t.wait(2) do
_g.ReplicatedStorage.Packages.Knit.Services.AwakeningService.RE.Awaken:FireServer()
end
end
})
local _sT = _wD:CreateTab("Spin & Zone", 4483362458)
_sT:CreateSection("Spin Actions")
_sT:CreateButton({
Name = "Spin Style",
_cb = function()
_g.ReplicatedStorage.Packages.Knit.Services.StyleService.RE.Spin:FireServer()
end
})
_sT:CreateButton({
Name = "Spin Zone",
_cb = function()
_g.ReplicatedStorage.Packages.Knit.Services.ZoneService.RE.Spin:FireServer()
end
})
_sT:CreateButton({
Name = "Auto Rejoin",
_cb = function()
_g:GetService("TeleportService"):TeleportToPlaceInstance(
_g.PlaceId,
_g.JobId,
_g.Players.LocalPlayer
)
end
})
local _stT = _wD:CreateTab("FE Style [Need Copycat]", 7734068321)
_stT:CreateSection("Select Style")
local styles = {"Clutch", "Chuck", "Phantom", "Playmaker", "Star", "Sniper", "Flash", "Lock", "Giant", "Ace", "Jackpot", "Copycat"}
for _, style in ipairs(styles) do
_stT:CreateButton({
Name = style,
_cb = function()
_g.Players.LocalPlayer.Style._v = style
end
})
end
local _setT = _wD:CreateTab("Settings", 4483362458)
_setT:CreateSection("Delay Settings")
_setT:CreateInput({
Name = "Auto Steal Delay",
PlaceholderText = "Enter delay in seconds (e.g. 0.5)",
RemoveTextAfterFocusLost = false,
_cb = function(Text)
local num = tonumber(Text)
if num then _dS.Steal = num end
end
})
_setT:CreateInput({
Name = "Auto Dribble Delay",
PlaceholderText = "Enter delay in seconds (e.g. 0.5)",
RemoveTextAfterFocusLost = false,
_cb = function(Text)
local num = tonumber(Text)
if num then _dS.Dribble = num end
end
})
_setT:CreateInput({
Name = "Auto Block Delay",
PlaceholderText = "Enter delay in seconds (e.g. 0.5)",
RemoveTextAfterFocusLost = false,
_cb = function(Text)
local num = tonumber(Text)
if num then _dS.Block = num end
end
})
