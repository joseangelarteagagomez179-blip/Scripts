-- [[ JoseAngel_Blox Fly - Professional Edition ]] --
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera
local PlayerModule = require(player.PlayerScripts:WaitForChild("PlayerModule"))
local Controls = PlayerModule:GetControls()

-- Variables de estado
local isFlying = false
local flySpeed = 50
local flyVelocity, flyGyro = nil, nil
local noclipConnection, flyConnection = nil, nil

-- [[ CREACIÓN DE LA INTERFAZ ]] --
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_BloxFly"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = (RunService:IsStudio() and player.PlayerGui) or CoreGui

-- Marco Principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 150)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -75)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Permite mover la UI en pantalla
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(60, 60, 70)
UIStroke.Thickness = 1
UIStroke.Parent = MainFrame

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "JoseAngel_Blox Fly"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

-- Icono de Zapato con Alas
local ShoeIcon = Instance.new("ImageLabel")
ShoeIcon.Size = UDim2.new(0, 24, 0, 24)
ShoeIcon.Position = UDim2.new(1, -34, 0, 13)
ShoeIcon.BackgroundTransparency = 1
ShoeIcon.Image = "rbxassetid://10675276335" -- ID de imagen de zapato con alas (Puedes cambiarlo)
ShoeIcon.Parent = MainFrame

-- Botón Fly
local FlyButton = Instance.new("TextButton")
FlyButton.Size = UDim2.new(1, -20, 0, 40)
FlyButton.Position = UDim2.new(0, 10, 0, 50)
FlyButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
FlyButton.Text = "FLY: OFF"
FlyButton.TextColor3 = Color3.fromRGB(200, 200, 200)
FlyButton.Font = Enum.Font.GothamBold
FlyButton.TextSize = 14
FlyButton.Parent = MainFrame

local FlyCorner = Instance.new("UICorner")
FlyCorner.CornerRadius = UDim.new(0, 6)
FlyCorner.Parent = FlyButton

-- Controles de Velocidad (Fondo)
local SpeedFrame = Instance.new("Frame")
SpeedFrame.Size = UDim2.new(1, -20, 0, 35)
SpeedFrame.Position = UDim2.new(0, 10, 0, 100)
SpeedFrame.BackgroundTransparency = 1
SpeedFrame.Parent = MainFrame

-- Botón Disminuir (-)
local MinusBtn = Instance.new("TextButton")
MinusBtn.Size = UDim2.new(0, 35, 1, 0)
MinusBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
MinusBtn.Text = "-"
MinusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinusBtn.Font = Enum.Font.GothamBold
MinusBtn.TextSize = 18
MinusBtn.Parent = SpeedFrame
local MinusCorner = Instance.new("UICorner")
MinusCorner.CornerRadius = UDim.new(0, 6)
MinusCorner.Parent = MinusBtn

-- Texto de Velocidad
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, -80, 1, 0)
SpeedLabel.Position = UDim2.new(0, 40, 0, 0)
SpeedLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
SpeedLabel.Text = "Speed: " .. flySpeed
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.Font = Enum.Font.GothamMedium
SpeedLabel.TextSize = 13
SpeedLabel.Parent = SpeedFrame
local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 6)
SpeedCorner.Parent = SpeedLabel

-- Botón Aumentar (+)
local PlusBtn = Instance.new("TextButton")
PlusBtn.Size = UDim2.new(0, 35, 1, 0)
PlusBtn.Position = UDim2.new(1, -35, 0, 0)
PlusBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
PlusBtn.Text = "+"
PlusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PlusBtn.Font = Enum.Font.GothamBold
PlusBtn.TextSize = 18
PlusBtn.Parent = SpeedFrame
local PlusCorner = Instance.new("UICorner")
PlusCorner.CornerRadius = UDim.new(0, 6)
PlusCorner.Parent = PlusBtn

-- [[ LÓGICA DEL SCRIPT ]] --

local function startFly()
    local char = player.Character or player.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    local humanoid = char:WaitForChild("Humanoid")

    -- Físicas de vuelo
    flyVelocity = Instance.new("BodyVelocity")
    flyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    flyVelocity.Parent = root

    flyGyro = Instance.new("BodyGyro")
    flyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    flyGyro.P = 10000
    flyGyro.Parent = root

    -- Noclip nativo (Traspasar paredes)
    noclipConnection = RunService.Stepped:Connect(function()
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end)

    -- Movimiento direccional basado en cámara y controles activos
    flyConnection = RunService.RenderStepped:Connect(function()
        local moveVector = Controls:GetMoveVector()
        
        -- Orientar personaje hacia la cámara
        flyGyro.CFrame = camera.CFrame
        
        -- Calcular dirección 3D (Adelante/Atrás + Izquierda/Derecha)
        local direction = (camera.CFrame.RightVector * moveVector.X) + (camera.CFrame.LookVector * -moveVector.Z)
        
        if moveVector.Magnitude > 0 then
            flyVelocity.Velocity = direction * flySpeed
        else
            flyVelocity.Velocity = Vector3.new(0, 0, 0)
        end
        
        humanoid.PlatformStand = true -- Evita animaciones de caída/caminata
    end)
end

local function stopFly()
    local char = player.Character
    if char then
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid then humanoid.PlatformStand = false end
    end
    if flyVelocity then flyVelocity:Destroy() end
    if flyGyro then flyGyro:Destroy() end
    if noclipConnection then noclipConnection:Disconnect() end
    if flyConnection then flyConnection:Disconnect() end
end

-- Funciones de Botones
FlyButton.MouseButton1Click:Connect(function()
    isFlying = not isFlying
    if isFlying then
        FlyButton.Text = "FLY: ON"
        FlyButton.TextColor3 = Color3.fromRGB(100, 255, 100)
        startFly()
    else
        FlyButton.Text = "FLY: OFF"
        FlyButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        stopFly()
    end
end)

MinusBtn.MouseButton1Click:Connect(function()
    flySpeed = math.max(10, flySpeed - 10)
    SpeedLabel.Text = "Speed: " .. flySpeed
end)

PlusBtn.MouseButton1Click:Connect(function()
    flySpeed = flySpeed + 10
    SpeedLabel.Text = "Speed: " .. flySpeed
end)

-- Limpiar al reiniciar personaje
player.CharacterAdded:Connect(function()
    if isFlying then
        isFlying = false
        FlyButton.Text = "FLY: OFF"
        FlyButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        stopFly()
    end
end)
