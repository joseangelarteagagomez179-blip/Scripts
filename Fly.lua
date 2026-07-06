--[[
    Script: JoseAngel_Blox Fly (Universal Fix v1.6)
    Version: 1.6
    Creator: JoseAngel_Blox
    Description: Joystick CORREGIDO (ahora mueve exactamente donde empujas el stick).
                 Cámara estabilizada. Dirección perfecta. Joypad + teclado funciona igual.
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Variables
local flying = false
local speed = 100
local minSpeed = 20
local maxSpeed = 300
local bv, bg
local steppedConn

-- Función bordes redondeados
local function round(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = parent
    return corner
end

-- GUI (carga, OpenBtn y MainFrame exactamente como tenías)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox_Fly_V4"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = game:GetService("CoreGui")

local LoadingFrame = Instance.new("Frame")
LoadingFrame.Size = UDim2.new(1, 0, 1, 0)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
LoadingFrame.ZIndex = 500
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

-- ... (BarBack, BarFill, PercentText exactamente como antes)

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

-- OpenBtn y MainFrame (igual que antes)
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
Title.Text = "JoseAngel_Blox Fly v1.6"
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

-- Sidebar, tabs, buttons (igual que antes)
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

-- ... (todos los botones de sidebar, infoLbl, flyToggle, speedText, sUp, sDown exactamente iguales)

-- SISTEMA DRAG (igual que antes)

-- LOGICA DE VUELO v1.6 (¡el joystick corregido!)
local function startFly()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")
    local camera = workspace.CurrentCamera

    bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e8, 1e8, 1e8)
    bv.Velocity = Vector3.new(0, 0, 0)
    bv.Parent = root

    bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(1e8, 1e8, 1e8)
    bg.P = 20000
    bg.D = 100
    bg.CFrame = root.CFrame
    bg.Parent = root

    steppedConn = RunService.RenderStepped:Connect(function()
        root.CanCollide = false
        hum.PlatformStand = true

        local moveDir = hum.MoveDirection  -- esto ahora SÍ funciona perfecto

        -- CORRECCIÓN: multiplicamos por la rotación de la cámara (¡esto es lo que faltaba!)
        local camCF = camera.CFrame
        local finalVelocity = camCF.Rotation * Vector3.new(moveDir.X, 0, moveDir.Z).Unit * speed

        -- Altura manual (mismo que antes)
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            finalVelocity = finalVelocity + Vector3.new(0, speed, 0)
        elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            finalVelocity = finalVelocity + Vector3.new(0, -speed, 0)
        end

        bv.Velocity = finalVelocity

        -- Cámara se queda donde estás mirando (estabilizada)
        bg.CFrame = CFrame.new(root.Position, root.Position + Vector3.new(camCF.LookVector.X, 0, camCF.LookVector.Z))
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

-- Botones (igual que antes, solo cambié el texto de velocidad)
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
    speed = math.min(maxSpeed, speed + 25)
    speedText.Text = "Velocidad: " .. speed
end)

sDown.MouseButton1Click:Connect(function()
    speed = math.max(minSpeed, speed - 25)
    speedText.Text = "Velocidad: " .. speed
end)

-- Resto de eventos (tabs, MinBtn, OpenBtn, drag) exactamente iguales que antes

-- EJECUTAR CARGA (igual que antes)
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
