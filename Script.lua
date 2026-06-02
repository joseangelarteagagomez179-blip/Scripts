-- ⚠️ PROTECCIÓN DE JUEGO - SOLO KICK A LUCKY BLOCK
local ID_JUEGO = 89469502395769
if game.GameId ~= ID_JUEGO then
    warn("❌ Este script es exclusivo para Kick a lucky block")
    return
end

-- ✅ SCRIPT CREADO PARA: JoseAngel_Blox Scripts
-- 📱 ADAPTADO PARA CELULAR + AUTO CLICK X2
-- 🎨 SERVICIOS NECESARIOS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")
local VirtualInputManager = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- 🔧 VARIABLES PRINCIPALES
local Config = {
    AutoFarm = false,
    AutoWeight = false,
    AutoCollect = false,
    AutoClick = false, -- ✅ NUEVO: AUTO CLICK X2
    Fly = false,
    Invisible = false,
    ShowFPS = false,
    WalkSpeed = 16,
    OriginalSpeed = 16,
    OriginalGravity = Workspace.Gravity
}

local Flying = false
local FlySpeed = 50
local FPS = 0
local LastTime = tick()
local Frames = 0

-- 📌 INTERFAZ ADAPTADA A CELULAR (Botones más grandes)
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "JoseAngel_Blox_Scripts"
MainGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
MainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
MainGui.ResetOnSpawn = false
MainGui.DisplayOrder = 999

-- FONDO PRINCIPAL CON DISEÑO
local Background = Instance.new("Frame")
Background.Name = "FondoPrincipal"
Background.Parent = MainGui
Background.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
Background.Position = UDim2.new(0.02, 0, 0.02, 0)
Background.Size = UDim2.new(0, 300, 0, 450) -- Más alto para celular
Background.BorderSizePixel = 0
Background.Active = true
Background.Draggable = true -- Se mueve con el dedo

-- BORDE DECORATIVO
local Borde = Instance.new("UIStroke")
Borde.Parent = Background
Borde.Color = Color3.fromRGB(80, 120, 255)
Borde.Thickness = 2
Borde.Transparency = 0.2

-- ESQUINAS REDONDEADAS
local Esquinas = Instance.new("UICorner")
Esquinas.Parent = Background
Esquinas.CornerRadius = UDim.new(0, 15)

-- TÍTULO DEL SCRIPT
local Titulo = Instance.new("TextLabel")
Titulo.Parent = Background
Titulo.Text = "✨ JoseAngel_Blox ✨"
Titulo.Font = Enum.Font.GothamBold
Titulo.TextColor3 = Color3.fromRGB(255, 255, 255)
Titulo.TextSize = 18
Titulo.BackgroundTransparency = 1
Titulo.Size = UDim2.new(1, 0, 0, 40)
Titulo.Position = UDim2.new(0, 0, 0, 5)

-- SUBTÍTULO
local Subtitulo = Instance.new("TextLabel")
Subtitulo.Parent = Background
Subtitulo.Text = "📱 Para Celular | Kick a Block"
Subtitulo.Font = Enum.Font.Gotham
Subtitulo.TextColor3 = Color3.fromRGB(180, 180, 255)
Subtitulo.TextSize = 13
Subtitulo.BackgroundTransparency = 1
Subtitulo.Size = UDim2.new(1, 0, 0, 20)
Subtitulo.Position = UDim2.new(0, 0, 0, 30)

-- CONTENEDOR DE OPCIONES
local Contenedor = Instance.new("ScrollingFrame")
Contenedor.Parent = Background
Contenedor.BackgroundTransparency = 1
Contenedor.Size = UDim2.new(1, -15, 1, -60)
Contenedor.Position = UDim2.new(0, 7, 0, 60)
Contenedor.ScrollBarThickness = 5
Contenedor.ScrollBarImageColor3 = Color3.fromRGB(80, 120, 255)
Contenedor.CanvasSize = UDim2.new(0, 0, 2.2, 0)

-- FUNCIÓN PARA CREAR BOTONES GRANDES (PARA DEDO)
local function CrearBoton(nombre, posicion, estado)
    local Boton = Instance.new("TextButton")
    Boton.Parent = Contenedor
    Boton.Text = nombre .. ": " .. (estado and "ON ✅" or "OFF ❌")
    Boton.Font = Enum.Font.GothamBold
    Boton.TextColor3 = Color3.fromRGB(255, 255, 255)
    Boton.TextSize = 14 -- Texto más grande
    Boton.BackgroundColor3 = estado and Color3.fromRGB(40, 120, 255) or Color3.fromRGB(30, 30, 50)
    Boton.Size = UDim2.new(1, -10, 0, 45) -- Botones más altos para celular
    Boton.Position = UDim2.new(0, 5, 0, posicion)
    Boton.BorderSizePixel = 0
    Boton.AutoButtonColor = false

    local EsquinaBoton = Instance.new("UICorner")
    EsquinaBoton.Parent = Boton
    EsquinaBoton.CornerRadius = UDim.new(0, 8)

    -- Efecto al tocar
    Boton.MouseButton1Down:Connect(function()
        Boton.BackgroundColor3 = Color3.fromRGB(60, 150, 255)
    end)

    return Boton
end

-- FUNCIÓN PARA CREAR BARRA DE VELOCIDAD
local function CrearBarra(posicion)
    local Marco = Instance.new("Frame")
    Marco.Parent = Contenedor
    Marco.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    Marco.Size = UDim2.new(1, -10, 0, 45)
    Marco.Position = UDim2.new(0, 5, 0, posicion)
    Marco.BorderSizePixel = 0

    local Esquina = Instance.new("UICorner")
    Esquina.Parent = Marco
    Esquina.CornerRadius = UDim.new(0, 8)

    local Etiqueta = Instance.new("TextLabel")
    Etiqueta.Parent = Marco
    Etiqueta.Text = "Velocidad: " .. Config.WalkSpeed
    Etiqueta.Font = Enum.Font.GothamSemibold
    Etiqueta.TextColor3 = Color3.fromRGB(255, 255, 255)
    Etiqueta.TextSize = 13
    Etiqueta.BackgroundTransparency = 1
    Etiqueta.Position = UDim2.new(0, 10, 0, 0)
    Etiqueta.Size = UDim2.new(1, -20, 1, 0)

    local Entrada = Instance.new("TextBox")
    Entrada.Parent = Marco
    Entrada.Text = ""
    Entrada.Font = Enum.Font.Gotham
    Entrada.TextColor3 = Color3.fromRGB(200, 200, 200)
    Entrada.PlaceholderText = "Ej: 80"
    Entrada.TextSize = 13
    Entrada.BackgroundColor3 = Color3.fromRGB(45, 45, 70)
    Entrada.Size = UDim2.new(0, 80, 0, 30)
    Entrada.Position = UDim2.new(1, -90, 0.5, -15)
    Entrada.ClearTextOnFocus = true

    local EsquinaInput = Instance.new("UICorner")
    EsquinaInput.Parent = Entrada
    EsquinaInput.CornerRadius = UDim.new(0, 6)

    Entrada.FocusLost:Connect(function(enter)
        if enter then
            local num = tonumber(Entrada.Text)
            if num and num > 0 then
                Config.WalkSpeed = num
                Etiqueta.Text = "Velocidad: " .. num
                if not Config.Fly then Humanoid.WalkSpeed = num end
            end
            Entrada.Text = ""
        end
    end)

    return Marco
end

-- 📊 MOSTRADOR DE FPS
local FPSLabel = Instance.new("TextLabel")
FPSLabel.Parent = MainGui
FPSLabel.Text = "FPS: 0"
FPSLabel.Font = Enum.Font.GothamBold
FPSLabel.TextColor3 = Color3.fromRGB(80, 255, 120)
FPSLabel.TextSize = 15
FPSLabel.BackgroundTransparency = 0.5
FPSLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
FPSLabel.Size = UDim2.new(0, 70, 0, 30)
FPSLabel.Position = UDim2.new(0.85, 0, 0.02, 0)
FPSLabel.Visible = false

-- 🚀 OPTIMIZACIÓN PARA CELULAR (MÁS FUERTE)
local function OptimizarJuego()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    settings().Rendering.LimitFramerate = true -- Limita para menos calor
    Workspace.GlobalShadows = false
    Workspace.FogEnd = 500
    Workspace.Lighting.Brightness = 1

    -- Borra todo lo que no sirva
    for _, objeto in pairs(Workspace:GetDescendants()) do
        if objeto:IsA("ParticleEmitter") or objeto:IsA("Trail") or objeto:IsA("Sparkles") then
            objeto:Destroy()
        end
        if objeto:IsA("BasePart") then
            objeto.Material = Enum.Material.Plastic
            objeto.Reflectance = 0
        end
    end
end

-- 🧠 FUNCIONES PRINCIPALES

-- ✅ AUTO CLICK X2 (Doble velocidad de toque)
local function AutoClickLoop()
    while task.wait(0.05) do -- 20 veces por segundo = x2 velocidad
        if Config.AutoClick and Humanoid and Humanoid.Health > 0 then
            -- Simula toque en pantalla
            pcall(function()
                local Cam = Workspace.CurrentCamera
                local Ray = Ray.new(Cam.CFrame.Position, Cam.CFrame.LookVector * 100)
                local Parte = Workspace:FindPartOnRay(Ray, Character)
                if Parte then
                    fireclickdetector(Parte:FindFirstChildOfClass("ClickDetector"))
                end
            end)
        end
    end
end

-- AUTO FARM
local function AutoFarmLoop()
    while task.wait(0.3) do
        if Config.AutoFarm and Character and Humanoid and Humanoid.Health > 0 then
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("Part") and string.lower(obj.Name):find("lucky") and obj:FindFirstAncestorWhichIsA("Model") then
                    if (obj.Position - RootPart.Position).Magnitude < 60 then
                        Humanoid:MoveTo(obj.Position)
                        pcall(function() fireclickdetector(obj:FindFirstChildOfClass("ClickDetector")) end)
                        break
                    end
                end
            end
        end
    end
end

-- AUTO WEIGHT
local function AutoWeightLoop()
    while task.wait(1) do
        if Config.AutoWeight then
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("Part") and (string.lower(obj.Name):find("weight") or string.lower(obj.Name):find("strength")) then
                    if (obj.Position - RootPart.Position).Magnitude < 25 then
                        pcall(function() fireclickdetector(obj:FindFirstChildOfClass("ClickDetector")) end)
                    end
                end
            end
        end
    end
end

-- AUTO COLECTAR DINERO
local function AutoCollectLoop()
    while task.wait(0.2) do
        if Config.AutoCollect and Character then
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("Part") and (string.lower(obj.Name):find("coin") or string.lower(obj.Name):find("money") or string.lower(obj.Name):find("cash")) then
                    if (obj.Position - RootPart.Position).Magnitude < 40 then
                        RootPart.CFrame = RootPart.CFrame + (obj.Position - RootPart.Position).Unit * ((obj.Position - RootPart.Position).Magnitude - 5)
                        task.wait(0.1)
                    end
                end
            end
        end
    end
end

-- SISTEMA DE VUELO PARA CELULAR
local function ActivarVuelo(estado)
    Flying = estado
    Humanoid.PlatformStand = estado
    Humanoid.WalkSpeed = estado and 0 or Config.WalkSpeed

    if estado then
        if RootPart:FindFirstChild("FlyVel") then RootPart.FlyVel:Destroy() end
        local ControlVuelo = Instance.new("BodyVelocity")
        ControlVuelo.Name = "FlyVel"
        ControlVuelo.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        ControlVuelo.Velocity = Vector3.new(0,0,0)
        ControlVuelo.Parent = RootPart

        RunService.RenderStepped:Connect(function()
            if not Flying or not RootPart:FindFirstChild("FlyVel") then return end
            local Cam = Workspace.CurrentCamera
            -- Se controla con la palanca de movimiento del juego
            local Movimiento = Humanoid.MoveDirection
            if Movimiento.Magnitude > 0 then
                RootPart.FlyVel.Velocity = (Cam.CFrame * Vector3.new(Movimiento.X, 0, Movimiento.Z) * FlySpeed + Vector3.new(0, Movimiento.Y * 30, 0)).Position
            else
                RootPart.FlyVel.Velocity = Vector3.new(0,0,0)
            end
        end)
    else
        if RootPart:FindFirstChild("FlyVel") then RootPart.FlyVel:Destroy() end
    end
end

-- INVISIBILIDAD
local function HacerInvisible(estado)
    if Character then
        for _, parte in pairs(Character:GetDescendants()) do
            if parte:IsA("BasePart") or parte:IsA("Decal") or parte:IsA("Texture") then
                parte.Transparency = estado and 1 or 0
            end
        end
        Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    end
end

-- ACTUALIZADOR DE FPS
RunService.RenderStepped:Connect(function()
    Frames += 1
    if tick() - LastTime >= 1 then
        FPS = Frames
        Frames = 0
        LastTime = tick()
        if Config.ShowFPS then FPSLabel.Text = "FPS: " .. FPS end
    end
end)

-- 🔘 BOTONES CONECTADOS
local BotonFarm = CrearBoton("🔄 Auto Farm", 10, Config.AutoFarm)
BotonFarm.MouseButton1Click:Connect(function()
    Config.AutoFarm = not Config.AutoFarm
    BotonFarm.Text = "🔄 Auto Farm: " .. (Config.AutoFarm and "ON ✅" or "OFF ❌")
    BotonFarm.BackgroundColor3 = Config.AutoFarm and Color3.fromRGB(40, 120, 255) or Color3.fromRGB(30, 30, 50)
end)

local BotonWeight = CrearBoton("🏋️ Auto Weight", 60, Config.AutoWeight)
BotonWeight.MouseButton1Click:Connect(function()
    Config.AutoWeight = not Config.AutoWeight
    BotonWeight.Text = "🏋️ Auto Weight: " .. (Config.AutoWeight and "ON ✅" or "OFF ❌")
    BotonWeight.BackgroundColor3 = Config.AutoWeight and Color3.fromRGB(40, 120, 255) or Color3.fromRGB(30, 30, 50)
end)

local BotonCollect = CrearBoton("💰 Auto Collect", 110, Config.AutoCollect)
BotonCollect.MouseButton1Click:Connect(function()
    Config.AutoCollect = not Config.AutoCollect
    BotonCollect.Text = "💰 Auto Collect: " .. (Config.AutoCollect and "ON ✅" or "OFF ❌")
    BotonCollect.BackgroundColor3 = Config.AutoCollect and Color3.fromRGB(40, 120, 255) or Color3.fromRGB(30, 30, 50)
end)

-- ✅ NUEVO BOTÓN: AUTO CLICK X2
local BotonClick = CrearBoton("🖱️ Auto Click X2", 160, Config.AutoClick)
BotonClick.MouseButton1Click:Connect(function()
    Config.AutoClick = not Config.AutoClick
    BotonClick.Text = "🖱️ Auto Click X2: " .. (Config.AutoClick and "ON ✅" or "OFF ❌")
    BotonClick.BackgroundColor3 = Config.AutoClick and Color3.fromRGB(255, 80, 80) or Color3.fromRGB(30, 30, 50)
end)

CrearBarra(210)

local BotonFly = CrearBoton("✈️ Volar", 260, Config.Fly)
BotonFly.MouseButton1Click:Connect(function()
    Config.Fly = not Config.Fly
    ActivarVuelo(Config.Fly)
    BotonFly.Text = "✈️ Volar: " .. (Config.Fly and "ON ✅" or "OFF ❌")
    BotonFly.BackgroundColor3 = Config.Fly and Color3.fromRGB(40, 120, 255) or Color3.fromRGB(30, 30, 50)
end)

local BotonInvisible = CrearBoton("👻 Invisible", 310, Config.Invisible)
BotonInvisible.MouseButton1Click:Connect(function()
    Config.Invisible = not Config.Invisible
    HacerInvisible(Config.Invisible)
    BotonInvisible.Text = "👻 Invisible: " .. (Config.Invisible and "ON ✅" or "OFF ❌")
    BotonInvisible.BackgroundColor3 = Config.Invisible and Color3.fromRGB(40, 120, 255) or Color3.fromRGB(30, 30, 50)
end)

local BotonFPS = CrearBoton("📊 Ver FPS", 360, Config.ShowFPS)
BotonFPS.MouseButton1Click:Connect(function()
    Config.ShowFPS = not Config.ShowFPS
    FPSLabel.Visible = Config.ShowFPS
    BotonFPS.Text = "📊 Ver FPS: " .. (Config.ShowFPS and "ON ✅" or "OFF ❌")
    BotonFPS.BackgroundColor3 = Config.ShowFPS and Color3.fromRGB(40, 120, 255) or Color3.fromRGB(30, 30, 50)
end)

local BotonOptimizar = CrearBoton("⚡ Quitar Lag", 410, true)
BotonOptimizar.MouseButton1Click:Connect(function()
    OptimizarJuego()
    BotonOptimizar.Text = "✅ Optimizado"
    BotonOptimizar.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
    StarterGui:SetCore("SendNotification", {Title="JoseAngel_Blox", Text="Celular optimizado ✅", Duration=2})
end)

-- 🔄 REGENERACIÓN
LocalPlayer.CharacterAdded:Connect(function(nuevoChar)
    Character = nuevoChar
    Humanoid = nuevoChar:WaitForChild("Humanoid")
    RootPart = nuevoChar:WaitForChild("HumanoidRootPart")
    if Config.Fly then ActivarVuelo(true) end
    if Config.Invisible then HacerInvisible(true) end
    Humanoid.WalkSpeed = Config.WalkSpeed
end)

-- ⚡ INICIAR TODOS LOS SISTEMAS
task.spawn(AutoFarmLoop)
task.spawn(AutoWeightLoop)
task.spawn(AutoCollectLoop)
task.spawn(AutoClickLoop) -- ✅ ACTIVADO EL AUTO CLICK

-- 📢 MENSAJE DE INICIO
StarterGui:SetCore("SendNotification", {
    Title = "JoseAngel_Blox Scripts",
    Text = "📱 Cargado para Celular | Kick a Block",
    Duration = 3
})
