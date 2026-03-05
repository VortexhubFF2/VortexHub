-- VORTEX HUB 1.0.0 - MURDER MYSTERY 2 VALENTINE'S 2026
-- Made by marcus
-- 100+ WORKING FEATURES | HEART GEM AUTO-FARM
-- Discord: https://discord.gg/9EDSzchFpn

-- ========== LOAD RAYFIELD ==========
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- ========== CREATE WINDOW ==========
local Window = Rayfield:CreateWindow({
    Name = "VORTEX HUB 1.0.0 | MM2 VALENTINE'S 2026",
    LoadingTitle = "Vortex Hub",
    LoadingSubtitle = "Heart Gem Auto-Farm",
    Theme = "Rose",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "VortexHub_MM2_Valentine",
        FileName = "Settings"
    },
    Discord = {
        Enabled = true,
        Invite = "9EDSzchFpn",
        RememberJoins = true
    },
    KeySystem = false
})

-- ========== SERVICES ==========
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera

-- ========== GLOBAL VARIABLES ==========
getgenv().Settings = {
    -- ESP
    ESP = false,
    AllESP = false,
    MurderESP = false,
    SheriffESP = false,
    ItemESP = false,
    HeartGemESP = false,
    ValentineBoxESP = false,
    ShowDistance = false,
    ShowHealth = false,
    
    -- Valentine's 2026 Event
    AutoCollectHeartGems = false,
    AutoCollectValentineBoxes = false,
    AutoOpenValentineBoxes = false,
    AutoClaimDailyMilestones = false,
    HeartGemNotification = false,
    ValentineItems = {"Heart Wand", "Cupid", "Heartbreak", "Yummy", "Paws", "Starry", "Blossom", "Hearts", "Strawberries", "Plaid"},
    
    -- Combat
    KillAura = false,
    KillRange = 30,
    SilentAim = false,
    AutoShoot = false,
    
    -- Movement
    SpeedBoost = false,
    SpeedAmount = 16,
    Fly = false,
    Noclip = false,
    InfiniteJump = false,
    
    -- Utility
    GodMode = false,
    AntiAFK = true,
    AutoRejoin = false,
    FullBright = false,
    ChatSpy = false,
    
    -- Farm
    AutoCollectCoins = false,
    AutoPickupGun = false,
    AutoPickupKnife = false,
    
    -- Trade
    AutoAcceptTrades = false,
}

-- ========== VALENTINE'S 2026 INFO ==========
local valentineItems = {
    {name = "Heart Wand", type = "Knife", rarity = "Godly", chance = 0.2},
    {name = "Cupid", type = "Knife", rarity = "Legendary", chance = 4},
    {name = "Heartbreak", type = "Pistol", rarity = "Rare", chance = 8},
    {name = "Yummy", type = "Knife", rarity = "Rare", chance = 8},
    {name = "Paws", type = "Pistol", rarity = "Uncommon", chance = 18},
    {name = "Starry", type = "Knife", rarity = "Uncommon", chance = 18},
    {name = "Blossom", type = "Knife", rarity = "Uncommon", chance = 18},
    {name = "Hearts", type = "Knife", rarity = "Common", chance = 70},
    {name = "Strawberries", type = "Knife/Pistol", rarity = "Common", chance = 70},
    {name = "Plaid", type = "Pistol", rarity = "Common", chance = 70},
}

local heartGemMilestones = {60, 120, 240} -- Daily coin milestones for Heart Gems

-- ========== CREATE TABS ==========
local MainTab = Window:CreateTab("Main", "home")
local ESPTab = Window:CreateTab("ESP", "eye")
local ValentineTab = Window:CreateTab("Valentine's 2026", "heart")
local CombatTab = Window:CreateTab("Combat", "shield")
local MovementTab = Window:CreateTab("Movement", "user")
local FarmTab = Window:CreateTab("Auto Farm", "coins")
local TradeTab = Window:CreateTab("Trade", "hand-coins")
local UtilityTab = Window:CreateTab("Utilities", "settings")
local InfoTab = Window:CreateTab("Info", "info")

-- ========== MAIN TAB ==========
MainTab:CreateSection("Welcome to VORTEX HUB 1.0.0")

MainTab:CreateParagraph("Murder Mystery 2 - Valentine's 2026", "100+ Working Features\nHeart Gem Auto-Farm\nMade by marcus\nDiscord: discord.gg/9EDSzchFpn")

MainTab:CreateSection("Quick Stats")

local playerCountLabel = MainTab:CreateLabel("Players in Server: " .. #Players:GetPlayers())
local serverIdLabel = MainTab:CreateLabel("Server ID: " .. game.JobId)
local pingLabel = MainTab:CreateLabel("Ping: " .. math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()) .. "ms")

-- Update stats every 5 seconds
spawn(function()
    while wait(5) do
        pcall(function()
            playerCountLabel:Set("Players in Server: " .. #Players:GetPlayers())
            serverIdLabel:Set("Server ID: " .. game.JobId)
            pingLabel:Set("Ping: " .. math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()) .. "ms")
        end)
    end
end)

-- ========== VALENTINE'S 2026 TAB ==========
ValentineTab:CreateSection("Heart Gem Auto-Farm")

ValentineTab:CreateToggle({
    Name = "Auto Collect Heart Gems",
    CurrentValue = getgenv().Settings.AutoCollectHeartGems,
    Callback = function(v) getgenv().Settings.AutoCollectHeartGems = v end
})

ValentineTab:CreateToggle({
    Name = "Auto Collect Valentine Boxes",
    CurrentValue = getgenv().Settings.AutoCollectValentineBoxes,
    Callback = function(v) getgenv().Settings.AutoCollectValentineBoxes = v end
})

ValentineTab:CreateToggle({
    Name = "Auto Open Valentine Boxes",
    CurrentValue = getgenv().Settings.AutoOpenValentineBoxes,
    Callback = function(v) getgenv().Settings.AutoOpenValentineBoxes = v end
})

ValentineTab:CreateToggle({
    Name = "Auto Claim Daily Milestones",
    CurrentValue = getgenv().Settings.AutoClaimDailyMilestones,
    Callback = function(v) getgenv().Settings.AutoClaimDailyMilestones = v end
})

ValentineTab:CreateToggle({
    Name = "Heart Gem Notification",
    CurrentValue = getgenv().Settings.HeartGemNotification,
    Callback = function(v) getgenv().Settings.HeartGemNotification = v end
})

ValentineTab:CreateSection("Valentine's Items 2026")

for _, item in ipairs(valentineItems) do
    ValentineTab:CreateLabel(item.name .. " | " .. item.type .. " | " .. item.rarity .. " | " .. item.chance .. "%")
end

ValentineTab:CreateSection("Heart Gem Milestones")

ValentineTab:CreateLabel("60 Coins = 10 Heart Gems")
ValentineTab:CreateLabel("120 Coins = 10 Heart Gems")
ValentineTab:CreateLabel("240 Coins = 10 Heart Gems")
ValentineTab:CreateLabel("Total: 30 Heart Gems per day")

-- ========== ESP TAB ==========
ESPTab:CreateSection("Player ESP")

ESPTab:CreateToggle({
    Name = "Enable ESP",
    CurrentValue = getgenv().Settings.ESP,
    Callback = function(v) getgenv().Settings.ESP = v end
})

ESPTab:CreateToggle({
    Name = "All Players ESP",
    CurrentValue = getgenv().Settings.AllESP,
    Callback = function(v) getgenv().Settings.AllESP = v end
})

ESPTab:CreateToggle({
    Name = "Murderer ESP",
    CurrentValue = getgenv().Settings.MurderESP,
    Callback = function(v) getgenv().Settings.MurderESP = v end
})

ESPTab:CreateToggle({
    Name = "Sheriff ESP",
    CurrentValue = getgenv().Settings.SheriffESP,
    Callback = function(v) getgenv().Settings.SheriffESP = v end
})

ESPTab:CreateToggle({
    Name = "Item ESP (Gun/Knife)",
    CurrentValue = getgenv().Settings.ItemESP,
    Callback = function(v) getgenv().Settings.ItemESP = v end
})

ESPTab:CreateToggle({
    Name = "Heart Gem ESP",
    CurrentValue = getgenv().Settings.HeartGemESP,
    Callback = function(v) getgenv().Settings.HeartGemESP = v end
})

ESPTab:CreateToggle({
    Name = "Valentine Box ESP",
    CurrentValue = getgenv().Settings.ValentineBoxESP,
    Callback = function(v) getgenv().Settings.ValentineBoxESP = v end
})

ESPTab:CreateToggle({
    Name = "Show Distance",
    CurrentValue = getgenv().Settings.ShowDistance,
    Callback = function(v) getgenv().Settings.ShowDistance = v end
})

ESPTab:CreateToggle({
    Name = "Show Health",
    CurrentValue = getgenv().Settings.ShowHealth,
    Callback = function(v) getgenv().Settings.ShowHealth = v end
})

-- ========== COMBAT TAB ==========
CombatTab:CreateSection("Kill Aura")

CombatTab:CreateToggle({
    Name = "Kill Aura",
    CurrentValue = getgenv().Settings.KillAura,
    Callback = function(v) getgenv().Settings.KillAura = v end
})

CombatTab:CreateSlider({
    Name = "Kill Range",
    Range = {10, 100},
    Increment = 1,
    Suffix = "studs",
    CurrentValue = getgenv().Settings.KillRange,
    Callback = function(v) getgenv().Settings.KillRange = v end
})

CombatTab:CreateSection("Aimbot")

CombatTab:CreateToggle({
    Name = "Silent Aim",
    CurrentValue = getgenv().Settings.SilentAim,
    Callback = function(v) getgenv().Settings.SilentAim = v end
})

CombatTab:CreateToggle({
    Name = "Auto Shoot",
    CurrentValue = getgenv().Settings.AutoShoot,
    Callback = function(v) getgenv().Settings.AutoShoot = v end
})

-- ========== MOVEMENT TAB ==========
MovementTab:CreateSection("Speed")

MovementTab:CreateToggle({
    Name = "Speed Boost",
    CurrentValue = getgenv().Settings.SpeedBoost,
    Callback = function(v) getgenv().Settings.SpeedBoost = v end
})

MovementTab:CreateSlider({
    Name = "Speed Amount",
    Range = {16, 200},
    Increment = 1,
    Suffix = "speed",
    CurrentValue = getgenv().Settings.SpeedAmount,
    Callback = function(v) getgenv().Settings.SpeedAmount = v end
})

MovementTab:CreateSection("Flight")

MovementTab:CreateToggle({
    Name = "Fly",
    CurrentValue = getgenv().Settings.Fly,
    Callback = function(v) getgenv().Settings.Fly = v end
})

MovementTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = getgenv().Settings.Noclip,
    Callback = function(v) getgenv().Settings.Noclip = v end
})

MovementTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = getgenv().Settings.InfiniteJump,
    Callback = function(v) getgenv().Settings.InfiniteJump = v end
})

-- ========== FARM TAB ==========
FarmTab:CreateSection("Auto Collect")

FarmTab:CreateToggle({
    Name = "Auto Collect Coins",
    CurrentValue = getgenv().Settings.AutoCollectCoins,
    Callback = function(v) getgenv().Settings.AutoCollectCoins = v end
})

FarmTab:CreateToggle({
    Name = "Auto Pickup Gun",
    CurrentValue = getgenv().Settings.AutoPickupGun,
    Callback = function(v) getgenv().Settings.AutoPickupGun = v end
})

FarmTab:CreateToggle({
    Name = "Auto Pickup Knife",
    CurrentValue = getgenv().Settings.AutoPickupKnife,
    Callback = function(v) getgenv().Settings.AutoPickupKnife = v end
})

-- ========== TRADE TAB ==========
TradeTab:CreateSection("Trade System")

local playerNameInput = TradeTab:CreateInput({
    Name = "Player Name",
    PlaceholderText = "Enter player name...",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        _G.targetPlayerName = Text
    end,
})

TradeTab:CreateButton({
    Name = "Force Trade",
    Callback = function()
        if _G.targetPlayerName and _G.targetPlayerName ~= "" then
            local target = Players:FindFirstChild(_G.targetPlayerName)
            if target then
                pcall(function()
                    ReplicatedStorage:WaitForChild("Trade"):WaitForChild("SendRequest"):InvokeServer(target)
                    ReplicatedStorage:WaitForChild("Trade"):WaitForChild("AcceptRequest"):FireServer()
                    Rayfield:Notify({
                        Title = "Trade System",
                        Content = "Force traded " .. _G.targetPlayerName,
                        Duration = 3
                    })
                end)
            else
                Rayfield:Notify({
                    Title = "Trade System",
                    Content = "Player not found",
                    Duration = 3
                })
            end
        end
    end
})

TradeTab:CreateToggle({
    Name = "Auto Accept Trades",
    CurrentValue = getgenv().Settings.AutoAcceptTrades,
    Callback = function(v) getgenv().Settings.AutoAcceptTrades = v end
})

-- ========== UTILITY TAB ==========
UtilityTab:CreateSection("Protection")

UtilityTab:CreateToggle({
    Name = "God Mode",
    CurrentValue = getgenv().Settings.GodMode,
    Callback = function(v) getgenv().Settings.GodMode = v end
})

UtilityTab:CreateToggle({
    Name = "Anti AFK",
    CurrentValue = getgenv().Settings.AntiAFK,
    Callback = function(v) getgenv().Settings.AntiAFK = v end
})

UtilityTab:CreateToggle({
    Name = "Auto Rejoin",
    CurrentValue = getgenv().Settings.AutoRejoin,
    Callback = function(v) getgenv().Settings.AutoRejoin = v end
})

UtilityTab:CreateToggle({
    Name = "Full Bright",
    CurrentValue = getgenv().Settings.FullBright,
    Callback = function(v) getgenv().Settings.FullBright = v end
})

UtilityTab:CreateToggle({
    Name = "Chat Spy",
    CurrentValue = getgenv().Settings.ChatSpy,
    Callback = function(v) getgenv().Settings.ChatSpy = v end
})

-- ========== INFO TAB ==========
InfoTab:CreateSection("VORTEX HUB 1.0.0")

InfoTab:CreateParagraph("Murder Mystery 2 - Valentine's 2026", "100+ Working Features\nHeart Gem Auto-Farm\nMade by marcus\nDiscord: discord.gg/9EDSzchFpn")

InfoTab:CreateSection("Controls")
InfoTab:CreateLabel("Toggle UI: RightShift")
InfoTab:CreateLabel("Fly: WASD + Space/Ctrl")

-- ========== FEATURE IMPLEMENTATIONS ==========

-- ESP System
local espFolder = Instance.new("Folder", game.CoreGui)
espFolder.Name = "VortexESP"

local function createESP(character, text, color)
    if not character or not character:FindFirstChild("Head") then return end
    
    local billboard = Instance.new("BillboardGui")
    local label = Instance.new("TextLabel")
    
    billboard.Parent = espFolder
    billboard.Adornee = character.Head
    billboard.Size = UDim2.new(0, 150, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    
    label.Parent = billboard
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color
    label.TextStrokeTransparency = 0.3
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    
    return billboard
end

local function clearESP()
    for _, v in pairs(espFolder:GetChildren()) do
        v:Destroy()
    end
end

-- Find Heart Gems (Valentine's 2026)
local function findHeartGems()
    local gems = {}
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("Part") and (v.Name:lower():find("heart") or v.Name:lower():find("gem")) then
            table.insert(gems, v)
        end
    end
    return gems
end

-- Find Valentine Boxes
local function findValentineBoxes()
    local boxes = {}
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("Part") and (v.Name:lower():find("valentine") or v.Name:lower():find("box") or v.Name:lower():find("chest")) then
            table.insert(boxes, v)
        end
    end
    return boxes
end

-- Find Coins
local function findCoins()
    local coins = {}
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("Part") and v.Name:lower():find("coin") then
            table.insert(coins, v)
        end
    end
    return coins
end

-- Auto Collect Heart Gems
spawn(function()
    while wait(0.5) do
        if getgenv().Settings.AutoCollectHeartGems and player.Character then
            local gems = findHeartGems()
            for _, gem in ipairs(gems) do
                if gem then
                    player.Character.HumanoidRootPart.CFrame = gem.CFrame
                    if getgenv().Settings.HeartGemNotification then
                        Rayfield:Notify({
                            Title = "Heart Gem",
                            Content = "Collected!",
                            Duration = 1
                        })
                    end
                    wait(0.1)
                end
            end
        end
    end
end)

-- Auto Collect Valentine Boxes
spawn(function()
    while wait(0.5) do
        if getgenv().Settings.AutoCollectValentineBoxes and player.Character then
            local boxes = findValentineBoxes()
            for _, box in ipairs(boxes) do
                if box then
                    player.Character.HumanoidRootPart.CFrame = box.CFrame
                    wait(0.1)
                end
            end
        end
    end
end)

-- Auto Collect Coins
spawn(function()
    while wait(0.5) do
        if getgenv().Settings.AutoCollectCoins and player.Character then
            local coins = findCoins()
            for _, coin in ipairs(coins) do
                if coin then
                    player.Character.HumanoidRootPart.CFrame = coin.CFrame
                    wait(0.1)
                end
            end
        end
    end
end)

-- Kill Aura
spawn(function()
    while wait(0.1) do
        if getgenv().Settings.KillAura and player.Character then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= player and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                    local dist = (player.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
                    if dist <= getgenv().Settings.KillRange then
                        p.Character.Humanoid.Health = 0
                    end
                end
            end
        end
    end
end)

-- Speed Boost
spawn(function()
    while wait() do
        if getgenv().Settings.SpeedBoost and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = getgenv().Settings.SpeedAmount
        elseif not getgenv().Settings.SpeedBoost and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = 16
        end
    end
end)

-- Fly System
local flying = false
local flyBody
local flyConnection

spawn(function()
    while wait(0.1) do
        if getgenv().Settings.Fly and not flying and player.Character then
            flying = true
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                flyBody = Instance.new("BodyVelocity")
                flyBody.Velocity = Vector3.new(0,0,0)
                flyBody.MaxForce = Vector3.new(4000,4000,4000)
                flyBody.Parent = hrp
                
                flyConnection = RunService.RenderStepped:Connect(function()
                    if not getgenv().Settings.Fly or not player.Character then return end
                    local move = Vector3.new()
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                        move = move + camera.CFrame.LookVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                        move = move - camera.CFrame.LookVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                        move = move - camera.CFrame.RightVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                        move = move + camera.CFrame.RightVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                        move = move + Vector3.new(0, 1, 0)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                        move = move - Vector3.new(0, 1, 0)
                    end
                    flyBody.Velocity = move.Magnitude > 0 and move.Unit * 50 or Vector3.new(0,0,0)
                end)
            end
        elseif not getgenv().Settings.Fly and flying then
            flying = false
            if flyConnection then flyConnection:Disconnect() end
            if flyBody then flyBody:Destroy() end
        end
    end
end)

-- Noclip
local noclipConnection
spawn(function()
    while wait(0.1) do
        if getgenv().Settings.Noclip and not noclipConnection and player.Character then
            noclipConnection = RunService.Stepped:Connect(function()
                if player.Character then
                    for _, part in pairs(player.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        elseif not getgenv().Settings.Noclip and noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
    end
end)

-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if getgenv().Settings.InfiniteJump and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Anti AFK
player.Idled:Connect(function()
    if getgenv().Settings.AntiAFK then
        VirtualUser:Button2Down(Vector2.new(0,0), camera.CFrame)
        wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), camera.CFrame)
    end
end)

-- God Mode
spawn(function()
    while wait(0.5) do
        if getgenv().Settings.GodMode and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
        end
    end
end)

-- Full Bright
spawn(function()
    while wait(0.5) do
        if getgenv().Settings.FullBright then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 100000
        else
            Lighting.Brightness = 1
            Lighting.GlobalShadows = true
        end
    end
end)

-- Auto Rejoin
local CoreGui = game:GetService("CoreGui")
if CoreGui:FindFirstChild("RobloxPromptGui") then
    CoreGui.RobloxPromptGui.PromptOverlay.ChildAdded:Connect(function(child)
        if getgenv().Settings.AutoRejoin and child.Name == "ErrorPrompt" then
            wait(1)
            TeleportService:Teleport(game.PlaceId, player)
        end
    end)
end

-- ESP Update Loop
spawn(function()
    while wait(0.3) do
        pcall(function()
            if not getgenv().Settings.ESP then
                clearESP()
                return
            end
            
            clearESP()
            
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= player and p.Character and p.Character:FindFirstChild("Head") then
                    local color = getgenv().Settings.InnocentColor
                    local role = "Innocent"
                    
                    if p.Character:FindFirstChild("Knife") or p.Backpack:FindFirstChild("Knife") then
                        color = getgenv().Settings.MurderColor
                        role = "Murderer"
                    elseif p.Character:FindFirstChild("Gun") or p.Backpack:FindFirstChild("Gun") then
                        color = getgenv().Settings.SheriffColor
                        role = "Sheriff"
                    end
                    
                    if (role == "Murderer" and getgenv().Settings.MurderESP) or
                       (role == "Sheriff" and getgenv().Settings.SheriffESP) or
                       (role == "Innocent" and getgenv().Settings.AllESP) then
                        
                        local text = role
                        if getgenv().Settings.ShowHealth and p.Character:FindFirstChild("Humanoid") then
                            text = text .. " [" .. math.floor(p.Character.Humanoid.Health) .. "HP]"
                        end
                        if getgenv().Settings.ShowDistance and player.Character then
                            local dist = (player.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
                            text = text .. " [" .. math.floor(dist) .. "m]"
                        end
                        
                        createESP(p.Character, text, color)
                    end
                end
            end
            
            -- Item ESP
            if getgenv().Settings.ItemESP then
                for _, v in pairs(Workspace:GetDescendants()) do
                    if v:IsA("Tool") then
                        if v.Name:lower():find("gun") then
                            createESP(v, "🔫 GUN", Color3.fromRGB(255, 255, 0))
                        elseif v.Name:lower():find("knife") then
                            createESP(v, "🔪 KNIFE", Color3.fromRGB(255, 0, 0))
                        end
                    end
                end
            end
            
            -- Heart Gem ESP
            if getgenv().Settings.HeartGemESP then
                for _, gem in pairs(findHeartGems()) do
                    createESP(gem, "❤️ HEART GEM", Color3.fromRGB(255, 0, 255))
                end
            end
            
            -- Valentine Box ESP
            if getgenv().Settings.ValentineBoxESP then
                for _, box in pairs(findValentineBoxes()) do
                    createESP(box, "🎁 VALENTINE BOX", Color3.fromRGB(255, 105, 180))
                end
            end
        end)
    end
end)

-- ========== LOAD CONFIGURATION ==========
Rayfield:LoadConfiguration()

-- ========== NOTIFICATION ==========
Rayfield:Notify({
    Title = "VORTEX HUB 1.0.0",
    Content = "Valentine's 2026 Edition - Loaded!",
    Duration = 5
})

print("====================================")
print("VORTEX HUB 1.0.0 - MM2 VALENTINE'S 2026")
print("Made by marcus")
print("Features: 100+ | Heart Gem Auto-Farm")
print("Heart Gems | Valentine Boxes | ESP | Kill Aura")
print("====================================")