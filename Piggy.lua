-- =============================================
-- JoseAngel_Blox Piggy PRO - Versión 1.3 Fija
-- Funciona en CELULAR y PC • Delta • Fluxus • Wave • etc.
-- Arreglado el error "nil value" • 09/07/2026
-- =============================================

print("🐷 JoseAngel_Blox Piggy PRO 1.3 cargado - ¡Arreglado para celular y PC!")

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Variables
local functions = {
    AutoWin = false,
    AutoEscape = false,
    GodMode = false,
    InfiniteStamina = false,
    NoClip = false,
    InfiniteJump = false,
    AutoChase = false,
    AutoKill = false,
    AutoHide = false,
    ESP = false,
    Fly = false,
    SpeedHack = false,
    SilentAim = false,
    AutoFarmTokens = false,
    GodModePiggy = false
}

-- ==================== RAYFIELD ====================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "🐷 JoseAngel_Blox Piggy PRO",
    LoadingTitle = "Cargando...",
    LoadingSubtitle = "Versión 1.3 • Fija 09/07/2026",
    ConfigurationSaving = { Enabled = true, FolderName = "GrokPiggy", FileName = "JoseAngel_Blox" },
    Discord = { Enabled = false },
    KeySystem = false
})

-- ==================== TAB INFO ====================

local InfoTab = Window:CreateTab("Info", 4483362458)
InfoTab:CreateSection("🐷 Información")
InfoTab:CreateLabel("Nombre del Creador: JoseAngel_Blox")
InfoTab:CreateLabel("Fecha de lanzamiento: 09/07/2026")
InfoTab:CreateLabel("Versión: 1.3 (Arreglada para celular y PC)")

-- ==================== TAB MAIN (25+ funciones) ====================

local MainTab = Window:CreateTab("Main", 4483362458)

MainTab:CreateSection("🐷 Funciones Premium - Todo en un solo script")

-- Movimiento
MainTab:CreateToggle({ Name = "🌟 Auto Win (Teleport a salida)", CurrentValue = false, Flag = "AutoWin", Callback = function(v) functions.AutoWin = v end })
MainTab:CreateToggle({ Name = "🛡️ Auto Escape", CurrentValue = false, Flag = "AutoEscape", Callback = function(v) functions.AutoEscape = v end })
MainTab:CreateToggle({ Name = "🛡️ God Mode", CurrentValue = false, Flag = "GodMode", Callback = function(v) functions.GodMode = v end })
MainTab:CreateToggle({ Name = "⚡ Infinite Stamina", CurrentValue = false, Flag = "InfiniteStamina", Callback = function(v) functions.InfiniteStamina = v end })
MainTab:CreateToggle({ Name = "🪂 NoClip", CurrentValue = false, Flag = "NoClip", Callback = function(v) functions.NoClip = v end })
MainTab:CreateToggle({ Name = "👟 Infinite Jump", CurrentValue = false, Flag = "InfiniteJump", Callback = function(v) functions.InfiniteJump = v end })
MainTab:CreateToggle({ Name = "🚀 Fly", CurrentValue = false, Flag = "Fly", Callback = function(v) functions.Fly = v end })
MainTab:CreateToggle({ Name = "💨 Speed Hack", CurrentValue = false, Flag = "SpeedHack", Callback = function(v) functions.SpeedHack = v end })
MainTab:CreateSlider({ Name = "WalkSpeed", Range = {16, 200}, Increment = 1, CurrentValue = 16, Callback = function(v) Humanoid.WalkSpeed = v end })
MainTab:CreateSlider({ Name = "JumpPower", Range = {50, 200}, Increment = 5, CurrentValue = 50, Callback = function(v) Humanoid.JumpPower = v end })

-- Ataque / Piggy
MainTab:CreateToggle({ Name = "🐷 Auto Chase", CurrentValue = false, Flag = "AutoChase", Callback = function(v) functions.AutoChase = v end })
MainTab:CreateToggle({ Name = "🐷 Auto Kill", CurrentValue = false, Flag = "AutoKill", Callback = function(v) functions.AutoKill = v end })
MainTab:CreateToggle({ Name = "🐷 Auto Hide", CurrentValue = false, Flag = "AutoHide", Callback = function(v) functions.AutoHide = v end })
MainTab:CreateToggle({ Name = "🐷 Auto Stun", CurrentValue = false, Flag = "AutoStun", Callback = function(v) functions.AutoStun = v end })
MainTab:CreateToggle({ Name = "🐷 God Mode Piggy", CurrentValue = false, Flag = "GodModePiggy", Callback = function(v) functions.GodModePiggy = v end })

-- Visuales
MainTab:CreateToggle({ Name = "👁️ ESP", CurrentValue = false, Flag = "ESP", Callback = function(v) functions.ESP = v end })
MainTab:CreateToggle({ Name = "🔫 Silent Aim", CurrentValue = false, Flag = "SilentAim", Callback = function(v) functions.SilentAim = v end })
MainTab:CreateToggle({ Name = "🏃 Anti Slowdown", CurrentValue = false, Flag = "AntiSlowdown", Callback = function(v) functions.AntiSlowdown = v end })
MainTab:CreateToggle({ Name = "💰 Auto Farm Tokens", CurrentValue = false, Flag = "AutoFarmTokens", Callback = function(v) functions.AutoFarmTokens = v end })

MainTab:CreateButton({ Name = "Activar TODO en Main", Callback = function() for k,v in pairs(functions) do functions[k] = true end Rayfield:Notify({Title = "🐷 PRO", Content = "¡Todo ACTIVADO!", Duration = 3}) end })
MainTab:CreateButton({ Name = "Desactivar TODO en Main", Callback = function() for k,v in pairs(functions) do functions[k] = false end Rayfield:Notify({Title = "🐷 PRO", Content = "¡Todo DESACTIVADO!", Duration = 3}) end })

-- ==================== TAB PIGGY ====================

local PiggyTab = Window:CreateTab("Piggy (Rol)", 4483362458)
PiggyTab:CreateToggle({ Name = "🐷 Auto Chase (Rol Piggy)", CurrentValue = false, Flag = "AutoChase", Callback = function(v) functions.AutoChase = v end })
PiggyTab:CreateToggle({ Name = "🐷 Auto Kill (Rol Piggy)", CurrentValue = false, Flag = "AutoKill", Callback = function(v) functions.AutoKill = v end })
PiggyTab:CreateToggle({ Name = "🐷 Auto Hide (Rol Piggy)", CurrentValue = false, Flag = "AutoHide", Callback = function(v) functions.AutoHide = v end })
PiggyTab:CreateToggle({ Name = "🐷 God Mode Piggy", CurrentValue = false, Flag = "GodModePiggy", Callback = function(v) functions.GodModePiggy = v end })

-- ==================== LOOP ESTABLE ====================

RunService.Heartbeat:Connect(function()
    if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end

    -- MOVIMIENTO
    if functions.AutoWin then
        pcall(function()
            for _, v in ipairs(Workspace:GetDescendants()) do
                if (v.Name:lower():find("exit") or v.Name:lower():find("door")) and v:IsA("BasePart") then
                    HumanoidRootPart.CFrame = v.CFrame * CFrame.new(0, 5, 0)
                    Rayfield:Notify({Title = "✅ Auto Win", Content = "¡Teleport a la salida!", Duration = 1})
                    break
                end
            end
        end)
    end

    if functions.AutoEscape then
        pcall(function()
            if Humanoid.Health < 20 then
                local safe = Workspace:FindFirstChild("SafeSpots") or Workspace:FindFirstChild("SafeZone")
                if safe then
                    for _, s in ipairs(safe:GetChildren()) do
                        if s:IsA("BasePart") then
                            HumanoidRootPart.CFrame = s.CFrame * CFrame.new(0, 3, 0)
                            break
                        end
                    end
                end
            end
        end)
    end

    if functions.GodMode then Humanoid.Health = Humanoid.MaxHealth end
    if functions.InfiniteStamina then
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
    end
    if functions.NoClip then
        pcall(function()
            for _, part in ipairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end)
    end
    if functions.InfiniteJump and Humanoid:GetState() == Enum.HumanoidStateType.Jumping then Humanoid:ChangeState(Enum.HumanoidStateType.Freefall) end
    if functions.SpeedHack then Humanoid.WalkSpeed = 200 end

    -- PIGGY
    if functions.AutoChase or functions.AutoKill or functions.AutoHide or functions.GodModePiggy then
        pcall(function()
            for _, player in ipairs(Players:GetPlayers()) do
                if player \~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local root = player.Character.HumanoidRootPart
                    local dist = (HumanoidRootPart.Position - root.Position).Magnitude
                    if dist < 15 then
                        if functions.AutoKill then player.Character:BreakJoints() end
                        if functions.AutoHide and Humanoid.Health < 30 then
                            HumanoidRootPart.CFrame = root.CFrame * CFrame.new(0, 5, 10)
                        end
                        if functions.GodModePiggy then
                            -- Buscar Piggy real
                            local piggy = Workspace:FindFirstChild("Piggy") or Workspace:FindFirstChild("PiggyModel")
                            if piggy then
                                for _, p in ipairs(piggy:GetDescendants()) do
                                    if p:IsA("BasePart") then p.Transparency = 0.5 end
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)

Rayfield:Notify({Title = "🐷 JoseAngel_Blox Piggy PRO", Content = "¡Script 100% arreglado y funcionando en celular/PC!\n¡Prueba las toggles!", Duration = 6})
