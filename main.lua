-- [[ 🔴 LYZEENJS v5.2 - ULTRA PREMIUM LOGO EDITION 🔴 ]] --
-- PERFORMANCE LAYER ENGINE | ANTI-STUCK SLIDER MECHANICS | CYBERPUNK GATEWAY

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local TweenService = game:GetService("TweenService")

-- Pembersihan Instansi Duplikat
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

-- [[ SMOOTH DRAGGING ENGINE ]] --
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

-- [[ MAIN HUB INTERFACE (LYZEENJS) ]] --
local function LaunchZalHub()
    local HubGui = Instance.new("ScreenGui", CoreGui)
    HubGui.Name = "ZalCloneHub"
    
    local MainFrame = Instance.new("Frame", HubGui)
    MainFrame.Size = UDim2.new(0, 750, 0, 450)
    MainFrame.Position = UDim2.new(0.5, -375, 0.5, -225)
    MainFrame.BackgroundColor3 = Color3.fromRGB(11, 12, 15)
    MakeDraggable(MainFrame)
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 6)
    
    -- SIDEBAR NAVIGASI
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

    -- HEADER TOPBAR (REBRANDED TO LYZEENJS)
    local Header = Instance.new("Frame", MainFrame)
    Header.Size = UDim2.new(1, -160, 0, 55)
    Header.Position = UDim2.new(0, 160, 0, 0)
    Header.BackgroundTransparency = 1
    
    -- [[ INTEGRASI LOGO MEWAH LYZEENJS ]] --
    local LogoImage = Instance.new("ImageLabel", Header)
    LogoImage.Size = UDim2.new(0, 36, 0, 36)
    LogoImage.Position = UDim2.new(0, 20, 0, 10)
    -- Ganti ID di bawah ini dengan ID asset logo yang sudah diupload ke Roblox
    LogoImage.Image = "rbxassetid://123456789" 
    LogoImage.BackgroundTransparency = 1
    LogoImage.ScaleType = Enum.ScaleType.Fit
    
    local Title = Instance.new("TextLabel", Header)
    Title.Size = UDim2.new(1, -100, 0, 25)
    Title.Position = UDim2.new(0, 64, 0, 10) -- Geser sedikit ke kanan agar tidak menabrak logo
    Title.Text = "LyzeenJs"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 15
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1
    
    local Subtitle = Instance.new("TextLabel", Header)
    Subtitle.Size = UDim2.new(1, -100, 0, 15)
    Subtitle.Position = UDim2.new(0, 64, 0, 29) -- Sejajar dengan Title
    Subtitle.Text = "Premium Execution Platform • Delta Optimization Loaded"
    Subtitle.TextColor3 = Color3.fromRGB(30, 144, 255)
    Subtitle.Font = Enum.Font.GothamMedium
    Subtitle.TextSize = 9
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

    -- Container Page Halaman
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

    -- TOGGLE LAYER BUILDER
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
                SwitchBg.BackgroundColor3 = Color3.fromRGB(30, 144, 255)
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

    -- SUNTIK DATA KATEGORI MISC
    local MiscLeft = PagesContainer["Misc"]:FindFirstChild("LeftColumn")
    local MiscRight = PagesContainer["Misc"]:FindFirstChild("RightColumn")

    InjectToggleCard(MiscLeft, "Instant Interact", "Interact NPC without holding button\nEnable Instant Interact", function(state)
        Config.InstantPrompt = state
    end)
    InjectToggleCard(MiscLeft, "Infinite Stamina", "Disable exhaustion matrix parameters\nEnable Infinite Stamina", function(state) end)
    InjectToggleCard(MiscLeft, "No Safezone Kick", "Circumvent structural base zone verification", function(state) Config.Desync = state end)
    InjectToggleCard(MiscLeft, "Blink Teleport", "Instantly dash to point utilizing vector ticks", function(state) end)

    -- [[ 🛠️ SLIDER WALKSPEED (OPTIMIZED DELTA ENGINE - NO FREEZE) 🛠️ ]] --
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
    SliderTrack.Size = UDim2.new(1, -60, 0, 6)
    SliderTrack.Position = UDim2.new(0, 20, 0, 48)
    SliderTrack.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
    Instance.new("UICorner", SliderTrack)
    
    local SliderFill = Instance.new("Frame", SliderTrack)
    SliderFill.Size = UDim2.new(0, 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(30, 144, 255)
    SliderFill.BorderSizePixel = 0
    Instance.new("UICorner", SliderFill)
    
    local SliderThumb = Instance.new("TextButton", SliderTrack)
    SliderThumb.Size = UDim2.new(0, 8, 0, 16)
    SliderThumb.Position = UDim2.new(0, -4, 0.5, -8)
    SliderThumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SliderThumb.Text = ""
    Instance.new("UICorner", SliderThumb)
    local ThumbStroke = Instance.new("UIStroke", SliderThumb)
    ThumbStroke.Color = Color3.fromRGB(30, 144, 255)

    -- Logika Input State-Based (Cuma Trigger Saat Digeser)
    local Dragging = false
    local function UpdateSlider(input)
        local TrackPos = SliderTrack.AbsolutePosition.X
        local TrackWidth = SliderTrack.AbsoluteSize.X
        local MousePos = input.Position.X
        local Percentage = math.clamp((MousePos - TrackPos) / TrackWidth, 0, 1)
        
        SliderThumb.Position = UDim2.new(Percentage, -4, 0.5, -8)
        SliderFill.Size = UDim2.new(Percentage, 0, 1, 0)
        
        -- Range Aman WalkSpeed (16 - 150) Biar Server Gak Gampang Freeze / Kick
        local TargetSpeed = math.floor(16 + (Percentage * 134))
        Config.WalkSpeed = TargetSpeed
        ValueLbl.Text = tostring(TargetSpeed) .. "s/ps"
        
        if LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then
            pcall(function()
                LP.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = TargetSpeed
            end)
        end
    end

    SliderThumb.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            UpdateSlider(input)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            UpdateSlider(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = false
        end
    end)

    InjectToggleCard(MiscRight, "Respawn at Death Location", "Enable Respawn at Death Location", function(state) end)
    InjectToggleCard(MiscRight, "Noclip", "Allows movement across static boundary colliders", function(state)
        Config.Noclip = state
    end)

    -- KATEGORI COMBAT & GUN
    InjectToggleCard(PagesContainer["Silent Aim"]:FindFirstChild("LeftColumn"), "Silent Aim Matrix", "Redirect vector hits to target", function(state) Config.SilentAim = state end)
    InjectToggleCard(PagesContainer["Gun"]:FindFirstChild("LeftColumn"), "Kill Aura Loop", "Attack nearby hostiles instantly", function(state) Config.KillAura = state end)

    -- [[ SAFE REPETITIVE EXECUTION LAYER (HEARTBEAT OPTIMIZATION) ]] --
    RunService.Heartbeat:Connect(function()
        pcall(function()
            if LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then
                local Hum = LP.Character:FindFirstChildOfClass("Humanoid")
                -- Pengecekan Bersyarat: Hanya Tembak Perubahan Jika Value Berbeda (Anti-Stuck Game)
                if Hum.WalkSpeed ~= Config.WalkSpeed then
                    Hum.WalkSpeed = Config.WalkSpeed
                end
            end
            if Config.Noclip and LP.Character then
                for _, part in pairs(LP.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    end)

    ProximityPromptService.PromptShown:Connect(function(prompt)
        if Config.InstantPrompt then prompt.HoldDuration = 0 end
    end)

    SwitchTab("Misc")
end

-- =========================================================
-- [⚡] COGNITIVE NEON CYBERPUNK GATEWAY KEY SYSTEM
-- =========================================================
local GatewayGui = Instance.new("ScreenGui", CoreGui)
GatewayGui.Name = "LyzeenGateway"

local Frame = Instance.new("Frame", GatewayGui)
Frame.Size = UDim2.new(0, 360, 0, 220)
Frame.Position = UDim2.new(0.5, -180, 0.5, -110)
Frame.BackgroundColor3 = Color3.fromRGB(10, 11, 14)
Frame.ClipsDescendants = true
MakeDraggable(Frame)
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)

local NeonStroke = Instance.new("UIStroke", Frame)
NeonStroke.Color = Color3.fromRGB(30, 144, 255)
NeonStroke.Thickness = 1.5

local NeonBar = Instance.new("Frame", Frame)
NeonBar.Size = UDim2.new(1, 0, 0, 3)
NeonBar.BackgroundColor3 = Color3.fromRGB(30, 144, 255)
NeonBar.BorderSizePixel = 0

local lbl = Instance.new("TextLabel", Frame)
lbl.Size = UDim2.new(1, 0, 0, 45)
lbl.Position = UDim2.new(0, 0, 0, 10)
lbl.Text = "🧬 LYZEENJS COGNITIVE INTERFACE"
lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
lbl.Font = Enum.Font.GothamBold
lbl.TextSize = 13
lbl.BackgroundTransparency = 1

local sublbl = Instance.new("TextLabel", Frame)
sublbl.Size = UDim2.new(1, 0, 0, 15)
sublbl.Position = UDim2.new(0, 0, 0, 45)
sublbl.Text = "Please enter your authentication token below"
sublbl.TextColor3 = Color3.fromRGB(110, 115, 125)
sublbl.Font = Enum.Font.GothamMedium
sublbl.TextSize = 10
sublbl.BackgroundTransparency = 1

local Box = Instance.new("TextBox", Frame)
Box.Size = UDim2.new(0, 300, 0, 40)
Box.Position = UDim2.new(0.5, -150, 0.45, 0)
Box.PlaceholderText = "Enter Security Token Key..."
Box.Text = ""
Box.TextColor3 = Color3.new(1, 1, 1)
Box.BackgroundColor3 = Color3.fromRGB(16, 18, 23)
Box.Font = Enum.Font.GothamMedium
Box.TextSize = 11
Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 5)
local BoxStroke = Instance.new("UIStroke", Box)
BoxStroke.Color = Color3.fromRGB(35, 40, 50)

Box.Focused:Connect(function()
    TweenService:Create(BoxStroke, TweenInfo.new(0.25), {Color = Color3.fromRGB(30, 144, 255)}):Play()
end)
Box.FocusLost:Connect(function()
    TweenService:Create(BoxStroke, TweenInfo.new(0.25), {Color = Color3.fromRGB(35, 40, 50)}):Play()
end)

local Btn = Instance.new("TextButton", Frame)
Btn.Size = UDim2.new(0, 180, 0, 38)
Btn.Position = UDim2.new(0.5, -90, 0.73, 5)
Btn.Text = "AUTHENTICATE"
Btn.TextColor3 = Color3.new(1, 1, 1)
B    CreateSideBtn("Whitelist", "📜")
    CreateSideLabel("Settings")
    CreateSideBtn("Settings", "⚙️")

    -- HEADER TOPBAR (REBRANDED TO LYZEENJS)
    local Header = Instance.new("Frame", MainFrame)
    Header.Size = UDim2.new(1, -160, 0, 55)
    Header.Position = UDim2.new(0, 160, 0, 0)
    Header.BackgroundTransparency = 1
    
    local Title = Instance.new("TextLabel", Header)
    Title.Size = UDim2.new(1, -100, 0, 25)
    Title.Position = UDim2.new(0, 20, 0, 12)
    Title.Text = "LyzeenJs"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1
    
    local Subtitle = Instance.new("TextLabel", Header)
    Subtitle.Size = UDim2.new(1, -100, 0, 15)
    Subtitle.Position = UDim2.new(0, 20, 0, 29)
    Subtitle.Text = "Premium Execution Platform • Optimization Layer Loaded"
    Subtitle.TextColor3 = Color3.fromRGB(30, 144, 255)
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

    -- Container Page Halaman
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

    -- TOGGLE LAYER BUILDER
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
                SwitchBg.BackgroundColor3 = Color3.fromRGB(30, 144, 255)
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

    -- SUNTIK DATA KATEGORI MISC
    local MiscLeft = PagesContainer["Misc"]:FindFirstChild("LeftColumn")
    local MiscRight = PagesContainer["Misc"]:FindFirstChild("RightColumn")

    InjectToggleCard(MiscLeft, "Instant Interact", "Interact NPC without holding button\nEnable Instant Interact", function(state)
        Config.InstantPrompt = state
    end)
    InjectToggleCard(MiscLeft, "Infinite Stamina", "Disable exhaustion matrix parameters\nEnable Infinite Stamina", function(state) end)
    InjectToggleCard(MiscLeft, "No Safezone Kick", "Circumvent structural base zone verification", function(state) Config.Desync = state end)
    InjectToggleCard(MiscLeft, "Blink Teleport", "Instantly dash to point utilizing vector ticks", function(state) end)

    -- [[ 🛠️ SLIDER WALKSPEED (100% FIXED & FLUID MECHANICS) 🛠️ ]] --
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

    -- Wilayah Track Diperluas Biar Responsif Saat Di-klik
    local SliderTrack = Instance.new("Frame", SpeedCard)
    SliderTrack.Size = UDim2.new(1, -60, 0, 6)
    SliderTrack.Position = UDim2.new(0, 20, 0, 48)
    SliderTrack.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
    Instance.new("UICorner", SliderTrack)
    
    local SliderFill = Instance.new("Frame", SliderTrack)
    SliderFill.Size = UDim2.new(0, 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(30, 144, 255)
    SliderFill.BorderSizePixel = 0
    Instance.new("UICorner", SliderFill)
    
    local SliderThumb = Instance.new("TextButton", SliderTrack)
    SliderThumb.Size = UDim2.new(0, 8, 0, 16)
    SliderThumb.Position = UDim2.new(0, -4, 0.5, -8)
    SliderThumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SliderThumb.Text = ""
    Instance.new("UICorner", SliderThumb)
    local ThumbStroke = Instance.new("UIStroke", SliderThumb)
    ThumbStroke.Color = Color3.fromRGB(30, 144, 255)

    -- Logika Input Global (Bebas Macet / Seret)
    local Dragging = false
    local function UpdateSlider(input)
        local TrackPos = SliderTrack.AbsolutePosition.X
        local TrackWidth = SliderTrack.AbsoluteSize.X
        local MousePos = input.Position.X
        local Percentage = math.clamp((MousePos - TrackPos) / TrackWidth, 0, 1)
        
        SliderThumb.Position = UDim2.new(Percentage, -4, 0.5, -8)
        SliderFill.Size = UDim2.new(Percentage, 0, 1, 0)
        
        -- Konfigurasi Kecepatan WalkSpeed (Range 16 sampai 200)
        local TargetSpeed = math.floor(16 + (Percentage * 184))
        Config.WalkSpeed = TargetSpeed
        ValueLbl.Text = tostring(TargetSpeed) .. "s/ps"
        
        -- Langsung Tembak ke Karakter Tanpa Delay Loop
        if LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then
            LP.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = TargetSpeed
        end
    end

    SliderThumb.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            UpdateSlider(input)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            UpdateSlider(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = false
        end
    end)

    InjectToggleCard(MiscRight, "Respawn at Death Location", "Enable Respawn at Death Location", function(state) end)
    InjectToggleCard(MiscRight, "Noclip", "Allows movement across static boundary colliders", function(state)
        Config.Noclip = state
    end)

    -- --- KATEGORI COMBAT & GUN ---
    InjectToggleCard(PagesContainer["Silent Aim"]:FindFirstChild("LeftColumn"), "Silent Aim Matrix", "Redirect vector hits to target", function(state) Config.SilentAim = state end)
    InjectToggleCard(PagesContainer["Gun"]:FindFirstChild("LeftColumn"), "Kill Aura Loop", "Attack nearby hostiles instantly", function(state) Config.KillAura = state end)

    -- [[ SAFE REPETITIVE EXECUTION LAYER ]] --
    RunService.Stepped:Connect(function()
        pcall(function()
            if LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") and LP.Character:FindFirstChildOfClass("Humanoid").WalkSpeed ~= Config.WalkSpeed then
                LP.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = Config.WalkSpeed
            end
            if Config.Noclip and LP.Character then
                for _, part in pairs(LP.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    end)

    ProximityPromptService.PromptShown:Connect(function(prompt)
        if Config.InstantPrompt then prompt.HoldDuration = 0 end
    end)

    SwitchTab("Misc")
end

-- =========================================================
-- [⚡] COGNITIVE NEON CYBERPUNK GATEWAY KEY SYSTEM (1000x BETTER)
-- =========================================================
local GatewayGui = Instance.new("ScreenGui", CoreGui)
GatewayGui.Name = "LyzeenGateway"

local Frame = Instance.new("Frame", GatewayGui)
Frame.Size = UDim2.new(0, 360, 0, 220)
Frame.Position = UDim2.new(0.5, -180, 0.5, -110)
Frame.BackgroundColor3 = Color3.fromRGB(10, 11, 14)
Frame.ClipsDescendants = true
MakeDraggable(Frame)
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)

-- Neon Glow Border Effects
local NeonStroke = Instance.new("UIStroke", Frame)
NeonStroke.Color = Color3.fromRGB(30, 144, 255)
NeonStroke.Thickness = 1.5

-- Top Neon Bar Accent
local NeonBar = Instance.new("Frame", Frame)
NeonBar.Size = UDim2.new(1, 0, 0, 3)
NeonBar.BackgroundColor3 = Color3.fromRGB(30, 144, 255)
NeonBar.BorderSizePixel = 0

local lbl = Instance.new("TextLabel", Frame)
lbl.Size = UDim2.new(1, 0, 0, 45)
lbl.Position = UDim2.new(0, 0, 0, 10)
lbl.Text = "🧬 LYZEENJS COGNITIVE INTERFACE"
lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
lbl.Font = Enum.Font.GothamBold
lbl.TextSize = 13
lbl.BackgroundTransparency = 1

local sublbl = Instance.new("TextLabel", Frame)
sublbl.Size = UDim2.new(1, 0, 0, 15)
sublbl.Position = UDim2.new(0, 0, 0, 45)
sublbl.Text = "Please enter your authentication token below"
sublbl.TextColor3 = Color3.fromRGB(110, 115, 125)
sublbl.Font = Enum.Font.GothamMedium
sublbl.TextSize = 10
sublbl.BackgroundTransparency = 1

local Box = Instance.new("TextBox", Frame)
Box.Size = UDim2.new(0, 300, 0, 40)
Box.Position = UDim2.new(0.5, -150, 0.45, 0)
Box.PlaceholderText = "Enter Security Token Key..."
Box.Text = ""
Box.TextColor3 = Color3.new(1, 1, 1)
Box.BackgroundColor3 = Color3.fromRGB(16, 18, 23)
Box.Font = Enum.Font.GothamMedium
Box.TextSize = 11
Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 5)
local BoxStroke = Instance.new("UIStroke", Box)
BoxStroke.Color = Color3.fromRGB(35, 40, 50)

-- Animasi Interaktif TextBox Focus
Box.Focused:Connect(function()
    TweenService:Create(BoxStroke, TweenInfo.new(0.25), {Color = Color3.fromRGB(30, 144, 255)}):Play()
end)
Box.FocusLost:Connect(function()
    TweenService:Create(BoxStroke, TweenInfo.new(0.25), {Color = Color3.fromRGB(35, 40, 50)}):Play()
end)

local Btn = Instance.new("TextButton", Frame)
Btn.Size = UDim2.new(0, 180, 0, 38)
Btn.Position = UDim2.new(0.5, -90, 0.73, 5)
Btn.Text = "AUTHENTICATE"
Btn.TextColor3 = Color3.new(1, 1, 1)
Btn.BackgroundColor3 = Color3.fromRGB(30, 144, 255)
Btn.Font = Enum.Font.GothamBold
Btn.TextSize = 11
Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 5)

-- Efek Hover Tombol Auth
Btn.MouseEnter:Connect(function()
    TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 191, 255)}):Play()
end)
Btn.MouseLeave:Connect(function()
    TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 144, 255)}):Play()
end)

Btn.MouseButton1Click:Connect(function()
    if Box.Text == Config.Key then
        -- Efek Animasi Sukses Sebelum Gui Ditutup
        Box.Text = "✓ ACCESS GRANTED"
        Box.TextColor3 = Color3.fromRGB(50, 205, 50)
        TweenService:Create(NeonStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(50, 205, 50)}):Play()
        task.wait(0.5)
        GatewayGui:Destroy()
        LaunchZalHub()
    else
        Box.Text = ""
        Box.PlaceholderText = "✕ INVALID SECURITY TOKEN"
        TweenService:Create(NeonStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(255, 30, 60)}):Play()
        task.spawn(function()
            task.wait(1)
            TweenService:Create(NeonStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(30, 144, 255)}):Play()
        end)
    end
end)
