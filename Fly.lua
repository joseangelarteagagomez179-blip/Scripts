-- =============================================
-- JoseAngel_Blox Fly - Versión 1.2
-- Fecha de lanzamiento: 03/06/2026
-- Creador: JoseAngel_Blox
-- =============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local flySpeed = 100
local flying = false
local noclip = false
local connection = nil

-- ==================== CARGA INICIAL ====================
local loadingScreen = Instance.new("ScreenGui")
loadingScreen.Name = "JoseAngelLoading"
loadingScreen.ResetOnSpawn = false
loadingScreen.Parent = game:GetService("CoreGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.4, 0, 0.2, 0)
frame.Position = UDim2.new(0.3, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Parent = loadingScreen

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 20)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0.3, 0)
title.BackgroundTransparency = 1
title.Text = "Bienvenidos a Scripts JoseAngel_Blox"
title.TextColor3 = Color3.fromRGB(0, 255, 100)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

local progressBar = Instance.new("Frame")
progressBar.Size = UDim2.new(0.9, 0, 0.15, 0)
progressBar.Position = UDim2.new(0.05, 0, 0.65, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
progressBar.Parent = frame

local progressCorner = Instance.new("UICorner")
progressCorner.CornerRadius = UDim.new(0, 10)
progressCorner.Parent = progressBar

local progressFill = Instance.new("Frame")
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
progressFill.Parent = progressBar

local progressCorner2 = Instance.new("UICorner")
progressCorner2.CornerRadius = UDim.new(0, 10)
progressCorner2.Parent = progressFill

local progressText = Instance.new("TextLabel")
progressText.Size = UDim2.new(0.2, 0, 1, 0)
progressText.Position = UDim2.new(0.91, 0, 0, 0)
progressText.BackgroundTransparency = 1
progressText.Text = "0%"
progressText.TextColor3 = Color3.fromRGB(255, 255, 255)
progressText.TextScaled = true
progressText.Font = Enum.Font.GothamBold
progressText.Parent = progressBar

-- Animación de carga
local startPercent = 0
for i = 1, 100 do
    wait(0.03) -- velocidad de carga (ajusta si quieres más lenta)
    startPercent = i
    progressFill.Size = UDim2.new(0, progressBar.AbsoluteSize.X * (i/100), 1, 0)
    progressText.Text = i .. "%"
end

-- Desvanecer animación
TweenService:Create(frame, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
TweenService:Create(title, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
TweenService:Create(progressBar, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
TweenService:Create(progressFill, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
TweenService:Create(progressText, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()

wait(1.2)
loadingScreen:Destroy()

-- ==================== MENÚ PRINCIPAL ====================
local mainGui = Instance.new("ScreenGui")
mainGui.Name = "JoseAngel_Blox Fly"
mainGui.ResetOnSpawn = false
mainGui.Parent = game:GetService("CoreGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0.35, 0, 0.5, 0)
mainFrame.Position = UDim2.new(0.325, 0, 0.25, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = mainGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 25)
mainCorner.Parent = mainFrame

local mainTitle = Instance.new("TextLabel")
mainTitle.Size = UDim2.new(1, 0, 0.15, 0)
mainTitle.BackgroundTransparency = 1
mainTitle.Text = "JoseAngel_Blox Fly"
mainTitle.TextColor3 = Color3.fromRGB(0, 255, 150)
mainTitle.TextScaled = true
mainTitle.Font = Enum.Font.GothamBold
mainTitle.Parent = mainFrame

-- ==================== OPCIONES ====================
local function createOptionButton(text, yPos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.85, 0, 0.12, 0)
    btn.Position = UDim2.new(0.075, 0, yPos, 0)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    btn.Parent = mainFrame
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 12)
    btnCorner.Parent = btn
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local infoBtn = createOptionButton("Info", 0.25, function()
    local infoFrame = Instance.new("Frame")
    infoFrame.Size = UDim2.new(0.8, 0, 0.6, 0)
    infoFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
    infoFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    infoFrame.Parent = mainGui
    local infoCorner = Instance.new("UICorner")
    infoCorner.CornerRadius = UDim.new(0, 20)
    infoCorner.Parent = infoFrame

    local infoTitle = Instance.new("TextLabel")
    infoTitle.Size = UDim2.new(1, 0, 0.2, 0)
    infoTitle.Text = "INFO"
    infoTitle.TextColor3 = Color3.fromRGB(0, 255, 100)
    infoTitle.TextScaled = true
    infoTitle.Font = Enum.Font.GothamBold
    infoTitle.Parent = infoFrame

    local infoText = Instance.new("TextLabel")
    infoText.Size = UDim2.new(0.9, 0, 0.7, 0)
    infoText.Position = UDim2.new(0.05, 0, 0.25, 0)
    infoText.Text = [[
Nombre del Creador: JoseAngel_Blox
Fecha de lanzamiento: 03/06/2026
Versión: 1.2

Cómo usar:
1. Presiona F para volar (sin noclip)
2. Mantén WASD para moverte
3. Mantén SHIFT para bajar
4. Mantén ESPACIO para subir
5. Presiona N para activar Noclip (volar sin atravesar paredes)

¡Disfruta volando, JoseAngel_Blox!
    ]]
    infoText.TextColor3 = Color3.fromRGB(255, 255, 255)
    infoText.TextScaled = false
    infoText.Font = Enum.Font.Gotham
    infoText.TextWrapped = true
    infoText.TextXAlignment = Enum.TextXAlignment.Left
    infoText.Parent = infoFrame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0.2, 0, 0.15, 0)
    closeBtn.Position = UDim2.new(0.4, 0, 0.85, 0)
    closeBtn.Text = "Cerrar"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    closeBtn.Parent = infoFrame
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 10)
    closeCorner.Parent = closeBtn
    closeBtn.MouseButton1Click:Connect(function() infoFrame:Destroy() end)
end)

local flyBtn = createOptionButton("Fly", 0.45, function()
    if flying then
        flying = false
        flyBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        flyBtn.Text = "Fly"
        connection:Disconnect()
        connection = nil
        print("Fly desactivado")
    else
        flying = true
        flyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        flyBtn.Text = "Desactivar Fly"
        print("Fly activado")
        
        connection = RunService.Heartbeat:Connect(function()
            if not character or not character:FindFirstChild("HumanoidRootPart") then return end
            
            local cam = workspace.CurrentCamera
            local moveDir = Vector3.new()
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end
            
            moveDir = moveDir.Magnitude > 0 and moveDir.Unit or Vector3.new()
            
            local targetCFrame = rootPart.CFrame + moveDir * flySpeed
            rootPart.CFrame = targetCFrame
        end)
    end
end)

-- Noclip siempre activo (sin bugs)
noclip = true
RunService.Stepped:Connect(function()
    if noclip and character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

-- ==================== MANUAL DE USUARIO ====================
local manualBtn = createOptionButton("Manual", 0.65, function()
    local manualFrame = Instance.new("Frame")
    manualFrame.Size = UDim2.new(0.85, 0, 0.75, 0)
    manualFrame.Position = UDim2.new(0.075, 0, 0.125, 0)
    manualFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    manualFrame.Parent = mainGui
    local manualCorner = Instance.new("UICorner")
    manualCorner.CornerRadius = UDim.new(0, 20)
    manualCorner.Parent = manualFrame

    local manualTitle = Instance.new("TextLabel")
    manualTitle.Size = UDim2.new(1, 0, 0.15, 0)
    manualTitle.Text = "📖 MANUAL DE USO"
    manualTitle.TextColor3 = Color3.fromRGB(0, 255, 100)
    manualTitle.TextScaled = true
    manualTitle.Font = Enum.Font.GothamBold
    manualTitle.Parent = manualFrame

    local manualText = Instance.new("TextLabel")
    manualText.Size = UDim2.new(0.95, 0, 0.65, 0)
    manualText.Position = UDim2.new(0.025, 0, 0.18, 0)
    manualText.Text = [[
¡BIENVENIDO A JOSEANGEL_BLOX FLY!

✅ Noclip = siempre activado (puedes volar sin atravesar paredes).
✅ Fly = activa el vuelo usando WASD + ESPACIO (sube) + SHIFT (baja).

Cómo volar:
• WASD = moverte en la dirección de la cámara
• ESPACIO = subir
• SHIFT = bajar
• F = activar/desactivar Fly

¡Disfruta volando sin bugs! JoseAngel_Blox ❤️

    ]]
    manualText.TextColor3 = Color3.fromRGB(255, 255, 255)
    manualText.TextScaled = false
    manualText.Font = Enum.Font.Gotham
    manualText.TextWrapped = true
    manualText.TextXAlignment = Enum.TextXAlignment.Left
    manualText.Parent = manualFrame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0.2, 0, 0.12, 0)
    closeBtn.Position = UDim2.new(0.4, 0, 0.85, 0)
    closeBtn.Text = "Cerrar"
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Parent = manualFrame
    local cb = Instance.new("UICorner")
    cb.CornerRadius = UDim.new(0, 10)
    cb.Parent = closeBtn
    closeBtn.MouseButton1Click:Connect(function() manualFrame:Destroy() end)
end)

-- Cerrar gui con ESC
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Escape then
        mainGui.Enabled = not mainGui.Enabled
    end
end)

-- Limpiar si reaparece personaje
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    rootPart = newChar:WaitForChild("HumanoidRootPart")
end)

print("✅ JoseAngel_Blox Fly cargado correctamente")
