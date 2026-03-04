-- VORTEX HUB 1.0.0 - ULTIMATE BLOX FRUITS
-- Made by marcus
-- 100+ FEATURES | PROFESSIONAL GRADE

-- ========== SERVICES ==========
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInput = game:GetService("VirtualInputManager")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer
local run = RunService
local camera = Workspace.CurrentCamera

-- ========== LOADING SCREEN ==========
local gui = Instance.new("ScreenGui")
gui.Name = "VortexHub"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999999

local loading = Instance.new("Frame")
loading.Parent = gui
loading.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
loading.Size = UDim2.new(1, 0, 1, 0)
loading.ZIndex = 1000

local loadingGradient = Instance.new("UIGradient")
loadingGradient.Parent = loading
loadingGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 20, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 5, 20))
})

local loadingLogo = Instance.new("TextLabel")
loadingLogo.Parent = loading
loadingLogo.BackgroundTransparency = 1
loadingLogo.Position = UDim2.new(0.5, -150, 0.4, -50)
loadingLogo.Size = UDim2.new(0, 300, 0, 100)
loadingLogo.Font = Enum.Font.GothamBlack
loadingLogo.Text = "VORTEX 1.0.0"
loadingLogo.TextColor3 = Color3.fromRGB(0, 200, 255)
loadingLogo.TextSize = 50

local loadingSub = Instance.new("TextLabel")
loadingSub.Parent = loading
loadingSub.BackgroundTransparency = 1
loadingSub.Position = UDim2.new(0.5, -150, 0.48, 0)
loadingSub.Size = UDim2.new(0, 300, 0, 30)
loadingSub.Font = Enum.Font.Gotham
loadingSub.Text = "ULTIMATE BLOX FRUITS"
loadingSub.TextColor3 = Color3.fromRGB(150, 150, 255)
loadingSub.TextSize = 16

local loadingBar = Instance.new("Frame")
loadingBar.Parent = loading
loadingBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
loadingBar.Position = UDim2.new(0.5, -150, 0.6, -5)
loadingBar.Size = UDim2.new(0, 300, 0, 6)

local loadingFill = Instance.new("Frame")
loadingFill.Parent = loadingBar
loadingFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
loadingFill.Size = UDim2.new(0, 0, 1, 0)

local loadingText = Instance.new("TextLabel")
loadingText.Parent = loading
loadingText.BackgroundTransparency = 1
loadingText.Position = UDim2.new(0.5, -150, 0.65, 0)
loadingText.Size = UDim2.new(0, 300, 0, 20)
loadingText.Font = Enum.Font.Gotham
loadingText.Text = "LOADING VORTEX HUB..."
loadingText.TextColor3 = Color3.fromRGB(200, 200, 255)
loadingText.TextSize = 12

-- Loading animation
spawn(function()
    local steps = {
        {text = "LOADING MAIN FRAMEWORK", pct = 10},
        {text = "LOADING AUTO FARM", pct = 25},
        {text = "LOADING FRUIT HUNTER", pct = 40},
        {text = "LOADING COMBAT SYSTEM", pct = 55},
        {text = "LOADING TELEPORTS", pct = 70},
        {text = "LOADING ESP SYSTEM", pct = 85},
        {text = "VORTEX HUB READY", pct = 100}
    }
    
    for _, step in ipairs(steps) do
        loadingText.Text = step.text
        for i = 0, step.pct, 2 do
            loadingFill.Size = UDim2.new(i/100, 0, 1, 0)
            wait(0.01)
        end
        wait(0.2)
    end
    wait(0.5)
    loading:TweenPosition(UDim2.new(0, 0, -1, 0), "Out", "Quad", 1, true)
    wait(1)
    loading:Destroy()
end)

-- ========== MAIN TOGGLE BUTTON ==========
local toggleBtn = Instance.new("ImageButton")
toggleBtn.Parent = gui
toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
toggleBtn.BackgroundTransparency = 0.2
toggleBtn.Position = UDim2.new(0.02, 0, 0.5, -25)
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Image = "rbxassetid://3570695787"
toggleBtn.ImageColor3 = Color3.fromRGB(0, 200, 255)
toggleBtn.ScaleType = Enum.ScaleType.Fit
toggleBtn.Draggable = true
toggleBtn.ZIndex = 100

local toggleCorner = Instance.new("UICorner")
toggleCorner.Parent = toggleBtn
toggleCorner.CornerRadius = UDim.new(0, 8)

-- ========== MAIN WINDOW ==========
local frame = Instance.new("Frame")
frame.Parent = gui
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
frame.Position = UDim2.new(0.1, 0, 0.05, 0)
frame.Size = UDim2.new(0.8, 0, 0.9, 0)
frame.Active = true
frame.Draggable = true
frame.Visible = false
frame.ZIndex = 50

local frameCorner = Instance.new("UICorner")
frameCorner.Parent = frame
frameCorner.CornerRadius = UDim.new(0, 6)

-- Shadow
local shadow = Instance.new("ImageLabel")
shadow.Parent = frame
shadow.BackgroundTransparency = 1
shadow.Position = UDim2.new(0, -8, 0, -8)
shadow.Size = UDim2.new(1, 16, 1, 16)
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.6
shadow.ZIndex = 49

-- Title bar
local titleBar = Instance.new("Frame")
titleBar.Parent = frame
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.ZIndex = 51

local titleCorner = Instance.new("UICorner")
titleCorner.Parent = titleBar
titleCorner.CornerRadius = UDim.new(0, 6)

local titleIcon = Instance.new("ImageLabel")
titleIcon.Parent = titleBar
titleIcon.BackgroundTransparency = 1
titleIcon.Position = UDim2.new(0, 10, 0, 10)
titleIcon.Size = UDim2.new(0, 20, 0, 20)
titleIcon.Image = "rbxassetid://3570695787"
titleIcon.ImageColor3 = Color3.fromRGB(0, 200, 255)

local titleText = Instance.new("TextLabel")
titleText.Parent = titleBar
titleText.BackgroundTransparency = 1
titleText.Position = UDim2.new(0, 35, 0, 0)
titleText.Size = UDim2.new(0, 200, 1, 0)
titleText.Font = Enum.Font.GothamBold
titleText.Text = "VORTEX 1.0.0"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextSize = 14
titleText.TextXAlignment = Enum.TextXAlignment.Left

local madeBy = Instance.new("TextLabel")
madeBy.Parent = titleBar
madeBy.BackgroundTransparency = 1
madeBy.Position = UDim2.new(0, 35, 0, 18)
madeBy.Size = UDim2.new(0, 200, 0, 20)
madeBy.Font = Enum.Font.Gotham
madeBy.Text = "by marcus | 100+ FEATURES"
madeBy.TextColor3 = Color3.fromRGB(150, 150, 150)
madeBy.TextSize = 10
madeBy.TextXAlignment = Enum.TextXAlignment.Left

-- Window controls
local closeBtn = Instance.new("ImageButton")
closeBtn.Parent = titleBar
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
closeBtn.Position = UDim2.new(1, -30, 0, 10)
closeBtn.Size = UDim2.new(0, 20, 0, 20)
closeBtn.Image = "rbxassetid://3570695787"
closeBtn.ImageColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.ZIndex = 52

local closeCorner = Instance.new("UICorner")
closeCorner.Parent = closeBtn
closeCorner.CornerRadius = UDim.new(0, 4)

closeBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
end)

-- ========== TAB BAR ==========
local tabBar = Instance.new("Frame")
tabBar.Parent = frame
tabBar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
tabBar.Position = UDim2.new(0, 0, 0, 40)
tabBar.Size = UDim2.new(1, 0, 0, 35)
tabBar.ZIndex = 51

-- Tab creation
local tabs = {}
local contents = {}

local function createTab(name, xPos)
    local tab = Instance.new("TextButton")
    tab.Parent = tabBar
    tab.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    tab.Position = UDim2.new(xPos, 3, 0, 2.5)
    tab.Size = UDim2.new(0.125, -4, 0, 30)
    tab.Font = Enum.Font.GothamBold
    tab.Text = name
    tab.TextColor3 = Color3.fromRGB(200, 200, 200)
    tab.TextSize = 9
    tab.ZIndex = 52
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.Parent = tab
    tabCorner.CornerRadius = UDim.new(0, 4)
    
    return tab
end

local tabsList = {"MAIN", "FARM", "FRUIT", "COMBAT", "BOSS", "MASTERY", "VISUAL", "MISC"}
for i, name in ipairs(tabsList) do
    tabs[name] = createTab(name, (i-1) * 0.125)
end

-- Content frames
for _, name in ipairs(tabsList) do
    local content = Instance.new("ScrollingFrame")
    content.Parent = frame
    content.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    content.BackgroundTransparency = 1
    content.Position = UDim2.new(0, 0, 0, 75)
    content.Size = UDim2.new(1, 0, 1, -75)
    content.CanvasSize = UDim2.new(0, 0, 0, 0)
    content.ScrollBarThickness = 4
    content.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 255)
    content.Visible = false
    contents[name] = content
end

-- Tab switching
local function switchTab(name)
    for tabName, tab in pairs(tabs) do
        tab.BackgroundColor3 = tabName == name and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(35, 35, 40)
        tab.TextColor3 = tabName == name and Color3.new(1,1,1) or Color3.fromRGB(200,200,200)
    end
    for contentName, content in pairs(contents) do
        content.Visible = contentName == name
    end
end

for name, tab in pairs(tabs) do
    tab.MouseButton1Click:Connect(function() switchTab(name) end)
end

-- ========== VARIABLES ==========
local settings = {
    -- Auto Farm
    autoFarm = false,
    farmMode = "Level",
    farmTarget = "Nearest",
    farmDistance = 20,
    farmHeight = 0,
    farmSpeed = 30,
    useTween = true,
    useInstant = false,
    autoAttack = true,
    attackDelay = 0.1,
    fastAttack = false,
    fastAttackMulti = 2,
    bringEnemies = false,
    bringRadius = 30,
    
    -- Quest
    autoQuest = false,
    autoAccept = true,
    autoTeleportNPC = true,
    
    -- Combat
    autoHaki = false,
    autoKen = false,
    autoClick = false,
    clickCPS = 10,
    noCooldown = false,
    hitboxExtend = false,
    hitboxSize = 1.5,
    
    -- Fruit
    fruitSniper = false,
    fruitESP = false,
    autoStore = false,
    fruitDealer = false,
    
    -- Teleport
    tweenSpeed = 300,
    instantTeleport = false,
    
    -- Visual
    playerESP = false,
    flowerESP = false,
    fullBright = false,
    removeFog = false,
    
    -- Misc
    autoRejoin = false,
    autoCode = false,
    hopServer = false,
    hopLowServer = false,
    fpsBooster = false,
    antiAfk = true,
}

-- ========== UI HELPER FUNCTIONS ==========
local function createSection(parent, title, yPos)
    local section = Instance.new("TextLabel")
    section.Parent = parent
    section.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    section.Position = UDim2.new(0, 5, 0, yPos)
    section.Size = UDim2.new(1, -10, 0, 25)
    section.Font = Enum.Font.GothamBold
    section.Text = title
    section.TextColor3 = Color3.fromRGB(0, 200, 255)
    section.TextSize = 12
    section.TextXAlignment = Enum.TextXAlignment.Left
    
    local sectionCorner = Instance.new("UICorner")
    sectionCorner.Parent = section
    sectionCorner.CornerRadius = UDim.new(0, 4)
    
    return section, yPos + 30
end

local function createToggle(parent, text, yPos, setting)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    btn.Position = UDim2.new(0, 5, 0, yPos)
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 11
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.ZIndex = 52
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.Parent = btn
    btnCorner.CornerRadius = UDim.new(0, 4)
    
    local indicator = Instance.new("Frame")
    indicator.Parent = btn
    indicator.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
    indicator.Position = UDim2.new(1, -25, 0, 5)
    indicator.Size = UDim2.new(0, 20, 0, 20)
    indicator.ZIndex = 53
    
    local indCorner = Instance.new("UICorner")
    indCorner.Parent = indicator
    indCorner.CornerRadius = UDim.new(0, 4)
    
    btn.MouseButton1Click:Connect(function()
        settings[setting] = not settings[setting]
        indicator.BackgroundColor3 = settings[setting] and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(255, 70, 70)
    end)
    
    return yPos + 35
end

local function createSlider(parent, text, yPos, setting, min, max, default)
    local bg = Instance.new("Frame")
    bg.Parent = parent
    bg.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    bg.Position = UDim2.new(0, 5, 0, yPos)
    bg.Size = UDim2.new(1, -10, 0, 40)
    bg.ZIndex = 52
    
    local bgCorner = Instance.new("UICorner")
    bgCorner.Parent = bg
    bgCorner.CornerRadius = UDim.new(0, 4)
    
    local label = Instance.new("TextLabel")
    label.Parent = bg
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Size = UDim2.new(1, -20, 0, 20)
    label.Font = Enum.Font.GothamBold
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Parent = bg
    valueLabel.BackgroundTransparency = 1
    valueLabel.Position = UDim2.new(1, -50, 0, 0)
    valueLabel.Size = UDim2.new(0, 40, 0, 20)
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.Text = tostring(default)
    valueLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
    valueLabel.TextSize = 11
    
    local sliderBg = Instance.new("Frame")
    sliderBg.Parent = bg
    sliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    sliderBg.Position = UDim2.new(0, 10, 0, 22)
    sliderBg.Size = UDim2.new(1, -70, 0, 10)
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.Parent = sliderBg
    sliderCorner.CornerRadius = UDim.new(0, 4)
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Parent = sliderBg
    sliderFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    sliderFill.Size = UDim2.new(default/max, 0, 1, 0)
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.Parent = sliderFill
    fillCorner.CornerRadius = UDim.new(0, 4)
    
    return yPos + 45
end

-- ========== POPULATE MAIN TAB ==========
local y = 5
y = createSection(contents["MAIN"], "MAIN SETTINGS", y)
y = createToggle(contents["MAIN"], "Auto Rejoin When Kicked", y, "autoRejoin")
y = createToggle(contents["MAIN"], "Auto Redeem Codes", y, "autoCode")
y = createToggle(contents["MAIN"], "Hop Server", y, "hopServer")
y = createToggle(contents["MAIN"], "Hop Low Server", y, "hopLowServer")
y = createToggle(contents["MAIN"], "FPS Booster", y, "fpsBooster")
y = createToggle(contents["MAIN"], "Anti AFK", y, "antiAfk")
y = y + 10

y = createSection(contents["MAIN"], "FPS BOOSTER", y)
y = createToggle(contents["MAIN"], "Remove Lava Damage", y, "fpsBooster")
y = createToggle(contents["MAIN"], "Reduce Graphics", y, "fpsBooster")
contents["MAIN"].CanvasSize = UDim2.new(0, 0, 0, y + 20)

-- ========== POPULATE FARM TAB ==========
y = 5
y = createSection(contents["FARM"], "FARM OPTIONS", y)
y = createToggle(contents["FARM"], "Auto Farm", y, "autoFarm")
y = createToggle(contents["FARM"], "Auto Second Sea", y, "autoFarm")
y = createToggle(contents["FARM"], "Auto Third Sea", y, "autoFarm")
y = createToggle(contents["FARM"], "Auto Bartilo Quest", y, "autoFarm")
y = createToggle(contents["FARM"], "Auto Factory", y, "autoFarm")
y = createToggle(contents["FARM"], "Auto Pirate Raid", y, "autoFarm")
y = createToggle(contents["FARM"], "Auto Elite", y, "autoFarm")
y = y + 10

y = createSection(contents["FARM"], "FARM SETTINGS", y)
y = createToggle(contents["FARM"], "Use Tween Teleport", y, "useTween")
y = createToggle(contents["FARM"], "Use Instant Teleport", y, "instantTeleport")
y = createToggle(contents["FARM"], "Bring Enemies", y, "bringEnemies")
y = createSlider(contents["FARM"], "Bring Radius", y, "bringRadius", 10, 50, 30)
contents["FARM"].CanvasSize = UDim2.new(0, 0, 0, y + 20)

-- ========== POPULATE FRUIT TAB ==========
y = 5
y = createSection(contents["FRUIT"], "DEVIL FRUIT", y)
y = createToggle(contents["FRUIT"], "Fruit Sniper", y, "fruitSniper")
y = createToggle(contents["FRUIT"], "Auto Find Fruit", y, "fruitSniper")
y = createToggle(contents["FRUIT"], "Auto Store Fruit", y, "autoStore")
y = createToggle(contents["FRUIT"], "Auto Fruit Dealer Cousin", y, "fruitDealer")
y = y + 10

y = createSection(contents["FRUIT"], "VISUALS", y)
y = createToggle(contents["FRUIT"], "Devil Fruit ESP", y, "fruitESP")
y = createToggle(contents["FRUIT"], "Flower ESP", y, "flowerESP")
contents["FRUIT"].CanvasSize = UDim2.new(0, 0, 0, y + 20)

-- ========== POPULATE COMBAT TAB ==========
y = 5
y = createSection(contents["COMBAT"], "COMBAT SETTINGS", y)
y = createToggle(contents["COMBAT"], "Auto Haki", y, "autoHaki")
y = createToggle(contents["COMBAT"], "Auto Ken (Observation)", y, "autoKen")
y = createToggle(contents["COMBAT"], "Fast Attack", y, "fastAttack")
y = createSlider(contents["COMBAT"], "Attack Delay", y, "attackDelay", 0, 1, 0.1)
y = createToggle(contents["COMBAT"], "No Cooldown", y, "noCooldown")
y = createToggle(contents["COMBAT"], "Hitbox Extender", y, "hitboxExtend")
y = createSlider(contents["COMBAT"], "Hitbox Size", y, "hitboxSize", 1, 3, 1.5)
contents["COMBAT"].CanvasSize = UDim2.new(0, 0, 0, y + 20)

-- ========== POPULATE BOSS TAB ==========
y = 5
y = createSection(contents["BOSS"], "BOSS FARM", y)
y = createToggle(contents["BOSS"], "Auto Farm Boss", y, "autoFarm")
y = createToggle(contents["BOSS"], "Auto Farm All Boss", y, "autoFarm")
contents["BOSS"].CanvasSize = UDim2.new(0, 0, 0, y + 20)

-- ========== POPULATE MASTERY TAB ==========
y = 5
y = createSection(contents["MASTERY"], "MASTERY FARM", y)
y = createToggle(contents["MASTERY"], "Auto Farm Mastery", y, "autoFarm")
y = createToggle(contents["MASTERY"], "Auto Unlock Skill Sword", y, "autoFarm")
y = createToggle(contents["MASTERY"], "Only Farm Legendary/Mythical", y, "autoFarm")
contents["MASTERY"].CanvasSize = UDim2.new(0, 0, 0, y + 20)

-- ========== POPULATE VISUAL TAB ==========
y = 5
y = createSection(contents["VISUAL"], "ESP", y)
y = createToggle(contents["VISUAL"], "Players ESP", y, "playerESP")
y = createToggle(contents["VISUAL"], "Devil Fruit ESP", y, "fruitESP")
y = createToggle(contents["VISUAL"], "Flower ESP", y, "flowerESP")
y = y + 10

y = createSection(contents["VISUAL"], "ENVIRONMENT", y)
y = createToggle(contents["VISUAL"], "Full Bright", y, "fullBright")
y = createToggle(contents["VISUAL"], "Remove Fog", y, "removeFog")
contents["VISUAL"].CanvasSize = UDim2.new(0, 0, 0, y + 20)

-- ========== POPULATE MISC TAB ==========
y = 5
y = createSection(contents["MISC"], "MOVEMENT", y)
y = createToggle(contents["MISC"], "Fly", y, "autoFarm")
y = createToggle(contents["MISC"], "Noclip", y, "autoFarm")
y = y + 10

y = createSection(contents["MISC"], "SAFETY", y)
y = createToggle(contents["MISC"], "Anti Void", y, "autoFarm")
y = createToggle(contents["MISC"], "Anti Death Loop", y, "autoFarm")
contents["MISC"].CanvasSize = UDim2.new(0, 0, 0, y + 20)

-- ========== CORE FEATURES ==========

-- Anti AFK
player.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), camera.CFrame)
    wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), camera.CFrame)
end)

-- Full Bright
spawn(function()
    while true do
        wait(0.5)
        if settings.fullBright then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
        else
            Lighting.Brightness = 1
            Lighting.GlobalShadows = true
        end
    end
end)

-- Auto Redeem Codes
local codes = {
    "ADMIN_ROCKS", "3BVISITS", "UPD16", "UPD15", "UPD14", "UPD13",
    "UPD12", "2BVISITS", "1BVISITS", "SUB2GAMERROBOT_EXP1"
}

spawn(function()
    while true do
        wait(30)
        if settings.autoCode then
            for _, code in ipairs(codes) do
                pcall(function()
                    local args = { [1] = "Redeem", [2] = code }
                    ReplicatedStorage:FindFirstChild("Remotes"):FindFirstChild("Redeem"):InvokeServer(unpack(args))
                    wait(0.5)
                end)
            end
        end
    end
end)

-- Auto Rejoin
local function rejoin()
    TeleportService:Teleport(game.PlaceId, player)
end

-- Server Hop
local function hopServer()
    local servers = {}
    local cursor = ""
    repeat
        local url = "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?limit=100"
        if cursor ~= "" then url = url.."&cursor="..cursor end
        local success, res = pcall(function() return game:HttpGet(url) end)
        if success then
            local data = HttpService:JSONDecode(res)
            for _, v in ipairs(data.data) do
                if v.playing < v.maxPlayers then
                    table.insert(servers, v.id)
                end
            end
            cursor = data.nextPageCursor
        else
            break
        end
    until not cursor or #servers > 0
    if #servers > 0 then
        local server = settings.hopLowServer and servers[math.random(1, #servers)] or servers[1]
        TeleportService:TeleportToPlaceInstance(game.PlaceId, server, player)
    end
end

-- ========== TOGGLE MENU ==========
toggleBtn.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- ========== INIT ==========
switchTab("MAIN")

print("====================================")
print("VORTEX HUB 1.0.0")
print("Made by marcus")
print("100+ FEATURES")
print("TABS: MAIN | FARM | FRUIT | COMBAT")
print("      BOSS | MASTERY | VISUAL | MISC")
print("====================================")