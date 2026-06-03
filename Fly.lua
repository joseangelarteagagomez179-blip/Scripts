-- Nombre del Script: JoseAngel_Blox Fly
-- Propósito: Vuelo universal compatible con PC y Celular
-- Advertencia: Solo para uso educativo

-- Servicios necesarios
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Datos del jugador
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Character, Humanoid, HumanoidRootPart

-- Variables de control
local FlyEnabled = false
local FlySpeed = 60
local BodyVel, Gyro = nil, nil

-- Función para cargar el personaje
local function CargarPersonaje()
    Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    Humanoid = Character:WaitForChild("Humanoid", 10)
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart", 10)
end
CargarPersonaje()

-- ======================================
-- INTERFAZ - JoseAngel_Blox Fly
-- ======================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox_Fly"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- Burbuja redonda con letra F
local Burbuja = Instance.new("Frame")
Burbuja.Name = "BotonFlotante"
Burbuja.Size = UDim2.new(0, 60, 0, 60)
Burbuja.Position = UDim2.new(0.05, 0, 0.45, 0)
Burbuja.BackgroundColor3 = Color3.fromRGB(25, 110, 255)
Burbuja.BorderSizePixel = 0
Burbuja.AnchorPoint = Vector2.new(0.5, 0.5)
Burbuja.Active = true
Burbuja.Draggable = true
Burbuja.Parent = ScreenGui

local EsquinaBurbuja = Instance.new("UICorner")
EsquinaBurbuja.CornerRadius = UDim.new(1, 0)
EsquinaBurbuja.Parent = Burbuja

local TextoBurbuja = Instance.new("TextLabel")
TextoBurbuja.Size = UDim2.new(1, 0, 1, 0)
TextoBurbuja.BackgroundTransparency = 1
TextoBurbuja.Text = "F"
TextoBurbuja.Font = Enum.Font.GothamBold
TextoBurbuja.TextColor3 = Color3.new(1, 1, 1)
TextoBurbuja.TextSize = 26
TextoBurbuja.Parent = Burbuja

-- Menú principal
local Menu = Instance.new("Frame")
Menu.Name = "MenuPrincipal"
Menu.Size = UDim2.new(0, 190, 0, 230)
Menu.Position = UDim2.new(0.18, 0, 0.38, 0)
Menu.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
Menu.BorderSizePixel = 0
Menu.Visible = false
Menu.Active = true
Menu.Draggable = true
Menu.Parent = ScreenGui

local EsquinaMenu = Instance.new("UICorner")
EsquinaMenu.CornerRadius = UDim.new(0.12, 0)
EsquinaMenu.Parent = Menu

local Titulo = Instance.new("TextLabel")
Titulo.Size = UDim2.new(1, 0, 0, 40)
Titulo.BackgroundTransparency = 1
Titulo.Text = "JoseAngel_Blox Fly"
Titulo.Font = Enum.Font.GothamBold
Titulo.TextColor3 = Color3.fromRGB(255, 215, 0)
Titulo.TextSize = 16
Titulo.Parent = Menu

-- Botón Activar/Desactivar Vuelo
local BtnVolar = Instance.new("TextButton")
BtnVolar.Size = UDim2.new(0.82, 0, 0, 42)
BtnVolar.Position = UDim2.new(0.09, 0, 0.26, 0)
BtnVolar.BackgroundColor3 = Color3.fromRGB(50, 180, 90)
BtnVolar.Text = "Volar: OFF"
BtnVolar.Font = Enum.Font.GothamSemibold
BtnVolar.TextColor3 = Color3.new(1, 1, 1)
BtnVolar.TextSize = 16
BtnVolar.Parent = Menu
Instance.new("UICorner", BtnVolar).CornerRadius = UDim.new(0.2, 0)

-- Botón Aumentar Velocidad
local BtnMas = Instance.new("TextButton")
BtnMas.Size = UDim2.new(0.32, 0, 0, 42)
BtnMas.Position = UDim2.new(0.09, 0, 0.58, 0)
BtnMas.BackgroundColor3 = Color3.fromRGB(40, 140, 255)
BtnMas.Text = "+"
BtnMas.Font = Enum.Font.GothamBold
BtnMas.TextColor3 = Color3.new(1, 1, 1)
BtnMas.TextSize = 22
BtnMas.Parent = Menu
Instance.new("UICorner", BtnMas).CornerRadius = UDim.new(0.2, 0)

-- Texto Velocidad Actual
local TextoVelocidad = Instance.new("TextLabel")
TextoVelocidad.Size = UDim2.new(0.30, 0, 0, 42)
TextoVelocidad.Position = UDim2.new(0.39, 0, 0.58, 0)
TextoVelocidad.BackgroundTransparency = 1
TextoVelocidad.Text = tostring(FlySpeed)
TextoVelocidad.Font = Enum.Font.Gotham
TextoVelocidad.TextColor3 = Color3.new(1, 1, 1)
TextoVelocidad.TextSize = 18
TextoVelocidad.Parent = Menu

-- Botón Disminuir Velocidad
local BtnMenos = Instance.new("TextButton")
BtnMenos.Size = UDim2.new(0.32, 0, 0, 42)
BtnMenos.Position = UDim2.new(0.68, 0, 0.58, 0)
BtnMenos.BackgroundColor3 = Color3.fromRGB(220, 70, 70)
BtnMenos.Text = "-"
BtnMenos.Font = Enum.Font.GothamBold
BtnMenos.TextColor3 = Color3.new(1, 1, 1)
BtnMenos.TextSize = 22
BtnMenos.Parent = Menu
Instance.new("UICorner", BtnMenos).CornerRadius = UDim.new(0.2, 0)

-- ======================================
-- FUNCIONES DE CONTROL
-- ======================================
-- Abrir/Cerrar menú al pulsar la burbuja
Burbuja.MouseButton1Click:Connect(function()
    Menu.Visible = not Menu.Visible
end)

-- Activar vuelo
local function ActivarVuelo()
    if not Character or not HumanoidRootPart then return end
    DesactivarVuelo()

    BodyVel = Instance.new("BodyVelocity")
    BodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    BodyVel.Velocity = Vector3.new(0, 0, 0)
    BodyVel.Parent = HumanoidRootPart

    Gyro = Instance.new("BodyGyro")
    Gyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    Gyro.CFrame = HumanoidRootPart.CFrame
    Gyro.Parent = HumanoidRootPart

    Humanoid.PlatformStand = true
    Humanoid.AutoRotate = false

    FlyEnabled = true
    BtnVolar.Text = "Volar: ON"
    BtnVolar.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
end

-- Desactivar vuelo
local function DesactivarVuelo()
    if BodyVel then BodyVel:Destroy() end
    if Gyro then Gyro:Destroy() end

    if Humanoid then
        Humanoid.PlatformStand = false
        Humanoid.AutoRotate = true
    end

    FlyEnabled = false
    BtnVolar.Text = "Volar: OFF"
    BtnVolar.BackgroundColor3 = Color3.fromRGB(50, 180, 90)
end

-- Botón principal
BtnVolar.MouseButton1Click:Connect(function()
    if FlyEnabled then DesactivarVuelo() else ActivarVuelo() end
end)

-- Cambiar velocidad
BtnMas.MouseButton1Click:Connect(function()
    FlySpeed = math.clamp(FlySpeed + 10, 20, 400)
    TextoVelocidad.Text = tostring(FlySpeed)
end)

BtnMenos.MouseButton1Click:Connect(function()
    FlySpeed = math.clamp(FlySpeed - 10, 20, 400)
    TextoVelocidad.Text = tostring(FlySpeed)
end)

-- Control de movimiento
RunService.RenderStepped:Connect(function()
    if not FlyEnabled or not BodyVel or not Gyro or not HumanoidRootPart then return end

    local Camara = workspace.CurrentCamera
    local Direccion = Vector3.new()

    -- Controles PC
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then Direccion += Camara.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then Direccion -= Camara.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then Direccion -= Camara.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then Direccion += Camara.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then Direccion += Vector3.new(0, 1, 0) end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then Direccion -= Vector3.new(0, 1, 0) end

    -- Aplicar velocidad
    if Direccion.Magnitude > 0 then
        Direccion = Direccion.Unit * FlySpeed
    end

    BodyVel.Velocity = Direccion
    Gyro.CFrame = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + Camara.CFrame.LookVector)
end)

-- Recargar al reaparecer
LocalPlayer.CharacterAdded:Connect(function()
    CargarPersonaje()
    DesactivarVuelo()
end)
