-- Nombre del Script: JoseAngel_Blox Fly
-- Versión: 1.3 (CORREGIDO)
-- Creador: JoséAngel_Blox
-- Fecha: 06/07/2026

-- Servicios
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

-- Variables del jugador
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Estados
local FlyActive = false
local NoclipActive = false
local FlySpeed = 80
local Gyro, BodyVelocity
local GuiVisible = true
local NoclipConnections = {}

-- Crear Interfaz
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox_Fly"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

-- Marco principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 380)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 14)
UICorner.Parent = MainFrame

-- Título
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 42)
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame
Instance.new("UICorner").CornerRadius = UDim.new(0, 14)
Instance.new("UICorner").Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -50, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "JoseAngel_Blox Fly"
TitleText.TextColor3 = Color3.new(1,1,1)
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 18
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- Botón Minimizar
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 40, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -45, 0, 6)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
MinimizeBtn.Text = "_"
MinimizeBtn.TextColor3 = Color3.new(1,1,1)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 20
MinimizeBtn.Parent = TitleBar
Instance.new("UICorner").CornerRadius = UDim.new(0, 8)
Instance.new("UICorner").Parent = MinimizeBtn

-- Pestañas
local InfoTab = Instance.new("TextButton")
InfoTab.Size = UDim2.new(0.5, -4, 0, 32)
InfoTab.Position = UDim2.new(0, 4, 0, 50)
InfoTab.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
InfoTab.Text = "📋 Info / Uso"
InfoTab.TextColor3 = Color3.new(1,1,1)
InfoTab.Font = Enum.Font.GothamSemibold
InfoTab.TextSize = 14
InfoTab.Parent = MainFrame
Instance.new("UICorner").CornerRadius = UDim.new(0, 8)
Instance.new("UICorner").Parent = InfoTab

local MainTab = Instance.new("TextButton")
MainTab.Size = UDim2.new(0.5, -4, 0, 32)
MainTab.Position = UDim2.new(0.5, 0, 0, 50)
MainTab.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
MainTab.Text = "⚙️ Principal"
MainTab.TextColor3 = Color3.new(1,1,1)
MainTab.Font = Enum.Font.GothamSemibold
MainTab.TextSize = 14
MainTab.Parent = MainFrame
Instance.new("UICorner").CornerRadius = UDim.new(0, 8)
Instance.new("UICorner").Parent = MainTab

-- Contenido Info con Tutorial
local InfoFrame = Instance.new("Frame")
InfoFrame.Size = UDim2.new(1, -10, 1, -90)
InfoFrame.Position = UDim2.new(0, 5, 0, 90)
InfoFrame.BackgroundTransparency = 1
InfoFrame.Visible = true
InfoFrame.Parent = MainFrame

local InfoText = Instance.new("TextLabel")
InfoText.Size = UDim2.new(1, 0, 1, 0)
InfoText.BackgroundTransparency = 1
InfoText.Text = [[
📌 INFORMACIÓN
Creador: JoséAngel_Blox
Lanzamiento: 06/07/2026
Versión: 1.3 (CORREGIDO)

📖 TUTORIAL DE USO

🖥️ PC:
• Activar: Dale clic a "Fly"
• Moverte: W A S D
• Subir: Espacio
• Bajar: Shift Izquierdo
• Noclip: Actívalo para atravesar paredes
• Velocidad: Usa los botones + / -

📱 CELULAR:
• Activar: Toca el botón "Fly"
• Moverte: Usa el joystick normal
• Girar: Desliza el dedo por la pantalla
• Noclip: Toca su interruptor
• Velocidad: Ajusta con los botones
]]
InfoText.TextColor3 = Color3.new(1,1,1)
InfoText.Font = Enum.Font.Gotham
InfoText.TextSize = 13
InfoText.TextWrapped = true
InfoText.TextXAlignment = Enum.TextXAlignment.Left
InfoText.TextYAlignment = Enum.TextYAlignment.Top
InfoText.Parent = InfoFrame

-- Contenido Principal
local MainContent = Instance.new("Frame")
MainContent.Size = UDim2.new(1, -10, 1, -90)
MainContent.Position = UDim2.new(0, 5, 0, 90)
MainContent.BackgroundTransparency = 1
MainContent.Visible = false
MainContent.Parent = MainFrame

-- Botón Fly
local FlyBtn = Instance.new("TextButton")
FlyBtn.Size = UDim2.new(1, 0, 0, 40)
FlyBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 85)
FlyBtn.Text = "✈️ Fly: Desactivado"
FlyBtn.TextColor3 = Color3.new(1,1,1)
FlyBtn.Font = Enum.Font.GothamBold
FlyBtn.TextSize = 15
FlyBtn.Parent = MainContent
Instance.new("UICorner").CornerRadius = UDim.new(0, 8)
Instance.new("UICorner").Parent = FlyBtn

-- Botón Noclip
local NoclipBtn = Instance.new("TextButton")
NoclipBtn.Size = UDim2.new(1, 0, 0, 40)
NoclipBtn.Position = UDim2.new(0, 0, 0, 50)
NoclipBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 85)
NoclipBtn.Text = "🚧 Noclip: Desactivado"
NoclipBtn.TextColor3 = Color3.new(1,1,1)
NoclipBtn.Font = Enum.Font.GothamBold
NoclipBtn.TextSize = 15
NoclipBtn.Parent = MainContent
Instance.new("UICorner").CornerRadius = UDim.new(0, 8)
Instance.new("UICorner").Parent = NoclipBtn

-- Control de Velocidad
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, 0, 0, 30)
SpeedLabel.Position = UDim2.new(0, 0, 0, 105)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Velocidad: " .. FlySpeed
SpeedLabel.TextColor3 = Color3.new(1,1,1)
SpeedLabel.Font = Enum.Font.GothamSemibold
SpeedLabel.TextSize = 14
SpeedLabel.Parent = MainContent

local SpeedMinus = Instance.new("TextButton")
SpeedMinus.Size = UDim2.new(0.48, 0, 0, 40)
SpeedMinus.Position = UDim2.new(0, 0, 0, 140)
SpeedMinus.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
SpeedMinus.Text = "⬇️ Menos"
SpeedMinus.TextColor3 = Color3.new(1,1,1)
SpeedMinus.Font = Enum.Font.GothamBold
SpeedMinus.TextSize = 14
SpeedMinus.Parent = MainContent
Instance.new("UICorner").CornerRadius = UDim.new(0, 8)
Instance.new("UICorner").Parent = SpeedMinus

local SpeedPlus = Instance.new("TextButton")
SpeedPlus.Size = UDim2.new(0.48, 0, 0, 40)
SpeedPlus.Position = UDim2.new(0.52, 0, 0, 140)
SpeedPlus.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
SpeedPlus.Text = "⬆️ Más"
SpeedPlus.TextColor3 = Color3.new(1,1,1)
SpeedPlus.Font = Enum.Font.GothamBold
SpeedPlus.TextSize = 14
SpeedPlus.Parent = MainContent
Instance.new("UICorner").CornerRadius = UDim.new(0, 8)
Instance.new("UICorner").Parent = SpeedPlus

-- FUNCIÓN NOCLIP CORREGIDA
local function UpdateNoclip()
    if not Character then return end
    
    -- Obtener todas las partes del personaje
    local parts = {}
    for _, v in ipairs(Character:GetDescendants()) do
        if v:IsA("BasePart") then
            table.insert(parts, v)
        end
    end
    
    -- Aplicar Noclip a TODAS las partes
    for _, part in ipairs(parts) do
        if NoclipActive then
            part.CanCollide = false
        else
            -- Solo restaurar colisiones si no está en estado Physics (para evitar conflictos)
            if part ~= RootPart then
                part.CanCollide = true
            else
                part.CanCollide = true
            end
        end
    end
    
    -- Deshabilitar/Habilitar estado Physics
    if NoclipActive then
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
    else
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
    end
end

-- FUNCIÓN FLY CORREGIDA
local function ActivarFly()
    if FlyActive then return end
    FlyActive = true
    FlyBtn.Text = "✈️ Fly: ACTIVADO"
    FlyBtn.BackgroundColor3 = Color3.fromRGB(30, 180, 60)

    -- Crear Gyro para mantener orientación
    Gyro = Instance.new("Gyro")
    Gyro.Name = "FlyGyro"
    Gyro.MaxTorque = Vector3.new(9e4, 9e4, 9e4)
    Gyro.P = 12000
    Gyro.D = 500
    Gyro.Parent = RootPart

    -- Crear BodyVelocity en lugar de BodyPosition (más confiable)
    BodyVelocity = Instance.new("BodyVelocity")
    BodyVelocity.Name = "FlyBodyVelocity"
    BodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    BodyVelocity.Velocity = Vector3.new(0, 0, 0)
    BodyVelocity.Parent = RootPart

    Humanoid.PlatformStand = true
    Humanoid.AutoRotate = false
end

local function DesactivarFly()
    if not FlyActive then return end
    FlyActive = false
    FlyBtn.Text = "✈️ Fly: Desactivado"
    FlyBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 85)

    if Gyro then Gyro:Destroy() end
    if BodyVelocity then BodyVelocity:Destroy() end
    Humanoid.PlatformStand = false
    Humanoid.AutoRotate = true
end

-- ACTUALIZAR MOVIMIENTO CORREGIDO
local moveConnection
moveConnection = RunService.RenderStepped:Connect(function()
    if not FlyActive or not BodyVelocity or not Gyro then return end
    if not Character or not Humanoid or not RootPart then return end
    
    local cam = workspace.CurrentCamera
    if not cam then return end
    
    local moveDirection = Vector3.new()
    
    -- CONTROLES PC
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then 
        moveDirection = moveDirection + cam.CFrame.LookVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then 
        moveDirection = moveDirection - cam.CFrame.LookVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then 
        moveDirection = moveDirection - cam.CFrame.RightVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then 
        moveDirection = moveDirection + cam.CFrame.RightVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then 
        moveDirection = moveDirection + Vector3.new(0, 1, 0)
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then 
        moveDirection = moveDirection - Vector3.new(0, 1, 0)
    end
    
    -- CONTROLES TÁCTILES (CORREGIDO)
    if UserInputService.TouchEnabled then
        -- Mantener dirección actual si no hay teclas presionadas
        if moveDirection.Magnitude == 0 then
            moveDirection = cam.CFrame.LookVector
        end
    end
    
    -- Aplicar velocidad
    if moveDirection.Magnitude > 0 then
        moveDirection = moveDirection.Unit * FlySpeed
        BodyVelocity.Velocity = moveDirection
    else
        BodyVelocity.Velocity = Vector3.new(0, 0, 0)
    end
    
    -- Mantener orientación
    Gyro.CFrame = cam.CFrame
    
    -- Actualizar Noclip continuamente
    UpdateNoclip()
end)

-- REAPARECER PERSONAJE
Player.CharacterAdded:Connect(function(nuevoChar)
    Character = nuevoChar
    Humanoid = Character:WaitForChild("Humanoid")
    RootPart = Character:WaitForChild("HumanoidRootPart")
    
    -- Limpiar variables antiguas
    if Gyro then 
        Gyro:Destroy() 
        Gyro = nil
    end
    if BodyVelocity then 
        BodyVelocity:Destroy() 
        BodyVelocity = nil
    end
    
    FlyActive = false
    FlyBtn.Text = "✈️ Fly: Desactivado"
    FlyBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 85)
    
    -- Resetear Noclip
    NoclipActive = false
    NoclipBtn.Text = "🚧 Noclip: Desactivado"
    NoclipBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 85)
    
    -- Actualizar Noclip para el nuevo personaje
    UpdateNoclip()
end)

-- BOTONES DE ACCIÓN
FlyBtn.MouseButton1Click:Connect(function()
    if FlyActive then 
        DesactivarFly() 
    else 
        ActivarFly() 
    end
end)

NoclipBtn.MouseButton1Click:Connect(function()
    NoclipActive = not NoclipActive
    NoclipBtn.Text = NoclipActive and "🚧 Noclip: ACTIVADO" or "🚧 Noclip: Desactivado"
    NoclipBtn.BackgroundColor3 = NoclipActive and Color3.fromRGB(30, 180, 60) or Color3.fromRGB(70, 70, 85)
    UpdateNoclip()
end)

SpeedMinus.MouseButton1Click:Connect(function()
    FlySpeed = math.max(20, FlySpeed - 10)
    SpeedLabel.Text = "Velocidad: " .. FlySpeed
end)

SpeedPlus.MouseButton1Click:Connect(function()
    FlySpeed = math.min(800, FlySpeed + 10)
    SpeedLabel.Text = "Velocidad: " .. FlySpeed
end)

-- CAMBIAR PESTAÑAS
InfoTab.MouseButton1Click:Connect(function()
    InfoFrame.Visible = true
    MainContent.Visible = false
    InfoTab.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    MainTab.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
end)

MainTab.MouseButton1Click:Connect(function()
    InfoFrame.Visible = false
    MainContent.Visible = true
    MainTab.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    InfoTab.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
end)

-- MINIMIZAR / RESTAURAR
MinimizeBtn.MouseButton1Click:Connect(function()
    GuiVisible = not GuiVisible
    if GuiVisible then
        MainFrame.Size = UDim2.new(0, 300, 0, 380)
        MinimizeBtn.Text = "_"
    else
        MainFrame.Size = UDim2.new(0, 300, 0, 42)
        MinimizeBtn.Text = "+"
    end
end)

-- ACTUALIZAR NOCLIP INICIAL
UpdateNoclip()

print("✅ JoseAngel_Blox Fly v1.3 CORREGIDO - Listo para usar!")
print("🛠️ Fly y Noclip funcionan correctamente ahora")
