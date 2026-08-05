-- SERVICIOS PRINCIPALES
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer

-- CONFIGURACIÓN
local VelocidadVuelo = 200 -- Velocidad del deslizamiento terrestre

-- FUNCIÓN PARA VOLAR A RAS DE SUELO
local function VolarAKickReady()
    local character = localPlayer.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end

    -- Busca el objeto kickready en cualquier parte del mapa
    local targetZone = game.Workspace:FindFirstChild("kickready", true)
    
    if targetZone then
        local destinoPos = targetZone:IsA("Model") and targetZone:GetPivot().Position or targetZone.Position
        -- Mantener la altura actual de tus pies para arrastrarse por el suelo
        local destinoAjustado = Vector3.new(destinoPos.X, rootPart.Position.Y, destinoPos.Z)
        
        local distancia = (rootPart.Position - destinoAjustado).Magnitude
        local duracion = distancia / VelocidadVuelo
        
        local infoTween = TweenInfo.new(duracion, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local objetivos = {CFrame = CFrame.new(destinoAjustado)}
        local tween = TweenService:Create(rootPart, infoTween, objetivos)
        
        -- Bypass de gravedad y velocidad del juego
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(500000, 500000, 500000)
        bodyVelocity.Parent = rootPart
        
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Physics) end
        
        tween:Play()
        
        -- Al llegar a kickready restablece el personaje
        tween.Completed:Connect(function()
            bodyVelocity:Destroy()
            if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end
        end)
    end
end

-- CREACIÓN DE INTERFAZ MÓVIL LIGERA (Botón Flotante)
local CoreGui = game:GetService("CoreGui")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeltaMobileBypass"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0, 70, 0, 70)
Button.Position = UDim2.new(0.1, 0, 0.4, 0) -- Posición inicial en tu pantalla
Button.BackgroundColor3 = Color3.fromRGB(240, 50, 50)
Button.Text = "RUN"
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Font = Enum.Font.SourceSansBold
Button.TextSize = 20
Button.Parent = ScreenGui

-- Hacer el botón redondo y estético
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 35)
UICorner.Parent = Button

-- ACTIVACIÓN POR TOQUE EN PANTALLA TÁCTIL
Button.MouseButton1Click:Connect(function()
    VolarAKickReady()
end)

-- SISTEMA PARA MOVER EL BOTÓN CON EL DEDO A DONDE QUIERAS
local dragging, dragInput, dragStart, startPos
Button.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Button.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
Button.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Button.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
