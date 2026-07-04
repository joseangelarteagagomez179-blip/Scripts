--========================================================--
--  JoseAngel_Blox Fly - v1.2
--  Creador: JoseAngel_Blox
--  Fecha: 03/06/2026
--========================================================--

-- Servicios
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")

--========================================================--
--  PANTALLA DE CARGA
--========================================================--

local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.ResetOnSpawn = false

local loadingFrame = Instance.new("Frame", screenGui)
loadingFrame.Size = UDim2.new(1,0,1,0)
loadingFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
loadingFrame.BackgroundTransparency = 0.2

local loadingText = Instance.new("TextLabel", loadingFrame)
loadingText.Size = UDim2.new(1,0,0.2,0)
loadingText.Position = UDim2.new(0,0,0.3,0)
loadingText.Text = "Bienvenidos a Scripts JoseAngel_Blox"
loadingText.TextColor3 = Color3.fromRGB(255,255,255)
loadingText.TextScaled = true
loadingText.BackgroundTransparency = 1

local bar = Instance.new("Frame", loadingFrame)
bar.Size = UDim2.new(0.6,0,0.05,0)
bar.Position = UDim2.new(0.2,0,0.55,0)
bar.BackgroundColor3 = Color3.fromRGB(40,40,40)
bar.BorderSizePixel = 0
local barCorner = Instance.new("UICorner", bar)
barCorner.CornerRadius = UDim.new(0,10)

local fill = Instance.new("Frame", bar)
fill.Size = UDim2.new(0,0,1,0)
fill.BackgroundColor3 = Color3.fromRGB(0,120,255)
fill.BorderSizePixel = 0
local fillCorner = Instance.new("UICorner", fill)
fillCorner.CornerRadius = UDim.new(0,10)

-- Animación de carga
for i = 1,100 do
    fill:TweenSize(UDim2.new(i/100,0,1,0), "Out", "Quad", 0.03)
    loadingText.Text = "Cargando... "..i.."%"
    task.wait(0.03)
end

-- Desvanecer
TweenService:Create(loadingFrame, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
task.wait(1)
loadingFrame:Destroy()

--========================================================--
--  INTERFAZ PRINCIPAL
--========================================================--

local mainGui = Instance.new("ScreenGui", player.PlayerGui)
mainGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Size = UDim2.new(0,350,0,300)
mainFrame.Position = UDim2.new(0.5,-175,0.5,-150)
mainFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
local mainCorner = Instance.new("UICorner", mainFrame)
mainCorner.CornerRadius = UDim.new(0,12)

local stroke = Instance.new("UIStroke", mainFrame)
stroke.Color = Color3.fromRGB(0,120,255)
stroke.Thickness = 2

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1,0,0.2,0)
title.Text = "JoseAngel_Blox Fly"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextScaled = true
title.BackgroundTransparency = 1

-- Botones
local infoBtn = Instance.new("TextButton", mainFrame)
infoBtn.Size = UDim2.new(0.45,0,0.15,0)
infoBtn.Position = UDim2.new(0.05,0,0.25,0)
infoBtn.Text = "Info"
infoBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
infoBtn.TextColor3 = Color3.fromRGB(255,255,255)
local infoCorner = Instance.new("UICorner", infoBtn)
infoCorner.CornerRadius = UDim.new(0,10)

local flyBtn = Instance.new("TextButton", mainFrame)
flyBtn.Size = UDim2.new(0.45,0,0.15,0)
flyBtn.Position = UDim2.new(0.5,0,0.25,0)
flyBtn.Text = "Fly"
flyBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
flyBtn.TextColor3 = Color3.fromRGB(255,255,255)
local flyCorner = Instance.new("UICorner", flyBtn)
flyCorner.CornerRadius = UDim.new(0,10)

--========================================================--
--  MENÚ INFO
--========================================================--

local infoFrame = Instance.new("Frame", mainFrame)
infoFrame.Size = UDim2.new(1,0,0.6,0)
infoFrame.Position = UDim2.new(0,0,0.4,0)
infoFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
local infoCorner2 = Instance.new("UICorner", infoFrame)
infoCorner2.CornerRadius = UDim.new(0,10)

local infoText = Instance.new("TextLabel", infoFrame)
infoText.Size = UDim2.new(1,0,1,0)
infoText.TextColor3 = Color3.fromRGB(255,255,255)
infoText.TextScaled = true
infoText.BackgroundTransparency = 1
infoText.Text = "Nombre del Creador: JoseAngel_Blox\nFecha de lanzamiento: 03/06/2026\nVersión: 1.2"

infoFrame.Visible = false

--========================================================--
--  MENÚ FLY
--========================================================--

local flyFrame = Instance.new("Frame", mainFrame)
flyFrame.Size = UDim2.new(1,0,0.6,0)
flyFrame.Position = UDim2.new(0,0,0.4,0)
flyFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
local flyCorner2 = Instance.new("UICorner", flyFrame)
flyCorner2.CornerRadius = UDim.new(0,10)

flyFrame.Visible = false

local switch = Instance.new("TextButton", flyFrame)
switch.Size = UDim2.new(0.4,0,0.2,0)
switch.Position = UDim2.new(0.3,0,0.1,0)
switch.Text = "Fly OFF"
switch.BackgroundColor3 = Color3.fromRGB(80,0,0)
switch.TextColor3 = Color3.fromRGB(255,255,255)
local switchCorner = Instance.new("UICorner", switch)
switchCorner.CornerRadius = UDim.new(0,10)

local speedSlider = 50
local speedLabel = Instance.new("TextLabel", flyFrame)
speedLabel.Size = UDim2.new(1,0,0.2,0)
speedLabel.Position = UDim2.new(0,0,0.4,0)
speedLabel.Text = "Velocidad: "..speedSlider
speedLabel.TextColor3 = Color3.fromRGB(255,255,255)
speedLabel.BackgroundTransparency = 1
speedLabel.TextScaled = true

local speedBtn = Instance.new("TextButton", flyFrame)
speedBtn.Size = UDim2.new(0.4,0,0.2,0)
speedBtn.Position = UDim2.new(0.3,0,0.65,0)
speedBtn.Text = "Aumentar Velocidad"
speedBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
speedBtn.TextColor3 = Color3.fromRGB(255,255,255)
local speedCorner = Instance.new("UICorner", speedBtn)
speedCorner.CornerRadius = UDim.new(0,10)

--========================================================--
--  SISTEMA DE FLY SUAVE
--========================================================--

local flying = false

switch.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then
        switch.Text = "Fly ON"
        switch.BackgroundColor3 = Color3.fromRGB(0,120,255)
        hum.PlatformStand = true
    else
        switch.Text = "Fly OFF"
        switch.BackgroundColor3 = Color3.fromRGB(80,0,0)
        hum.PlatformStand = false
    end
end)

speedBtn.MouseButton1Click:Connect(function()
    speedSlider = speedSlider + 25
    speedLabel.Text = "Velocidad: "..speedSlider
end)

RunService.RenderStepped:Connect(function()
    if flying then
        local cam = workspace.CurrentCamera
        local moveDir = Vector3.new(0,0,0)

        if UIS:IsKeyDown(Enum.KeyCode.W) then
            moveDir = moveDir + cam.CFrame.LookVector
        end
        if UIS:IsKeyDown(Enum.KeyCode.S) then
            moveDir = moveDir - cam.CFrame.LookVector
        end
        if UIS:IsKeyDown(Enum.KeyCode.A) then
            moveDir = moveDir - cam.CFrame.RightVector
        end
        if UIS:IsKeyDown(Enum.KeyCode.D) then
            moveDir = moveDir + cam.CFrame.RightVector
        end

        root.CFrame = root.CFrame + moveDir * (speedSlider/100)
        root.CanCollide = false
    else
        root.CanCollide = true
    end
end)

--========================================================--
--  BOTONES DE MENÚ
--========================================================--

infoBtn.MouseButton1Click:Connect(function()
    infoFrame.Visible = true
    flyFrame.Visible = false
end)

flyBtn.MouseButton1Click:Connect(function()
    infoFrame.Visible = false
    flyFrame.Visible = true
end)
