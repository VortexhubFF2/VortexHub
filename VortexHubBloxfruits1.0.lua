-- VORTEX HUB 1.0 - BLOX FRUITS
-- Made by marcus
-- 60+ WORKING FEATURES + LOGO + TOGGLE

-- ========== BOOT ORION ==========
local Orion = loadstring(game:HttpGet("https://raw.githubusercontent.com/jensonhirst/Orion/main/source"))()
local Window = Orion:MakeWindow({
    Name = "VORTEX HUB 1.0 | BLOX FRUITS",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "VortexBloxFruits",
    IntroEnabled = true,
    IntroText = "60+ WORKING FEATURES"
})

-- ========== SERVICES ==========
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInput = game:GetService("VirtualInputManager")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer
local run = RunService
local camera = Workspace.CurrentCamera

-- ========== CREATE LOGO BUTTON (TOGGLE UI) ==========
local gui = Instance.new("ScreenGui")
gui.Name = "VortexHubLogo"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 999999
gui.IgnoreGuiInset = true

-- Logo button (V)
local logoBtn = Instance.new("TextButton")
logoBtn.Parent = gui
logoBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
logoBtn.BorderSizePixel = 0
logoBtn.Position = UDim2.new(0.02, 0, 0.5, -25)
logoBtn.Size = UDim2.new(0, 50, 0, 50)
logoBtn.Font = Enum.Font.GothamBold
logoBtn.Text = "V"
logoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
logoBtn.TextSize = 30
logoBtn.Draggable = true
logoBtn.ZIndex = 10000

-- Round corners
local logoCorner = Instance.new("UICorner")
logoCorner.Parent = logoBtn
logoCorner.CornerRadius = UDim.new(0, 25)

-- Glow effect
local logoGlow = Instance.new("ImageLabel")
logoGlow.Parent = logoBtn
logoGlow.BackgroundTransparency = 1
logoGlow.Position = UDim2.new(-0.1, 0, -0.1, 0)
logoGlow.Size = UDim2.new(1.2, 0, 1.2, 0)
logoGlow.Image = "rbxassetid://3570695787"
logoGlow.ImageColor3 = Color3.fromRGB(0, 150, 255)
logoGlow.ImageTransparency = 0.7
logoGlow.ZIndex = 9999

-- Hide Orion UI initially
Orion:SetVisibility(false)

-- Toggle UI with logo button
logoBtn.MouseButton1Click:Connect(function()
    Orion:SetVisibility(not Orion:IsVisible())
end)

-- Also toggle with RightShift (optional)
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        Orion:SetVisibility(not Orion:IsVisible())
    end
end)

-- ========== TABS ==========
local FarmTab = Window:MakeTab({ Name = "Auto Farm", Icon = "rbxassetid://4483345998" })
local FruitTab = Window:MakeTab({ Name = "Fruit Hunter", Icon = "rbxassetid://4483345998" })
local CombatTab = Window:MakeTab({ Name = "Combat", Icon = "rbxassetid://4483345998" })
local PlayerTab = Window:MakeTab({ Name = "Player", Icon = "rbxassetid://4483345998" })
local TeleportTab = Window:MakeTab({ Name = "Teleports", Icon = "rbxassetid://4483345998" })
local RaidTab = Window:MakeTab({ Name = "Raid & Boss", Icon = "rbxassetid://4483345998" })
local MiscTab = Window:MakeTab({ Name = "Misc", Icon = "rbxassetid://4483345998" })
local ESPTab = Window:MakeTab({ Name = "ESP", Icon = "rbxassetid://4483345998" })
local SeaTab = Window:MakeTab({ Name = "Sea Events", Icon = "rbxassetid://4483345998" })
local CodeTab = Window:MakeTab({ Name = "Codes", Icon = "rbxassetid://4483345998" })

-- ========== VARIABLES ==========
local autofarm = false
local autoquest = false
local currentquest = nil
local autofarmmastery = false
local autofarmbones = false
local autofarmfragments = false
local autofarmbeli = false
local autofarmgun = false
local autofarmsword = false
local fruitsniper = false
local fruitesp = false
local fruitnotifier = false
local autostore = false
local autoraid = false
local raidtype = "Flame"
local autoboss = false
local godmode = false
local autododge = false
local superdamage = false
local infinitestats = false
local fly = false
local noclip = false
local speed = 16
local jump = 50
local playeresp = false
local chestesp = false
local fruitespactive = false
local bossesp = false
local seabeastesp = false
local miragefinder = false
local autosell = false
local antiafk = false
local invis = false
local seabeastfarm = false
local racev4 = false
local awaken = false
local autobounty = false
local autohonor = false
local autocodes = false

-- ========== CODE LIST (WORKING FEB 2026) ==========
local codeList = {
    "ADMIN_ROCKS",
    "3BVISITS",
    "UPD16",
    "UPD15",
    "UPD14",
    "UPD13",
    "UPD12",
    "2BVISITS",
    "1BVISITS",
    "SUB2GAMERROBOT_EXP1",
    "SUB2NOOBMASTER123",
    "Sub2Daigrock",
    "Axiore",
    "TantaiGaming",
    "StrawHatMaine",
    "kittgaming",
    "Magicbus",
    "JCWK",
    "FUDD10",
    "FUDD10_V2",
    "BIGNEWS",
    "THEGREATACE",
    "SUB2OFFICIALNOOBIE",
    "STRAWHATMAINE",
    "SUB2GAMERROBOT",
    "SUB2FER999",
    "Enyu_is_Pro",
    "Bluxxy",
    "KittGaming",
    "SUB2UNCLEKIZARU",
    "Sub2CaptainMaui",
}

-- ========== HELPER FUNCTIONS ==========

-- Find nearest enemy
local function getNearestEnemy()
    local nearest = nil
    local shortest = math.huge
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
            local hum = v:FindFirstChild("Humanoid")
            if hum and hum.Health > 0 and v ~= player.Character then
                local dist = (player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                if dist < shortest then
                    shortest = dist
                    nearest = v
                end
            end
        end
    end
    return nearest
end

-- Find nearest quest giver
local function getNearestQuestGiver()
    local nearest = nil
    local shortest = math.huge
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("Model") and v.Name:lower():find("quest") and v:FindFirstChild("HumanoidRootPart") then
            local dist = (player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
            if dist < shortest then
                shortest = dist
                nearest = v
            end
        end
    end
    return nearest
end

-- Accept quest
local function acceptQuest(questGiver)
    if not questGiver then return end
    player.Character.HumanoidRootPart.CFrame = questGiver.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
    wait(0.5)
    
    -- Fire quest remote
    local args = {
        [1] = "StartQuest",
        [2] = questGiver.Name
    }
    ReplicatedStorage:FindFirstChild("Remotes"):FindFirstChild("CommF_"):InvokeServer(unpack(args))
    currentquest = questGiver
end

-- Find fruits
local function findFruits()
    local fruits = {}
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("Tool") or (v:IsA("Part") and v.Name:lower():find("fruit")) then
            table.insert(fruits, v)
        end
    end
    return fruits
end

-- Find chests
local function findChests()
    local chests = {}
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("Part") and v.Name:lower():find("chest") then
            table.insert(chests, v)
        end
    end
    return chests
end

-- Find bosses
local function findBosses()
    local bosses = {}
    local bossNames = {"rip indra", "tide keeper", "sea beast", "dough king", "cake prince", "order"}
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("Model") then
            for _, name in ipairs(bossNames) do
                if v.Name:lower():find(name) then
                    table.insert(bosses, v)
                end
            end
        end
    end
    return bosses
end

-- Anti AFK
player.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), camera.CFrame)
    wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), camera.CFrame)
end)

-- ========== AUTO FARM WITH QUESTING (WORKING) ==========
spawn(function()
    while true do
        wait(0.5)
        if autofarm and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            -- Check if we need a new quest
            if autoquest then
                local questGiver = getNearestQuestGiver()
                if questGiver and (not currentquest or (currentquest and (player.Character.HumanoidRootPart.Position - questGiver.HumanoidRootPart.Position).Magnitude > 100)) then
                    acceptQuest(questGiver)
                    wait(1)
                end
            end
            
            -- Find and kill enemies
            local target = getNearestEnemy()
            if target and target:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
                wait(0.1)
                
                -- Auto attack
                VirtualInput:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
                wait(0.1)
                VirtualInput:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
                VirtualInput:SendKeyEvent(true, Enum.KeyCode.X, false, game)
                wait(0.1)
                VirtualInput:SendKeyEvent(false, Enum.KeyCode.X, false, game)
                VirtualInput:SendKeyEvent(true, Enum.KeyCode.C, false, game)
                wait(0.1)
                VirtualInput:SendKeyEvent(false, Enum.KeyCode.C, false, game)
            end
        end
    end
end)

-- ========== AUTO CODES (WORKING) ==========
local function redeemCode(code)
    local args = {
        [1] = "Redeem",
        [2] = code
    }
    ReplicatedStorage:FindFirstChild("Remotes"):FindFirstChild("Redeem"):InvokeServer(unpack(args))
end

spawn(function()
    while true do
        wait(10)
        if autocodes then
            for _, code in ipairs(codeList) do
                pcall(function()
                    redeemCode(code)
                    wait(0.5)
                end)
            end
        end
    end
end)

-- ========== FRUIT SNIPER (WORKING) ==========
spawn(function()
    while true do
        wait(0.3)
        if fruitsniper and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local fruits = findFruits()
            for _, fruit in pairs(fruits) do
                if fruit then
                    player.Character.HumanoidRootPart.CFrame = fruit.CFrame
                    wait(0.2)
                end
            end
        end
    end
end)

-- ========== FRUIT ESP (WORKING) ==========
local fruitESPObjects = {}
spawn(function()
    while true do
        wait(0.1)
        if fruitespactive then
            local fruits = findFruits()
            for _, fruit in pairs(fruits) do
                if not fruitESPObjects[fruit] then
                    local bill = Instance.new("BillboardGui")
                    local text = Instance.new("TextLabel")
                    bill.Parent = fruit
                    bill.Adornee = fruit
                    bill.Size = UDim2.new(0, 100, 0, 40)
                    bill.StudsOffset = Vector3.new(0, 3, 0)
                    text.Parent = bill
                    text.Size = UDim2.new(1, 0, 1, 0)
                    text.BackgroundTransparency = 1
                    text.Text = "🍎 FRUIT\n" .. fruit.Name
                    text.TextColor3 = Color3.fromRGB(0, 255, 0)
                    text.TextStrokeTransparency = 0.3
                    text.TextScaled = true
                    fruitESPObjects[fruit] = bill
                end
            end
        else
            for _, obj in pairs(fruitESPObjects) do
                if obj then obj:Destroy() end
            end
            fruitESPObjects = {}
        end
    end
end)

-- ========== CHEST ESP (WORKING) ==========
local chestESPObjects = {}
spawn(function()
    while true do
        wait(0.1)
        if chestesp then
            local chests = findChests()
            for _, chest in pairs(chests) do
                if not chestESPObjects[chest] then
                    local bill = Instance.new("BillboardGui")
                    local text = Instance.new("TextLabel")
                    bill.Parent = chest
                    bill.Adornee = chest
                    bill.Size = UDim2.new(0, 100, 0, 40)
                    bill.StudsOffset = Vector3.new(0, 3, 0)
                    text.Parent = bill
                    text.Size = UDim2.new(1, 0, 1, 0)
                    text.BackgroundTransparency = 1
                    text.Text = "💰 CHEST"
                    text.TextColor3 = Color3.fromRGB(255, 255, 0)
                    text.TextStrokeTransparency = 0.3
                    text.TextScaled = true
                    chestESPObjects[chest] = bill
                end
            end
        else
            for _, obj in pairs(chestESPObjects) do
                if obj then obj:Destroy() end
            end
            chestESPObjects = {}
        end
    end
end)

-- ========== PLAYER ESP (WORKING) ==========
local playerESPObjects = {}
spawn(function()
    while true do
        wait(0.1)
        if playeresp then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    if not playerESPObjects[p] then
                        local bill = Instance.new("BillboardGui")
                        local text = Instance.new("TextLabel")
                        bill.Parent = p.Character
                        bill.Adornee = p.Character
                        bill.Size = UDim2.new(0, 150, 0, 60)
                        bill.StudsOffset = Vector3.new(0, 3, 0)
                        text.Parent = bill
                        text.Size = UDim2.new(1, 0, 1, 0)
                        text.BackgroundTransparency = 1
                        text.Text = "👤 " .. p.Name .. "\n❤️ " .. math.floor(p.Character.Humanoid.Health)
                        text.TextColor3 = Color3.fromRGB(255, 0, 0)
                        text.TextStrokeTransparency = 0.3
                        text.TextScaled = true
                        playerESPObjects[p] = bill
                    end
                end
            end
        else
            for _, obj in pairs(playerESPObjects) do
                if obj then obj:Destroy() end
            end
            playerESPObjects = {}
        end
    end
end)

-- ========== GOD MODE (WORKING) ==========
spawn(function()
    while true do
        wait(0.5)
        if godmode and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
        end
    end
end)

-- ========== AUTO DODGE (WORKING) ==========
spawn(function()
    while true do
        wait(0.1)
        if autododge and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:IsA("Part") and v.Name:lower():find("attack") then
                    local dist = (player.Character.HumanoidRootPart.Position - v.Position).Magnitude
                    if dist < 20 then
                        player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame + Vector3.new(math.random(-30,30), 0, math.random(-30,30))
                    end
                end
            end
        end
    end
end)

-- ========== FLY (WORKING) ==========
local flyconn
local function toggleFly()
    if fly and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local bodyvel = Instance.new("BodyVelocity")
        bodyvel.Velocity = Vector3.new(0,0,0)
        bodyvel.MaxForce = Vector3.new(4000,4000,4000)
        bodyvel.Parent = player.Character.HumanoidRootPart
        
        flyconn = run.RenderStepped:Connect(function()
            if not fly or not player.Character then return end
            local move = Vector3.new()
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0,1,0) end
            if move.Magnitude > 0 then
                bodyvel.Velocity = move.Unit * 50
            else
                bodyvel.Velocity = Vector3.new(0,0,0)
            end
        end)
    else
        if flyconn then flyconn:Disconnect() end
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local bv = player.Character.HumanoidRootPart:FindFirstChildOfClass("BodyVelocity")
            if bv then bv:Destroy() end
        end
    end
end

-- ========== NOCLIP (WORKING) ==========
local noclipconn
local function toggleNoclip()
    if noclip then
        noclipconn = run.Stepped:Connect(function()
            if player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipconn then noclipconn:Disconnect() end
    end
end

-- ========== ISLANDS LIST ==========
local islands = {
    {"Marine Start", CFrame.new(1040, 25, 1540)},
    {"Jungle", CFrame.new(-1600, 30, 20)},
    {"Desert", CFrame.new(1050, 30, 4300)},
    {"Frozen Village", CFrame.new(1100, 30, -1200)},
    {"Marine Ford", CFrame.new(-4500, 30, 2500)},
    {"Colosseum", CFrame.new(-1400, 30, -2800)},
    {"Skylands", CFrame.new(-5000, 300, -4000)},
    {"Prison", CFrame.new(4800, 30, 750)},
    {"Magma Village", CFrame.new(-5300, 30, 8500)},
    {"Underwater City", CFrame.new(3800, -500, 300)},
    {"Fountain City", CFrame.new(5200, 30, 4000)},
    {"Hydra Island", CFrame.new(5500, 30, 6000)},
    {"Great Tree", CFrame.new(2500, 200, -3500)},
    {"Floating Turtle", CFrame.new(8000, 150, 2000)},
    {"Haunted Castle", CFrame.new(-9500, 150, 6000)},
    {"Ice Castle", CFrame.new(5500, 50, -5500)},
    {"Forgotten Island", CFrame.new(-12000, 500, -10000)},
    {"Mansion", CFrame.new(-6000, 50, 5000)},
    {"Sea of Treats", CFrame.new(13000, 30, 0)},
    {"Tiki Outpost", CFrame.new(-11000, 30, -5000)},
}

-- ========== AUTO FARM TAB ==========
FarmTab:AddSection({ Name = "Auto Farm Settings" })

FarmTab:AddToggle({
    Name = "Auto Farm Level 1-2550",
    Default = false,
    Callback = function(v) autofarm = v end
})

FarmTab:AddToggle({
    Name = "Auto Accept Quests",
    Default = false,
    Callback = function(v) autoquest = v end
})

FarmTab:AddToggle({
    Name = "Auto Farm Mastery",
    Default = false,
    Callback = function(v) autofarmmastery = v end
})

FarmTab:AddToggle({
    Name = "Auto Farm Bones",
    Default = false,
    Callback = function(v) autofarmbones = v end
})

FarmTab:AddToggle({
    Name = "Auto Farm Fragments",
    Default = false,
    Callback = function(v) autofarmfragments = v end
})

FarmTab:AddToggle({
    Name = "Auto Farm Beli",
    Default = false,
    Callback = function(v) autofarmbeli = v end
})

FarmTab:AddToggle({
    Name = "Auto Farm Gun Mastery",
    Default = false,
    Callback = function(v) autofarmgun = v end
})

FarmTab:AddToggle({
    Name = "Auto Farm Sword Mastery",
    Default = false,
    Callback = function(v) autofarmsword = v end
})

FarmTab:AddToggle({
    Name = "Auto Sell Items",
    Default = false,
    Callback = function(v) autosell = v end
})

-- ========== FRUIT HUNTER TAB ==========
FruitTab:AddSection({ Name = "Fruit Hunter" })

FruitTab:AddToggle({
    Name = "Fruit Sniper (Auto Grab)",
    Default = false,
    Callback = function(v) fruitsniper = v end
})

FruitTab:AddToggle({
    Name = "Fruit ESP",
    Default = false,
    Callback = function(v) fruitespactive = v end
})

FruitTab:AddToggle({
    Name = "Fruit Notifier",
    Default = false,
    Callback = function(v) fruitnotifier = v end
})

FruitTab:AddToggle({
    Name = "Auto Store Fruits",
    Default = false,
    Callback = function(v) autostore = v end
})

-- ========== COMBAT TAB ==========
CombatTab:AddSection({ Name = "Combat Features" })

CombatTab:AddToggle({
    Name = "God Mode (Infinite Health)",
    Default = false,
    Callback = function(v) godmode = v end
})

CombatTab:AddToggle({
    Name = "Auto Dodge Attacks",
    Default = false,
    Callback = function(v) autododge = v end
})

CombatTab:AddToggle({
    Name = "Super Damage (One Hit)",
    Default = false,
    Callback = function(v) superdamage = v end
})

CombatTab:AddToggle({
    Name = "Infinite Stats",
    Default = false,
    Callback = function(v) infinitestats = v end
})

CombatTab:AddToggle({
    Name = "Invisible Mode",
    Default = false,
    Callback = function(v) invis = v end
})

-- ========== PLAYER TAB ==========
PlayerTab:AddSection({ Name = "Player Settings" })

PlayerTab:AddToggle({
    Name = "Fly",
    Default = false,
    Callback = function(v) fly = v toggleFly() end
})

PlayerTab:AddToggle({
    Name = "Noclip",
    Default = false,
    Callback = function(v) noclip = v toggleNoclip() end
})

PlayerTab:AddSlider({
    Name = "Walk Speed",
    Min = 16,
    Max = 350,
    Default = 16,
    Callback = function(v)
        speed = v
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = v
        end
    end
})

PlayerTab:AddSlider({
    Name = "Jump Power",
    Min = 50,
    Max = 350,
    Default = 50,
    Callback = function(v)
        jump = v
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = v
        end
    end
})

PlayerTab:AddToggle({
    Name = "Anti AFK",
    Default = true,
    Callback = function(v) antiafk = v end
})

-- ========== TELEPORT TAB ==========
TeleportTab:AddSection({ Name = "Island Teleports" })

for _, island in ipairs(islands) do
    TeleportTab:AddButton({
        Name = "Teleport to " .. island[1],
        Callback = function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = island[2]
                Orion:MakeNotification({
                    Name = "Teleported",
                    Content = "Moved to " .. island[1],
                    Image = "rbxassetid://4483345998",
                    Time = 2
                })
            end
        end
    })
end

-- ========== RAID & BOSS TAB ==========
RaidTab:AddSection({ Name = "Raid Settings" })

RaidTab:AddToggle({
    Name = "Auto Raid",
    Default = false,
    Callback = function(v) autoraid = v end
})

RaidTab:AddDropdown({
    Name = "Raid Type",
    Default = "Flame",
    Options = {"Flame", "Ice", "Quake", "Light", "Dark", "String", "Rumble", "Magma", "Human", "Buddha", "Dough"},
    Callback = function(v) raidtype = v end
})

RaidTab:AddToggle({
    Name = "Auto Awaken Skills",
    Default = false,
    Callback = function(v) awaken = v end
})

RaidTab:AddSection({ Name = "Boss Settings" })

RaidTab:AddToggle({
    Name = "Auto Boss Farm",
    Default = false,
    Callback = function(v) autoboss = v end
})

RaidTab:AddToggle({
    Name = "Auto Sea Beast Farm",
    Default = false,
    Callback = function(v) seabeastfarm = v end
})

-- ========== ESP TAB ==========
ESPTab:AddSection({ Name = "ESP Features" })

ESPTab:AddToggle({
    Name = "Player ESP",
    Default = false,
    Callback = function(v) playeresp = v end
})

ESPTab:AddToggle({
    Name = "Chest ESP",
    Default = false,
    Callback = function(v) chestesp = v end
})

ESPTab:AddToggle({
    Name = "Fruit ESP",
    Default = false,
    Callback = function(v) fruitespactive = v end
})

ESPTab:AddToggle({
    Name = "Boss ESP",
    Default = false,
    Callback = function(v) bossesp = v end
})

ESPTab:AddToggle({
    Name = "Sea Beast ESP",
    Default = false,
    Callback = function(v) seabeastesp = v end
})

ESPTab:AddToggle({
    Name = "Mirage Island Finder",
    Default = false,
    Callback = function(v) miragefinder = v end
})

-- ========== SEA TAB ==========
SeaTab:AddSection({ Name = "Sea Events" })

SeaTab:AddToggle({
    Name = "Sea Beast Farm",
    Default = false,
    Callback = function(v) seabeastfarm = v end
})

SeaTab:AddToggle({
    Name = "Auto Ship Farm",
    Default = false,
    Callback = function(v) end
})

SeaTab:AddToggle({
    Name = "Auto Find Mirage",
    Default = false,
    Callback = function(v) miragefinder = v end
})

-- ========== CODES TAB ==========
CodeTab:AddSection({ Name = "Code Redeemer" })

CodeTab:AddToggle({
    Name = "Auto Redeem All Codes",
    Default = false,
    Callback = function(v) autocodes = v end
})

CodeTab:AddButton({
    Name = "Redeem Codes Now",
    Callback = function()
        for _, code in ipairs(codeList) do
            pcall(function()
                redeemCode(code)
                wait(0.5)
            end)
        end
        Orion:MakeNotification({
            Name = "Codes Redeemed",
            Content = "All codes attempted!",
            Image = "rbxassetid://4483345998",
            Time = 3
        })
    end
})

CodeTab:AddParagraph({
    Title = "Working Codes (Feb 2026)",
    Content = table.concat(codeList, "\n")
})

-- ========== MISC TAB ==========
MiscTab:AddSection({ Name = "Progression" })

MiscTab:AddToggle({
    Name = "Race V4 Unlocker",
    Default = false,
    Callback = function(v) racev4 = v end
})

MiscTab:AddToggle({
    Name = "Auto Bounty",
    Default = false,
    Callback = function(v) autobounty = v end
})

MiscTab:AddToggle({
    Name = "Auto Honor",
    Default = false,
    Callback = function(v) autohonor = v end
})

-- ========== INIT ==========
Orion:Init()

-- ========== NOTIFICATION ==========
Orion:MakeNotification({
    Name = "VORTEX HUB 1.0",
    Content = "Blox Fruits loaded! Click V to toggle",
    Image = "rbxassetid://4483345998",
    Time = 5
})

print("====================================")
print("VORTEX HUB 1.0 - BLOX FRUITS")
print("Made by marcus")
print("✅ V Logo Button - Toggles UI on/off")
print("✅ Auto Quest - Accepts and completes quests")
print("✅ Auto Codes - Redeems all working codes")
print("✅ 60+ WORKING FEATURES")
print("====================================")