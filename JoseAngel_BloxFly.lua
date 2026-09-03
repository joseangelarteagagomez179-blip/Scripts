-- ==============================================
-- JoseAngel_Blox Fly | Zapato Volador
-- ✅ Fly + Noclip Integrado
-- 📱 PC + Móvil (Teclas + Joystick)
-- 🎨 Diseño profesional | Versión Corregida
-- ==============================================

-- Servicios
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local Character, Humanoid, RootPart, Camera

-- Estado
local FlyEnabled = false
local FlySpeed = 50
local NoclipConnection = nil
local Input = {Forward=false, Backward=false, Left=false, Right=false, Up=false, Down=false}

-- Actualizar personaje
local function UpdateCharacter()
    Character = Player.Character or Player.CharacterAdded:Wait()
    Humanoid = Character:WaitForChild("Humanoid", 3)
    RootPart = Character:WaitForChild("HumanoidRootPart", 3)
    Camera = workspace.CurrentCamera
end

-- NOCLIP
local function SetNoclip(state)
    if not Character then return end
    for _, part in ipairs(Character:GetDescendants()) do
        if part:IsA("BasePart") and part.CanCollide == state then 
            part.CanCollide = not state 
        end
    end
end

-- SISTEMA DE VUELO CORREGIDO
local function FlyUpdate(deltaTime)
    if not FlyEnabled or not RootPart or not Camera then return end
    
    -- Dirección según cámara
    local camCF = Camera.CFrame
    local camDir = Vector3.new(camCF.LookVector.X, 0, camCF.LookVector.Z)
    if camDir.Magnitude > 0 then camDir = camDir.Unit end
    
    local camRight = Vector3.new(camCF.RightVector.X, 0, camCF.RightVector.Z)
    if camRight.Magnitude > 0 then camRight = camRight.Unit end
    
    local dir = Vector3.zero
    
    -- Teclado / Joystick
    if Input.Forward then dir += camDir end
    if Input.Backward then dir -= camDir end
    if Input.Left then dir -= camRight end
    if Input.Right then dir += camRight end
    if Input.Up then dir += Vector3.new(0, 1, 0) end
    if Input.Down then dir -= Vector3.new(0, 1, 0) end
    
    -- Normalizar para velocidad uniforme
    if dir.Magnitude > 0 then dir = dir.Unit end
    
    -- Anular inercia y caída
    RootPart.AssemblyLinearVelocity = Vector3.zero
    RootPart.AssemblyAngularVelocity = Vector3.zero
    
    -- Aplicar movimiento exacto
    RootPart.CFrame += dir * (FlySpeed * deltaTime)
end

-- ACTIVAR/DESACTIVAR FLY
local function ToggleFly()
    UpdateCharacter()
    if not Humanoid or not RootPart then return false end
    
    FlyEnabled = not FlyEnabled
    
    Humanoid.PlatformStand = FlyEnabled
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, not FlyEnabled)
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, not FlyEnabled)
    
    if FlyEnabled then
        SetNoclip(true)
        -- Mantener noclip activo
        NoclipConnection = RunService.Stepped:Connect(function()
            if FlyEnabled then SetNoclip(true) end
        end)
    else
        if NoclipConnection then 
            NoclipConnection:Disconnect() 
            NoclipConnection = nil
        end
        SetNoclip(false)
        RootPart.AssemblyLinearVelocity = Vector3.zero
    end
    
    return FlyEnabled
end

-- CONTROLES PC
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

-- SOPORTE JOYSTICK MÓVIL
UserInputService.InputChanged:Connect(function(input, gp)
    if input.KeyCode == Enum.KeyCode.Thumbstick1 then
        local pos = input.Position
        Input.Forward = pos.Y > 0.2
        Input.Backward = pos.Y < -0.2
        Input.Left = pos.X < -0.2
        Input.Right = pos.X > 0.2
    end
end)

RunService.RenderStepped:Connect(FlyUpdate)
Player.CharacterAdded:Connect(UpdateCharacter)

-- ================== INTERFAZ UI ==================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_BloxFlyUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Contenedor principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 220, 0, 220)
MainFrame.Position = UDim2.new(0.02, 0, 0.5, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

-- Esquinas redondeadas
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

-- Título + Icono
local TitleContainer = Instance.new("Frame")
TitleContainer.Parent = MainFrame
TitleContainer.Size = UDim2.new(1, -16, 0, 50)
TitleContainer.Position = UDim2.new(0, 8, 0, 8)
TitleContainer.BackgroundTransparency = 1

local ShoeIcon = Instance.new("TextLabel")
ShoeIcon.Parent = TitleContainer
ShoeIcon.Size = UDim2.new(0, 32, 1, 0)
ShoeIcon.BackgroundTransparency = 1
ShoeIcon.Text = "👟"
ShoeIcon.Font = Enum.Font.GothamBold
ShoeIcon.TextSize = 26
ShoeIcon.TextColor3 = Color3.fromRGB(255, 100, 100)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = TitleContainer
TitleLabel.Size = UDim2.new(1, -36, 1, 0)
TitleLabel.Position = UDim2.new(0, 36, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "JoseAngel_Blox Fly"
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 14
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Separador
local Separator = Instance.new("Frame")
Separator.Parent = MainFrame
Separator.Size = UDim2.new(1, -20, 0, 1)
Separator.Position = UDim2.new(0, 10, 0, 58)
Separator.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
local SepCorner = Instance.new("UICorner")
SepCorner.CornerRadius = UDim.new(0, 1)
SepCorner.Parent = Separator

-- Botón FLY
local FlyBtn = Instance.new("TextButton")
FlyBtn.Parent = MainFrame
FlyBtn.Size = UDim2.new(1, -24, 0, 50)
FlyBtn.Position = UDim2.new(0, 12, 0, 70)
FlyBtn.BackgroundColor3 = Color3.fromRGB(58, 58, 68)
FlyBtn.Font = Enum.Font.GothamBold
FlyBtn.Text = "FLY"
FlyBtn.TextSize = 16
FlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyBtn.AutoLocalize = false
local FlyBtnCorner = Instance.new("UICorner")
FlyBtnCorner.CornerRadius = UDim.new(0, 12)
FlyBtnCorner.Parent = FlyBtn

-- Contenedor Velocidad
local SpeedContainer = Instance.new("Frame")
SpeedContainer.Parent = MainFrame
SpeedContainer.Size = UDim2.new(1, -24, 0, 50)
SpeedContainer.Position = UDim2.new(0, 12, 0, 135)
SpeedContainer.BackgroundTransparency = 1

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = SpeedContainer
SpeedLabel.Size = UDim2.new(1, 0, 0, 20)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Velocidad: " .. FlySpeed
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextSize = 13
SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)

-- Botón Menos
local MinusBtn = Instance.new("TextButton")
MinusBtn.Parent = SpeedContainer
MinusBtn.Size = UDim2.new(0, 50, 0, 32)
MinusBtn.Position = UDim2.new(0, 0, 0, 18)
MinusBtn.BackgroundColor3 = Color3.fromRGB(52, 52, 62)
MinusBtn.Text = "−"
MinusBtn.Font = Enum.Font.GothamBold
MinusBtn.TextSize = 20
MinusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
local MinusCorner = Instance.new("UICorner")
MinusCorner.CornerRadius = UDim.new(0, 10)
MinusCorner.Parent = MinusBtn

-- Botón Más
local PlusBtn = Instance.new("TextButton")
PlusBtn.Parent = SpeedContainer
PlusBtn.Size = UDim2.new(0, 50, 0, 32)
PlusBtn.Position = UDim2.new(1, -50, 0, 18)
PlusBtn.BackgroundColor3 = Color3.fromRGB(52, 52, 62)
PlusBtn.Text = "+"
PlusBtn.Font = Enum.Font.GothamBold
PlusBtn.TextSize = 20
PlusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
local PlusCorner = Instance.new("UICorner")
PlusCorner.CornerRadius = UDim.new(0, 10)
PlusCorner.Parent = PlusBtn

-- ACCIONES
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
