-- JoseAngel_Blox Fly | Versión 1.2
-- Fecha de lanzamiento: 06/07/2026
-- Creador: JoseAngel_Blox

-- Servicios
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- Jugador
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Variables
local FlyActive = false
local NoclipActive = false
local FlySpeed = 60
local FlyBodyVel = nil
local GuiVisible = true
local FlyOpen = false

-- Interfaz principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_BloxFly"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Marco principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 130)
MainFrame.Position = UDim2.new(0.08, 0, 0.12, 0)
MainFrame.BackgroundColor3 = Color3.new(0.12, 0.12, 0.15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.new(0.18, 0.18, 0.22)
Title.Text = "JoseAngel_Blox Fly"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.Parent = MainFrame

local UICornerTitle = Instance.new("UICorner")
UICornerTitle.CornerRadius = UDim.new(0, 10)
UICornerTitle.Parent = Title

-- Botón Minimizar
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -33, 0, 2.5)
MinimizeBtn.BackgroundColor3 = Color3.new(0.25,0.25,0.3)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.new(1,1,1)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 18
MinimizeBtn.Parent = Title

local UICornerMin = Instance.new("UICorner")
UICornerMin.CornerRadius = UDim.new(0, 6)
UICornerMin.Parent = MinimizeBtn

-- Botón flotante para restaurar
local RestoreBtn = Instance.new("TextButton")
RestoreBtn.Size = UDim2.new(0, 40, 0, 40)
RestoreBtn.Position = MainFrame.Position
RestoreBtn.BackgroundColor3 = Color3.new(0.2, 0.6, 1)
RestoreBtn.Text = "✈️"
RestoreBtn.TextColor3 = Color3.new(1,1,1)
RestoreBtn.Font = Enum.Font.GothamBold
RestoreBtn.TextSize = 16
RestoreBtn.Visible = false
RestoreBtn.Active = true
RestoreBtn.Draggable = true
RestoreBtn.Parent = ScreenGui

local UICornerRestore = Instance.new("UICorner")
UICornerRestore.CornerRadius = UDim.new(0, 10)
UICornerRestore.Parent = RestoreBtn

-- Contenedor de contenido
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -10, 0, 85)
ContentFrame.Position = UDim2.new(0,5,0,40)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Botón Info
local InfoBtn = Instance.new("TextButton")
InfoBtn.Size = UDim2.new(1,0,0,32)
InfoBtn.BackgroundColor3 = Color3.new(0.15,0.15,0.18)
InfoBtn.Text = "Info ↓"
InfoBtn.TextColor3 = Color3.new(1,1,1)
InfoBtn.Font = Enum.Font.Gotham
InfoBtn.TextSize = 13
InfoBtn.TextXAlignment = Enum.TextXAlignment.Left
InfoBtn.Parent = ContentFrame

local UICornerInfo = Instance.new("UICorner")
UICornerInfo.CornerRadius = UDim.new(0, 6)
UICornerInfo.Parent = InfoBtn

-- Panel Info
local InfoFrame = Instance.new("Frame")
InfoFrame.Size = UDim2.new(1, 0, 0, 70)
InfoFrame.Position = UDim2.new(0, 0, 0, 37)
InfoFrame.BackgroundColor3 = Color3.new(0.14,0.14,0.17)
InfoFrame.Visible = false
InfoFrame.Parent = ContentFrame

local UICornerInfoF = Instance.new("UICorner")
UICornerInfoF.CornerRadius = UDim.new(0, 6)
UICornerInfoF.Parent = InfoFrame

local InfoText = Instance.new("TextLabel")
InfoText.Size = UDim2.new(1, -8, 1, -8)
InfoText.Position = UDim2.new(0,4,0,4)
InfoText.BackgroundTransparency = 1
InfoText.Text = "👤 Creador: JoseAngel_Blox\n📅 Lanzamiento: 06/07/2026\n📌 Versión: 1.2"
InfoText.TextColor3 = Color3.new(0.9,0.9,0.9)
InfoText.Font = Enum.Font.Gotham
InfoText.TextSize = 12
InfoText.TextXAlignment = Enum.TextXAlignment.Left
InfoText.TextWrapped = true
InfoText.Parent = InfoFrame

-- Botón Fly (debajo igual que Info)
local FlyBtn = Instance.new("TextButton")
FlyBtn.Size = UDim2.new(1,0,0,32)
FlyBtn.Position = UDim2.new(0,0,0, 112)
FlyBtn.BackgroundColor3 = Color3.new(0.15,0.15,0.18)
FlyBtn.Text = "Fly ↓"
FlyBtn.TextColor3 = Color3.new(1,1,1)
FlyBtn.Font = Enum.Font.Gotham
FlyBtn.TextSize = 13
FlyBtn.TextXAlignment = Enum.TextXAlignment.Left
FlyBtn.Parent = ContentFrame

local UICornerFlyBtn = Instance.new("UICorner")
UICornerFlyBtn.CornerRadius = UDim.new(0, 6)
UICornerFlyBtn.Parent = FlyBtn

-- Panel Fly
local FlyFrame = Instance.new("Frame")
FlyFrame.Size = UDim2.new(1,0,0,90)
FlyFrame.Position = UDim2.new(0,0,0, 149)
FlyFrame.BackgroundColor3 = Color3.new(0.14,0.14,0.17)
FlyFrame.Visible = false
FlyFrame.Parent = ContentFrame

local UICornerFlyF = Instance.new("UICorner")
UICornerFlyF.CornerRadius = UDim.new(0, 6)
UICornerFlyF.Parent = FlyFrame

-- Interruptor Fly
local FlyToggle = Instance.new("TextButton")
FlyToggle.Size = UDim2.new(0, 50, 0, 24)
FlyToggle.Position = UDim2.new(1, -55, 0, 5)
FlyToggle.BackgroundColor3 = Color3.new(0.4,0.4,0.4)
FlyToggle.Text = "OFF"
FlyToggle.TextColor3 = Color3.new(1,1,1)
FlyToggle.Font = Enum.Font.GothamBold
FlyToggle.TextSize = 12
FlyToggle.Parent = FlyFrame

local UICornerFlyT = Instance.new("UICorner")
UICornerFlyT.CornerRadius = UDim.new(0, 5)
UICornerFlyT.Parent = FlyToggle

-- Noclip
local NoclipLabel = Instance.new("TextLabel")
NoclipLabel.Size = UDim2.new(0, 60, 0, 22)
NoclipLabel.Position = UDim2.new(5, 0, 5, 0)
NoclipLabel.BackgroundTransparency = 1
NoclipLabel.Text = "Noclip"
NoclipLabel.TextColor3 = Color3.new(1,1,1)
NoclipLabel.Font = Enum.Font.Gotham
NoclipLabel.TextSize = 12
NoclipLabel.TextXAlignment = Enum.TextXAlignment.Left
NoclipLabel.Parent = FlyFrame

local NoclipToggle = Instance.new("TextButton")
NoclipToggle.Size = UDim2.new(0, 45, 0, 22)
NoclipToggle.Position = UDim2.new(1, -50, 0, 29)
NoclipToggle.BackgroundColor3 = Color3.new(0.4,0.4,0.4)
NoclipToggle.Text = "OFF"
NoclipToggle.TextColor3 = Color3.new(1,1,1)
NoclipToggle.Font = Enum.Font.Gotham
NoclipToggle.TextSize = 11
NoclipToggle.Parent = FlyFrame

local UICornerNoclipT = Instance.new("UICorner")
UICornerNoclipT.CornerRadius = UDim.new(0, 5)
UICornerNoclipT.Parent = NoclipToggle

-- Velocidad
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0, 80, 0, 22)
SpeedLabel.Position = UDim2.new(5, 0, 32, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Velocidad: "..FlySpeed
SpeedLabel.TextColor3 = Color3.new(1,1,1)
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextSize = 12
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = FlyFrame

local SpeedDown = Instance.new("TextButton")
SpeedDown.Size = UDim2.new(0, 22, 0, 22)
SpeedDown.Position = UDim2.new(1, -50, 32, 0)
SpeedDown.BackgroundColor3 = Color3.new(0.8,0.2,0.2)
SpeedDown.Text = "-"
SpeedDown.TextColor3 = Color3.new(1,1,1)
SpeedDown.Font = Enum.Font.GothamBold
SpeedDown.TextSize = 14
SpeedDown.Parent = FlyFrame

local UICornerSpeedD = Instance.new("UICorner")
UICornerSpeedD.CornerRadius = UDim.new(0, 5)
UICornerSpeedD.Parent = SpeedDown

local SpeedUp = Instance.new("TextButton")
SpeedUp.Size = UDim2.new(0, 22, 0, 22)
SpeedUp.Position = UDim2.new(1, -25, 32, 0)
SpeedUp.BackgroundColor3 = Color3.new(0.2,0.7,0.3)
SpeedUp.Text = "+"
SpeedUp.TextColor3 = Color3.new(1,1,1)
SpeedUp.Font = Enum.Font.GothamBold
SpeedUp.TextSize = 14
SpeedUp.Parent = FlyFrame

local UICornerSpeedU = Instance.new("UICorner")
UICornerSpeedU.CornerRadius = UDim.new(0, 5)
UICornerSpeedU.Parent = SpeedUp

-- Funciones de vuelo
local function ActivarFly()
    if FlyActive then return end
    FlyActive = true
    Humanoid.PlatformStand = true
    FlyBodyVel = Instance.new("BodyVelocity")
    FlyBodyVel.MaxForce = Vector3.new(9e9,9e9,9e9)
    FlyBodyVel.Velocity = Vector3.new(0,0,0)
    FlyBodyVel.Parent = RootPart
end

local function DesactivarFly()
    if not FlyActive then return end
    FlyActive = false
    Humanoid.PlatformStand = false
    if FlyBodyVel then FlyBodyVel:Destroy() end
end

-- Noclip
local function ActualizarNoclip()
    if NoclipActive and Character then
        for _,v in ipairs(Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end

-- Eventos
InfoBtn.MouseButton1Click:Connect(function()
    InfoFrame.Visible = not InfoFrame.Visible
    InfoBtn.Text = InfoFrame.Visible and "Info ↑" or "Info ↓"
end)

FlyBtn.MouseButton1Click:Connect(function()
    FlyFrame.Visible = not FlyFrame.Visible
    FlyBtn.Text = FlyFrame.Visible and "Fly ↑" or "Fly ↓"
    FlyOpen = FlyFrame.Visible
    MainFrame.Size = UDim2.new(0, 260, 0, FlyOpen and 245 or 130)
end)

FlyToggle.MouseButton1Click:Connect(function()
    FlyActive = not FlyActive
    if FlyActive then
        ActivarFly()
        FlyToggle.BackgroundColor3 = Color3.new(0.2,0.7,0.3)
        FlyToggle.Text = "ON"
    else
        DesactivarFly()
        FlyToggle.BackgroundColor3 = Color3.new(0.4,0.4,0.4)
        FlyToggle.Text = "OFF"
    end
end)

NoclipToggle.MouseButton1Click:Connect(function()
    NoclipActive = not NoclipActive
    if NoclipActive then
        NoclipToggle.BackgroundColor3 = Color3.new(0.2,0.7,0.3)
        NoclipToggle.Text = "ON"
    else
        NoclipToggle.BackgroundColor3 = Color3.new(0.4,0.4,0.4)
        NoclipToggle.Text = "OFF"
        for _,v in ipairs(Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = true end
        end
    end
end)

SpeedUp.MouseButton1Click:Connect(function()
    FlySpeed = math.min(FlySpeed + 10, 350)
    SpeedLabel.Text = "Velocidad: "..FlySpeed
end)

SpeedDown.MouseButton1Click:Connect(function()
    FlySpeed = math.max(FlySpeed - 10, 20)
    SpeedLabel.Text = "Velocidad: "..FlySpeed
end)

MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    RestoreBtn.Visible = true
end)

RestoreBtn.MouseButton1Click:Connect(function()
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
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir -= Vector3.new(0,1,0) end

        FlyBodyVel.Velocity = dir.Magnitude > 0 and dir.Unit * FlySpeed or Vector3.new(0,0,0)
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

print("✅ JoseAngel_Blox Fly v1.2 corregido ❤️")
