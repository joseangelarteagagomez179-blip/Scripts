--[[
🌴 JoseAngel_Blox Jungle Events
   TP a tu base al instante — para Kick a Lucky Block
   Compatible con PC y celular
--]]

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- ============================================================
-- 🔍 Buscar base
-- ============================================================
local function FindBase()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        local name = obj.Name:lower()
        if (name:find("plot") or name:find("base") or name:find("spawn")
            or name:find("safe") or name:find("home") or name:find("tycoon"))
            and obj:IsA("BasePart") then
            return obj
        end
    end

    local playerName = player.Name:lower()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        local name = obj.Name:lower()
        if name:find(playerName) and obj:IsA("BasePart") then
            return obj
        end
    end

    local spawn = Workspace:FindFirstChild("SpawnLocation")
    if spawn then return spawn end

    return nil
end

-- ============================================================
-- 🚀 TP a base
-- ============================================================
local function TeleportToBase()
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local base = FindBase()
    if base then
        hrp.CFrame = CFrame.new(base.Position + Vector3.new(0, 5, 0))
    else
        hrp.CFrame = CFrame.new(0, 10, 0)
    end
end

-- ============================================================
-- 🌿 INTERFAZ — Temática Jungla
-- ============================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "JoseAngelBloxJungleEvents"
screenGui.ResetOnSpawn = false
screenGui.Parent = CoreGui

-- Panel principal
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 280)
mainFrame.Position = UDim2.new(0.5, -110, 0.5, -140)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 55, 30)
mainFrame.BackgroundTransparency = 0.08
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Borde redondeado
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 18)
corner.Parent = mainFrame

-- Sombra/borde decorativo
local borderFrame = Instance.new("Frame")
borderFrame.Size = UDim2.new(1, -4, 1, -4)
borderFrame.Position = UDim2.new(0, 2, 0, 2)
borderFrame.BackgroundColor3 = Color3.fromRGB(30, 75, 40)
borderFrame.BackgroundTransparency = 0
borderFrame.BorderSizePixel = 0
local cornerBorder = Instance.new("UICorner")
cornerBorder.CornerRadius = UDim.new(0, 16)
cornerBorder.Parent = borderFrame
borderFrame.Parent = mainFrame

-- Barra superior verde (follaje)
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 6)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.fromRGB(50, 180, 70)
topBar.BackgroundTransparency = 0
topBar.BorderSizePixel = 0
local cornerTop = Instance.new("UICorner")
cornerTop.CornerRadius = UDim.new(0, 16)
cornerTop.Parent = topBar
topBar.Parent = mainFrame

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 10)
title.BackgroundTransparency = 1
title.Text = "🌴 JoseAngel_Blox"
title.TextColor3 = Color3.fromRGB(255, 255, 200)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.Parent = mainFrame

-- Subtítulo
local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, 0, 0, 24)
subtitle.Position = UDim2.new(0, 0, 0, 48)
subtitle.BackgroundTransparency = 1
subtitle.Text = "🍌 Jungle Events"
subtitle.TextColor3 = Color3.fromRGB(144, 238, 144)
subtitle.TextSize = 14
subtitle.Font = Enum.Font.GothamSemibold
subtitle.TextScaled = true
subtitle.Parent = mainFrame

-- Separador decorativo
local divider = Instance.new("TextLabel")
divider.Size = UDim2.new(0.8, 0, 0, 20)
divider.Position = UDim2.new(0.1, 0, 0, 72)
divider.BackgroundTransparency = 1
divider.Text = "🌿 🌺 🌿"
divider.TextColor3 = Color3.fromRGB(200, 255, 180)
divider.TextSize = 14
divider.Font = Enum.Font.Gotham
divider.TextScaled = true
divider.Parent = mainFrame

-- Indicador de estado
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0.9, 0, 0, 28)
statusLabel.Position = UDim2.new(0.05, 0, 0, 98)
statusLabel.BackgroundColor3 = Color3.fromRGB(15, 40, 20)
statusLabel.BackgroundTransparency = 0.4
statusLabel.TextColor3 = Color3.fromRGB(200, 255, 200)
statusLabel.Text = "🌴 Listo para usar"
statusLabel.TextSize = 13
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextScaled = true
local cornerStatus = Instance.new("UICorner")
cornerStatus.CornerRadius = UDim.new(0, 8)
cornerStatus.Parent = statusLabel
statusLabel.Parent = mainFrame

-- Botón TP grande
local tpButton = Instance.new("TextButton")
tpButton.Size = UDim2.new(0.8, 0, 0, 65)
tpButton.Position = UDim2.new(0.1, 0, 0, 140)
tpButton.BackgroundColor3 = Color3.fromRGB(210, 160, 40)
tpButton.BackgroundTransparency = 0.1
tpButton.BorderSizePixel = 0
tpButton.Text = "🚀 TP A MI BASE"
tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
tpButton.TextSize = 18
tpButton.Font = Enum.Font.GothamBold
tpButton.TextScaled = true
local cornerBtn = Instance.new("UICorner")
cornerBtn.CornerRadius = UDim.new(0, 14)
cornerBtn.Parent = tpButton
tpButton.Parent = mainFrame

-- Brillo del botón
local btnGlow = Instance.new("Frame")
btnGlow.Size = UDim2.new(0.8, 0, 0, 65)
btnGlow.Position = UDim2.new(0.1, 0, 0, 140)
btnGlow.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
btnGlow.BackgroundTransparency = 0.7
btnGlow.BorderSizePixel = 0
local cornerGlow = Instance.new("UICorner")
cornerGlow.CornerRadius = UDim.new(0, 14)
cornerGlow.Parent = btnGlow
btnGlow.Parent = mainFrame
btnGlow.ZIndex = 0
tpButton.ZIndex = 1

-- Feedback
local feedbackLabel = Instance.new("TextLabel")
feedbackLabel.Size = UDim2.new(0.9, 0, 0, 24)
feedbackLabel.Position = UDim2.new(0.05, 0, 0, 220)
feedbackLabel.BackgroundTransparency = 1
feedbackLabel.Text = ""
feedbackLabel.TextColor3 = Color3.fromRGB(200, 255, 180)
feedbackLabel.TextSize = 12
feedbackLabel.Font = Enum.Font.Gotham
feedbackLabel.TextScaled = true
feedbackLabel.Parent = mainFrame

-- Decoración inferior
local bottomDeco = Instance.new("TextLabel")
bottomDeco.Size = UDim2.new(0.9, 0, 0, 22)
bottomDeco.Position = UDim2.new(0.05, 0, 0, 250)
bottomDeco.BackgroundTransparency = 1
bottomDeco.Text = "🦎 🐒 🌴"
bottomDeco.TextColor3 = Color3.fromRGB(180, 255, 160)
bottomDeco.TextSize = 14
bottomDeco.Font = Enum.Font.Gotham
bottomDeco.TextScaled = true
bottomDeco.Parent = mainFrame

-- ============================================================
-- 🎮 Funcionalidad del botón
-- ============================================================

local function SetStatus(text, isGood)
    statusLabel.Text = text
    if isGood then
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        statusLabel.TextColor3 = Color3.fromRGB(255, 180, 100)
    end
    task.delay(3, function()
        statusLabel.Text = "🌴 Listo para usar"
        statusLabel.TextColor3 = Color3.fromRGB(200, 255, 200)
    end)
end

local function ShowFeedback(text)
    feedbackLabel.Text = text
    task.delay(2, function()
        feedbackLabel.Text = ""
    end)
end

-- Animación al presionar
tpButton.MouseButton1Down:Connect(function()
    tpButton.TextScaled = false
    tpButton.TextSize = 16
    tpButton.BackgroundColor3 = Color3.fromRGB(180, 130, 20)
end)

tpButton.MouseButton1Up:Connect(function()
    tpButton.TextScaled = true
    tpButton.BackgroundColor3 = Color3.fromRGB(210, 160, 40)
end)

-- TP action
local function OnTPClick()
    local char = player.Character
    if not char then
        SetStatus("❌ Sin personaje en el juego", false)
        ShowFeedback("Entra al juego primero")
        return
    end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then
        SetStatus("❌ No se encontró el personaje", false)
        ShowFeedback("Espera a cargar")
        return
    end

    SetStatus("🚀 Teletransportando...", true)
    TeleportToBase()
    ShowFeedback("✅ Llegaste a tu base 🏠")
    task.wait(1)
    SetStatus("🌴 Listo para usar", true)
end

tpButton.MouseButton1Click:Connect(OnTPClick)
tpButton.TouchTap:Connect(OnTPClick)

-- Tecla END como atajo en PC
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.End then
        OnTPClick()
    end
end)

-- ============================================================
-- 🚀 Inicio
-- ============================================================
print("🌴 JoseAngel_Blox Jungle Events cargado!")
print("   🚀 Toca el botón o presiona END para TP a tu base")
