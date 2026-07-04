--// SERVICES
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

--// VARIABLES
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local Char = Player.Character or Player.CharacterAdded:Wait()
local Hum = Char:WaitForChild("Humanoid")
local HRP = Char:WaitForChild("HumanoidRootPart")

--// SETTINGS
local Speed = 50
local Flying = false
local Noclip = false

-- ==============================================
-- ANIMACIÓN DE CARGA
-- ==============================================
local LoadingGui = Instance.new("ScreenGui")
LoadingGui.Name = "LoadingGui"
LoadingGui.Parent = game.CoreGui

local LoadingFrame = Instance.new("Frame")
LoadingFrame.Size = UDim2.new(0, 300, 0, 100)
LoadingFrame.Position = UDim2.new(0.5, -150, 0.5, -50)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
LoadingFrame.BorderSizePixel = 0
LoadingFrame.ClipsDescendants = true
LoadingFrame.Parent = LoadingGui

local UICornerLoad = Instance.new("UICorner")
UICornerLoad.CornerRadius = UDim.new(0,15)
UICornerLoad.Parent = LoadingFrame

local TitleLoad = Instance.new("TextLabel")
TitleLoad.Size = UDim2.new(1, -20, 0, 30)
TitleLoad.Position = UDim2.new(0, 10, 0, 5)
TitleLoad.BackgroundTransparency = 1
TitleLoad.Font = Enum.Font.GothamBold
TitleLoad.TextColor3 = Color3.fromRGB(255,255,255)
TitleLoad.TextSize = 16
TitleLoad.Text = "Bienvenidos a Scripts JoseAngel_Blox"
TitleLoad.Parent = LoadingFrame

local BarBackground = Instance.new("Frame")
BarBackground.Size = UDim2.new(0.8, 0, 0, 20)
BarBackground.Position = UDim2.new(0.1, 0, 0, 45)
BarBackground.BackgroundColor3 = Color3.fromRGB(40,40,40)
BarBackground.Parent = LoadingFrame

local UICornerBar = Instance.new("UICorner")
UICornerBar.CornerRadius = UDim.new(0,10)
UICornerBar.Parent = BarBackground

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
BarFill.Parent = BarBackground

local UICornerBar2 = Instance.new("UICorner")
UICornerBar2.CornerRadius = UDim.new(0,10)
UICornerBar2.Parent = BarFill

local PercentText = Instance.new("TextLabel")
PercentText.Size = UDim2.new(1, 0, 0, 20)
PercentText.Position = UDim2.new(0,0, 0, 70)
PercentText.BackgroundTransparency = 1
PercentText.Font = Enum.Font.Gotham
PercentText.TextColor3 = Color3.fromRGB(255,255,255)
PercentText.TextSize = 14
PercentText.Text = "0%"
PercentText.Parent = LoadingFrame

--// ANIMACIÓN DE CARGA
for i = 1, 100 do
    wait()
    PercentText.Text = i.."%"
    TweenService:Create(BarFill, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {Size = UDim2.new(i/100,0,1,0)}):Play()
end

wait(0.3)
TweenService:Create(LoadingFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1, Position = UDim2.new(0.5, -150, 0.5, 50)}):Play()
TweenService:Create(TitleLoad, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
TweenService:Create(PercentText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
TweenService:Create(BarBackground, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
TweenService:Create(BarFill, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
wait(0.5)
LoadingGui:Destroy()

-- ==============================================
-- INTERFAZ PRINCIPAL
-- ==============================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "JoseAngel_Blox_Fly"
Gui.Parent = game.CoreGui

--// MAIN FRAME
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 220, 0, 280)
Main.Position = UDim2.new(0.1, 0, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = Gui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 14)
UICorner.Parent = Main

--// TITULO
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.BorderSizePixel = 0
Title.Font = Enum.Font.GothamBold
Title.Text = "JoseAngel_Blox Fly"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextSize = 14
Title.Parent = Main

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 14)
TitleCorner.Parent = Title

--// BOTON MINIMIZAR (CORREGIDO)
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 25, 0, 25)
MinimizeBtn.Position = UDim2.new(1, -30, 0, 2.5)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
MinimizeBtn.BorderSizePixel = 0
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "_"
MinimizeBtn.TextColor3 = Color3.new(1,1,1)
MinimizeBtn.TextSize = 14
MinimizeBtn.Parent = Main

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 50)
MinCorner.Parent = MinimizeBtn

--// SECCION INFO
local InfoSection = Instance.new("TextButton") -- Cambiado a TextButton para que sea clickeable
InfoSection.Size = UDim2.new(1, -20, 0, 40)
InfoSection.Position = UDim2.new(0, 10, 0, 40)
InfoSection.BackgroundColor3 = Color3.fromRGB(40,40,40)
InfoSection.BorderSizePixel = 0
InfoSection.Parent = Main

local InfoCorner = Instance.new("UICorner")
InfoCorner.CornerRadius = UDim.new(0, 8)
InfoCorner.Parent = InfoSection

local InfoText = Instance.new("TextLabel")
InfoText.Size = UDim2.new(0.8, 0, 1, 0)
InfoText.Position = UDim2.new(0, 10, 0, 0)
InfoText.BackgroundTransparency = 1
InfoText.Font = Enum.Font.GothamBold
InfoText.Text = "Info ↓"
InfoText.TextColor3 = Color3.new(1,1,1)
InfoText.TextSize = 13
InfoText.TextXAlignment = Enum.TextXAlignment.Left
InfoText.Parent = InfoSection

local InfoContent = Instance.new("Frame")
InfoContent.Size = UDim2.new(1, -20, 0, 60)
InfoContent.Position = UDim2.new(0, 10, 0, 85)
InfoContent.BackgroundColor3 = Color3.fromRGB(45,45,45)
InfoContent.BorderSizePixel = 0
InfoContent.Visible = false
InfoContent.Parent = Main

local InfoContentCorner = Instance.new("UICorner")
InfoContentCorner.CornerRadius = UDim.new(0, 8)
InfoContentCorner.Parent = InfoContent

local InfoData = Instance.new("TextLabel")
InfoData.Size = UDim2.new(1, -10, 1, 0)
InfoData.Position = UDim2.new(0, 5, 0, 0)
InfoData.BackgroundTransparency = 1
InfoData.Font = Enum.Font.Gotham
InfoData.Text = "Creador: JoseAngel_Blox\nFecha: 04/06/2026\nVersión: 1.2"
InfoData.TextColor3 = Color3.new(1,1,1)
InfoData.TextSize = 11
InfoData.TextWrapped = true
InfoData.TextXAlignment = Enum.TextXAlignment.Left
InfoData.Parent = InfoContent

--// SECCION FLY
local FlySection = Instance.new("TextButton") -- Cambiado a TextButton para que sea clickeable
FlySection.Size = UDim2.new(1, -20, 0, 40)
FlySection.Position = UDim2.new(0, 10, 0, 150)
FlySection.BackgroundColor3 = Color3.fromRGB(40,40,40)
FlySection.BorderSizePixel = 0
FlySection.Parent = Main

local FlyCorner = Instance.new("UICorner")
FlyCorner.CornerRadius = UDim.new(0, 8)
FlyCorner.Parent = FlySection

local FlyText = Instance.new("TextLabel")
FlyText.Size = UDim2.new(0.5, 0, 1, 0)
FlyText.Position = UDim2.new(0, 10, 0, 0)
FlyText.BackgroundTransparency = 1
FlyText.Font = Enum.Font.GothamBold
FlyText.Text = "Fly ↓"
FlyText.TextColor3 = Color3.new(1,1,1)
FlyText.TextSize = 13
FlyText.TextXAlignment = Enum.TextXAlignment.Left
FlyText.Parent = FlySection

local FlyContent = Instance.new("Frame")
FlyContent.Size = UDim2.new(1, -20, 0, 70)
FlyContent.Position = UDim2.new(0, 10, 0, 195)
FlyContent.BackgroundColor3 = Color3.fromRGB(45,45,45)
FlyContent.BorderSizePixel = 0
FlyContent.Visible = false
FlyContent.Parent = Main

local FlyContentCorner = Instance.new("UICorner")
FlyContentCorner.CornerRadius = UDim.new(0, 8)
FlyContentCorner.Parent = FlyContent

--// TOGGLE FLY
local ToggleFly = Instance.new("TextButton")
ToggleFly.Size = UDim2.new(0, 40, 0, 20)
ToggleFly.Position = UDim2.new(0, 10, 0, 10)
ToggleFly.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
ToggleFly.BorderSizePixel = 0
ToggleFly.Text = "OFF"
ToggleFly.Font = Enum.Font.GothamBold
ToggleFly.TextColor3 = Color3.new(1,1,1)
ToggleFly.TextSize = 11
ToggleFly.Parent = FlyContent

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 10)
ToggleCorner.Parent = ToggleFly

--// SPEED CONTROL
local SpeedText = Instance.new("TextLabel")
SpeedText.Size = UDim2.new(1, -20, 0, 20)
SpeedText.Position = UDim2.new(0, 10, 0, 35)
SpeedText.BackgroundTransparency = 1
SpeedText.Font = Enum.Font.Gotham
SpeedText.Text = "Speed Fly: 50"
SpeedText.TextColor3 = Color3.new(1,1,1)
SpeedText.TextSize = 12
SpeedText.TextXAlignment = Enum.TextXAlignment.Left
SpeedText.Parent = FlyContent

local MinusBtn = Instance.new("TextButton")
MinusBtn.Size = UDim2.new(0, 25, 0, 20)
MinusBtn.Position = UDim2.new(0.4, 0, 0, 35)
MinusBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
MinusBtn.BorderSizePixel = 0
MinusBtn.Text = "-"
MinusBtn.Font = Enum.Font.GothamBold
MinusBtn.TextColor3 = Color3.new(1,1,1)
MinusBtn.Parent = FlyContent

local PlusBtn = Instance.new("TextButton")
PlusBtn.Size = UDim2.new(0, 25, 0, 20)
PlusBtn.Position = UDim2.new(0.65, 0, 0, 35)
PlusBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
PlusBtn.BorderSizePixel = 0
PlusBtn.Text = "+"
PlusBtn.Font = Enum.Font.GothamBold
PlusBtn.TextColor3 = Color3.new(1,1,1)
PlusBtn.Parent = FlyContent

-- ==============================================
-- FUNCIONES (CORREGIDAS)
-- ==============================================

-- MOSTRAR / OCULTAR INFO
local InfoOpen = false
InfoSection.MouseButton1Click:Connect(function()
    InfoOpen = not InfoOpen
    if InfoOpen then
        InfoText.Text = "Info ↑"
        InfoContent.Visible = true
    else
        InfoText.Text = "Info ↓"
        InfoContent.Visible = false
    end
end)

-- MOSTRAR / OCULTAR FLY
local FlyOpen = false
FlySection.MouseButton1Click:Connect(function()
    FlyOpen = not FlyOpen
    if FlyOpen then
        FlyText.Text = "Fly ↑"
        FlyContent.Visible = true
    else
        FlyText.Text = "Fly ↓"
        FlyContent.Visible = false
    end
end)

-- MINIMIZAR (CORREGIDO)
local Minimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    Minimized = not Minimized
    if Minimized then
        TweenService:Create(Main, TweenInfo.new(0.3), {Size = UDim2.new(0, 220, 0, 30)}):Play()
    else
        TweenService:Create(Main, TweenInfo.new(0.3), {Size = UDim2.new(0, 220, 0, 280)}):Play()
    end
end)

-- TOGGLE FLY Y NOCLIP
ToggleFly.MouseButton1Click:Connect(function()
    Flying = not Flying
    if Flying then
        ToggleFly.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        ToggleFly.Text = "ON"
        Hum.PlatformStand = true
    else
        ToggleFly.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
        ToggleFly.Text = "OFF"
        Hum.PlatformStand = false
    end
end)

-- CONTROL DE VELOCIDAD
PlusBtn.MouseButton1Click:Connect(function()
    Speed = Speed + 10
    if Speed > 200 then Speed = 200 end
    SpeedText.Text = "Speed Fly: "..Speed
end)

MinusBtn.MouseButton1Click:Connect(function()
    Speed = Speed - 10
    if Speed < 10 then Speed = 10 end
    SpeedText.Text = "Speed Fly: "..Speed
end)

-- ==============================================
-- LOGICA DE VUELO Y NOCLIP
-- ==============================================

RunService.RenderStepped:Connect(function()
    if Flying and Hum.Health > 0 then
        -- Noclip Integrado
        for _, part in pairs(Char:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
        
        -- Movimiento
        local CamCF = Workspace.CurrentCamera.CFrame
        local moveV = Vector3.new()
        
        -- Teclado
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveV += CamCF.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveV -= CamCF.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveV += CamCF.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveV -= CamCF.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveV += Vector3.new(0,1,0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            moveV -= Vector3.new(0,1,0)
        end
        
        -- Aplicar velocidad
        HRP.Velocity = moveV.Unit * Speed
        
        -- Soporte Joystick Celular
        local success, err = pcall(function()
            local PlayerModule = require(game:GetService("Players").LocalPlayer.PlayerScripts:FindFirstChild("PlayerModule"))
            local Controls = PlayerModule:GetControls()
            local MoveVec = Controls:GetMoveVector()
            if MoveVec.Magnitude > 0 then
                 local camLook = CFrame.new(Vector3.new(), CamCF.LookVector)
                 HRP.Velocity = camLook:VectorToWorldSpace(MoveVec) * Speed + Vector3.new(0, HRP.Velocity.Y, 0)
            end
        end)
        
    else
        -- Restaurar Collision cuando no vuela
        for _, part in pairs(Char:GetChildren()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.CanCollide = true
            end
        end
    end
end)

-- Actualizar personaje si resetea
Player.CharacterAdded:Connect(function(newChar)
    Char = newChar
    Hum = Char:WaitForChild("Humanoid")
    HRP = Char:WaitForChild("HumanoidRootPart")
    Flying = false
    ToggleFly.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
    ToggleFly.Text = "OFF"
end)

print("✅ JoseAngel_Blox Fly V1.2 Cargado Correctamente")
