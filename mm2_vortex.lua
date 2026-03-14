-- ╔══════════════════════════════════════════════════════════════╗
-- ║           VORTEX HUB — MM2 SCRIPT v1.0                      ║
-- ║           Murder Mystery 2 | discord.gg/9EDSzchFpn          ║
-- ╚══════════════════════════════════════════════════════════════╝

local KEY = script_key or ""
if KEY ~= "trial" and KEY ~= "Trial" then
    warn("[VORTEX] Invalid key. Use key: trial")
    return
end

-- ══════════════════════════════════════════════════════
-- SERVICES
-- ══════════════════════════════════════════════════════
local Players         = game:GetService("Players")
local RunService      = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService    = game:GetService("TweenService")
local Workspace       = game:GetService("Workspace")
local CoreGui         = game:GetService("CoreGui")
local Lighting        = game:GetService("Lighting")
local Camera          = Workspace.CurrentCamera

local LP = Players.LocalPlayer
local LMouse = LP:GetMouse()

-- ══════════════════════════════════════════════════════
-- CONFIG (all toggles & settings)
-- ══════════════════════════════════════════════════════
local CFG = {
    -- ESP
    ESP_Enabled       = false,
    ESP_Boxes         = true,
    ESP_Names         = true,
    ESP_Distance      = true,
    ESP_Role          = true,
    ESP_Tracers       = false,
    ESP_MaxDist       = 500,

    -- AIMBOT
    Aimbot_Enabled    = false,
    Aimbot_FOV        = 120,
    Aimbot_Smooth     = 0.25,
    Aimbot_HitPart    = "Head",
    Aimbot_ShowFOV    = true,
    Aimbot_Prediction = false,

    -- MOVEMENT
    Speed_Enabled     = false,
    Speed_Value       = 32,
    NoClip_Enabled    = false,
    InfJump_Enabled   = false,
    FlyHack_Enabled   = false,
    Fly_Speed         = 50,
    Noclip_Enabled    = false,

    -- TELEPORT
    TP_Knife          = false,
    TP_Coins          = false,
    TP_Sheriff        = false,

    -- COINS
    AutoCoin_Enabled  = false,
    AutoCoin_Delay    = 0.1,

    -- VISUALS
    Fullbright        = false,
    NoFog             = false,
    CrosshairEnable   = false,

    -- MISC
    AntiAFK           = true,
    AutoWin_Murder    = false,
    AutoWin_Sheriff   = false,
    SpamChat          = false,
    SpamMsg           = "VORTEX HUB | discord.gg/9EDSzchFpn",
}

-- ══════════════════════════════════════════════════════
-- UTILITY
-- ══════════════════════════════════════════════════════
local function getChar()
    return LP.Character
end

local function getRoot()
    local c = getChar()
    return c and c:FindFirstChild("HumanoidRootPart")
end

local function getHRP(player)
    local c = player.Character
    return c and c:FindFirstChild("HumanoidRootPart")
end

local function getHum(player)
    local c = player.Character
    return c and c:FindFirstChildOfClass("Humanoid")
end

local function isAlive(player)
    local h = getHum(player)
    return h and h.Health > 0
end

local function distTo(pos)
    local root = getRoot()
    if not root then return math.huge end
    return (root.Position - pos).Magnitude
end

local function worldToVP(pos)
    local vp, onScreen = Camera:WorldToViewportPoint(pos)
    return Vector2.new(vp.X, vp.Y), onScreen, vp.Z
end

local function getRoleColor(player)
    -- MM2 role detection via tags/values
    local c = player.Character
    if not c then return Color3.fromRGB(255,255,255) end
    -- Attempt role detection
    local roleVal = LP:FindFirstChild("Role") or LP:FindFirstChild("PlayerGui") and LP.PlayerGui:FindFirstChild("Role")
    -- Fallback color coding by name comparison (sheriff/murderer are known in game)
    local name = player.Name
    -- Check common MM2 role indicators
    if c:FindFirstChild("Knife") then
        return Color3.fromRGB(255, 50, 50)   -- murderer = red
    elseif c:FindFirstChild("Gun") then
        return Color3.fromRGB(50, 150, 255)  -- sheriff = blue
    else
        return Color3.fromRGB(50, 255, 150)  -- innocent = green
    end
end

local function getRoleLabel(player)
    local c = player.Character
    if not c then return "?" end
    if c:FindFirstChild("Knife") then return "MURDERER"
    elseif c:FindFirstChild("Gun") then return "SHERIFF"
    else return "INNOCENT" end
end

-- ══════════════════════════════════════════════════════
-- GUI BUILDER
-- ══════════════════════════════════════════════════════
-- Clean up old instance
pcall(function()
    if CoreGui:FindFirstChild("VortexMM2") then
        CoreGui.VortexMM2:Destroy()
    end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VortexMM2"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LP.PlayerGui end

-- ── COLORS ──
local C = {
    BG       = Color3.fromRGB(4,   4,  14),
    Panel    = Color3.fromRGB(8,   8,  22),
    Card     = Color3.fromRGB(12, 12,  30),
    Rim      = Color3.fromRGB(22, 22,  60),
    Cyan     = Color3.fromRGB(0,  220, 255),
    Purple   = Color3.fromRGB(160, 50, 255),
    Green    = Color3.fromRGB(0,  220, 120),
    Red      = Color3.fromRGB(255, 50,  80),
    Yellow   = Color3.fromRGB(255, 200,  0),
    White    = Color3.fromRGB(220, 235, 255),
    Muted    = Color3.fromRGB(80,  90, 130),
    Text     = Color3.fromRGB(140, 160, 200),
}

-- ── HELPER FUNCTIONS ──
local function makeCorner(parent, radius)
    local c = Instance.new("UICorner", parent)
    c.CornerRadius = UDim.new(0, radius or 6)
    return c
end

local function makeStroke(parent, color, thickness)
    local s = Instance.new("UIStroke", parent)
    s.Color = color or C.Rim
    s.Thickness = thickness or 1
    return s
end

local function makePadding(parent, all)
    local p = Instance.new("UIPadding", parent)
    p.PaddingLeft   = UDim.new(0, all)
    p.PaddingRight  = UDim.new(0, all)
    p.PaddingTop    = UDim.new(0, all)
    p.PaddingBottom = UDim.new(0, all)
    return p
end

local function label(parent, text, size, color, font)
    local l = Instance.new("TextLabel", parent)
    l.Size = UDim2.new(1, 0, 0, size + 4)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextSize = size
    l.TextColor3 = color or C.Text
    l.Font = font or Enum.Font.GothamMedium
    l.TextXAlignment = Enum.TextXAlignment.Left
    return l
end

-- ── MAIN WINDOW ──
local Main = Instance.new("Frame", ScreenGui)
Main.Name = "Main"
Main.Size = UDim2.new(0, 540, 0, 420)
Main.Position = UDim2.new(0.5, -270, 0.5, -210)
Main.BackgroundColor3 = C.BG
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
makeCorner(Main, 8)
makeStroke(Main, C.Rim, 1)

-- Gradient top bar
local TopGrad = Instance.new("Frame", Main)
TopGrad.Size = UDim2.new(1, 0, 0, 2)
TopGrad.Position = UDim2.new(0, 0, 0, 0)
TopGrad.BackgroundColor3 = C.Cyan
TopGrad.BorderSizePixel = 0
makeCorner(TopGrad, 2)
local tg = Instance.new("UIGradient", TopGrad)
tg.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, C.Cyan),
    ColorSequenceKeypoint.new(0.5, C.Purple),
    ColorSequenceKeypoint.new(1, C.Cyan),
})

-- Title bar
local TitleBar = Instance.new("Frame", Main)
TitleBar.Size = UDim2.new(1, 0, 0, 44)
TitleBar.Position = UDim2.new(0, 0, 0, 2)
TitleBar.BackgroundColor3 = C.Panel
TitleBar.BorderSizePixel = 0

local TitleLabel = Instance.new("TextLabel", TitleBar)
TitleLabel.Size = UDim2.new(1, -100, 1, 0)
TitleLabel.Position = UDim2.new(0, 14, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "VORTEX HUB  //  MM2"
TitleLabel.TextSize = 13
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextColor3 = C.White
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local SubLabel = Instance.new("TextLabel", TitleBar)
SubLabel.Size = UDim2.new(0, 200, 1, 0)
SubLabel.Position = UDim2.new(1, -210, 0, 0)
SubLabel.BackgroundTransparency = 1
SubLabel.Text = "discord.gg/9EDSzchFpn"
SubLabel.TextSize = 10
SubLabel.Font = Enum.Font.Code
SubLabel.TextColor3 = C.Muted
SubLabel.TextXAlignment = Enum.TextXAlignment.Right

-- Close button
local CloseBtn = Instance.new("TextButton", TitleBar)
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -36, 0.5, -14)
CloseBtn.BackgroundColor3 = Color3.fromRGB(20, 8, 8)
CloseBtn.Text = "✕"
CloseBtn.TextSize = 12
CloseBtn.TextColor3 = C.Red
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
makeCorner(CloseBtn, 4)
makeStroke(CloseBtn, Color3.fromRGB(80, 20, 20), 1)

-- Minimize button
local MinBtn = Instance.new("TextButton", TitleBar)
MinBtn.Size = UDim2.new(0, 28, 0, 28)
MinBtn.Position = UDim2.new(1, -68, 0.5, -14)
MinBtn.BackgroundColor3 = Color3.fromRGB(10, 16, 8)
MinBtn.Text = "─"
MinBtn.TextSize = 12
MinBtn.TextColor3 = C.Green
MinBtn.Font = Enum.Font.GothamBold
MinBtn.BorderSizePixel = 0
makeCorner(MinBtn, 4)
makeStroke(MinBtn, Color3.fromRGB(20, 60, 20), 1)

-- ── TAB BAR ──
local TabBar = Instance.new("Frame", Main)
TabBar.Size = UDim2.new(0, 120, 1, -46)
TabBar.Position = UDim2.new(0, 0, 0, 46)
TabBar.BackgroundColor3 = C.Panel
TabBar.BorderSizePixel = 0

local TabLayout = Instance.new("UIListLayout", TabBar)
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Padding = UDim.new(0, 2)

makePadding(TabBar, 6)
makeStroke(TabBar, C.Rim, 1)

-- ── CONTENT AREA ──
local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -128, 1, -46)
Content.Position = UDim2.new(0, 124, 0, 46)
Content.BackgroundColor3 = C.BG
Content.BorderSizePixel = 0

-- ══════════════════════════════════════════════════════
-- TAB SYSTEM
-- ══════════════════════════════════════════════════════
local Tabs = {}
local TabPages = {}
local ActiveTab = nil

local TAB_DEFS = {
    {name = "ESP",       icon = "👁"},
    {name = "AIMBOT",    icon = "🎯"},
    {name = "MOVEMENT",  icon = "⚡"},
    {name = "TELEPORT",  icon = "🌀"},
    {name = "COINS",     icon = "🪙"},
    {name = "VISUALS",   icon = "🎨"},
    {name = "MISC",      icon = "⚙️"},
}

local function makeScrollFrame(parent)
    local scroll = Instance.new("ScrollingFrame", parent)
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 3
    scroll.ScrollBarImageColor3 = C.Cyan
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    local layout = Instance.new("UIListLayout", scroll)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    makePadding(scroll, 10)
    return scroll
end

local function selectTab(name)
    for n, btn in pairs(Tabs) do
        if n == name then
            btn.BackgroundColor3 = C.Card
            btn.TextColor3 = C.Cyan
            makeStroke(btn, C.Cyan, 1)
        else
            btn.BackgroundColor3 = Color3.fromRGB(0,0,0,0)
            btn.TextColor3 = C.Muted
            local s = btn:FindFirstChildOfClass("UIStroke")
            if s then s.Color = Color3.fromRGB(0,0,0,0) end
        end
    end
    for n, page in pairs(TabPages) do
        page.Visible = (n == name)
    end
    ActiveTab = name
end

for i, def in ipairs(TAB_DEFS) do
    local btn = Instance.new("TextButton", TabBar)
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.BackgroundTransparency = 1
    btn.Text = def.icon .. "  " .. def.name
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = C.Muted
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.BorderSizePixel = 0
    btn.LayoutOrder = i
    makeCorner(btn, 5)
    makePadding(btn, 8)
    makeStroke(btn, Color3.fromRGB(0,0,0,0), 1)

    local page = Instance.new("Frame", Content)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Name = def.name

    local scroll = makeScrollFrame(page)

    Tabs[def.name] = btn
    TabPages[def.name] = page
    TabPages[def.name].Scroll = scroll

    btn.MouseButton1Click:Connect(function()
        selectTab(def.name)
    end)
end

selectTab("ESP")

-- ══════════════════════════════════════════════════════
-- TOGGLE WIDGET
-- ══════════════════════════════════════════════════════
local function makeToggle(parent, title, desc, cfgKey, callback)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, 0, 0, 54)
    row.BackgroundColor3 = C.Card
    row.BorderSizePixel = 0
    makeCorner(row, 6)
    makeStroke(row, C.Rim, 1)

    local titleL = Instance.new("TextLabel", row)
    titleL.Size = UDim2.new(1, -60, 0, 20)
    titleL.Position = UDim2.new(0, 12, 0, 8)
    titleL.BackgroundTransparency = 1
    titleL.Text = title
    titleL.TextSize = 12
    titleL.Font = Enum.Font.GothamBold
    titleL.TextColor3 = C.White
    titleL.TextXAlignment = Enum.TextXAlignment.Left

    if desc then
        local descL = Instance.new("TextLabel", row)
        descL.Size = UDim2.new(1, -60, 0, 16)
        descL.Position = UDim2.new(0, 12, 0, 28)
        descL.BackgroundTransparency = 1
        descL.Text = desc
        descL.TextSize = 10
        descL.Font = Enum.Font.Gotham
        descL.TextColor3 = C.Muted
        descL.TextXAlignment = Enum.TextXAlignment.Left
    end

    -- Toggle pill
    local pill = Instance.new("Frame", row)
    pill.Size = UDim2.new(0, 40, 0, 20)
    pill.Position = UDim2.new(1, -52, 0.5, -10)
    pill.BackgroundColor3 = CFG[cfgKey] and C.Cyan or C.Rim
    pill.BorderSizePixel = 0
    makeCorner(pill, 10)

    local dot = Instance.new("Frame", pill)
    dot.Size = UDim2.new(0, 14, 0, 14)
    dot.Position = CFG[cfgKey] and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
    dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    dot.BorderSizePixel = 0
    makeCorner(dot, 7)

    local btn = Instance.new("TextButton", row)
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.ZIndex = 5

    btn.MouseButton1Click:Connect(function()
        CFG[cfgKey] = not CFG[cfgKey]
        local on = CFG[cfgKey]
        local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad)
        TweenService:Create(pill, tweenInfo, {BackgroundColor3 = on and C.Cyan or C.Rim}):Play()
        TweenService:Create(dot, tweenInfo, {
            Position = on and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
        }):Play()
        if callback then callback(on) end
    end)

    return row
end

-- ══════════════════════════════════════════════════════
-- SLIDER WIDGET
-- ══════════════════════════════════════════════════════
local function makeSlider(parent, title, minV, maxV, cfgKey, callback)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, 0, 0, 60)
    row.BackgroundColor3 = C.Card
    row.BorderSizePixel = 0
    makeCorner(row, 6)
    makeStroke(row, C.Rim, 1)

    local titleL = Instance.new("TextLabel", row)
    titleL.Size = UDim2.new(0.7, 0, 0, 20)
    titleL.Position = UDim2.new(0, 12, 0, 8)
    titleL.BackgroundTransparency = 1
    titleL.Text = title
    titleL.TextSize = 12
    titleL.Font = Enum.Font.GothamBold
    titleL.TextColor3 = C.White
    titleL.TextXAlignment = Enum.TextXAlignment.Left

    local valL = Instance.new("TextLabel", row)
    valL.Size = UDim2.new(0.3, -12, 0, 20)
    valL.Position = UDim2.new(0.7, 0, 0, 8)
    valL.BackgroundTransparency = 1
    valL.Text = tostring(CFG[cfgKey])
    valL.TextSize = 12
    valL.Font = Enum.Font.Code
    valL.TextColor3 = C.Cyan
    valL.TextXAlignment = Enum.TextXAlignment.Right

    local track = Instance.new("Frame", row)
    track.Size = UDim2.new(1, -24, 0, 4)
    track.Position = UDim2.new(0, 12, 0, 38)
    track.BackgroundColor3 = C.Rim
    track.BorderSizePixel = 0
    makeCorner(track, 2)

    local fill = Instance.new("Frame", track)
    fill.Size = UDim2.new((CFG[cfgKey] - minV) / (maxV - minV), 0, 1, 0)
    fill.BackgroundColor3 = C.Cyan
    fill.BorderSizePixel = 0
    makeCorner(fill, 2)

    local handle = Instance.new("Frame", track)
    handle.Size = UDim2.new(0, 12, 0, 12)
    handle.Position = UDim2.new((CFG[cfgKey] - minV) / (maxV - minV), -6, 0.5, -6)
    handle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    handle.BorderSizePixel = 0
    makeCorner(handle, 6)

    local sliding = false
    local btn = Instance.new("TextButton", track)
    btn.Size = UDim2.new(1, 0, 0, 20)
    btn.Position = UDim2.new(0, 0, 0.5, -10)
    btn.BackgroundTransparency = 1
    btn.Text = ""

    local function updateSlider(input)
        local pos = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
        local val = math.floor(minV + pos * (maxV - minV))
        CFG[cfgKey] = val
        valL.Text = tostring(val)
        fill.Size = UDim2.new(pos, 0, 1, 0)
        handle.Position = UDim2.new(pos, -6, 0.5, -6)
        if callback then callback(val) end
    end

    btn.MouseButton1Down:Connect(function() sliding = true end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then sliding = false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if sliding and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input)
        end
    end)
    btn.MouseButton1Down:Connect(function(x, y)
        local fakeInput = {Position = Vector3.new(x, y, 0)}
        updateSlider(fakeInput)
    end)

    return row
end

-- ══════════════════════════════════════════════════════
-- SECTION HEADER
-- ══════════════════════════════════════════════════════
local function makeHeader(parent, text)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, 0, 0, 24)
    row.BackgroundTransparency = 1

    local line = Instance.new("Frame", row)
    line.Size = UDim2.new(1, 0, 0, 1)
    line.Position = UDim2.new(0, 0, 0.5, 0)
    line.BackgroundColor3 = C.Rim
    line.BorderSizePixel = 0

    local bg = Instance.new("Frame", row)
    bg.Size = UDim2.new(0, #text * 7 + 20, 0, 18)
    bg.Position = UDim2.new(0, 0, 0.5, -9)
    bg.BackgroundColor3 = C.BG
    bg.BorderSizePixel = 0

    local lbl = Instance.new("TextLabel", bg)
    lbl.Size = UDim2.new(1, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = "// " .. text
    lbl.TextSize = 10
    lbl.Font = Enum.Font.Code
    lbl.TextColor3 = C.Cyan
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    return row
end

-- ══════════════════════════════════════════════════════
-- BUILD TABS
-- ══════════════════════════════════════════════════════

-- ── ESP TAB ──
local espScroll = TabPages["ESP"].Scroll
makeHeader(espScroll, "PLAYER ESP")
makeToggle(espScroll, "ESP Enabled",    "Show all players through walls",  "ESP_Enabled")
makeToggle(espScroll, "ESP Boxes",      "Draw box around players",         "ESP_Boxes")
makeToggle(espScroll, "ESP Names",      "Show player names",               "ESP_Names")
makeToggle(espScroll, "ESP Distance",   "Show distance to player",         "ESP_Distance")
makeToggle(espScroll, "ESP Role",       "Show MURDERER / SHERIFF / INNOCENT", "ESP_Role")
makeToggle(espScroll, "ESP Tracers",    "Draw lines from screen center",   "ESP_Tracers")
makeHeader(espScroll, "SETTINGS")
makeSlider(espScroll, "Max Distance",   50, 1000, "ESP_MaxDist")

-- ── AIMBOT TAB ──
local abScroll = TabPages["AIMBOT"].Scroll
makeHeader(abScroll, "AIMBOT")
makeToggle(abScroll, "Aimbot Enabled",  "Auto-aim at nearest target",      "Aimbot_Enabled")
makeToggle(abScroll, "Show FOV Circle", "Draw FOV circle on screen",       "Aimbot_ShowFOV")
makeToggle(abScroll, "Prediction",      "Lead moving targets",             "Aimbot_Prediction")
makeHeader(abScroll, "SETTINGS")
makeSlider(abScroll, "FOV Radius",      20, 500, "Aimbot_FOV")
makeSlider(abScroll, "Smoothness (x10)",1, 10,  "Aimbot_Smooth")

-- ── MOVEMENT TAB ──
local mvScroll = TabPages["MOVEMENT"].Scroll
makeHeader(mvScroll, "SPEED")
makeToggle(mvScroll, "Speed Hack",      "Move faster than normal",         "Speed_Enabled")
makeSlider(mvScroll, "Walk Speed",      16, 200, "Speed_Value")
makeHeader(mvScroll, "MOBILITY")
makeToggle(mvScroll, "Infinite Jump",   "Jump in the air infinitely",      "InfJump_Enabled")
makeToggle(mvScroll, "Fly Hack",        "Fly around freely (Q/E up/down)", "FlyHack_Enabled")
makeSlider(mvScroll, "Fly Speed",       10, 200, "Fly_Speed")
makeToggle(mvScroll, "NoClip",          "Walk through walls",              "NoClip_Enabled")

-- ── TELEPORT TAB ──
local tpScroll = TabPages["TELEPORT"].Scroll
makeHeader(tpScroll, "AUTO TELEPORT")
makeToggle(tpScroll, "Teleport to Knife","Auto TP to knife each round",    "TP_Knife")
makeToggle(tpScroll, "Teleport to Coins","Auto TP to nearest coin",        "TP_Coins")
makeToggle(tpScroll, "Teleport to Sheriff","TP to sheriff (murderer mode)","TP_Sheriff")

-- Player TP buttons
makeHeader(tpScroll, "PLAYER TELEPORT")
local tpNote = Instance.new("TextLabel", tpScroll)
tpNote.Size = UDim2.new(1, 0, 0, 30)
tpNote.BackgroundTransparency = 1
tpNote.Text = "Buttons appear for alive players"
tpNote.TextSize = 11
tpNote.Font = Enum.Font.Gotham
tpNote.TextColor3 = C.Muted
tpNote.TextXAlignment = Enum.TextXAlignment.Left

local tpPlayerFrame = Instance.new("Frame", tpScroll)
tpPlayerFrame.Size = UDim2.new(1, 0, 0, 10)
tpPlayerFrame.BackgroundTransparency = 1
tpPlayerFrame.AutomaticSize = Enum.AutomaticSize.Y
local tpLayout = Instance.new("UIListLayout", tpPlayerFrame)
tpLayout.Padding = UDim.new(0, 4)

-- Refresh player TP buttons
local function refreshTPButtons()
    for _, c in ipairs(tpPlayerFrame:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and isAlive(p) then
            local btn = Instance.new("TextButton", tpPlayerFrame)
            btn.Size = UDim2.new(1, 0, 0, 32)
            btn.BackgroundColor3 = C.Card
            btn.Text = "  TP → " .. p.Name
            btn.TextSize = 11
            btn.Font = Enum.Font.GothamBold
            btn.TextColor3 = C.White
            btn.TextXAlignment = Enum.TextXAlignment.Left
            btn.BorderSizePixel = 0
            makeCorner(btn, 5)
            makeStroke(btn, C.Rim, 1)
            btn.MouseButton1Click:Connect(function()
                local root = getRoot()
                local hrp = getHRP(p)
                if root and hrp then
                    root.CFrame = hrp.CFrame + Vector3.new(0, 3, 0)
                end
            end)
        end
    end
end

-- Refresh button
local refBtn = Instance.new("TextButton", tpScroll)
refBtn.Size = UDim2.new(1, 0, 0, 32)
refBtn.BackgroundColor3 = Color3.fromRGB(8, 20, 8)
refBtn.Text = "↻  Refresh Player List"
refBtn.TextSize = 11
refBtn.Font = Enum.Font.GothamBold
refBtn.TextColor3 = C.Green
refBtn.BorderSizePixel = 0
makeCorner(refBtn, 5)
makeStroke(refBtn, Color3.fromRGB(20, 60, 20), 1)
refBtn.MouseButton1Click:Connect(refreshTPButtons)
refreshTPButtons()

-- ── COINS TAB ──
local coinScroll = TabPages["COINS"].Scroll
makeHeader(coinScroll, "AUTO COLLECT")
makeToggle(coinScroll, "Auto Collect Coins", "Automatically collect all coins", "AutoCoin_Enabled")
makeSlider(coinScroll, "Collect Delay (ms)", 1, 20, "AutoCoin_Delay")

-- Coin counter
local coinCount = 0
local coinLabel = Instance.new("TextLabel", coinScroll)
coinLabel.Size = UDim2.new(1, 0, 0, 40)
coinLabel.BackgroundColor3 = C.Card
coinLabel.Text = "Coins collected this session: 0"
coinLabel.TextSize = 12
coinLabel.Font = Enum.Font.Code
coinLabel.TextColor3 = C.Yellow
coinLabel.BorderSizePixel = 0
makeCorner(coinLabel, 6)
makeStroke(coinLabel, C.Rim, 1)

-- ── VISUALS TAB ──
local visScroll = TabPages["VISUALS"].Scroll
makeHeader(visScroll, "WORLD VISUALS")
makeToggle(visScroll, "Fullbright",     "Remove all darkness from map",    "Fullbright", function(on)
    Lighting.Brightness = on and 10 or 1
    Lighting.GlobalShadows = not on
    Lighting.FogEnd = on and 100000 or 100000
end)
makeToggle(visScroll, "No Fog",         "Disable all fog effects",         "NoFog", function(on)
    Lighting.FogEnd = on and 100000 or 1000
end)
makeToggle(visScroll, "Crosshair",      "Show custom crosshair on screen", "CrosshairEnable")

-- ── MISC TAB ──
local miscScroll = TabPages["MISC"].Scroll
makeHeader(miscScroll, "UTILITY")
makeToggle(miscScroll, "Anti-AFK",      "Prevent auto-kick for AFK",       "AntiAFK")
makeToggle(miscScroll, "Spam Chat",     "Spam chat with a message",        "SpamChat")

makeHeader(miscScroll, "GAME")
makeToggle(miscScroll, "Auto Win (Murder)","Auto kill innocents as murderer","AutoWin_Murder")
makeToggle(miscScroll, "Auto Win (Sheriff)","Auto shoot murderer as sheriff","AutoWin_Sheriff")

-- Rejoin button
local rejoinBtn = Instance.new("TextButton", miscScroll)
rejoinBtn.Size = UDim2.new(1, 0, 0, 36)
rejoinBtn.BackgroundColor3 = Color3.fromRGB(8, 8, 22)
rejoinBtn.Text = "⟳  Rejoin Server"
rejoinBtn.TextSize = 12
rejoinBtn.Font = Enum.Font.GothamBold
rejoinBtn.TextColor3 = C.Cyan
rejoinBtn.BorderSizePixel = 0
makeCorner(rejoinBtn, 6)
makeStroke(rejoinBtn, C.Rim, 1)
rejoinBtn.MouseButton1Click:Connect(function()
    local TeleportService = game:GetService("TeleportService")
    TeleportService:Teleport(game.PlaceId, LP)
end)

-- Copy Discord button
local dcBtn = Instance.new("TextButton", miscScroll)
dcBtn.Size = UDim2.new(1, 0, 0, 36)
dcBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 30)
dcBtn.Text = "💬  discord.gg/9EDSzchFpn"
dcBtn.TextSize = 12
dcBtn.Font = Enum.Font.GothamBold
dcBtn.TextColor3 = Color3.fromRGB(140, 148, 255)
dcBtn.BorderSizePixel = 0
makeCorner(dcBtn, 6)
makeStroke(dcBtn, Color3.fromRGB(40, 40, 100), 1)

-- ══════════════════════════════════════════════════════
-- WINDOW CONTROLS
-- ══════════════════════════════════════════════════════
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    Content.Visible = not minimized
    TabBar.Visible = not minimized
    Main.Size = minimized and UDim2.new(0, 540, 0, 46) or UDim2.new(0, 540, 0, 420)
    MinBtn.Text = minimized and "+" or "─"
end)

-- ══════════════════════════════════════════════════════
-- HOTKEY: INSERT to toggle GUI
-- ══════════════════════════════════════════════════════
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.Insert or input.KeyCode == Enum.KeyCode.RightControl then
        Main.Visible = not Main.Visible
    end
end)

-- ══════════════════════════════════════════════════════
-- ESP DRAWING
-- ══════════════════════════════════════════════════════
local ESPObjects = {}

local function clearESP()
    for _, t in pairs(ESPObjects) do
        if t.Box then t.Box:Remove() end
        if t.Name then t.Name:Remove() end
        if t.Dist then t.Dist:Remove() end
        if t.Role then t.Role:Remove() end
        if t.Tracer then t.Tracer:Remove() end
    end
    ESPObjects = {}
end

local function getESP(player)
    if not ESPObjects[player] then
        local box = Drawing.new("Square")
        box.Filled = false
        box.Thickness = 1.5
        box.Visible = false

        local nameD = Drawing.new("Text")
        nameD.Size = 13
        nameD.Center = true
        nameD.Outline = true
        nameD.Visible = false

        local distD = Drawing.new("Text")
        distD.Size = 11
        distD.Center = true
        distD.Outline = true
        distD.Visible = false

        local roleD = Drawing.new("Text")
        roleD.Size = 12
        roleD.Center = true
        roleD.Outline = true
        roleD.Visible = false

        local tracer = Drawing.new("Line")
        tracer.Thickness = 1
        tracer.Visible = false

        ESPObjects[player] = {
            Box = box, Name = nameD, Dist = distD,
            Role = roleD, Tracer = tracer
        }
    end
    return ESPObjects[player]
end

-- ══════════════════════════════════════════════════════
-- AIMBOT FOV CIRCLE
-- ══════════════════════════════════════════════════════
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1.5
FOVCircle.Color = Color3.fromRGB(0, 220, 255)
FOVCircle.Filled = false
FOVCircle.Transparency = 0.6
FOVCircle.Visible = false

-- ══════════════════════════════════════════════════════
-- CROSSHAIR
-- ══════════════════════════════════════════════════════
local CHLines = {}
for i = 1, 4 do
    local l = Drawing.new("Line")
    l.Thickness = 1.5
    l.Color = Color3.fromRGB(0, 255, 100)
    l.Visible = false
    CHLines[i] = l
end

-- ══════════════════════════════════════════════════════
-- MAIN LOOP
-- ══════════════════════════════════════════════════════
local coinTimer = 0

RunService.RenderStepped:Connect(function(dt)
    local myChar = getChar()
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    local vp = Camera.ViewportSize

    -- ── SPEED HACK ──
    if CFG.Speed_Enabled and myChar then
        local hum = myChar:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = CFG.Speed_Value end
    end

    -- ── INFINITE JUMP ──
    if CFG.InfJump_Enabled and myChar then
        local hum = myChar:FindFirstChildOfClass("Humanoid")
        if hum and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end

    -- ── NOCLIP ──
    if CFG.NoClip_Enabled and myChar then
        for _, part in ipairs(myChar:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end

    -- ── FLY HACK ──
    if CFG.FlyHack_Enabled and myRoot then
        local bv = myRoot:FindFirstChild("VortexFly")
        if not bv then
            bv = Instance.new("BodyVelocity", myRoot)
            bv.Name = "VortexFly"
            bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        end
        local vel = Vector3.new()
        local speed = CFG.Fly_Speed
        local cf = Camera.CFrame
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel = vel + cf.LookVector * speed end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel = vel - cf.LookVector * speed end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel = vel - cf.RightVector * speed end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel = vel + cf.RightVector * speed end
        if UserInputService:IsKeyDown(Enum.KeyCode.E) then vel = vel + Vector3.new(0, speed, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.Q) then vel = vel - Vector3.new(0, speed, 0) end
        bv.Velocity = vel
    else
        if myRoot then
            local bv = myRoot:FindFirstChild("VortexFly")
            if bv then bv:Destroy() end
        end
    end

    -- ── AUTO COLLECT COINS ──
    coinTimer = coinTimer + dt
    if CFG.AutoCoin_Enabled and coinTimer >= CFG.AutoCoin_Delay and myRoot then
        coinTimer = 0
        local coins = Workspace:FindFirstChild("Coins") or Workspace:FindFirstChild("Drops")
        if coins then
            for _, coin in ipairs(coins:GetChildren()) do
                if coin:IsA("BasePart") or coin:IsA("Model") then
                    local coinPos = coin:IsA("Model") and (coin.PrimaryPart and coin.PrimaryPart.Position) or coin.Position
                    if coinPos and (myRoot.Position - coinPos).Magnitude < 200 then
                        myRoot.CFrame = CFrame.new(coinPos + Vector3.new(0, 2, 0))
                        coinCount = coinCount + 1
                        coinLabel.Text = "Coins collected this session: " .. coinCount
                        task.wait(0.05)
                        break
                    end
                end
            end
        end
    end

    -- ── TELEPORT TO KNIFE ──
    if CFG.TP_Knife and myRoot then
        local knife = Workspace:FindFirstChild("Knife") or Workspace:FindFirstChildWhichIsA("Tool")
        if knife then
            local kPos = knife:IsA("Model") and (knife.PrimaryPart and knife.PrimaryPart.Position) or knife.Position
            if kPos then
                myRoot.CFrame = CFrame.new(kPos + Vector3.new(0, 3, 0))
            end
        end
    end

    -- ── ESP + AIMBOT ──
    local nearest = nil
    local nearestDist = math.huge
    local screenCenter = Vector2.new(vp.X / 2, vp.Y / 2)

    for _, player in ipairs(Players:GetPlayers()) do
        if player == LP then continue end
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local head = char and char:FindFirstChild("Head")
        local hum = char and char:FindFirstChildOfClass("Humanoid")

        local esp = getESP(player)
        local alive = hum and hum.Health > 0

        if not (hrp and alive and CFG.ESP_Enabled) then
            esp.Box.Visible = false
            esp.Name.Visible = false
            esp.Dist.Visible = false
            esp.Role.Visible = false
            esp.Tracer.Visible = false
            continue
        end

        local dist = distTo(hrp.Position)
        if dist > CFG.ESP_MaxDist then
            esp.Box.Visible = false
            esp.Name.Visible = false
            esp.Dist.Visible = false
            esp.Role.Visible = false
            esp.Tracer.Visible = false
            continue
        end

        local color = getRoleColor(player)
        local roleLabel = getRoleLabel(player)

        -- Box ESP
        local topPos, topVis = worldToVP(hrp.Position + Vector3.new(0, 3, 0))
        local botPos = worldToVP(hrp.Position - Vector3.new(0, 3, 0))
        local height = math.abs(topPos.Y - botPos.Y)
        local width = height * 0.55

        if topVis and CFG.ESP_Boxes then
            esp.Box.Position = Vector2.new(topPos.X - width / 2, topPos.Y)
            esp.Box.Size = Vector2.new(width, height)
            esp.Box.Color = color
            esp.Box.Visible = true
        else
            esp.Box.Visible = false
        end

        -- Name
        if topVis and CFG.ESP_Names then
            esp.Name.Position = Vector2.new(topPos.X, topPos.Y - 16)
            esp.Name.Text = player.Name
            esp.Name.Color = color
            esp.Name.Visible = true
        else
            esp.Name.Visible = false
        end

        -- Distance
        if topVis and CFG.ESP_Distance then
            esp.Dist.Position = Vector2.new(topPos.X, botPos.Y + 4)
            esp.Dist.Text = math.floor(dist) .. " studs"
            esp.Dist.Color = Color3.fromRGB(180, 180, 180)
            esp.Dist.Visible = true
        else
            esp.Dist.Visible = false
        end

        -- Role
        if topVis and CFG.ESP_Role then
            esp.Role.Position = Vector2.new(topPos.X, topPos.Y - 30)
            esp.Role.Text = "[" .. roleLabel .. "]"
            esp.Role.Color = color
            esp.Role.Visible = true
        else
            esp.Role.Visible = false
        end

        -- Tracer
        if topVis and CFG.ESP_Tracers then
            esp.Tracer.From = Vector2.new(vp.X / 2, vp.Y)
            esp.Tracer.To = topPos
            esp.Tracer.Color = color
            esp.Tracer.Visible = true
        else
            esp.Tracer.Visible = false
        end

        -- Aimbot nearest
        if CFG.Aimbot_Enabled and topVis then
            local screenDist = (topPos - screenCenter).Magnitude
            if screenDist < CFG.Aimbot_FOV and screenDist < nearestDist then
                nearestDist = screenDist
                nearest = player
            end
        end
    end

    -- ── AIMBOT ──
    if CFG.Aimbot_ShowFOV then
        FOVCircle.Position = screenCenter
        FOVCircle.Radius = CFG.Aimbot_FOV
        FOVCircle.Visible = true
    else
        FOVCircle.Visible = false
    end

    if CFG.Aimbot_Enabled and nearest then
        local char = nearest.Character
        local target = char and char:FindFirstChild(CFG.Aimbot_HitPart)
        if target then
            local pos = target.Position
            if CFG.Aimbot_Prediction then
                local vel = target.Velocity
                pos = pos + vel * 0.1
            end
            Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, pos)
        end
    end

    -- ── CROSSHAIR ──
    local cx, cy = vp.X / 2, vp.Y / 2
    local cs = 10
    if CFG.CrosshairEnable then
        CHLines[1].From = Vector2.new(cx - cs, cy); CHLines[1].To = Vector2.new(cx - 3, cy); CHLines[1].Visible = true
        CHLines[2].From = Vector2.new(cx + 3, cy);  CHLines[2].To = Vector2.new(cx + cs, cy); CHLines[2].Visible = true
        CHLines[3].From = Vector2.new(cx, cy - cs); CHLines[3].To = Vector2.new(cx, cy - 3); CHLines[3].Visible = true
        CHLines[4].From = Vector2.new(cx, cy + 3);  CHLines[4].To = Vector2.new(cx, cy + cs); CHLines[4].Visible = true
    else
        for _, l in ipairs(CHLines) do l.Visible = false end
    end
end)

-- ══════════════════════════════════════════════════════
-- ANTI-AFK
-- ══════════════════════════════════════════════════════
local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    if CFG.AntiAFK then
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end
end)

-- ══════════════════════════════════════════════════════
-- SPAM CHAT
-- ══════════════════════════════════════════════════════
task.spawn(function()
    while task.wait(3) do
        if CFG.SpamChat then
            local ok, err = pcall(function()
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(CFG.SpamMsg, "All")
            end)
        end
    end
end)

-- ══════════════════════════════════════════════════════
-- CLEANUP on destroy
-- ══════════════════════════════════════════════════════
ScreenGui.AncestryChanged:Connect(function()
    clearESP()
    FOVCircle:Remove()
    for _, l in ipairs(CHLines) do l:Remove() end
end)

print("╔════════════════════════════════════════╗")
print("║  VORTEX HUB — MM2 Script Loaded        ║")
print("║  INSERT or RIGHT CTRL to toggle GUI    ║")
print("║  discord.gg/9EDSzchFpn                 ║")
print("╚════════════════════════════════════════╝")
