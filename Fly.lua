-- =============================================
-- JoseAngel_Blox Fly - v1.2
-- Creador: JoseAngel_Blox | Fecha: 05/07/2026
-- =============================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")

-- ==================== ANIMACIÓN DE CARGA ====================
local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(0, 280, 0, 180)
loadingFrame.Position = UDim2.new(0.5, -140, 0.5, -90)
loadingFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
loadingFrame.BorderSizePixel = 0
loadingFrame.Parent = player:WaitForChild("PlayerGui")

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = loadingFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0.35, 0)
title.BackgroundTransparency = 1
title.Text = "Bienvenidos a Scripts JoseAngel_Blox"
title.TextColor3 = Color3.fromRGB(0, 255, 100)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = loadingFrame

local barBG = Instance.new("Frame")
barBG.Size = UDim2.new(0.8, 0, 0.15, 0)
barBG.Position = UDim2.new(0.1, 0, 0.6, 0)
barBG.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
barBG.Parent = loadingFrame

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(0, 12)
barCorner.Parent = barBG

local loadingBar = Instance.new("Frame")
loadingBar.Size = UDim2.new(0, 0, 1, 0)
loadingBar.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
loadingBar.Parent = barBG
Instance.new("UICorner", loadingBar).CornerRadius = UDim.new(0, 12)

-- Efecto de carga
for i = 0, 100 do
    TweenService:Create(loadingBar, TweenInfo.new(0.03, Enum.EasingStyle.Linear), {Size = UDim2.new(i/100, 0, 1, 0)}):Play()
    task.wait(0.03)
end

-- Desvanecer animación
TweenService:Create(loadingFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1, Title.Transparency = 1, loadingBar.BackgroundTransparency = 1}):Play()
task.wait(0.7)
loadingFrame:Destroy()

-- ==================== HUD PRINCIPAL ====================
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 260, 0, 280)
mainFrame.Position = UDim2.new(0.02, 0, 0.5, -140)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = player:WaitForChild("PlayerGui")

local cornerMain = Instance.new("UICorner")
cornerMain.CornerRadius = UDim.new(0, 18)
cornerMain.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "JoseAngel_Blox Fly"
titleLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = mainFrame

-- Info (clicable)
local infoButton = Instance.new("TextButton")
infoButton.Size = UDim2.new(1, -20, 0, 35)
infoButton.Position = UDim2.new(0, 10, 0, 50)
infoButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
infoButton.Text = "Info ↓ ↑ Flecha clicable"
infoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
infoButton.TextScaled = true
infoButton.Font = Enum.Font.Gotham
infoButton.Parent = mainFrame
Instance.new("UICorner", infoButton).CornerRadius = UDim.new(0, 12)

infoButton.MouseButton1Click:Connect(function()
    print("=== JoseAngel_Blox Fly v1.2 ===")
    print("Creador: JoseAngel_Blox")
    print("Fecha de Creación: 05/07/2026")
    print("Velocidad actual: " .. math.floor(flySpeed))
    print("Noclip: " .. (noclipEnabled and "Activado" or "Desactivado"))
end)

-- Fly Toggle + Interruptor deslizable
local flyLabel = Instance.new("TextLabel")
flyLabel.Size = UDim2.new(1, -20, 0, 30)
flyLabel.Position = UDim2.new(0, 10, 0, 95)
flyLabel.BackgroundTransparency = 1
flyLabel.Text = "Fly"
flyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
flyLabel.TextScaled = true
flyLabel.Font = Enum.Font.Gotham
flyLabel.Parent = mainFrame

local toggleFrame = Instance.new("Frame")
toggleFrame.Size = UDim2.new(0, 60, 0, 30)
toggleFrame.Position = UDim2.new(0.7, 0, 0.95, -15)
toggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
toggleFrame.Parent = mainFrame
Instance.new("UICorner", toggleFrame).CornerRadius = UDim.new(1, 0)

local slider = Instance.new("Frame")
slider.Size = UDim2.new(0.5, 0, 1, 0)
slider.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
slider.Parent = toggleFrame
Instance.new("UICorner", slider).CornerRadius = UDim.new(1, 0)

local dragging = false
local function updateToggle()
    if flying then
        slider.Position = UDim2.new(0.5, 0, 0, 0)
        slider.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    else
        slider.Position = UDim2.new(0, 0, 0, 0)
        slider.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end
end

toggleFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        updateToggle()
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mouseX = input.Position.X
        local toggleX = toggleFrame.AbsolutePosition.X
        local toggleWidth = toggleFrame.AbsoluteSize.X
        local percent = math.clamp((mouseX - toggleX) / toggleWidth, 0, 1)
        slider.Position = UDim2.new(percent, 0, 0, 0)
        flying = percent > 0.5
        updateToggle()
    end
end)

-- Velocidad ajustable
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, -20, 0, 30)
speedLabel.Position = UDim2.new(0, 10, 0, 140)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Velocidad: 50"
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.TextScaled = true
speedLabel.Font = Enum.Font.Gotham
speedLabel.Parent = mainFrame

local function updateSpeedLabel()
    speedLabel.Text = "Velocidad: " .. math.floor(flySpeed)
end

local decreaseBtn = Instance.new("TextButton")
decreaseBtn.Size = UDim2.new(0.45, 0, 0, 30)
decreaseBtn.Position = UDim2.new(0.05, 0, 0, 180)
decreaseBtn.Text = "-"
decreaseBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
decreaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
decreaseBtn.TextScaled = true
decreaseBtn.Parent = mainFrame
Instance.new("UICorner", decreaseBtn).CornerRadius = UDim.new(0, 10)

decreaseBtn.MouseButton1Click:Connect(function()
    flySpeed = math.max(10, flySpeed - 5)
    updateSpeedLabel()
end)

local increaseBtn = Instance.new("TextButton")
increaseBtn.Size = UDim2.new(0.45, 0, 0, 30)
increaseBtn.Position = UDim2.new(0.5, 0, 0, 180)
increaseBtn.Text = "+"
increaseBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
increaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
increaseBtn.TextScaled = true
increaseBtn.Parent = mainFrame
Instance.new("UICorner", increaseBtn).CornerRadius = UDim.new(0, 10)

increaseBtn.MouseButton1Click:Connect(function()
    flySpeed = math.min(200, flySpeed + 5)
    updateSpeedLabel()
end)

-- ==================== VARIABLES DE VUELO ====================
local flying = false
local noclipEnabled = false
local bv = nil
local bg = nil

local function startFly()
    if flying then return end
    flying = true

    bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bv.Parent = root

    bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.P = 12500
    bg.Parent = root

    RunService.RenderStepped:Connect(function()
        if not flying then return end

        local cam = workspace.CurrentCamera
        local moveDir = Vector3.new()

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir += cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir -= cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir -= cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir += cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir -= Vector3.new(0, 1, 0) end

        moveDir = moveDir.Unit * flySpeed
        bv.Velocity = moveDir
        bg.CFrame = cam.CFrame
    end)

    -- Noclip inteligente (solo cuando velocidad > 80)
    if flySpeed >= 80 then
        noclipEnabled = true
        spawn(function()
            while flying and noclipEnabled do
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
                task.wait(0.1)
            end
        end)
    end
end

local function stopFly()
    flying = false
    if bv then bv:Destroy() end
    if bg then bg:Destroy() end
    noclipEnabled = false

    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = true
        end
    end
end

-- Toggle Fly
infoButton.MouseButton1Click:Connect(function() -- ya está conectado arriba
    if flying then
        stopFly()
    else
        startFly()
    end
end)

-- Tecla F para activar/desactivar (opcional, para cuando el HUD no esté visible)
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F then
        if flying then stopFly() else startFly() end
    end
end)

-- ==================== AUTO START ====================
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    root = newChar:WaitForChild("HumanoidRootPart")
    humanoid = newChar:WaitForChild("Humanoid")
end)

print("✅ JoseAngel_Blox Fly v1.2 cargado")
print("   • Usa el HUD para volar y ajustar velocidad")
print("   • F para volar/volver a personaje")
