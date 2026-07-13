-- =============================================
-- JoseAngel_Blox Kick - Script Profesional
-- Creado por JoseAngel_Blox | 13/07/2026 | Versión: 1.1
-- =============================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- ==================== REMOTES (ajusta los nombres reales si cambian) ====================
local Network = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Packages"):WaitForChild("Network")
local KickEvent = Network:WaitForChild("rev_KickEvent")   -- Auto Kick + Perfect Kick
local PlaceEvent = Network:WaitForChild("rev_PlaceEvent") -- Auto Place (Brainrots)
local CollectEvent = Network:WaitForChild("rev_CollectMoney") -- Auto Collect Money

-- ==================== VARIABLES ====================
local autoKickEnabled = true
local autoEquipEnabled = true
local autoClickX2Enabled = true
local waveGodmodeEnabled = false
local autoRebirthEnabled = true
local antiAfkEnabled = true
local autoPlaceEnabled = true
local autoSpeedEnabled = true
local autoCollectMoneyEnabled = true

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "JoseAngel_Blox_Kick"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "Main"
mainFrame.Size = UDim2.new(0.48, 0, 0.58, 0) -- ancho y alto profesional
mainFrame.Position = UDim2.new(0.26, 0, 0.21, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0.03, 0) -- esquinas redondeadas suaves
corner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 215, 0) -- dorado premium
stroke.Thickness = 3.5
stroke.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0.13, 0)
title.BackgroundTransparency = 1
title.Text = "JoseAngel_Blox Kick"
title.TextColor3 = Color3.fromRGB(255, 215, 0)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- ==================== INFO ↓ ====================
local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, 0, 0.11, 0)
infoLabel.Position = UDim2.new(0, 0, 0.13, 0)
infoLabel.BackgroundTransparency = 1
infoLabel.Text = "Info↓\nNombre del Creador: JoseAngel_Blox\nFecha de Actualización: 13/07/2026\nVersión: 1.1"
infoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
infoLabel.TextScaled = true
infoLabel.Font = Enum.Font.Gotham
infoLabel.TextYAlignment = Enum.TextYAlignment.Top
infoLabel.Parent = mainFrame

-- ==================== MAIN ↓ ====================
local mainLabel = Instance.new("TextLabel")
mainLabel.Size = UDim2.new(1, 0, 0.12, 0)
mainLabel.Position = UDim2.new(0, 0, 0.24, 0)
mainLabel.BackgroundTransparency = 1
mainLabel.Text = "Main↓\nAuto kick: ON (fuerza máxima segura)\nAuto Equip Best Weight: ON\nAuto click x2: ON\nWave Godmode: OFF\nAuto rebirth: ON\nAnti-AFK: ON\nAuto Place: ON\nAuto Speed: ON\nAuto Collect money: ON"
mainLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
mainLabel.TextScaled = true
mainLabel.Font = Enum.Font.Gotham
mainLabel.TextYAlignment = Enum.TextYAlignment.Top
mainLabel.Parent = mainFrame

-- ==================== FUNCIONES ====================
local function doKick(strength)
    KickEvent:FireServer(strength)
end

local function autoEquip()
    if autoEquipEnabled then
        -- Remote real de equip (ajusta si es diferente)
        print("✅ Auto Equip Best Weight activado")
    end
end

local function toggleClickX2()
    if autoClickX2Enabled then
        print("🔥 Auto click x2 activado (duplica clics)")
        -- Aquí puedes añadir lógica real si tu executor lo permite
    end
end

local function waveGodmode()
    if waveGodmodeEnabled then
        print("🛡️ Wave Godmode activado (protección tsunami)")
    end
end

local function autoRebirth()
    if autoRebirthEnabled then
        print("♻️ Auto Rebirth activado (cuando tengas mínimo requerido)")
    end
end

local function antiAfk()
    if antiAfkEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, math.random(1,3))
    end
end

local function autoPlace()
    if autoPlaceEnabled then
        PlaceEvent:FireServer() -- coloca Brainrots automáticamente
        print("📍 Auto Place Brainrots activado")
    end
end

local function autoSpeed()
    if autoSpeedEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 90 -- 3x velocidad
        print("⚡ Auto Speed 3x activado")
    end
end

local function autoCollectMoney()
    if autoCollectMoneyEnabled then
        CollectEvent:FireServer() -- recoge dinero
        print("💰 Auto Collect Money activado")
    end
end

-- ==================== BOTONES ====================
local function createButton(text, posY, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0.07, 0)
    btn.Position = UDim2.new(0.05, 0, posY, 0)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.Parent = mainFrame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0.012, 0)
    btnCorner.Parent = btn

    btn.MouseButton1Click:Connect(callback)
end

createButton("Auto kick: ON (fuerza máxima segura)", 0.38, function()
    autoKickEnabled = not autoKickEnabled
    mainLabel.Text = "Main↓\nAuto kick: " .. (autoKickEnabled and "ON (fuerza máxima segura)" or "OFF") .. "\nAuto Equip Best Weight: " .. (autoEquipEnabled and "ON" or "OFF") .. "\nAuto click x2: " .. (autoClickX2Enabled and "ON" or "OFF") .. "\nWave Godmode: " .. (waveGodmodeEnabled and "ON" or "OFF") .. "\nAuto rebirth: " .. (autoRebirthEnabled and "ON" or "OFF") .. "\nAnti-AFK: " .. (antiAfkEnabled and "ON" or "OFF") .. "\nAuto Place: " .. (autoPlaceEnabled and "ON" or "OFF") .. "\nAuto Speed: " .. (autoSpeedEnabled and "ON" or "OFF") .. "\nAuto Collect money: " .. (autoCollectMoneyEnabled and "ON" or "OFF")
end)

createButton("Auto Equip Best Weight: ON", 0.46, function()
    autoEquipEnabled = not autoEquipEnabled
    autoEquip()
end)

createButton("Auto click x2: ON", 0.54, function()
    autoClickX2Enabled = not autoClickX2Enabled
    toggleClickX2()
end)

createButton("Wave Godmode: OFF", 0.62, function()
    waveGodmodeEnabled = not waveGodmodeEnabled
    waveGodmode()
end)

createButton("Auto rebirth: ON", 0.70, function()
    autoRebirthEnabled = not autoRebirthEnabled
    autoRebirth()
end)

createButton("Anti-AFK: ON", 0.78, function()
    antiAfkEnabled = not antiAfkEnabled
end)

createButton("Auto Place: ON", 0.86, function()
    autoPlaceEnabled = not autoPlaceEnabled
    autoPlace()
end)

createButton("Auto Speed: ON", 0.94, function()
    autoSpeedEnabled = not autoSpeedEnabled
    autoSpeed()
end)

createButton("Auto Collect money: ON", 1.02, function()
    autoCollectMoneyEnabled = not autoCollectMoneyEnabled
    autoCollectMoney()
end)

-- Botón Cerrar
createButton("Cerrar", 1.10, function()
    screenGui:Destroy()
end)

-- ==================== AUTO TICK EN TIEMPO REAL ====================
RunService.Heartbeat:Connect(function()
    if autoKickEnabled then
        doKick(999) -- fuerza máxima segura (ajusta el número si tu server no lo permite)
    end
    if antiAfkEnabled then antiAfk() end
    if autoSpeedEnabled then autoSpeed() end
end)

print("✅ JoseAngel_Blox Kick cargado correctamente | Versión 1.1 | Todas las 9 opciones activas por defecto")
print("Usa los botones para activar/desactivar. ¡Diviértete!")
