-- Configuración básica de velocidad
local FlySpeed = 50
local Flying = false

-- Servicios de Roblox
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Crear interfaz de usuario (Protegida)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FlyScriptGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- 1. CREAR BURBUJA FLOTANTE REDONDA (BOTÓN F)
local BubbleButton = Instance.new("TextButton")
BubbleButton.Size = UDim2.new(0, 60, 0, 60)
BubbleButton.Position = UDim2.new(0.1, 0, 0.4, 0)
BubbleButton.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
BubbleButton.Text = "F"
BubbleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BubbleButton.TextSize = 28
BubbleButton.Font = Enum.Font.SourceSansBold
BubbleButton.Parent = ScreenGui

-- Hacer la burbuja redonda
local UICornerBubble = Instance.new("UICorner")
UICornerBubble.CornerRadius = UDim.new(1, 0)
UICornerBubble.Parent = BubbleButton

-- Lógica para arrastrar la burbuja (Móvil y PC)
local dragging, dragInput, dragStart, startPos
BubbleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = BubbleButton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
BubbleButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
RunService.Heartbeat:Connect(function()
    if dragging and dragInput then
        local delta = dragInput.Position - dragStart
        BubbleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- 2. CREAR MENÚ PRINCIPAL (Inicia oculto)
local MainMenu = Instance.new("Frame")
MainMenu.Size = UDim2.new(0, 220, 0, 220)
MainMenu.Position = UDim2.new(0.5, -110, 0.5, -110)
MainMenu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainMenu.Visible = false
MainMenu.Parent = ScreenGui

local UICornerMenu = Instance.new("UICorner")
UICornerMenu.CornerRadius = UDim.new(0, 12)
UICornerMenu.Parent = MainMenu

-- TÍTULO DEL SCRIPT: JoseAngel_Blox Fly
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.Position = UDim2.new(0, 0, 0, 5)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "JoseAngel_Blox Fly"
TitleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
TitleLabel.TextSize = 20
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Parent = MainMenu

-- Contenedor para alinear los botones debajo del título
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Size = UDim2.new(1, 0, 1, -45)
ButtonContainer.Position = UDim2.new(0, 0, 0, 45)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = MainMenu

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ButtonContainer
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
UIListLayout.Padding = UDim.new(0, 8)

-- Función para dar estilo a los botones del menú
local function CreateMenuButton(text, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 180, 0, 40)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 16
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = ButtonContainer
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    return btn
end

-- Botones del menú
local FlyBtn = CreateMenuButton("Fly: Volar", Color3.fromRGB(46, 204, 113))
local SpeedUpBtn = CreateMenuButton("+ Velocidad", Color3.fromRGB(52, 152, 219))
local SpeedDownBtn = CreateMenuButton("- Velocidad", Color3.fromRGB(231, 76, 60))

-- Interruptor ON/OFF sucesivo para el menú al presionar la burbuja
BubbleButton.MouseButton1Click:Connect(function()
    MainMenu.Visible = not MainMenu.Visible
end)

-- Modificar velocidad
SpeedUpBtn.MouseButton1Click:Connect(function()
    FlySpeed = FlySpeed + 10
    SpeedUpBtn.Text = "+ Vel (" .. FlySpeed .. ")"
    task.wait(0.5)
    SpeedUpBtn.Text = "+ Velocidad"
end)

-- Disminuir velocidad
SpeedDownBtn.MouseButton1Click:Connect(function()
    if FlySpeed > 10 then
        FlySpeed = FlySpeed - 10
        SpeedDownBtn.Text = "- Vel (" .. FlySpeed .. ")"
        task.wait(0.5)
        SpeedDownBtn.Text = "- Velocidad"
    end
end)

-- 3. LÓGICA DE VUELO DIRECCIONAL 3D (CÁMARA, JOYSTICK Y TECLADO)
local BodyVelocity, BodyGyro

FlyBtn.MouseButton1Click:Connect(function()
    Flying = not Flying
    
    local Character = LocalPlayer.Character
    if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
    local Root = Character.HumanoidRootPart
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")

    if Flying then
        FlyBtn.Text = "Volando: Activo"
        FlyBtn.BackgroundColor3 = Color3.fromRGB(155, 89, 182)
        
        BodyVelocity = Instance.new("BodyVelocity")
        BodyVelocity.Velocity = Vector3.new(0, 0, 0)
        BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        BodyVelocity.Parent = Root

        BodyGyro = Instance.new("BodyGyro")
        BodyGyro.CFrame = Root.CFrame
        BodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        BodyGyro.P = 3000
        BodyGyro.Parent = Root

        if Humanoid then 
            Humanoid.PlatformStand = true
        end
    else
        FlyBtn.Text = "Fly: Volar"
        FlyBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
        
        if BodyVelocity then BodyVelocity:Destroy() end
        if BodyGyro then BodyGyro:Destroy() end
        if Humanoid then Humanoid.PlatformStand = false end
    end
end)

-- Bucle de movimiento continuo en 3D según la cámara
RunService.RenderStepped:Connect(function()
    if Flying and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local Root = LocalPlayer.Character.HumanoidRootPart
        local Camera = workspace.CurrentCamera
        local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        
        if Humanoid and BodyVelocity and BodyGyro then
            local MoveDirection = Humanoid.MoveDirection
            
            if MoveDirection.Magnitude > 0 then
                -- Obtener los vectores de dirección de la cámara (adelante/atrás y lados)
                local LookVector = Camera.CFrame.LookVector
                local RightVector = Camera.CFrame.RightVector
                
                -- Detectar si nos movemos hacia adelante/atrás o lateralmente basándonos en la MoveDirection del Humanoid
                -- Esto permite que funcione perfectamente con el joystick 3D en celular
                local ForwardMove = Root.CFrame.LookVector:Dot(MoveDirection)
                local RightMove = Root.CFrame.RightVector:Dot(MoveDirection)
                
                -- Combinar las direcciones reales de la cámara en 3D (incluye el eje Y para subir y bajar)
                local TargetVelocity = (LookVector * ForwardMove) + (RightVector * RightMove)
                
                -- Si por alguna razón la magnitud es cero, usamos la dirección por defecto ajustada
                if TargetVelocity.Magnitude == 0 then
                    TargetVelocity = MoveDirection
                else
                    TargetVelocity = TargetVelocity.Unit
                end
                
                -- Aplicar la velocidad final
                BodyVelocity.Velocity = TargetVelocity * FlySpeed
            else
                -- Si no mueves el joystick, te quedas suspendido en el aire inmóvil
                BodyVelocity.Velocity = Vector3.new(0, 0, 0)
            end
            
            -- Mantener el cuerpo del personaje totalmente recto (vertical) sin rotar de forma extraña
            local CameraLook = Camera.CFrame.LookVector
            BodyGyro.CFrame = CFrame.new(Root.Position, Root.Position + Vector3.new(CameraLook.X, 0, CameraLook.Z))
        end
    end
end)

-- Resetear estado al reaparecer
LocalPlayer.CharacterAdded:Connect(function()
    Flying = false
    FlyBtn.Text = "Fly: Volar"
    FlyBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
end)
