--[[
    Script: JoseAngel_Blox Fly (Táctil + Joystick + Burbuja deslizable)
    Para: Delta Executor en celular
    - Vuela con el joystick del juego
    - Burbuja movible por toda la pantalla
    - Velocidad ajustable con botones +/-
--]]

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local rootPart = char:WaitForChild("HumanoidRootPart")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")

-- Variables
local flying = false
local speed = 50  -- Velocidad ajustable
local bodyVelocity = nil
local currentVel = Vector3.new(0, 0, 0)

-- Crear GUI principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "JoseAngelFlyGui"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ========== BURBUJA DESLIZABLE ==========
local bubble = Instance.new("Frame")
bubble.Size = UDim2.new(0, 70, 0, 70)
bubble.Position = UDim2.new(0.85, 0, 0.85, 0)  -- Esquina derecha abajo
bubble.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
bubble.BackgroundTransparency = 0.1
bubble.BorderSizePixel = 0
bubble.Parent = screenGui

-- Diseño bonito
local bubbleCorner = Instance.new("UICorner")
bubbleCorner.CornerRadius = UDim.new(1, 0)
bubbleCorner.Parent = bubble

local bubbleStroke = Instance.new("UIStroke")
bubbleStroke.Thickness = 2
bubbleStroke.Color = Color3.fromRGB(0, 200, 255)
bubbleStroke.Transparency = 0.3
bubbleStroke.Parent = bubble

local bubbleGradient = Instance.new("UIGradient")
bubbleGradient.Rotation = 45
bubbleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 120, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 60, 200))
})
bubbleGradient.Parent = bubble

-- Icono dentro de la burbuja
local bubbleIcon = Instance.new("TextLabel")
bubbleIcon.Size = UDim2.new(1, 0, 1, 0)
bubbleIcon.BackgroundTransparency = 1
bubbleIcon.Text = "✈️"
bubbleIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
bubbleIcon.TextSize = 35
bubbleIcon.Font = Enum.Font.GothamBold
bubbleIcon.TextScaled = true
bubbleIcon.Parent = bubble

-- Animación de respiración
local breathTween = tweenService:Create(bubble, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Size = UDim2.new(0, 75, 0, 75)})
breathTween:Play()

-- Hacer burbuja DESLIZABLE
local dragging = false
local dragStart = nil
local bubbleStartPos = nil

bubble.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        bubbleStartPos = bubble.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

userInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        local newX = bubbleStartPos.X.Scale + (delta.X / screenGui.AbsoluteSize.X)
        local newY = bubbleStartPos.Y.Scale + (delta.Y / screenGui.AbsoluteSize.Y)
        -- Limitar bordes
        newX = math.clamp(newX, 0, 1 - bubble.Size.X.Scale)
        newY = math.clamp(newY, 0, 1 - bubble.Size.Y.Scale)
        bubble.Position = UDim2.new(newX, 0, newY, 0)
    end
end)

-- ========== PANEL DE VELOCIDAD (botones + y -) ==========
local speedPanel = Instance.new("Frame")
speedPanel.Size = UDim2.new(0, 120, 0, 40)
speedPanel.Position = UDim2.new(0.02, 0, 0.85, 0)
speedPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
speedPanel.BackgroundTransparency = 0.2
speedPanel.BorderSizePixel = 0
speedPanel.Parent = screenGui

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 20)
panelCorner.Parent = speedPanel

-- Botón -
local minusBtn = Instance.new("TextButton")
minusBtn.Size = UDim2.new(0, 40, 0, 40)
minusBtn.Position = UDim2.new(0, 0, 0, 0)
minusBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
minusBtn.BackgroundTransparency = 0.3
minusBtn.Text = "−"
minusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minusBtn.TextSize = 30
minusBtn.Font = Enum.Font.GothamBold
minusBtn.Parent = speedPanel

local minusCorner = Instance.new("UICorner")
minusCorner.CornerRadius = UDim.new(1, 0)
minusCorner.Parent = minusBtn

-- Texto velocidad
local speedText = Instance.new("TextLabel")
speedText.Size = UDim2.new(0, 40, 0, 40)
speedText.Position = UDim2.new(0, 40, 0, 0)
speedText.BackgroundTransparency = 1
speedText.Text = tostring(speed)
speedText.TextColor3 = Color3.fromRGB(255, 255, 255)
speedText.TextSize = 20
speedText.Font = Enum.Font.GothamBold
speedText.Parent = speedPanel

-- Botón +
local plusBtn = Instance.new("TextButton")
plusBtn.Size = UDim2.new(0, 40, 0, 40)
plusBtn.Position = UDim2.new(0, 80, 0, 0)
plusBtn.BackgroundColor3 = Color3.fromRGB(80, 255, 80)
plusBtn.BackgroundTransparency = 0.3
plusBtn.Text = "+"
plusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
plusBtn.TextSize = 30
plusBtn.Font = Enum.Font.GothamBold
plusBtn.Parent = speedPanel

local plusCorner = Instance.new("UICorner")
plusCorner.CornerRadius = UDim.new(1, 0)
plusCorner.Parent = plusBtn

-- Función para actualizar velocidad
local function updateSpeedUI()
    speedText.Text = tostring(speed)
    -- Cambiar color según velocidad
    if speed > 150 then
        speedText.TextColor3 = Color3.fromRGB(255, 100, 100)
    elseif speed > 80 then
        speedText.TextColor3 = Color3.fromRGB(255, 200, 100)
    else
        speedText.TextColor3 = Color3.fromRGB(100, 255, 100)
    end
end

minusBtn.MouseButton1Click:Connect(function()
    speed = math.max(10, speed - 10)
    updateSpeedUI()
    print("⚡ Velocidad reducida a: " .. speed)
end)

plusBtn.MouseButton1Click:Connect(function()
    speed = speed + 10
    updateSpeedUI()
    print("⚡ Velocidad aumentada a: " .. speed)
end)

-- ========== LÓGICA DE VUELO CON JOYSTICK ==========
local function startFly()
    if bodyVelocity then bodyVelocity:Destroy() end
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyVelocity.P = 5000
    bodyVelocity.Parent = rootPart
end

local function updateFlyWithJoystick()
    if not flying then return end
    
    -- Obtener dirección del movimiento del humanoid (joystick táctil)
    local moveDirection = humanoid.MoveDirection  -- Vector3 normalizado
    
    if moveDirection.Magnitude > 0 then
        -- Movimiento horizontal + vertical (si el juego permite)
        currentVel = moveDirection * speed
    else
        -- Modo AFK: se queda quieto
        currentVel = Vector3.new(0, 0, 0)
    end
    
    bodyVelocity.Velocity = currentVel
end

-- Alternar vuelo al tocar burbuja
local function toggleFly()
    flying = not flying
    
    -- Cambiar apariencia de la burbuja
    if flying then
        bubbleIcon.Text = "🛸"
        bubbleStroke.Color = Color3.fromRGB(0, 255, 100)
        bubbleStroke.Transparency = 0.1
        bubbleGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 200, 100)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 100, 50))
        })
        startFly()
        humanoid.PlatformStand = true
        
        -- Loop de vuelo
        local conn
        conn = runService.RenderStepped:Connect(function()
            if flying then
                updateFlyWithJoystick()
            else
                if bodyVelocity then bodyVelocity:Destroy() end
                humanoid.PlatformStand = false
                conn:Disconnect()
            end
        end)
    else
        bubbleIcon.Text = "✈️"
        bubbleStroke.Color = Color3.fromRGB(0, 200, 255)
        bubbleStroke.Transparency = 0.3
        bubbleGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 120, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 60, 200))
        })
        if bodyVelocity then bodyVelocity:Destroy() end
        humanoid.PlatformStand = false
        currentVel = Vector3.new(0, 0, 0)
    end
end

-- Click en burbuja (táctil)
bubble.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        -- Evitar que el arrastre active el toggle
        task.wait(0.1)
        if not dragging then
            toggleFly()
        end
    end
end)

-- ========== BOTÓN DE CERRAR (X dentro de la burbuja) ==========
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 22, 0, 22)
closeBtn.Position = UDim2.new(1, -5, 0, 5)
closeBtn.AnchorPoint = Vector2.new(1, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeBtn.BackgroundTransparency = 0.2
closeBtn.Text = "✖"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 14
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = bubble

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    if bodyVelocity then bodyVelocity:Destroy() end
    humanoid.PlatformStand = false
    screenGui:Destroy()
    print("❌ Script cerrado")
end)

-- ========== NOTIFICACIÓN INICIAL ==========
local toast = Instance.new("TextLabel")
toast.Size = UDim2.new(0, 250, 0, 45)
toast.Position = UDim2.new(0.5, -125, 0.7, 0)
toast.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
toast.BackgroundTransparency = 0.5
toast.Text = "✨ JoseAngel_Blox Fly ✨\nToca la burbuja y usa el joystick"
toast.TextColor3 = Color3.fromRGB(255, 255, 255)
toast.TextSize = 14
toast.Font = Enum.Font.GothamBold
toast.TextWrapped = true
toast.Parent = screenGui

local toastCorner = Instance.new("UICorner")
toastCorner.CornerRadius = UDim.new(0, 15)
toastCorner.Parent = toast

game:GetService("Debris"):AddItem(toast, 4)

updateSpeedUI()
print("✅ JoseAngel_Blox Fly TÁCTIL cargado")
print("🟢 Toca la burbuja → Activa vuelo")
print("📱 Mueve el joystick → Vuelas")
print("➕/➖ Ajustan velocidad")
print("🖐️ Arrastra la burbuja a cualquier lugar")
