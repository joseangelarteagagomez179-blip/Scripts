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

local Remotes = ReplicatedStorage:FindFirstChild("Remotes", true) or ReplicatedStorage
local KickEvent = Remotes:FindFirstChild("Kick") or Remotes:FindFirstChild("Patear") or Remotes:WaitForChild("Event", 10)
local CollectEvent = Remotes:FindFirstChild("Collect") or Remotes:FindFirstChild("Recolectar")
local PlaceEvent = Remotes:FindFirstChild("Place") or Remotes:FindFirstChild("Colocar")
local BuyEvent = Remotes:FindFirstChild("Buy") or Remotes:FindFirstChild("Comprar")
local RebirthEvent = Remotes:FindFirstChild("Rebirth") or Remotes:FindFirstChild("Renacer")

spawn(function()
    while task.wait(0.07) do
        if Config.AutoKick and KickEvent then
            local Block = Workspace:FindFirstChild("LuckyBlock", true) or Workspace:FindFirstChild("Bloque", true)
            if Block then
                local Force = Config.PerfectKick and math.random(930, 990) or Config.MaxForce
                KickEvent:FireServer(Block.Position, Force, Character.HumanoidRootPart.CFrame)
            end
        end
    end
end)

spawn(function()
    while task.wait(0.12) do
        if Config.AutoCollect and CollectEvent then
            for _, Obj in pairs(Workspace:GetDescendants()) do
                if (Obj:IsA("Part") or Obj:IsA("MeshPart")) and (Obj.Name:lower():find("coin") or Obj.Name:lower():find("money") or Obj.Name:lower():find("brainrot")) then
                    CollectEvent:FireServer(Obj)
                    Character.HumanoidRootPart.CFrame = Obj.CFrame + Vector3.new(0,2,0)
                    task.wait(0.04)
                end
            end
        end
    end
end)

spawn(function()
    while task.wait(1) do
        if Config.AutoPlace and PlaceEvent then
            local Plot = Workspace:FindFirstChild("Plots", true) and Workspace.Plots:FindFirstChild(tostring(Player.UserId), true)
            local Inventory = Player:FindFirstChild("Inventory", true)
            if Plot and Inventory then
                for _, Item in pairs(Inventory:GetChildren()) do
                    if Item.Name:find("Brainrot") then
                        PlaceEvent:FireServer(Item, Plot.Position + Vector3.new(math.random(-8,8),0,math.random(-8,8)))
                        task.wait(0.2)
                    end
                end
            end
        end
    end
end)

spawn(function()
    while task.wait(1.2) do
        if Config.AutoBuy and BuyEvent then
            local Upgrades = {"Weight", "LegPower", "Luck", "Speed", "Jump"}
            for _, Upg in pairs(Upgrades) do
                pcall(function() BuyEvent:FireServer(Upg) end)
                task.wait(0.25)
            end
        end
    end
end)

spawn(function()
    while task.wait(2) do
        if Config.AutoRebirth and RebirthEvent then
            pcall(function() RebirthEvent:FireServer() end)
        end
    end
end)

spawn(function()
    while task.wait(0.4) do
        if Config.SurviveTsunami and Humanoid then
            local Water = Workspace:FindFirstChild("Tsunami", true)
            if Water and Water.Position.Y > Character.Position.Y - 3 then
                Character.HumanoidRootPart.CFrame = CFrame.new(Character.Position.X, 120, Character.Position.Z)
                Humanoid.Health = 100
            end
        end
    end
end)

spawn(function()
    while task.wait(40) do
        if Config.AntiAFK and Humanoid then
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

local function UpdateStats()
    if Humanoid then
        Humanoid.WalkSpeed = Config.WalkSpeed
        Humanoid.JumpPower = Config.JumpPower
    end
end

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

