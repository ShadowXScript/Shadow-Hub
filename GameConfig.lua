-- Gamelist
getgenv().gamesConfig = {
    {
        gameName = "Anime Fighting Simulator: Endless",
        placeId = 130247632398296,
        ConfigScript = [[ loadstring(game:HttpGet("https://raw.githubusercontent.com/ShadowXScript/Shadow-Hub/refs/heads/main/AFSE/loader.lua"))()]]
    },
    {
        gameName = "Basketball Zero",
        placeId = 0000000000, 
        ConfigScript = [[   ]]
    },
}

--[[LOGO]]--
getgenv().logo = [[
    
    ╔═══════════════════════════════════════════════════════════════════════════╗
    ║                                                                           ║
    ║   ░██████╗██╗░░██╗░█████╗░██████╗░░█████╗░░██╗░░░░░░░██╗                ║
    ║   ██╔════╝██║░░██║██╔══██╗██╔══██╗██╔══██╗░██║░░██╗░░██║                ║
    ║   ╚█████╗░███████║███████║██║░░██║██║░░██║░╚██╗████╗██╔╝                ║
    ║   ░╚═══██╗██╔══██║██╔══██║██║░░██║██║░░██║░░████╔═████║░                ║
    ║   ██████╔╝██║░░██║██║░░██║██████╔╝╚█████╔╝░░╚██╔╝░╚██╔╝░                ║
    ║   ╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═════╝░░╚════╝░░░░╚═╝░░░╚═╝░░                ║
    ║                                                                           ║
    ║   ░██████╗░█████╗░██████╗░██╗██████╗░████████╗                          ║
    ║   ██╔════╝██╔══██╗██╔══██╗██║██╔══██╗╚══██╔══╝                          ║
    ║   ╚█████╗░██║░░╚═╝██████╔╝██║██████╔╝░░░██║░░░                          ║
    ║   ░╚═══██╗██║░░██╗██╔══██╗██║██╔═══╝░░░░██║░░░                          ║
    ║   ██████╔╝╚█████╔╝██║░░██║██║██║░░░░░░░░██║░░░                          ║
    ║   ╚═════╝░░╚════╝░╚═╝░░╚═╝╚═╝╚═╝░░░░░░░░╚═╝░░░                          ║
    ║                                                                           ║
    ╚═══════════════════════════════════════════════════════════════════════════╝
                             Created By Shadow | Shadow Hub 
                         Discord: https://discord.gg/KV8pkjbqPA
    ═══════════════════════════════════════════════════════════════════════════════════
    
]]

--[[GAME CHECK]]--
getgenv().gamechecker = true
getgenv().ScriptName = "Shadow Hub"
getgenv().UniversalScript = [[ loadstring(game:HttpGet("https://raw.githubusercontent.com/ShadowXScript/Shadow-Hub/refs/heads/main/AFSE/admincmds.txt"))() ]]
