--[[
    Script mejorado para JoseAngel_Blox Fly
    - Interfaz ordenada y responsive
    - Botón INFO con flecha desplegable
    - Animación de carga pequeña y centrada
    - Sistema de vuelo funcional con controles táctiles y teclado
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Variables de vuelo
local flying = false
local flyBodyVelocity = nil
local flyGyro = nil
local flySpeed = 50
local moveDirection = Vector3.new(0, 0, 0)
local touchControls = {}
local keysPressed = {}

-- Crear GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "JoseAngelGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player.PlayerGui

-- ANIMACIÓN DE CARGA
local loadFrame = Instance.new("Frame")
loadFrame.Size = UDim2.new(0, 0, 0, 0)
loadFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
loadFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
loadFrame.BorderSizePixel = 0
loadFrame.ClipsDescendants = true
loadFrame.Parent = screenGui

local loadCircle = Instance.new("Frame")
loadCircle.Size = UDim2.new(0, 60, 0, 60)
loadCircle.Position = UDim2.new(0.5, -30, 0.5, -30)
loadCircle.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
loadCircle.BorderSizePixel = 0
loadCircle.Parent = loadFrame

local loadBar = Instance.new("Frame")
loadBar.Size = UDim2.new(0, 0, 0, 4)
loadBar.Position = UDim2.new(0, 0, 0.5, 20)
loadBar.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
loadBar.BorderSizePixel = 0
loadBar.Parent = loadFrame

local loadText = Instance.new("TextLabel")
loadText.Size = UDim2.new(0, 80, 0, 20)
loadText.Position = UDim2.new(0.5, -40, 0.5, 40)
loadText.BackgroundTransparency = 1
loadText.Text = "0%"
loadText.TextColor3 = Color3.fromRGB(255, 255, 255)
loadText.TextScaled = true
loadText.Font = Enum.Font.GothamBold
loadText.Parent = loadFrame

-- Animación de carga
loadFrame:TweenSize(UDim2.new(0, 150, 0, 120), "Out", "Quad", 0.3)

local progress = 0
local loadTween = TweenService:Create(loadBar, TweenInfo.new(2, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 0, 4)})
loadTween:Play()
loadTween.Completed:Connect(function()
    loadFrame:TweenSize(UDim2.new(0, 0, 0, 0), "In", "Quad", 0.3, true)
    loadFrame.Visible = false
    showMainGUI()
end)

-- Actualizar porcentaje
game:GetService("RunService").Heartbeat:Connect(function()
    if loadFrame.Visible then
        progress = math.min(loadBar.Size.X.Scale * 100, 100)
        loadText.Text = math.floor(progress) .. "%"
    end
end)

-- INTERFAZ PRINCIPAL
function showMainGUI()
    -- Panel principal
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 280, 0, 180)
    mainFrame.Position = UDim2.new(0.5, -140, 0.5, -90)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    mainFrame.BackgroundTransparency = 0.15
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui
    
    -- Efecto vidrio
    local glass = Instance.new("Frame")
    glass.Size = UDim2.new(1, 0, 1, 0)
    glass.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    glass.BackgroundTransparency = 0.95
    glass.BorderSizePixel = 0
    glass.Parent = mainFrame
    
    -- Título
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Position = UDim2.new(0, 0, 0, 5)
    title.BackgroundTransparency = 1
    title.Text = "JoseAngel_Blox Fly"
    title.TextColor3 = Color3.fromRGB(255, 200, 0)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame
    
    -- Botón INFO (con flecha)
    local infoBtn = Instance.new("TextButton")
    infoBtn.Size = UDim2.new(0, 120, 0, 30)
    infoBtn.Position = UDim2.new(0.5, -60, 0, 40)
    infoBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    infoBtn.BorderSizePixel = 0
    infoBtn.Text = "INFO ▼"
    infoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    infoBtn.TextScaled = true
    infoBtn.Font = Enum.Font.GothamBold
    infoBtn.Parent = mainFrame
    
    -- Panel de información (oculto)
    local infoPanel = Instance.new("Frame")
    infoPanel.Size = UDim2.new(1, -20, 0, 80)
    infoPanel.Position = UDim2.new(0, 10, 0, 75)
    infoPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    infoPanel.BackgroundTransparency = 0.5
    infoPanel.BorderSizePixel = 0
    infoPanel.Visible = false
    infoPanel.Parent = mainFrame
    
    local infoText = Instance.new("TextLabel")
    infoText.Size = UDim2.new(1, 0, 1, 0)
    infoText.BackgroundTransparency = 1
    infoText.Text = "Creador: JoseAngel_Blox\nLanzamiento: 04/06/2026\nVelocidad: 50\n\nUsa el joystick o WASD para moverte\nBotón de salto para volar más alto"
    infoText.TextColor3 = Color3.fromRGB(200, 200, 200)
    infoText.TextScaled = true
    infoText.Font = Enum.Font.Gotham
    infoText.Parent = infoPanel
    
    -- Alternar INFO
    local infoVisible = false
    infoBtn.MouseButton1Click:Connect(function()
        infoVisible = not infoVisible
        infoPanel.Visible = infoVisible
        infoBtn.Text = infoVisible and "INFO ▲" or "INFO ▼"
        mainFrame.Size = infoVisible and UDim2.new(0, 280, 0, 200) or UDim2.new(0, 280, 0, 140)
    end)
    
    -- Botón FLY
    local flyBtn = Instance.new("TextButton")
    flyBtn.Size = UDim2.new(0, 120, 0, 35)
    flyBtn.Position = UDim2.new(0.5, -60, 0, 75)
    flyBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
    flyBtn.BorderSizePixel = 0
    flyBtn.Text = "FLY"
    flyBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    flyBtn.TextScaled = true
    flyBtn.Font = Enum.Font.GothamBold
    flyBtn.Parent = mainFrame
    
    -- Funcionalidad FLY
    flyBtn.MouseButton1Click:Connect(function()
        flying = not flying
        flyBtn.Text = flying and "STOP" or "FLY"
        flyBtn.BackgroundColor3 = flying and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(255, 200, 0)
        
        if flying then
            enableFly()
        else
            disableFly()
        end
    end)
    
    -- Botón Terminar Obby
    local finishBtn = Instance.new("TextButton")
    finishBtn.Size = UDim2.new(0, 120, 0, 30)
    finishBtn.Position = UDim2.new(0.5, -60, 0, 115)
    finishBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 40)
    finishBtn.BorderSizePixel = 0
    finishBtn.Text = "Terminar Obby"
    finishBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    finishBtn.TextScaled = true
    finishBtn.Font = Enum.Font.GothamBold
    finishBtn.Parent = mainFrame
    
    finishBtn.MouseButton1Click:Connect(function()
        -- Aquí va la lógica para terminar el obby
        print("Obby terminado!")
    end)
    
    -- Botón Saltar Etapa
    local skipBtn = Instance.new("TextButton")
    skipBtn.Size = UDim2.new(0, 120, 0, 30)
    skipBtn.Position = UDim2.new(0.5, -60, 0, 150)
    skipBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
    skipBtn.BorderSizePixel = 0
    skipBtn.Text = "Saltar Etapa"
    skipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    skipBtn.TextScaled = true
    skipBtn.Font = Enum.Font.GothamBold
    skipBtn.Parent = mainFrame
    
    skipBtn.MouseButton1Click:Connect(function()
        -- Aquí va la lógica para saltar etapa
        print("Etapa saltada!")
    end)
    
    -- Ajustar tamaño según elementos visibles
    mainFrame.Size = UDim2.new(0, 280, 0, 190)
end

-- SISTEMA DE VUELO
function enableFly()
    local character = player.Character or player.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")
    
    -- Desactivar gravedad
    humanoid.PlatformStand = true
    
    -- Crear BodyVelocity para movimiento
    flyBodyVelocity = Instance.new("BodyVelocity")
    flyBodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
    flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
    flyBodyVelocity.Parent = rootPart
    
    -- Crear Gyro para control de rotación
    flyGyro = Instance.new("BodyGyro")
    flyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
    flyGyro.CFrame = rootPart.CFrame
    flyGyro.Parent = rootPart
end

function disableFly()
    if flyBodyVelocity then
        flyBodyVelocity:Destroy()
        flyBodyVelocity = nil
    end
    if flyGyro then
        flyGyro:Destroy()
        flyGyro = nil
    end
    
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.PlatformStand = false
        end
    end
    flying = false
end

-- CONTROLES DE MOVIMIENTO
function updateFly()
    if not flying or not flyBodyVelocity then return end
    
    local character = player.Character
    if not character then return end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    
    -- Obtener dirección de movimiento
    local moveVector = Vector3.new(0, 0, 0)
    
    -- Controles táctiles (joystick virtual)
    if touchControls.Left or keysPressed.Left then
        moveVector = moveVector - Vector3.new(1, 0, 0)
    end
    if touchControls.Right or keysPressed.Right then
        moveVector = moveVector + Vector3.new(1, 0, 0)
    end
    if touchControls.Forward or keysPressed.Forward then
        moveVector = moveVector + Vector3.new(0, 0, -1)
    end
    if touchControls.Backward or keysPressed.Backward then
        moveVector = moveVector + Vector3.new(0, 0, 1)
    end
    if touchControls.Up or keysPressed.Up then
        moveVector = moveVector + Vector3.new(0, 1, 0)
    end
    if touchControls.Down or keysPressed.Down then
        moveVector = moveVector - Vector3.new(0, 1, 0)
    end
    
    if moveVector.Magnitude > 0 then
        moveVector = moveVector.Unit * flySpeed
        flyBodyVelocity.Velocity = moveVector
    else
        flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
    end
    
    -- Orientación
    if flyGyro and moveVector.Magnitude > 0 then
        local lookCFrame = CFrame.lookAt(rootPart.Position, rootPart.Position + moveVector)
        flyGyro.CFrame = lookCFrame
    end
end

-- CONFIGURAR CONTROLES TÁCTILES (Joystick virtual)
function setupTouchControls()
    local touchFrame = Instance.new("Frame")
    touchFrame.Size = UDim2.new(0, 150, 0, 150)
    touchFrame.Position = UDim2.new(0, 20, 0.5, -75)
    touchFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    touchFrame.BackgroundTransparency = 0.8
    touchFrame.BorderSizePixel = 0
    touchFrame.Parent = screenGui
    
    local touchStick = Instance.new("Frame")
    touchStick.Size = UDim2.new(0, 50, 0, 50)
    touchStick.Position = UDim2.new(0.5, -25, 0.5, -25)
    touchStick.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
    touchStick.BorderSizePixel = 0
    touchStick.Parent = touchFrame
    
    -- Variables táctiles
    local touchOffset = Vector2.new(0, 0)
    local touching = false
    
    touchFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            touching = true
            touchOffset = touchFrame.AbsolutePosition - input.Position
        end
    end)
    
    touchFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch and touching then
            local pos = input.Position + touchOffset
            local relativePos = pos - touchFrame.AbsolutePosition
            local center = touchFrame.AbsoluteSize / 2
            local diff = relativePos - center
            local maxDist = 50
            
            if diff.Magnitude > maxDist then
                diff = diff.Unit * maxDist
            end
            
            touchStick.Position = UDim2.new(0.5, diff.X - 25, 0.5, diff.Y - 25)
            
            -- Actualizar controles
            local normalized = diff / maxDist
            touchControls.Left = normalized.X < -0.3
            touchControls.Right = normalized.X > 0.3
            touchControls.Forward = normalized.Y < -0.3
            touchControls.Backward = normalized.Y > 0.3
            touchControls.Up = false
            touchControls.Down = false
        end
    end)
    
    touchFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            touching = false
            touchStick.Position = UDim2.new(0.5, -25, 0.5, -25)
            touchControls.Left = false
            touchControls.Right = false
            touchControls.Forward = false
            touchControls.Backward = false
        end
    end)
    
    -- Botones de altura (arriba/abajo)
    local upBtn = Instance.new("TextButton")
    upBtn.Size = UDim2.new(0, 50, 0, 50)
    upBtn.Position = UDim2.new(0, 180, 0.5, -75)
    upBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
    upBtn.BorderSizePixel = 0
    upBtn.Text = "⬆"
    upBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    upBtn.TextScaled = true
    upBtn.Font = Enum.Font.GothamBold
    upBtn.Parent = screenGui
    
    local downBtn = Instance.new("TextButton")
    downBtn.Size = UDim2.new(0, 50, 0, 50)
    downBtn.Position = UDim2.new(0, 180, 0.5, -15)
    downBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
    downBtn.BorderSizePixel = 0
    downBtn.Text = "⬇"
    downBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    downBtn.TextScaled = true
    downBtn.Font = Enum.Font.GothamBold
    downBtn.Parent = screenGui
    
    upBtn.MouseButton1Down:Connect(function()
        touchControls.Up = true
    end)
    upBtn.MouseButton1Up:Connect(function()
        touchControls.Up = false
    end)
    
    downBtn.MouseButton1Down:Connect(function()
        touchControls.Down = true
    end)
    downBtn.MouseButton1Up:Connect(function()
        touchControls.Down = false
    end)
end

-- CONFIGURAR CONTROLES DE TECLADO
function setupKeyboardControls()
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.W then
            keysPressed.Forward = true
        elseif input.KeyCode == Enum.KeyCode.S then
            keysPressed.Backward = true
        elseif input.KeyCode == Enum.KeyCode.A then
            keysPressed.Left = true
        elseif input.KeyCode == Enum.KeyCode.D then
            keysPressed.Right = true
        elseif input.KeyCode == Enum.KeyCode.Space then
            keysPressed.Up = true
        elseif input.KeyCode == Enum.KeyCode.LeftShift then
            keysPressed.Down = true
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.W then
            keysPressed.Forward = false
        elseif input.KeyCode == Enum.KeyCode.S then
            keysPressed.Backward = false
        elseif input.KeyCode == Enum.KeyCode.A then
            keysPressed.Left = false
        elseif input.KeyCode == Enum.KeyCode.D then
            keysPressed.Right = false
        elseif input.KeyCode == Enum.KeyCode.Space then
            keysPressed.Up = false
        elseif input.KeyCode == Enum.KeyCode.LeftShift then
            keysPressed.Down = false
        end
    end)
end

-- INICIALIZACIÓN
setupTouchControls()
setupKeyboardControls()

-- Actualizar vuelo en cada frame
RunService.Heartbeat:Connect(function()
    updateFly()
end)

-- Limpiar al morir
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
    
    if flying then
        disableFly()
        flying = true
        enableFly()
    end
end)

print("JoseAngel_Blox Fly cargado correctamente!")
