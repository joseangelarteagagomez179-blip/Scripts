-- =============================================
-- JOSEANGEL_BLOX FLY
-- Versión: 1.2
-- Fecha: 05/06/2026
-- Solo para volar con noclip + velocidad ajustable
-- Hecho manualmente para que se vea natural
-- =============================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")

-- ============== CARGA ANIMADA ==============
local loadingGui = Instance.new("ScreenGui")
loadingGui.ResetOnSpawn = false
loadingGui.Parent = game:GetService("CoreGui")

local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(0, 300, 0, 120)
loadingFrame.Position = UDim2.new(0.5, -150, 0.5, -60)
loadingFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
loadingFrame.BorderSizePixel = 0
loadingFrame.Parent = loadingGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = loadingFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(80, 80, 110)
stroke.Thickness = 2
stroke.Parent = loadingFrame

local text = Instance.new("TextLabel")
text.Size = UDim2.new(1, 0, 0, 30)
text.BackgroundTransparency = 1
text.Text = "Bienvenido a scripts JoseAngel_Blox"
text.TextColor3 = Color3.fromRGB(255, 255, 255)
text.TextScaled = true
text.Font = Enum.Font.GothamBold
text.Parent = loadingFrame

local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(1, -20, 0, 12)
barBg.Position = UDim2.new(0, 10, 0, 50)
barBg.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
barBg.Parent = loadingFrame
local barCornerBg = Instance.new("UICorner")
barCornerBg.CornerRadius = UDim.new(1, 0)
barCornerBg.Parent = barBg

local bar = Instance.new("Frame")
bar.Size = UDim2.new(0, 0, 1, 0)
bar.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
bar.Parent = barBg
local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(1, 0)
barCorner.Parent = bar

for i = 1, 100 do
    task.wait(0.03)
    bar.Size = UDim2.new(0, i * 3, 1, 0)
end

TweenService:Create(bar, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(1, 0, 1, 0)}):Play()

task.wait(0.8)
TweenService:Create(loadingFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 1, Position = UDim2.new(0.5, -150, 1.5, 0)}):Play()
task.wait(0.6)
loadingGui:Destroy()

-- ============== VENTANA PRINCIPAL ==============
local screenGui = Instance.new("ScreenGui")
screenGui.ResetOnSpawn = false
screenGui.Parent = game:GetService("CoreGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 420, 0, 520)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -260)
mainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local cornerMain = Instance.new("UICorner")
cornerMain.CornerRadius = UDim.new(0, 18)
cornerMain.Parent = mainFrame

local strokeMain = Instance.new("UIStroke")
strokeMain.Color = Color3.fromRGB(90, 90, 130)
strokeMain.Thickness = 2
strokeMain.Parent = mainFrame

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 48)
title.BackgroundTransparency = 1
title.Text = "JOSEANGEL_BLOX FLY"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- ============== INFO & MAIN (esquinas izquierda) ==============
local infoMainHolder = Instance.new("Frame")
infoMainHolder.Size = UDim2.new(0, 210, 1, -70)
infoMainHolder.Position = UDim2.new(0, 10, 0, 65)
infoMainHolder.BackgroundTransparency = 1
infoMainHolder.Parent = mainFrame

local function createSection(titleText, isInfo)
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, 0, 0, 220)
    section.BackgroundColor3 = Color3.fromRGB(28, 28, 42)
    section.Parent = infoMainHolder
    
    local cornerSec = Instance.new("UICorner")
    cornerSec.CornerRadius = UDim.new(0, 14)
    cornerSec.Parent = section
    
    local strokeSec = Instance.new("UIStroke")
    strokeSec.Color = Color3.fromRGB(70, 70, 100)
    strokeSec.Thickness = 1.5
    strokeSec.Parent = section
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -20, 0, 35)
    titleLabel.Position = UDim2.new(0, 10, 0, 8)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = titleText
    titleLabel.TextColor3 = Color3.fromRGB(180, 180, 220)
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.GothamSemibold
    titleLabel.Parent = section
    
    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, -20, 1, -55)
    content.Position = UDim2.new(0, 10, 0, 50)
    content.BackgroundTransparency = 1
    content.Parent = section
    
    return content
end

local infoContent = createSection("INFO", true)
local mainContent = createSection("MAIN", false)

-- ============== ANIMACIÓN FLECHA (Info) ==============
local arrowContainer = Instance.new("Frame")
arrowContainer.Size = UDim2.new(0, 50, 0, 50)
arrowContainer.Position = UDim2.new(0, 5, 0, 5)
arrowContainer.BackgroundTransparency = 1
arrowContainer.Parent = infoContent

local arrow = Instance.new("TextLabel")
arrow.Size = UDim2.new(1, 0, 1, 0)
arrow.BackgroundTransparency = 1
arrow.Text = "↓"
arrow.TextColor3 = Color3.fromRGB(200, 200, 220)
arrow.TextScaled = true
arrow.Font = Enum.Font.GothamBold
arrow.Parent = arrowContainer

local isInfoExpanded = false
arrow.MouseButton1Click:Connect(function()
    isInfoExpanded = not isInfoExpanded
    TweenService:Create(arrowContainer, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Rotation = isInfoExpanded and 0 or 180}):Play()
    TweenService:Create(infoContent, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Size = isInfoExpanded and UDim2.new(1, -20, 0, 420) or UDim2.new(1, -20, 0, 0)}):Play()
end)

-- ============== INFO CONTENT ==============
local creator = Instance.new("TextLabel")
creator.Size = UDim2.new(1, -20, 0, 35)
creator.Position = UDim2.new(0, 10, 0, 10)
creator.BackgroundTransparency = 1
creator.Text = "Nombre del Creador: JoseAngel_Blox"
creator.TextColor3 = Color3.fromRGB(255, 255, 255)
creator.TextScaled = true
creator.Font = Enum.Font.Gotham
creator.Parent = infoContent

local date = Instance.new("TextLabel")
date.Size = UDim2.new(1, -20, 0, 35)
date.Position = UDim2.new(0, 10, 0, 55)
date.BackgroundTransparency = 1
date.Text = "Fecha de lanzamiento: 05/06/2026"
date.TextColor3 = Color3.fromRGB(255, 255, 255)
date.TextScaled = true
date.Font = Enum.Font.Gotham
date.Parent = infoContent

local version = Instance.new("TextLabel")
version.Size = UDim2.new(1, -20, 0, 35)
version.Position = UDim2.new(0, 10, 0, 100)
version.BackgroundTransparency = 1
version.Text = "Versión: 1.2"
version.TextColor3 = Color3.fromRGB(255, 255, 255)
version.TextScaled = true
version.Font = Enum.Font.Gotham
version.Parent = infoContent

-- ============== FLY CONTENT (esquina derecha) ==============
local flyContent = Instance.new("Frame")
flyContent.Size = UDim2.new(0, 180, 1, -70)
flyContent.Position = UDim2.new(1, -190, 0, 65)
flyContent.BackgroundColor3 = Color3.fromRGB(28, 28, 42)
flyContent.Parent = mainFrame

local cornerFly = Instance.new("UICorner")
cornerFly.CornerRadius = UDim.new(0, 14)
cornerFly.Parent = flyContent

local strokeFly = Instance.new("UIStroke")
strokeFly.Color = Color3.fromRGB(70, 70, 100)
strokeFly.Thickness = 1.5
strokeFly.Parent = flyContent

local flyTitle = Instance.new("TextLabel")
flyTitle.Size = UDim2.new(1, -20, 0, 35)
flyTitle.Position = UDim2.new(0, 10, 0, 8)
flyTitle.BackgroundTransparency = 1
flyTitle.Text = "FLY"
flyTitle.TextColor3 = Color3.fromRGB(180, 180, 220)
flyTitle.TextScaled = true
flyTitle.Font = Enum.Font.GothamSemibold
flyTitle.Parent = flyContent

-- Botón Fly (interruptor)
local flyToggle = Instance.new("TextButton")
flyToggle.Size = UDim2.new(0, 80, 0, 35)
flyToggle.Position = UDim2.new(0.5, -40, 0, 55)
flyToggle.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
flyToggle.Text = "OFF"
flyToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
flyToggle.TextScaled = true
flyToggle.Font = Enum.Font.GothamBold
flyToggle.Parent = flyContent

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(1, 0)
toggleCorner.Parent = flyToggle

local toggleState = false
flyToggle.MouseButton1Click:Connect(function()
    toggleState = not toggleState
    if toggleState then
        flyToggle.BackgroundColor3 = Color3.fromRGB(40, 220, 40)
        flyToggle.Text = "ON"
    else
        flyToggle.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
        flyToggle.Text = "OFF"
    end
end)

-- Velocidad
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, -20, 0, 30)
speedLabel.Position = UDim2.new(0, 10, 0, 105)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Velocidad de vuelo"
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.TextScaled = true
speedLabel.Font = Enum.Font.Gotham
speedLabel.Parent = flyContent

local speedFrame = Instance.new("Frame")
speedFrame.Size = UDim2.new(1, -20, 0, 35)
speedFrame.Position = UDim2.new(0, 10, 0, 140)
speedFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
speedFrame.Parent = flyContent
local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0, 10)
speedCorner.Parent = speedFrame

local minus = Instance.new("TextButton")
minus.Size = UDim2.new(0, 35, 1, 0)
minus.Position = UDim2.new(0, 0, 0, 0)
minus.BackgroundTransparency = 1
minus.Text = "-"
minus.TextColor3 = Color3.fromRGB(255, 255, 255)
minus.TextScaled = true
minus.Parent = speedFrame

local speedText = Instance.new("TextLabel")
speedText.Size = UDim2.new(0.5, 0, 1, 0)
speedText.Position = UDim2.new(0.35, 0, 0, 0)
speedText.BackgroundTransparency = 1
speedText.Text = "12"
speedText.TextColor3 = Color3.fromRGB(255, 255, 255)
speedText.TextScaled = true
speedText.Font = Enum.Font.GothamBold
speedText.Parent = speedFrame

local plus = Instance.new("TextButton")
plus.Size = UDim2.new(0, 35, 1, 0)
plus.Position = UDim2.new(1, -35, 0, 0)
plus.BackgroundTransparency = 1
plus.Text = "+"
plus.TextColor3 = Color3.fromRGB(255, 255, 255)
plus.TextScaled = true
plus.Parent = speedFrame

local currentSpeed = 12
local maxSpeed = 25
local minSpeed = 8

local function updateSpeed()
    speedText.Text = tostring(currentSpeed)
end

minus.MouseButton1Click:Connect(function()
    if currentSpeed > minSpeed then
        currentSpeed = currentSpeed - 1
        updateSpeed()
    end
end)

plus.MouseButton1Click:Connect(function()
    if currentSpeed < maxSpeed then
        currentSpeed = currentSpeed + 1
        updateSpeed()
    end
end)

-- ============== FLY LOGIC ==============
local isFlying = false
local bodyVelocity
local noclipConnection

local function startFlying()
    if not root then return end
    if bodyVelocity then bodyVelocity:Destroy() end
    
    isFlying = true
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    bodyVelocity.Velocity = Vector3.new(0, currentSpeed * 2, 0) -- subir por defecto
    bodyVelocity.Parent = root
    
    -- Noclip
    noclipConnection = RunService.Stepped:Connect(function()
        if character and humanoid then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end
    end)
end

local function stopFlying()
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
    if noclipConnection then
        noclipConnection:Disconnect()
        noclipConnection = nil
    end
    isFlying = false
end

flyToggle.MouseButton1Click:Connect(function()
    if toggleState then
        startFlying()
    else
        stopFlying()
    end
end)

-- Actualizar velocidad en tiempo real
RunService.Heartbeat:Connect(function()
    if bodyVelocity then
        bodyVelocity.Velocity = Vector3.new(0, currentSpeed * 2, 0)
    end
end)

-- ============== ARRastrar ventana ==============
local dragging
local dragStart
local startPos

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- ============== Cerrar ==============
local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -35, 0, 8)
close.BackgroundTransparency = 1
close.Text = "✕"
close.TextColor3 = Color3.fromRGB(220, 50, 50)
close.TextScaled = true
close.Font = Enum.Font.GothamBold
close.Parent = mainFrame

close.MouseButton1Click:Connect(function()
    screenGui:Destroy()
    loadingGui:Destroy()
end)

-- Mensaje inicial
print("✅ JOSEANGEL_BLOX FLY cargado correctamente")

-- =============================================
-- Listo. Copia y pega en cualquier executor.
-- Volas, tienes noclip automático y todo se ve hecho a mano.
-- ¿Quieres que le agregue algo más? (jump power, speed, etc.) solo dime.
