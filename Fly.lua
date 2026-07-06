--[[
    Script: JoseAngel_Blox Fly (Universal)
    Version: 1.2
    Creator: JoseAngel_Blox
    Description: Script de vuelo universal (PC y Mobile) con Noclip y Animación de Carga.
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Variables de Vuelo
local flying = false
local speed = 50
local bv, bg
local steppedConn

-- Función para bordes redondeados
local function round(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = parent
    return corner
end

-- CONTENEDOR PRINCIPAL
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox_Fly_V2"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = game:GetService("CoreGui")

-- 1. PANTALLA DE CARGA
local LoadingFrame = Instance.new("Frame")
LoadingFrame.Size = UDim2.new(1, 0, 1, 0)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
LoadingFrame.ZIndex = 100
LoadingFrame.Parent = ScreenGui

local LoadingText = Instance.new("TextLabel")
LoadingText.Size = UDim2.new(0.8, 0, 0, 50)
LoadingText.Position = UDim2.new(0.5, 0, 0.45, 0)
LoadingText.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingText.BackgroundTransparency = 1
LoadingText.Text = "Bienvenido a scripts JoseAngel_Blox"
LoadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadingText.TextSize = 24
LoadingText.Font = Enum.Font.GothamBold
LoadingText.TextScaled = true
LoadingText.Parent = LoadingFrame

local BarBack = Instance.new("Frame")
BarBack.Size = UDim2.new(0, 250, 0, 8)
BarBack.Position = UDim2.new(0.5, 0, 0.55, 0)
BarBack.AnchorPoint = Vector2.new(0.5, 0.5)
BarBack.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
BarBack.Parent = LoadingFrame
round(BarBack, 4)

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
BarFill.Parent = BarBack
round(BarFill, 4)

local PercentText = Instance.new("TextLabel")
PercentText.Size = UDim2.new(0, 100, 0, 20)
PercentText.Position = UDim2.new(0.5, 0, 0.6, 0)
PercentText.AnchorPoint = Vector2.new(0.5, 0.5)
PercentText.BackgroundTransparency = 1
PercentText.Text = "0%"
PercentText.TextColor3 = Color3.fromRGB(180, 180, 180)
PercentText.TextSize = 16
PercentText.Font = Enum.Font.Gotham
PercentText.Parent = LoadingFrame

-- 2. GUI PRINCIPAL
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 380, 0, 220)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui
round(MainFrame, 15)

local Stroke = Instance.new("UIStroke")
Stroke.Thickness = 2
Stroke.Color = Color3.fromRGB(45, 45, 55)
Stroke.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -50, 0, 45)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Text = "JoseAngel_Blox Fly v1.2"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = MainFrame

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 35, 0, 35)
MinBtn.Position = UDim2.new(1, -40, 0, 5)
MinBtn.Text = "-"
MinBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.Parent = MainFrame
round(MinBtn, 8)

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 110, 1, -60)
Sidebar.Position = UDim2.new(0, 10, 0, 50)
Sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Sidebar.Parent = MainFrame
round(Sidebar, 10)

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -140, 1, -60)
Content.Position = UDim2.new(0, 130, 0, 50)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

local TabMain = Instance.new("Frame")
TabMain.Size = UDim2.new(1, 0, 1, 0)
TabMain.BackgroundTransparency = 1
TabMain.Parent = Content

local TabInfo = Instance.new("Frame")
TabInfo.Size = UDim2.new(1, 0, 1, 0)
TabInfo.BackgroundTransparency = 1
TabInfo.Visible = false
TabInfo.Parent = Content

local btnMain = Instance.new("TextButton")
btnMain.Size = UDim2.new(1, -10, 0, 35)
btnMain.Position = UDim2.new(0, 5, 0, 10)
btnMain.Text = "Main"
btnMain.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
btnMain.TextColor3 = Color3.fromRGB(255, 255, 255)
btnMain.Font = Enum.Font.GothamBold
btnMain.Parent = Sidebar
round(btnMain, 6)

local btnInfo = Instance.new("TextButton")
btnInfo.Size = UDim2.new(1, -10, 0, 35)
btnInfo.Position = UDim2.new(0, 5, 0, 50)
btnInfo.Text = "Info ↓"
btnInfo.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
btnInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
btnInfo.Font = Enum.Font.GothamBold
btnInfo.Parent = Sidebar
round(btnInfo, 6)

local flyToggle = Instance.new("TextButton")
flyToggle.Size = UDim2.new(1, 0, 0, 45)
flyToggle.Text = "ACTIVAR FLY"
flyToggle.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
flyToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
flyToggle.Font = Enum.Font.GothamBold
flyToggle.Parent = TabMain
round(flyToggle, 10)

local speedText = Instance.new("TextLabel")
speedText.Size = UDim2.new(1, 0, 0, 30)
speedText.Position = UDim2.new(0, 0, 0, 55)
speedText.Text = "Velocidad: " .. speed
speedText.TextColor3 = Color3.fromRGB(255, 255, 255)
speedText.BackgroundTransparency = 1
speedText.Font = Enum.Font.Gotham
speedText.Parent = TabMain

local sUp = Instance.new("TextButton")
sUp.Size = UDim2.new(0.45, 0, 0, 35)
sUp.Position = UDim2.new(0, 0, 0, 90)
sUp.Text = "+"
sUp.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
sUp.TextColor3 = Color3.fromRGB(255, 255, 255)
sUp.Parent = TabMain
round(sUp, 8)

local sDown = Instance.new("TextButton")
sDown.Size = UDim2.new(0.45, 0, 0, 35)
sDown.Position = UDim2.new(0.55, 0, 0, 90)
sDown.Text = "-"
sDown.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
sDown.TextColor3 = Color3.fromRGB(255, 255, 255)
sDown.Parent = TabMain
round(sDown, 8)

local infoLbl = Instance.new("TextLabel")
infoLbl.Size = UDim2.new(1, 0, 1, 0)
infoLbl.Text = "Creador: JoseAngel_Blox\nLanzamiento: 05/06/2026\nVersión: 1.2\nSistema: Universal"
infoLbl.TextColor3 = Color3.fromRGB(200, 200, 200)
infoLbl.BackgroundTransparency = 1
infoLbl.Font = Enum.Font.Gotham
infoLbl.TextSize = 14
infoLbl.Parent = TabInfo

-- DRAG SYSTEM (Soporta Touch)
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- VUELO UNIVERSAL (Joystick + Teclado)
local function startFly()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")
    
    bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e8, 1e8, 1e8)
    bv.Velocity = Vector3.new(0,0,0)
    bv.Parent = root
    
    bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(1e8, 1e8, 1e8)
    bg.CFrame = root.CFrame
    bg.Parent = root
    
    steppedConn = RunService.RenderStepped:Connect(function()
        root.CanCollide = false
        hum.PlatformStand = true
        
        -- Detecta dirección del Joystick o Teclas W/A/S/D
        local moveDir = hum.MoveDirection
        local camera = workspace.CurrentCamera
        
        local vertical = 0
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vertical = 1 end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then vertical = -1 end
        
        if moveDir.Magnitude > 0 or vertical ~= 0 then
            bv.Velocity = (moveDir * speed) + (Vector3.new(0, vertical, 0) * speed)
        else
            bv.Velocity = Vector3.new(0, 0.1, 0) -- Flotar quieto
        end
        bg.CFrame = camera.CFrame
    end)
end

local function stopFly()
    if steppedConn then steppedConn:Disconnect() end
    if bv then bv:Destroy() end
    if bg then bg:Destroy() end
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.PlatformStand = false
        char.HumanoidRootPart.CanCollide = true
    end
end

-- EVENTOS BOTONES
flyToggle.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then
        flyToggle.Text = "DESACTIVAR FLY"
        flyToggle.BackgroundColor3 = Color3.fromRGB(60, 200, 60)
        startFly()
    else
        flyToggle.Text = "ACTIVAR FLY"
        flyToggle.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
        stopFly()
    end
end)

sUp.MouseButton1Click:Connect(function()
    speed = speed + 10
    speedText.Text = "Velocidad: " .. speed
end)

sDown.MouseButton1Click:Connect(function()
    speed = math.max(10, speed - 10)
    speedText.Text = "Velocidad: " .. speed
end)

btnMain.MouseButton1Click:Connect(function()
    TabMain.Visible = true
    TabInfo.Visible = false
    btnInfo.Text = "Info ↓"
    btnMain.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    btnInfo.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
end)

btnInfo.MouseButton1Click:Connect(function()
    TabMain.Visible = false
    TabInfo.Visible = true
    btnInfo.Text = "Info ↑"
    btnMain.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    btnInfo.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
end)

MinBtn.MouseButton1Click:Connect(function()
    MainFrame:TweenSize(UDim2.new(0,0,0,0), "In", "Quad", 0.3, true, function()
        MainFrame.Visible = false
    end)
end)

-- CARGA INICIAL
task.spawn(function()
    for i = 1, 100 do
        task.wait(0.02)
        BarFill.Size = UDim2.new(i/100, 0, 1, 0)
        PercentText.Text = i .. "%"
    end
    
    local fadeOut = TweenService:Create(LoadingFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1})
    TweenService:Create(LoadingText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(BarBack, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(BarFill, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(PercentText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    fadeOut:Play()
    
    fadeOut.Completed:Connect(function()
        LoadingFrame:Destroy()
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        MainFrame:TweenSize(UDim2.new(0, 380, 0, 220), "Out", "Back", 0.5)
    end)
end)
