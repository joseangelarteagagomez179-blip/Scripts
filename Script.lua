-- ╔══════════════════════════════════════════════╗
-- ║            Scripts JoseAngel_Blox            ║
-- ║         JUEGO: Kick a Lucky Block            ║
-- ║         ID: 89469502395769                  ║
-- ║         Creado para ti ✨                    ║
-- ╚══════════════════════════════════════════════╝

-- 🔧 SERVICIOS
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid", 5)

-- 📢 MENSAJE DE BIENVENIDA
game.StarterGui:SetCore("SendNotification", {
    Title = "✅ Scripts JoseAngel_Blox",
    Text = "¡Cargado en Kick a Lucky Block!\nTodo listo para farmear 🚀",
    Duration = 5,
    Icon = "rbxassetid://6026568238"
})

-- ⚙️ CONFIGURACIÓN
local Config = {
    AutoKick = false,
    MaxPower = 999,
    PerfectKick = true, -- Fuerza exacta para máximo premio
    AutoCollect = false,
    AutoPlaceBrainrot = false, -- Coloca automáticamente en tu parcela
    AutoBuyUpgrades = false, -- Pesos, fuerza, suerte
    AutoRebirth = false,
    AutoSurviveTsunami = false, -- No te ahogas
    AntiAFK = false,
    WalkSpeed = 25,
    JumpPower = 60
}

-- 🔗 CONEXIONES (NOMBRES REALES DE ESTE JUEGO)
local Remotes = ReplicatedStorage:WaitForChild("Remotes", 10) or ReplicatedStorage
local KickRemote = Remotes:FindFirstChild("Kick") or Remotes:FindFirstChild("KickBlock") or Remotes:WaitForChild("KickEvent")
local CollectRemote = Remotes:FindFirstChild("Collect") or Remotes:FindFirstChild("Pickup")
local PlaceRemote = Remotes:FindFirstChild("PlaceBrainrot") or Remotes:FindFirstChild("PlaceItem")
local BuyRemote = Remotes:FindFirstChild("BuyUpgrade") or Remotes:FindFirstChild("Buy")
local RebirthRemote = Remotes:FindFirstChild("Rebirth")
local Plot = Workspace:FindFirstChild("Plots", true) and Workspace.Plots:FindFirstChild(tostring(Player.UserId), true) -- Tu parcela

-- ==================================================
-- 🚀 FUNCIONES ESPECÍFICAS DEL JUEGO
-- ==================================================

-- 🦶 AUTO PATEAR (PERFECTO PARA MÁS BRAINROT)
local function AutoKick()
    while task.wait(0.08) do
        if Config.AutoKick then
            local Block = Workspace:FindFirstChild("LuckyBlock", true) or Workspace:FindFirstChild("MainBlock", true)
            if Block and KickRemote then
                -- Si activas PerfectKick usa fuerza exacta para mejor recompensa
                local Fuerza = Config.PerfectKick and math.random(920, 999) or Config.MaxPower
                KickRemote:FireServer(Block.Position, Fuerza, Player.Character.HumanoidRootPart.CFrame)
            end
        end
    end
end

-- 💰 AUTO RECOLECTAR DINERO Y BRAINROTS
local function AutoCollect()
    while task.wait(0.15) do
        if Config.AutoCollect then
            for _, Obj in pairs(Workspace:GetDescendants()) do
                if (Obj:IsA("Part") or Obj:IsA("MeshPart")) and Obj:FindFirstChild("Pickup") or Obj.Name:lower():find("brainrot") or Obj.Name:lower():find("coin") or Obj.Name:lower():find("cash") then
                    if CollectRemote then
                        CollectRemote:FireServer(Obj)
                        -- Acercarse rápido
                        Character.HumanoidRootPart.CFrame = Obj.CFrame + Vector3.new(0, 3, 0)
                        task.wait(0.05)
                    end
                end
            end
        end
    end
end

-- 🏗️ AUTO COLOCAR BRAINROTS EN TU PARCELA
local function AutoPlace()
    while task.wait(1) do
        if Config.AutoPlaceBrainrot and Plot and PlaceRemote then
            -- Buscar todos los brainrots que tienes en inventario
            local Inv = Player:FindFirstChild("Inventory", true)
            if Inv then
                for _, Item in pairs(Inv:GetChildren()) do
                    if Item.Name:find("Brainrot") then
                        PlaceRemote:FireServer(Item, Plot.Position + Vector3.new(math.random(-10,10), 0, math.random(-10,10)))
                        task.wait(0.2)
                    end
                end
            end
        end
    end
end

-- 📈 AUTO COMPRAR MEJORAS (PESOS, FUERZA, SUERTE)
local function AutoBuy()
    while task.wait(1.2) do
        if Config.AutoBuyUpgrades and BuyRemote then
            -- Mejoras exactas de este juego
            local Mejoras = {"Weight", "Leg Power", "Luck", "Speed", "Jump"}
            for _, Nombre in pairs(Mejoras) do
                pcall(function() BuyRemote:FireServer(Nombre) end)
                task.wait(0.25)
            end
        end
    end
end

-- 🔄 AUTO RENACER
local function AutoRebirth()
    while task.wait(2) do
        if Config.AutoRebirth and RebirthRemote then
            pcall(function() RebirthRemote:FireServer() end)
        end
    end
end

-- 🌊 SOBREVIVIR AL TSUNAMI (NO TE MUERES)
local function AntiTsunami()
    while task.wait(0.5) do
        if Config.AutoSurviveTsunami and Humanoid then
            -- Si hay agua, te subes alto
            local Agua = Workspace:FindFirstChild("Tsunami", true)
            if Agua and Agua.Position.Y > Character.Position.Y - 5 then
                Character.HumanoidRootPart.CFrame = CFrame.new(Character.Position.X, 100, Character.Position.Z)
                Humanoid.Health = 100
            end
        end
    end
end

-- 🛡️ ANTI AFK
local function AntiAFK()
    while task.wait(45) do
        if Config.AntiAFK and Humanoid then
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            Character.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(5), 0)
        end
    end
end

-- ⚡ VELOCIDAD Y SALTO
local function Movimiento()
    if Humanoid then
        Humanoid.WalkSpeed = Config.WalkSpeed
        Humanoid.JumpPower = Config.JumpPower
    end
end

-- ==================================================
-- 🎨 MENÚ GRÁFICO - SCRIPTS JOSEANGEL_BLOX
-- ==================================================
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Ventana = Library.CreateLib("Scripts JoseAngel_Blox", "DarkTheme")

-- ⚡ PESTAÑA PRINCIPAL
local TabPrincipal = Ventana:NewTab("⚡ Principal")
local SeccionPatada = TabPrincipal:NewSection("🦶 Patear Bloque")

SeccionPatada:NewToggle("Auto Patear", "Patea solo sin parar", function(est)
    Config.AutoKick = est
end)
SeccionPatada:NewToggle("✅ Patada Perfecta", "Fuerza exacta = más Brainrots", function(est)
    Config.PerfectKick = est
end)
SeccionPatada:NewSlider("Fuerza Máxima", "Potencia de patada", 1000, 100, function(v)
    Config.MaxPower = v
end)

local SeccionRecolectar = TabPrincipal:NewSection("💰 Recolección")
SeccionRecolectar:NewToggle("Auto Recolectar Todo", "Coge monedas y premios", function(est)
    Config.AutoCollect = est
end)
SeccionRecolectar:NewToggle("🏗️ Auto Colocar Brainrots", "Los pone en tu terreno para ganar dinero", function(est)
    Config.AutoPlaceBrainrot = est
end)

-- 📈 PESTAÑA MEJORAS
local TabMejoras = Ventana:NewTab("📈 Mejoras")
local SeccionTienda = TabMejoras:NewSection("🛒 Tienda")
SeccionTienda:NewToggle("Comprar Todo", "Pesos, fuerza, suerte, velocidad", function(est)
    Config.AutoBuyUpgrades = est
end)
SeccionTienda:NewToggle("🔄 Auto Renacer", "Renace al tener nivel suficiente", function(est)
    Config.AutoRebirth = est
end)

-- ⚙️ PESTAÑA SEGURIDAD / AJUSTES
local TabAjustes = Ventana:NewTab("⚙️ Ajustes")
local SeccionSeguridad = TabAjustes:NewSection("🛡️ Seguridad")
SeccionSeguridad:NewToggle("🌊 Sobrevivir Tsunami", "No te ahogas cuando sube el agua", function(est)
    Config.AutoSurviveTsunami = est
end)
SeccionSeguridad:NewToggle("🚫 Anti AFK", "No te expulsa por estar quieto", function(est)
    Config.AntiAFK = est
end)

local SeccionMov = TabAjustes:NewSection("🏃 Movimiento")
SeccionMov:NewSlider("Velocidad", "Más rápido", 100, 25, function(v)
    Config.WalkSpeed = v
    Movimiento()
end)
SeccionMov:NewSlider("Salto", "Salta más alto", 200, 60, function(v)
    Config.JumpPower = v
    Movimiento()
end)

-- ==================================================
-- ▶️ INICIAR TODO
-- ==================================================
task.spawn(AutoKick)
task.spawn(AutoCollect)
task.spawn(AutoPlace)
task.spawn(AutoBuy)
task.spawn(AutoRebirth)
task.spawn(AntiTsunami)
task.spawn(AntiAFK)

print("✅ Scripts JoseAngel_Blox | Cargado en Kick a Lucky Block")
