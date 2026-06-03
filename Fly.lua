--[[
    Script de Vuelo Avanzado con Burbuja Flotante (F)
    - Arrastrable, clic para mostrar/ocultar menú.
    - Compatible con PC (teclado + ratón) y móvil (joystick táctil + botones).
    - Sin rotaciones ni animaciones extrañas del personaje.
    - Velocidad ajustable, vuelo con dirección de la cámara.
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Variables de vuelo
local flying = false
local currentSpeed = 50
local minSpeed = 10
local maxSpeed = 150
local speedStep = 10
local ascending = false
local descending = false

-- Referencias al personaje y componentes
local character = nil
local humanoid = nil
local rootPart = nil
local bodyVelocity = nil
local heartbeatConnection = nil

-- Variables de UI
local screenGui = nil
local bubble = nil
local menuFrame = nil
local speedLabel = nil
local flyToggleButton = nil

-- ==================== FUNCIONES DE VUELO ====================

local function stopFly()
    if heartbeatConnection then
        heartbeatConnection:Disconnect()
        heartbeatConnection = nil
    end
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
    if humanoid then
        humanoid.PlatformStand = false
        humanoid.AutoRotate = true
        humanoid.WalkSpeed = 16
        humanoid.JumpPower = 50
    end
    flying = false
    if flyToggleButton then
        flyToggleButton.Text = "🔘 Volar: OFF"
    end
end

local function updateVelocity()
    if not (character and character.Parent and humanoid and rootPart) then
        stopFly()
        return
    end
    
    -- Obtener dirección de movimiento horizontal (joystick / WASD)
    local moveDirection = humanoid.MoveDirection
    -- Dirección de la cámara
    local camera = workspace.CurrentCamera
    local camForward = camera.CFrame.LookVector
    local camRight = camera.CFrame.RightVector
    
    -- Convertir MoveDirection (global) a movimiento relativo a la cámara
    local forwardMove = moveDirection.Z  -- MoveDirection.X = lateral, Z = frontal
    local rightMove = moveDirection.X
    local moveVector = (camForward * forwardMove) + (camRight * rightMove)
    moveVector = moveVector.Unit * currentSpeed
    
    -- Componente vertical (ascenso/descenso)
    local verticalSpeed = 0
    if ascending then
        verticalSpeed = currentSpeed
    elseif descending then
        verticalSpeed = -currentSpeed
    end
    
    -- Velocidad final
    local velocity = Vector3.new(moveVector.X, verticalSpeed, moveVector.Z)
    bodyVelocity.Velocity = velocity
end

local function startFly()
    if flying then return end
    character = player.Character
    if not character then return end
    
    humanoid = character:FindFirstChild("Humanoid")
    rootPart = character:FindFirstChild("HumanoidRootPart")
    if not (humanoid and rootPart) then return end
    
    -- Congelar animaciones y rotaciones
    humanoid.PlatformStand = true
    humanoid.AutoRotate = false
    humanoid.WalkSpeed = 0
    humanoid.JumpPower = 0
    
    -- BodyVelocity para el movimiento
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(1e6, 1e6, 1e6)
    bodyVelocity.Parent = rootPart
    
    flying = true
    if flyToggleButton then
        flyToggleButton.Text = "🔘 Volar: ON"
    end
    
    -- Bucle de actualización
    if heartbeatConnection then heartbeatConnection:Disconnect() end
    heartbeatConnection = RunService.Heartbeat:Connect(updateVelocity)
end

-- ==================== CONTROLES DE TECLADO ====================

local function handleKeyPress(input, isDown)
    if not flying then return end
    local key = input.KeyCode
    if key == Enum.KeyCode.Space then
        ascending = isDown
    elseif key == Enum.KeyCode.LeftControl or key == Enum.KeyCode.C then
        descending = isDown
    end
end

UserInputService.InputBegan:Connect(function(input)
    handleKeyPress(input, true)
end)
UserInputService.InputEnded:Connect(function(input)
    handleKeyPress(input, false)
end)

-- ==================== CREACIÓN DE UI ====================

local function createUI()
    screenGui = Instance.new("ScreenGui")
    screenGui.Name = "FlyScriptGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    -- Burbuja redonda con la letra F
    bubble = Instance.new("TextButton")
    bubble.Name = "FlyBubble"
    bubble.Size = UDim2.new(0, 70, 0, 70)
    bubble.Position = UDim2.new(0.05, 0, 0.5, -35)
    bubble.BackgroundColor3 = Color3.fromRGB(30, 144, 255)
    bubble.BackgroundTransparency = 0.1
    bubble.Text = "F"
    bubble.TextColor3 = Color3.new(1, 1, 1)
    bubble.TextScaled = true
    bubble.Font = Enum.Font.GothamBold
    bubble.BorderSizePixel = 0
    bubble.Draggable = true
    bubble.Parent = screenGui
    
    -- Sombra y redondeado
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = bubble
    
    local shadow = Instance.new("UIStroke")
    shadow.Color = Color3.new(0, 0, 0)
    shadow.Thickness = 2
    shadow.Transparency = 0.5
    shadow.Parent = bubble
    
    -- Menú principal
    menuFrame = Instance.new("Frame")
    menuFrame.Name = "FlyMenu"
    menuFrame.Size = UDim2.new(0, 220, 0, 280)
    menuFrame.Position = UDim2.new(0.5, -110, 0.5, -140)
    menuFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    menuFrame.BackgroundTransparency = 0.15
    menuFrame.BorderSizePixel = 0
    menuFrame.Visible = false
    menuFrame.Parent = screenGui
    
    local menuCorner = Instance.new("UICorner")
    menuCorner.CornerRadius = UDim.new(0, 12)
    menuCorner.Parent = menuFrame
    
    local menuStroke = Instance.new("UIStroke")
    menuStroke.Color = Color3.fromRGB(80, 80, 100)
    menuStroke.Thickness = 1
    menuStroke.Parent = menuFrame
    
    -- Título
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "CONTROL DE VUELO"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = menuFrame
    
    -- Velocidad actual
    speedLabel = Instance.new("TextLabel")
    speedLabel.Size = UDim2.new(1, -20, 0, 40)
    speedLabel.Position = UDim2.new(0, 10, 0, 45)
    speedLabel.BackgroundTransparency = 1
    speedLabel.Text = "Velocidad: " .. currentSpeed
    speedLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    speedLabel.TextScaled = true
    speedLabel.Font = Enum.Font.Gotham
    speedLabel.Parent = menuFrame
    
    -- Fila de botones (+, -)
    local speedRow = Instance.new("Frame")
    speedRow.Size = UDim2.new(1, 0, 0, 50)
    speedRow.Position = UDim2.new(0, 0, 0, 90)
    speedRow.BackgroundTransparency = 1
    speedRow.Parent = menuFrame
    
    local btnPlus = Instance.new("TextButton")
    btnPlus.Size = UDim2.new(0.4, -10, 1, -10)
    btnPlus.Position = UDim2.new(0.05, 0, 0, 0)
    btnPlus.Text = "+"
    btnPlus.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
    btnPlus.TextColor3 = Color3.new(1, 1, 1)
    btnPlus.TextScaled = true
    btnPlus.Font = Enum.Font.GothamBold
    btnPlus.Parent = speedRow
    local plusCorner = Instance.new("UICorner")
    plusCorner.CornerRadius = UDim.new(0, 8)
    plusCorner.Parent = btnPlus
    
    local btnMinus = Instance.new("TextButton")
    btnMinus.Size = UDim2.new(0.4, -10, 1, -10)
    btnMinus.Position = UDim2.new(0.55, 0, 0, 0)
    btnMinus.Text = "-"
    btnMinus.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    btnMinus.TextColor3 = Color3.new(1, 1, 1)
    btnMinus.TextScaled = true
    btnMinus.Font = Enum.Font.GothamBold
    btnMinus.Parent = speedRow
    local minusCorner = Instance.new("UICorner")
    minusCorner.CornerRadius = UDim.new(0, 8)
    minusCorner.Parent = btnMinus
    
    -- Botones ascend / descend
    local verticalRow = Instance.new("Frame")
    verticalRow.Size = UDim2.new(1, 0, 0, 50)
    verticalRow.Position = UDim2.new(0, 0, 0, 145)
    verticalRow.BackgroundTransparency = 1
    verticalRow.Parent = menuFrame
    
    local btnUp = Instance.new("TextButton")
    btnUp.Size = UDim2.new(0.4, -10, 1, -10)
    btnUp.Position = UDim2.new(0.05, 0, 0, 0)
    btnUp.Text = "▲ SUBIR"
    btnUp.BackgroundColor3 = Color3.fromRGB(100, 100, 200)
    btnUp.TextColor3 = Color3.new(1, 1, 1)
    btnUp.TextScaled = true
    btnUp.Font = Enum.Font.GothamBold
    btnUp.Parent = verticalRow
    local upCorner = Instance.new("UICorner")
    upCorner.CornerRadius = UDim.new(0, 8)
    upCorner.Parent = btnUp
    
    local btnDown = Instance.new("TextButton")
    btnDown.Size = UDim2.new(0.4, -10, 1, -10)
    btnDown.Position = UDim2.new(0.55, 0, 0, 0)
    btnDown.Text = "▼ BAJAR"
    btnDown.BackgroundColor3 = Color3.fromRGB(200, 100, 50)
    btnDown.TextColor3 = Color3.new(1, 1, 1)
    btnDown.TextScaled = true
    btnDown.Font = Enum.Font.GothamBold
    btnDown.Parent = verticalRow
    local downCorner = Instance.new("UICorner")
    downCorner.CornerRadius = UDim.new(0, 8)
    downCorner.Parent = btnDown
    
    -- Botón toggle vuelo
    flyToggleButton = Instance.new("TextButton")
    flyToggleButton.Size = UDim2.new(0.8, 0, 0, 45)
    flyToggleButton.Position = UDim2.new(0.1, 0, 0, 210)
    flyToggleButton.Text = "🔘 Volar: OFF"
    flyToggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
    flyToggleButton.TextColor3 = Color3.new(1, 1, 1)
    flyToggleButton.TextScaled = true
    flyToggleButton.Font = Enum.Font.GothamBold
    flyToggleButton.Parent = menuFrame
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 10)
    toggleCorner.Parent = flyToggleButton
    
    -- Eventos de UI
    bubble.Activated:Connect(function()
        menuFrame.Visible = not menuFrame.Visible
    end)
    
    btnPlus.MouseButton1Click:Connect(function()
        currentSpeed = math.min(currentSpeed + speedStep, maxSpeed)
        speedLabel.Text = "Velocidad: " .. currentSpeed
    end)
    
    btnMinus.MouseButton1Click:Connect(function()
        currentSpeed = math.max(currentSpeed - speedStep, minSpeed)
        speedLabel.Text = "Velocidad: " .. currentSpeed
    end)
    
    -- Ascenso / Descenso táctil (mantener presionado)
    btnUp.Pressed:Connect(function() ascending = true end)
    btnUp.Released:Connect(function() ascending = false end)
    btnDown.Pressed:Connect(function() descending = true end)
    btnDown.Released:Connect(function() descending = false end)
    
    flyToggleButton.MouseButton1Click:Connect(function()
        if flying then
            stopFly()
        else
            startFly()
        end
    end)
end

-- ==================== MANEJO DE RESPAWN ====================

local function onCharacterAdded(newChar)
    character = newChar
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
    if flying then
        -- Si estaba volando antes de morir, reiniciamos el vuelo
        stopFly()
        startFly()
    end
end

local function onPlayerDied()
    stopFly()
end

if player.Character then
    onCharacterAdded(player.Character)
end
player.CharacterAdded:Connect(onCharacterAdded)
player.CharacterRemoving:Connect(onPlayerDied)

-- Iniciar UI
createUI()
