-- Nombre del Script: JoseAngel_Blox Fly
-- Interfaz: Cuadrada con esquinas redondeadas
-- Compatible: PC y Celular

-- Servicios necesarios
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Variables de control
local FlyActive = false
local NoclipActive = false
local FlySpeed = 50
local FlyGyro, FlyBodyPos

-- Crear Interfaz
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox_Fly"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

-- Marco principal (cuadrado con esquinas redondeadas)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 280, 0, 320)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Esquinas redondeadas
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.Text = "JoseAngel_Blox Fly"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = MainFrame
Instance.new("UICorner").CornerRadius = UDim.new(0, 12)
Instance.new("UICorner").Parent = Title

-- Botones de pestañas
local InfoButton = Instance.new("TextButton")
InfoButton.Size = UDim2.new(0.5, -2, 0, 30)
InfoButton.Position = UDim2.new(0, 2, 0, 45)
InfoButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
InfoButton.Text = "📋 Info"
InfoButton.TextColor3 = Color3.new(1,1,1)
InfoButton.Font = Enum.Font.GothamSemibold
InfoButton.TextSize = 14
InfoButton.Parent = MainFrame
Instance.new("UICorner").CornerRadius = UDim.new(0, 8)
Instance.new("UICorner").Parent = InfoButton

local MainButton = Instance.new("TextButton")
MainButton.Size = UDim2.new(0.5, -2, 0, 30)
MainButton.Position = UDim2.new(0.5, 2, 0, 45)
MainButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MainButton.Text = "⚙️ Main"
MainButton.TextColor3 = Color3.new(1,1,1)
MainButton.Font = Enum.Font.GothamSemibold
MainButton.TextSize = 14
MainButton.Parent = MainFrame
Instance.new("UICorner").CornerRadius = UDim.new(0, 8)
Instance.new("UICorner").Parent = MainButton

-- Pestaña Info
local InfoFrame = Instance.new("Frame")
InfoFrame.Size = UDim2.new(1, -10, 1, -90)
InfoFrame.Position = UDim2.new(0, 5, 0, 80)
InfoFrame.BackgroundTransparency = 1
InfoFrame.Visible = true
InfoFrame.Parent = MainFrame

local InfoText = Instance.new("TextLabel")
InfoText.Size = UDim2.new(1, 0, 1, 0)
InfoText.BackgroundTransparency = 1
InfoText.Text = [[
Nombre del Creador:
JoséAngel_Blox

Fecha de lanzamiento:
06/07/2026

Versión:
1.2
]]
InfoText.TextColor3 = Color3.new(1,1,1)
InfoText.Font = Enum.Font.Gotham
InfoText.TextSize = 16
InfoText.TextWrapped = true
InfoText.TextXAlignment = Enum.TextXAlignment.Left
InfoText.TextYAlignment = Enum.TextYAlignment.Top
InfoText.Parent = InfoFrame

-- Pestaña Main
local MainFrameContent = Instance.new("Frame")
MainFrameContent.Size = UDim2.new(1, -10, 1, -90)
MainFrameContent.Position = UDim2.new(0, 5, 0, 80)
MainFrameContent.BackgroundTransparency = 1
MainFrameContent.Visible = false
MainFrameContent.Parent = MainFrame

-- Interruptor Fly
local FlyToggle = Instance.new("TextButton")
FlyToggle.Size = UDim2.new(1, 0, 0, 35)
FlyToggle.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
FlyToggle.Text = "Fly: Desactivado"
FlyToggle.TextColor3 = Color3.new(1,1,1)
FlyToggle.Font = Enum.Font.GothamSemibold
FlyToggle.TextSize = 15
FlyToggle.Parent = MainFrameContent
Instance.new("UICorner").CornerRadius = UDim.new(0, 8)
Instance.new("UICorner").Parent = FlyToggle

-- Interruptor Noclip
local NoclipToggle = Instance.new("TextButton")
NoclipToggle.Size = UDim2.new(1, 0, 0, 35)
NoclipToggle.Position = UDim2.new(0, 0, 0, 45)
NoclipToggle.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
NoclipToggle.Text = "Noclip: Desactivado"
NoclipToggle.TextColor3 = Color3.new(1,1,1)
NoclipToggle.Font = Enum.Font.GothamSemibold
NoclipToggle.TextSize = 15
NoclipToggle.Parent = MainFrameContent
Instance.new("UICorner").CornerRadius = UDim.new(0, 8)
Instance.new("UICorner").Parent = NoclipToggle

-- Control de velocidad
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, 0, 0, 25)
SpeedLabel.Position = UDim2.new(0, 0, 0, 90)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Velocidad: " .. FlySpeed
SpeedLabel.TextColor3 = Color3.new(1,1,1)
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextSize = 14
SpeedLabel.Parent = MainFrameContent

local SpeedDown = Instance.new("TextButton")
SpeedDown.Size = UDim2.new(0.48, 0, 0, 35)
SpeedDown.Position = UDim2.new(0, 0, 0, 120)
SpeedDown.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
SpeedDown.Text = "⬇️ Menos"
SpeedDown.TextColor3 = Color3.new(1,1,1)
SpeedDown.Font = Enum.Font.GothamSemibold
SpeedDown.TextSize = 14
SpeedDown.Parent = MainFrameContent
Instance.new("UICorner").CornerRadius = UDim.new(0, 8)
Instance.new("UICorner").Parent = SpeedDown

local SpeedUp = Instance.new("TextButton")
SpeedUp.Size = UDim2.new(0.48, 0, 0, 35)
SpeedUp.Position = UDim2.new(0.52, 0, 0, 120)
SpeedUp.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
SpeedUp.Text = "⬆️ Más"
SpeedUp.TextColor3 = Color3.new(1,1,1)
SpeedUp.Font = Enum.Font.GothamSemibold
SpeedUp.TextSize = 14
SpeedUp.Parent = MainFrameContent
Instance.new("UICorner").CornerRadius = UDim.new(0, 8)
Instance.new("UICorner").Parent = SpeedUp

-- Cambiar entre pestañas
InfoButton.MouseButton1Click:Connect(function()
    InfoFrame.Visible = true
    MainFrameContent.Visible = false
    InfoButton.BackgroundColor3 = Color3.fromRGB(60,60,60)
    MainButton.BackgroundColor3 = Color3.fromRGB(50,50,50)
end)

MainButton.MouseButton1Click:Connect(function()
    InfoFrame.Visible = false
    MainFrameContent.Visible = true
    MainButton.BackgroundColor3 = Color3.fromRGB(60,60,60)
    InfoButton.BackgroundColor3 = Color3.fromRGB(50,50,50)
end)

-- Función de Noclip
local function UpdateNoclip()
    if NoclipActive and Humanoid then
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Collision, false)
        for _, Part in ipairs(Character:GetDescendants()) do
            if Part:IsA("BasePart") then
                Part.CanCollide = false
            end
        end
    elseif Humanoid then
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Collision, true)
        for _, Part in ipairs(Character:GetDescendants()) do
            if Part:IsA("BasePart") and Part ~= RootPart then
                Part.CanCollide = true
            end
        end
    end
end

-- Función de Vuelo
local function StartFly()
    FlyActive = true
    FlyToggle.Text = "Fly: Activado"
    FlyToggle.BackgroundColor3 = Color3.fromRGB(30, 150, 30)

    FlyGyro = Instance.new("Gyro")
    FlyGyro.CFrame = RootPart.CFrame
    FlyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
    FlyGyro.P = 12000
    FlyGyro.Parent = RootPart

    FlyBodyPos = Instance.new("BodyPosition")
    FlyBodyPos.Position = RootPart.Position
    FlyBodyPos.MaxForce = Vector3.new(400000, 400000, 400000)
    FlyBodyPos.D = 400
    FlyBodyPos.P = 12000
    FlyBodyPos.Parent = RootPart
end

local function StopFly()
    FlyActive = false
    FlyToggle.Text = "Fly: Desactivado"
    FlyToggle.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    if FlyGyro then FlyGyro:Destroy() end
    if FlyBodyPos then FlyBodyPos:Destroy() end
end

-- Control de movimiento del vuelo
RunService.RenderStepped:Connect(function()
    if FlyActive and FlyBodyPos and FlyGyro then
        local Camera = workspace.CurrentCamera
        local MoveDir = Vector3.new()

        -- Controles PC
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then MoveDir += Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then MoveDir -= Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then MoveDir -= Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then MoveDir += Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then MoveDir += Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then MoveDir -= Vector3.new(0,1,0) end

        -- Controles Celular
        if UserInputService.TouchEnabled then
            if UserInputService:IsTouchDown(Enum.TouchState.Moved) then
                -- Ajuste automático para móvil
                FlyBodyPos.Position = RootPart.Position + Camera.CFrame.LookVector * FlySpeed
            end
        end

        MoveDir = MoveDir.Unit * FlySpeed
        FlyBodyPos.Position = RootPart.Position + MoveDir
        FlyGyro.CFrame = Camera.CFrame
    end
    UpdateNoclip()
end)

-- Botones de activación
FlyToggle.MouseButton1Click:Connect(function()
    if FlyActive then StopFly() else StartFly() end
end)

NoclipToggle.MouseButton1Click:Connect(function()
    NoclipActive = not NoclipActive
    NoclipToggle.Text = NoclipActive and "Noclip: Activado" or "Noclip: Desactivado"
    NoclipToggle.BackgroundColor3 = NoclipActive and Color3.fromRGB(30, 150, 30) or Color3.fromRGB(70, 70, 70)
end)

-- Ajustar velocidad
SpeedDown.MouseButton1Click:Connect(function()
    FlySpeed = math.max(10, FlySpeed - 10)
    SpeedLabel.Text = "Velocidad: " .. FlySpeed
end)

SpeedUp.MouseButton1Click:Connect(function()
    FlySpeed = math.min(500, FlySpeed + 10)
    SpeedLabel.Text = "Velocidad: " .. FlySpeed
end)

-- Actualizar personaje si reaparece
Player.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = Character:WaitForChild("Humanoid")
    RootPart = Character:WaitForChild("HumanoidRootPart")
    if FlyActive then StopFly() end
end)
