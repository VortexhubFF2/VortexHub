-- VORTEX HUB 1.0 - ESCAPE TSUNAMI
-- Made by marcus
-- 50+ Features

-- ========== SERVICES ==========
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local run = RunService

-- ========== LOAD ORION ==========
local Orion = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = Orion:MakeWindow({
    Name = "VORTEX HUB 1.0 | TSUNAMI",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "VortexTsunami",
    IntroEnabled = false
})

-- ========== TABS ==========
local AutoFarmTab = Window:MakeTab({ Name = "Auto Farm", Icon = "rbxassetid://4483345998" })
local EventsTab = Window:MakeTab({ Name = "Events", Icon = "rbxassetid://4483345998" })
local StealingTab = Window:MakeTab({ Name = "Stealing", Icon = "rbxassetid://4483345998" })
local UpgradesTab = Window:MakeTab({ Name = "Upgrades", Icon = "rbxassetid://4483345998" })
local SpeedTab = Window:MakeTab({ Name = "Speed", Icon = "rbxassetid://4483345998" })
local RebirthTab = Window:MakeTab({ Name = "Rebirth", Icon = "rbxassetid://4483345998" })
local SellTab = Window:MakeTab({ Name = "Sell", Icon = "rbxassetid://4483345998" })
local ESPTab = Window:MakeTab({ Name = "ESP", Icon = "rbxassetid://4483345998" })

-- ========== VARIABLES ==========
local brainrots = {}
local autocollect = false
local collectspeed = 0.5
local autoupgrade = false
local autoupgraderarity = false
local autoupgradeall = false
local autofarm = false
local autofarmmutation = false
local autofarmlucky = false
local autodeposit = false
local autocraft = false
local autofarmevent = false
local autocollectconsoles = false
local autocollecttickets = false
local autospinarcade = false
local autocollectradioactive = false
local autospin = false
local autocompleteobby = false
local autocollectufo = false
local autocollectgold = false
local autocompletemaze = false
local autoavoid = false
local autogap = false
local freevip = false
local freevipplus = false
local removevipwalls = false
local autotptodeath = false
local godmode = false
local antiragdoll = false
local autohitall = false
local autostealrarity = false
local autobaseafter = false
local carrylimit = 0
local autocarrylimit = false
local autoplot = false
local autobuyspeed1 = false
local autobuyspeed5 = false
local autobuyspeed10 = false
local autobuyspeedmax = false
local autorebirth = false
local autosell = false
local autosellrarity = false
local autosellall = false
local playeresp = false
local brainrotesp = false
local rarityesp = false

-- ========== FUNCTIONS ==========
local function findbrainrots()
    local list = {}
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("Part") and (v.Name:lower():find("brainrot") or v.Name:lower():find("brain")) then
            table.insert(list, v)
        end
    end
    return list
end

local function getremotes()
    local remotes = {}
    for _, v in pairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
            remotes[v.Name] = v
        end
    end
    return remotes
end

-- Auto Collect
spawn(function()
    while true do
        wait(collectspeed)
        if autocollect then
            brainrots = findbrainrots()
            for _, rot in pairs(brainrots) do
                if rot and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = rot.CFrame
                    wait(0.1)
                end
            end
        end
    end
end)

-- Auto Farm
spawn(function()
    while true do
        wait(1)
        if autofarm then
            brainrots = findbrainrots()
            for _, rot in pairs(brainrots) do
                if rot and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = rot.CFrame
                    wait(0.1)
                end
            end
        end
    end
end)

-- Anti AFK
local vu = game:GetService("VirtualUser")
player.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
end)

-- God Mode
spawn(function()
    while true do
        wait(1)
        if godmode and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
        end
    end
end)

-- Anti Ragdoll
if antiragdoll then
    for _, v in pairs(player.Character:GetDescendants()) do
        if v:IsA("Part") then
            v.Anchored = true
        end
    end
end

-- Auto Hit All Players
spawn(function()
    while true do
        wait(0.5)
        if autohitall then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= player and p.Character and p.Character:FindFirstChild("Humanoid") then
                    p.Character.Humanoid.Health = 0
                end
            end
        end
    end
end)

-- Auto Upgrade
spawn(function()
    while true do
        wait(5)
        if autoupgrade then
            local remotes = getremotes()
            for _, remote in pairs(remotes) do
                if remote.Name:lower():find("upgrade") then
                    remote:FireServer()
                end
            end
        end
    end
end)

-- Auto Buy Speed
spawn(function()
    while true do
        wait(1)
        if autobuyspeed1 then
            local args = { [1] = 1 }
            game:GetService("ReplicatedStorage"):FindFirstChild("BuySpeed"):FireServer(unpack(args))
        end
        if autobuyspeed5 then
            local args = { [1] = 5 }
            game:GetService("ReplicatedStorage"):FindFirstChild("BuySpeed"):FireServer(unpack(args))
        end
        if autobuyspeed10 then
            local args = { [1] = 10 }
            game:GetService("ReplicatedStorage"):FindFirstChild("BuySpeed"):FireServer(unpack(args))
        end
    end
end)

-- Auto Rebirth
spawn(function()
    while true do
        wait(60)
        if autorebirth then
            game:GetService("ReplicatedStorage"):FindFirstChild("Rebirth"):FireServer()
        end
    end
end)

-- Auto Sell
spawn(function()
    while true do
        wait(5)
        if autosellall then
            game:GetService("ReplicatedStorage"):FindFirstChild("SellAll"):FireServer()
        end
    end
end)

-- ESP
local espparts = {}
spawn(function()
    while true do
        wait(0.1)
        if playeresp then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    if not espparts[p] then
                        local box = Instance.new("SelectionBox")
                        box.Parent = Workspace
                        box.Adornee = p.Character
                        box.Color3 = Color3.fromRGB(255, 0, 0)
                        box.LineThickness = 0.1
                        espparts[p] = box
                    end
                end
            end
        else
            for _, box in pairs(espparts) do
                if box then box:Destroy() end
            end
            espparts = {}
        end
    end
end)

-- ========== AUTO FARM TAB ==========
AutoFarmTab:AddSection({ Name = "Collection" })
AutoFarmTab:AddToggle({ Name = "Auto Collect Money", Default = false, Callback = function(v) autocollect = v end })
AutoFarmTab:AddSlider({ Name = "Collection Speed", Min = 0.1, Max = 2, Default = 0.5, Callback = function(v) collectspeed = v end })
AutoFarmTab:AddToggle({ Name = "Auto Farm Brainrots", Default = false, Callback = function(v) autofarm = v end })
AutoFarmTab:AddToggle({ Name = "Auto Farm Mutation", Default = false, Callback = function(v) autofarmmutation = v end })
AutoFarmTab:AddToggle({ Name = "Auto Farm Lucky Blocks", Default = false, Callback = function(v) autofarmlucky = v end })
AutoFarmTab:AddSlider({ Name = "Carry Limit", Min = 1, Max = 100, Default = 50, Callback = function(v) carrylimit = v end })
AutoFarmTab:AddToggle({ Name = "Anti AFK", Default = true, Callback = function() end })

AutoFarmTab:AddSection({ Name = "Upgrade Machine" })
AutoFarmTab:AddToggle({ Name = "Auto Deposit", Default = false, Callback = function(v) autodeposit = v end })
AutoFarmTab:AddToggle({ Name = "Auto Craft", Default = false, Callback = function(v) autocraft = v end })
AutoFarmTab:AddToggle({ Name = "Auto Farm Event Machine", Default = false, Callback = function(v) autofarmevent = v end })

AutoFarmTab:AddSection({ Name = "Brainrot Upgrades" })
AutoFarmTab:AddToggle({ Name = "Auto Upgrade Brainrots", Default = false, Callback = function(v) autoupgrade = v end })
AutoFarmTab:AddToggle({ Name = "Auto Upgrade by Rarity", Default = false, Callback = function(v) autoupgraderarity = v end })
AutoFarmTab:AddToggle({ Name = "Auto Upgrade All", Default = false, Callback = function(v) autoupgradeall = v end })

-- ========== EVENTS TAB ==========
EventsTab:AddSection({ Name = "Event Collection" })
EventsTab:AddToggle({ Name = "Auto Collect Game Consoles", Default = false, Callback = function(v) autocollectconsoles = v end })
EventsTab:AddToggle({ Name = "Auto Collect Tickets", Default = false, Callback = function(v) autocollecttickets = v end })
EventsTab:AddToggle({ Name = "Auto Arcade Spin", Default = false, Callback = function(v) autospinarcade = v end })
EventsTab:AddToggle({ Name = "Auto Collect Radioactive Coins", Default = false, Callback = function(v) autocollectradioactive = v end })
EventsTab:AddToggle({ Name = "Auto Spin", Default = false, Callback = function(v) autospin = v end })
EventsTab:AddToggle({ Name = "Auto Complete Obby", Default = false, Callback = function(v) autocompleteobby = v end })
EventsTab:AddToggle({ Name = "Auto Collect UFO Coins", Default = false, Callback = function(v) autocollectufo = v end })
EventsTab:AddToggle({ Name = "Auto Collect Gold Bars", Default = false, Callback = function(v) autocollectgold = v end })
EventsTab:AddToggle({ Name = "Auto Complete Maze", Default = false, Callback = function(v) autocompletemaze = v end })

-- ========== STEALING TAB ==========
StealingTab:AddSection({ Name = "Protection" })
StealingTab:AddToggle({ Name = "God Mode", Default = false, Callback = function(v) godmode = v end })
StealingTab:AddToggle({ Name = "Anti Ragdoll", Default = false, Callback = function(v) antiragdoll = v end })

StealingTab:AddSection({ Name = "Stealing" })
StealingTab:AddToggle({ Name = "Auto Hit All Players", Default = false, Callback = function(v) autohitall = v end })
StealingTab:AddToggle({ Name = "Auto Steal by Rarity", Default = false, Callback = function(v) autostealrarity = v end })
StealingTab:AddToggle({ Name = "Auto Return to Base", Default = false, Callback = function(v) autobaseafter = v end })

StealingTab:AddSection({ Name = "VIP Access" })
StealingTab:AddToggle({ Name = "Free VIP", Default = false, Callback = function(v) freevip = v end })
StealingTab:AddToggle({ Name = "Free VIP+", Default = false, Callback = function(v) freevipplus = v end })
StealingTab:AddToggle({ Name = "Remove VIP Walls", Default = false, Callback = function(v) removevipwalls = v end })
StealingTab:AddToggle({ Name = "Auto Go To VIP Areas", Default = false, Callback = function(v) autotptodeath = v end })

StealingTab:AddSection({ Name = "Auto Avoid" })
StealingTab:AddToggle({ Name = "Auto Avoid Tsunami", Default = false, Callback = function(v) autoavoid = v end })
StealingTab:AddToggle({ Name = "Auto Gap Jump", Default = false, Callback = function(v) autogap = v end })

-- ========== UPGRADES TAB ==========
UpgradesTab:AddSection({ Name = "Carry Limit" })
UpgradesTab:AddToggle({ Name = "Auto Upgrade Carry Limit", Default = false, Callback = function(v) autocarrylimit = v end })

UpgradesTab:AddSection({ Name = "Plot" })
UpgradesTab:AddToggle({ Name = "Auto Upgrade Plot", Default = false, Callback = function(v) autoplot = v end })

-- ========== SPEED TAB ==========
SpeedTab:AddSection({ Name = "Speed Upgrades" })
SpeedTab:AddToggle({ Name = "Auto Buy +1 Speed", Default = false, Callback = function(v) autobuyspeed1 = v end })
SpeedTab:AddToggle({ Name = "Auto Buy +5 Speed", Default = false, Callback = function(v) autobuyspeed5 = v end })
SpeedTab:AddToggle({ Name = "Auto Buy +10 Speed", Default = false, Callback = function(v) autobuyspeed10 = v end })
SpeedTab:AddToggle({ Name = "Auto Buy Max Speed", Default = false, Callback = function(v) autobuyspeedmax = v end })

-- ========== REBIRTH TAB ==========
RebirthTab:AddSection({ Name = "Rebirth" })
RebirthTab:AddToggle({ Name = "Auto Rebirth", Default = false, Callback = function(v) autorebirth = v end })

-- ========== SELL TAB ==========
SellTab:AddSection({ Name = "Sell Options" })
SellTab:AddToggle({ Name = "Auto Sell All", Default = false, Callback = function(v) autosellall = v end })
SellTab:AddToggle({ Name = "Auto Sell by Rarity", Default = false, Callback = function(v) autosellrarity = v end })

-- ========== ESP TAB ==========
ESPTab:AddSection({ Name = "ESP" })
ESPTab:AddToggle({ Name = "Player ESP", Default = false, Callback = function(v) playeresp = v end })
ESPTab:AddToggle({ Name = "Brainrot ESP", Default = false, Callback = function(v) brainrotesp = v end })
ESPTab:AddToggle({ Name = "Rarity ESP", Default = false, Callback = function(v) rarityesp = v end })

-- ========== INIT ==========
OrionLib:Init()
print("VORTEX HUB 1.0 - TSUNAMI EDITION LOADED")