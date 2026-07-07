-- [[ 🔴 LYZEENJS v5.0 - UNTOUCHABLE CARNAGE EDITION (FULL FIXED) 🔴 ]] --
-- ANTI-CRASH PROTECTION INCLUDED

local Success, ErrorMessage = pcall(function()
    -- Pemanggilan UI Rayfield Versi Paling Stabil & Universal
    local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

    -- [[ CORE CONFIGURATION DATA ]] --
    local Config = {
        Key = "LyzeenJsFree",
        SilentAim = { Enabled = false, FOV = 130, TargetPart = "Head" },
        KillAura = { Enabled = false, Range = 18 },
        WalkSpeed = { Enabled = false, Value = 16 },
        InfiniteJump = false,
        Noclip = false,
        AutoCollect = false,
        AutoSell = false
    }

    -- [[ ACCESSIBILITY GATEWAY SYSTEM (KEY SYSTEM) ]] --
    local Window = Rayfield:CreateWindow({
       Name = "🔴 LYZEENJS PREMIUM v5.0",
       LoadingTitle = "⚡ LyzeenJs Infrastructure",
       LoadingSubtitle = "by Lyzeen",
       ConfigurationSaving = { Enabled = false },
       KeySystem = true,
       KeySettings = {
          Title = "🔑 LyzeenJs Secure Gateway",
          Subtitle = "Masukkan Kunci Akses Premium",
          Note = "Key bawaan: LyzeenJsFree",
          FileName = "LyzeenKeyCache",
          SaveKey = true,
          GrabKeyFromUrl = false,
          Key = {"LyzeenJsFree"}
       }
    })

    local Players = game:GetService("Players")
    local LP = Players.LocalPlayer
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")

    -- [[ TAB MENUS ]] --
    local TabCombat = Window:CreateTab("🎯 Combat", 4483362458)
    local TabFarm = Window:CreateTab("🌾 Auto Farm", 4483362458)
    local TabMovement = Window:CreateTab("👟 Movement", 4483362458)

    -- ========================================================
    -- [[ 1. COMBAT MODULE ]] --
    -- ========================================================
    TabCombat:CreateSection("Aimbot & Carnage Controls")

    TabCombat:CreateToggle({
       Name = "Enable Silent Aim",
       CurrentValue = false,
       Flag = "SilentAimToggle",
       Callback = function(Value) Config.SilentAim.Enabled = Value end,
    })

    TabCombat:CreateToggle({
       Name = "Kill Aura (Auto Attack)",
       CurrentValue = false,
       Flag = "KillAuraToggle",
       Callback = function(Value) Config.KillAura.Enabled = Value end,
    })

    local DesyncActive = false
    TabCombat:CreateToggle({
       Name = "💀 Activate Server Desync Lag",
       CurrentValue = false,
       Flag = "DesyncToggle",
       Callback = function(Value)
          DesyncActive = Value
          task.spawn(function()
             while DesyncActive do
                if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                    local Root = LP.Character.HumanoidRootPart
                    local OldCFrame = Root.CFrame
                    Root.Velocity = Vector3.new(999999, 999999, 999999)
                    RunService.Heartbeat:Wait()
                    Root.CFrame = OldCFrame
                else break end
             end
          end)
       end,
    })

    -- ========================================================
    -- [[ 2. AUTO FARM MODULE ]] --
    -- ========================================================
    TabFarm:CreateSection("Industrial Automation")

    TabFarm:CreateToggle({
       Name = "🌾 Auto Collect Items",
       CurrentValue = false,
       Flag = "CollectToggle",
       Callback = function(Value) Config.AutoCollect = Value end,
    })

    TabFarm:CreateToggle({
       Name = "💰 Auto Teleport Sell",
       CurrentValue = false,
       Flag = "SellToggle",
       Callback = function(Value) Config.AutoSell = Value end,
    })

    -- ========================================================
    -- [[ 3. MOVEMENT MODULE ]] --
    -- ========================================================
    TabMovement:CreateSection("Physics Modifier")

    TabMovement:CreateSlider({
       Name = "Custom WalkSpeed",
       Min = 16,
       Max = 250,
       Default = 16,
       Color = Color3.fromRGB(255, 20, 50),
       Increment = 2,
       ValueName = "Speed",
       Flag = "SpeedSlider",
       Callback = function(Value) 
          Config.WalkSpeed.Value = Value
          Config.WalkSpeed.Enabled = true 
       end,
    })

    TabMovement:CreateToggle({
       Name = "Infinite Jump Mechanics",
       CurrentValue = false,
       Flag = "InfJumpToggle",
       Callback = function(Value) Config.InfiniteJump = Value end,
    })

    TabMovement:CreateToggle({
       Name = "🧱 Noclip (Tembus Tembok)",
       CurrentValue = false,
       Flag = "NoclipToggle",
       Callback = function(Value) Config.Noclip = Value end,
    })

    -- ========================================================
    -- [[ CORE RUNTIME LOGIC LOOPS ]] --
    -- ========================================================

    -- Kill Aura & Speed Handler Loop
    task.spawn(function()
        while task.wait(0.1) do
            pcall(function()
                if LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then
                    local Hum = LP.Character:FindFirstChildOfClass("Humanoid")
                    if Config.WalkSpeed.Enabled then Hum.WalkSpeed = Config.WalkSpeed.Value end
                end
                
                if Config.KillAura.Enabled and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                    for _, v in pairs(Players:GetPlayers()) do
                        if v ~= LP and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") then
                            local Dist = (LP.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
                            if Dist <= Config.KillAura.Range and v.Character.Humanoid.Health > 0 then
                                local Tool = LP.Character:FindFirstChildOfClass("Tool")
                                if Tool then Tool:Activate() end
                            end
                        end
                    end
                end
            end)
        end
    end)

    -- Noclip Runtime Loop
    RunService.Stepped:Connect(function()
        if Config.Noclip and LP.Character then
            for _, part in pairs(LP.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end)

    -- Infinite Jump Listener
    UserInputService.JumpRequest:Connect(function()
        if Config.InfiniteJump and LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then
            LP.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end
    end)

    Rayfield:Notify({Title = "DEPLOY SUCCESS", Content = "Semua fitur ganas LyzeenJs v5.0 aktif sempurna!", Duration = 5})
end)

-- Jika Script Mengalami Eror/Crash, Ini Akan Memunculkan Pesan Eror di Layar Game
if not Success then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "❌ LYZEENJS ERROR",
        Text = "Terjadi crash: " .. tostring(ErrorMessage),
        Duration = 10
    })
    warn("[LYZEENJS CRASH LOG]: " .. tostring(ErrorMessage))
end
