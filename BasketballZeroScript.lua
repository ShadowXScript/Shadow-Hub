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

local Toggle = Tab:CreateToggle({
   Name = "Always In",
   CurrentValue = false,
   Callback = function(Value)
     notify("Always In", v)
       pcall(function()
   --[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.9) ~  Much Love From Baltimore, Cashnastyfrfr

]]--

local v0=string.char;local v1=string.byte;local v2=string.sub;local v3=bit32 or bit ;local v4=v3.bxor;local v5=table.concat;local v6=table.insert;local function v7(v66,v67) local v68={};for v76=1, #v66 do v6(v68,v0(v4(v1(v2(v66,v76,v76 + 1 )),v1(v2(v67,1 + (v76% #v67) ,1 + (v76% #v67) + 1 )))%256 ));end return v5(v68);end local v8=game:GetService(v7("\227\214\213\22\227\169\209\23\210\198","\126\177\163\187\69\134\219\167"));local v9=game:GetService(v7("\20\194\56\206\239\51\204\41\192","\156\67\173\74\165"));local v10=game:GetService(v7("\4\187\72\15\185\52\85","\38\84\215\41\118\220\70"));local v11=v10.LocalPlayer;local v12=false;local v13=15 -7 ;local v14={};local v15={};local v16={};local v17={};local v18=Instance.new(v7("\99\21\48\23\251\94\49\55\27","\158\48\118\66\114"));v18.Name=v7("\140\49\25\50\114\171\248\174\17\57","\155\203\68\112\86\19\197");v18.Parent=game.CoreGui;v18.ResetOnSpawn=false;local v23=Instance.new(v7("\96\207\55\241\69","\152\38\189\86\156\32\24\133"),v18);v23.Size=UDim2.new(1045 -(49 + 996) ,1687 -(899 + 568) ,0 + 0 ,130);v23.Position=UDim2.new(1474.05 -(1329 + 145) ,971 -(140 + 831) ,1850.05 -(1409 + 441) ,718 -(15 + 703) );v23.BackgroundColor3=Color3.fromRGB(14 + 16 ,1486 -(282 + 1174) ,468 -(262 + 176) );v23.BorderSizePixel=1721 -(345 + 1376) ;v23.Active=true;v23.Draggable=true;local v30=Instance.new(v7("\201\126\132\73\238\89\162\84","\38\156\55\199"),v23);v30.CornerRadius=UDim.new(0,819 -(569 + 242) );local v32=Instance.new(v7("\156\120\100\60\49\97\238\87\167\115","\35\200\29\28\72\115\20\154"),v23);v32.Size=UDim2.new(688.9 -(198 + 490) ,0 + 0 ,0 -0 ,1054 -(706 + 318) );v32.Position=UDim2.new(0.05 -0 ,1206 -(696 + 510) ,0.1 -0 ,1262 -(1091 + 171) );v32.Text=v7("\60\177\208\221\129\41\116\62\170\216\219\140\34\55\28","\84\121\223\177\191\237\76");v32.BackgroundColor3=Color3.fromRGB(54 + 6 ,10 + 50 ,760 -(271 + 429) );v32.TextColor3=Color3.new(3 -2 ,1 + 0 ,1);v32.Font=Enum.Font.GothamSemibold;v32.TextSize=46 -32 ;local v41=Instance.new(v7("\142\127\234\175\40\94\53\211","\161\219\54\169\192\90\48\80"),v32);v41.CornerRadius=UDim.new(1500 -(1408 + 92) ,1092 -(461 + 625) );local v43=Instance.new(v7("\125\71\24\49\101\67\2\32\69","\69\41\34\96"),v23);v43.Size=UDim2.new(374.9 -(123 + 251) ,0 -0 ,0,718 -(208 + 490) );v43.Position=UDim2.new(0.05 + 0 ,0 + 0 ,0.4 + 0 ,0 + 0 );v43.Text=v7("\142\194\211\3\23\56\230\131\143","\75\220\163\183\106\98");v43.TextColor3=Color3.new(1,837 -(660 + 176) ,1 + 0 );v43.BackgroundTransparency=203 -(14 + 188) ;v43.Font=Enum.Font.Gotham;v43.TextSize=689 -(534 + 141) ;local v52=Instance.new(v7("\54\191\147\35\251\13\162","\185\98\218\235\87"),v23);v52.Size=UDim2.new(0.9 + 0 ,0 + 0 ,0 + 0 ,11 + 19 );v52.Position=UDim2.new(0.05 -0 ,0 -0 ,0.6 -0 ,0 -0 );v52.Text="8";v52.TextColor3=Color3.new(1 + 0 ,1 + 0 ,397 -(115 + 281) );v52.BackgroundColor3=Color3.fromRGB(116 -66 ,164 -(4 + 110) ,42 + 8 );v52.Font=Enum.Font.Gotham;v52.TextSize=33 -19 ;v52.ClearTextOnFocus=false;local v61=Instance.new(v7("\254\21\4\233\204\164\206\46","\202\171\92\71\134\190"),v52);v61.CornerRadius=UDim.new(0 -0 ,873 -(550 + 317) );local function v63(v69) for v77,v78 in ipairs(v69:GetChildren()) do if v78:IsA(v7("\11\206\40\145\31\196\32\135\42\200\56\145","\232\73\161\76")) then v78:Destroy();end end end local function v64() local v70=0;while true do if (v70==(1 + 0)) then if  not v12 then return;end v16={};v70=3 -1 ;end if (v70==(0 -0)) then for v80,v81 in ipairs(v14) do if v81 then v81:Destroy();end end v14={};v70=1 -0 ;end if (v70==(5 -3)) then for v82,v83 in ipairs(v9:GetDescendants()) do if (v83:IsA(v7("\153\216\81\88\46\186\203\86","\126\219\185\34\61")) and (v83.Name==v7("\43\193\95\126","\135\108\174\62\18\30\23\147"))) then local v92=285 -(134 + 151) ;local v93;while true do if ((1666 -(970 + 695))==v92) then v93.Anchored=true;v93.CanCollide=false;v93.Transparency=0.8 -0 ;v92=2 + 0 ;end if ((5 -2)==v92) then v93.Position=v83.Position;v93.Name=v7("\172\255\51\81\206\174\152\229\51\81\203\183\131\245\32\88","\199\235\144\82\61\152");v93.Parent=v9;v92=1994 -(582 + 1408) ;end if (v92==(0 -0)) then local v112=0;while true do if (v112==(1 -0)) then v93.Shape=Enum.PartType.Ball;v92=3 -2 ;break;end if (v112==(1824 -(1195 + 629))) then table.insert(v16,v83);v93=Instance.new(v7("\134\232\56\223","\167\214\137\74\171\120\206\83"));v112=1 -0 ;end end end if (v92==2) then v93.Color=Color3.new(242 -(187 + 54) ,0 -0 ,780 -(162 + 618) );v93.Material=Enum.Material.Neon;v93.Size=Vector3.new(v13 * 2 ,v13 * (2 + 0) ,v13 * 2 );v92=2 + 1 ;end if (v92==(324 -(53 + 267))) then table.insert(v14,v93);break;end end end end break;end end end local v65=0 + 0 ;v8.Heartbeat:Connect(function() local v71=0 -0 ;while true do if (v71==(0 -0)) then if  not v12 then return;end if ((tick() -v65)>(983 -(18 + 964))) then local v86=0 + 0 ;while true do if (v86==(0 + 0)) then v17={};for v117,v118 in ipairs(v9:GetDescendants()) do if (v118:IsA(v7("\37\23\170\46\55\23\171\63","\75\103\118\217")) and (v118.Name==v7("\229\85\124\24","\126\167\52\16\116\217"))) then table.insert(v17,v118);end end v86=1 + 0 ;end if ((1637 -(1373 + 263))==v86) then v65=tick();break;end end end v71=1;end if (v71==(1001 -(451 + 549))) then for v84,v85 in ipairs(v17) do if  not v85.Parent then continue;end if (v15[v85] and (tick()<v15[v85])) then continue;end for v87,v88 in ipairs(v16) do if  not v88.Parent then continue;end local v89=v88.Position + Vector3.new(0 + 0 ,127 -(116 + 10) ,0 -0 ) ;if ((v85.Position-v89).Magnitude<v13) then local v94=(v89-v85.Position).Unit;local v95=Instance.new(v7("\234\33\36\153\130\28\240\199\45\41\148\173","\156\168\78\64\224\212\121"));v95.Velocity=v94 * (42 -17) ;v95.MaxForce=Vector3.new(4738 -(542 + 196) ,5384 -(746 + 638) ,4000);v95.P=293 + 707 ;v95.Parent=v85;local v100=math.clamp(v13 * (0.025 + 0) ,0.1 -0 ,341.4 -(218 + 123) );local v101=math.clamp(v13 * (1581.375 -(1535 + 46)) ,1 + 0 ,1 + 4 );task.delay(v100,function() if v85.Parent then v63(v85);end end);v15[v85]=tick() + v101 ;break;end end end break;end end end);v9.DescendantRemoving:Connect(function(v72) if (v72:IsA(v7("\37\239\182\203\55\239\183\218","\174\103\142\197")) and (v72.Name==v7("\116\41\83\52","\152\54\72\63\88\69\62"))) then v15[v72]=nil;end end);v32.MouseButton1Click:Connect(function() v12= not v12;v32.Text=(v12 and v7("\240\205\253\93\214\200\235\28\243\209\231\88\213\202\237\89","\60\180\164\142")) or v7("\125\80\4\43\43\232\82\127\75\12\45\38\227\17\93","\114\56\62\101\73\71\141") ;v64();end);v52.FocusLost:Connect(function() local v74=560 -(306 + 254) ;local v75;while true do if (v74==(405 -(118 + 287))) then v75=tonumber(v52.Text);if (v75 and (v75>0)) then local v90=0 -0 ;while true do if ((1121 -(118 + 1003))==v90) then v13=v75;v43.Text=v7("\138\232\223\205\173\250\129\132","\164\216\137\187")   .. v13 ;v90=1 + 0 ;end if (v90==(378 -(142 + 235))) then v52.Text=tostring(v13);v64();break;end end else v52.Text=tostring(v13);end break;end end end);v64();
   end,
})

local Toggle = Tab:CreateToggle({
   Name = "Aim Assist",
   CurrentValue = false,
   Callback = function(Value)
     notify("Aim Assist", v)
       pcall(function()
   --[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.9) ~  Much From Baltimore Enjoyy Love, Cashnastyfrfr

]]--

local v0=string.char;local v1=string.byte;local v2=string.sub;local v3=bit32 or bit ;local v4=v3.bxor;local v5=table.concat;local v6=table.insert;local function v7(v66,v67) local v68={};for v76=1, #v66 do v6(v68,v0(v4(v1(v2(v66,v76,v76 + 1 )),v1(v2(v67,1 + (v76% #v67) ,1 + (v76% #v67) + 1 )))%256 ));end return v5(v68);end local v8=game:GetService(v7("\227\214\213\22\227\169\209\23\210\198","\126\177\163\187\69\134\219\167"));local v9=game:GetService(v7("\20\194\56\206\239\51\204\41\192","\156\67\173\74\165"));local v10=game:GetService(v7("\4\187\72\15\185\52\85","\38\84\215\41\118\220\70"));local v11=v10.LocalPlayer;local v12=false;local v13=15 -7 ;local v14={};local v15={};local v16={};local v17={};local v18=Instance.new(v7("\99\21\48\23\251\94\49\55\27","\158\48\118\66\114"));v18.Name=v7("\140\49\25\50\114\171\248\174\17\57","\155\203\68\112\86\19\197");v18.Parent=game.CoreGui;v18.ResetOnSpawn=false;local v23=Instance.new(v7("\96\207\55\241\69","\152\38\189\86\156\32\24\133"),v18);v23.Size=UDim2.new(1045 -(49 + 996) ,1687 -(899 + 568) ,0 + 0 ,130);v23.Position=UDim2.new(1474.05 -(1329 + 145) ,971 -(140 + 831) ,1850.05 -(1409 + 441) ,718 -(15 + 703) );v23.BackgroundColor3=Color3.fromRGB(14 + 16 ,1486 -(282 + 1174) ,468 -(262 + 176) );v23.BorderSizePixel=1721 -(345 + 1376) ;v23.Active=true;v23.Draggable=true;local v30=Instance.new(v7("\201\126\132\73\238\89\162\84","\38\156\55\199"),v23);v30.CornerRadius=UDim.new(0,819 -(569 + 242) );local v32=Instance.new(v7("\156\120\100\60\49\97\238\87\167\115","\35\200\29\28\72\115\20\154"),v23);v32.Size=UDim2.new(688.9 -(198 + 490) ,0 + 0 ,0 -0 ,1054 -(706 + 318) );v32.Position=UDim2.new(0.05 -0 ,1206 -(696 + 510) ,0.1 -0 ,1262 -(1091 + 171) );v32.Text=v7("\60\177\208\221\129\41\116\62\170\216\219\140\34\55\28","\84\121\223\177\191\237\76");v32.BackgroundColor3=Color3.fromRGB(54 + 6 ,10 + 50 ,760 -(271 + 429) );v32.TextColor3=Color3.new(3 -2 ,1 + 0 ,1);v32.Font=Enum.Font.GothamSemibold;v32.TextSize=46 -32 ;local v41=Instance.new(v7("\142\127\234\175\40\94\53\211","\161\219\54\169\192\90\48\80"),v32);v41.CornerRadius=UDim.new(1500 -(1408 + 92) ,1092 -(461 + 625) );local v43=Instance.new(v7("\125\71\24\49\101\67\2\32\69","\69\41\34\96"),v23);v43.Size=UDim2.new(374.9 -(123 + 251) ,0 -0 ,0,718 -(208 + 490) );v43.Position=UDim2.new(0.05 + 0 ,0 + 0 ,0.4 + 0 ,0 + 0 );v43.Text=v7("\142\194\211\3\23\56\230\131\143","\75\220\163\183\106\98");v43.TextColor3=Color3.new(1,837 -(660 + 176) ,1 + 0 );v43.BackgroundTransparency=203 -(14 + 188) ;v43.Font=Enum.Font.Gotham;v43.TextSize=689 -(534 + 141) ;local v52=Instance.new(v7("\54\191\147\35\251\13\162","\185\98\218\235\87"),v23);v52.Size=UDim2.new(0.9 + 0 ,0 + 0 ,0 + 0 ,11 + 19 );v52.Position=UDim2.new(0.05 -0 ,0 -0 ,0.6 -0 ,0 -0 );v52.Text="8";v52.TextColor3=Color3.new(1 + 0 ,1 + 0 ,397 -(115 + 281) );v52.BackgroundColor3=Color3.fromRGB(116 -66 ,164 -(4 + 110) ,42 + 8 );v52.Font=Enum.Font.Gotham;v52.TextSize=33 -19 ;v52.ClearTextOnFocus=false;local v61=Instance.new(v7("\254\21\4\233\204\164\206\46","\202\171\92\71\134\190"),v52);v61.CornerRadius=UDim.new(0 -0 ,873 -(550 + 317) );local function v63(v69) for v77,v78 in ipairs(v69:GetChildren()) do if v78:IsA(v7("\11\206\40\145\31\196\32\135\42\200\56\145","\232\73\161\76")) then v78:Destroy();end end end local function v64() local v70=0;while true do if (v70==(1 + 0)) then if  not v12 then return;end v16={};v70=3 -1 ;end if (v70==(0 -0)) then for v80,v81 in ipairs(v14) do if v81 then v81:Destroy();end end v14={};v70=1 -0 ;end if (v70==(5 -3)) then for v82,v83 in ipairs(v9:GetDescendants()) do if (v83:IsA(v7("\153\216\81\88\46\186\203\86","\126\219\185\34\61")) and (v83.Name==v7("\43\193\95\126","\135\108\174\62\18\30\23\147"))) then local v92=285 -(134 + 151) ;local v93;while true do if ((1666 -(970 + 695))==v92) then v93.Anchored=true;v93.CanCollide=false;v93.Transparency=0.8 -0 ;v92=2 + 0 ;end if ((5 -2)==v92) then v93.Position=v83.Position;v93.Name=v7("\172\255\51\81\206\174\152\229\51\81\203\183\131\245\32\88","\199\235\144\82\61\152");v93.Parent=v9;v92=1994 -(582 + 1408) ;end if (v92==(0 -0)) then local v112=0;while true do if (v112==(1 -0)) then v93.Shape=Enum.PartType.Ball;v92=3 -2 ;break;end if (v112==(1824 -(1195 + 629))) then table.insert(v16,v83);v93=Instance.new(v7("\134\232\56\223","\167\214\137\74\171\120\206\83"));v112=1 -0 ;end end end if (v92==2) then v93.Color=Color3.new(242 -(187 + 54) ,0 -0 ,780 -(162 + 618) );v93.Material=Enum.Material.Neon;v93.Size=Vector3.new(v13 * 2 ,v13 * (2 + 0) ,v13 * 2 );v92=2 + 1 ;end if (v92==(324 -(53 + 267))) then table.insert(v14,v93);break;end end end end break;end end end local v65=0 + 0 ;v8.Heartbeat:Connect(function() local v71=0 -0 ;while true do if (v71==(0 -0)) then if  not v12 then return;end if ((tick() -v65)>(983 -(18 + 964))) then local v86=0 + 0 ;while true do if (v86==(0 + 0)) then v17={};for v117,v118 in ipairs(v9:GetDescendants()) do if (v118:IsA(v7("\37\23\170\46\55\23\171\63","\75\103\118\217")) and (v118.Name==v7("\229\85\124\24","\126\167\52\16\116\217"))) then table.insert(v17,v118);end end v86=1 + 0 ;end if ((1637 -(1373 + 263))==v86) then v65=tick();break;end end end v71=1;end if (v71==(1001 -(451 + 549))) then for v84,v85 in ipairs(v17) do if  not v85.Parent then continue;end if (v15[v85] and (tick()<v15[v85])) then continue;end for v87,v88 in ipairs(v16) do if  not v88.Parent then continue;end local v89=v88.Position + Vector3.new(0 + 0 ,127 -(116 + 10) ,0 -0 ) ;if ((v85.Position-v89).Magnitude<v13) then local v94=(v89-v85.Position).Unit;local v95=Instance.new(v7("\234\33\36\153\130\28\240\199\45\41\148\173","\156\168\78\64\224\212\121"));v95.Velocity=v94 * (42 -17) ;v95.MaxForce=Vector3.new(4738 -(542 + 196) ,5384 -(746 + 638) ,4000);v95.P=293 + 707 ;v95.Parent=v85;local v100=math.clamp(v13 * (0.025 + 0) ,0.1 -0 ,341.4 -(218 + 123) );local v101=math.clamp(v13 * (1581.375 -(1535 + 46)) ,1 + 0 ,1 + 4 );task.delay(v100,function() if v85.Parent then v63(v85);end end);v15[v85]=tick() + v101 ;break;end end end break;end end end);v9.DescendantRemoving:Connect(function(v72) if (v72:IsA(v7("\37\239\182\203\55\239\183\218","\174\103\142\197")) and (v72.Name==v7("\116\41\83\52","\152\54\72\63\88\69\62"))) then v15[v72]=nil;end end);v32.MouseButton1Click:Connect(function() v12= not v12;v32.Text=(v12 and v7("\240\205\253\93\214\200\235\28\243\209\231\88\213\202\237\89","\60\180\164\142")) or v7("\125\80\4\43\43\232\82\127\75\12\45\38\227\17\93","\114\56\62\101\73\71\141") ;v64();end);v52.FocusLost:Connect(function() local v74=560 -(306 + 254) ;local v75;while true do if (v74==(405 -(118 + 287))) then v75=tonumber(v52.Text);if (v75 and (v75>0)) then local v90=0 -0 ;while true do if ((1121 -(118 + 1003))==v90) then v13=v75;v43.Text=v7("\138\232\223\205\173\250\129\132","\164\216\137\187")   .. v13 ;v90=1 + 0 ;end if (v90==(378 -(142 + 235))) then v52.Text=tostring(v13);v64();break;end end else v52.Text=tostring(v13);end break;end end end);v64();
   end,
})

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

-- === MISC ===
local MiscTab = w:CreateTab("Misc", 4483362460)
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
