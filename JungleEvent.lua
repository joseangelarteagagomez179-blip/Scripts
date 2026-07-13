-- ============================================
-- 🍌 SCRIPT EVENTO JUNGLE - KICK A LUCKY BLOCK
-- ============================================
-- Creado especialmente para ti
-- Instrucciones: Copia y pega en tu ejecutor
-- Teclas: F=Recolectar | P=Pausar | K=Kick
-- ============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")

-- ============================================
-- CONFIGURACIÓN (Puedes cambiar estos valores)
-- ============================================
local config = {
    autoCollect = true,      -- Recolectar plátanos automático
    autoRun = true,          -- Correr obstáculos automático
    autoKick = true,         -- Patear bloques automático
    autoClaim = true,        -- Reclamar recompensas automático
    speed = 50,              -- Velocidad de movimiento
    jumpPower = 50,          -- Poder de salto
    collectDistance = 20,    -- Distancia para recolectar
    kickDelay = 0.5,         -- Delay entre kicks
    waitTime = 1,            -- Tiempo de espera entre acciones
}

-- ============================================
-- VARIABLES GLOBALES
-- ============================================
local isActive = true
local isCollecting = false
local isRunning = false
local currentState = "Esperando..."

-- ============================================
-- FUNCIÓN: MEJORAR ESTADÍSTICAS
-- ============================================
local function setStats()
    if humanoid then
        humanoid.WalkSpeed = config.speed
        humanoid.JumpPower = config.jumpPower
        currentState = "⚡ Estadísticas mejoradas"
        print("⚡ Velocidad: " .. config.speed .. " | Salto: " .. config.jumpPower)
    end
end

-- ============================================
-- FUNCIÓN: DETECTAR EVENTO JUNGLE
-- ============================================
local function isJungleEventActive()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Part") and obj.Name:find("Jungle") then
            return true
        end
        if obj:IsA("Model") and obj.Name:find("Portal") and obj.Name:find("Jungle") then
            return true
        end
    end
    return false
end

-- ============================================
-- FUNCIÓN: RECOLECTAR PLÁTANO
-- ============================================
local function collectBanana()
    if isCollecting then return end
    isCollecting = true
    
    local banana = nil
    local shortestDist = math.huge
    
    -- Buscar el plátano más cercano
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Tool") and (obj.Name:find("Banana") or obj.Name:find("Platano")) then
            if obj.Parent ~= character and obj.Parent ~= player.Backpack then
                local dist = (obj.Position - root.Position).Magnitude
                if dist < shortestDist and dist < config.collectDistance then
                    shortestDist = dist
                    banana = obj
                end
            end
        end
    end
    
    if banana then
        currentState = "🍌 Recolectando plátano..."
        print("🍌 Encontré un plátano a " .. math.floor(shortestDist) .. "m")
        
        -- Ir hacia el plátano
        humanoid:MoveTo(banana.Position)
        task.wait(0.3)
        
        -- Intentar recoger
        for _, tool in pairs(workspace:GetDescendants()) do
            if tool:IsA("Tool") and (tool.Name:find("Banana") or tool.Name:find("Platano")) then
                if tool.Parent ~= character then
                    local handle = tool:FindFirstChild("Handle")
                    if handle and handle:IsA("BasePart") then
                        local dist = (handle.Position - root.Position).Magnitude
                        if dist < 5 then
                            fireproximityprompt(tool)
                            print("✅ ¡Plátano recolectado!")
                            currentState = "✅ Plátano recolectado"
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

-- ============================================
-- FUNCIÓN: CORRER OBSTÁCULOS
-- ============================================
local function runObstacleCourse()
    if isRunning then return end
    isRunning = true
    
    currentState = "🏃 Corriendo obstáculos..."
    print("🏃 Corriendo el curso de obstáculos...")
    
    -- Buscar puntos de control o camino
    local pathPoints = {}
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            if obj.Name:find("Checkpoint") or 
               obj.Name:find("Path") or 
               obj.Name:find("Plataforma") or
               obj.Name:find("Floor") then
                if (obj.Position - root.Position).Magnitude < 100 then
                    table.insert(pathPoints, obj.Position)
                end
            end
        end
    end
    
    -- Si no encuentra puntos, buscar el portal
    if #pathPoints == 0 then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Name:find("Portal") then
                table.insert(pathPoints, obj.Position)
                break
            end
        end
    end
    
    -- Ordenar por distancia
    table.sort(pathPoints, function(a, b)
        return (a - root.Position).Magnitude < (b - root.Position).Magnitude
    end)
    
    -- Recorrer el camino
    for i, point in pairs(pathPoints) do
        if not isActive then break end
        
        humanoid:MoveTo(point)
        currentState = "🏃 Avanzando... (" .. i .. "/" .. #pathPoints .. ")"
        task.wait(0.8)
        
        -- Saltar si hay obstáculo
        if i % 3 == 0 and humanoid then
            humanoid.Jump = true
            task.wait(0.1)
        end
    end
    
    currentState = "✅ Curso completado"
    print("✅ ¡Curso de obstáculos completado!")
    isRunning = false
    return true
end

-- ============================================
-- FUNCIÓN: KICK AUTOMÁTICO
-- ============================================
local function autoKick()
    local block = nil
    local shortestDist = math.huge
    
    -- Buscar bloque para patear
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name:find("Block") and obj.Parent:IsA("Model") then
            -- Verificar que sea un lucky block
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
        currentState = "👢 Pateando bloque..."
        -- Simular el kick (click derecho en el bloque)
        local args = {
            [1] = block.Parent,
            [2] = block.Position
        }
        game:GetService("ReplicatedStorage"):FindFirstChild("KickBlock"):FireServer(unpack(args))
        print("👢 ¡Bloque pateado!")
        task.wait(config.kickDelay)
        return true
    end
    return false
end

-- ============================================
-- FUNCIÓN: RECLAMAR RECOMPENSAS
-- ============================================
local function claimRewards()
    currentState = "🎁 Reclamando recompensas..."
    print("🎁 Buscando recompensas...")
    
    -- Buscar botones de reclamar
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Part") and obj.Name:find("Claim") then
            fireclickdetector(obj)
            print("✅ ¡Recompensa reclamada!")
            currentState = "✅ Recompensa reclamada"
            return true
        end
    end
    
    -- Buscar en la GUI
    for _, gui in pairs(player.PlayerGui:GetChildren()) do
        for _, btn in pairs(gui:GetDescendants()) do
            if btn:IsA("TextButton") and (btn.Name:find("Claim") or btn.Name:find("Reclamar")) then
                btn:FireClient()
                print("✅ ¡Recompensa reclamada por GUI!")
                currentState = "✅ Recompensa reclamada"
                return true
            end
        end
    end
    
    return false
end

-- ============================================
-- FUNCIÓN: CICLO PRINCIPAL DEL EVENTO
-- ============================================
local function eventLoop()
    while isActive do
        task.wait(config.waitTime)
        
        -- Verificar si el evento está activo
        if not isJungleEventActive() then
            currentState = "⏳ Esperando evento..."
            task.wait(5)
            continue
        end
        
        print("🌴 ¡EVENTO JUNGLE ACTIVO!")
        currentState = "🌴 Evento activo!"
        
        -- PASO 1: Recolectar plátanos
        if config.autoCollect then
            for i = 1, 3 do
                if not isActive then break end
                collectBanana()
                task.wait(1)
            end
        end
        
        -- PASO 2: Correr obstáculos
        if config.autoRun then
            runObstacleCourse()
            task.wait(1)
        end
        
        -- PASO 3: Patear bloques
        if config.autoKick then
            for i = 1, 5 do
                if not isActive then break end
                autoKick()
                task.wait(0.3)
            end
        end
        
        -- PASO 4: Reclamar recompensas
        if config.autoClaim then
            claimRewards()
            task.wait(1)
        end
        
        currentState = "🔄 Ciclo completado, repitiendo..."
        print("🔄 Ciclo completado, repitiendo...")
    end
end

-- ============================================
-- FUNCIÓN: CARRERA COMPLETA HACIA EL PORTAL
-- ============================================
local function rushToPortal()
    currentState = "🚀 Corriendo al portal..."
    print("🚀 ¡Corriendo al portal!")
    
    -- Buscar el portal
    local portal = nil
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name:find("Portal") or obj.Name:find("End")) then
            portal = obj
            break
        end
    end
    
    if portal then
        humanoid:MoveTo(portal.Position + Vector3.new(0, 5, 0))
        task.wait(3)
        humanoid.Jump = true
        task.wait(0.5)
        print("✅ ¡Llegaste al portal!")
        currentState = "✅ Portal alcanzado"
        return true
    end
    return false
end

-- ============================================
-- CREAR GUI DE CONTROL
-- ============================================
local function createGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "JungleEventScript"
    screenGui.Parent = player.PlayerGui
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 250, 0, 120)
    frame.Position = UDim2.new(0, 10, 0, 10)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0.5
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(255, 200, 50)
    frame.Parent = screenGui
    
    -- Título
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0.3, 0)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "🍌 EVENTO JUNGLE"
    title.TextColor3 = Color3.fromRGB(255, 200, 50)
    title.TextScaled = true
    title.Font = Enum.Font.SourceSansBold
    title.Parent = frame
    
    -- Estado
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, 0, 0.4, 0)
    status.Position = UDim2.new(0, 0, 0.3, 0)
    status.BackgroundTransparency = 1
    status.Text = "⏳ Esperando evento..."
    status.TextColor3 = Color3.fromRGB(255, 255, 255)
    status.TextScaled = true
    status.Font = Enum.Font.SourceSans
    status.Name = "StatusLabel"
    status.Parent = frame
    
    -- Controles
    local controls = Instance.new("TextLabel")
    controls.Size = UDim2.new(1, 0, 0.3, 0)
    controls.Position = UDim2.new(0, 0, 0.7, 0)
    controls.BackgroundTransparency = 1
    controls.Text = "F=Recolectar | P=Pausar | K=Kick"
    controls.TextColor3 = Color3.fromRGB(200, 200, 200)
    controls.TextScaled = true
    controls.Font = Enum.Font.SourceSans
    controls.Parent = frame
    
    return status
end

local statusLabel = createGUI()

-- ============================================
-- ACTUALIZAR GUI
-- ============================================
spawn(function()
    while wait(0.5) do
        if statusLabel then
            local stateText = currentState
            if not isActive then
                stateText = "⏸️ PAUSADO"
            end
            statusLabel.Text = stateText
        end
    end
end)

-- ============================================
-- CONTROLES DE TECLADO
-- ============================================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    -- F = Recolectar plátano manual
    if input.KeyCode == Enum.KeyCode.F then
        collectBanana()
        print("🍌 Recolección manual")
    end
    
    -- P = Pausar/Activar
    if input.KeyCode == Enum.KeyCode.P then
        isActive = not isActive
        print(isActive and "▶️ SCRIPT ACTIVADO" or "⏸️ SCRIPT PAUSADO")
        if isActive then
            currentState = "▶️ Activo"
        else
            currentState = "⏸️ Pausado"
        end
    end
    
    -- K = Kick manual
    if input.KeyCode == Enum.KeyCode.K then
        autoKick()
        print("👢 Kick manual")
    end
    
    -- R = Correr al portal
    if input.KeyCode == Enum.KeyCode.R then
        rushToPortal()
    end
    
    -- M = Mejorar estadísticas
    if input.KeyCode == Enum.KeyCode.M then
        setStats()
    end
end)

-- ============================================
-- INICIAR EL SCRIPT
-- ============================================
print("🍌 ¡SCRIPT EVENTO JUNGLE CARGADO!")
print("📌 Teclas:")
print("   F = Recolectar plátano")
print("   P = Pausar/Activar")
print("   K = Kick manual")
print("   R = Correr al portal")
print("   M = Mejorar estadísticas")

-- Mejorar estadísticas al inicio
setStats()

-- Iniciar el bucle principal
spawn(eventLoop)

print("✅ ¡Todo listo! El script está funcionando.")
print("🎮 Esperando el evento Jungle...")
currentState = "🎮 Esperando evento..."
