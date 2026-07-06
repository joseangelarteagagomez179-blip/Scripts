--[[
    Script: JoseAngel_Blox Fly (Universal Fix)
    Version: 1.3
    Creator: JoseAngel_Blox
    Description: Corregido: Animación de carga visible, Fly con dirección de cámara, 
                 Velocidad funcional, Botón de minimizar y Orden de pestañas.
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
ScreenGui.Name = "JoseAngel_Blox_Fly_V3"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true 
ScreenGui.Parent = game:GetService("CoreGui")

-- 1. PANTALLA DE CARGA (Corregida: Ahora es visible sobre todo)
local LoadingFrame = Instance.new("Frame")
LoadingFrame.Size = UDim2.new(1, 0, 1, 0)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
LoadingFrame.ZIndex = 500
LoadingFrame.BorderSizePixel = 0
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
LoadingText.ZIndex = 501
LoadingText.Parent = LoadingFrame

local BarBack = Instance.new("Frame")
BarBack.Size = UDim2.new(0, 250, 0, 10)
BarBack.Position = UDim2.new(0.5, 0, 0.55, 0)
BarBack.AnchorPoint = Vector2.new(0.5, 0.5)
BarBack.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
BarBack.ZIndex = 501
BarBack.Parent = LoadingFrame
round(BarBack, 5)

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
BarFill.ZIndex = 502
BarFill.Parent = BarBack
round(BarFill, 5)

local PercentText = Instance.new("TextLabel")
PercentText.Size = UDim2.new(0, 100, 0, 20)
PercentText.Position = UDim2.new(0.5, 0, 0.62, 0)
PercentText.AnchorPoint = Vector2.new(0.5, 0.5)
PercentText.BackgroundTransparency = 1
PercentText.Text = "0%"
PercentText.TextColor3 = Color3.fromRGB(200, 200, 200)
PercentText.TextSize = 16
PercentText.Font = Enum.Font.Gotham
PercentText.ZIndex = 501
PercentText.Parent = LoadingFrame

-- 2. BOTON DE REAPERTURA (Corregido: Para no tener que re-ejecutar)
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, 50, 0, 50)
OpenBtn.Position = UDim2.new(0, 10, 0.5, -25)
OpenBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
OpenBtn.Text = "FLY"
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.Visible = false
OpenBtn.Parent = ScreenGui
round(OpenBtn, 25)
local OpenStroke = Instance.new("UIStroke")
OpenStroke.Thickness = 2
OpenStroke.Color = Color3.fromRGB(0, 150, 255)
OpenStroke.Parent = OpenBtn

-- 3. GUI PRINCIPAL
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 250)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
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
Title.Text = "JoseAngel_Blox Fly v1.3"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
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
MinBtn.TextSize = 20
MinBtn.Parent = MainFrame
round(MinBtn, 8)

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 120, 1, -60)
Sidebar.Position = UDim2.new(0, 10, 0, 50)
Sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Sidebar.Parent = MainFrame
round(Sidebar, 10)

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -150, 1, -60)
Content.Position = UDim2.new(0, 140, 0, 50)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

-- Tabs
local TabInfo = Instance.new("Frame")
TabInfo.Size = UDim2.new(1, 0, 1, 0)
TabInfo.BackgroundTransparency = 1
TabInfo.Visible = true 
TabInfo.Parent = Content

local TabMain = Instance.new("Frame")
TabMain.Size = UDim2.new(1, 0, 1, 0)
TabMain.BackgroundTransparency = 1
TabMain.Visible = false
TabMain.Parent = Content

-- Sidebar Buttons (Orden Corregido: Info primero)
local btnInfo = Instance.new("TextButton")
btnInfo.Size = UDim2.new(1, -10, 0, 35)
btnInfo.Position = UDim2.new(0, 5, 0, 10)
btnInfo.Text = "Info ↓"
btnInfo.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
btnInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
btnInfo.Font = Enum.Font.GothamBold
btnInfo.Parent = Sidebar
round(btnInfo, 6)

local btnMain = Instance.new("TextButton")
btnMain.Size = UDim2.new(1, -10, 0, 35)
btnMain.Position = UDim2.new(0, 5, 0, 50)
btnMain.Text = "Main"
btnMain.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
btnMain.TextColor3 = Color3.fromRGB(200, 200, 200)
btnMain.Font = Enum.Font.GothamBold
btnMain.Parent = Sidebar
round(btnMain, 6)

-- INFO CONTENT
local infoLbl = Instance.new("TextLabel")
infoLbl.Size = UDim2.new(1, 0, 1, 0)
infoLbl.Text = "Nombre del Creador: JoseAngel_Blox\nFecha de lanzamiento: 05/06/2026\nVersión: 1.2"
infoLbl.TextColor3 = Color3.fromRGB(220, 220, 220)
infoLbl.BackgroundTransparency = 1
infoLbl.Font = Enum.Font.Gotham
infoLbl.TextSize = 14
infoLbl.TextYAlignment = Enum.TextYAlignment.Top
infoLbl.Parent = TabInfo

-- MAIN CONTENT (FLY)
local flyToggle = Instance.new("TextButton")
flyToggle.Size = UDim2.new(1, 0, 0, 45)
flyToggle.Text = "FLY: OFF"
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

-- SISTEMA DRAG
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

-- LOGICA DE VUELO (Corregida: Sube con cámara y velocidad real)
local function startFly()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")
    local camera = workspace.CurrentCamera
    
    bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e8, 1e8, 1e8)
    bv.Velocity = Vector3.new(0,0,0)
    bv.Parent = root
    
    bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(1e8, 1e8, 1e8)
    bg.P = 15000 
    bg.CFrame = root.CFrame
    bg.Parent = root
    
    steppedConn = RunService.RenderStepped:Connect(function()
        root.CanCollide = false
        hum.PlatformStand = true
        
        local moveDir = hum.MoveDirection
        
        if moveDir.Magnitude > 0 then
            -- Vuelo en dirección de la cámara (Si miras arriba, subes)
            bv.Velocity = camera.CFrame:VectorToWorldSpace(Vector3.new(moveDir.X, moveDir.Z * -camera.CFrame.LookVector.Y, moveDir.Z).Unit * speed)
            -- Multiplicamos por la velocidad real ajustada
            bv.Velocity = camera.CFrame.Rotation * Vector3.new(moveDir.X, 0, moveDir.Z).Unit * speed
        else
            bv.Velocity = Vector3.new(0, 0.1, 0)
        end
        
        -- Soporte Espacio/Ctrl para PC
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            bv.Velocity = bv.Velocity + Vector3.new(0, speed, 0)
        elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            bv.Velocity = bv.Velocity + Vector3.new(0, -speed, 0)
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
        flyToggle.Text = "FLY: ON"
        flyToggle.BackgroundColor3 = Color3.fromRGB(60, 200, 60)
        startFly()
    else
        flyToggle.Text = "FLY: OFF"
        flyToggle.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
        stopFly()
    end
end)

sUp.MouseButton1Click:Connect(function()
    speed = speed + 25 -- Incremento más notable
    speedText.Text = "Velocidad: " .. speed
end)

sDown.MouseButton1Click:Connect(function()
    speed = math.max(10, speed - 25)
    speedText.Text = "Velocidad: " .. speed
end)

btnInfo.MouseButton1Click:Connect(function()
    TabInfo.Visible = true
    TabMain.Visible = false
    btnInfo.Text = "Info ↓"
    btnInfo.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    btnMain.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
end)

btnMain.MouseButton1Click:Connect(function()
    TabInfo.Visible = false
    TabMain.Visible = true
    btnInfo.Text = "Info ↑"
    btnMain.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    btnInfo.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
end)

-- MINIMIZAR (Corregido: Crea botón flotante)
MinBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    OpenBtn.Visible = false
    MainFrame.Visible = true
end)

-- EJECUTAR CARGA (Corregida: Animación visible)
task.spawn(function()
    for i = 1, 100 do
        task.wait(0.02)
        BarFill.Size = UDim2.new(i/100, 0, 1, 0)
        PercentText.Text = i .. "%"
    end
    
    local t = TweenService:Create(LoadingFrame, TweenInfo.new(0.6), {BackgroundTransparency = 1})
    TweenService:Create(LoadingText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(BarBack, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(BarFill, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(PercentText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    t:Play()
    
    t.Completed:Connect(function()
        LoadingFrame:Destroy()
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        MainFrame:TweenSize(UDim2.new(0, 400, 0, 250), "Out", "Back", 0.5)
    end)
end)
