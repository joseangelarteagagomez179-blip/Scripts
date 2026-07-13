-- ============================================
-- 🌴 JUNGLE EVENT - SCRIPT COMPLETO
-- Para Delta Executor / Roblox
-- Versión: 1.0.0
-- Autor: JoseAngel_Blox
-- GitHub: https://github.com/tu-usuario/JungleEvent
-- ============================================

print("🌴 Cargando Jungle Event Complete...")

-- ============================================
-- 1. CONFIGURACIÓN
-- ============================================

local CONFIG = {
    -- Tiempos
    EventCooldown = 7200,        -- 2 horas
    EventDuration = 900,         -- 15 minutos
    PortalSpawnDelay = 30,       -- Segundos hasta que aparece el portal
    BossChaseTime = 60,          -- Segundos de persecución
    ObstacleTimeLimit = 30,      -- Segundos por obstáculo
    
    -- Jefe
    Boss = {
        Name = "Glorbo Fruttodrillo",
        Speed = 16,
        MaxSpeed = 35,
        SpeedIncrease = 0.5,
        Damage = 100,
        ChaseRange = 60,
    },
    
    -- Obstáculos
    ObstacleTypes = {
        "Laberinto", "Parkour", "Lava", "Pinchos", "PlataformasMoviles"
    },
    
    -- Interfaz
    UI = {
        PanelSize = {X = 250, Y = 200},
        CornerRadius = 12,
        Colors = {
            Primary = Color3.fromRGB(255, 215, 0),
            Background = Color3.fromRGB(20, 50, 20),
            Text = Color3.fromRGB(255, 255, 255),
            Success = Color3.fromRGB(0, 255, 0),
            Danger = Color3.fromRGB(255, 0, 0),
        }
    },
    
    -- Límites
    Limits = {
        MaxPlayersPerEvent = 20,
        MaxRewardsPerPlayer = 1,
        MinPlayersToStart = 1,
    }
}

-- ============================================
-- 2. RECOMPENSAS
-- ============================================

local REWARDS = {
    {
        Name = "250K Cash",
        Chance = 32,
        Type = "Cash",
        Value = 250000,
        Color = Color3.fromRGB(255, 215, 0),
        Icon = "💰",
        Rarity = "Común"
    },
    {
        Name = "+1 Banana",
        Chance = 28,
        Type = "ExtraSpin",
        Value = 1,
        Color = Color3.fromRGB(255, 255, 0),
        Icon = "🍌",
        Rarity = "Común"
    },
    {
        Name = "x1.5 Kick Speed",
        Chance = 22,
        Type = "Boost",
        Value = 1.5,
        Color = Color3.fromRGB(0, 255, 255),
        Icon = "⚡",
        Rarity = "Poco Común"
    },
    {
        Name = "+1 Speed",
        Chance = 14,
        Type = "Boost",
        Value = 1,
        Color = Color3.fromRGB(0, 255, 128),
        Icon = "🏃",
        Rarity = "Poco Común"
    },
    {
        Name = "Croakumber",
        Chance = 2,
        Type = "Brainrot",
        Value = 0.75,
        Color = Color3.fromRGB(0, 255, 0),
        Icon = "🐸",
        Rarity = "Raro"
    },
    {
        Name = "Tuki Tuki Taco",
        Chance = 1,
        Type = "Brainrot",
        Value = 1,
        Color = Color3.fromRGB(255, 128, 0),
        Icon = "🌮",
        Rarity = "Épico"
    },
    {
        Name = "Lampuccio Racconelli",
        Chance = 0.7,
        Type = "Brainrot",
        Value = 1.25,
        Color = Color3.fromRGB(255, 0, 255),
        Icon = "🦝",
        Rarity = "Legendario"
    },
    {
        Name = "Professor Tigrellini",
        Chance = 0.25,
        Type = "Brainrot",
        Value = 2,
        Color = Color3.fromRGB(255, 0, 0),
        Icon = "🐯",
        Rarity = "Mítico"
    },
    {
        Name = "Orangutango Supremo",
        Chance = 0.05,
        Type = "Brainrot",
        Value = 3,
        Color = Color3.fromRGB(255, 215, 0),
        Icon = "🦧",
        Rarity = "Ultra Mítico"
    },
}

-- ============================================
-- 3. UTILIDADES
-- ============================================

local Utils = {}

function Utils.GetRandomPosition(radius)
    radius = radius or 200
    return Vector3.new(
        math.random(-radius, radius),
        5,
        math.random(-radius, radius)
    )
end

function Utils.CreateParticles(position, color, count, lifetime)
    count = count or 30
    lifetime = lifetime or 2
    color = color or Color3.fromRGB(255, 215, 0)
    
    for i = 1, count do
        local particle = Instance.new("Part")
        particle.Size = Vector3.new(0.5, 0.5, 0.5)
        particle.Position = position + Vector3.new(
            math.random(-5, 5),
            math.random(0, 5),
            math.random(-5, 5)
        )
        particle.Anchored = true
        particle.CanCollide = false
        particle.BrickColor = BrickColor.new(color)
        particle.Transparency = 0.5
        particle.Parent = workspace
        game:GetService("Debris"):AddItem(particle, lifetime)
    end
end

function Utils.PlaySound(soundId, volume)
    volume = volume or 0.5
    local sound = Instance.new("Sound")
    sound.SoundId = soundId or "rbxassetid://1839518145"
    sound.Volume = volume
    sound.Parent = workspace
    sound:Play()
    game:GetService("Debris"):AddItem(sound, 5)
end

function Utils.GetHRP(player)
    if not player or not player.Character then return nil end
    return player.Character:FindFirstChild("HumanoidRootPart")
end

function Utils.GetReward()
    local totalChance = 0
    for _, reward in ipairs(REWARDS) do
        totalChance = totalChance + reward.Chance
    end
    
    local random = math.random() * totalChance
    local cumulative = 0
    
    for _, reward in ipairs(REWARDS) do
        cumulative = cumulative + reward.Chance
        if random <= cumulative then
            return reward
        end
    end
    return REWARDS[1]
end

function Utils.ApplyReward(player, reward)
    if not player or not reward then return false end
    
    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then
        leaderstats = Instance.new("Folder")
        leaderstats.Name = "leaderstats"
        leaderstats.Parent = player
        local cash = Instance.new("NumberValue")
        cash.Name = "Cash"
        cash.Value = 0
        cash.Parent = leaderstats
    end
    
    if reward.Type == "Cash" then
        local cash = leaderstats:FindFirstChild("Cash")
        if cash then
            cash.Value = cash.Value + reward.Value
            return true
        end
    elseif reward.Type == "Brainrot" then
        local inventory = player:FindFirstChild("Inventory")
        if not inventory then
            inventory = Instance.new("Folder")
            inventory.Name = "Inventory"
            inventory.Parent = player
        end
        local brainrot = Instance.new("StringValue")
        brainrot.Name = reward.Name
        brainrot.Value = tostring(reward.Value)
        brainrot.Parent = inventory
        return true
    elseif reward.Type == "Boost" then
        local boosts = player:FindFirstChild("Boosts")
        if not boosts then
            boosts = Instance.new("Folder")
            boosts.Name = "Boosts"
            boosts.Parent = player
        end
        local boost = Instance.new("NumberValue")
        boost.Name = reward.Name
        boost.Value = reward.Value
        boost.Parent = boosts
        game:GetService("Debris"):AddItem(boost, 1800)
        return true
    elseif reward.Type == "ExtraSpin" then
        local spins = player:FindFirstChild("ExtraSpins")
        if not spins then
            spins = Instance.new("NumberValue")
            spins.Name = "ExtraSpins"
            spins.Value = 0
            spins.Parent = player
        end
        spins.Value = spins.Value + reward.Value
        return true
    end
    return false
end

-- ============================================
-- 4. INTERFAZ DE USUARIO
-- ============================================

local UIManager = {}
UIManager.__index = UIManager

function UIManager.new()
    local self = setmetatable({}, UIManager)
    self:CreateUI()
    return self
end

function UIManager:CreateUI()
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "JungleEventUI"
    self.ScreenGui.ResetOnSpawn = false
    self.ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    
    -- Panel principal
    self.Panel = Instance.new("Frame")
    self.Panel.Size = UDim2.new(0, CONFIG.UI.PanelSize.X, 0, CONFIG.UI.PanelSize.Y)
    self.Panel.Position = UDim2.new(1, -CONFIG.UI.PanelSize.X - 20, 0, 20)
    self.Panel.BackgroundColor3 = CONFIG.UI.Colors.Background
    self.Panel.BackgroundTransparency = 0.15
    self.Panel.BorderSizePixel = 0
    self.Panel.Visible = false
    self.Panel.Parent = self.ScreenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, CONFIG.UI.CornerRadius)
    corner.Parent = self.Panel
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 60, 10)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(20, 80, 20)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 60, 10)),
    })
    gradient.Rotation = 45
    gradient.Parent = self.Panel
    
    -- Título
    self.Title = Instance.new("TextLabel")
    self.Title.Size = UDim2.new(1, 0, 0.2, 0)
    self.Title.Position = UDim2.new(0, 0, 0.02, 0)
    self.Title.BackgroundTransparency = 1
    self.Title.Text = "🌴 EVENTO JUNGLA"
    self.Title.TextColor3 = CONFIG.UI.Colors.Primary
    self.Title.TextSize = 20
    self.Title.Font = Enum.Font.Bold
    self.Title.TextStrokeTransparency = 0
    self.Title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    self.Title.Parent = self.Panel
    
    -- Temporizador
    self.Timer = Instance.new("TextLabel")
    self.Timer.Size = UDim2.new(1, 0, 0.18, 0)
    self.Timer.Position = UDim2.new(0, 0, 0.22, 0)
    self.Timer.BackgroundTransparency = 1
    self.Timer.Text = "⏱️ 15:00"
    self.Timer.TextColor3 = CONFIG.UI.Colors.Text
    self.Timer.TextSize = 18
    self.Timer.Font = Enum.Font.SourceSans
    self.Timer.TextStrokeTransparency = 0
    self.Timer.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    self.Timer.Parent = self.Panel
    
    -- Jugadores
    self.Players = Instance.new("TextLabel")
    self.Players.Size = UDim2.new(1, 0, 0.18, 0)
    self.Players.Position = UDim2.new(0, 0, 0.40, 0)
    self.Players.BackgroundTransparency = 1
    self.Players.Text = "👥 0 jugadores"
    self.Players.TextColor3 = CONFIG.UI.Colors.Success
    self.Players.TextSize = 16
    self.Players.Font = Enum.Font.SourceSans
    self.Players.TextStrokeTransparency = 0
    self.Players.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    self.Players.Parent = self.Panel
    
    -- Estado
    self.Status = Instance.new("TextLabel")
    self.Status.Size = UDim2.new(1, 0, 0.22, 0)
    self.Status.Position = UDim2.new(0, 0, 0.58, 0)
    self.Status.BackgroundTransparency = 1
    self.Status.Text = "📍 Esperando evento..."
    self.Status.TextColor3 = CONFIG.UI.Colors.Text
    self.Status.TextSize = 14
    self.Status.Font = Enum.Font.SourceSans
    self.Status.TextStrokeTransparency = 0
    self.Status.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    self.Status.TextWrapped = true
    self.Status.Parent = self.Panel
    
    -- Popup de recompensas
    self.Popup = Instance.new("Frame")
    self.Popup.Size = UDim2.new(0, 400, 0, 250)
    self.Popup.Position = UDim2.new(0.5, -200, 0.4, -125)
    self.Popup.BackgroundColor3 = CONFIG.UI.Colors.Background
    self.Popup.BackgroundTransparency = 0.1
    self.Popup.BorderSizePixel = 3
    self.Popup.BorderColor3 = CONFIG.UI.Colors.Primary
    self.Popup.Visible = false
    self.Popup.Parent = self.ScreenGui
    
    local popupCorner = Instance.new("UICorner")
    popupCorner.CornerRadius = UDim.new(0, 16)
    popupCorner.Parent = self.Popup
    
    local popupGradient = Instance.new("UIGradient")
    popupGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(5, 30, 5)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 50, 15)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 30, 5)),
    })
    popupGradient.Rotation = 135
    popupGradient.Parent = self.Popup
    
    self.PopupTitle = Instance.new("TextLabel")
    self.PopupTitle.Size = UDim2.new(1, 0, 0.2, 0)
    self.PopupTitle.Position = UDim2.new(0, 0, 0.05, 0)
    self.PopupTitle.BackgroundTransparency = 1
    self.PopupTitle.Text = "🎉 RECOMPENSA"
    self.PopupTitle.TextColor3 = CONFIG.UI.Colors.Primary
    self.PopupTitle.TextSize = 28
    self.PopupTitle.Font = Enum.Font.Bold
    self.PopupTitle.Parent = self.Popup
    
    self.PopupIcon = Instance.new("TextLabel")
    self.PopupIcon.Size = UDim2.new(0, 60, 0, 60)
    self.PopupIcon.Position = UDim2.new(0.5, -30, 0.28, 0)
    self.PopupIcon.BackgroundTransparency = 1
    self.PopupIcon.Text = "💰"
    self.PopupIcon.TextColor3 = CONFIG.UI.Colors.Primary
    self.PopupIcon.TextSize = 50
    self.PopupIcon.Font = Enum.Font.SourceSans
    self.PopupIcon.Parent = self.Popup
    
    self.PopupName = Instance.new("TextLabel")
    self.PopupName.Size = UDim2.new(1, 0, 0.2, 0)
    self.PopupName.Position = UDim2.new(0, 0, 0.5, 0)
    self.PopupName.BackgroundTransparency = 1
    self.PopupName.Text = "250K Cash"
    self.PopupName.TextColor3 = CONFIG.UI.Colors.Text
    self.PopupName.TextSize = 22
    self.PopupName.Font = Enum.Font.Bold
    self.PopupName.Parent = self.Popup
    
    self.PopupButton = Instance.new("TextButton")
    self.PopupButton.Size = UDim2.new(0.4, 0, 0.12, 0)
    self.PopupButton.Position = UDim2.new(0.3, 0, 0.78, 0)
    self.PopupButton.BackgroundColor3 = CONFIG.UI.Colors.Primary
    self.PopupButton.Text = "¡GENIAL!"
    self.PopupButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    self.PopupButton.TextSize = 20
    self.PopupButton.Font = Enum.Font.Bold
    self.PopupButton.Parent = self.Popup
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = self.PopupButton
    
    self.PopupButton.MouseButton1Click:Connect(function()
        self.Popup.Visible = false
    end)
end

function UIManager:ShowPanel()
    self.Panel.Visible = true
end

function UIManager:HidePanel()
    self.Panel.Visible = false
end

function UIManager:UpdateTimer(timeLeft)
    if not self.Timer then return end
    local minutes = math.floor(timeLeft / 60)
    local seconds = timeLeft % 60
    self.Timer.Text = string.format("⏱️ %02d:%02d", minutes, seconds)
    if timeLeft < 60 then
        self.Timer.TextColor3 = CONFIG.UI.Colors.Danger
    else
        self.Timer.TextColor3 = CONFIG.UI.Colors.Text
    end
end

function UIManager:UpdatePlayers(count)
    if self.Players then
        self.Players.Text = "👥 " .. count .. " jugadores"
    end
end

function UIManager:UpdateStatus(text, color)
    if self.Status then
        self.Status.Text = text
        if color then
            self.Status.TextColor3 = color
        end
    end
end

function UIManager:ShowReward(reward)
    if not reward then return end
    self.PopupTitle.Text = "🎉 " .. reward.Name .. " 🎉"
    self.PopupIcon.Text = reward.Icon or "🎁"
    self.PopupName.Text = reward.Name
    self.PopupName.TextColor3 = reward.Color or CONFIG.UI.Colors.Text
    self.Popup.Visible = true
    Utils.PlaySound("rbxassetid://1839518145", 0.5)
end

-- ============================================
-- 5. GESTOR DEL EVENTO
-- ============================================

local EventManager = {}
EventManager.__index = EventManager

function EventManager.new(uiManager)
    local self = setmetatable({}, EventManager)
    self.UI = uiManager
    self.IsActive = false
    self.IsOnCooldown = false
    self.ActivePlayers = {}
    self.EventObjects = {}
    self.StartTime = 0
    self.CurrentTimer = nil
    self.CooldownTimer = nil
    return self
end

function EventManager:GetStatus()
    return {
        IsActive = self.IsActive,
        IsOnCooldown = self.IsOnCooldown,
        PlayerCount = #self.ActivePlayers,
        TimeLeft = self.IsActive and (CONFIG.EventDuration - (os.time() - self.StartTime)) or 0
    }
end

function EventManager:CreatePortal()
    local position = Utils.GetRandomPosition(200)
    
    local portal = Instance.new("Part")
    portal.Name = "JunglePortal"
    portal.Size = Vector3.new(6, 8, 6)
    portal.Position = position
    portal.Anchored = true
    portal.CanCollide = false
    portal.Transparency = 0.3
    portal.BrickColor = BrickColor.new("Bright yellow")
    portal.Material = Enum.Material.Neon
    portal.Parent = workspace
    
    local glow = Instance.new("PointLight")
    glow.Parent = portal
    glow.Color = Color3.fromRGB(255, 215, 0)
    glow.Range = 40
    glow.Brightness = 10
    
    local particles = Instance.new("ParticleEmitter")
    particles.Parent = portal
    particles.Texture = "rbxasset://textures/particles/sparkle_main.dds"
    particles.Rate = 100
    particles.Lifetime = NumberRange.new(0.5, 1)
    particles.SpreadAngle = Vector2.new(360, 360)
    particles.Transparency = NumberSequence.new(0.5, 0)
    particles.Size = NumberSequence.new(1, 3)
    particles.Color = ColorSequence.new(Color3.fromRGB(255, 215, 0))
    
    self.EventObjects[#self.EventObjects + 1] = portal
    
    -- Script de teletransporte
    local script = Instance.new("Script")
    script.Source = [[
        script.Parent.Touched:Connect(function(hit)
            local player = game.Players:GetPlayerFromCharacter(hit.Parent)
            if not player then return end
            
            local cave = workspace:FindFirstChild("JungleCave")
            if cave then
                local hrp = hit.Parent:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = cave.CFrame + Vector3.new(0, 3, 0)
                    -- Notificar al servidor
                    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("JungleEventRemote")
                    if remote then
                        remote:FireServer("PlayerEntered", player)
                    end
                end
            end
        end)
    ]]
    script.Parent = portal
    
    return portal
end

function EventManager:CreateCave()
    local cavePos = Vector3.new(1000, 0, 0)
    
    -- Cueva
    local cave = Instance.new("Part")
    cave.Name = "JungleCave"
    cave.Size = Vector3.new(50, 20, 50)
    cave.Position = cavePos
    cave.Anchored = true
    cave.CanCollide = true
    cave.Transparency = 0.4
    cave.BrickColor = BrickColor.new("Dark green")
    cave.Material = Enum.Material.Grass
    cave.Parent = workspace
    self.EventObjects[#self.EventObjects + 1] = cave
    
    -- Plátano
    local banana = Instance.new("Part")
    banana.Name = "GoldenBanana"
    banana.Size = Vector3.new(2, 3, 1)
    banana.Position = cavePos + Vector3.new(0, 5, 0)
    banana.Anchored = true
    banana.CanCollide = false
    banana.BrickColor = BrickColor.new("Bright yellow")
    banana.Material = Enum.Material.Neon
    banana.Parent = workspace
    self.EventObjects[#self.EventObjects + 1] = banana
    
    -- Jefe
    local boss = Instance.new("Part")
    boss.Name = "GlorboFruttodrillo"
    boss.Size = Vector3.new(4, 6, 4)
    boss.Position = cavePos + Vector3.new(-15, 3, -15)
    boss.Anchored = true
    boss.BrickColor = BrickColor.new("Bright red")
    boss.Material = Enum.Material.Glass
    boss.Transparency = 0.3
    boss.Parent = workspace
    self.EventObjects[#self.EventObjects + 1] = boss
    
    return cave, banana, boss
end

function EventManager:StartEvent()
    if self.IsActive then
        print("⚠️ El evento ya está activo")
        return
    end
    
    if self.IsOnCooldown then
        print("⚠️ El evento está en cooldown")
        return
    end
    
    self.IsActive = true
    self.StartTime = os.time()
    self.ActivePlayers = {}
    
    print("🌴 ¡EVENTO DE LA JUNGLA INICIADO!")
    self.UI:ShowPanel()
    self.UI:UpdateStatus("📍 ¡Busca el portal dorado!", CONFIG.UI.Colors.Primary)
    
    -- Generar portal y cueva
    task.wait(CONFIG.PortalSpawnDelay)
    self:CreatePortal()
    self:CreateCave()
    
    -- Temporizador
    local duration = CONFIG.EventDuration
    self.CurrentTimer = task.spawn(function()
        while duration > 0 and self.IsActive do
            task.wait(1)
            duration = duration - 1
            self.UI:UpdateTimer(duration)
            self.UI:UpdatePlayers(#self.ActivePlayers)
        end
        if self.IsActive then
            self:EndEvent()
        end
    end)
end

function EventManager:EndEvent()
    if not self.IsActive then return end
    
    self.IsActive = false
    print("⏰ EVENTO DE LA JUNGLA TERMINADO")
    self.UI:HidePanel()
    self.UI:UpdateStatus("⏰ Evento terminado", CONFIG.UI.Colors.Danger)
    
    -- Limpiar objetos
    for _, obj in ipairs(self.EventObjects) do
        if obj and obj.Parent then
            obj:Destroy()
        end
    end
    self.EventObjects = {}
    
    -- Iniciar cooldown
    self.IsOnCooldown = true
    self.CooldownTimer = task.spawn(function()
        local cooldown = CONFIG.EventCooldown
        while cooldown > 0 do
            task.wait(1)
            cooldown = cooldown - 1
        end
        self.IsOnCooldown = false
        print("🌴 Cooldown terminado. ¡Próximo evento disponible!")
    end)
end

function EventManager:HandlePlayerAction(player, action)
    if not self.IsActive then return end
    
    if action == "StealBanana" then
        -- Robar plátano
        local banana = workspace:FindFirstChild("GoldenBanana")
        if banana then
            banana:Destroy()
            self.UI:UpdateStatus("🏃 ¡Huye del jefe!", CONFIG.UI.Colors.Danger)
            
            -- Activar jefe
            local boss = workspace:FindFirstChild("GlorboFruttodrillo")
            if boss then
                self:ActivateBoss(player, boss)
            end
            
            print("🍌 " .. player.Name .. " robó el plátano")
        end
        
    elseif action == "CompleteCourse" then
        -- Completar circuito
        if not self.ActivePlayers[player.UserId] then
            local reward = Utils.GetReward()
            local success = Utils.ApplyReward(player, reward)
            
            if success then
                self.ActivePlayers[player.UserId] = true
                self.UI:ShowReward(reward)
                print("🎁 " .. player.Name .. " obtuvo: " .. reward.Name)
            end
        end
    end
end

function EventManager:ActivateBoss(player, boss)
    -- Script de persecución
    local script = Instance.new("Script")
    script.Source = [[
        local boss = script.Parent
        local player = game.Players:GetPlayerFromCharacter(script.Parent.Parent)
        if not player then return end
        
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        local speed = 16
        local maxSpeed = 35
        
        while boss and hrp and hrp.Parent do
            local direction = (hrp.Position - boss.Position).Unit
            boss.Position = boss.Position + direction * speed * 0.1
            
            if speed < maxSpeed then
                speed = speed + 0.5
            end
            
            if (boss.Position - hrp.Position).Magnitude < 3 then
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.Health = 0
                end
                break
            end
            
            task.wait(0.1)
        end
    ]]
    script.Parent = boss
end

-- ============================================
-- 6. CONFIGURAR REMOTEEVENTS
-- ============================================

local function SetupRemotes(eventManager)
    local remote = Instance.new("RemoteEvent")
    remote.Name = "JungleEventRemote"
    remote.Parent = game:GetService("ReplicatedStorage")
    
    remote.OnServerEvent:Connect(function(player, action)
        eventManager:HandlePlayerAction(player, action)
    end)
    
    return remote
end

-- ============================================
-- 7. COMANDOS PARA DELTA
-- ============================================

local function SetupCommands(eventManager)
    _G.StartJungleEvent = function()
        eventManager:StartEvent()
    end
    
    _G.StopJungleEvent = function()
        eventManager:EndEvent()
    end
    
    _G.GetEventStatus = function()
        local status = eventManager:GetStatus()
        print("📊 Estado del evento:")
        print("  Activo: " .. tostring(status.IsActive))
        print("  En cooldown: " .. tostring(status.IsOnCooldown))
        print("  Jugadores: " .. status.PlayerCount)
        print("  Tiempo restante: " .. status.TimeLeft .. "s")
        return status
    end
    
    print("📌 Comandos disponibles:")
    print("  _G.StartJungleEvent() - Inicia el evento")
    print("  _G.StopJungleEvent() - Termina el evento")
    print("  _G.GetEventStatus() - Muestra el estado")
end

-- ============================================
-- 8. INICIALIZACIÓN PRINCIPAL
-- ============================================

print("🌴 Inicializando Jungle Event...")

-- Crear UI
local ui = UIManager.new()

-- Crear gestor de eventos
local eventManager = EventManager.new(ui)

-- Configurar remotes
SetupRemotes(eventManager)

-- Configurar comandos
SetupCommands(eventManager)

print("✅ Jungle Event cargado correctamente")
print("🌴 Esperando 10 segundos para iniciar...")

-- Iniciar automáticamente
task.wait(10)
_G.StartJungleEvent()

-- ============================================
-- 9. BUCLE DE MANTENIMIENTO
-- ============================================

while true do
    task.wait(60) -- Verificar cada minuto
    if eventManager.IsActive then
        -- Mantener UI actualizada
        local status = eventManager:GetStatus()
        if status.TimeLeft < 60 then
            ui:UpdateStatus("⚠️ ¡El evento está por terminar!", CONFIG.UI.Colors.Danger)
        end
    end
end

-- ============================================
-- FIN DEL SCRIPT
-- ============================================
