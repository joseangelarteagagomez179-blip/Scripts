-- ============================================
-- 🌴 JoseAngel_Blox Jungle Events
-- Versión: 2.0 (PC y Móvil)
-- ============================================
-- Creado especialmente para ti
-- Interfaz con interruptores (toggles)
-- Fondo de jungla y diseño cuadrado con bordes redondeados
-- ============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")

-- ============================================
-- CONFIGURACIÓN INICIAL
-- ============================================
local config = {
    autoCollect = false,
    autoRun = false,
    autoKick = false,
    autoClaim = false,
    speed = 50,
    jumpPower = 50,
}

local isActive = true
local isCollecting = false
local isRunning = false

-- ============================================
-- CREAR GUI PRINCIPAL
-- ============================================
local function createMainGUI()
    -- Limpiar GUI anterior si existe
    local oldGui = player.PlayerGui:FindFirstChild("JoseAngelGUI")
    if oldGui then oldGui:Destroy() end
    
    -- ScreenGui principal
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "JoseAngelGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player.PlayerGui
    
    -- ============================================
    -- FONDO DE JUNGLA (Imagen o color degradado)
    -- ============================================
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 340, 0, 460)
    mainFrame.Position = UDim2.new(0.5, -170, 0.5, -230)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 60, 20)
    mainFrame.BackgroundTransparency = 0.15
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui
    
    -- Hacer esquinas redondeadas
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = mainFrame
    
    -- Degradado de fondo (simula jungla)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 80, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 130, 30)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 60, 20))
    })
    gradient.Rotation = 45
    gradient.Parent = mainFrame
    
    -- ============================================
    -- TÍTULO
    -- ============================================
    local titleFrame = Instance.new("Frame")
    titleFrame.Size = UDim2.new(1, 0, 0, 50)
    titleFrame.Position = UDim2.new(0, 0, 0, 0)
    titleFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    titleFrame.BackgroundTransparency = 0.5
    titleFrame.BorderSizePixel = 0
    titleFrame.Parent = mainFrame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 20)
    titleCorner.Parent = titleFrame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 1, 0)
    title.BackgroundTransparency = 1
    title.Text = "🌴 JoseAngel_Blox Jungle Events"
    title.TextColor3 = Color3.fromRGB(255, 215, 0)
    title.TextScaled = true
    title.Font = Enum.Font.SourceSansBold
    title.Parent = titleFrame
    
    -- ============================================
    -- SUBTÍTULO (Estado del evento)
    -- ============================================
    local statusFrame = Instance.new("Frame")
    statusFrame.Size = UDim2.new(1, -20, 0, 35)
    statusFrame.Position = UDim2.new(0, 10, 0, 55)
    statusFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    statusFrame.BackgroundTransparency = 0.5
    statusFrame.BorderSizePixel = 0
    statusFrame.Parent = mainFrame
    
    local statusCorner = Instance.new("UICorner")
    statusCorner.CornerRadius = UDim.new(0, 10)
    statusCorner.Parent = statusFrame
    
    local statusText = Instance.new("TextLabel")
    statusText.Size = UDim2.new(1, 0, 1, 0)
    statusText.BackgroundTransparency = 1
    statusText.Text = "⏳ Esperando evento..."
    statusText.TextColor3 = Color3.fromRGB(255, 255, 255)
    statusText.TextScaled = true
    statusText.Font = Enum.Font.SourceSans
    statusText.Name = "StatusLabel"
    statusText.Parent = statusFrame
    
    -- ============================================
    -- INTERRUPTORES (TOGGLES)
    -- ============================================
    local toggleY = 100
    local toggleHeight = 45
    local spacing = 55
    local toggles = {}
    
    -- Lista de funciones
    local functions = {
        {name = "🍌 Auto Recolectar", key = "autoCollect", color = Color3.fromRGB(255, 200, 50)},
        {name = "🏃 Auto Correr", key = "autoRun", color = Color3.fromRGB(100, 200, 255)},
        {name = "👢 Auto Kick", key = "autoKick", color = Color3.fromRGB(255, 100, 100)},
        {name = "🎁 Auto Reclamar", key = "autoClaim", color = Color3.fromRGB(100, 255, 100)}
    }
    
    for i, func in ipairs(functions) do
        local toggleFrame = Instance.new("Frame")
        toggleFrame.Size = UDim2.new(1, -20, 0, toggleHeight)
        toggleFrame.Position = UDim2.new(0, 10, 0, toggleY + (i-1) * spacing)
        toggleFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        toggleFrame.BackgroundTransparency = 0.4
        toggleFrame.BorderSizePixel = 0
        toggleFrame.Parent = mainFrame
        
        local toggleCorner = Instance.new("UICorner")
        toggleCorner.CornerRadius = UDim.new(0, 10)
        toggleCorner.Parent = toggleFrame
        
        -- Texto de la función
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.6, 0, 1, 0)
        label.Position = UDim2.new(0, 10, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = func.name
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextScaled = true
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Font = Enum.Font.SourceSans
        label.Parent = toggleFrame
        
        -- Interruptor (Toggle)
        local toggleBg = Instance.new("Frame")
        toggleBg.Size = UDim2.new(0, 55, 0, 30)
        toggleBg.Position = UDim2.new(1, -65, 0.5, -15)
        toggleBg.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        toggleBg.BorderSizePixel = 0
        toggleBg.Parent = toggleFrame
        
        local toggleCorner2 = Instance.new("UICorner")
        toggleCorner2.CornerRadius = UDim.new(1, 0)
        toggleCorner2.Parent = toggleBg
        
        -- Círculo del interruptor
        local toggleCircle = Instance.new("Frame")
        toggleCircle.Size = UDim2.new(0, 24, 0, 24)
        toggleCircle.Position = UDim2.new(0, 3, 0.5, -12)
        toggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        toggleCircle.BorderSizePixel = 0
        toggleCircle.Parent = toggleBg
        
        local circleCorner = Instance.new("UICorner")
        circleCorner.CornerRadius = UDim.new(1, 0)
        circleCorner.Parent = toggleCircle
        
        -- Guardar referencia
        toggles[func.key] = {
            bg = toggleBg,
            circle = toggleCircle,
            value = false,
            toggleFrame = toggleFrame
        }
        
        -- Función para cambiar el estado del toggle
        local function setToggle(value)
            toggles[func.key].value = value
            config[func.key] = value
            
            if value then
                toggleBg.BackgroundColor3 = func.color
                toggleCircle.Position = UDim2.new(1, -27, 0.5, -12)
            else
                toggleBg.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
                toggleCircle.Position = UDim2.new(0, 3, 0.5, -12)
            end
            
            print("🔄 " .. func.name .. ": " .. (value and "✅ Activado" or "❌ Desactivado"))
        end
        
        -- Evento click para PC
        local function onToggleClick()
            setToggle(not toggles[func.key].value)
        end
        
        toggleBg.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or 
               input.UserInputType == Enum.UserInputType.Touch then
                onToggleClick()
            end
        end)
        
        toggleFrame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or 
               input.UserInputType == Enum.UserInputType.Touch then
                onToggleClick()
            end
        end)
        
        -- Activar por defecto? (desactivado)
        setToggle(false)
    end
    
    -- ============================================
    -- BOTÓN DE ESTADÍSTICAS
    -- ============================================
    local statsY = toggleY + (#functions * spacing) + 10
    
    local statsFrame = Instance.new("Frame")
    statsFrame.Size = UDim2.new(1, -20, 0, 40)
    statsFrame.Position = UDim2.new(0, 10, 0, statsY)
    statsFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    statsFrame.BackgroundTransparency = 0.4
    statsFrame.BorderSizePixel = 0
    statsFrame.Parent = mainFrame
    
    local statsCorner = Instance.new("UICorner")
    statsCorner.CornerRadius = UDim.new(0, 10)
    statsCorner.Parent = statsFrame
    
    local statsLabel = Instance.new("TextLabel")
    statsLabel.Size = UDim2.new(1, 0, 1, 0)
    statsLabel.BackgroundTransparency = 1
    statsLabel.Text = "⚡ Mejorar Estadísticas"
    statsLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    statsLabel.TextScaled = true
    statsLabel.Font = Enum.Font.SourceSansBold
    statsLabel.Parent = statsFrame
    
    -- Click en estadísticas
    statsFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            if humanoid then
                humanoid.WalkSpeed = config.speed
                humanoid.JumpPower = config.jumpPower
                statsLabel.Text = "✅ Estadísticas mejoradas!"
                task.wait(1)
                statsLabel.Text = "⚡ Mejorar Estadísticas"
                print("⚡ Estadísticas mejoradas!")
            end
        end
    end)
    
    -- ============================================
    -- CRÉDITOS
    -- ============================================
    local creditsY = statsY + 50
    
    local credits = Instance.new("TextLabel")
    credits.Size = UDim2.new(1, 0, 0, 20)
    credits.Position = UDim2.new(0, 0, 0, creditsY)
    credits.BackgroundTransparency = 1
    credits.Text = "🧑‍💻 Creado por JoseAngel_Blox"
    credits.TextColor3 = Color3.fromRGB(150, 150, 150)
    credits.TextScaled = true
    credits.Font = Enum.Font.SourceSans
    credits.Parent = mainFrame
    
    -- ============================================
    -- BOTÓN DE CERRAR
    -- ============================================
    local closeBtn = Instance.new("ImageButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -40, 0, 10)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeBtn.BackgroundTransparency = 0.3
    closeBtn.BorderSizePixel = 0
    closeBtn.Image = "rbxassetid://3926305904"
    closeBtn.Parent = mainFrame
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(1, 0)
    closeCorner.Parent = closeBtn
    
    -- Efecto hover
    closeBtn.MouseEnter:Connect(function()
        closeBtn.BackgroundTransparency = 0
    end)
    closeBtn.MouseLeave:Connect(function()
        closeBtn.BackgroundTransparency = 0.3
    end)
    
    closeBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = false
        print("📱 GUI ocultada - Presiona 'J' para mostrar de nuevo")
    end)
    
    -- ============================================
    -- MOSTRAR GUI CON ANIMACIÓN
    -- ============================================
    mainFrame.BackgroundTransparency = 1
    mainFrame.Size = UDim2.new(0, 0, 0, 0)
    
    local tweenInfo = TweenInfo.new(
        0.5,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out
    )
    
    local tween1 = TweenService:Create(mainFrame, tweenInfo, {
        BackgroundTransparency = 0.15,
        Size = UDim2.new(0, 340, 0, 460)
    })
    tween1:Play()
    
    return screenGui, statusText
end

-- ============================================
-- FUNCIONES DEL SCRIPT
-- ============================================

-- Función para detectar evento
local function isJungleEventActive()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Part") and obj.Name:find("Jungle") then
            return true
        end
    end
    return false
end

-- Recolectar plátano
local function collectBanana()
    if isCollecting then return end
    isCollecting = true
    
    local banana = nil
    local shortestDist = math.huge
    
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Tool") and (obj.Name:find("Banana") or obj.Name:find("Platano")) then
            if obj.Parent ~= character and obj.Parent ~= player.Backpack then
                local dist = (obj.Position - root.Position).Magnitude
                if dist < shortestDist and dist < 20 then
                    shortestDist = dist
                    banana = obj
                end
            end
        end
    end
    
    if banana then
        humanoid:MoveTo(banana.Position)
        task.wait(0.5)
        
        for _, tool in pairs(workspace:GetDescendants()) do
            if tool:IsA("Tool") and (tool.Name:find("Banana") or tool.Name:find("Platano")) then
                if tool.Parent ~= character then
                    local handle = tool:FindFirstChild("Handle")
                    if handle and handle:IsA("BasePart") then
                        local dist = (handle.Position - root.Position).Magnitude
                        if dist < 5 then
                            fireproximityprompt(tool)
                            print("✅ Plátano recolectado!")
                            isCollecting = false
                            return true
                        end
                    end
                end
            end
        end
    end
    
    isCollecting = false
    return false
end

-- Correr obstáculos
local function runObstacleCourse()
    if isRunning then return end
    isRunning = true
    
    local pathPoints = {}
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name:find("Checkpoint") or obj.Name:find("Path") or obj.Name:find("Plataforma")) then
            if (obj.Position - root.Position).Magnitude < 100 then
                table.insert(pathPoints, obj.Position)
            end
        end
    end
    
    table.sort(pathPoints, function(a, b)
        return (a - root.Position).Magnitude < (b - root.Position).Magnitude
    end)
    
    for _, point in pairs(pathPoints) do
        if not isActive then break end
        humanoid:MoveTo(point)
        task.wait(0.8)
    end
    
    isRunning = false
    return true
end

-- Auto Kick
local function autoKick()
    local block = nil
    local shortestDist = math.huge
    
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name:find("Block") and obj.Parent:IsA("Model") then
            if obj.Parent.Name:find("Lucky") or obj.Parent.Name:find("Block") then
                local dist = (obj.Position - root.Position).Magnitude
                if dist < shortestDist and dist < 15 then
                    shortestDist = dist
                    block = obj
                end
            end
        end
    end
    
    if block then
        local args = {
            [1] = block.Parent,
            [2] = block.Position
        }
        local remote = game:GetService("ReplicatedStorage"):FindFirstChild("KickBlock")
        if remote then
            remote:FireServer(unpack(args))
            print("👢 Bloque pateado!")
            return true
        end
    end
    return false
end

-- Reclamar recompensas
local function claimRewards()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Part") and obj.Name:find("Claim") then
            fireclickdetector(obj)
            print("🎁 Recompensa reclamada!")
            return true
        end
    end
    
    for _, gui in pairs(player.PlayerGui:GetChildren()) do
        for _, btn in pairs(gui:GetDescendants()) do
            if btn:IsA("TextButton") and (btn.Name:find("Claim") or btn.Name:find("Reclamar")) then
                btn:FireClient()
                print("🎁 Recompensa reclamada por GUI!")
                return true
            end
        end
    end
    return false
end

-- ============================================
-- BUCLE PRINCIPAL
-- ============================================
local function mainLoop()
    while wait(1) do
        if not isActive then continue end
        
        -- Actualizar estado en GUI
        local statusLabel = player.PlayerGui:FindFirstChild("JoseAngelGUI")
        if statusLabel then
            local label = statusLabel:FindFirstChild("MainFrame"):FindFirstChild("StatusLabel")
            if label then
                if isJungleEventActive() then
                    label.Text = "🌴 ¡EVENTO ACTIVO!"
                    label.TextColor3 = Color3.fromRGB(100, 255, 100)
                else
                    label.Text = "⏳ Esperando evento..."
                    label.TextColor3 = Color3.fromRGB(255, 255, 255)
                end
            end
        end
        
        -- Solo ejecutar si el evento está activo
        if not isJungleEventActive() then
            wait(5)
            continue
        end
        
        -- Ejecutar funciones según toggles
        if config.autoCollect then
            for i = 1, 3 do
                collectBanana()
                wait(0.8)
            end
        end
        
        if config.autoRun then
            runObstacleCourse()
            wait(1)
        end
        
        if config.autoKick then
            for i = 1, 3 do
                autoKick()
                wait(0.3)
            end
        end
        
        if config.autoClaim then
            claimRewards()
            wait(1)
        end
    end
end

-- ============================================
-- MOSTRAR/OCULTAR GUI CON TECLA J
-- ============================================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.J then
        local gui = player.PlayerGui:FindFirstChild("JoseAngelGUI")
        if gui then
            local mainFrame = gui:FindFirstChild("MainFrame")
            if mainFrame then
                mainFrame.Visible = not mainFrame.Visible
                print(mainFrame.Visible and "📱 GUI mostrada" or "📱 GUI ocultada")
            end
        end
    end
end)

-- ============================================
-- INICIAR TODO
-- ============================================
local gui, statusText = createMainGUI()
print("🌴 JoseAngel_Blox Jungle Events CARGADO!")
print("📱 Presiona 'J' para mostrar/ocultar la GUI")
print("🎮 ¡Esperando el evento Jungle!")

-- Mejorar estadísticas automáticamente
wait(1)
if humanoid then
    humanoid.WalkSpeed = config.speed
    humanoid.JumpPower = config.jumpPower
end

-- Iniciar bucle principal
spawn(mainLoop)
