--[[
    Script: JoseAngel_Blox Fly (Universal)
    Compatible con CUALQUIER juego de Roblox.
    Características: Vuelo universal, velocidad ajustable, modo infinito, burbuja táctil, borde arcoíris.
    Funciona en PC, móvil, tablet y consola.
--]]

local player = game.Players.LocalPlayer
local userInput = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")

-- Variables de estado
local flying = false
local speed = 50
local infiniteSpeed = false
local currentVelocity = nil
local flyConnection = nil
local character = nil
local humanoid = nil
local rootPart = nil

-- Función para obtener el personaje actual (funciona siempre)
local function getCharacter()
    local char = player.Character
    if not char or not char.Parent then return nil end
    return char
end

-- Función para obtener la parte raíz (se adapta a cualquier avatar)
local function getRootPart(char)
    if not char then return nil end
    -- Intentar obtener HumanoidRootPart (estándar)
    local root = char:FindFirstChild("HumanoidRootPart")
    if root then return root end
    -- Si no existe, buscar cualquier parte con Anchored = false
    for _, part in ipairs(char:GetChildren()) do
        if part:IsA("BasePart") and part ~= char:FindFirstChild("Head") then
            return part
        end
    end
    return char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
end

-- Función para reiniciar referencias
local function refreshCharacter()
    character = getCharacter()
    if not character then return false end
    humanoid = character:FindFirstChildOfClass("Humanoid")
    rootPart = getRootPart(character)
    return (humanoid and rootPart)
end

-- Sistema de vuelo universal (sin BodyVelocity, compatible con todos los motores)
local function startFly()
    if flying then return end
    if not refreshCharacter() then
        warn("No se pudo iniciar vuelo: personaje no listo")
        return false
    end
    
    flying = true
    
    -- Guardar estado original
    local originalPlatformStand = humanoid.PlatformStand
    local originalAutoRotate = humanoid.AutoRotate
    
    humanoid.PlatformStand = true
    humanoid.AutoRotate = false
    humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
    
    -- Sistema de vuelo manual (más universal)
    flyConnection = runService.Heartbeat:Connect(function(deltaTime)
        if not flying then return end
        if not refreshCharacter() then
            stopFly()
            return
        end
        
        local moveDirection = humanoid.MoveDirection
        local currentSpeedVal = infiniteSpeed and 1000 or speed
        
        if moveDirection.Magnitude > 0 then
            -- Movimiento en la dirección que mira el jugador
            local camera = workspace.CurrentCamera
            local cameraCF = camera.CFrame
            local forward = cameraCF.LookVector
            local right = cameraCF.RightVector
            
            -- Obtener inputs del jugador (universal)
            local moveVector = Vector3.new(
                (userInput:IsKeyDown(Enum.KeyCode.D) and 1 or 0) - (userInput:IsKeyDown(Enum.KeyCode.A) and 1 or 0),
                0,
                (userInput:IsKeyDown(Enum.KeyCode.W) and 1 or 0) - (userInput:IsKeyDown(Enum.KeyCode.S) and 1 or 0)
            )
            
            -- Soporte para móvil (joystick virtual)
            if moveVector.Magnitude == 0 then
                moveVector = moveDirection
            end
            
            if moveVector.Magnitude > 0 then
                moveVector = moveVector.Unit
                local velocity = (forward * moveVector.Z + right * moveVector.X) * currentSpeedVal
                -- Control vertical
                if userInput:IsKeyDown(Enum.KeyCode.Space) or userInput:IsKeyDown(Enum.KeyCode.E) then
                    velocity = velocity + Vector3.new(0, currentSpeedVal, 0)
                elseif userInput:IsKeyDown(Enum.KeyCode.LeftControl) or userInput:IsKeyDown(Enum.KeyCode.Q) then
                    velocity = velocity + Vector3.new(0, -currentSpeedVal, 0)
                end
                rootPart.Velocity = velocity
            else
                -- Mantener suspendido en el aire cuando AFK
                if rootPart.Velocity.Y < -0.5 then
                    rootPart.Velocity = Vector3.new(rootPart.Velocity.X, 0, rootPart.Velocity.Z)
                end
            end
        else
            -- Modo AFK: queda flotando quieto
            if rootPart.Velocity.Y < -0.5 then
                rootPart.Velocity = Vector3.new(rootPart.Velocity.X, 0, rootPart.Velocity.Z)
            end
            if math.abs(rootPart.Velocity.Y) > 1 then
                rootPart.Velocity = Vector3.new(rootPart.Velocity.X, 0, rootPart.Velocity.Z)
            end
        end
    end)
    
    -- Efecto visual al activar
    if bubbleText then
        bubbleText.Text = "✨\nVOLANDO"
        bubbleText.TextColor3 = Color3.fromRGB(0, 255, 255)
    end
    
    return true
end

local function stopFly()
    if not flying then return end
    flying = false
    
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    
    if refreshCharacter() then
        humanoid.PlatformStand = false
        humanoid.AutoRotate = true
        humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
        
        -- Pequeño impulso para evitar caídas bruscas
        if rootPart then
            rootPart.Velocity = Vector3.new(rootPart.Velocity.X, 5, rootPart.Velocity.Z)
        end
    end
    
    if bubbleText then
        bubbleText.Text = "🐉\nVUELO"
        bubbleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end

-- Interfaz gráfica universal (sin errores en ningún juego)
local function createUI()
    -- Limpiar GUI anterior si existe
    local existingGui = player.PlayerGui:FindFirstChild("JoseAngelFlyGUI")
    if existingGui then existingGui:Destroy() end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "JoseAngelFlyGUI"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    -- Burbuja flotante (funciona con mouse y táctil)
    local bubble = Instance.new("ImageButton")
    bubble.Size = UDim2.new(0, 70, 0, 70)
    bubble.Position = UDim2.new(0.85, 0, 0.85, 0)
    bubble.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    bubble.BackgroundTransparency = 0.2
    bubble.Image = "rbxassetid://3926305904"
    bubble.ImageColor3 = Color3.fromRGB(100, 200, 255)
    bubble.ImageTransparency = 0.1
    bubble.AutoButtonColor = true
    bubble.Draggable = true
    bubble.Active = true
    bubble.Parent = screenGui
    
    local bubbleText = Instance.new("TextLabel")
    bubbleText.Size = UDim2.new(1, 0, 1, 0)
    bubbleText.BackgroundTransparency = 1
    bubbleText.Text = "🐉\nVUELO"
    bubbleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    bubbleText.TextScaled = true
    bubbleText.Font = Enum.Font.GothamBold
    bubbleText.TextWrapped = true
    bubbleText.Parent = bubble
    
    -- Menú principal
    local menu = Instance.new("Frame")
    menu.Size = UDim2.new(0, 320, 0, 280)
    menu.Position = UDim2.new(0.5, -160, 0.5, -140)
    menu.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    menu.BackgroundTransparency = 0.1
    menu.BorderSizePixel = 3
    menu.Visible = false
    menu.Parent = screenGui
    
    -- Borde redondeado
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = menu
    
    -- Borde arcoíris
    local border = Instance.new("UIStroke")
    border.Thickness = 3
    border.Color = Color3.fromRGB(255, 0, 0)
    border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    border.Parent = menu
    
    -- Título
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 45)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "🌟 JoseAngel Fly 🌟"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = menu
    
    -- Control velocidad
    local speedLabel = Instance.new("TextLabel")
    speedLabel.Size = UDim2.new(0.8, 0, 0, 30)
    speedLabel.Position = UDim2.new(0.1, 0, 0, 50)
    speedLabel.BackgroundTransparency = 1
    speedLabel.Text = "Velocidad: " .. speed
    speedLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
    speedLabel.TextXAlignment = Enum.TextXAlignment.Left
    speedLabel.Font = Enum.Font.Gotham
    speedLabel.Parent = menu
    
    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(0.8, 0, 0, 8)
    sliderBg.Position = UDim2.new(0.1, 0, 0, 85)
    sliderBg.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    sliderBg.BorderSizePixel = 0
    sliderBg.Parent = menu
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new(speed / 200, 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderBg
    
    local sliderBtn = Instance.new("ImageButton")
    sliderBtn.Size = UDim2.new(0, 18, 0, 18)
    sliderBtn.Position = UDim2.new(speed / 200, -9, -5, 0)
    sliderBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderBtn.Image = "rbxassetid://266887528"
    sliderBtn.Parent = sliderBg
    
    -- Checkbox velocidad infinita
    local infiniteBtn = Instance.new("TextButton")
    infiniteBtn.Size = UDim2.new(0.8, 0, 0, 35)
    infiniteBtn.Position = UDim2.new(0.1, 0, 0, 105)
    infiniteBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    infiniteBtn.Text = "⚡ Infinito: OFF"
    infiniteBtn.TextColor3 = Color3.fromRGB(255, 200, 100)
    infiniteBtn.Font = Enum.Font.GothamBold
    infiniteBtn.Parent = menu
    
    -- Botón toggle vuelo
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0.8, 0, 0, 45)
    toggleBtn.Position = UDim2.new(0.1, 0, 0, 155)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
    toggleBtn.Text = "🕊️ ACTIVAR VUELO"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.Parent = menu
    
    -- Botón cerrar
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 35, 0, 35)
    closeBtn.Position = UDim2.new(1, -42, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = menu
    
    -- Animación arcoíris del borde
    local hue = 0
    runService.RenderStepped:Connect(function()
        if menu.Visible then
            hue = (hue + 0.01) % 1
            local color = Color3.fromHSV(hue, 1, 1)
            border.Color = color
        end
    end)
    
    -- Eventos
    local menuVisible = false
    bubble.MouseButton1Click:Connect(function()
        menuVisible = not menuVisible
        menu.Visible = menuVisible
    end)
    
    toggleBtn.MouseButton1Click:Connect(function()
        if flying then
            stopFly()
            toggleBtn.Text = "🕊️ ACTIVAR VUELO"
            toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
        else
            startFly()
            toggleBtn.Text = "🛑 DESACTIVAR VUELO"
            toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        end
    end)
    
    closeBtn.MouseButton1Click:Connect(function()
        menu.Visible = false
        menuVisible = false
    end)
    
    infiniteBtn.MouseButton1Click:Connect(function()
        infiniteSpeed = not infiniteSpeed
        if infiniteSpeed then
            infiniteBtn.Text = "⚡ Infinito: ON"
            infiniteBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        else
            infiniteBtn.Text = "⚡ Infinito: OFF"
            infiniteBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
        end
    end)
    
    -- Slider de velocidad (compatible táctil)
    local dragging = false
    sliderBtn.MouseButton1Down:Connect(function() dragging = true end)
    userInput.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    runService.RenderStepped:Connect(function()
        if dragging and menuVisible then
            local mousePos = userInput:GetMouseLocation()
            local sliderPos = sliderBg.AbsolutePosition
            local newX = math.clamp(mousePos.X - sliderPos.X, 0, sliderBg.AbsoluteSize.X)
            speed = math.floor((newX / sliderBg.AbsoluteSize.X) * 200)
            speed = math.clamp(speed, 10, 200)
            sliderFill.Size = UDim2.new(speed / 200, 0, 1, 0)
            sliderBtn.Position = UDim2.new(speed / 200, -9, -5, 0)
            speedLabel.Text = "Velocidad: " .. speed
        end
    end)
    
    -- Reconectar automáticamente al morir
    player.CharacterAdded:Connect(function()
        task.wait(0.5)
        if flying then
            stopFly()
            task.wait(0.2)
            startFly()
        end
    end)
    
    return bubbleText
end

-- Iniciar todo
local bubbleText = createUI()

-- Notificación universal
task.wait(1)
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "JoseAngel_Blox Fly",
    Text = "✅ Script universal cargado | Toca burbuja azul",
    Duration = 3
})
