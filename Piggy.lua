--[[
    JoseAngel_Blox Piggy PRO v1.2 (MOBILE FIX)
    Creador: JoseAngel_Blox | 10/07/2026
--]]

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- ===== VARIABLES =====
local ESPEnabled, ESPItemsEnabled, NoclipEnabled = false, false, false
local GodModeEnabled, AutoGrabEnabled, SpeedJumpEnabled = false, false, false
local InvisibleEnabled, KillAuraEnabled = false, false
local PiggyKillAuraEnabled, PiggyESPEnabled = false, false
local PiggySpeedJumpEnabled, PiggyHitboxEnabled = false, false

local speedValue, jumpValue = 24, 70
local piggySpeedValue, piggyJumpValue = 40, 120
local killAuraRange, piggyKillAuraRange = 20, 25
local hitboxMultiplier = 3

local ESPObjects, ESPItems, connections = {}, {}, {}

-- ===== CREAR GUI =====
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "JoseAngel_Blox_GUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- MAIN FRAME
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 350, 0, 450)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -225)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(200, 0, 0)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = mainFrame

-- TITLE
local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, 0, 0, 40)
titleText.BackgroundTransparency = 1
titleText.Text = "JoseAngel_Blox Piggy PRO"
titleText.TextColor3 = Color3.fromRGB(220, 0, 0)
titleText.TextSize = 20
titleText.Font = Enum.Font.GothamBold
titleText.Parent = mainFrame

-- SCROLLING FRAME
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -10, 1, -50)
scroll.Position = UDim2.new(0, 5, 0, 45)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 4
scroll.CanvasSize = UDim2.new(0, 0, 0, 850)
scroll.Parent = mainFrame

local list = Instance.new("UIListLayout")
list.Padding = UDim.new(0, 5)
list.HorizontalAlignment = Enum.HorizontalAlignment.Center
list.Parent = scroll

-- ===== FUNCIONES GUI =====
function createSection(title)
    local lab = Instance.new("TextLabel")
    lab.Size = UDim2.new(1, -10, 0, 30)
    lab.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
    lab.Text = "  " .. title
    lab.TextColor3 = Color3.fromRGB(255, 0, 0)
    lab.TextXAlignment = Enum.TextXAlignment.Left
    lab.Font = Enum.Font.GothamBold
    lab.TextSize = 14
    lab.Parent = scroll
    Instance.new("UICorner", lab).CornerRadius = UDim.new(0, 6)
end

function createInfo(text)
    local lab = Instance.new("TextLabel")
    lab.Size = UDim2.new(1, -20, 0, 20)
    lab.BackgroundTransparency = 1
    lab.Text = text
    lab.TextColor3 = Color3.fromRGB(200, 200, 200)
    lab.TextSize = 12
    lab.Font = Enum.Font.Gotham
    lab.TextXAlignment = Enum.TextXAlignment.Left
    lab.Parent = scroll
end

function createToggle(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Text = text .. ": OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.Parent = scroll
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    local enabled = false
    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        btn.Text = text .. (enabled and ": ON" or ": OFF")
        btn.BackgroundColor3 = enabled and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(25, 25, 25)
        pcall(callback, enabled)
    end)
end

-- ============================================================
--  CONTENIDO
-- ============================================================

createSection("INFO")
createInfo("Nombre: JoseAngel_Blox")
createInfo("Fecha: 10/07/2026")
createInfo("Versión: 1.2")

createSection("MAIN")
createToggle("ESP (Players/Bots)", function(v) ESPEnabled = v end)
createToggle("ESP Items", function(v) ESPItemsEnabled = v end)
createToggle("Noclip", function(v) NoclipEnabled = v end)
createToggle("God Mode", function(v) GodModeEnabled = v end)
createToggle("Auto Grab Items", function(v) AutoGrabEnabled = v end)
createToggle("Speed + Jump", function(v) SpeedJumpEnabled = v end)
createToggle("Invisible", function(v) InvisibleEnabled = v end)
createToggle("Kill Aura", function(v) KillAuraEnabled = v end)

createSection("ROL PIGGY")
createToggle("Kill Aura Players", function(v) PiggyKillAuraEnabled = v end)
createToggle("ESP Players Only", function(v) PiggyESPEnabled = v end)
createToggle("Speed + Jump Pro", function(v) PiggySpeedJumpEnabled = v end)
createToggle("Hitbox Expand", function(v) PiggyHitboxEnabled = v end)

-- === LOOP DE FUNCIONES ===
task.spawn(function()
    while task.wait(0.3) do
        local myChar = player.Character
        if not myChar then continue end
        local root = myChar:FindFirstChild("HumanoidRootPart")
        local hum = myChar:FindFirstChild("Humanoid")
        
        -- Speed/Jump
        if SpeedJumpEnabled and hum then
            hum.WalkSpeed = speedValue
            hum.JumpPower = jumpValue
        elseif PiggySpeedJumpEnabled and hum then
            hum.WalkSpeed = piggySpeedValue
            hum.JumpPower = piggyJumpValue
        end
        
        -- God Mode
        if GodModeEnabled and hum then
            hum.MaxHealth = 100000
            hum.Health = 100000
        end

        -- Kill Aura
        if KillAuraEnabled or PiggyKillAuraEnabled then
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= player and p.Character and p.Character:FindFirstChild("Humanoid") then
                    local pRoot = p.Character:FindFirstChild("HumanoidRootPart")
                    if pRoot and (pRoot.Position - root.Position).Magnitude < killAuraRange then
                        p.Character.Humanoid.Health = 0
                    end
                end
            end
        end
    end
end)

-- Noclip Loop
game:GetService("RunService").Stepped:Connect(function()
    if NoclipEnabled and player.Character then
        for _, v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

print("JoseAngel_Blox Piggy PRO cargado!")
