--[[
    Script: JoseAngel_Blox Fly (Versión Burbuja + AFK)
    Ejecutor: Delta Executor (Android/iOS)
    Funciones:
    - Burbuja táctil para activar/desactivar vuelo
    - Modo AFK: se queda quieto al soltar controles
    - Velocidad infinita ajustable
    - Diseño bonito y moderno
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
local speed = 50
local bodyVelocity = nil
local currentVelocity = Vector3.new(0, 0, 0)
local afkMode = true  -- True = se queda quieto al soltar teclas

-- Crear pantalla para la burbuja
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "JoseAngelFlyGui"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Fondo bonito (semi-transparente, redondeado)
local background = Instance.new("Frame")
background.Size = UDim2.new(0, 70, 0, 70)
background.Position = UDim2.new(0.85, 0, 0.85, 0)  -- Esquina inferior derecha
background.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
background.BackgroundTransparency = 0.15
background.BorderSizePixel = 0
background.ClipsDescendants = true
background.Parent = screenGui

-- Efecto de vidrio esmerilado (simulado)
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)  -- Círculo completo
corner.Parent = background

local shadow = Instance.new("UIStroke")
shadow.Thickness = 2
shadow.Color = Color3.fromRGB(100, 150, 255)
shadow.Transparency = 0.5
shadow.Parent = background

-- Brillo interno
local glow = Instance.new("UIGradient")
glow.Rotation = 45
glow.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 120, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 60, 150))
})
glow.Parent = background

-- Texto dentro de la burbuja
local buttonText = Instance.new("TextLabel")
buttonText.Size = UDim2.new(1, 0, 1, 0)
buttonText.BackgroundTransparency = 1
buttonText.Text = "✈️"
buttonText.TextColor3 = Color3.fromRGB(255, 255, 255)
buttonText.TextSize = 30
buttonText.Font = Enum.Font.GothamBold
buttonText.TextScaled = true
buttonText.Parent = background

-- Animación de la burbuja (respiración)
local tweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local scaleUp = tweenService:Create(background, tweenInfo, {Size = UDim2.new(0, 75, 0, 75)})
scaleUp:Play()

-- Función para actualizar el color según estado
local function updateBubbleColor(isFlying)
    local targetColor = isFlying and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(30, 30, 45)
    local tweenColor = tweenService:Create(background, TweenInfo.new(0.3), {BackgroundColor3 = targetColor})
    tweenColor:Play()
    buttonText.Text = isFlying and "🛸" or "✈️"
end

-- Crear BodyVelocity
local function startFly()
    if bodyVelocity then bodyVelocity:Destroy() end
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyVelocity.P = 5000
    bodyVelocity.Parent = rootPart
end

-- Modo AFK: frena completamente cuando no hay input
local function updateMovement()
    if not flying then return end
    
    local cam = workspace.CurrentCamera
    local moveDirection = Vector3.new(0, 0, 0)
    
    -- Detectar teclas presionadas (WASD + Espacio + C)
    if userInputService:IsKeyDown(Enum.KeyCode.W) then moveDirection = moveDirection + cam.CFrame.LookVector end
    if userInputService:IsKeyDown(Enum.KeyCode.S) then moveDirection = moveDirection - cam.CFrame.LookVector end
    if userInputService:IsKeyDown(Enum.KeyCode.A) then moveDirection = moveDirection - cam.CFrame.RightVector end
    if userInputService:IsKeyDown(Enum.KeyCode.D) then moveDirection = moveDirection + cam.CFrame.RightVector end
    if userInputService:IsKeyDown(Enum.KeyCode.Space) then moveDirection = moveDirection + Vector3.new(0, 1, 0) end
    if userInputService:IsKeyDown(Enum.KeyCode.C) then moveDirection = moveDirection - Vector3.new(0, 1, 0) end
    
    if moveDirection.Magnitude > 0 then
        currentVelocity = moveDirection.Unit * speed
        afkMode = false
    else
        if afkMode then
            currentVelocity = Vector3.new(0, 0, 0)  -- Se queda quieto
        else
            -- Pequeña inercia (opcional, puedes poner 0 para parada instantánea)
            currentVelocity = currentVelocity * 0.95
            if currentVelocity.Magnitude < 0.5 then currentVelocity = Vector3.new(0, 0, 0) end
        end
    end
    
    bodyVelocity.Velocity = currentVelocity
end

-- Alternar vuelo con la burbuja
local function toggleFly()
    flying = not flying
    updateBubbleColor(flying)
    
    if flying then
        startFly()
        humanoid.PlatformStand = true
        -- Actualizar dirección cada frame
        local conn
        conn = runService.RenderStepped:Connect(function()
            if flying then
                updateMovement()
            else
                if bodyVelocity then bodyVelocity:Destroy() end
                humanoid.PlatformStand = false
                conn:Disconnect()
            end
        end)
    else
        if bodyVelocity then bodyVelocity:Destroy() end
        humanoid.PlatformStand = false
        currentVelocity = Vector3.new(0, 0, 0)
    end
end

-- Click en burbuja (táctil)
local function onBubbleClick(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        toggleFly()
    end
end

background.InputBegan:Connect(onBubbleClick)

-- Control de velocidad con teclas + y - (sigue funcionando)
userInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.Equals then
        speed = speed + 10
        print("⚡ Velocidad: " .. speed)
    elseif input.KeyCode == Enum.KeyCode.Minus then
        speed = math.max(10, speed - 10)
        print("⚡ Velocidad: " .. speed)
    end
end)

-- Botón flotante para cerrar el script (opcional)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -5, 1, -5)
closeBtn.AnchorPoint = Vector2.new(1, 1)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
closeBtn.BackgroundTransparency = 0.3
closeBtn.Text = "✖"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 14
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = background

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    if bodyVelocity then bodyVelocity:Destroy() end
    humanoid.PlatformStand = false
    screenGui:Destroy()
    print("❌ Script JoseAngel_Blox Fly cerrado")
end)

-- Notificación de inicio
print("✅ JoseAngel_Blox Fly cargado")
print("🟢 Toca la burbuja para volar")
print("➕/➖ para velocidad | Modo AFK activado (quieto al soltar)")

-- Mensaje en pantalla (pequeño toast)
local toast = Instance.new("TextLabel")
toast.Size = UDim2.new(0, 200, 0, 40)
toast.Position = UDim2.new(0.5, -100, 0.8, 0)
toast.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
toast.BackgroundTransparency = 0.6
toast.TextColor3 = Color3.fromRGB(255, 255, 255)
toast.Text = "✨ JoseAngel_Blox Fly listo ✨"
toast.TextSize = 14
toast.Font = Enum.Font.Gotham
toast.TextScaled = false
toast.Parent = screenGui

local toastCorner = Instance.new("UICorner")
toastCorner.CornerRadius = UDim.new(0, 15)
toastCorner.Parent = toast

game:GetService("Debris"):AddItem(toast, 3)
