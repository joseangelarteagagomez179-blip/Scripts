-- Nombre del Script: JoseAngel_Blox Scripts
-- Creador: JoseAngel_Blox
-- Fecha de creación: 02/06/2026
-- Compatibilidad: Delta Executor
-- Juego: Kick A Lucky Block | ID: 89469502395769

-- Servicios necesarios
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = Workspace.CurrentCamera

-- Jugador local
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Variables de configuración
local Config = {
    -- Main
    AutoFarm = false,
    AutoWeight = false,
    AutoCollectMoney = false,
    EnableMove = false,
    WalkSpeed = 16,

    -- Player
    Fly = false,
    FlySpeed = 50,
    Invisible = false,

    -- Configuración general
    ShowFPS = false,
    OptimizeGame = true
}

-- Zona segura ajustada para Kick A Lucky Block (posición general, se ajusta sola)
local SafeZone = Workspace:FindFirstChild("SafeZone") or Workspace:FindFirstChild("SpawnLocation")
local SafeZonePosition = SafeZone and SafeZone.Position or Vector3.new(0, 5, 0)

-- INTERFAZ GRÁFICA
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-main/main/Universe.lua"))() -- Biblioteca ligera y compatible con Delta
local Window = Library:CreateWindow({
    Title = "JoseAngel_Blox Scripts",
    Subtitle = "Kick A Lucky Block | Optimizado",
    Size = UDim2.new(0, 500, 0, 400),
    Theme = "Dark"
})

-- Pestaña INFO
local InfoTab = Window:AddTab("Info")
InfoTab:AddLabel("📌 Nombre del creador: JoseAngel_Blox")
InfoTab:AddLabel("📅 Fecha de creación: 02/06/2026")
InfoTab:AddLabel("🎮 Juego: Kick A Lucky Block")
InfoTab:AddLabel("⚙️ Versión: 1.0 | Delta Executor")

-- Pestaña MAIN
local MainTab = Window:AddTab("Main")
MainTab:AddToggle("Auto Farm", function(state)
    Config.AutoFarm = state
end)
MainTab:AddSlider("Velocidad de caminata", 16, 120, Config.WalkSpeed, function(value)
    Config.WalkSpeed = value
    if not Config.Fly then Humanoid.WalkSpeed = value end
end)
MainTab:AddToggle("Auto Weight", function(state)
    Config.AutoWeight = state
end)
MainTab:AddToggle("Auto Collect Money", function(state)
    Config.AutoCollectMoney = state
end)
MainTab:AddToggle("Enable Move (Moverse con pesa)", function(state)
    Config.EnableMove = state
end)

-- Pestaña PLAYER
local PlayerTab = Window:AddTab("Player")
PlayerTab:AddToggle("Volar", function(state)
    Config.Fly = state
    if state then ActivateFly() else DeactivateFly() end
end)
PlayerTab:AddSlider("Velocidad de vuelo", 10, 200, Config.FlySpeed, function(value)
    Config.FlySpeed = value
end)
PlayerTab:AddToggle("Invisible", function(state)
    Config.Invisible = state
    for _, v in pairs(Character:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("Decal") or v:IsA("Shirt") or v:IsA("Pants") then
            v.LocalTransparencyModifier = state and 1 or 0
        end
    end
end)
PlayerTab:AddToggle("Velocidad máxima", function(state)
    Config.WalkSpeed = state and 120 or 16
    Humanoid.WalkSpeed = Config.WalkSpeed
end)

-- Pestaña CONFIGURACIÓN
local ConfigTab = Window:AddTab("Configuración")
ConfigTab:AddToggle("Mostrar FPS", function(state)
    Config.ShowFPS = state
end)
ConfigTab:AddToggle("Optimizar juego (Sin Lag)", function(state)
    Config.OptimizeGame = state
    if state then OptimizeGame() end
end)

-- ==============================================
--                FUNCIONES PRINCIPALES
-- ==============================================

-- ✅ AUTO FARM: Patear Lucky Block y volver a zona segura
local function AutoFarmLoop()
    while task.wait(0.3) do
        if not Config.AutoFarm then continue end

        -- Buscar Lucky Block (nombre exacto del juego)
        local luckyBlock = Workspace:FindFirstChildWhichIsA("Part", true)
        if luckyBlock and luckyBlock.Name:lower():find("lucky") and not luckyBlock:IsAncestorOf(Character) then
            -- Ir hacia el bloque para patearlo
            RootPart.CFrame = CFrame.new(luckyBlock.Position + Vector3.new(0, 1, 3)) -- Ponerse enfrente
            task.wait(0.15)
            
            -- Simular el golpe / patada
            Humanoid:Jump()
            task.wait(0.1)
            -- Enviar evento de golpe (ajustado al juego)
            if ReplicatedStorage:FindFirstChild("Events") and ReplicatedStorage.Events:FindFirstChild("Kick") then
                ReplicatedStorage.Events.Kick:FireServer(luckyBlock)
            end

            -- Volver a Zona Segura
            task.wait(0.2)
            RootPart.CFrame = CFrame.new(SafeZonePosition + Vector3.new(0, 2, 0))
        end

        -- Mantener velocidad
        if not Config.Fly then Humanoid.WalkSpeed = Config.WalkSpeed end
    end
end

-- ✅ AUTO WEIGHT: Equipar pesa automáticamente
local function AutoWeightLoop()
    while task.wait(0.8) do
        if not Config.AutoWeight then continue end

        -- Buscar pesas / pesos en el mapa
        local weight = Workspace:FindFirstChildWhichIsA("Tool", true) or Workspace:FindFirstChildWhichIsA("Model", true)
        if weight and (weight.Name:lower():find("weight") or weight.Name:lower():find("pesa") or weight.Name:lower():find("dumbbell")) then
            if not Character:FindFirstChild(weight.Name) then
                -- Recoger automáticamente
                local click = weight:FindFirstChildOfClass("ClickDetector")
                if click then fireclickdetector(click) end
                -- Si usa proximidad
                local prompt = weight:FindFirstChildOfClass("ProximityPrompt")
                if prompt then fireproximityprompt(prompt) end
            end
        end
    end
end

-- ✅ AUTO COLLECT MONEY: Teletransportarse a Brainrots / Dinero
local function AutoCollectMoneyLoop()
    while task.wait(0.4) do
        if not Config.AutoCollectMoney then continue end

        -- Buscar monedas, dinero o los llamados Brainrots
        local moneyObj = Workspace:FindFirstChildWhichIsA("Part", true) or Workspace:FindFirstChildWhichIsA("Model", true)
        if moneyObj and (moneyObj.Name:lower():find("coin") or moneyObj.Name:lower():find("money") or moneyObj.Name:lower():find("brainrot")) then
            -- Ir directo a recoger
            RootPart.CFrame = CFrame.new(moneyObj.Position + Vector3.new(0, 1, 0))
            task.wait(0.05)
            -- Recoger
            if moneyObj:FindFirstChildOfClass("TouchTransmitter") then
                firetouchinterest(RootPart, moneyObj, 0)
                firetouchinterest(RootPart, moneyObj, 1)
            end
        end
    end
end

-- ✅ ENABLE MOVE: Moverse con pesa equipada (sin restricción)
local function EnableMoveSystem()
    RunService.Stepped:Connect(function()
        if Config.EnableMove then
            -- Si tienes herramienta/pesa en mano, quitar la restricción de movimiento
            if Humanoid and Character:FindFirstChildOfClass("Tool") then
                Humanoid.WalkSpeed = Config.WalkSpeed
                Humanoid.JumpPower = 50
                Humanoid.JumpHeight = 7.5
                -- Evitar que el juego te bloquee
                pcall(function() Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false) end)
            end
        end
    end)
end

-- ✅ SISTEMA DE VUELO
local Velocity = Instance.new("BodyVelocity")
Velocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
Velocity.Velocity = Vector3.new(0,0,0)

function ActivateFly()
    Velocity.Parent = RootPart
    Humanoid.PlatformStand = true
end

function DeactivateFly()
    Velocity.Parent = nil
    Humanoid.PlatformStand = false
end

RunService.RenderStepped:Connect(function()
    if not Config.Fly then return end
    local cam = Camera.CFrame
    local move = Vector3.new()

    if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += cam.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= cam.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= cam.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += cam.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0,1,0) end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0,1,0) end

    Velocity.Velocity = move * Config.FlySpeed
end)

-- ✅ OPTIMIZACIÓN PARA NO LAG
function OptimizeGame()
    -- Gráficos al mínimo
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    settings().Rendering.LimitVideoQuality = true

    -- Desactivar efectos pesados
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") then
            obj.Enabled = false
        end
        if obj:IsA("BasePart") and obj.Material == Enum.Material.Neon then
            obj.Material = Enum.Material.Plastic
        end
    end

    -- Distancia de visión
    Camera.FarPlane = 120
    Camera.FieldOfView = 70
end

-- ✅ MOSTRAR FPS
local FPSGui = Instance.new("ScreenGui")
local FPSLabel = Instance.new("TextLabel")
FPSGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
FPSLabel.Parent = FPSGui
FPSLabel.Size = UDim2.new(0, 80, 0, 25)
FPSLabel.Position = UDim2.new(0.01,0,0.01,0)
FPSLabel.BackgroundColor3 = Color3.new(0,0,0)
FPSLabel.BackgroundTransparency = 0.4
FPSLabel.TextColor3 = Color3.new(1,1,1)
FPSLabel.Font = Enum.Font.GothamBold
FPSLabel.TextSize = 14

RunService.RenderStepped:Connect(function(dt)
    FPSGui.Enabled = Config.ShowFPS
    FPSLabel.Text = "FPS: "..math.floor(1/dt)
end)

-- ==============================================
--                INICIAR SISTEMAS
-- ==============================================
task.spawn(AutoFarmLoop)
task.spawn(AutoWeightLoop)
task.spawn(AutoCollectMoneyLoop)
EnableMoveSystem()

-- Notificación inicial
Library:Notify("JoseAngel_Blox Scripts", "✅ Cargado en Kick A Lucky Block", 4)
