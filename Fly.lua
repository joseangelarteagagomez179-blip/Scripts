-- =============================================
-- JOSEANGEL_BLOX_FLY - Script Profesional v1.2
-- Fly + Noclip | Speed ajustable | Info PC + Celular
-- Compatible con PC y Móvil (Delta Executor)
-- =============================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")

local flyEnabled = false
local noclipEnabled = false
local currentSpeed = 50
local maxSpeed = 500
local minSpeed = 10

local bv, bg

-- ==================== NOTIFICACIONES ====================
local function notify(title, message, duration)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "JoseAngel_Notify"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, 280, 0, 110)
    main.Position = UDim2.new(0.5, -140, 0.85, 0)
    main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    main.BorderSizePixel = 0
    main.Parent = screenGui
    
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)
    
    local stroke = Instance.new("UIStroke", main)
    stroke.Color = Color3.fromRGB(255, 215, 0)
    stroke.Thickness = 3
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0.35, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Parent = main
    
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Size = UDim2.new(1, 0, 0.65, 0)
    messageLabel.Position = UDim2.new(0, 0, 0.35, 0)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Text = message
    messageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    messageLabel.TextScaled = true
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.Parent = main
    
    main.Size = UDim2.new(0, 280, 0, 0)
    TweenService:Create(main, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 280, 0, 110)}):Play()
    
    task.delay(duration, function()
        TweenService:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 280, 0, 0)}):Play()
        task.wait(0.3)
        screenGui:Destroy()
    end)
end

-- ==================== INFO SCREEN ====================
local function showInfoScreen()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "JoseAngel_InfoScreen"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    local main = Instance.new("Frame")
    main.Size = UDim2.new(0.45, 0, 0.6, 0)
    main.Position = UDim2.new(0.275, 0, 0.2, 0)
    main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    main.BorderSizePixel = 0
    main.Parent = screenGui
    
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 16)
    
    local stroke = Instance.new("UIStroke", main)
    stroke.Color = Color3.fromRGB(255, 215, 0)
    stroke.Thickness = 4
    
    -- Título
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0.15, 0)
    title.BackgroundTransparency = 1
    title.Text = "JoseAngel_Blox_Fly - v1.2"
    title.TextColor3 = Color3.fromRGB(255, 215, 0)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBlack
    title.Parent = main
    
    -- Línea
    local line = Instance.new("Frame")
    line.Size = UDim2.new(0.9, 0, 0, 2)
    line.Position = UDim2.new(0.05, 0, 0.15, 0)
    line.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    line.Parent = main
    
    -- Información
    local infoFrame = Instance.new("Frame")
    infoFrame.Size = UDim2.new(1, 0, 0.65, 0)
    infoFrame.Position = UDim2.new(0, 0, 0.18, 0)
    infoFrame.BackgroundTransparency = 1
    infoFrame.Parent = main
    
    local creator = Instance.new("TextLabel")
    creator.Size = UDim2.new(1, 0, 0.2, 0)
    creator.BackgroundTransparency = 1
    creator.Text = "Nombre del Creador: JoseAngel_Blox"
    creator.TextColor3 = Color3.fromRGB(255, 255, 255)
    creator.TextScaled = true
    creator.Font = Enum.Font.GothamBold
    creator.Parent = infoFrame
    
    local date = Instance.new("TextLabel")
    date.Size = UDim2.new(1, 0, 0.2, 0)
    date.Position = UDim2.new(0, 0, 0.22, 0)
    date.BackgroundTransparency = 1
    date.Text = "Fecha de lanzamiento: 06/07/2026"
    date.TextColor3 = Color3.fromRGB(255, 255, 255)
    date.TextScaled = true
    date.Font = Enum.Font.GothamBold
    date.Parent = infoFrame
    
    local version = Instance.new("TextLabel")
    version.Size = UDim2.new(1, 0, 0.2, 0)
    version.Position = UDim2.new(0, 0, 0.44, 0)
    version.BackgroundTransparency = 1
    version.Text = "Versión: 1.2"
    version.TextColor3 = Color3.fromRGB(255, 215, 0)
    version.TextScaled = true
    version.Font = Enum.Font.GothamBold
    version.Parent = infoFrame
    
    -- Cómo usar
    local useLabel = Instance.new("TextLabel")
    useLabel.Size = UDim2.new(1, 0, 0.35, 0)
    useLabel.Position = UDim2.new(0, 0, 0.67, 0)
    useLabel.BackgroundTransparency = 1
    useLabel.Text = [[INSTRUCCIONES:

    PC:
    • F = Volando / Noclip
    • Z = Aumentar velocidad
    • X = Disminuir velocidad
    • Y = Información

    Celular:
    • Botón de ala en pantalla = Volando / Noclip
    • Z / X = Velocidad
    • Y = Información

    ¡Disfruta y sé OP! 🚀]]
    useLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    useLabel.TextScaled = true
    useLabel.Font = Enum.Font.Gotham
    useLabel.TextXAlignment = Enum.TextXAlignment.Left
    useLabel.TextWrapped = true
    useLabel.Parent = infoFrame
    
    -- Botón Cerrar
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0.3, 0, 0.1, 0)
    closeBtn.Position = UDim2.new(0.35, 0, 0.9, 0)
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    closeBtn.Text = "Cerrar"
    closeBtn.TextColor3 = Color3.new(1, 1, 1)
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = main
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 10)
    
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
end

-- ==================== FLY & NOCLIP ====================
local function cleanup()
    if bv then bv:Destroy() end
    if bg then bg:Destroy() end
    humanoid.PlatformStand = false
    flyEnabled = false
end

local function applyNoclip(enabled)
    noclipEnabled = enabled
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") and part.CanCollide then
            part.CanCollide = not enabled
        end
    end
end

local function flyLoop()
    while flyEnabled do
        if not root or not root.Parent then return end
        
        local moveDir = UserInputService:GetMoveVector()
        local cameraCF = workspace.CurrentCamera.CFrame
        local direction = Vector3.new()
        
        if moveDir.X > 0 then direction = direction + cameraCF.RightVector end
        if moveDir.X < 0 then direction = direction - cameraCF.RightVector end
        if moveDir.Z > 0 then direction = direction - cameraCF.LookVector end
        if moveDir.Z < 0 then direction = direction + cameraCF.LookVector end
        
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direction = direction + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then direction = direction - Vector3.new(0, 1, 0) end
        
        if direction.Magnitude > 0 then
            direction = direction.Unit * currentSpeed
            bv.Velocity = direction
        else
            bv.Velocity = Vector3.new(0, bv.Velocity.Y, 0)
        end
        
        if noclipEnabled then applyNoclip(true) end
        
        task.wait(0.016)
    end
end

local function toggleFly()
    cleanup()
    
    if flyEnabled then
        humanoid.PlatformStand = false
        notify("Fly", "Volando desactivado", 2)
    else
        bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(400000, 400000, 400000)
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.Parent = root
        
        bg = Instance.new("BodyGyro")
        bg.P = 9e4
        bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.CFrame = root.CFrame
        bg.Parent = root
        
        humanoid.PlatformStand = true
        humanoid.AutoRotate = false
        flyEnabled = true
        noclipEnabled = true
        applyNoclip(true)
        
        notify("Fly", "Volando activado | Speed: " .. currentSpeed, 2)
        flyLoop()
    end
end

local function changeSpeed(increment)
    currentSpeed = math.clamp(currentSpeed + increment, minSpeed, maxSpeed)
    print("✅ Speed ajustado: " .. currentSpeed)
    if flyEnabled then
        notify("Speed", "Speed ahora: " .. currentSpeed, 1)
    end
end

-- ==================== CONTROLES ====================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.F then
        toggleFly()
    elseif input.KeyCode == Enum.KeyCode.Y then
        showInfoScreen()
    elseif input.KeyCode == Enum.KeyCode.Z then
        changeSpeed(20)
    elseif input.KeyCode == Enum.KeyCode.X then
        changeSpeed(-20)
    end
end)

-- Celular: botón grande de volar
local mobileFlyButton
if UserInputService.TouchEnabled then
    mobileFlyButton = Instance.new("TextButton")
    mobileFlyButton.Size = UDim2.new(0.3, 0, 0.12, 0)
    mobileFlyButton.Position = UDim2.new(0.35, 0, 0.78, 0)
    mobileFlyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    mobileFlyButton.Text = "🛫 VOLAR"
    mobileFlyButton.TextColor3 = Color3.new(1, 1, 1)
    mobileFlyButton.TextScaled = true
    mobileFlyButton.Font = Enum.Font.GothamBlack
    mobileFlyButton.Parent = player:WaitForChild("PlayerGui")
    Instance.new("UICorner", mobileFlyButton).CornerRadius = UDim.new(0, 12)
    
    mobileFlyButton.MouseButton1Click:Connect(function()
        toggleFly()
    end)
end

-- Auto cleanup
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    root = newChar:WaitForChild("HumanoidRootPart")
end)

humanoid.Died:Connect(cleanup)

print("✅ JoseAngel_Blox_Fly v1.2 cargado correctamente")
notify("JoseAngel_Blox_Fly", "v1.2 - Presiona F / Y / Botón Celular\nZ + X para velocidad", 6)
