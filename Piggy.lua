-- =============================================
-- JoseAngel_Blox Scripts PRO
-- Versión: 1.1
-- Creado por: JoseAngel_Blox
-- Fecha de lanzamiento: 08/07/2026
-- =============================================

-- Servicios
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

-- Jugador
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- ==================== INTERFAZ - RELACIÓN 4:3 ====================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "JoseAngel_Blox_Pro"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Ventana principal (640x480 = 4:3)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainWindow"
mainFrame.Size = UDim2.new(0, 640, 0, 480)
mainFrame.Position = UDim2.new(0.5, -320, 0.5, -240)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Esquinas redondeadas
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 18)
mainCorner.Parent = mainFrame

-- Borde exterior
local mainStroke = Instance.new("UIStroke")
mainStroke.Thickness = 3
mainStroke.Color = Color3.fromRGB(0, 255, 100)
mainStroke.Parent = mainFrame

-- Título principal
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 60)
titleLabel.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
titleLabel.Text = "JoseAngel_Blox Scripts PRO"
titleLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextScaled = true
titleLabel.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 18)
titleCorner.Parent = titleLabel

-- ==================== SECCIÓN DE INFORMACIÓN ====================
local infoFrame = Instance.new("Frame")
infoFrame.Size = UDim2.new(0.45, 0, 0, 120)
infoFrame.Position = UDim2.new(0.025, 0, 0.18, 0)
infoFrame.BackgroundTransparency = 0.9
infoFrame.Parent = mainFrame

local infoTitle = Instance.new("TextLabel")
infoTitle.Size = UDim2.new(1, 0, 0, 25)
infoTitle.BackgroundTransparency = 1
infoTitle.Text = "ℹ️ Info ↓"
infoTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
infoTitle.Font = Enum.Font.GothamBold
infoTitle.TextXAlignment = Enum.TextXAlignment.Left
infoTitle.Parent = infoFrame

local infoText = Instance.new("TextLabel")
infoText.Size = UDim2.new(1, 0, 0, 90)
infoText.Position = UDim2.new(0, 0, 0, 25)
infoText.BackgroundTransparency = 1
infoText.Text = [[Nombre del Creador: JoseAngel_Blox
Fecha de lanzamiento: 08/07/2026
Versión: 1.1]]
infoText.TextColor3 = Color3.fromRGB(180, 180, 180)
infoText.Font = Enum.Font.GothamSemibold
infoText.TextSize = 14
infoText.TextXAlignment = Enum.TextXAlignment.Left
infoText.TextWrapped = true
infoText.Parent = infoFrame

-- ==================== CONTENEDOR DE OPCIONES ====================
local optionsFrame = Instance.new("Frame")
optionsFrame.Size = UDim2.new(0.95, 0, 0.60, 0)
optionsFrame.Position = UDim2.new(0.025, 0, 0.38, 0)
optionsFrame.BackgroundTransparency = 1
optionsFrame.Parent = mainFrame

local optionsTitle = Instance.new("TextLabel")
optionsTitle.Size = UDim2.new(1, 0, 0, 25)
optionsTitle.BackgroundTransparency = 1
optionsTitle.Text = "⚙️ Main ↓"
optionsTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
optionsTitle.Font = Enum.Font.GothamBold
optionsTitle.TextXAlignment = Enum.TextXAlignment.Left
optionsTitle.Parent = optionsFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 10)
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
listLayout.VerticalAlignment = Enum.VerticalAlignment.Top
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = optionsFrame

-- ==================== FUNCIÓN PARA CREAR INTERRUPTORES ====================
local function createToggle(name, defaultState, callback)
    local toggleContainer = Instance.new("Frame")
    toggleContainer.Size = UDim2.new(1, 0, 0, 40)
    toggleContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    toggleContainer.BorderSizePixel = 0
    toggleContainer.Parent = optionsFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = toggleContainer

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.8, 0, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(230, 230, 230)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = toggleContainer

    local toggleBackground = Instance.new("Frame")
    toggleBackground.Size = UDim2.new(0, 44, 0, 22)
    toggleBackground.Position = UDim2.new(1, -54, 0.5, -11)
    toggleBackground.BackgroundColor3 = defaultState and Color3.fromRGB(0, 200, 80) or Color3.fromRGB(60, 60, 60)
    toggleBackground.Parent = toggleContainer

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 11)
    toggleCorner.Parent = toggleBackground

    local toggleKnob = Instance.new("Frame")
    toggleKnob.Size = UDim2.new(0, 18, 0, 18)
    toggleKnob.Position = defaultState and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
    toggleKnob.BackgroundColor3 = Color3.new(1, 1, 1)
    toggleKnob.Parent = toggleBackground

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(0, 9)
    knobCorner.Parent = toggleKnob

    local isActive = defaultState

    local function switchState()
        isActive = not isActive
        local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quint)

        TweenService:Create(toggleBackground, tweenInfo, {
            BackgroundColor3 = isActive and Color3.fromRGB(0, 200, 80) or Color3.fromRGB(60, 60, 60)
        }):Play()

        TweenService:Create(toggleKnob, tweenInfo, {
            Position = isActive and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
        }):Play()

        if callback then callback(isActive) end
    end

    toggleContainer.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            switchState()
        end
    end)

    return toggleContainer
end

-- ==================== VARIABLES DE ESTADO ====================
local features = {
    godMode = false,
    itemESP = false,
    autoUnlock = false,
    autoGrab = false,
    noClip = false,
    speedJump = false,
    fullBright = false,
    playerESP = false,
    menuVisible = true
}

local originalWalkSpeed = humanoid.WalkSpeed
local originalJumpPower = humanoid.JumpPower
local originalLighting = {
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    FogEnd = Lighting.FogEnd,
    GlobalShadows = Lighting.GlobalShadows
}

-- Actualizar personaje si reaparece
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    originalWalkSpeed = humanoid.WalkSpeed
    originalJumpPower = humanoid.JumpPower
end)

-- ==================== FUNCIÓN PRINCIPAL DE EFECTOS ====================
RunService.Heartbeat:Connect(function()
    if not character or not humanoid or humanoid.Health <= 0 then return end

    -- God Mode
    if features.godMode then
        humanoid.MaxHealth = math.huge
        humanoid.Health = humanoid.MaxHealth
    end

    -- Item ESP
    if features.itemESP then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") and not obj:FindFirstAncestorOfClass("Player") then
                local name = obj.Name:lower()
                if name:find("item") or name:find("key") or name:find("tool") or name:find("box") then
                    obj.Color = Color3.new(1, 1, 0)
                    obj.Transparency = 0.3
                end
            end
        end
    end

    -- Auto Unlock Doors
    if features.autoUnlock then
        for _, door in ipairs(Workspace:GetDescendants()) do
            if door:IsA("BasePart") and door.Name:lower():find("door") then
                door.CanCollide = false
                door.Transparency = 0.4
            end
        end
    end

    -- Auto Grab Items
    if features.autoGrab and character:FindFirstChild("HumanoidRootPart") then
        local root = character.HumanoidRootPart
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if (obj:IsA("Tool") or obj:IsA("BasePart")) and (obj.Name:lower():find("item") or obj.Name:lower():find("key")) then
                if (root.Position - obj.Position).Magnitude < 16 then
                    obj.Parent = character
                end
            end
        end
    end

    -- No Clip
    if features.noClip then
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end

    -- Speed & Jump
    if features.speedJump then
        humanoid.WalkSpeed = 70
        humanoid.JumpPower = 75
    else
        humanoid.WalkSpeed = originalWalkSpeed
        humanoid.JumpPower = originalJumpPower
    end

    -- FullBright
    if features.fullBright then
        Lighting.Brightness = 3
        Lighting.ClockTime = 12
        Lighting.FogEnd = 200000
        Lighting.GlobalShadows = false
    else
        Lighting.Brightness = originalLighting.Brightness
        Lighting.ClockTime = originalLighting.ClockTime
        Lighting.FogEnd = originalLighting.FogEnd
        Lighting.GlobalShadows = originalLighting.GlobalShadows
    end

    -- ESP Jugadores / Piggy
    if features.playerESP then
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local root = plr.Character.HumanoidRootPart
                root.Color = Color3.new(1, 0, 0)
                root.Transparency = 0.2
            end
        end
    end
end)

-- ==================== TECLA INSERT MOSTRAR/OCULTAR ====================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        features.menuVisible = not features.menuVisible
        mainFrame.Visible = features.menuVisible
    end
end)

-- ==================== CREAR TODAS LAS OPCIONES ====================
createToggle("God Mode (invencible)", false, function(s) features.godMode = s end)
createToggle("Item ESP (ve items a través de paredes)", false, function(s) features.itemESP = s end)
createToggle("Toggle con la tecla INSERT (activar/desactivar todo)", false, function() end)
createToggle("Auto Unlock Doors (abre puertas automáticamente)", false, function(s) features.autoUnlock = s end)
createToggle("Auto Grab Items (coge todo lo que está cerca)", false, function(s) features.autoGrab = s end)
createToggle("No Clip: Atravesar paredes en emergencia", false, function(s) features.noClip = s end)
createToggle("Speed & Jump: Correr más rápido que Piggy", false, function(s) features.speedJump = s end)
createToggle("FullBright: Ver en mapas oscuros", false, function(s) features.fullBright = s end)
createToggle("ESP: Ver dónde está Piggy y otros jugadores", false, function(s) features.playerESP = s end)

print("✅ JoseAngel_Blox Scripts PRO v1.1 cargado correctamente")
