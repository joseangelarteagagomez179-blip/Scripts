-- Kick a Lucky Block | Script para Delta Executor
-- https://www.roblox.com/es/games/89469502395769/Kick-a-Lucky-Block
-- Compatible: Delta, Fluxus, Codex, todos ejecutores modernos
-- GitHub listo: guardar como KickALuckyBlock.lua

-- Servicios
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")

-- Configuración
local Config = {
    AutoKick = true,
    PerfectKick = true,
    AutoCollect = true,
    AutoPlace = true,
    AutoTrain = true,
    AutoBuyWeights = true,
    AutoSurviveTsunami = true,
    AutoRebirth = false,
    SpeedBoost = 1.5,
    JumpBoost = 1.2
}

-- Crear Interfaz
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RobloxUI/UI-Library/main/Source.lua"))()
local Window = Library:CreateWindow({
    Title = "Kick a Lucky Block | Delta",
    Position = UDim2.new(0.02, 0, 0.02, 0),
    Size = UDim2.new(0, 320, 0, 420),
    Theme = "Dark"
})

local MainTab = Window:AddTab("Principal")
local FarmSection = MainTab:AddSection("Auto Granja")

FarmSection:AddToggle("Auto Chute", function(state) Config.AutoKick=state end, Config.AutoKick)
FarmSection:AddToggle("Chute Perfecto", function(state) Config.PerfectKick=state end, Config.PerfectKick)
FarmSection:AddToggle("Auto Recolectar", function(state) Config.AutoCollect=state end, Config.AutoCollect)
FarmSection:AddToggle("Auto Colocar", function(state) Config.AutoPlace=state end, Config.AutoPlace)
FarmSection:AddToggle("Auto Entrenar", function(state) Config.AutoTrain=state end, Config.AutoTrain)
FarmSection:AddToggle("Auto Comprar Pesas", function(state) Config.AutoBuyWeights=state end, Config.AutoBuyWeights)
FarmSection:AddToggle("Sobrevivir Tsunami", function(state) Config.AutoSurviveTsunami=state end, Config.AutoSurviveTsunami)
FarmSection:AddToggle("Auto Renacer", function(state) Config.AutoRebirth=state end, Config.AutoRebirth)

local PlayerTab = Window:AddTab("Jugador")
PlayerTab:AddSlider("Velocidad", 1, 5, Config.SpeedBoost, function(v) Config.SpeedBoost=v end)
PlayerTab:AddSlider("Salto", 1, 5, Config.JumpBoost, function(v) Config.JumpBoost=v end)

-- Funciones principales
local function GetLuckyBlock()
    return Workspace:FindFirstChild("LuckyBlock", true)
end

local function KickBlock()
    local block = GetLuckyBlock()
    if not block or not Config.AutoKick then return end
    
    -- Chute perfecto: llenar barra al máximo
    if Config.PerfectKick then
        local kickEvent = ReplicatedStorage:WaitForChild("Events"):WaitForChild("Kick")
        kickEvent:FireServer(100) -- Fuerza máxima
    else
        ReplicatedStorage.Events.Kick:FireServer()
    end
end

local function CollectItems()
    if not Config.AutoCollect then return end
    for _,item in pairs(Workspace:GetChildren()) do
        if item:IsA("Model") and item.Name:find("Brainrot") and item:FindFirstChild("Pickup") then
            fireclickdetector(item.Pickup)
        end
    end
end

local function PlaceItems()
    if not Config.AutoPlace then return end
    local plot = Workspace:FindFirstChild("Plots", true):FindFirstChild(Player.Name)
    if plot and plot:FindFirstChild("PlacePad") then
        ReplicatedStorage.Events.PlaceBrainrot:FireServer()
    end
end

local function TrainLegs()
    if not Config.AutoTrain then return end
    local trainPad = Workspace:FindFirstChild("TrainingArea", true):FindFirstChild("TrainPad")
    if trainPad then fireclickdetector(trainPad) end
end

local function BuyWeights()
    if not Config.AutoBuyWeights then return end
    local shop = Workspace:FindFirstChild("Shop", true)
    if shop then
        for _,btn in pairs(shop:GetDescendants()) do
            if btn:IsA("TextButton") and btn.Name:find("Weight") then
                fireclickdetector(btn)
                task.wait(0.2)
            end
        end
    end
end

local function SurviveTsunami()
    if not Config.AutoSurviveTsunami then return end
    local tsunami = Workspace:FindFirstChild("Tsunami", true)
    if tsunami and tsunami:IsA("BasePart") then
        -- Correr hacia atrás / zona segura
        local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
        if root then
            root.Velocity = Vector3.new(0, 0, -50 * Config.SpeedBoost)
        end
    end
end

local function ApplyStats()
    if Player.Character then
        local hum = Player.Character:FindFirstChild("Humanoid")
        if hum then
            hum.WalkSpeed = 16 * Config.SpeedBoost
            hum.JumpPower = 50 * Config.JumpBoost
        end
    end
end

-- Bucle principal
RunService.RenderStepped:Connect(function()
    if not Player.Character then return end
    ApplyStats()
    SurviveTsunami()
end)

task.spawn(function()
    while task.wait(0.5) do
        if Config.AutoKick then KickBlock() end
        if Config.AutoCollect then CollectItems() end
        if Config.AutoPlace then PlaceItems() end
        if Config.AutoTrain then TrainLegs() end
        if Config.AutoBuyWeights then BuyWeights() end
    end
end)

print("✅ Script cargado | Kick a Lucky Block | Delta Executor")
