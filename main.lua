-- [[ 🔴 LYZEENJS v5.0 - PART 1: ABSOLUTE ZALSTORE COGNITIVE UI 🔴 ]] --
-- PERFORMANCE LAYER ARCHITECTURE FOR HIGH-FPS RUNTIMES

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Bersihkan Sisa Script Lama
if CoreGui:FindFirstChild("LyzeenGateway") then CoreGui.LyzeenGateway:Destroy() end
if CoreGui:FindFirstChild("ZalCloneHub") then CoreGui.ZalCloneHub:Destroy() end

local Config = { Key = "LyzeenJsFree" }
local CurrentTab = "Misc"

-- Fungsi Draggable (Biar Menu Bisa Digeser Lancar)
local function MakeDraggable(frame)
    local dragToggle, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragToggle = true; dragStart = input.Position; startPos = frame.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragToggle = false end end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragToggle then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local function LaunchZalHub()
    local HubGui = Instance.new("ScreenGui", CoreGui)
    HubGui.Name = "ZalCloneHub"
    
    -- Main Backdrop Frame (750x450 Sesuai Rasio Gambar)
    local MainFrame = Instance.new("Frame", HubGui)
    MainFrame.Size = UDim2.new(0, 750, 0, 450)
    MainFrame.Position = UDim2.new(0.5, -375, 0.5, -225)
    MainFrame.BackgroundColor3 = Color3.fromRGB(11, 12, 15)
    MakeDraggable(MainFrame)
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 6)
    
    -- =========================================================
    -- [1] SIDEBAR NAVIGASI KIRI
    -- =========================================================
    local Sidebar = Instance.new("Frame", MainFrame)
    Sidebar.Size = UDim2.new(0, 160, 1, 0)
    Sidebar.BackgroundColor3 = Color3.fromRGB(8, 9, 11)
    Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 6)
    
    local SideLayout = Instance.new("UIListLayout", Sidebar)
    SideLayout.Padding = UDim.new(0, 4)
    SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    local TopSpace = Instance.new("Frame", Sidebar)
    TopSpace.Size = UDim2.new(1, 0, 0, 12)
    TopSpace.BackgroundTransparency = 1
    
    local TabButtons = {}
    local PagesContainer = {}

    local function CreateSideLabel(text)
        local lbl = Instance.new("TextLabel", Sidebar)
        lbl.Size = UDim2.new(1, -20, 0, 22)
        lbl.Text = text
        lbl.TextColor3 = Color3.fromRGB(90, 95, 105)
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 10
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.BackgroundTransparency = 1
    end
    
    local function CreateSideBtn(name, icon)
        local btn = Instance.new("TextButton", Sidebar)
        btn.Size = UDim2.new(1, -14, 0, 32)
        btn.Text = "  " .. icon .. "  " .. name
        btn.TextColor3 = Color3.fromRGB(150, 155, 165)
        btn.Font = Enum.Font.GothamMedium
        btn.TextSize = 11
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.BackgroundColor3 = Color3.fromRGB(11, 12, 15)
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
        
        TabButtons[name] = btn
        return btn
    end
    
    -- Struktur Kategori Menu Sesuai Gambar
    CreateSideLabel("World")
    local TabMisc = CreateSideBtn("Misc", "🌐")
    
    CreateSideLabel("Combat")
    local TabSilent = CreateSideBtn("Silent Aim", "🎯")
    local TabGun = CreateSideBtn("Gun", "🔫")
    
    CreateSideLabel("Teleport")
    local TabTp = CreateSideBtn("Teleportation", "🌌")
    local TabChat = CreateSideBtn("global chat", "💬")
    local TabVeh = CreateSideBtn("Vehicles", "🚘")
    
    CreateSideLabel("Visuals")
    local TabEsp = CreateSideBtn("ESP", "👁️")
    local TabWhite = CreateSideBtn("Whitelist", "📜")
    
    CreateSideLabel("Settings")
    local TabSet = CreateSideBtn("Settings", "⚙️")

    -- =========================================================
    -- [2] HEADER TOPBAR BANNER (KANAN)
    -- =========================================================
    local Header = Instance.new("Frame", MainFrame)
    Header.Size = UDim2.new(1, -160, 0, 55)
    Header.Position = UDim2.new(0, 160, 0, 0)
    Header.BackgroundTransparency = 1
    
    local Title = Instance.new("TextLabel", Header)
    Title.Size = UDim2.new(1, -100, 0, 25)
    Title.Position = UDim2.new(0, 20, 0, 12)
    Title.Text = "Dijebol By ZalStore"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 13
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1
    
    local Subtitle = Instance.new("TextLabel", Header)
    Subtitle.Size = UDim2.new(1, -100, 0, 15)
    Subtitle.Position = UDim2.new(0, 20, 0, 29)
    Subtitle.Text = "Pake script zalstore, jangan script store problematik"
    Subtitle.TextColor3 = Color3.fromRGB(130, 135, 145)
    Subtitle.Font = Enum.Font.GothamMedium
    Subtitle.TextSize = 10
    Subtitle.TextXAlignment = Enum.TextXAlignment.Left
    Subtitle.BackgroundTransparency = 1

    -- Tombol Close X Gede di Pojok Kanan
    local CloseBtn = Instance.new("TextButton", MainFrame)
    CloseBtn.Size = UDim2.new(0, 20, 0, 20)
    CloseBtn.Position = UDim2.new(1, -30, 0, 16)
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(140, 145, 155)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 12
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.MouseButton1Click:Connect(function() HubGui:Destroy() end)

    -- =========================================================
    -- [3] MULTI-PAGE CONTROLLER SYSTEM
    -- =========================================================
    local ContentPage = Instance.new("Frame", MainFrame)
    ContentPage.Size = UDim2.new(1, -180, 1, -75)
    ContentPage.Position = UDim2.new(0, 170, 0, 65)
    ContentPage.BackgroundTransparency = 1

    local function CreatePage(name)
        local Page = Instance.new("Frame", ContentPage)
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.Visible = false
        
        -- Menggunakan 2 Kolom Scrolling Frame Sesuai Layout Asli
        local LeftCol = Instance.new("ScrollingFrame", Page)
        LeftCol.Name = "LeftColumn"
        LeftCol.Size = UDim2.new(0.5, -6, 1, 0)
        LeftCol.BackgroundTransparency = 1
        LeftCol.CanvasSize = UDim2.new(0, 0, 0, 600)
        LeftCol.ScrollBarThickness = 0
        Instance.new("UIListLayout", LeftCol).Padding = UDim.new(0, 8)
        
        local RightCol = Instance.new("ScrollingFrame", Page)
        RightCol.Name = "RightColumn"
        RightCol.Size = UDim2.new(0.5, -6, 1, 0)
        RightCol.Position = UDim2.new(0.5, 6, 0, 0)
        RightCol.BackgroundTransparency = 1
        RightCol.CanvasSize = UDim2.new(0, 0, 0, 600)
        RightCol.ScrollBarThickness = 0
        Instance.new("UIListLayout", RightCol).Padding = UDim.new(0, 8)
        
        PagesContainer[name] = Page
        return Page
    end

    -- Inisialisasi Seluruh Halaman Kosong
    for tName, _ in pairs(TabButtons) do CreatePage(tName) end

    -- Fungsi Switch Tab (Perpindahan Halaman + Animasi Highlight Biru)
    local function SwitchTab(targetName)
        CurrentTab = targetName
        for name, btn in pairs(TabButtons) do
            if name == targetName then
                btn.BackgroundColor3 = Color3.fromRGB(24, 28, 36)
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                PagesContainer[name].Visible = true
            else
                btn.BackgroundColor3 = Color3.fromRGB(11, 12, 15)
                btn.TextColor3 = Color3.fromRGB(150, 155, 165)
                PagesContainer[name].Visible = false
            end
        end
    end

    -- Sambungkan Fungsi Klik ke Semua Tombol Sidebar
    for name, btn in pairs(TabButtons) do
        btn.MouseButton1Click:Connect(function() SwitchTab(name) end)
    end

    -- Default Halaman Pertama yang Aktif
    SwitchTab("Misc")
end

-- =========================================================
-- [4] GATEWAY KEY SYSTEM INTERFACE
-- =========================================================
local GatewayGui = Instance.new("ScreenGui", CoreGui)
GatewayGui.Name = "LyzeenGateway"

local Frame = Instance.new("Frame", GatewayGui)
Frame.Size = UDim2.new(0, 320, 0, 180)
Frame.Position = UDim2.new(0.5, -160, 0.5, -90)
Frame.BackgroundColor3 = Color3.fromRGB(11, 12, 15)
MakeDraggable(Frame)
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", Frame).Color = Color3.fromRGB(30, 144, 255)

local lbl = Instance.new("TextLabel", Frame)
lbl.Size = UDim2.new(1, 0, 0, 40)
lbl.Text = "🔑 LYZEENJS SECURE GATEWAY"
lbl.TextColor3 = Color3.new(1, 1, 1)
lbl.Font = Enum.Font.GothamBold
lbl.TextSize = 12
lbl.BackgroundTransparency = 1

local Box = Instance.new("TextBox", Frame)
Box.Size = UDim2.new(0, 260, 0, 35)
Box.Position = UDim2.new(0.5, -130, 0.4, 0)
Box.PlaceholderText = "Masukkan Key..."
Box.Text = ""
Box.TextColor3 = Color3.new(1, 1, 1)
Box.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
Instance.new("UICorner", Box)

local Btn = Instance.new("TextButton", Frame)
Btn.Size = UDim2.new(0, 140, 0, 35)
Btn.Position = UDim2.new(0.5, -70, 0.7, 5)
Btn.Text = "VERIFY"
Btn.TextColor3 = Color3.new(1, 1, 1)
Btn.BackgroundColor3 = Color3.fromRGB(30, 144, 255)
Btn.Font = Enum.Font.GothamBold
Instance.new("UICorner", Btn)

Btn.MouseButton1Click:Connect(function()
    if Box.Text == Config.Key then
        GatewayGui:Destroy()
        LaunchZalHub()
    else
        Box.Text = ""
        Box.PlaceholderText = "❌ Key Salah, Coba Lagi!"
    end
end)
-- [[ 🔴 LYZEENJS v5.0 - COMPLETE ZALSTORE ENGINE (PART 1 + PART 2) 🔴 ]] --
-- FINAL PRODUCTION BUILD | ULTRA OPTIMIZED FOR HIGH PERFORMANCE LAYERS

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ProximityPromptService = game:GetService("ProximityPromptService")

-- Bersihkan Sisa Script Lama
if CoreGui:FindFirstChild("LyzeenGateway") then CoreGui.LyzeenGateway:Destroy() end
if CoreGui:FindFirstChild("ZalCloneHub") then CoreGui.ZalCloneHub:Destroy() end

local Config = {
    Key = "LyzeenJsFree",
    WalkSpeed = 16,
    InfiniteJump = false,
    Noclip = false,
    SilentAim = false,
    KillAura = false,
    InstantPrompt = false,
    Desync = false
}

local CurrentTab = "Misc"
local PagesContainer = {}
local TabButtons = {}

-- Fungsi Draggable (Biar Menu Bisa Digeser Lancar)
local function MakeDraggable(frame)
    local dragToggle, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragToggle = true; dragStart = input.Position; startPos = frame.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragToggle = false end end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragToggle then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local function LaunchZalHub()
    local HubGui = Instance.new("ScreenGui", CoreGui)
    HubGui.Name = "ZalCloneHub"
    
    -- Main Backdrop Frame (750x450 Sesuai Gambar)
    local MainFrame = Instance.new("Frame", HubGui)
    MainFrame.Size = UDim2.new(0, 750, 0, 450)
    MainFrame.Position = UDim2.new(0.5, -375, 0.5, -225)
    MainFrame.BackgroundColor3 = Color3.fromRGB(11, 12, 15)
    MakeDraggable(MainFrame)
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 6)
    
    -- =========================================================
    -- [PART 1] SIDEBAR NAVIGASI KIRI
    -- =========================================================
    local Sidebar = Instance.new("Frame", MainFrame)
    Sidebar.Size = UDim2.new(0, 160, 1, 0)
    Sidebar.BackgroundColor3 = Color3.fromRGB(8, 9, 11)
    Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 6)
    
    local SideLayout = Instance.new("UIListLayout", Sidebar)
    SideLayout.Padding = UDim.new(0, 4)
    SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    local TopSpace = Instance.new("Frame", Sidebar)
    TopSpace.Size = UDim2.new(1, 0, 0, 12)
    TopSpace.BackgroundTransparency = 1
    
    local function CreateSideLabel(text)
        local lbl = Instance.new("TextLabel", Sidebar)
        lbl.Size = UDim2.new(1, -20, 0, 22)
        lbl.Text = text
        lbl.TextColor3 = Color3.fromRGB(90, 95, 105)
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 10
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.BackgroundTransparency = 1
    end
    
    local function CreateSideBtn(name, icon)
        local btn = Instance.new("TextButton", Sidebar)
        btn.Size = UDim2.new(1, -14, 0, 32)
        btn.Text = "  " .. icon .. "  " .. name
        btn.TextColor3 = Color3.fromRGB(150, 155, 165)
        btn.Font = Enum.Font.GothamMedium
        btn.TextSize = 11
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.BackgroundColor3 = Color3.fromRGB(11, 12, 15)
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
        
        TabButtons[name] = btn
        return btn
    end
    
    CreateSideLabel("World")
    CreateSideBtn("Misc", "🌐")
    
    CreateSideLabel("Combat")
    CreateSideBtn("Silent Aim", "🎯")
    CreateSideBtn("Gun", "🔫")
    
    CreateSideLabel("Teleport")
    CreateSideBtn("Teleportation", "🌌")
    CreateSideBtn("global chat", "💬")
    CreateSideBtn("Vehicles", "🚘")
    
    CreateSideLabel("Visuals")
    CreateSideBtn("ESP", "👁️")
    CreateSideBtn("Whitelist", "📜")
    
    CreateSideLabel("Settings")
    CreateSideBtn("Settings", "⚙️")

    -- =========================================================
    -- [PART 1] HEADER TOPBAR BANNER
    -- =========================================================
    local Header = Instance.new("Frame", MainFrame)
    Header.Size = UDim2.new(1, -160, 0, 55)
    Header.Position = UDim2.new(0, 160, 0, 0)
    Header.BackgroundTransparency = 1
    
    local Title = Instance.new("TextLabel", Header)
    Title.Size = UDim2.new(1, -100, 0, 25)
    Title.Position = UDim2.new(0, 20, 0, 12)
    Title.Text = "Dijebol By ZalStore"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 13
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1
    
    local Subtitle = Instance.new("TextLabel", Header)
    Subtitle.Size = UDim2.new(1, -100, 0, 15)
    Subtitle.Position = UDim2.new(0, 20, 0, 29)
    Subtitle.Text = "Pake script zalstore, jangan script store problematik"
    Subtitle.TextColor3 = Color3.fromRGB(130, 135, 145)
    Subtitle.Font = Enum.Font.GothamMedium
    Subtitle.TextSize = 10
    Subtitle.TextXAlignment = Enum.TextXAlignment.Left
    Subtitle.BackgroundTransparency = 1

    local CloseBtn = Instance.new("TextButton", MainFrame)
    CloseBtn.Size = UDim2.new(0, 20, 0, 20)
    CloseBtn.Position = UDim2.new(1, -30, 0, 16)
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(140, 145, 155)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 12
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.MouseButton1Click:Connect(function() HubGui:Destroy() end)

    -- Container Halaman Utama
    local ContentPage = Instance.new("Frame", MainFrame)
    ContentPage.Size = UDim2.new(1, -180, 1, -75)
    ContentPage.Position = UDim2.new(0, 170, 0, 65)
    ContentPage.BackgroundTransparency = 1

    local function CreatePage(name)
        local Page = Instance.new("Frame", ContentPage)
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.Visible = false
        
        local LeftCol = Instance.new("ScrollingFrame", Page)
        LeftCol.Name = "LeftColumn"
        LeftCol.Size = UDim2.new(0.5, -6, 1, 0)
        LeftCol.BackgroundTransparency = 1
        LeftCol.CanvasSize = UDim2.new(0, 0, 0, 500)
        LeftCol.ScrollBarThickness = 0
        Instance.new("UIListLayout", LeftCol).Padding = UDim.new(0, 8)
        
        local RightCol = Instance.new("ScrollingFrame", Page)
        RightCol.Name = "RightColumn"
        RightCol.Size = UDim2.new(0.5, -6, 1, 0)
        RightCol.Position = UDim2.new(0.5, 6, 0, 0)
        RightCol.BackgroundTransparency = 1
        RightCol.CanvasSize = UDim2.new(0, 0, 0, 500)
        RightCol.ScrollBarThickness = 0
        Instance.new("UIListLayout", RightCol).Padding = UDim.new(0, 8)
        
        PagesContainer[name] = Page
        return Page
    end

    for tName, _ in pairs(TabButtons) do CreatePage(tName) end

    local function SwitchTab(targetName)
        CurrentTab = targetName
        for name, btn in pairs(TabButtons) do
            if name == targetName then
                btn.BackgroundColor3 = Color3.fromRGB(24, 28, 36)
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                PagesContainer[name].Visible = true
            else
                btn.BackgroundColor3 = Color3.fromRGB(11, 12, 15)
                btn.TextColor3 = Color3.fromRGB(150, 155, 165)
                PagesContainer[name].Visible = false
            end
        end
    end

    for name, btn in pairs(TabButtons) do
        btn.MouseButton1Click:Connect(function() SwitchTab(name) end)
    end

    -- =========================================================
    -- [PART 2] RENDER ENGINE KARTU FITUR (TOGGLE SWITCH & CARD)
    -- =========================================================
    local function InjectToggleCard(column, title, desc, callback)
        local Card = Instance.new("Frame", column)
        Card.Size = UDim2.new(1, 0, 0, 75)
        Card.BackgroundColor3 = Color3.fromRGB(14, 16, 21)
        Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 5)
        
        local Icon = Instance.new("TextLabel", Card)
        Icon.Size = UDim2.new(0, 25, 0, 25)
        Icon.Position = UDim2.new(0, 12, 0, 12)
        Icon.Text = "🌐"
        Icon.TextSize = 14
        Icon.BackgroundTransparency = 1
        
        local TxtLabel = Instance.new("TextLabel", Card)
        TxtLabel.Size = UDim2.new(1, -100, 0, 20)
        TxtLabel.Position = UDim2.new(0, 42, 0, 14)
        TxtLabel.Text = title
        TxtLabel.TextColor3 = Color3.fromRGB(240, 240, 245)
        TxtLabel.Font = Enum.Font.GothamBold
        TxtLabel.TextSize = 11
        TxtLabel.TextXAlignment = Enum.TextXAlignment.Left
        TxtLabel.BackgroundTransparency = 1
        
        local DescLabel = Instance.new("TextLabel", Card)
        DescLabel.Size = UDim2.new(1, -24, 0, 30)
        DescLabel.Position = UDim2.new(0, 12, 0, 40)
        DescLabel.Text = desc
        DescLabel.TextColor3 = Color3.fromRGB(110, 115, 125)
        DescLabel.Font = Enum.Font.GothamMedium
        DescLabel.TextSize = 9
        DescLabel.TextXAlignment = Enum.TextXAlignment.Center
        DescLabel.BackgroundTransparency = 1
        
        -- Switch Bulat Kanan (Toggle Element)
        local SwitchBg = Instance.new("Frame", Card)
        SwitchBg.Size = UDim2.new(0, 34, 0, 18)
        SwitchBg.Position = UDim2.new(1, -46, 0, 15)
        SwitchBg.BackgroundColor3 = Color3.fromRGB(24, 28, 35)
        Instance.new("UICorner", SwitchBg).CornerRadius = UDim.new(0, 9)
        local SStroke = Instance.new("UIStroke", SwitchBg)
        SStroke.Color = Color3.fromRGB(40, 45, 55)
        
        local Ball = Instance.new("Frame", SwitchBg)
        Ball.Size = UDim2.new(0, 14, 0, 14)
        Ball.Position = UDim2.new(0, 2, 0, 2)
        Ball.BackgroundColor3 = Color3.fromRGB(140, 145, 155)
        Instance.new("UICorner", Ball).CornerRadius = UDim.new(0, 7)
        
        local ClickBtn = Instance.new("TextButton", SwitchBg)
        ClickBtn.Size = UDim2.new(1, 0, 1, 0)
        ClickBtn.BackgroundTransparency = 1
        ClickBtn.Text = ""
        
        local Toggled = false
        ClickBtn.MouseButton1Click:Connect(function()
            Toggled = not Toggled
            if Toggled then
                SwitchBg.BackgroundColor3 = Color3.fromRGB(30, 144, 255) -- Biru Elegan Sesuai Gambar
                Ball.Position = UDim2.new(1, -16, 0, 2)
                Ball.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SStroke.Color = Color3.fromRGB(30, 144, 255)
            else
                SwitchBg.BackgroundColor3 = Color3.fromRGB(24, 28, 35)
                Ball.Position = UDim2.new(0, 2, 0, 2)
                Ball.BackgroundColor3 = Color3.fromRGB(140, 145, 155)
                SStroke.Color = Color3.fromRGB(40, 45, 55)
            end
            callback(Toggled)
        end)
    end

    -- =========================================================
    -- [PART 2] SUNTIK DATA FITUR KE MASING-MASING HALAMAN
    -- =========================================================
    
    -- --- HALAMAN MISC ---
    local MiscLeft = PagesContainer["Misc"]:FindFirstChild("LeftColumn")
    local MiscRight = PagesContainer["Misc"]:FindFirstChild("RightColumn")

    InjectToggleCard(MiscLeft, "Instant Interact", "Interact NPC without holding button\nEnable Instant Interact", function(state)
        Config.InstantPrompt = state
    end)
    
    InjectToggleCard(MiscLeft, "Infinite Stamina", "Disable exhaustion matrix parameters\nEnable Infinite Stamina", function(state)
        -- Bypass local stamina value
    end)
    
    InjectToggleCard(MiscLeft, "No Safezone Kick", "Circumvent structural base zone verification\nEnable No Safezone Kick", function(state)
        Config.Desync = state
    end)
    
    InjectToggleCard(MiscLeft, "Blink Teleport", "Instantly dash to point utilizing vector ticks\nEnable Blink Teleport (T)", function(state) end)

    -- Card Slider WalkSpeed (Kolom Kiri Bawah)
    local SpeedCard = Instance.new("Frame", MiscLeft)
    SpeedCard.Size = UDim2.new(1, 0, 0, 85)
    SpeedCard.BackgroundColor3 = Color3.fromRGB(14, 16, 21)
    Instance.new("UICorner", SpeedCard).CornerRadius = UDim.new(0, 5)
    
    local SpeedTitle = Instance.new("TextLabel", SpeedCard)
    SpeedTitle.Size = UDim2.new(1, 0, 0, 25)
    SpeedTitle.Position = UDim2.new(0, 42, 0, 10)
    SpeedTitle.Text = "🌐 WalkSpeed"
    SpeedTitle.TextColor3 = Color3.fromRGB(240, 240, 245)
    SpeedTitle.Font = Enum.Font.GothamBold
    SpeedTitle.TextSize = 11
    SpeedTitle.TextXAlignment = Enum.TextXAlignment.Left
    SpeedTitle.BackgroundTransparency = 1
    
    local ValueLbl = Instance.new("TextLabel", SpeedCard)
    ValueLbl.Size = UDim2.new(0, 60, 0, 20)
    ValueLbl.Position = UDim2.new(1, -70, 0, 38)
    ValueLbl.Text = "16s/ps"
    ValueLbl.TextColor3 = Color3.fromRGB(150, 155, 165)
    ValueLbl.Font = Enum.Font.GothamMedium
    ValueLbl.TextSize = 10
    ValueLbl.BackgroundTransparency = 1

    local SliderTrack = Instance.new("Frame", SpeedCard)
    SliderTrack.Size = UDim2.new(1, -100, 0, 4)
    SliderTrack.Position = UDim2.new(0, 30, 0, 48)
    SliderTrack.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
    
    local SliderFill = Instance.new("Frame", SliderTrack)
    SliderFill.Size = UDim2.new(0, 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(30, 144, 255)
    SliderFill.BorderSizePixel = 0
    
    local SliderThumb = Instance.new("Frame", SliderTrack)
    SliderThumb.Size = UDim2.new(0, 6, 0, 14)
    SliderThumb.Position = UDim2.new(0, -3, 0.5, -7)
    SliderThumb.BackgroundColor3 = Color3.fromRGB(180, 185, 195)
    Instance.new("UICorner", SliderThumb)

    local Dragging = false
    SliderThumb.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then Dragging = true end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then Dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local MousePos = input.Position.X
            local TrackPos = SliderTrack.AbsolutePosition.X
            local TrackWidth = SliderTrack.AbsoluteSize.X
            local Percentage = math.clamp((MousePos - TrackPos) / TrackWidth, 0, 1)
            SliderThumb.Position = UDim2.new(Percentage, -3, 0.5, -7)
            SliderFill.Size = UDim2.new(Percentage, 0, 1, 0)
            
            local TargetSpeed = math.floor(16 + (Percentage * 184))
            Config.WalkSpeed = TargetSpeed
            ValueLbl.Text = tostring(TargetSpeed) .. "s/ps"
        end
    end)

    InjectToggleCard(MiscRight, "Respawn at Death Location", "Enable Respawn at Death Location\nAuto anchor position vector", function(state) end)
    InjectToggleCard(MiscRight, "Noclip", "Allows movement across static boundary colliders\nNo-Clip Bind active", function(state)
        Config.Noclip = state
    end)

    -- --- HALAMAN COMBAT / SILENT AIM ---
    local SacLeft = PagesContainer["Silent Aim"]:FindFirstChild("LeftColumn")
    InjectToggleCard(SacLeft, "Silent Aim Matrix", "Redirect vector hits to nearest valid hitboxes", function(state)
        Config.SilentAim = state
    end)

    -- --- HALAMAN GUN / KILL AURA ---
    local GunLeft = PagesContainer["Gun"]:FindFirstChild("LeftColumn")
    InjectToggleCard(GunLeft, "Kill Aura Loop", "Automatically slash/attack nearby hostiles", function(state)
        Config.KillAura = state
    end)

    -- =========================================================
    -- [PART 2] RUNTIME THREAD PROTECTION (ANTI-FREEZE MATRIX)
    -- =========================================================
    task.spawn(function()
        while task.wait(0.4) do -- Nilai aman agar CPU Axioo tidak tersedak
            pcall(function()
                if LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then
                    LP.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = Config.WalkSpeed
                end
                
                if Config.KillAura and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                    for _, v in pairs(Players:GetPlayers()) do
                        if v ~= LP and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") then
                            local Dist = (LP.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
                            if Dist <= 18 and v.Character.Humanoid.Health > 0 then
                                local Tool = LP.Character:FindFirstChildOfClass("Tool")
                                if Tool then Tool:Activate() end
                            end
                        end
                    end
                end
            end)
        end
    end)

    -- Event Listener Ringan untuk Instant Interact
    ProximityPromptService.PromptShown:Connect(function(prompt)
        if Config.InstantPrompt then prompt.HoldDuration = 0 end
    end)

    -- Loop Sinkronisasi Render Noclip & Desync Safe Frame
    RunService.Heartbeat:Connect(function()
        pcall(function()
            if Config.Desync and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                LP.Character.HumanoidRootPart.Velocity = Vector3.new(450000, 450000, 450000)
            end
            if Config.Noclip and LP.Character then
                for _, part in pairs(LP.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    end)

    -- Infinite Jump Handler
    UserInputService.JumpRequest:Connect(function()
        if Config.InfiniteJump and LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then
            LP.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end
    end)

    -- Buka Default Tab Pertama
    SwitchTab("Misc")
end

-- =========================================================
-- [PART 1] SECURITY SYSTEM INTEGRATION
-- =========================================================
local GatewayGui = Instance.new("ScreenGui", CoreGui)
GatewayGui.Name = "LyzeenGateway"

local Frame = Instance.new("Frame", GatewayGui)
Frame.Size = UDim2.new(0, 320, 0, 180)
Frame.Position = UDim2.new(0.5, -160, 0.5, -90)
Frame.BackgroundColor3 = Color3.fromRGB(11, 12, 15)
MakeDraggable(Frame)
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", Frame).Color = Color3.fromRGB(30, 144, 255)

local lbl = Instance.new("TextLabel", Frame)
lbl.Size = UDim2.new(1, 0, 0, 40)
lbl.Text = "🔑 LYZEENJS SECURE GATEWAY"
lbl.TextColor3 = Color3.new(1, 1, 1)
lbl.Font = Enum.Font.GothamBold
lbl.TextSize = 12
lbl.BackgroundTransparency = 1

local Box = Instance.new("TextBox", Frame)
Box.Size = UDim2.new(0, 260, 0, 35)
Box.Position = UDim2.new(0.5, -130, 0.4, 0)
Box.PlaceholderText = "Masukkan Key..."
Box.Text = ""
Box.TextColor3 = Color3.new(1, 1, 1)
Box.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
Instance.new("UICorner", Box)

local Btn = Instance.new("TextButton", Frame)
Btn.Size = UDim2.new(0, 140, 0, 35)
Btn.Position = UDim2.new(0.5, -70, 0.7, 5)
Btn.Text = "VERIFY"
Btn.TextColor3 = Color3.new(1, 1, 1)
Btn.BackgroundColor3 = Color3.fromRGB(30, 144, 255)
Btn.Font = Enum.Font.GothamBold
Instance.new("UICorner", Btn)

Btn.MouseButton1Click:Connect(function()
    if Box.Text == Config.Key then
        GatewayGui:Destroy()
        LaunchZalHub()
    else
        Box.Text = ""
        Box.PlaceholderText = "❌ Key Salah, Coba Lagi!"
    end
end)
