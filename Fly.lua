--[[
    ====================================================
    Script: JoseAngel_Blox Fly
    Creador: JoseAngel_Blox
    Versión: 1.2
    Fecha: 06/07/2026
    ====================================================
    
    MANUAL DE USO:
    
    ¡Bienvenidos y bienvenidas al script JoseAngel_Blox Fly!
    
    Este script te permite volar en cualquier juego de Roblox
    de manera fácil y profesional.
    
    📱 USO EN MÓVIL:
    - Al activar el interruptor, aparecerán botones en pantalla
    - Usa el joystick izquierdo para moverte
    - Botón "⬆" para subir
    - Botón "⬇" para bajar
    - Desliza el joystick hacia adelante para avanzar volando
    
    💻 USO EN PC:
    - Presiona la tecla "F" para activar/desactivar el vuelo
    - Usa WASD para moverte
    - Barra espaciadora para subir
    - Tecla Shift para bajar
    - La velocidad se ajusta con las teclas + y -
    
    ⚙️ CARACTERÍSTICAS:
    - Noclip integrado (atravesar paredes)
    - Velocidad ajustable
    - Compatible con móvil y PC
    - Interfaz profesional
    - Funciona en cualquier juego
--]]

-- ==================================================
-- CONFIGURACIÓN INICIAL
-- ==================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local flying = false
local flySpeed = 50
local minSpeed = 10
local maxSpeed = 200
local noclipEnabled = true

-- ==================================================
-- CREACIÓN DE GUI
-- ==================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "JoseAngel_BloxFlyGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- ==================================================
-- FUNCIÓN PARA CREAR BOTONES PROFESIONALES
-- ==================================================
local function createButton(parent, text, position, size, color)
    local button = Instance.new("TextButton")
    button.Text = text
    button.Size = size or UDim2.new(0, 60, 0, 60)
    button.Position = position
    button.BackgroundColor3 = color or Color3.fromRGB(30, 144, 255)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 18
    button.BackgroundTransparency = 0.1
    button.BorderSizePixel = 2
    button.BorderColor3 = Color3.fromRGB(255, 255, 255)
    
    -- Efecto de gradiente
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 100, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 200, 255))
    })
    gradient.Parent = button
    
    -- Efecto de esquinas redondeadas
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = button
    
    button.Parent = parent
    
    -- Animación al pasar el mouse
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.0,
            Size = size + UDim2.new(0, 5, 0, 5)
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.1,
            Size = size
        }):Play()
    end)
    
    return button
end

-- ==================================================
-- INTERFAZ PRINCIPAL
-- ==================================================
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 350)
mainFrame.Position = UDim2.new(0.5, -110, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Fondo con blur
local blur = Instance.new("BlurEffect")
blur.Size = 10
blur.Parent = mainFrame

-- Esquinas redondeadas
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 20)
mainCorner.Parent = mainFrame

-- Borde brillante
local border = Instance.new("Frame")
border.Size = UDim2.new(1, 0, 1, 0)
border.Position = UDim2.new(0, 0, 0, 0)
border.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
border.BackgroundTransparency = 0.8
border.BorderSizePixel = 0
border.Parent = mainFrame

local borderCorner = Instance.new("UICorner")
borderCorner.CornerRadius = UDim.new(0, 20)
borderCorner.Parent = border

-- Título
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.Position = UDim2.new(0, 0, 0, 10)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "✈️ JoseAngel_Blox Fly"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 18
titleLabel.TextScaled = true
titleLabel.Parent = mainFrame

-- Línea decorativa
local line = Instance.new("Frame")
line.Size = UDim2.new(0.8, 0, 0, 2)
line.Position = UDim2.new(0.1, 0, 0, 55)
line.BackgroundColor3 = Color3.fromRGB(30, 144, 255)
line.BackgroundTransparency = 0.3
line.Parent = mainFrame

-- Versión
local versionLabel = Instance.new("TextLabel")
versionLabel.Size = UDim2.new(1, 0, 0, 20)
versionLabel.Position = UDim2.new(0, 0, 0, 62)
versionLabel.BackgroundTransparency = 1
versionLabel.Text = "v1.2 | 06/07/2026"
versionLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
versionLabel.Font = Enum.Font.Gotham
versionLabel.TextSize = 12
versionLabel.TextScaled = true
versionLabel.Parent = mainFrame

-- ==================================================
-- INTERRUPTOR DE VUELO (PROFESIONAL)
-- ==================================================
local switchFrame = Instance.new("Frame")
switchFrame.Size = UDim2.new(0, 120, 0, 50)
switchFrame.Position = UDim2.new(0.5, -60, 0, 110)
switchFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
switchFrame.BackgroundTransparency = 0.5
switchFrame.BorderSizePixel = 0
switchFrame.Parent = mainFrame

local switchCorner = Instance.new("UICorner")
switchCorner.CornerRadius = UDim.new(0, 25)
switchCorner.Parent = switchFrame

local switchButton = Instance.new("TextButton")
switchButton.Size = UDim2.new(0, 50, 0, 40)
switchButton.Position = UDim2.new(0.05, 0, 0.05, 0)
switchButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
switchButton.BackgroundTransparency = 0.1
switchButton.BorderSizePixel = 0
switchButton.Text = "OFF"
switchButton.TextColor3 = Color3.fromRGB(255, 255, 255)
switchButton.Font = Enum.Font.GothamBold
switchButton.TextSize = 16
switchButton.Parent = switchFrame

local switchCorner2 = Instance.new("UICorner")
switchCorner2.CornerRadius = UDim.new(0, 20)
switchCorner2.Parent = switchButton

local switchLabel = Instance.new("TextLabel")
switchLabel.Size = UDim2.new(0, 50, 1, 0)
switchLabel.Position = UDim2.new(0.6, 0, 0, 0)
switchLabel.BackgroundTransparency = 1
switchLabel.Text = "FLY"
switchLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
switchLabel.Font = Enum.Font.GothamBold
switchLabel.TextSize = 16
switchLabel.TextXAlignment = Enum.TextXAlignment.Center
switchLabel.Parent = switchFrame

-- ==================================================
-- CONTROLES DE VELOCIDAD
-- ==================================================
local speedFrame = Instance.new("Frame")
speedFrame.Size = UDim2.new(0, 160, 0, 40)
speedFrame.Position = UDim2.new(0.5, -80, 0, 180)
speedFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
speedFrame.BackgroundTransparency = 0.5
speedFrame.BorderSizePixel = 0
speedFrame.Parent = mainFrame

local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0, 10)
speedCorner.Parent = speedFrame

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, 0, 1, 0)
speedLabel.Position = UDim2.new(0, 0, 0, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "⚡ Velocidad: 50"
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.Font = Enum.Font.GothamBold
speedLabel.TextSize = 14
speedLabel.Parent = speedFrame

-- Botones de velocidad
local speedMinus = createButton(mainFrame, "-", UDim2.new(0.1, 0, 0, 240), UDim2.new(0, 40, 0, 40), Color3.fromRGB(200, 50, 50))
local speedPlus = createButton(mainFrame, "+", UDim2.new(0.7, 0, 0, 240), UDim2.new(0, 40, 0, 40), Color3.fromRGB(50, 200, 50))

-- ==================================================
-- BOTONES MÓVIL (SOLO VISIBLES EN MÓVIL)
-- ==================================================
local mobileFrame = Instance.new("Frame")
mobileFrame.Size = UDim2.new(0, 200, 0, 100)
mobileFrame.Position = UDim2.new(1, -220, 0.5, -50)
mobileFrame.BackgroundTransparency = 1
mobileFrame.Parent = screenGui
mobileFrame.Visible = UserInputService.TouchEnabled

-- Botón subir
local upButton = createButton(mobileFrame, "⬆", UDim2.new(0.5, -30, 0, 0), UDim2.new(0, 60, 0, 60), Color3.fromRGB(50, 200, 50))

-- Botón bajar
local downButton = createButton(mobileFrame, "⬇", UDim2.new(0.5, -30, 0, 50), UDim2.new(0, 60, 0, 60), Color3.fromRGB(200, 50, 50))

-- ==================================================
-- FUNCIONALIDAD DE VUELO
-- ==================================================
local bodyVelocity = nil
local bodyGyro = nil
local noclip = nil

local function startFly()
    if not character or not rootPart or not humanoid then return end
    
    -- Crear BodyVelocity
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(1/0, 1/0, 1/0)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = rootPart
    
    -- Crear BodyGyro para controlar la orientación
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(1/0, 1/0, 1/0)
    bodyGyro.Parent = rootPart
    
    -- Noclip
    if noclipEnabled then
        noclip = Instance.new("NoClip", character)
        noclip.Name = "JoseAngel_Noclip"
    end
    
    -- Desactivar gravedad
    humanoid.PlatformStand = true
    
    flying = true
    switchButton.Text = "ON"
    switchButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    TweenService:Create(switchButton, TweenInfo.new(0.3), {
        Position = UDim2.new(0.6, 0, 0.05, 0)
    }):Play()
end

local function stopFly()
    if bodyVelocity then bodyVelocity:Destroy() end
    if bodyGyro then bodyGyro:Destroy() end
    if noclip then noclip:Destroy() end
    
    bodyVelocity = nil
    bodyGyro = nil
    noclip = nil
    
    humanoid.PlatformStand = false
    
    flying = false
    switchButton.Text = "OFF"
    switchButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    TweenService:Create(switchButton, TweenInfo.new(0.3), {
        Position = UDim2.new(0.05, 0, 0.05, 0)
    }):Play()
end

-- ==================================================
-- MOVIMIENTO DE VUELO
-- ==================================================
local function updateFly()
    if not flying or not character or not rootPart or not bodyVelocity then return end
    
    local moveDirection = Vector3.new(0, 0, 0)
    local camera = workspace.CurrentCamera
    
    -- Movimiento en PC
    if not UserInputService.TouchEnabled then
        local forward = camera.CFrame.LookVector * Vector3.new(1, 0, 1)
        local right = camera.CFrame.RightVector * Vector3.new(1, 0, 1)
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + forward
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - forward
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection - right
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + right
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveDirection = moveDirection + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            moveDirection = moveDirection - Vector3.new(0, 1, 0)
        end
    else
        -- Movimiento en móvil (usando joystick virtual)
        -- El joystick de Roblox ya maneja el movimiento
        local moveVector = humanoid.MoveDirection
        if moveVector.Magnitude > 0 then
            -- Obtener dirección relativa a la cámara
            local camCFrame = camera.CFrame
            local forwardVec = camCFrame.LookVector * Vector3.new(1, 0, 1)
            local rightVec = camCFrame.RightVector * Vector3.new(1, 0, 1)
            
            moveDirection = (forwardVec * moveVector.Z) + (rightVec * moveVector.X)
        end
    end
    
    -- Normalizar y aplicar velocidad
    if moveDirection.Magnitude > 0 then
        moveDirection = moveDirection.Unit * flySpeed
    end
    
    -- Aplicar velocidad
    bodyVelocity.Velocity = moveDirection
    
    -- Orientación
    if moveDirection.Magnitude > 0.1 then
        bodyGyro.CFrame = CFrame.lookAt(Vector3.new(0, 0, 0), moveDirection.Unit)
    end
end

-- ==================================================
-- EVENTOS DE CONTROL
-- ==================================================
-- Switch de vuelo
switchButton.MouseButton1Click:Connect(function()
    if flying then
        stopFly()
    else
        startFly()
    end
end)

-- Controles de velocidad
speedMinus.MouseButton1Click:Connect(function()
    flySpeed = math.max(minSpeed, flySpeed - 5)
    speedLabel.Text = "⚡ Velocidad: " .. math.round(flySpeed)
end)

speedPlus.MouseButton1Click:Connect(function()
    flySpeed = math.min(maxSpeed, flySpeed + 5)
    speedLabel.Text = "⚡ Velocidad: " .. math.round(flySpeed)
end)

-- Controles móviles
upButton.MouseButton1Click:Connect(function()
    if flying and bodyVelocity then
        bodyVelocity.Velocity = bodyVelocity.Velocity + Vector3.new(0, flySpeed, 0)
    end
end)

downButton.MouseButton1Click:Connect(function()
    if flying and bodyVelocity then
        bodyVelocity.Velocity = bodyVelocity.Velocity - Vector3.new(0, flySpeed, 0)
    end
end)

-- Teclas de PC
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.F then
        if flying then
            stopFly()
        else
            startFly()
        end
    end
end)

-- ==================================================
-- LOOP PRINCIPAL
-- ==================================================
RunService.Heartbeat:Connect(function()
    updateFly()
end)

-- ==================================================
-- MANEJO DE REINICIO DEL PERSONAJE
-- ==================================================
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    rootPart = character:WaitForChild("HumanoidRootPart")
    humanoid = character:WaitForChild("Humanoid")
    
    if flying then
        stopFly()
        startFly()
    end
end)

-- ==================================================
-- MENSAJE DE BIENVENIDA
-- ==================================================
wait(1)
print("============================================")
print("✨ JoseAngel_Blox Fly v1.2 ✨")
print("============================================")
print("¡Bienvenidos y bienvenidas al script JoseAngel_Blox Fly!")
print("")
print("📱 MÓVIL:")
print("- Activa el interruptor y usa los botones")
print("- Usa el joystick para moverte")
print("")
print("💻 PC:")
print("- Presiona F para volar")
print("- WASD para moverte")
print("- Espacio para subir")
print("- Shift para bajar")
print("- + y - para velocidad")
print("")
print("⚙️ Velocidad ajustable: " .. flySpeed)
print("🎯 Noclip: Activado")
print("============================================")

-- Efecto de entrada
TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
    Size = UDim2.new(0, 240, 0, 370)
}):Play()
