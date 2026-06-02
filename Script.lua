--[[
    Scripts JoseAngel_Blox - Kick a Lucky Block
    Compatible con Delta Executor
    Versión: 1.0.0
    
    Script completo con:
    - Auto Patear con patada perfecta
    - Auto Recolectar monedas y objetos
    - Auto Colocar Brainrots
    - Auto Comprar mejoras
    - Auto Renacer
    - Sobrevivir Tsunami (elevación)
    - Anti AFK
    - Velocidad y Salto personalizables
]]

-- Servicios
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

-- Variables globales
local Kicking = false
local Collecting = false
local Placing = false
local AutoUpgrade = false
local AutoRebirthFlag = false
local TsunamiSurvival = true
local AntiAFKEnabled = true

-- Configuración de velocidad/salto
local CustomSpeed = 16
local CustomJumpPower = 50

-- Interfaz gráfica
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngelBloxGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true

-- Sombra/Mate
local Corner = Instance.new("UICorner", MainFrame)
Corner.CornerRadius = UDim.new(0, 12)

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner", TitleBar)
TitleCorner.CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "Scripts JoseAngel_Blox ⚡"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Center
Title.Parent = TitleBar

-- Pestañas
local TabButtons = Instance.new("Frame")
TabButtons.Size = UDim2.new(1, 0, 0, 40)
TabButtons.Position = UDim2.new(0, 0, 0, 45)
TabButtons.BackgroundTransparency = 1
TabButtons.Parent = MainFrame

local PrincipalBtn = Instance.new("TextButton")
PrincipalBtn.Size = UDim2.new(0.33, 0, 1, 0)
PrincipalBtn.Position = UDim2.new(0, 0, 0, 0)
PrincipalBtn.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
PrincipalBtn.Text = "Principal"
PrincipalBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PrincipalBtn.Font = Enum.Font.GothamSemibold
PrincipalBtn.TextSize = 14
PrincipalBtn.BorderSizePixel = 0
PrincipalBtn.Parent = TabButtons

local MejorasBtn = Instance.new("TextButton")
MejorasBtn.Size = UDim2.new(0.33, 0, 1, 0)
MejorasBtn.Position = UDim2.new(0.33, 0, 0, 0)
MejorasBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
MejorasBtn.Text = "Mejoras"
MejorasBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MejorasBtn.Font = Enum.Font.GothamSemibold
MejorasBtn.TextSize = 14
MejorasBtn.BorderSizePixel = 0
MejorasBtn.Parent = TabButtons

local AjustesBtn = Instance.new("TextButton")
AjustesBtn.Size = UDim2.new(0.34, 0, 1, 0)
AjustesBtn.Position = UDim2.new(0.66, 0, 0, 0)
AjustesBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
AjustesBtn.Text = "Ajustes"
AjustesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AjustesBtn.Font = Enum.Font.GothamSemibold
AjustesBtn.TextSize = 14
AjustesBtn.BorderSizePixel = 0
AjustesBtn.Parent = TabButtons

-- Contenedor de contenido
local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, 0, 1, -85)
ContentContainer.Position = UDim2.new(0, 0, 0, 85)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

-- Panel Principal
local PrincipalPanel = Instance.new("ScrollingFrame")
PrincipalPanel.Size = UDim2.new(1, 0, 1, 0)
PrincipalPanel.BackgroundTransparency = 1
PrincipalPanel.ScrollBarThickness = 5
PrincipalPanel.CanvasSize = UDim2.new(0, 0, 0, 450)
PrincipalPanel.Parent = ContentContainer

-- Auto Patear
local AutoKickBtn = Instance.new("TextButton")
AutoKickBtn.Size = UDim2.new(0.9, 0, 0, 45)
AutoKickBtn.Position = UDim2.new(0.05, 0, 0.05, 0)
AutoKickBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
AutoKickBtn.Text = "⚽ Auto Patear (Perfect Kick)"
AutoKickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoKickBtn.Font = Enum.Font.GothamSemibold
AutoKickBtn.TextSize = 14
AutoKickBtn.BorderSizePixel = 0
AutoKickBtn.Parent = PrincipalPanel
local AutoKickCorner = Instance.new("UICorner", AutoKickBtn)
AutoKickCorner.CornerRadius = UDim.new(0, 8)

local KickStatus = Instance.new("TextLabel")
KickStatus.Size = UDim2.new(0.9, 0, 0, 25)
KickStatus.Position = UDim2.new(0.05, 0, 0.18, 0)
KickStatus.BackgroundTransparency = 1
KickStatus.Text = "Estado: ❌ Inactivo"
KickStatus.TextColor3 = Color3.fromRGB(180, 180, 180)
KickStatus.TextSize = 12
KickStatus.Font = Enum.Font.Gotham
KickStatus.TextXAlignment = Enum.TextXAlignment.Left
KickStatus.Parent = PrincipalPanel

-- Auto Recolectar
local AutoCollectBtn = Instance.new("TextButton")
AutoCollectBtn.Size = UDim2.new(0.9, 0, 0, 45)
AutoCollectBtn.Position = UDim2.new(0.05, 0, 0.25, 0)
AutoCollectBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
AutoCollectBtn.Text = "💰 Auto Recolectar"
AutoCollectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoCollectBtn.Font = Enum.Font.GothamSemibold
AutoCollectBtn.TextSize = 14
AutoCollectBtn.BorderSizePixel = 0
AutoCollectBtn.Parent = PrincipalPanel
local AutoCollectCorner = Instance.new("UICorner", AutoCollectBtn)
AutoCollectCorner.CornerRadius = UDim.new(0, 8)

local CollectStatus = Instance.new("TextLabel")
CollectStatus.Size = UDim2.new(0.9, 0, 0, 25)
CollectStatus.Position = UDim2.new(0.05, 0, 0.38, 0)
CollectStatus.BackgroundTransparency = 1
CollectStatus.Text = "Estado: ❌ Inactivo"
CollectStatus.TextColor3 = Color3.fromRGB(180, 180, 180)
CollectStatus.TextSize = 12
CollectStatus.Font = Enum.Font.Gotham
CollectStatus.TextXAlignment = Enum.TextXAlignment.Left
CollectStatus.Parent = PrincipalPanel

-- Auto Colocar Brainrots
local AutoPlaceBtn = Instance.new("TextButton")
AutoPlaceBtn.Size = UDim2.new(0.9, 0, 0, 45)
AutoPlaceBtn.Position = UDim2.new(0.05, 0, 0.45, 0)
AutoPlaceBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
AutoPlaceBtn.Text = "🧠 Auto Colocar Brainrots"
AutoPlaceBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoPlaceBtn.Font = Enum.Font.GothamSemibold
AutoPlaceBtn.TextSize = 14
AutoPlaceBtn.BorderSizePixel = 0
AutoPlaceBtn.Parent = PrincipalPanel
local AutoPlaceCorner = Instance.new("UICorner", AutoPlaceBtn)
AutoPlaceCorner.CornerRadius = UDim.new(0, 8)

local PlaceStatus = Instance.new("TextLabel")
PlaceStatus.Size = UDim2.new(0.9, 0, 0, 25)
PlaceStatus.Position = UDim2.new(0.05, 0, 0.58, 0)
PlaceStatus.BackgroundTransparency = 1
PlaceStatus.Text = "Estado: ❌ Inactivo"
PlaceStatus.TextColor3 = Color3.fromRGB(180, 180, 180)
PlaceStatus.TextSize = 12
PlaceStatus.Font = Enum.Font.Gotham
PlaceStatus.TextXAlignment = Enum.TextXAlignment.Left
PlaceStatus.Parent = PrincipalPanel

-- Sobrevivir Tsunami
local TsunamiBtn = Instance.new("TextButton")
TsunamiBtn.Size = UDim2.new(0.9, 0, 0, 45)
TsunamiBtn.Position = UDim2.new(0.05, 0, 0.65, 0)
TsunamiBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
TsunamiBtn.Text = "🌊 Sobrevivir Tsunami (ON)"
TsunamiBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TsunamiBtn.Font = Enum.Font.GothamSemibold
TsunamiBtn.TextSize = 14
TsunamiBtn.BorderSizePixel = 0
TsunamiBtn.Parent = PrincipalPanel
local TsunamiCorner = Instance.new("UICorner", TsunamiBtn)
TsunamiCorner.CornerRadius = UDim.new(0, 8)

-- Panel Mejoras
local MejorasPanel = Instance.new("ScrollingFrame")
MejorasPanel.Size = UDim2.new(1, 0, 1, 0)
MejorasPanel.BackgroundTransparency = 1
MejorasPanel.ScrollBarThickness = 5
MejorasPanel.CanvasSize = UDim2.new(0, 0, 0, 400)
MejorasPanel.Visible = false
MejorasPanel.Parent = ContentContainer

local AutoBuyBtn = Instance.new("TextButton")
AutoBuyBtn.Size = UDim2.new(0.9, 0, 0, 45)
AutoBuyBtn.Position = UDim2.new(0.05, 0, 0.05, 0)
AutoBuyBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
AutoBuyBtn.Text = "🛒 Auto Comprar TODAS las mejoras"
AutoBuyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoBuyBtn.Font = Enum.Font.GothamSemibold
AutoBuyBtn.TextSize = 14
AutoBuyBtn.BorderSizePixel = 0
AutoBuyBtn.Parent = MejorasPanel
local AutoBuyCorner = Instance.new("UICorner", AutoBuyBtn)
AutoBuyCorner.CornerRadius = UDim.new(0, 8)

local UpgradeStatus = Instance.new("TextLabel")
UpgradeStatus.Size = UDim2.new(0.9, 0, 0, 25)
UpgradeStatus.Position = UDim2.new(0.05, 0, 0.18, 0)
UpgradeStatus.BackgroundTransparency = 1
UpgradeStatus.Text = "Estado: ❌ Inactivo"
UpgradeStatus.TextColor3 = Color3.fromRGB(180, 180, 180)
UpgradeStatus.TextSize = 12
UpgradeStatus.Font = Enum.Font.Gotham
UpgradeStatus.TextXAlignment = Enum.TextXAlignment.Left
UpgradeStatus.Parent = MejorasPanel

local AutoRebirthBtn = Instance.new("TextButton")
AutoRebirthBtn.Size = UDim2.new(0.9, 0, 0, 45)
AutoRebirthBtn.Position = UDim2.new(0.05, 0, 0.25, 0)
AutoRebirthBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
AutoRebirthBtn.Text = "🔄 Auto Renacer"
AutoRebirthBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoRebirthBtn.Font = Enum.Font.GothamSemibold
AutoRebirthBtn.TextSize = 14
AutoRebirthBtn.BorderSizePixel = 0
AutoRebirthBtn.Parent = MejorasPanel
local AutoRebirthCorner = Instance.new("UICorner", AutoRebirthBtn)
AutoRebirthCorner.CornerRadius = UDim.new(0, 8)

local RebirthStatus = Instance.new("TextLabel")
RebirthStatus.Size = UDim2.new(0.9, 0, 0, 25)
RebirthStatus.Position = UDim2.new(0.05, 0, 0.38, 0)
RebirthStatus.BackgroundTransparency = 1
RebirthStatus.Text = "Estado: ❌ Inactivo"
RebirthStatus.TextColor3 = Color3.fromRGB(180, 180, 180)
RebirthStatus.TextSize = 12
RebirthStatus.Font = Enum.Font.Gotham
RebirthStatus.TextXAlignment = Enum.TextXAlignment.Left
RebirthStatus.Parent = MejorasPanel

-- Panel Ajustes
local AjustesPanel = Instance.new("ScrollingFrame")
AjustesPanel.Size = UDim2.new(1, 0, 1, 0)
AjustesPanel.BackgroundTransparency = 1
AjustesPanel.ScrollBarThickness = 5
AjustesPanel.CanvasSize = UDim2.new(0, 0, 0, 300)
AjustesPanel.Visible = false
AjustesPanel.Parent = ContentContainer

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0.9, 0, 0, 25)
SpeedLabel.Position = UDim2.new(0.05, 0, 0.05, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Velocidad personalizada: 16"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize = 14
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = AjustesPanel

local SpeedSlider = Instance.new("TextBox")
SpeedSlider.Size = UDim2.new(0.9, 0, 0, 35)
SpeedSlider.Position = UDim2.new(0.05, 0, 0.12, 0)
SpeedSlider.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
SpeedSlider.Text = "16"
SpeedSlider.PlaceholderText = "Velocidad (default: 16)"
SpeedSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedSlider.Font = Enum.Font.Gotham
SpeedSlider.TextSize = 14
SpeedSlider.BorderSizePixel = 0
SpeedSlider.Parent = AjustesPanel
local SpeedSliderCorner = Instance.new("UICorner", SpeedSlider)
SpeedSliderCorner.CornerRadius = UDim.new(0, 8)

local JumpLabel = Instance.new("TextLabel")
JumpLabel.Size = UDim2.new(0.9, 0, 0, 25)
JumpLabel.Position = UDim2.new(0.05, 0, 0.22, 0)
JumpLabel.BackgroundTransparency = 1
JumpLabel.Text = "Salto personalizado: 50"
JumpLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpLabel.TextSize = 14
JumpLabel.Font = Enum.Font.Gotham
JumpLabel.TextXAlignment = Enum.TextXAlignment.Left
JumpLabel.Parent = AjustesPanel

local JumpSlider = Instance.new("TextBox")
JumpSlider.Size = UDim2.new(0.9, 0, 0, 35)
JumpSlider.Position = UDim2.new(0.05, 0, 0.29, 0)
JumpSlider.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
JumpSlider.Text = "50"
JumpSlider.PlaceholderText = "Salto (default: 50)"
JumpSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpSlider.Font = Enum.Font.Gotham
JumpSlider.TextSize = 14
JumpSlider.BorderSizePixel = 0
JumpSlider.Parent = AjustesPanel
local JumpSliderCorner = Instance.new("UICorner", JumpSlider)
JumpSliderCorner.CornerRadius = UDim.new(0, 8)

local AntiAFKBtn = Instance.new("TextButton")
AntiAFKBtn.Size = UDim2.new(0.9, 0, 0, 45)
AntiAFKBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
AntiAFKBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
AntiAFKBtn.Text = "🟢 Anti AFK (ON)"
AntiAFKBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiAFKBtn.Font = Enum.Font.GothamSemibold
AntiAFKBtn.TextSize = 14
AntiAFKBtn.BorderSizePixel = 0
AntiAFKBtn.Parent = AjustesPanel
local AntiAFKCorner = Instance.new("UICorner", AntiAFKBtn)
AntiAFKCorner.CornerRadius = UDim.new(0, 8)

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(0.9, 0, 0, 30)
StatusLabel.Position = UDim2.new(0.05, 0, 0.55, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "✅ Scripts JoseAngel_Blox cargado"
StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
StatusLabel.TextSize = 12
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Parent = AjustesPanel

-- Botón para arrastrar
local Draggable = false
local DragStart
local StartPos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Draggable = true
        DragStart = input.Position
        StartPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if Draggable and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - DragStart
        MainFrame.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + delta.X, StartPos.Y.Scale, StartPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Draggable = false
    end
end)

-- Funciones del script

function PerfectKick()
    -- Encuentra el Lucky Block
    local luckyBlock = Workspace:FindFirstChild("LuckyBlock") or Workspace:FindFirstChild("BlockToKick")
    if not luckyBlock then return end
    
    -- Simula patada perfecta (force max)
    local kickRemote = ReplicatedStorage:FindFirstChild("KickBlock") or ReplicatedStorage:FindFirstChild("StartKick")
    if kickRemote then
        kickRemote:FireServer("Perfect")
    end
end

function AutoKickLoop()
    while Kicking do
        PerfectKick()
        wait(2) -- Espera entre patadas
    end
end

function AutoCollectLoop()
    while Collecting do
        -- Busca monedas y objetos recolectables
        local drops = Workspace:GetDescendants()
        for _, item in pairs(drops) do
            if item:IsA("BasePart") and (item.Name:lower():find("coin") or item.Name:lower():find("money") or item.Name:lower():find("drop") or item.Name:lower():find("brainrot")) then
                local character = Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    local hrp = character.HumanoidRootPart
                    local distance = (hrp.Position - item.Position).Magnitude
                    if distance < 50 then
                        -- Acercarse al objeto
                        hrp.CFrame = CFrame.new(item.Position)
                    end
                end
            end
        end
        wait(0.5)
    end
end

function AutoPlaceBrainrots()
    while Placing do
        -- Encuentra pedestal vacío en la parcela del jugador
        local base = Workspace:FindFirstChild(LocalPlayer.Name) or Workspace:FindFirstChild("Plots"):FindFirstChild(LocalPlayer.Name)
        if base then
            local pedestals = base:GetDescendants()
            for _, pedestal in pairs(pedestals) do
                if pedestal.Name:lower():find("pedestal") or pedestal.Name:lower():find("slot") then
                    local placeRemote = ReplicatedStorage:FindFirstChild("PlaceBrainrot") or ReplicatedStorage:FindFirstChild("PlacePet")
                    if placeRemote then
                        placeRemote:FireServer(pedestal)
                        wait(1)
                    end
                end
            end
        end
        wait(3)
    end
end

function AutoBuyAllUpgrades()
    while AutoUpgrade do
        -- Compra todas las mejoras disponibles: Peso, Fuerza de piernas, Suerte
        local upgradeTypes = {"Weight", "KickPower", "Luck", "Speed", "Jump"}
        for _, upgrade in pairs(upgradeTypes) do
            local buyRemote = ReplicatedStorage:FindFirstChild("BuyUpgrade") or ReplicatedStorage:FindFirstChild("PurchaseUpgrade")
            if buyRemote then
                buyRemote:FireServer(upgrade)
                wait(0.5)
            end
        end
        wait(5)
    end
end

function AutoRebirth()
    while AutoRebirthFlag do
        -- Verifica si se cumplen requisitos para renacer
        local rebirthRemote = ReplicatedStorage:FindFirstChild("Rebirth") or ReplicatedStorage:FindFirstChild("RequestRebirth")
        if rebirthRemote then
            rebirthRemote:FireServer()
        end
        wait(60) -- Verifica cada minuto
    end
end

function SurviveTsunami()
    local waterLevel = Workspace:FindFirstChild("WaterLevel") or Workspace:FindFirstChild("Tsunami")
    if waterLevel and TsunamiSurvival then
        local character = Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local hrp = character.HumanoidRootPart
            local waterY = waterLevel.Position.Y
            if hrp.Position.Y < waterY + 5 then
                -- Eleva al personaje sobre el agua
                hrp.CFrame = CFrame.new(hrp.Position.X, waterY + 10, hrp.Position.Z)
            end
        end
    end
end

function AntiAFK()
    if AntiAFKEnabled then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton1(Vector2.new())
        wait(60)
        VirtualUser:ClickButton1(Vector2.new())
    end
end

function ApplyCustomStats()
    if Character and Humanoid then
        Humanoid.WalkSpeed = CustomSpeed
        Humanoid.JumpPower = CustomJumpPower
    end
end

-- Conectar eventos
CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = Character:WaitForChild("Humanoid")
    ApplyCustomStats()
end)

RunService.Heartbeat:Connect(function()
    if TsunamiSurvival then
        SurviveTsunami()
    end
    ApplyCustomStats()
    if AntiAFKEnabled then
        AntiAFK()
    end
end)

-- Funciones de la interfaz
AutoKickBtn.MouseButton1Click:Connect(function()
    Kicking = not Kicking
    AutoKickBtn.BackgroundColor3 = Kicking and Color3.fromRGB(85, 255, 85) or Color3.fromRGB(45, 45, 55)
    AutoKickBtn.Text = Kicking and "✅ Auto Patear ACTIVADO" or "⚽ Auto Patear (Perfect Kick)"
    KickStatus.Text = Kicking and "Estado: ✅ Activo" or "Estado: ❌ Inactivo"
    if Kicking then
        coroutine.wrap(AutoKickLoop)()
    end
end)

AutoCollectBtn.MouseButton1Click:Connect(function()
    Collecting = not Collecting
    AutoCollectBtn.BackgroundColor3 = Collecting and Color3.fromRGB(85, 255, 85) or Color3.fromRGB(45, 45, 55)
    AutoCollectBtn.Text = Collecting and "✅ Auto Recolectar ACTIVADO" or "💰 Auto Recolectar"
    CollectStatus.Text = Collecting and "Estado: ✅ Activo" or "Estado: ❌ Inactivo"
    if Collecting then
        coroutine.wrap(AutoCollectLoop)()
    end
end)

AutoPlaceBtn.MouseButton1Click:Connect(function()
    Placing = not Placing
    AutoPlaceBtn.BackgroundColor3 = Placing and Color3.fromRGB(85, 255, 85) or Color3.fromRGB(45, 45, 55)
    AutoPlaceBtn.Text = Placing and "✅ Auto Colocar ACTIVADO" or "🧠 Auto Colocar Brainrots"
    PlaceStatus.Text = Placing and "Estado: ✅ Activo" or "Estado: ❌ Inactivo"
    if Placing then
        coroutine.wrap(AutoPlaceBrainrots)()
    end
end)

AutoBuyBtn.MouseButton1Click:Connect(function()
    AutoUpgrade = not AutoUpgrade
    AutoBuyBtn.BackgroundColor3 = AutoUpgrade and Color3.fromRGB(85, 255, 85) or Color3.fromRGB(45, 45, 55)
    AutoBuyBtn.Text = AutoUpgrade and "✅ Auto Comprar ACTIVADO" or "🛒 Auto Comprar TODAS las mejoras"
    UpgradeStatus.Text = AutoUpgrade and "Estado: ✅ Activo" or "Estado: ❌ Inactivo"
    if AutoUpgrade then
        coroutine.wrap(AutoBuyAllUpgrades)()
    end
end)

AutoRebirthBtn.MouseButton1Click:Connect(function()
    AutoRebirthFlag = not AutoRebirthFlag
    AutoRebirthBtn.BackgroundColor3 = AutoRebirthFlag and Color3.fromRGB(85, 255, 85) or Color3.fromRGB(45, 45, 55)
    AutoRebirthBtn.Text = AutoRebirthFlag and "✅ Auto Renacer ACTIVADO" or "🔄 Auto Renacer"
    RebirthStatus.Text = AutoRebirthFlag and "Estado: ✅ Activo" or "Estado: ❌ Inactivo"
    if AutoRebirthFlag then
        coroutine.wrap(AutoRebirth)()
    end
end)

TsunamiBtn.MouseButton1Click:Connect(function()
    TsunamiSurvival = not TsunamiSurvival
    TsunamiBtn.BackgroundColor3 = TsunamiSurvival and Color3.fromRGB(85, 255, 85) or Color3.fromRGB(0, 120, 200)
    TsunamiBtn.Text = TsunamiSurvival and "✅ Sobrevivir Tsunami (ON)" or "🌊 Sobrevivir Tsunami (OFF)"
end)

AntiAFKBtn.MouseButton1Click:Connect(function()
    AntiAFKEnabled = not AntiAFKEnabled
    AntiAFKBtn.BackgroundColor3 = AntiAFKEnabled and Color3.fromRGB(85, 255, 85) or Color3.fromRGB(0, 120, 200)
    AntiAFKBtn.Text = AntiAFKEnabled and "🟢 Anti AFK (ON)" or "🔴 Anti AFK (OFF)"
end)

SpeedSlider.FocusLost:Connect(function()
    local val = tonumber(SpeedSlider.Text)
    if val then
        CustomSpeed = math.clamp(val, 16, 100)
        SpeedLabel.Text = "Velocidad personalizada: " .. CustomSpeed
        ApplyCustomStats()
    end
    SpeedSlider.Text = CustomSpeed
end)

JumpSlider.FocusLost:Connect(function()
    local val = tonumber(JumpSlider.Text)
    if val then
        CustomJumpPower = math.clamp(val, 50, 200)
        JumpLabel.Text = "Salto personalizado: " .. CustomJumpPower
        ApplyCustomStats()
    end
    JumpSlider.Text = CustomJumpPower
end)

-- Cambio de pestañas
PrincipalBtn.MouseButton1Click:Connect(function()
    PrincipalPanel.Visible = true
    MejorasPanel.Visible = false
    AjustesPanel.Visible = false
    PrincipalBtn.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
    MejorasBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    AjustesBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
end)

MejorasBtn.MouseButton1Click:Connect(function()
    PrincipalPanel.Visible = false
    MejorasPanel.Visible = true
    AjustesPanel.Visible = false
    PrincipalBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    MejorasBtn.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
    AjustesBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
end)

AjustesBtn.MouseButton1Click:Connect(function()
    PrincipalPanel.Visible = false
    MejorasPanel.Visible = false
    AjustesPanel.Visible = true
    PrincipalBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    MejorasBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    AjustesBtn.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
end)

-- Mostrar GUI
ScreenGui.Parent = PlayerGui
MainFrame.Parent = ScreenGui

-- Notificación de bienvenida
local notification = Instance.new("TextLabel")
notification.Size = UDim2.new(0, 300, 0, 50)
notification.Position = UDim2.new(0.5, -150, 0.85, 0)
notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
notification.BackgroundTransparency = 0.3
notification.Text = "✨ Scripts JoseAngel_Blox cargado ✨"
notification.TextColor3 = Color3.fromRGB(255, 255, 255)
notification.TextSize = 16
notification.Font = Enum.Font.GothamBold
notification.Parent = ScreenGui

local notifCorner = Instance.new("UICorner", notification)
notifCorner.CornerRadius = UDim.new(0, 10)

wait(3)
notification:Destroy()

print("✅ Scripts JoseAngel_Blox para Kick a Lucky Block cargado correctamente")
print("📌 Compatible con Delta Executor")
