--[[
╔══════════════════════════════════════════════════════════╗
║              🐒  JoseAngel_Blox Jungle events           ║
║                                                          ║
║   🌴 Modo Flotar — camina en el aire, no caigas a la     ║
║      lava cuando salgas del obby                         ║
║   🚀 Velocidad extra — corre más rápido en el aire       ║
╚══════════════════════════════════════════════════════════╝
--]]

-- ⚙️ CONFIGURACIÓN
local Settings = {
    DefaultSpeed = 22,
    BoostSpeed = 65,
}

-- 🧩 SERVICIOS
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LP = Players.LocalPlayer

-- 🎨 GUI JUNGLA (cuadrada + esquinas redondeadas)
local gui = Instance.new("ScreenGui")
gui.Name = "JoseAngelBloxGUI"
gui.ResetOnSpawn = false

local box = Instance.new("Frame")
box.Size = UDim2.new(0, 75, 0, 85)
box.Position = UDim2.new(0.5, -37, 0.80, -42)
box.BackgroundColor3 = Color3.fromRGB(13, 45, 20)
box.BackgroundTransparency = 0.1
box.BorderSizePixel = 0
box.Active = true
box.Draggable = true
box.Parent = gui

-- 🟢 Esquinas redondeadas (14px)
Instance.new("UICorner").CornerRadius = UDim.new(0, 14)
Instance.new("UICorner").Parent = box

-- Borde verde brillante
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(50, 205, 80)
stroke.Thickness = 2.5
stroke.Parent = box

-- 🍃 Decoración: hojitas + enredaderas
local function crearHoja(p, r, s, c)
    local h = Instance.new("Frame")
    h.Size = UDim2.new(0, s or 12, 0, s or 12)
    h.Position = p
    h.BackgroundColor3 = c or Color3.fromRGB(34, 139, 34)
    h.BackgroundTransparency = 0.2
    h.BorderSizePixel = 0
    h.Rotation = r or 0
    Instance.new("UICorner").CornerRadius = UDim.new(0, 6)
    Instance.new("UICorner").Parent = h
    h.Parent = box
end
local function crearLinea(p, sz, r, c)
    local l = Instance.new("Frame")
    l.Size = UDim2.new(0, sz.X, 0, sz.Y)
    l.Position = p
    l.BackgroundColor3 = c or Color3.fromRGB(34, 139, 34)
    l.BackgroundTransparency = 0.3
    l.BorderSizePixel = 0
    l.Rotation = r or 0
    Instance.new("UICorner").CornerRadius = UDim.new(0, 3)
    Instance.new("UICorner").Parent = l
    l.Parent = box
end
crearHoja(UDim2.new(0, -4, 0, -4), 45, 14, Color3.fromRGB(50, 180, 50))
crearHoja(UDim2.new(1, -8, 0, -4), -45, 14, Color3.fromRGB(40, 160, 40))
crearHoja(UDim2.new(0, -4, 1, -8), -45, 14, Color3.fromRGB(60, 200, 60))
crearHoja(UDim2.new(1, -8, 1, -8), 45, 14, Color3.fromRGB(34, 139, 34))
crearLinea(UDim2.new(0, -3, 0, 20), Vector2.new(4, 25), 10, Color3.fromRGB(34, 120, 34))
crearLinea(UDim2.new(1, -1, 0, 15), Vector2.new(4, 30), -10, Color3.fromRGB(40, 130, 40))

-- 🎯 BOTÓN FLOTAR
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(1, -10, 0, 32)
toggleBtn.Position = UDim2.new(0, 5, 0, 8)
toggleBtn.BackgroundColor3 = Color3.fromRGB(20, 70, 30)
toggleBtn.BackgroundTransparency = 0.3
toggleBtn.BorderSizePixel = 0
toggleBtn.Text = "🌴 FLOTAR"
toggleBtn.TextSize = 14
toggleBtn.TextColor3 = Color3.fromRGB(200, 255, 200)
toggleBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner").CornerRadius = UDim.new(0, 8)
Instance.new("UICorner").Parent = toggleBtn
toggleBtn.Parent = box

-- 📊 BARRA DE VELOCIDAD
local speedBar = Instance.new("Frame")
speedBar.Size = UDim2.new(1, -10, 0, 6)
speedBar.Position = UDim2.new(0, 5, 0, 44)
speedBar.BackgroundColor3 = Color3.fromRGB(10, 35, 15)
speedBar.BackgroundTransparency = 0.4
speedBar.BorderSizePixel = 0
Instance.new("UICorner").CornerRadius = UDim.new(0, 3)
Instance.new("UICorner").Parent = speedBar
speedBar.Parent = box

local speedFill = Instance.new("Frame")
speedFill.Size = UDim2.new(0.4, 0, 1, 0)
speedFill.BackgroundColor3 = Color3.fromRGB(50, 220, 80)
speedFill.BorderSizePixel = 0
Instance.new("UICorner").CornerRadius = UDim.new(0, 3)
Instance.new("UICorner").Parent = speedFill
speedFill.Parent = speedBar

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, -10, 0, 14)
speedLabel.Position = UDim2.new(0, 5, 0, 52)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "🚀 22"
speedLabel.TextSize = 11
speedLabel.TextColor3 = Color3.fromRGB(180, 255, 180)
speedLabel.Font = Enum.Font.SourceSans
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = box

-- ⚡ BOTÓN TURBO
local boostBtn = Instance.new("TextButton")
boostBtn.Size = UDim2.new(1, -10, 0, 20)
boostBtn.Position = UDim2.new(0, 5, 0, 62)
boostBtn.BackgroundColor3 = Color3.fromRGB(180, 120, 20)
boostBtn.BackgroundTransparency = 0.25
boostBtn.BorderSizePixel = 0
boostBtn.Text = "⚡ TURBO ⚡"
boostBtn.TextSize = 11
boostBtn.TextColor3 = Color3.fromRGB(255, 240, 150)
boostBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner").CornerRadius = UDim.new(0, 6)
Instance.new("UICorner").Parent = boostBtn
boostBtn.Parent = box

-- 🔄 ESTADO
local Floating = false
local BoostActive = false
local CurrentSpeed = Settings.DefaultSpeed
local Connection = nil

-- 📡 FUNCIÓN DE FLOTACIÓN
local function startFloating()
    local char = LP.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not (hrp and hum) then return end

    local anchorY = hrp.Position.Y  -- Guarda la altura actual

    Connection = RunService.Heartbeat:Connect(function()
        if not Floating then return end
        local c = LP.Character
        if not c then return end
        local root = c:FindFirstChild("HumanoidRootPart")
        local human = c:FindFirstChildOfClass("Humanoid")
        if not (root and human) then return end

        -- ⭐ FIJAR ALTURA: no cae, se mantiene donde estás
        local pos = root.Position
        pos = Vector3.new(pos.X, anchorY, pos.Z)
        root.CFrame = CFrame.new(pos) * (root.CFrame - root.Position)

        -- ⭐ APLICAR VELOCIDAD
        human.WalkSpeed = CurrentSpeed
    end)
end

local function stopFloating()
    if Connection then
        Connection:Disconnect()
        Connection = nil
    end
    local char = LP.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = 16 end
    end
end

-- 🎯 TOGGLE FLOTAR
toggleBtn.MouseButton1Click:Connect(function()
    Floating = not Floating
    if Floating then
        local char = LP.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                toggleBtn.Text = "🌴 FLOTANDO"
                toggleBtn.BackgroundColor3 = Color3.fromRGB(20, 100, 40)
                box.BackgroundColor3 = Color3.fromRGB(20, 60, 30)
                stroke.Color = Color3.fromRGB(100, 255, 100)
                startFloating()
            end
        end
    else
        toggleBtn.Text = "🌴 FLOTAR"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(20, 70, 30)
        box.BackgroundColor3 = Color3.fromRGB(13, 45, 20)
        stroke.Color = Color3.fromRGB(50, 205, 80)
        stopFloating()
    end
end)

-- ⚡ TOGGLE TURBO
boostBtn.MouseButton1Click:Connect(function()
    BoostActive = not BoostActive
    if BoostActive then
        CurrentSpeed = Settings.BoostSpeed
        boostBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 20)
        boostBtn.Text = "⚡ TURBO ON ⚡"
        boostBtn.TextColor3 = Color3.fromRGB(255, 255, 200)
        speedFill:TweenSize(UDim2.new(1, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
        speedFill.BackgroundColor3 = Color3.fromRGB(255, 150, 50)
        speedLabel.Text = "🚀 65"
    else
        CurrentSpeed = Settings.DefaultSpeed
        boostBtn.BackgroundColor3 = Color3.fromRGB(180, 120, 20)
        boostBtn.Text = "⚡ TURBO ⚡"
        boostBtn.TextColor3 = Color3.fromRGB(255, 240, 150)
        speedFill:TweenSize(UDim2.new(0.4, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
        speedFill.BackgroundColor3 = Color3.fromRGB(50, 220, 80)
        speedLabel.Text = "🚀 22"
    end
end)

-- Reconectar al morir
LP.CharacterAdded:Connect(function()
    wait(1)
    if Floating then startFloating() end
end)

-- 🖥️ INICIO
gui.Parent = CoreGui
print("🐒 JoseAngel_Blox Jungle events cargado!")
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "🐒 JoseAngel Blox",
    Text = "🌴 Toca FLOTAR para no caer a la lava!",
    Duration = 4
})
