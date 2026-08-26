-- ============================================
-- 🎩 JoseAngel_Blox Bonds
-- Creado por JoseAngel_Blox
-- Auto Farm Bonds: Banco | Castillo | Fuerte
-- ============================================

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- 🔧 CONFIGURACIÓN
local GUI_NAME = "JoseAngel_Blox Bonds"
local BOND_COLOR = Color3.fromRGB(255, 0, 0) -- Rojo
local TELEPORT_DELAY = 0.5
local COLLECT_DELAY = 0.3
local CHECK_INTERVAL = 1

-- 📍 UBICACIONES DE BONDS (actualiza según tu juego)
local bondLocations = {
    {name = "Banco", pos = Vector3.new(0, 10, 0)},      -- ⚠️ CAMBIA ESTAS COORDENADAS
    {name = "Castillo", pos = Vector3.new(100, 10, 100)},
    {name = "Fuerte", pos = Vector3.new(-80, 10, -80)},
    {name = "Pueblo 1", pos = Vector3.new(50, 10, -50)},
    {name = "Pueblo 2", pos = Vector3.new(-50, 10, 50)},
}

-- ============================================
-- 🖥️ CREACIÓN DE GUI
-- ============================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = GUI_NAME
screenGui.Parent = player:WaitForChild("PlayerGui") or gethui()

-- 📦 Frame Principal (cuadrado con esquinas redondeadas)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 320)
frame.Position = UDim2.new(0.5, -125, 0.5, -160)
frame.BackgroundColor3 = BOND_COLOR
frame.BackgroundTransparency = 0.15
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Parent = screenGui

-- Esquinas redondeadas (usando UI Corner)
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = frame

-- Borde interior (opcional)
local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(200, 0, 0)
stroke.Transparency = 0.3
stroke.Parent = frame

-- 📝 Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 10)
title.BackgroundTransparency = 1
title.Text = "JoseAngel_Blox Bonds"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- 👤 Créditos
local credit = Instance.new("TextLabel")
credit.Size = UDim2.new(1, 0, 0, 30)
credit.Position = UDim2.new(0, 0, 0, 55)
credit.BackgroundTransparency = 1
credit.Text = "Creado por JoseAngel_Blox"
credit.TextColor3 = Color3.fromRGB(200, 200, 200)
credit.TextScaled = true
credit.Font = Enum.Font.Gotham
credit.Parent = frame

-- Línea separadora
local line = Instance.new("Frame")
line.Size = UDim2.new(0.9, 0, 0, 2)
line.Position = UDim2.new(0.05, 0, 0, 90)
line.BackgroundColor3 = Color3.fromRGB(255, 200, 200)
line.BackgroundTransparency = 0.5
line.Parent = frame

-- 🔘 Botón Auto Farm
local farmButton = Instance.new("TextButton")
farmButton.Size = UDim2.new(0.8, 0, 0, 50)
farmButton.Position = UDim2.new(0.1, 0, 0, 105)
farmButton.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
farmButton.BackgroundTransparency = 0.2
farmButton.Text = "▶ ACTIVAR FARM"
farmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
farmButton.TextScaled = true
farmButton.Font = Enum.Font.GothamBold
farmButton.Parent = frame

local farmCorner = Instance.new("UICorner")
farmCorner.CornerRadius = UDim.new(0, 8)
farmCorner.Parent = farmButton

-- 📊 Estado
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 30)
statusLabel.Position = UDim2.new(0, 0, 0, 170)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "⚪ Inactivo"
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.TextScaled = true
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = frame

-- 📍 Ubicación actual
local locationLabel = Instance.new("TextLabel")
locationLabel.Size = UDim2.new(1, 0, 0, 30)
locationLabel.Position = UDim2.new(0, 0, 0, 200)
locationLabel.BackgroundTransparency = 1
locationLabel.Text = "📍 Esperando..."
locationLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
locationLabel.TextScaled = true
locationLabel.Font = Enum.Font.Gotham
locationLabel.Parent = frame

-- 🟢 Botón de pausa
local pauseButton = Instance.new("TextButton")
pauseButton.Size = UDim2.new(0.35, 0, 0, 35)
pauseButton.Position = UDim2.new(0.1, 0, 0, 245)
pauseButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
pauseButton.BackgroundTransparency = 0.3
pauseButton.Text = "⏸ Pausa"
pauseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
pauseButton.TextScaled = true
pauseButton.Font = Enum.Font.Gotham
pauseButton.Parent = frame

local pauseCorner = Instance.new("UICorner")
pauseCorner.CornerRadius = UDim.new(0, 6)
pauseCorner.Parent = pauseButton

-- 🔴 Botón de parar
local stopButton = Instance.new("TextButton")
stopButton.Size = UDim2.new(0.35, 0, 0, 35)
stopButton.Position = UDim2.new(0.55, 0, 0, 245)
stopButton.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
stopButton.BackgroundTransparency = 0.3
stopButton.Text = "⏹ Parar"
stopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
stopButton.TextScaled = true
stopButton.Font = Enum.Font.Gotham
stopButton.Parent = frame

local stopCorner = Instance.new("UICorner")
stopCorner.CornerRadius = UDim.new(0, 6)
stopCorner.Parent = stopButton

-- 🟢 Botón de cerrar GUI (opcional)
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -40, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeButton.BackgroundTransparency = 0.6
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextScaled = true
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = frame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- ============================================
-- 🧠 LÓGICA DE AUTO FARM
-- ============================================
local isFarming = false
local isPaused = false
local currentTarget = nil
local farmLoop = nil
local bondCollector = nil

-- Función para recoger bonos cercanos
local function collectNearbyBonds()
    local collection = game:GetService("CollectionService")
    local bondObjects = collection:GetTagged("Bond") -- ⚠️ Cambia el tag si es necesario
    
    if #bondObjects == 0 then
        -- Si no encuentra con tag, busca por nombre
        bondObjects = {}
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Part") and (v.Name:lower():find("bond") or v.Name:lower():find("coin")) then
                table.insert(bondObjects, v)
            end
        end
    end
    
    for _, bond in pairs(bondObjects) do
        local distance = (bond.Position - rootPart.Position).Magnitude
        if distance < 20 then -- Rango de recolección
            -- Simula el toque o fire el evento correspondiente
            local fire = bond:FindFirstChild("TouchInterest")
            if fire then
                fire:FireServer()
            end
            task.wait(COLLECT_DELAY)
        end
    end
end

-- Función principal de farm
local function startFarming()
    if isFarming then return end
    isFarming = true
    isPaused = false
    statusLabel.Text = "🟢 Farmeando..."
    statusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
    farmButton.Text = "⏹ DETENER"
    
    farmLoop = game:GetService("RunService").Stepped:Connect(function()
        if isPaused then return end
        
        -- 1. Buscar ubicaciones disponibles
        local bestLocation = nil
        local bestDistance = math.huge
        
        for _, loc in pairs(bondLocations) do
            local dist = (loc.pos - rootPart.Position).Magnitude
            if dist < bestDistance then
                bestDistance = dist
                bestLocation = loc
            end
        end
        
        if bestLocation then
            currentTarget = bestLocation.name
            locationLabel.Text = "📍 " .. bestLocation.name
            locationLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
            
            -- Teleport a la ubicación
            rootPart.CFrame = CFrame.new(bestLocation.pos)
            task.wait(TELEPORT_DELAY)
            
            -- Recoger bonos
            collectNearbyBonds()
            task.wait(CHECK_INTERVAL)
        end
    end)
end

-- Función para detener el farm
local function stopFarming()
    isFarming = false
    isPaused = false
    if farmLoop then
        farmLoop:Disconnect()
        farmLoop = nil
    end
    statusLabel.Text = "⚪ Detenido"
    statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    locationLabel.Text = "📍 Esperando..."
    farmButton.Text = "▶ ACTIVAR FARM"
end

-- Función para pausar/reanudar
local function togglePause()
    if not isFarming then return end
    isPaused = not isPaused
    pauseButton.Text = isPaused and "▶ Reanudar" or "⏸ Pausa"
    statusLabel.Text = isPaused and "⏸ Pausado" or "🟢 Farmeando..."
    statusLabel.TextColor3 = isPaused and Color3.fromRGB(255, 200, 0) or Color3.fromRGB(0, 255, 100)
end

-- ============================================
-- 🎮 EVENTOS DE BOTONES
-- ============================================
farmButton.MouseButton1Click:Connect(function()
    if isFarming then
        stopFarming()
    else
        startFarming()
    end
end)

pauseButton.MouseButton1Click:Connect(togglePause)

stopButton.MouseButton1Click:Connect(stopFarming)

-- ============================================
-- 🧹 LIMPIEZA AL MORIR
-- ============================================
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    rootPart = newChar:WaitForChild("HumanoidRootPart")
    if isFarming then
        stopFarming()
        task.wait(2)
        startFarming()
    end
end)

-- ============================================
-- 🔧 COORDENADAS - ¡ACTUALIZA ESTO!
-- ============================================
print("⚠️ ADVERTENCIA: Actualiza las coordenadas en 'bondLocations'")
print("📌 Usa el comando: print(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)")
print("📌 Luego reemplaza los valores Vector3.new en el script")
print("")
print("✅ Script JoseAngel_Blox Bonds cargado correctamente")
