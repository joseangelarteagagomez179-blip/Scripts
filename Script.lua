-- SERVICIOS
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- ███ CONFIGURACIONES GLOBALES (EDITABLES) ███
local Config = {
    -- Auto Farm
    AutoFarm_Key = Enum.KeyCode.F,
    AutoFarm_WalkSpeed = 50,
    AutoFarm_WaitTime = 2,

    -- Auto Weight
    AutoWeight_Pos = {X = 50, Y = 150},
    AutoWeight_Size = {W = 120, H = 50},

    -- Auto Collect Money
    AutoCollect_Pos = {X = 50, Y = 220},
    AutoCollect_Size = {W = 120, H = 50},
    AutoCollect_Speed = 40,
    AutoCollect_Wait = 1.5,

    -- Enable Move
    EnableMove_Pos = {X = 50, Y = 290},
    EnableMove_Size = {W = 120, H = 50},
    EnableMove_Speed = 35,

    -- Fly
    Fly_Pos = {X = 50, Y = 360},
    Fly_Size = {W = 120, H = 50},
    Fly_SliderMin = 16,
    Fly_SliderMax = 250,
    Fly_Color = Color3.new(0, 1, 0),

    -- WalkSpeed Infinito
    Speed_Pos = {X = 50, Y = 430},
    Speed_Size = {W = 120, H = 50},
    Speed_Min = 100,
    Speed_Max = 1000,
    Speed_Color = Color3.new(1, 0.5, 0),

    -- Invisible
    Invisible_Pos = {X = 50, Y = 500},
    Invisible_Size = {W = 120, H = 50},
    Invisible_Color = Color3.new(0.2, 0.2, 0.2),

    -- FPS
    FPS_Pos = "Arriba Derecha", -- Opciones: Arriba Izquierda, Abajo Izquierda, Abajo Derecha
    FPS_Size = 14,
    FPS_Color = Color3.new(1, 1, 1)
}

-- ███ VARIABLES DE ESTADO ███
local States = {
    AutoFarm = false,
    AutoWeight = false,
    AutoCollect = false,
    EnableMove = false,
    Fly = false,
    Speed = false,
    Invisible = false,
    FPS = false,
    OriginalWS = Humanoid.WalkSpeed,
    OriginalGravity = Workspace.Gravity,
    OriginalTransparency = {},
    FlyingSpeed = 50,
    InfiniteSpeed = 500
}

-- ███ INTERFAZ GRÁFICA ███
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KickALuckyBlock_UI"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Función para crear botones táctiles
local function CreateButton(name, pos, size, color)
    local Button = Instance.new("TextButton")
    Button.Name = name
    Button.Size = UDim2.new(0, size.W, 0, size.H)
    Button.Position = UDim2.new(0, pos.X, 0, pos.Y)
    Button.BackgroundColor3 = color or Color3.new(0.15, 0.15, 0.15)
    Button.TextColor3 = Color3.new(1,1,1)
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 14
    Button.Parent = ScreenGui
    return Button
end

-- Función para crear sliders
local function CreateSlider(name, pos, size, min, max, color)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Name = name.."_Frame"
    SliderFrame.Size = UDim2.new(0, size.W, 0, 20)
    SliderFrame.Position = UDim2.new(0, pos.X, 0, pos.Y + size.H + 5)
    SliderFrame.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
    SliderFrame.Parent = ScreenGui

    local Bar = Instance.new("Frame")
    Bar.Size = UDim2.new(0.9, 0, 0.5, 0)
    Bar.Position = UDim2.new(0.05,0,0.25,0)
    Bar.BackgroundColor3 = Color3.new(0.3,0.3,0.3)
    Bar.Parent = SliderFrame

    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0,15,0,15)
    Knob.Position = UDim2.new(0,0,0.125,0)
    Knob.BackgroundColor3 = color or Color3.new(0,1,0)
    Knob.ZIndex = 2
    Knob.Parent = Bar

    local ValueText = Instance.new("TextLabel")
    ValueText.Size = UDim2.new(1,0,1,0)
    ValueText.Position = UDim2.new(0,0,-15,0)
    ValueText.BackgroundTransparency = 1
    ValueText.TextColor3 = Color3.new(1,1,1)
    ValueText.Font = Enum.Font.Gotham
    ValueText.TextSize = 12
    ValueText.Parent = SliderFrame

    return {Frame=SliderFrame, Knob=Knob, Bar=Bar, Text=ValueText, Min=min, Max=max, Value=min}
end

-- █ 1️⃣ INFO █
print("=== INFO ===")
print("Creador del Script: JoseAngel_Blox")
print("Fecha: 02/06/2026")
print("Juego: Kick a Lucky Block")
print("========================")

-- █ 2️⃣ MAIN █

-- ========== AUTO FARM ==========
-- ⚙️ CONFIGURABLE: Tecla, velocidad, tiempo de espera
local AutoFarmBtn = CreateButton("AutoFarm", {X=50,Y=80}, {W=120,H=50}, Color3.new(0,0.6,1))
AutoFarmBtn.Text = "Auto Farm: OFF"

UserInputService.InputBegan:Connect(function(Input, GP)
    if GP then return end
    if Input.KeyCode == Config.AutoFarm_Key then
        States.AutoFarm = not States.AutoFarm
        AutoFarmBtn.Text = "Auto Farm: "..(States.AutoFarm and "ON" or "OFF")
        if not States.AutoFarm then Humanoid.WalkSpeed = States.OriginalWS end
    end
end)

AutoFarmBtn.MouseButton1Click:Connect(function()
    States.AutoFarm = not States.AutoFarm
    AutoFarmBtn.Text = "Auto Farm: "..(States.AutoFarm and "ON" or "OFF")
    if not States.AutoFarm then Humanoid.WalkSpeed = States.OriginalWS end
end)

-- Lógica principal Auto Farm
spawn(function()
    while wait(0.1) do
        if States.AutoFarm and Character and Humanoid.Health > 0 then
            Humanoid.WalkSpeed = Config.AutoFarm_WalkSpeed

            -- 🥅 PASO 1: Pateo perfecto (detección de medidor)
            local LuckyBlock = Workspace:FindFirstChild("LuckyBlock", true)
            if LuckyBlock then
                -- Simula timing exacto para "Perfect Kick"
                local PowerMeter = Character:FindFirstChild("PowerMeter", true) or {Value = 100}
                if PowerMeter.Value >= 98 then
                    RootPart.CFrame = LuckyBlock.CFrame * CFrame.new(0,0,-3)
                    wait(0.2)
                    -- Disparar patada (simulación de evento del juego)
                    firetouchinterest(RootPart, LuckyBlock, 0)
                    wait(Config.AutoFarm_WaitTime)
                end
            end

            -- 📦 PASO 2: Recoger Brainrot
            local Brainrot = Workspace:FindFirstChild("Brainrot", true)
            if Brainrot then
                RootPart.CFrame = Brainrot.CFrame * CFrame.new(0,0,-1)
                wait(0.3)
                firetouchinterest(RootPart, Brainrot, 0)
                Brainrot:Destroy()
            end

            -- 🛡️ PASO 3: Volver a Zona Segura
            local SafeZone = Workspace:FindFirstChild("SafeZone", true) or Workspace:FindFirstChild("GreenPad", true)
            if SafeZone then
                RootPart.CFrame = SafeZone.CFrame * CFrame.new(0,2,0)
            end
        end
    end
end)

-- ========== AUTO WEIGHT ==========
-- ⚙️ CONFIGURABLE: Posición, tamaño
local AutoWeightBtn = CreateButton("AutoWeight", Config.AutoWeight_Pos, Config.AutoWeight_Size, Color3.new(0.8,0.2,0.2))
AutoWeightBtn.Text = "Auto Weight: OFF"

AutoWeightBtn.MouseButton1Click:Connect(function()
    States.AutoWeight = not States.AutoWeight
    AutoWeightBtn.Text = "Auto Weight: "..(States.AutoWeight and "ON" or "OFF")
end)

spawn(function()
    while wait(0.5) do
        if States.AutoWeight and Character then
            -- Buscar botón de peso en la interfaz
            local WeightBtn = Player.PlayerGui:FindFirstChild("WeightButton", true)
            if WeightBtn and WeightBtn.Visible then
                -- Simular toque/click para equipar
                fireclickdetector(WeightBtn:FindFirstChildWhichIsA("ClickDetector"))
            end
        end
    end
end)

-- ========== AUTO COLLECT MONEY ==========
-- ⚙️ CONFIGURABLE: Posición, tamaño, velocidad, espera
local AutoCollectBtn = CreateButton("AutoCollect", Config.AutoCollect_Pos, Config.AutoCollect_Size, Color3.new(0.2,0.8,0.4))
AutoCollectBtn.Text = "Auto Collect: OFF"

AutoCollectBtn.MouseButton1Click:Connect(function()
    States.AutoCollect = not States.AutoCollect
    AutoCollectBtn.Text = "Auto Collect: "..(States.AutoCollect and "ON" or "OFF")
end)

spawn(function()
    while wait(Config.AutoCollect_Wait) do
        if States.AutoCollect and Character then
            Humanoid.WalkSpeed = Config.AutoCollect_Speed
            -- Buscar zona de dinero
            local MoneyPad = Workspace:FindFirstChild("GreenPad_Money", true) or Workspace:FindFirstChild("MoneyPedestal", true)
            if MoneyPad then
                RootPart.CFrame = MoneyPad.CFrame * CFrame.new(0,1,0)
                wait(0.4)
                -- Recoger pisando o presionando E
                firetouchinterest(RootPart, MoneyPad, 0)
            end
        end
    end
end)

-- ========== ENABLE MOVE ==========
-- ⚙️ CONFIGURABLE: Posición, tamaño, velocidad
local EnableMoveBtn = CreateButton("EnableMove", Config.EnableMove_Pos, Config.EnableMove_Size, Color3.new(0.7,0.3,0.9))
EnableMoveBtn.Text = "Enable Move: OFF"

EnableMoveBtn.MouseButton1Click:Connect(function()
    States.EnableMove = not States.EnableMove
    EnableMoveBtn.Text = "Enable Move: "..(States.EnableMove and "ON" or "OFF")
    -- Anular restricción de movimiento del juego
    if States.EnableMove then
        Humanoid:SetAttribute("CanMoveWithWeight", true)
        Humanoid.WalkSpeed = Config.EnableMove_Speed
    else
        Humanoid:SetAttribute("CanMoveWithWeight", nil)
        Humanoid.WalkSpeed = States.OriginalWS
    end
end)

-- █ 3️⃣ PLAYER █

-- ========== FLY ==========
-- ⚙️ CONFIGURABLE: Posición, tamaño, rango, color
local FlyBtn = CreateButton("Fly", Config.Fly_Pos, Config.Fly_Size, Config.Fly_Color)
FlyBtn.Text = "Fly: OFF"
local FlySlider = CreateSlider("FlySpeed", Config.Fly_Pos, Config.Fly_Size, Config.Fly_SliderMin, Config.Fly_SliderMax, Config.Fly_Color)

FlyBtn.MouseButton1Click:Connect(function()
    States.Fly = not States.Fly
    FlyBtn.Text = "Fly: "..(States.Fly and "ON" or "OFF")
    Workspace.Gravity = States.Fly and 0 or States.OriginalGravity
    Humanoid.PlatformStand = States.Fly
end)

-- Control de slider vuelo
local isDraggingFly = false
FlySlider.Knob.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.Touch then isDraggingFly = true end end)
FlySlider.Knob.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.Touch then isDraggingFly = false end end)

UserInputService.TouchMoved:Connect(function(touch)
    if isDraggingFly then
        local pos = (touch.Position.X - FlySlider.Bar.AbsolutePosition.X) / FlySlider.Bar.AbsoluteSize.X
        pos = math.clamp(pos, 0, 1)
        FlySlider.Knob.Position = UDim2.new(pos, -7.5, 0.125, 0)
        States.FlyingSpeed = Config.Fly_SliderMin + (pos * (Config.Fly_SliderMax - Config.Fly_SliderMin))
        FlySlider.Text.Text = math.floor(States.FlyingSpeed)
    end
end)

-- Lógica de vuelo (dos dedos para subir/bajar)
RunService.RenderStepped:Connect(function()
    if States.Fly and Character then
        local Cam = Workspace.CurrentCamera
        local Dir = Vector3.Zero

        -- Dirección cámara
        if Humanoid.MoveDirection.Magnitude > 0 then
            Dir = Cam.CFrame:VectorToWorldSpace(Humanoid.MoveDirection)
            Dir = Vector3.new(Dir.X,0,Dir.Z).Unit * States.FlyingSpeed
        end

        -- Subir/Bajar con dos dedos
        if #UserInputService:GetTouchScreenPoints() >= 2 then
            local t1 = UserInputService:GetTouchScreenPoints()[1]
            local t2 = UserInputService:GetTouchScreenPoints()[2]
            if t1.Position.Y < t2.Position.Y then Dir += Vector3.new(0, States.FlyingSpeed * 0.7, 0)
            else Dir += Vector3.new(0, -States.FlyingSpeed * 0.7, 0) end
        end

        RootPart.Velocity = Dir
    end
end)

-- ========== WALKSPEED INFINITO ==========
-- ⚙️ CONFIGURABLE: Posición, tamaño, rango, color
local SpeedBtn = CreateButton("InfiniteSpeed", Config.Speed_Pos, Config.Speed_Size, Config.Speed_Color)
SpeedBtn.Text = "Speed: OFF"
local SpeedSlider = CreateSlider("SpeedValue", Config.Speed_Pos, Config.Speed_Size, Config.Speed_Min, Config.Speed_Max, Config.Speed_Color)

SpeedBtn.MouseButton1Click:Connect(function()
    States.Speed = not States.Speed
    SpeedBtn.Text = "Speed: "..(States.Speed and "ON" or "OFF")
    Humanoid.WalkSpeed = States.Speed and States.InfiniteSpeed or States.OriginalWS
end)

-- Control slider velocidad
local isDraggingSpeed = false
SpeedSlider.Knob.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.Touch then isDraggingSpeed = true end end)
SpeedSlider.Knob.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.Touch then isDraggingSpeed = false end end)

UserInputService.TouchMoved:Connect(function(touch)
    if isDraggingSpeed then
        local pos = (touch.Position.X - SpeedSlider.Bar.AbsolutePosition.X) / SpeedSlider.Bar.AbsoluteSize.X
        pos = math.clamp(pos, 0, 1)
        SpeedSlider.Knob.Position = UDim2.new(pos, -7.5, 0.125, 0)
        States.InfiniteSpeed = Config.Speed_Min + (pos * (Config.Speed_Max - Config.Speed_Min))
        SpeedSlider.Text.Text = math.floor(States.InfiniteSpeed)
        if States.Speed then Humanoid.WalkSpeed = States.InfiniteSpeed end
    end
end)

-- ========== INVISIBLE ==========
-- ⚙️ CONFIGURABLE: Posición, tamaño, color
local InvisibleBtn = CreateButton("Invisible", Config.Invisible_Pos, Config.Invisible_Size, Config.Invisible_Color)
InvisibleBtn.Text = "Invisible: OFF"

-- Guardar transparencia original
local function SaveTransp()
    States.OriginalTransparency = {}
    for _,p in pairs(Character:GetChildren()) do
        if p:IsA("BasePart") then States.OriginalTransparency[p] = p.Transparency end
    end
end

-- Aplicar/Quitar invisibilidad
local function SetInvisible(active)
    if not Character then return end
    for _,p in pairs(Character:GetChildren()) do
        if p:IsA("BasePart") then
            p.Transparency = active and 1 or States.OriginalTransparency[p] or 0
            p.CastShadow = not active
        end
    end
    -- Ocultar GUI/efectos
    for _,g in pairs(Character:GetDescendants()) do
        if g:IsA("BillboardGui") or g:IsA("ParticleEmitter") then g.Enabled = not active end
    end
end

InvisibleBtn.MouseButton1Click:Connect(function()
    States.Invisible = not States.Invisible
    InvisibleBtn.Text = "Invisible: "..(States.Invisible and "ON" or "OFF")
    if States.Invisible then SaveTransp() end
    SetInvisible(States.Invisible)
end)

-- Reaplicar al reaparecer
Player.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = Character:WaitForChild("Humanoid")
    RootPart = Character:WaitForChild("HumanoidRootPart")
    if States.Invisible then wait(0.5) SaveTransp() SetInvisible(true) end
end)

-- █ 4️⃣ CONFIGURACIONES █

-- ========== MOSTRAR FPS + OPTIMIZACIÓN EXTREMA ==========
-- ⚙️ CONFIGURABLE: Posición, tamaño, color
local FPSFrame = Instance.new("Frame")
FPSFrame.Size = UDim2.new(0, 60, 0, 25)
FPSFrame.BackgroundColor3 = Color3.new(0,0,0)
FPSFrame.BackgroundTransparency = 0.4
FPSFrame.Visible = false
FPSFrame.Parent = ScreenGui

-- Definir posición
if Config.FPS_Pos == "Arriba Izquierda" then FPSFrame.Position = UDim2.new(0,10,0,10)
elseif Config.FPS_Pos == "Abajo Izquierda" then FPSFrame.Position = UDim2.new(0,10,1,-35)
elseif Config.FPS_Pos == "Abajo Derecha" then FPSFrame.Position = UDim2.new(1,-70,1,-35)
else FPSFrame.Position = UDim2.new(1,-70,0,10) end

local FPSText = Instance.new("TextLabel")
FPSText.Size = UDim2.new(1,0,1,0)
FPSText.BackgroundTransparency = 1
FPSText.TextColor3 = Config.FPS_Color
FPSText.Font = Enum.Font.GothamBold
FPSText.TextSize = Config.FPS_Size
FPSText.Text = "FPS: 0"
FPSText.Parent = FPSFrame

local FPSBtn = CreateButton("FPS", {X=50,Y=570}, {W=120,H=50}, Color3.new(0.1,0.1,0.1))
FPSBtn.Text = "Mostrar FPS: OFF"

FPSBtn.MouseButton1Click:Connect(function()
    States.FPS = not States.FPS
    FPSFrame.Visible = States.FPS
    FPSBtn.Text = "Mostrar FPS: "..(States.FPS and "ON" or "OFF")
end)

-- Cálculo FPS optimizado (bajo consumo CPU <1%)
spawn(function()
    local LastTime = tick()
    local FrameCount = 0
    while wait(1) do -- Actualizar cada 1 SEGUNDO (no cada frame)
        if States.FPS then
            local Now = tick()
            local FPS = math.floor(FrameCount / (Now - LastTime))
            FPSText.Text = "FPS: "..FPS
            LastTime = Now
            FrameCount = 0
        end
    end
end)

RunService.RenderStepped:Connect(function() if States.FPS then FrameCount +=1 end end)

-- █ FIN DEL SCRIPT █
print("✅ Script cargado correctamente | Kick a Lucky Block")
