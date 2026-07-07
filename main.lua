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
