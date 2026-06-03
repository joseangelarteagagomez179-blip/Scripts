-- SCRIPT: Kick a Lucky Block
-- CREADOR: JoseAngel_Blox
-- FECHA: 02/06/2026
-- JUEGO ID: 89469502395769
-- BURBUJA DE CONTROL INCLUIDA

-- 🔒 PROTECCIÓN EXCLUSIVA
if game.GameId ~= 89469502395769 then
    return
end

-- ⚙️ SERVICIOS
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- 👤 DATOS DEL JUGADOR
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- 🔗 CONEXIONES DEL JUEGO
local Remotes = ReplicatedStorage:WaitForChild("Remotes", 15) or ReplicatedStorage
local RemoteKick = Remotes:FindFirstChild("Kick") or Remotes:WaitForChild("Patear", 5)
local RemoteCollect = Remotes:FindFirstChild("Collect") or Remotes:WaitForChild("Recolectar", 5)
local RemotePlace = Remotes:FindFirstChild("Place") or Remotes:WaitForChild("Colocar", 5)
local RemoteBuy = Remotes:FindFirstChild("Buy") or Remotes:WaitForChild("Comprar", 5)

-- ⚡ CONFIGURACIÓN GENERAL
local Config = {
    -- CONTROL GENERAL
    ScriptActivo = true,
    -- MAIN
    AutoKick = false,
    PerfectKick = false,
    AutoCollect = false,
    AutoPlace = false,
    AutoBuy = false,
    AutoSurvive = false,
    InfiniteStats = false,
    -- PLAYER
    Fly = false,
    WalkSpeed = 35,
    JumpPower = 80,
    -- CONFIGURACIÓN
    AntiAFK = true,
    ShowFPS = false,
    Optimize = false
}

-- 📊 VARIABLES GLOBALES
local FPS = 0
local LastTime = tick()
local Frames = 0
local Flying = false
local PlayerPlot = nil
local MenuActivo = "Main"

-- 🔄 REGENERAR PERSONAJE
LocalPlayer.CharacterAdded:Connect(function(NuevoChar)
    Character = NuevoChar
    Humanoid = NuevoChar:WaitForChild("Humanoid")
    RootPart = NuevoChar:WaitForChild("HumanoidRootPart")
    Humanoid.WalkSpeed = Config.WalkSpeed
    Humanoid.JumpPower = Config.JumpPower
    if Config.Fly and Config.ScriptActivo then ToggleFly(true) end
end)

-- 🚀 FUNCIONES DEL SCRIPT
local function AutoKickLoop()
    while task.wait(0.1) do
        if not Config.ScriptActivo then task.wait(); continue end
        if Config.AutoKick and Humanoid.Health > 0 then
            local Bloque = Workspace:FindFirstChild("LuckyBlock", true) or Workspace:FindFirstChild("Block", true)
            if Bloque then
                if (Bloque.Position - RootPart.Position).Magnitude > 12 then Humanoid:MoveTo(Bloque.Position) end
                pcall(function()
                    if RemoteKick then
                        local Fuerza = Config.PerfectKick and 100 or math.random(50,95)
                        RemoteKick:FireServer(Bloque, Fuerza)
                    end
                    if Bloque:FindFirstChildOfClass("ClickDetector") then fireclickdetector(Bloque:FindFirstChildOfClass("ClickDetector")) end
                end)
            end
        end
    end
end

local function AutoCollectLoop()
    while task.wait(0.05) do
        if not Config.ScriptActivo then task.wait(); continue end
        if Config.AutoCollect and Humanoid.Health > 0 then
            for _, Obj in pairs(Workspace:GetDescendants()) do
                if Obj:IsA("Part") and (Obj.Name:lower():find("coin") or Obj.Name:lower():find("money") or Obj.Name:lower():find("brainrot")) then
                    if (Obj.Position - RootPart.Position).Magnitude < 50 then
                        RootPart.CFrame = CFrame.new(Obj.Position.X, RootPart.Position.Y+1, Obj.Position.Z)
                        pcall(function() if RemoteCollect then RemoteCollect:FireServer(Obj) end end)
                    end
                end
            end
        end
    end
end

local function AutoPlaceLoop()
    while task.wait(0.5) do
        if not Config.ScriptActivo then task.wait(); continue end
        if Config.AutoPlace and Humanoid.Health > 0 then
            if not PlayerPlot then
                for _, Plot in pairs(Workspace:GetDescendants()) do
                    if Plot:IsA("Model") and Plot.Name:find("Plot") and Plot.Owner and Plot.Owner.Value == LocalPlayer.Name then
                        PlayerPlot = Plot; break
                    end
                end
            end
            if PlayerPlot and ReplicatedStorage:FindFirstChild("Inventory") then
                for _, Item in pairs(ReplicatedStorage.Inventory:GetChildren()) do
                    if Item:IsA("Model") and Item.Name:find("Brainrot") then
                        pcall(function()
                            local Pos = PlayerPlot.Position + Vector3.new(math.random(-8,8), 1, math.random(-8,8))
                            if RemotePlace then RemotePlace:FireServer(Item, Pos) end
                        end)
                    end
                end
            end
        end
    end
end

local function AutoBuyLoop()
    while task.wait(0.4) do
        if not Config.ScriptActivo then task.wait(); continue end
        if Config.AutoBuy then
            for _, Shop in pairs(Workspace:GetDescendants()) do
                if Shop:IsA("Part") and (Shop.Name:lower():find("weight") or Shop.Name:lower():find("upgrade")) then
                    if (Shop.Position - RootPart.Position).Magnitude < 30 then
                        pcall(function()
                            if RemoteBuy then RemoteBuy:FireServer("Strength") RemoteBuy:FireServer("Legs") end
                            if Shop:FindFirstChildOfClass("ClickDetector") then fireclickdetector(Shop:FindFirstChildOfClass("ClickDetector")) end
                        end)
                    end
                end
            end
            if Config.InfiniteStats then
                pcall(function()
                    if LocalPlayer.leaderstats then
                        if LocalPlayer.leaderstats.Strength then LocalPlayer.leaderstats.Strength.Value = 9999999 end
                        if LocalPlayer.leaderstats.Legs then LocalPlayer.leaderstats.Legs.Value = 9999999 end
                        if LocalPlayer.leaderstats.Money then LocalPlayer.leaderstats.Money.Value = 999999999 end
                    end
                end)
            end
        end
    end
end

local function SurviveTsunamiLoop()
    while task.wait(0.2) do
        if not Config.ScriptActivo then task.wait(); continue end
        if Config.AutoSurvive and Humanoid.Health > 0 then
            local Agua = Workspace:FindFirstChild("Tsunami", true) or Workspace:FindFirstChild("Water", true)
            if Agua and Agua.Position.Y > RootPart.Position.Y - 3 then
                RootPart.CFrame = CFrame.new(RootPart.Position.X, 150, RootPart.Position.Z)
                Humanoid.Health = 100
            end
        end
    end
end

local function ToggleFly(Estado)
    Flying = Estado
    Humanoid.PlatformStand = Estado
    Humanoid.WalkSpeed = Estado and 0 or Config.WalkSpeed

    if Estado and Config.ScriptActivo then
        local Vel = Instance.new("BodyVelocity")
        Vel.MaxForce = Vector3.new(1e9,1e9,1e9)
        Vel.Velocity = Vector3.new(0,0,0)
        Vel.Parent = RootPart

        RunService.RenderStepped:Connect(function()
            if not Flying or not Vel:IsDescendantOf(game) or not Config.ScriptActivo then return end
            local Cam = Workspace.CurrentCamera
            local Dir = Humanoid.MoveDirection
            Vel.Velocity = Dir.Magnitude > 0 and (Cam.CFrame * Vector3.new(Dir.X, 0, Dir.Z) * 60 + Vector3.new(0, Dir.Y * 45, 0)).Position or Vector3.new(0,0,0)
        end)
    else
        if RootPart:FindFirstChild("BodyVelocity") then RootPart.BodyVelocity:Destroy() end
    end
end

if Config.AntiAFK then
    task.spawn(function() while task.wait(4) do pcall(function() if Config.ScriptActivo then Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end end) end end)
end

RunService.RenderStepped:Connect(function()
    if not Config.ScriptActivo then return end
    Frames += 1
    if tick() - LastTime >= 1 then FPS = Frames; Frames = 0; LastTime = tick() end
end)

local function Optimizar()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    Workspace.GlobalShadows = false
    Workspace.FogEnd = 800
    game.Lighting.Brightness = 1
    for _, Efecto in pairs(Workspace:GetDescendants()) do
        if Efecto:IsA("ParticleEmitter") or Efecto:IsA("Trail") then Efecto:Destroy() end
    end
end

-- 🟡 BURBUJA FLOTANTE DE ACTIVACIÓN / DESACTIVACIÓN
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox_UI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

local Burbuja = Instance.new("TextButton")
Burbuja.Name = "BurbujaControl"
Burbuja.Parent = ScreenGui
Burbuja.BackgroundColor3 = Color3.fromRGB(45, 200, 120)
Burbuja.Size = UDim2.new(0, 50, 0, 50)
Burbuja.Position = UDim2.new(0.88, 0, 0.40, 0)
Burbuja.Text = "✅"
Burbuja.Font = Enum.Font.GothamBold
Burbuja.TextColor3 = Color3.new(1,1,1)
Burbuja.TextSize = 20
Burbuja.AutoButtonColor = false
Burbuja.ZIndex = 999

local BurbujaCorner = Instance.new("UICorner")
BurbujaCorner.Parent = Burbuja
BurbujaCorner.CornerRadius = UDim.new(1, 0)

local BurbujaStroke = Instance.new("UIStroke")
BurbujaStroke.Parent = Burbuja
BurbujaStroke.Color = Color3.new(1,1,1)
BurbujaStroke.Thickness = 1.5
BurbujaStroke.Transparency = 0.2

local DragToggle, DragInput, DragStart
Burbuja.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.Touch or Input.UserInputType == Enum.UserInputType.MouseButton1 then
        DragToggle = true
        DragStart = Input.Position - Burbuja.AbsolutePosition
    end
end)
Burbuja.InputChanged:Connect(function(Input)
    if DragToggle and (Input.UserInputType == Enum.UserInputType.Touch or Input.UserInputType == Enum.UserInputType.MouseMovement) then
        DragInput = Input.Position - DragStart
        Burbuja.Position = UDim2.new(0, DragInput.X, 0, DragInput.Y)
    end
end)
Burbuja.InputEnded:Connect(function() DragToggle = false end)

Burbuja.MouseButton1Click:Connect(function()
    Config.ScriptActivo = not Config.ScriptActivo
    if Config.ScriptActivo then
        Burbuja.BackgroundColor3 = Color3.fromRGB(45, 200, 120)
        Burbuja.Text = "✅"
        StarterGui:SetCore("SendNotification", {Title = "✅ SCRIPT ACTIVADO", Text = "Todas las funciones trabajan", Duration = 2})
        if Config.Fly then ToggleFly(true) end
    else
        Burbuja.BackgroundColor3 = Color3.fromRGB(220, 45, 45)
        Burbuja.Text = "❌"
        StarterGui:SetCore("SendNotification", {Title = "❌ SCRIPT DESACTIVADO", Text = "Se detuvieron todas las funciones", Duration = 2})
        if Config.Fly then ToggleFly(false) end
    end
end)

-- 🎨 INTERFAZ PRINCIPAL
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MenuPrincipal"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 14, 28)
MainFrame.Position = UDim2.new(0.02, 0, 0.02, 0)
MainFrame.Size = UDim2.new(0, 320, 0, 530)
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.Parent = MainFrame
UICorner.CornerRadius = UDim.new(0, 18)

local UIStroke = Instance.new("UIStroke")
UIStroke.Parent = MainFrame
UIStroke.Color = Color3.fromRGB(65, 105, 255)
UIStroke.Thickness = 2.5

-- 📌 INFORMACIÓN (SE MUESTRA DENTRO DEL JUEGO)
local InfoBar = Instance.new("Frame")
InfoBar.Parent = MainFrame
InfoBar.BackgroundColor3 = Color3.fromRGB(20, 25, 50)
InfoBar.Size = UDim2.new(1, 0, 0, 60)
InfoBar.Position = UDim2.new(0, 0, 0, 0)

local InfoCorner = Instance.new("UICorner")
InfoCorner.Parent = InfoBar
InfoCorner.CornerRadius = UDim.new(0, 18)

local CreatorText = Instance.new("TextLabel")
CreatorText.Parent = InfoBar
CreatorText.Text = "👤 Creador: JoseAngel_Blox"
CreatorText.Font = Enum.Font.GothamBold
CreatorText.TextColor3 = Color3.new(1,1,1)
CreatorText.TextSize = 14
CreatorText.BackgroundTransparency = 1
CreatorText.Size = UDim2.new(1, 0, 0, 30)
CreatorText.Position = UDim2.new(0, 0, 0, 2)

local DateText = Instance.new("TextLabel")
DateText.Parent = InfoBar
DateText.Text = "📅 Fecha: 02/06/2026"
DateText.Font = Enum.Font.GothamSemibold
DateText.TextColor3 = Color3.fromRGB(200, 200, 255)
DateText.TextSize = 12
DateText.BackgroundTransparency = 1
DateText.Size = UDim2.new(1, 0, 0, 25)
DateText.Position = UDim2.new(0, 0, 0, 28)

-- 📂 PESTAÑAS
local TabBar = Instance.new("Frame")
TabBar.Parent = MainFrame
TabBar.BackgroundColor3 = Color3.fromRGB(25, 35, 70)
TabBar.Size = UDim2.new(0.9, 0, 0, 40)
TabBar.Position = UDim2.new(0.05, 0, 0, 70)

local TabCorner = Instance.new("UICorner")
TabCorner.Parent = TabBar
TabCorner.CornerRadius = UDim.new(0, 10)

local function CrearPestaña(Nombre, PosX)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Parent = TabBar
    TabBtn.Text = Nombre
    TabBtn.Font = Enum.Font.GothamBold
    TabBtn.TextColor3 = Color3.new(1,1,1)
    TabBtn.TextSize = 13
    TabBtn.BackgroundColor3 = Color3.fromRGB(40, 60, 180)
    TabBtn.Size = UDim2.new(0.32, 0, 0.85, 0)
    TabBtn.Position = UDim2.new(PosX, 0, 0.075, 0)
    TabBtn.AutoButtonColor = false

    local TabBtnCorner = Instance.new("UICorner")
    TabBtnCorner.Parent = TabBtn
    TabBtnCorner.CornerRadius = UDim.new(0, 8)

    return TabBtn
end

local TabMain = CrearPestaña("MAIN", 0.01)
local TabPlayer = CrearPestaña("PLAYER", 0.34)
local TabConfig = CrearPestaña("CONFIG", 0.67)

-- 📦 CONTENEDOR
local Contenedor = Instance.new("ScrollingFrame")
Contenedor.Parent = MainFrame
Contenedor.BackgroundTransparency = 1
Contenedor.Size = UDim2.new(0.9, 0, 0, 370)
Contenedor.Position = UDim2.new(0.05, 0, 0, 120)
Contenedor.ScrollBarThickness = 4
Contenedor.ScrollBarImageColor3 = Color3.fromRGB(65, 105, 255)
Contenedor.CanvasSize = UDim2.new(0, 0, 0, 450)

local function CrearOpcion(Nombre, PosY, Activo, ColorActivo)
    local Btn = Instance.new("Frame")
    Btn.Parent = Contenedor
    Btn.BackgroundColor3 = Activo and ColorActivo or Color3.fromRGB(30, 35, 60)
    Btn.Size = UDim2.new(1, 0, 0, 46)
    Btn.Position = UDim2.new(0, 0, 0, PosY)

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.Parent = Btn
    BtnCorner.CornerRadius = UDim.new(0, 10)

    local BtnStroke = Instance.new("UIStroke")
    BtnStroke.Parent = Btn
    BtnStroke.Color = Activo and ColorActivo:Lerp(Color3.new(1,1,1), 0.3) or Color3.fromRGB(60, 70, 100)
    BtnStroke.Thickness = 1

    local BtnText = Instance.new("TextLabel")
    BtnText.Parent = Btn
    BtnText.Text = Nombre .. ": " .. (Activo and "ACTIVO ✅" or "INACTIVO ❌")
    BtnText.Font = Enum.Font.GothamSemibold
    BtnText.TextColor3 = Color3.new(1,1,1)
    BtnText.TextSize = 14
    BtnText.BackgroundTransparency = 1
    BtnText.Size = UDim2.new(1, 0, 1, 0)

    local Clicker = Instance.new("TextButton")
    Clicker.Parent = Btn
    Clicker.Text = ""
    Clicker.Size = UDim2.new(1, 0, 1, 0)
    Clicker.BackgroundTransparency = 1
    Clicker.AutoButtonColor = false

    return Btn, BtnText, Clicker
end

-- 📋 OPCIONES
local MainOptions = {
    {Nombre = "🔄 Auto Kick", ConfigKey = "AutoKick", Color = Color3.fromRGB(45, 80, 220)},
    {Nombre = "💥 Perfect Kick", ConfigKey = "PerfectKick", Color = Color3.fromRGB(220, 100, 45)},
    {Nombre = "💰 Auto Collect", ConfigKey = "AutoCollect", Color = Color3.fromRGB(45, 200, 120)},
    {Nombre = "📌 Auto Place", ConfigKey = "AutoPlace", Color = Color3.fromRGB(150, 45, 220)},
    {Nombre = "🏋️ Auto Buy / Upgrade", ConfigKey = "AutoBuy", Color = Color3.fromRGB(220, 45, 160)},
    {Nombre = "♾️ Stats Infinitas", ConfigKey = "InfiniteStats", Color = Color3.fromRGB(220, 45, 45)},
    {Nombre = "🌊 Sobrevivir Tsunami", ConfigKey = "AutoSurvive", Color = Color3.fromRGB(45, 160, 220)}
}

local PlayerOptions = {
    {Nombre = "✈️ Volar", ConfigKey = "Fly", Color = Color3.fromRGB(45, 80, 220)},
    {Nombre = "🏃 Velocidad: " .. Config.WalkSpeed, ConfigKey = "WalkSpeed", Color = Color3.fromRGB(45, 200, 120)},
    {Nombre = "⬆️ Salto: " .. Config.JumpPower, ConfigKey = "JumpPower", Color = Color3.fromRGB(45, 200, 120)}
}

local ConfigOptions = {
    {Nombre = "🛡️ Anti AFK", ConfigKey = "AntiAFK", Color = Color3.fromRGB(45, 80, 220)},
    {Nombre = "📊 Mostrar FPS", ConfigKey = "ShowFPS", Color = Color3.fromRGB(45, 200, 120)},
    {Nombre = "⚡ Optimizar Juego", ConfigKey = "Optimize", Color = Color3.fromRGB(220, 100, 45)}
}

-- 📊 FPS
local FPSLabel = Instance.new("TextLabel")
FPSLabel.Parent = ScreenGui
FPSLabel.Text = "FPS: 0"
FPSLabel.Font = Enum.Font.GothamBold
FPSLabel.TextColor3 = Color3.fromRGB(85, 255, 130)
FPSLabel.TextSize = 15
FPSLabel.BackgroundColor3 = Color3.fromRGB(10, 10, 30)
FPSLabel.BackgroundTransparency = 0.3
FPSLabel.Size = UDim2.new(0, 70, 0, 30)
FPSLabel.Position = UDim2.new(0.84, 0, 0.02, 0)
FPSLabel.Visible = false
local FPSCorner = Instance.new("UICorner")
FPSCorner.Parent = FPSLabel
FPSCorner.CornerRadius = UDim.new(0, 8)

-- 🔄 CAMBIAR PESTAÑAS
local function MostrarPestaña(Nombre)
    for _, v in pairs(Contenedor:GetChildren()) do
        if v:IsA("Frame") then v:Destroy() end
    end

    TabMain.BackgroundColor3 = Nombre == "Main" and Color3.fromRGB(45, 80, 220) or Color3.fromRGB(25, 35, 70)
    TabPlayer.BackgroundColor3 = Nombre == "Player" and Color3.fromRGB(45, 80, 220) or Color3.fromRGB(25, 35, 70)
    TabConfig.BackgroundColor3 = Nombre == "Config" and Color3.fromRGB(45, 80, 220) or Color3.fromRGB(25, 35, 70)

    local Opciones
    if Nombre == "Main" then Opciones = MainOptions
    elseif Nombre == "Player" then Opciones = PlayerOptions
    elseif Nombre == "Config" then Opciones = ConfigOptions end

    for i, Opt in ipairs(Opciones) do
        local Activo = Config[Opt.ConfigKey]
        local Btn, Txt, Click = CrearOpcion(Opt.Nombre, (i-1)*52, Activo, Opt.Color)

        Click.MouseButton1Click:Connect(function()
            if Opt.ConfigKey == "Fly" then
                Config.Fly = not Config.Fly
                if Config.ScriptActivo then ToggleFly(Config.Fly) end
            elseif Opt.ConfigKey == "Optimize" then
                Optimizar()
                Txt.Text = "⚡ JUEGO OPTIMIZADO ✅"
                Btn.BackgroundColor3 = Color3.fromRGB(45, 200, 120)
                return
            elseif Opt.ConfigKey == "ShowFPS" then
                Config.ShowFPS = not Config.ShowFPS
                FPSLabel.Visible = Config.ShowFPS and Config.ScriptActivo
            else
                Config[Opt.ConfigKey] = not Config[Opt.ConfigKey]
            end

            local NuevoEstado = Config[Opt.ConfigKey]
            Txt.Text = Opt.Nombre .. ": " .. (NuevoEstado and "ACTIVO ✅" or "INACTIVO ❌")
            Btn.BackgroundColor3 = NuevoEstado and Opt.Color or Color3.fromRGB(30, 35, 60)
            Btn.UIStroke.Color = NuevoEstado and Opt.Color:Lerp(Color3.new(1,1,1), 0.3) or Color3.fromRGB(60, 70, 100)
        end)
    end
end

TabMain.MouseButton1Click:Connect(function() MostrarPestaña("Main") end)
TabPlayer.MouseButton1Click:Connect(function() MostrarPestaña("Player") end)
TabConfig.MouseButton1Click:Connect(function() MostrarPestaña("Config") end)

-- 🚀 INICIAR
MostrarPestaña("Main")
task.spawn(AutoKickLoop)
task.spawn(AutoCollectLoop)
task.spawn(AutoPlaceLoop)
task.spawn(AutoBuyLoop)
task.spawn(SurviveTsunamiLoop)

StarterGui:SetCore("SendNotification", {
    Title = "✅ JoseAngel_Blox | Script Cargado",
    Text = "Kick a Lucky Block | Versión: 02/06/2026",
    Duration = 4
})

RunService.RenderStepped:Connect(function() if Config.ShowFPS and Config.ScriptActivo then FPSLabel.Text = "FPS: " .. FPS end end)
