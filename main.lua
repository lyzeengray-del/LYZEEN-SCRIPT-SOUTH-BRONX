-- [[ 🔴 LYZEENJS v5.0 - ABSOLUTE INDEPENDENT ENGINE 🔴 ]] --
-- TIDAK BUTUH SERVER LUAR - 100% PASTI MUNCUL DI SEMUA EXECUTOR

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Hapus UI lama jika duplikat
if CoreGui:FindFirstChild("LyzeenGateway") then CoreGui.LyzeenGateway:Destroy() end
if CoreGui:FindFirstChild("LyzeenHub") then CoreGui.LyzeenHub:Destroy() end

-- State Cache
local Config = { Key = "LyzeenJsFree", WalkSpeed = 16, InfiniteJump = false, Noclip = false }

-- Fungsi Drag Frame (Biar Bisa Digeser di HP)
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

-- [[ INTERFACE HUB UTAMA ]] --
local function LaunchLyzeenHub()
    local HubGui = Instance.new("ScreenGui", CoreGui)
    HubGui.Name = "LyzeenHub"
    
    local MainFrame = Instance.new("Frame", HubGui)
    MainFrame.Size = UDim2.new(0, 350, 0, 250)
    MainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
    MakeDraggable(MainFrame)
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(255, 20, 50)
    
    local Title = Instance.new("TextLabel", MainFrame)
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Text = "🔴 LYZEENJS PREMIUM v5.0"
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 14
    Title.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 8)
    
    -- Tombol Fitur Speed
    local SpeedBtn = Instance.new("TextButton", MainFrame)
    SpeedBtn.Size = UDim2.new(0, 310, 0, 35)
    SpeedBtn.Position = UDim2.new(0, 20, 0, 60)
    SpeedBtn.Text = "⚡ Fast Speed (Set to 100)"
    SpeedBtn.TextColor3 = Color3.new(1, 1, 1)
    SpeedBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Instance.new("UICorner", SpeedBtn)
    
    local SpeedActive = false
    SpeedBtn.MouseButton1Click:Connect(function()
        SpeedActive = not SpeedActive
        SpeedBtn.BackgroundColor3 = SpeedActive and Color3.fromRGB(255, 20, 50) or Color3.fromRGB(30, 30, 35)
        Config.WalkSpeed = SpeedActive and 100 or 16
    end)
    
    -- Tombol Fitur Infinite Jump
    local JumpBtn = Instance.new("TextButton", MainFrame)
    JumpBtn.Size = UDim2.new(0, 310, 0, 35)
    JumpBtn.Position = UDim2.new(0, 20, 0, 110)
    JumpBtn.Text = "🪶 Toggle Infinite Jump [OFF]"
    JumpBtn.TextColor3 = Color3.new(1, 1, 1)
    JumpBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Instance.new("UICorner", JumpBtn)
    
    JumpBtn.MouseButton1Click:Connect(function()
        Config.InfiniteJump = not Config.InfiniteJump
        JumpBtn.Text = "🪶 Toggle Infinite Jump [" .. (Config.InfiniteJump and "ON" or "OFF") .. "]"
        JumpBtn.BackgroundColor3 = Config.InfiniteJump and Color3.fromRGB(255, 20, 50) or Color3.fromRGB(30, 30, 35)
    end)

    -- Tombol Fitur Noclip
    local NoclipBtn = Instance.new("TextButton", MainFrame)
    NoclipBtn.Size = UDim2.new(0, 310, 0, 35)
    NoclipBtn.Position = UDim2.new(0, 20, 0, 160)
    NoclipBtn.Text = "🧱 Toggle Noclip [OFF]"
    NoclipBtn.TextColor3 = Color3.new(1, 1, 1)
    NoclipBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Instance.new("UICorner", NoclipBtn)
    
    NoclipBtn.MouseButton1Click:Connect(function()
        Config.Noclip = not Config.Noclip
        NoclipBtn.Text = "🧱 Toggle Noclip [" .. (Config.Noclip and "ON" or "OFF") .. "]"
        NoclipBtn.BackgroundColor3 = Config.Noclip and Color3.fromRGB(255, 20, 50) or Color3.fromRGB(30, 30, 35)
    end)
    
    -- [[ LOOP CORE LOGIC LOOPS ]] --
    task.spawn(function()
        while task.wait(0.1) do
            if LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then
                LP.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = Config.WalkSpeed
            end
        end
    end)
    
    RunService.Stepped:Connect(function()
        if Config.Noclip and LP.Character then
            for _, v in pairs(LP.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
    
    UserInputService.JumpRequest:Connect(function()
        if Config.InfiniteJump and LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then
            LP.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end
    end)
end

-- [[ GATEWAY KEY SYSTEM UI ]] --
local GatewayGui = Instance.new("ScreenGui", CoreGui)
GatewayGui.Name = "LyzeenGateway"

local Frame = Instance.new("Frame", GatewayGui)
Frame.Size = UDim2.new(0, 320, 0, 180)
Frame.Position = UDim2.new(0.5, -160, 0.5, -90)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MakeDraggable(Frame)
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", Frame).Color = Color3.fromRGB(255, 20, 50)

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
Box.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Instance.new("UICorner", Box)

local Btn = Instance.new("TextButton", Frame)
Btn.Size = UDim2.new(0, 140, 0, 35)
Btn.Position = UDim2.new(0.5, -70, 0.7, 5)
Btn.Text = "VERIFY"
Btn.TextColor3 = Color3.new(1, 1, 1)
Btn.BackgroundColor3 = Color3.fromRGB(255, 20, 50)
Btn.Font = Enum.Font.GothamBold
Instance.new("UICorner", Btn)

Btn.MouseButton1Click:Connect(function()
    if Box.Text == Config.Key then
        GatewayGui:Destroy()
        LaunchLyzeenHub()
    else
        Box.Text = ""
        Box.PlaceholderText = "❌ Key Salah, Coba Lagi!"
    end
end)
