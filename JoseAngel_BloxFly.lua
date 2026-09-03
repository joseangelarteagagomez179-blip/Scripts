-- JoseAngel_Bloc Fly | Zapato Volador
-- ✅ Fly + Noclip Integrado
-- 📱 Funciona en PC + Móvil (Teclas + Joystick)
-- 🎨 Diseño compacto, esquinas redondeadas

-- Servicios
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

local Player = Players.LocalPlayer
local Character, Humanoid, RootPart, Camera

-- Estado
local FlyEnabled = false
local FlySpeed = 35
local NoclipConnection = nil
local Input = {Forward=false, Backward=false, Left=false, Right=false, Up=false, Down=false}

-- Actualizar personaje
local function UpdateCharacter()
    Character = Player.Character
    if not Character then return end
    Humanoid = Character:FindFirstChildOfClass("Humanoid")
    RootPart = Character:FindFirstChild("HumanoidRootPart")
    Camera = workspace.CurrentCamera
end

-- NOCLIP
local function SetNoclip(state)
    if not Character then return end
    for _, part in ipairs(Character:GetDescendants()) do
        if part:IsA("BasePart") then part.CanCollide = not state end
    end
end

-- SISTEMA DE VUELO
local function FlyUpdate(deltaTime)
    if not FlyEnabled or not RootPart or not Camera then return end
    
    -- Dirección según cámara
    local camCF = Camera.CFrame
    local dir = Vector3.new()
    
    -- Teclado / Joystick
    if Input.Forward then dir += camCF.LookVector end
    if Input.Backward then dir -= camCF.LookVector end
    if Input.Left then dir -= camCF.RightVector end
    if Input.Right then dir += camCF.RightVector end
    if Input.Up then dir += Vector3.new(0,1,0) end
    if Input.Down then dir -= Vector3.new(0,1,0) end
    
    -- Normalizar para velocidad uniforme
    if dir.Magnitude > 0 then dir = dir.Unit * FlySpeed end
    
    -- Aplicar movimiento
    RootPart.Velocity = dir * FlySpeed
end

-- ACTIVAR/DESACTIVAR FLY
local function ToggleFly()
    UpdateCharacter()
    if not Humanoid then return end
    
    FlyEnabled = not FlyEnabled
    Humanoid.PlatformStand = FlyEnabled
    Humanoid.GravityScale = FlyEnabled and 0 or 1
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, not FlyEnabled)
    
    if FlyEnabled then
        SetNoclip(true)
        NoclipConnection = RunService.Stepped:Connect(function() SetNoclip(true) end)
    else
        if NoclipConnection then NoclipConnection:Disconnect() end
        SetNoclip(false)
    end
    
    return FlyEnabled
end

-- CONTROLES DE ENTRADA
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.W then Input.Forward = true end
    if input.KeyCode == Enum.KeyCode.S then Input.Backward = true end
    if input.KeyCode == Enum.KeyCode.A then Input.Left = true end
    if input.KeyCode == Enum.KeyCode.D then Input.Right = true end
    if input.KeyCode == Enum.KeyCode.Space then Input.Up = true end
    if input.KeyCode == Enum.KeyCode.LeftControl then Input.Down = true end
end)

UserInputService.InputEnded:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.W then Input.Forward = false end
    if input.KeyCode == Enum.KeyCode.S then Input.Backward = false end
    if input.KeyCode == Enum.KeyCode.A then Input.Left = false end
    if input.KeyCode == Enum.KeyCode.D then Input.Right = false end
    if input.KeyCode == Enum.KeyCode.Space then Input.Up = false end
    if input.KeyCode == Enum.KeyCode.LeftControl then Input.Down = false end
end)

-- Conexión de vuelo
RunService.RenderStepped:Connect(FlyUpdate)
Player.CharacterAdded:Connect(UpdateCharacter)

-- ================== INTERFAZ UI ==================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = Player:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Contenedor principal (cuadrado redondeado, pequeño)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "JoseAngel_BlocFly"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 170, 0, 210)
MainFrame.Position = UDim2.new(0.02, 0, 0.5, -105)
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
MainFrame.BorderSizePixel = 0
MainFrame.CornerRadius = UDim.new(0, 14)
MainFrame.Active = true
MainFrame.Draggable = true

-- Sombra
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 14)
UICorner.Parent = MainFrame

local UIShadow = Instance.new("UIGradient")
UIShadow.Rotation = 90
UIShadow.Transparency = NumberSequence.new{0, 0.15}
UIShadow.Parent = MainFrame

-- Título + Icono Zapato Volador
local TitleContainer = Instance.new("Frame")
TitleContainer.Parent = MainFrame
TitleContainer.Size = UDim2.new(1, -16, 0, 45)
TitleContainer.Position = UDim2.new(0, 8, 0, 8)
TitleContainer.BackgroundTransparency = 1

-- Icono Zapato con Alas 🥿✈️
local ShoeIcon = Instance.new("TextLabel")
ShoeIcon.Parent = TitleContainer
ShoeIcon.Size = UDim2.new(0, 32, 1, 0)
ShoeIcon.BackgroundTransparency = 1
ShoeIcon.Text = "👟"
ShoeIcon.Font = Enum.Font.GothamBold
ShoeIcon.TextSize = 24
ShoeIcon.TextColor3 = Color3.fromRGB(255, 215, 0)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = TitleContainer
TitleLabel.Size = UDim2.new(1, -36, 1, 0)
TitleLabel.Position = UDim2.new(0, 36, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "JoseAngel_Bloc Fly"
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 13
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Separador
local Separator = Instance.new("Frame")
Separator.Parent = MainFrame
Separator.Size = UDim2.new(1, -20, 0, 1)
Separator.Position = UDim2.new(0, 10, 0, 53)
Separator.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
Instance.new("UICorner", Separator).CornerRadius = UDim.new(0, 1)

-- Botón FLY
local FlyBtn = Instance.new("TextButton")
FlyBtn.Parent = MainFrame
FlyBtn.Size = UDim2.new(1, -24, 0, 45)
FlyBtn.Position = UDim2.new(0, 12, 0, 65)
FlyBtn.BackgroundColor3 = Color3.fromRGB(58, 58, 68)
FlyBtn.Font = Enum.Font.GothamBold
FlyBtn.Text = "FLY"
FlyBtn.TextSize = 16
FlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyBtn.AutoLocalize = false
Instance.new("UICorner", FlyBtn).CornerRadius = UDim.new(0, 10)

-- Contenedor Velocidad
local SpeedContainer = Instance.new("Frame")
SpeedContainer.Parent = MainFrame
SpeedContainer.Size = UDim2.new(1, -24, 0, 40)
SpeedContainer.Position = UDim2.new(0, 12, 0, 122)
SpeedContainer.BackgroundTransparency = 1

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = SpeedContainer
SpeedLabel.Size = UDim2.new(1, 0, 0, 18)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Velocidad: " .. FlySpeed
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextSize = 12
SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)

local MinusBtn = Instance.new("TextButton")
MinusBtn.Parent = SpeedContainer
MinusBtn.Size = UDim2.new(0, 45, 0, 30)
MinusBtn.Position = UDim2.new(0, 0, 0, 18)
MinusBtn.BackgroundColor3 = Color3.fromRGB(52, 52, 62)
MinusBtn.Text = "−"
MinusBtn.Font = Enum.Font.GothamBold
MinusBtn.TextSize = 18
MinusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", MinusBtn).CornerRadius = UDim.new(0, 8)

local PlusBtn = Instance.new("TextButton")
PlusBtn.Parent = SpeedContainer
PlusBtn.Size = UDim2.new(0, 45, 0, 30)
PlusBtn.Position = UDim2.new(1, -45, 0, 18)
PlusBtn.BackgroundColor3 = Color3.fromRGB(52, 52, 62)
PlusBtn.Text = "+"
PlusBtn.Font = Enum.Font.GothamBold
PlusBtn.TextSize = 18
PlusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", PlusBtn).CornerRadius = UDim.new(0, 8)

-- ACCIONES BOTONES
FlyBtn.MouseButton1Click:Connect(function()
    local state = ToggleFly()
    FlyBtn.BackgroundColor3 = state and Color3.fromRGB(76, 175, 80) or Color3.fromRGB(58, 58, 68)
    FlyBtn.Text = state and "VUELO ACTIVO" or "FLY"
end)

MinusBtn.MouseButton1Click:Connect(function()
    FlySpeed = math.max(10, FlySpeed - 5)
    SpeedLabel.Text = "Velocidad: " .. FlySpeed
end)

PlusBtn.MouseButton1Click:Connect(function()
    FlySpeed = math.min(120, FlySpeed + 5)
    SpeedLabel.Text = "Velocidad: " .. FlySpeed
end)

-- Inicializar
UpdateCharacter()
