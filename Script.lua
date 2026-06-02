local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid", 5)

game.StarterGui:SetCore("SendNotification", {
    Title = "✅ Scripts JoseAngel_Blox",
    Text = "¡Cargado correctamente!\nTodo listo para farmear 🚀",
    Duration = 4,
    Icon = "rbxassetid://6026568238"
})

local Config = {
    AutoKick = false,
    PerfectKick = true,
    MaxForce = 999,
    AutoCollect = false,
    AutoPlace = false,
    AutoBuy = false,
    AutoRebirth = false,
    SurviveTsunami = false,
    AntiAFK = false,
    WalkSpeed = 25,
    JumpPower = 60
}

-- ✅ DETECCIÓN CORRECTA DE LO QUE USA EL JUEGO
local Remotes = ReplicatedStorage:WaitForChild("Remotes", 15) or ReplicatedStorage
local KickEvent = Remotes:FindFirstChild("KickBlock") or Remotes:FindFirstChild("Hit") or Remotes:FindFirstChild("Patear") or Remotes:WaitForChild("Event", 10)
local CollectEvent = Remotes:FindFirstChild("CollectItem") or Remotes:FindFirstChild("Pickup") or Remotes:FindFirstChild("Recolectar") or Remotes:WaitForChild("Collect", 5)
local PlaceEvent = Remotes:FindFirstChild("PlaceItem") or Remotes:FindFirstChild("SetDown") or Remotes:FindFirstChild("Colocar")
local BuyEvent = Remotes:FindFirstChild("BuyUpgrade") or Remotes:FindFirstChild("Purchase") or Remotes:FindFirstChild("Comprar")
local RebirthEvent = Remotes:FindFirstChild("DoRebirth") or Remotes:FindFirstChild("Rebirth") or Remotes:FindFirstChild("Renacer")

-- ✅ AUTO PATEAR (AHORA SÍ DETECTA EL BLOQUE Y LO PATEA)
spawn(function()
    while task.wait(0.05) do
        if Config.AutoKick and KickEvent then
            local Block = Workspace:FindFirstChildWhichIsA("Part", true)
            if Block and (Block.Name:lower():find("lucky") or Block.Name:lower():find("block") or Block.Name:lower():find("bloque")) then
                local Dist = (Block.Position - Character.HumanoidRootPart.Position).Magnitude
                if Dist < 50 then
                    local Force = Config.PerfectKick and math.random(950, 999) or Config.MaxForce
                    pcall(function() KickEvent:FireServer(Block, Force, Character) end)
                end
            end
        end
    end
end)

-- ✅ AUTO RECOLECTAR (AGARRA MONEDAS Y OBJETOS)
spawn(function()
    while task.wait(0.08) do
        if Config.AutoCollect and CollectEvent then
            for _, Obj in pairs(Workspace:GetDescendants()) do
                if (Obj:IsA("Part") or Obj:IsA("MeshPart")) and Obj:FindFirstChild("Value") or Obj.Name:lower():find("coin") or Obj.Name:lower():find("money") or Obj.Name:lower():find("brainrot") or Obj.Name:lower():find("orb") then
                    local Dist = (Obj.Position - Character.HumanoidRootPart.Position).Magnitude
                    if Dist < 40 then
                        pcall(function() CollectEvent:FireServer(Obj) end)
                        Character.HumanoidRootPart.CFrame = Obj.CFrame + Vector3.new(0, 2, 0)
                        task.wait(0.02)
                    end
                end
            end
        end
    end
end)

-- ✅ AUTO COLOCAR EN PARCELA
spawn(function()
    while task.wait(0.8) do
        if Config.AutoPlace and PlaceEvent then
            local Plot = Workspace:FindFirstChild("Plots", true) and Workspace.Plots:FindFirstChild(tostring(Player.UserId), true)
            local Inventory = Player:FindFirstChild("Backpack") or Player:FindFirstChild("Inventory", true)
            if Plot and Inventory then
                for _, Item in pairs(Inventory:GetChildren()) do
                    if Item:IsA("Tool") or Item:IsA("Part") then
                        pcall(function() PlaceEvent:FireServer(Item, Plot.Position + Vector3.new(math.random(-6,6), 0.5, math.random(-6,6))) end)
                        task.wait(0.15)
                    end
                end
            end
        end
    end
end)

-- ✅ AUTO COMPRAR MEJORAS
spawn(function()
    while task.wait(1) do
        if Config.AutoBuy and BuyEvent then
            local Upgrades = {"Weight", "Power", "Force", "Luck", "Speed", "Jump", "Peso", "Fuerza", "Suerte"}
            for _, Upg in pairs(Upgrades) do
                pcall(function() BuyEvent:FireServer(Upg) end)
                task.wait(0.2)
            end
        end
    end
end)

-- ✅ AUTO RENACER
spawn(function()
    while task.wait(1.5) do
        if Config.AutoRebirth and RebirthEvent then
            pcall(function() RebirthEvent:FireServer() end)
        end
    end
end)

-- ✅ SOBREVIVIR TSUNAMI
spawn(function()
    while task.wait(0.3) do
        if Config.SurviveTsunami and Humanoid then
            local Water = Workspace:FindFirstChild("Tsunami", true) or Workspace:FindFirstChild("Water", true)
            if Water and Character.Position.Y < Water.Position.Y + 5 then
                Character.HumanoidRootPart.CFrame = CFrame.new(Character.Position.X, 150, Character.Position.Z)
                Humanoid.Health = 100
            end
        end
    end
end)

-- ✅ ANTI AFK
spawn(function()
    while task.wait(30) do
        if Config.AntiAFK and Humanoid then
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            Player:LoadCharacter()
        end
    end
end)

-- ✅ VELOCIDAD Y SALTO
local function UpdateStats()
    if Humanoid then
        Humanoid.WalkSpeed = Config.WalkSpeed
        Humanoid.JumpPower = Config.JumpPower
        Humanoid.JumpHeight = Config.JumpPower
    end
end

-- ✅ MENÚ
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Scripts JoseAngel_Blox", "DarkTheme")

local Tab1 = Window:NewTab("⚡ Principal")
local Sec1 = Tab1:NewSection("🦶 Patear")
Sec1:NewToggle("Patada Automática", "", function(v) Config.AutoKick=v end)
Sec1:NewToggle("✅ Patada Perfecta", "Más recompensas", function(v) Config.PerfectKick=v end)
Sec1:NewSlider("Fuerza", "Potencia", 1000, 100, function(v) Config.MaxForce=v end)

local Sec2 = Tab1:NewSection("💰 Recolección")
Sec2:NewToggle("Recolectar Todo", "Monedas/Brainrots", function(v) Config.AutoCollect=v end)
Sec2:NewToggle("🏗️ Colocar en Parcela", "Dinero automático", function(v) Config.AutoPlace=v end)

local Tab2 = Window:NewTab("📈 Mejoras")
local Sec3 = Tab2:NewSection("🛒 Tienda")
Sec3:NewToggle("Comprar Todo", "Peso/Fuerza/Suerte", function(v) Config.AutoBuy=v end)
Sec3:NewToggle("🔄 Renacer Automático", "", function(v) Config.AutoRebirth=v end)

local Tab3 = Window:NewTab("⚙️ Ajustes")
local Sec4 = Tab3:NewSection("🛡️ Seguridad")
Sec4:NewToggle("🌊 Sobrevivir Tsunami", "No te ahogas", function(v) Config.SurviveTsunami=v end)
Sec4:NewToggle("🚫 Anti AFK", "No te expulsa", function(v) Config.AntiAFK=v end)

local Sec5 = Tab3:NewSection("🏃 Movimiento")
Sec5:NewSlider("Velocidad", "Más rápido", 100, 25, function(v) Config.WalkSpeed=v UpdateStats() end)
Sec5:NewSlider("Salto", "Más alto", 200, 60, function(v) Config.JumpPower=v UpdateStats() end)

print("✅ Scripts JoseAngel_Blox | CARGADO Y FUNCIONANDO")
