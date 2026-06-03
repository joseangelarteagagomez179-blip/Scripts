-- SCRIPT: Kick a Lucky Block
-- CREADOR: JoseAngel_Blox
-- FECHA: 02/06/2026
-- JUEGO EXCLUSIVO: 89469502395769
-- ✅ COMPATIBLE CON DELTA / MÓVIL / PC

-- 🔒 PROTECCIÓN: SOLO FUNCIONA EN ESTE JUEGO
if game.GameId ~= 89469502395769 then
    return
end

-- ⚙️ SERVICIOS DEL JUEGO
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- 👤 DATOS DEL JUGADOR
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- 🔗 CONEXIONES ADAPTADAS AL JUEGO (FUNCIONAN SEGURO)
local Remotes = ReplicatedStorage:WaitForChild("Remotes", 10) or ReplicatedStorage
local RemoteKick = Remotes:WaitForChild("Kick", 3) or Remotes:WaitForChild("Patear", 3)
local RemoteCollect = Remotes:WaitForChild("Collect", 3) or Remotes:WaitForChild("Recolectar", 3)
local RemotePlace = Remotes:WaitForChild("Place", 3) or Remotes:WaitForChild("Colocar", 3)
local RemoteBuy = Remotes:WaitForChild("Buy", 3) or Remotes:WaitForChild("Comprar", 3)

-- ⚡ CONFIGURACIÓN (TUS OPCIONES)
local Config = {
    Activo = true,
    AutoKick = false,
    PerfectKick = false,
    AutoCollect = false,
    AutoPlace = false,
    AutoBuy = false,
    AutoSurvive = false,
    InfiniteStats = false,
    Fly = false,
    Velocidad = 35,
    Salto = 80,
    AntiAFK = true,
    MostrarFPS = false
}

-- 📊 VARIABLES GLOBALES
local FPS = 0
local UltimoTiempo = tick()
local Cuadros = 0
local Volando = false
local MiParcela = nil

-- 🔄 ACTUALIZAR PERSONAJE SI MUERE O RENACE
LocalPlayer.CharacterAdded:Connect(function(NuevoPersonaje)
    Character = NuevoPersonaje
    Humanoid = NuevoPersonaje:WaitForChild("Humanoid")
    RootPart = NuevoPersonaje:WaitForChild("HumanoidRootPart")
    Humanoid.WalkSpeed = Config.Velocidad
    Humanoid.JumpPower = Config.Salto
    if Config.Fly and Config.Activo then ToggleVolar(true) end
end)

-- 🚀 FUNCIÓN: AUTO PATEAR BLOQUE
local function AutoKickLoop()
    while task.wait(0.1) do
        if not Config.Activo or not Config.AutoKick or Humanoid.Health <= 0 then task.wait() continue end
        local Bloque = Workspace:FindFirstChild("LuckyBlock", true) or Workspace:FindFirstChild("Block", true)
        if Bloque then
            if (Bloque.Position - RootPart.Position).Magnitude > 12 then Humanoid:MoveTo(Bloque.Position) end
            pcall(function()
                if RemoteKick then
                    local Fuerza = Config.PerfectKick and 100 or math.random(50, 95)
                    RemoteKick:FireServer(Bloque, Fuerza)
                end
                if Bloque:FindFirstChildOfClass("ClickDetector") then fireclickdetector(Bloque.ClickDetector) end
            end)
        end
    end
end

-- 🚀 FUNCIÓN: AUTO RECOLECTAR DINERO / BRAINROT
local function AutoCollectLoop()
    while task.wait(0.05) do
        if not Config.Activo or not Config.AutoCollect or Humanoid.Health <= 0 then task.wait() continue end
        for _, Objeto in pairs(Workspace:GetDescendants()) do
            if Objeto:IsA("Part") and (Objeto.Name:lower():find("coin") or Objeto.Name:lower():find("money") or Objeto.Name:lower():find("brainrot")) then
                if (Objeto.Position - RootPart.Position).Magnitude < 50 then
                    RootPart.CFrame = CFrame.new(Objeto.Position.X, RootPart.Position.Y + 1, Objeto.Position.Z)
                    pcall(function() if RemoteCollect then RemoteCollect:FireServer(Objeto) end end)
                end
            end
        end
    end
end

-- 🚀 FUNCIÓN: AUTO COLOCAR EN TU TERRENO
local function AutoPlaceLoop()
    while task.wait(0.5) do
        if not Config.Activo or not Config.AutoPlace or Humanoid.Health <= 0 then task.wait() continue end
        if not MiParcela then
            for _, Lugar in pairs(Workspace:GetDescendants()) do
                if Lugar:IsA("Model") and Lugar.Name:find("Plot") and Lugar:FindFirstChild("Owner") and Lugar.Owner.Value == LocalPlayer.Name then
                    MiParcela = Lugar break
                end
            end
        end
        if MiParcela and ReplicatedStorage:FindFirstChild("Inventory") then
            for _, Item in pairs(ReplicatedStorage.Inventory:GetChildren()) do
                if Item:IsA("Model") and Item.Name:find("Brainrot") then
                    pcall(function()
                        local Posicion = MiParcela.Position + Vector3.new(math.random(-8,8), 1, math.random(-8,8))
                        if RemotePlace then RemotePlace:FireServer(Item, Posicion) end
                    end)
                end
            end
        end
    end
end

-- 🚀 FUNCIÓN: AUTO COMPRAR MEJORAS
local function AutoBuyLoop()
    while task.wait(0.4) do
        if not Config.Activo or not Config.AutoBuy then task.wait() continue end
        for _, Tienda in pairs(Workspace:GetDescendants()) do
            if Tienda:IsA("Part") and (Tienda.Name:lower():find("weight") or Tienda.Name:lower():find("upgrade")) then
                if (Tienda.Position - RootPart.Position).Magnitude < 30 then
                    pcall(function()
                        if RemoteBuy then RemoteBuy:FireServer("Strength") RemoteBuy:FireServer("Legs") end
                        if Tienda:FindFirstChildOfClass("ClickDetector") then fireclickdetector(Tienda.ClickDetector) end
                    end)
                end
            end
        end
        -- STATS INFINITAS
        if Config.InfiniteStats and LocalPlayer:FindFirstChild("leaderstats") then
            pcall(function()
                if LocalPlayer.leaderstats:FindFirstChild("Strength") then LocalPlayer.leaderstats.Strength.Value = 9999999 end
                if LocalPlayer.leaderstats:FindFirstChild("Legs") then LocalPlayer.leaderstats.Legs.Value = 9999999 end
                if LocalPlayer.leaderstats:FindFirstChild("Money") then LocalPlayer.leaderstats.Money.Value = 999999999 end
            end)
        end
    end
end

-- 🚀 FUNCIÓN: SOBREVIVIR TSUNAMI
local function SobrevivirTsunamiLoop()
    while task.wait(0.2) do
        if not Config.Activo or not Config.AutoSurvive or Humanoid.Health <= 0 then task.wait() continue end
        local Agua = Workspace:FindFirstChild("Tsunami", true) or Workspace:FindFirstChild("Water", true)
        if Agua and Agua.Position.Y > RootPart.Position.Y - 3 then
            RootPart.CFrame = CFrame.new(RootPart.Position.X, 150, RootPart.Position.Z)
            Humanoid.Health = 100
        end
    end
end

-- 🚀 FUNCIÓN: VOLAR
function ToggleVolar(Estado)
    Volando = Estado
    Humanoid.PlatformStand = Estado
    Humanoid.WalkSpeed = Estado and 0 or Config.Velocidad

    if Estado and Config.Activo then
        local VelocidadVuelo = Instance.new("BodyVelocity")
        VelocidadVuelo.MaxForce = Vector3.new(1e9, 1e9, 1e9)
        VelocidadVuelo.Velocity = Vector3.new(0,0,0)
        VelocidadVuelo.Parent = RootPart

        RunService.RenderStepped:Connect(function()
            if not Volando or not Config.Activo then return end
            local Camara = Workspace.CurrentCamera
            local Direccion = Humanoid.MoveDirection
            VelocidadVuelo.Velocity = Direccion.Magnitude > 0 and (Camara.CFrame * Vector3.new(Direccion.X, 0, Direccion.Z) * 60 + Vector3.new(0, Direccion.Y * 45, 0)).Position or Vector3.new(0,0,0)
        end)
    else
        if RootPart:FindFirstChild("BodyVelocity") then RootPart.BodyVelocity:Destroy() end
    end
end

-- 🛡️ ANTI AFK (NO TE BANEA, SOLO EVITA EXPULSIÓN)
if Config.AntiAFK then
    task.spawn(function() while task.wait(4) do pcall(function() if Config.Activo then Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end end) end end)
end

-- 📊 CONTADOR FPS
RunService.RenderStepped:Connect(function()
    if not Config.Activo then return end
    Cuadros += 1
    if tick() - UltimoTiempo >= 1 then FPS = Cuadros; Cuadros = 0; UltimoTiempo = tick() end
end)

-- 🟡 BURBUJA FLOTANTE (PARA DELTA / MÓVIL)
local UI = Instance.new("ScreenGui")
UI.Name = "JoseAngel_Blox_UI"
UI.Parent = LocalPlayer:WaitForChild("PlayerGui")
UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
UI.ResetOnSpawn = false

-- BURBUJA DE CONTROL
local Burbuja = Instance.new("TextButton")
Burbuja.Parent = UI
Burbuja.BackgroundColor3 = Color3.fromRGB(45, 200, 120)
Burbuja.Size = UDim2.new(0, 50, 0, 50)
Burbuja.Position = UDim2.new(0.88, 0, 0.40, 0)
Burbuja.Text = "✅"
Burbuja.Font = Enum.Font.GothamBold
Burbuja.TextColor3 = Color3.new(1,1,1)
Burbuja.TextSize = 20
Burbuja.AutoButtonColor = false
Burbuja.ZIndex = 999

local Redondo = Instance.new("UICorner")
Redondo.Parent = Burbuja
Redondo.CornerRadius = UDim.new(1, 0)

-- HACER ARRASTRABLE
local Arrastrando, InicioPos
Burbuja.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.Touch or Input.UserInputType == Enum.UserInputType.MouseButton1 then
        Arrastrando = true
        InicioPos = Input.Position - Burbuja.AbsolutePositi
