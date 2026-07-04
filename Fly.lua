-- JoseAngel_Blox Fly Script v1.2
-- Compatible con PC y Móvil

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Variables del Fly
local flying = false
local noclip = true
local speed = 50
local flySpeed = speed / 10
local bodyVelocity = nil
local bodyGyro = nil

-- Crear ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "JoseAngel_BloxGUI"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

-- ANIMACIÓN DE CARGA
local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(1, 0, 1, 0)
loadingFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 30)
loadingFrame.Parent = screenGui

local loadingTitle = Instance.new("TextLabel")
loadingTitle.Size = UDim2.new(1, 0, 0.3, 0)
loadingTitle.Position = UDim2.new(0, 0, 0.2, 0)
loadingTitle.BackgroundTransparency = 1
loadingTitle.Text = "Bienvenidos a Scripts JoseAngel_Blox"
loadingTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingTitle.TextScaled = true
loadingTitle.Font = Enum.Font.GothamBold
loadingTitle.Parent = loadingFrame

local barBackground = Instance.new("Frame")
barBackground.Size = UDim2.new(0.6, 0, 0.05, 0)
barBackground.Position = UDim2.new(0.2, 0, 0.55, 0)
barBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
barBackground.BorderSizePixel = 0
barBackground.Parent = loadingFrame

local loadingBar = Instance.new("Frame")
loadingBar.Size = UDim2.new(0, 0, 1, 0)
loadingBar.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
loadingBar.BorderSizePixel = 0
loadingBar.Parent = barBackground

local loadingPercent = Instance.new("TextLabel")
loadingPercent.Size = UDim2.new(1, 0, 0.1, 0)
loadingPercent.Position = UDim2.new(0, 0, 0.65, 0)
loadingPercent.BackgroundTransparency = 1
loadingPercent.Text = "0%"
loadingPercent.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingPercent.TextScaled = true
loadingPercent.Font = Enum.Font.GothamBold
loadingPercent.Parent = loadingFrame

-- Animación de carga
coroutine.wrap(function()
    for i = 1, 100 do
        loadingBar.Size = UDim2.new(i / 100, 0, 1, 0)
        loadingPercent.Text = i .. "%"
        if i % 10 == 0 then
            loadingBar.BackgroundColor3 = Color3.fromRGB(0, 200, 255 - (i * 2))
        end
        task.wait(0.03)
    end
    wait(0.5)
    loadingFrame:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.5, true)
    wait(0.5)
    loadingFrame.Visible = false
    loadingFrame:Destroy()
end)()

-- VENTANA PRINCIPAL
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 380, 0, 500)
mainFrame.Position = UDim2.new(0.5, -190, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Visible = false
mainFrame.Parent = screenGui

-- Hacer esquinas redondeadas con UICorner
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = mainFrame

-- Sombra
local shadow = Instance.new("Frame")
shadow.Size = UDim2.new(1, 0, 1, 0)
shadow.Position = UDim2.new(0, 5, 0, 5)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.5
shadow.BorderSizePixel = 0
shadow.Parent = mainFrame
local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 15)
shadowCorner.Parent = shadow
shadow.ZIndex = 0

-- Título con botón de cerrar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame
local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 15)
titleCorner.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -60, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "JoseAngel_Blox Fly"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = titleBar

-- Botón minimizar/cerrar
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -40, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextScaled = true
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = titleBar
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeButton

-- INFO (sección 1)
local infoButton = Instance.new("TextButton")
infoButton.Size = UDim2.new(0, 360, 0, 60)
infoButton.Position = UDim2.new(0, 10, 0, 50)
infoButton.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
infoButton.Text = "ℹ️ INFO"
infoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
infoButton.TextScaled = true
infoButton.Font = Enum.Font.GothamBold
infoButton.Parent = mainFrame
local infoCorner = Instance.new("UICorner")
infoCorner.CornerRadius = UDim.new(0, 8)
infoCorner.Parent = infoButton

local infoFrame = Instance.new("Frame")
infoFrame.Size = UDim2.new(1, -20, 0, 0)
infoFrame.Position = UDim2.new(0, 10, 0, 120)
infoFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
infoFrame.BorderSizePixel = 0
infoFrame.Visible = false
infoFrame.ClipsDescendants = true
infoFrame.Parent = mainFrame
local infoCorner2 = Instance.new("UICorner")
infoCorner2.CornerRadius = UDim.new(0, 8)
infoCorner2.Parent = infoFrame

local infoText = Instance.new("TextLabel")
infoText.Size = UDim2.new(1, 0, 1, 0)
infoText.Position = UDim2.new(0, 0, 0, 5)
infoText.BackgroundTransparency = 1
infoText.Text = "Nombre del Creador: JoseAngel_Blox\nFecha de lanzamiento: 04/06/2026\nVersión: 1.2"
infoText.TextColor3 = Color3.fromRGB(200, 200, 255)
infoText.TextScaled = true
infoText.TextXAlignment = Enum.TextXAlignment.Left
infoText.TextYAlignment = Enum.TextYAlignment.Top
infoText.Font = Enum.Font.Gotham
infoText.Parent = infoFrame

-- FLY (sección 2)
local flyButton = Instance.new("TextButton")
flyButton.Size = UDim2.new(0, 360, 0, 60)
flyButton.Position = UDim2.new(0, 10, 0, 180)
flyButton.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
flyButton.Text = "✈️ FLY"
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.TextScaled = true
flyButton.Font = Enum.Font.GothamBold
flyButton.Parent = mainFrame
local flyCorner = Instance.new("UICorner")
flyCorner.CornerRadius = UDim.new(0, 8)
flyCorner.Parent = flyButton

local flyFrame = Instance.new("Frame")
flyFrame.Size = UDim2.new(1, -20, 0, 0)
flyFrame.Position = UDim2.new(0, 10, 0, 250)
flyFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
flyFrame.BorderSizePixel = 0
flyFrame.Visible = false
flyFrame.ClipsDescendants = true
flyFrame.Parent = mainFrame
local flyCorner2 = Instance.new("UICorner")
flyCorner2.CornerRadius = UDim.new(0, 8)
flyCorner2.Parent = flyFrame

-- Toggle Fly
local toggleFly = Instance.new("TextButton")
toggleFly.Size = UDim2.new(0, 160, 0, 45)
toggleFly.Position = UDim2.new(0, 10, 0, 10)
toggleFly.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
toggleFly.Text = "ACTIVAR"
toggleFly.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleFly.TextScaled = true
toggleFly.Font = Enum.Font.GothamBold
toggleFly.Parent = flyFrame
local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 8)
toggleCorner.Parent = toggleFly

-- Speed control
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0, 160, 0, 30)
speedLabel.Position = UDim2.new(0, 190, 0, 10)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Velocidad: 50"
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.TextScaled = true
speedLabel.Font = Enum.Font.GothamBold
speedLabel.Parent = flyFrame

local speedDown = Instance.new("TextButton")
speedDown.Size = UDim2.new(0, 40, 0, 40)
speedDown.Position = UDim2.new(0, 10, 0, 65)
speedDown.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
speedDown.Text = "-"
speedDown.TextColor3 = Color3.fromRGB(255, 255, 255)
speedDown.TextScaled = true
speedDown.Font = Enum.Font.GothamBold
speedDown.Parent = flyFrame
local speedDownCorner = Instance.new("UICorner")
speedDownCorner.CornerRadius = UDim.new(0, 8)
speedDownCorner.Parent = speedDown

local speedUp = Instance.new("TextButton")
speedUp.Size = UDim2.new(0, 40, 0, 40)
speedUp.Position = UDim2.new(0, 310, 0, 65)
speedUp.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
speedUp.Text = "+"
speedUp.TextColor3 = Color3.fromRGB(255, 255, 255)
speedUp.TextScaled = true
speedUp.Font = Enum.Font.GothamBold
speedUp.Parent = flyFrame
local speedUpCorner = Instance.new("UICorner")
speedUpCorner.CornerRadius = UDim.new(0, 8)
speedUpCorner.Parent = speedUp

local speedSlider = Instance.new("TextLabel")
speedSlider.Size = UDim2.new(0, 250, 0, 20)
speedSlider.Position = UDim2.new(0, 55, 0, 75)
speedSlider.BackgroundTransparency = 1
speedSlider.Text = "───────────────"
speedSlider.TextColor3 = Color3.fromRGB(100, 100, 150)
speedSlider.TextScaled = true
speedSlider.Font = Enum.Font.GothamBold
speedSlider.Parent = flyFrame

local speedValue = Instance.new("TextLabel")
speedValue.Size = UDim2.new(0, 50, 0, 20)
speedValue.Position = UDim2.new(0, 155, 0, 72)
speedValue.BackgroundTransparency = 1
speedValue.Text = "50"
speedValue.TextColor3 = Color3.fromRGB(0, 200, 255)
speedValue.TextScaled = true
speedValue.Font = Enum.Font.GothamBold
speedValue.Parent = flyFrame

-- Botón para mostrar/ocultar GUI
local toggleGuiButton = Instance.new("TextButton")
toggleGuiButton.Size = UDim2.new(0, 60, 0, 60)
toggleGuiButton.Position = UDim2.new(0, 10, 0, 10)
toggleGuiButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
toggleGuiButton.Text = "👾"
toggleGuiButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleGuiButton.TextScaled = true
toggleGuiButton.Font = Enum.Font.GothamBold
toggleGuiButton.Parent = screenGui
local toggleCorner2 = Instance.new("UICorner")
toggleCorner2.CornerRadius = UDim.new(1, 0)
toggleCorner2.Parent = toggleGuiButton

-- Hacer que el botón sea arrastrable
local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

local function updateInput(input)
    local delta = input.Position - dragStart
    local position = UDim2.new(
        startPos.X.Scale, 
        startPos.X.Offset + delta.X,
        startPos.Y.Scale, 
        startPos.Y.Offset + delta.Y
    )
    toggleGuiButton.Position = position
end

toggleGuiButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = toggleGuiButton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

toggleGuiButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateInput(input)
    end
end)

-- Funciones del Fly
local function startFly()
    if not character or not character.Parent then return end
    humanoid.PlatformStand = true
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = character:WaitForChild("HumanoidRootPart")
    
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
    bodyGyro.CFrame = character:WaitForChild("HumanoidRootPart").CFrame
    bodyGyro.Parent = character:WaitForChild("HumanoidRootPart")
    
    flying = true
    toggleFly.Text = "DESACTIVAR"
    toggleFly.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
end

local function stopFly()
    if bodyVelocity then bodyVelocity:Destroy() end
    if bodyGyro then bodyGyro:Destroy() end
    humanoid.PlatformStand = false
    flying = false
    toggleFly.Text = "ACTIVAR"
    toggleFly.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
end

-- Noclip
local function enableNoclip()
    noclip = true
    while flying do
        if character and character.Parent then
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
        task.wait()
    end
end

-- Control de vuelo
local function updateFly()
    if not flying or not character or not character.Parent then return end
    local rootPart = character:WaitForChild("HumanoidRootPart")
    if not rootPart then return end
    
    local moveDirection = Vector3.new(0, 0, 0)
    
    -- Controles PC (WASD + Space/Shift)
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
        moveDirection = moveDirection + rootPart.CFrame.LookVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
        moveDirection = moveDirection - rootPart.CFrame.LookVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
        moveDirection = moveDirection - rootPart.CFrame.RightVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
        moveDirection = moveDirection + rootPart.CFrame.RightVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        moveDirection = moveDirection + Vector3.new(0, 1, 0)
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
        moveDirection = moveDirection - Vector3.new(0, 1, 0)
    end
    
    if moveDirection.Magnitude > 0 then
        moveDirection = moveDirection.Unit * flySpeed
    end
    
    bodyVelocity.Velocity = moveDirection
    bodyGyro.CFrame = rootPart.CFrame
    
    -- Controles Móvil (Joystick)
    local mobileMove = Vector3.new(0, 0, 0)
    local touch = UserInputService:GetTouchPositions()
    if #touch > 0 then
        -- Usar el primer toque para controlar (se puede mejorar)
        local screenSize = workspace.CurrentCamera.ViewportSize
        local touchPos = touch[1]
        local centerX = screenSize.X / 2
        local centerY = screenSize.Y / 2
        local deltaX = (touchPos.X - centerX) / centerX
        local deltaY = (touchPos.Y - centerY) / centerY
        
        if math.abs(deltaX) > 0.2 or math.abs(deltaY) > 0.2 then
            mobileMove = Vector3.new(deltaX, 0, -deltaY).Unit * flySpeed
        end
    end
    
    if mobileMove.Magnitude > 0 then
        bodyVelocity.Velocity = mobileMove
    end
end

-- Conexiones
toggleFly.MouseButton1Click:Connect(function()
    if flying then
        stopFly()
    else
        startFly()
        coroutine.wrap(enableNoclip)()
    end
end)

speedUp.MouseButton1Click:Connect(function()
    speed = math.min(speed + 5, 200)
    flySpeed = speed / 10
    speedLabel.Text = "Velocidad: " .. speed
    speedValue.Text = tostring(speed)
    local barPos = (speed - 5) / 195
    speedSlider.Text = string.rep("─", math.floor(barPos * 25)) .. "●" .. string.rep("─", math.floor((1 - barPos) * 25))
end)

speedDown.MouseButton1Click:Connect(function()
    speed = math.max(speed - 5, 5)
    flySpeed = speed / 10
    speedLabel.Text = "Velocidad: " .. speed
    speedValue.Text = tostring(speed)
    local barPos = (speed - 5) / 195
    speedSlider.Text = string.rep("─", math.floor(barPos * 25)) .. "●" .. string.rep("─", math.floor((1 - barPos) * 25))
end)

-- Info button toggle
infoButton.MouseButton1Click:Connect(function()
    infoFrame.Visible = not infoFrame.Visible
    if infoFrame.Visible then
        infoFrame.Size = UDim2.new(1, -20, 0, 100)
        infoFrame:TweenSize(UDim2.new(1, -20, 0, 100), "Out", "Quad", 0.3, true)
    else
        infoFrame:TweenSize(UDim2.new(1, -20, 0, 0), "Out", "Quad", 0.3, true)
        wait(0.3)
        infoFrame.Size = UDim2.new(1, -20, 0, 0)
    end
end)

-- Fly button toggle
flyButton.MouseButton1Click:Connect(function()
    flyFrame.Visible = not flyFrame.Visible
    if flyFrame.Visible then
        flyFrame.Size = UDim2.new(1, -20, 0, 130)
        flyFrame:TweenSize(UDim2.new(1, -20, 0, 130), "Out", "Quad", 0.3, true)
    else
        flyFrame:TweenSize(UDim2.new(1, -20, 0, 0), "Out", "Quad", 0.3, true)
        wait(0.3)
        flyFrame.Size = UDim2.new(1, -20, 0, 0)
    end
end)

-- Toggle GUI visibility
toggleGuiButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    if mainFrame.Visible then
        mainFrame:TweenSize(UDim2.new(0, 380, 0, 500), "Out", "Quad", 0.3, true)
    else
        mainFrame:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.3, true)
        wait(0.3)
        mainFrame.Size = UDim2.new(0, 380, 0, 500)
    end
end)

-- Cerrar botón
closeButton.MouseButton1Click:Connect(function()
    if flying then stopFly() end
    mainFrame:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.3, true)
    wait(0.3)
    mainFrame.Visible = false
    mainFrame.Size = UDim2.new(0, 380, 0, 500)
end)

-- Mostrar GUI después de la carga
wait(2.5)
mainFrame.Visible = true
mainFrame:TweenSize(UDim2.new(0, 380, 0, 500), "Out", "Quad", 0.5, true)

-- Loop de vuelo
RunService.Heartbeat:Connect(function()
    if flying then
        updateFly()
    end
end)

-- Manejar muerte/respawn
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = character:WaitForChild("Humanoid")
    if flying then
        wait(0.5)
        startFly()
        coroutine.wrap(enableNoclip)()
    end
end)
