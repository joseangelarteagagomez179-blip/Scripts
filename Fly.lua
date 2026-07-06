-- JoseAngel_Blox Fly | Versión 1.2
-- Fecha de lanzamiento: 06/07/2026
-- Creador: JoseAngel_Blox

-- Servicios necesarios
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Variables de control
local FlyActive = false
local NoclipActive = false
local FlySpeed = 60
local FlyBodyVel = nil
local GuiVisible = true

-- Crear interfaz principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_BloxFly"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Marco principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 220)
MainFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
MainFrame.BackgroundColor3 = Color3.new(0.12, 0.12, 0.15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Esquinas redondeadas
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.new(0.18, 0.18, 0.22)
Title.Text = "JoseAngel_Blox Fly"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = MainFrame

local UICornerTitle = Instance.new("UICorner")
UICornerTitle.CornerRadius = UDim.new(0, 10)
UICornerTitle.Parent = Title

-- Botón minimizar
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -35, 0, 2)
MinimizeBtn.BackgroundColor3 = Color3.new(0.25, 0.25, 0.3)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.new(1, 1, 1)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 18
MinimizeBtn.Parent = Title

local UICornerMin = Instance.new("UICorner")
UICornerMin.CornerRadius = UDim.new(0, 6)
UICornerMin.Parent = MinimizeBtn

-- Botón flotante para volver a abrir
local RestoreBtn = Instance.new("TextButton")
RestoreBtn.Size = UDim2.new(0, 45, 0, 45)
RestoreBtn.Position = UDim2.new(0.05, 0, 0.1, 0)
RestoreBtn.BackgroundColor3 = Color3.new(0.2, 0.6, 1)
RestoreBtn.Text = "📌"
RestoreBtn.TextColor3 = Color3.new(1, 1, 1)
RestoreBtn.Font = Enum.Font.GothamBold
RestoreBtn.TextSize = 18
RestoreBtn.Visible = false
RestoreBtn.Active = true
RestoreBtn.Draggable = true
RestoreBtn.Parent = ScreenGui

local UICornerRestore = Instance.new("UICorner")
UICornerRestore.CornerRadius = UDim.new(0, 12)
UICornerRestore.Parent = RestoreBtn

-- Panel izquierdo: Opciones
local LeftPanel = Instance.new("Frame")
LeftPanel.Size = UDim2.new(0.4, -5, 1, -40)
LeftPanel.Position = UDim2.new(0, 5, 0, 38)
LeftPanel.BackgroundTransparency = 1
LeftPanel.Parent = MainFrame

-- Botón Info
local InfoBtn = Instance.new("TextButton")
InfoBtn.Size = UDim2.new(1, 0, 0, 40)
InfoBtn.BackgroundColor3 = Color3.new(0.15, 0.15, 0.18)
InfoBtn.Text = "Info ↓"
InfoBtn.TextColor3 = Color3.new(1, 1, 1)
InfoBtn.Font = Enum.Font.Gotham
InfoBtn.TextSize = 14
InfoBtn.Parent = LeftPanel

local UICornerInfo = Instance.new("UICorner")
UICornerInfo.CornerRadius = UDim.new(0, 8)
UICornerInfo.Parent = InfoBtn

-- Panel derecho: Funciones
local RightPanel = Instance.new("Frame")
RightPanel.Size = UDim2.new(0.55, -5, 1, -40)
RightPanel.Position = UDim2.new(0.45, 5, 0, 38)
RightPanel.BackgroundTransparency = 1
RightPanel.Parent = MainFrame

-- Subpanel Info
local InfoFrame = Instance.new("Frame")
InfoFrame.Size = UDim2.new(1, 0, 0, 90)
InfoFrame.Position = UDim2.new(0, 0, 0, 0)
InfoFrame.BackgroundColor3 = Color3.new(0.14, 0.14, 0.17)
InfoFrame.Visible = false
InfoFrame.Parent = RightPanel

local UICornerInfoFrame = Instance.new("UICorner")
UICornerInfoFrame.CornerRadius = UDim.new(0, 8)
UICornerInfoFrame.Parent = InfoFrame

local InfoText = Instance.new("TextLabel")
InfoText.Size = UDim2.new(1, -10, 1, -10)
InfoText.Position = UDim2.new(0, 5, 0, 5)
InfoText.BackgroundTransparency = 1
InfoText.Text = "👤 Creador: JoseAngel_Blox\n📅 Lanzamiento: 06/07/2026\n📌 Versión: 1.2"
InfoText.TextColor3 = Color3.new(0.9, 0.9, 0.9)
InfoText.Font = Enum.Font.Gotham
InfoText.TextSize = 13
InfoText.TextXAlignment = Enum.TextXAlignment.Left
InfoText.TextWrapped = true
InfoText.Parent = InfoFrame

-- Subpanel Fly
local FlyFrame = Instance.new("Frame")
FlyFrame.Size = UDim2.new(1, 0, 0, 115)
FlyFrame.Position = UDim2.new(0, 0, 0, 95)
FlyFrame.BackgroundColor3 = Color3.new(0.14, 0.14, 0.17)
FlyFrame.Parent = RightPanel

local UICornerFlyFrame = Instance.new("UICorner")
UICornerFlyFrame.CornerRadius = UDim.new(0, 8)
UICornerFlyFrame.Parent = FlyFrame

local FlyLabel = Instance.new("TextLabel")
FlyLabel.Size = UDim2.new(1, -10, 0, 25)
FlyLabel.Position = UDim2.new(0, 5, 0, 5)
FlyLabel.BackgroundTransparency = 1
FlyLabel.Text = "Fly ↓"
FlyLabel.TextColor3 = Color3.new(1, 1, 1)
FlyLabel.Font = Enum.Font.GothamBold
FlyLabel.TextSize = 14
FlyLabel.TextXAlignment = Enum.TextXAlignment.Left
FlyLabel.Parent = FlyFrame

-- Interruptor Fly
local FlyToggle = Instance.new("TextButton")
FlyToggle.Size = UDim2.new(0, 60, 0, 25)
FlyToggle.Position = UDim2.new(1, -65, 0, 5)
FlyToggle.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
FlyToggle.Text = "OFF"
FlyToggle.TextColor3 = Color3.new(1, 1, 1)
FlyToggle.Font = Enum.Font.GothamBold
FlyToggle.TextSize = 12
FlyToggle.Parent = FlyFrame

local UICornerFlyToggle = Instance.new("UICorner")
UICornerFlyToggle.CornerRadius = UDim.new(0, 6)
UICornerFlyToggle.Parent = FlyToggle

-- Interruptor Noclip
local NoclipLabel = Instance.new("TextLabel")
NoclipLabel.Size = UDim2.new(0, 80, 0, 25)
NoclipLabel.Position = UDim2.new(0, 5, 0, 35)
NoclipLabel.BackgroundTransparency = 1
NoclipLabel.Text = "Noclip"
NoclipLabel.TextColor3 = Color3.new(1, 1, 1)
NoclipLabel.Font = Enum.Font.Gotham
NoclipLabel.TextSize = 13
NoclipLabel.TextXAlignment = Enum.TextXAlignment.Left
NoclipLabel.Parent = FlyFrame

local NoclipToggle = Instance.new("TextButton")
NoclipToggle.Size = UDim2.new(0, 50, 0, 22)
NoclipToggle.Position = UDim2.new(1, -55, 0, 36)
NoclipToggle.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
NoclipToggle.Text = "OFF"
NoclipToggle.TextColor3 = Color3.new(1, 1, 1)
NoclipToggle.Font = Enum.Font.Gotham
NoclipToggle.TextSize = 11
NoclipToggle.Parent = FlyFrame

local UICornerNoclip = Instance.new("UICorner")
UICornerNoclip.CornerRadius = UDim.new(0, 5)
UICornerNoclip.Parent = NoclipToggle

-- Control de velocidad
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0, 100, 0, 25)
SpeedLabel.Position = UDim2.new(0, 5, 0, 65)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Velocidad: "..FlySpeed
SpeedLabel.TextColor3 = Color3.new(1, 1, 1)
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextSize = 13
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = FlyFrame

local SpeedUp = Instance.new("TextButton")
SpeedUp.Size = UDim2.new(0, 25, 0, 22)
SpeedUp.Position = UDim2.new(1, -55, 0, 66)
SpeedUp.BackgroundColor3 = Color3.new(0.2, 0.7, 0.3)
SpeedUp.Text = "+"
SpeedUp.TextColor3 = Color3.new(1, 1, 1)
SpeedUp.Font = Enum.Font.GothamBold
SpeedUp.TextSize = 14
SpeedUp.Parent = FlyFrame

local UICornerSpeedUp = Instance.new("UICorner")
UICornerSpeedUp.CornerRadius = UDim.new(0, 5)
UICornerSpeedUp.Parent = SpeedUp

local SpeedDown = Instance.new("TextButton")
SpeedDown.Size = UDim2.new(0, 25, 0, 22)
SpeedDown.Position = UDim2.new(1, -85, 0, 66)
SpeedDown.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
SpeedDown.Text = "-"
SpeedDown.TextColor3 = Color3.new(1, 1, 1)
SpeedDown.Font = Enum.Font.GothamBold
SpeedDown.TextSize = 14
SpeedDown.Parent = FlyFrame

local UICornerSpeedDown = Instance.new("UICorner")
UICornerSpeedDown.CornerRadius = UDim.new(0, 5)
UICornerSpeedDown.Parent = SpeedDown

-- Funciones de vuelo
local function ActivarFly()
    if FlyActive then return end
    FlyActive = true
    Humanoid.PlatformStand = true
    FlyBodyVel = Instance.new("BodyVelocity")
    FlyBodyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    FlyBodyVel.Parent = RootPart
end

local function DesactivarFly()
    if not FlyActive then return end
    FlyActive = false
    Humanoid.PlatformStand = false
    if FlyBodyVel then FlyBodyVel:Destroy() end
end

local function ActualizarNoclip()
    if NoclipActive and Character then
        for _, parte in ipairs(Character:GetDescendants()) do
            if parte:IsA("BasePart") then
                parte.CanCollide = false
            end
        end
    end
end

-- Conexiones
InfoBtn.MouseButton1Click:Connect(function()
    InfoFrame.Visible = not InfoFrame.Visible
    InfoBtn.Text = InfoFrame.Visible and "Info ↑" or "Info ↓"
end)

FlyToggle.MouseButton1Click:Connect(function()
    FlyActive = not FlyActive
    if FlyActive then
        ActivarFly()
        FlyToggle.BackgroundColor3 = Color3.new(0.2, 0.7, 0.3)
        FlyToggle.Text = "ON"
    else
        DesactivarFly()
        FlyToggle.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
        FlyToggle.Text = "OFF"
    end
end)

NoclipToggle.MouseButton1Click:Connect(function()
    NoclipActive = not NoclipActive
    if NoclipActive then
        NoclipToggle.BackgroundColor3 = Color3.new(0.2, 0.7, 0.3)
        NoclipToggle.Text = "ON"
    else
        NoclipToggle.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
        NoclipToggle.Text = "OFF"
        for _, parte in ipairs(Character:GetDescendants()) do
            if parte:IsA("BasePart") then parte.CanCollide = true end
        end
    end
end)

SpeedUp.MouseButton1Click:Connect(function()
    FlySpeed = math.min(FlySpeed + 10, 300)
    SpeedLabel.Text = "Velocidad: "..FlySpeed
end)

SpeedDown.MouseButton1Click:Connect(function()
    FlySpeed = math.max(FlySpeed - 10, 20)
    SpeedLabel.Text = "Velocidad: "..FlySpeed
end)

MinimizeBtn.MouseButton1Click:Connect(function()
    GuiVisible = false
    MainFrame.Visible = false
    RestoreBtn.Visible = true
end)

RestoreBtn.MouseButton1Click:Connect(function()
    GuiVisible = true
    MainFrame.Visible = true
    RestoreBtn.Visible = false
end)

-- Bucle principal
RunService.RenderStepped:Connect(function()
    if FlyActive and FlyBodyVel then
        local cam = workspace.CurrentCamera
        local dir = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir -= Vector3.new(0, 1, 0) end

        FlyBodyVel.Velocity = dir.Magnitude > 0 and dir.Unit * FlySpeed or Vector3.new(0, 0, 0)
    end

    if NoclipActive then ActualizarNoclip() end
end)

-- Recargar al revivir
LocalPlayer.CharacterAdded:Connect(function(nuevoChar)
    Character = nuevoChar
    Humanoid = nuevoChar:WaitForChild("Humanoid")
    RootPart = nuevoChar:WaitForChild("HumanoidRootPart")
    DesactivarFly()
end)

print("✅ JoseAngel_Blox Fly v1.2 cargado correctamente ❤️")
