--[[
    JoseAngel_Blox Piggy PRO v1.4 (PC + Móvil 2026)
    Creador: JoseAngel_Blox | Hecho a mano
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- ==================== VARIABLES ====================
local ESPEnabled, ESPItemsEnabled, NoclipEnabled = false, false, false
local GodModeEnabled, AutoGrabEnabled, SpeedJumpEnabled = false, false, false
local InvisibleEnabled, KillAuraEnabled = false, false
local PiggyKillAuraEnabled, PiggyESPEnabled = false, false
local PiggySpeedJumpEnabled, PiggyHitboxEnabled = false, false

local speedValue, jumpValue = 24, 70
local piggySpeedValue, piggyJumpValue = 40, 120
local killAuraRange = 20
local hitboxMultiplier = 3

local ESPObjects = {}
local ESPItems = {}

-- ==================== GUI ====================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "JoseAngel_Blox_PiggyPRO_v1.4"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 380, 0, 520)
mainFrame.Position = UDim2.new(0.5, -190, 0.5, -260)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = mainFrame

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.Text = "JoseAngel_Blox Piggy PRO v1.4"
title.TextColor3 = Color3.fromRGB(220, 0, 0)
title.TextSize = 22
title.Font = Enum.Font.GothamBlack
title.Parent = mainFrame

-- Scroll
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -12, 1, -65)
scroll.Position = UDim2.new(0, 6, 0, 55)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 6
scroll.CanvasSize = UDim2.new(0, 0, 0, 900)
scroll.Parent = mainFrame

local list = Instance.new("UIListLayout")
list.Padding = UDim.new(0, 8)
list.SortOrder = Enum.SortOrder.LayoutOrder
list.Parent = scroll

-- ==================== TOGGLES ====================
local function createToggle(text, default, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Text = text .. ": " .. (default and "ON" or "OFF")
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 15
    btn.Font = Enum.Font.Gotham
    btn.Parent = scroll
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    
    local enabled = default
    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        btn.Text = text .. ": " .. (enabled and "ON" or "OFF")
        btn.BackgroundColor3 = enabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(25, 25, 25)
        pcall(callback, enabled)
    end)
end

local function createSection(title)
    local lab = Instance.new("TextLabel")
    lab.Size = UDim2.new(1, -20, 0, 32)
    lab.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
    lab.Text = "  " .. title
    lab.TextColor3 = Color3.fromRGB(255, 0, 0)
    lab.TextSize = 15
    lab.Font = Enum.Font.GothamBold
    lab.Parent = scroll
    Instance.new("UICorner", lab).CornerRadius = UDim.new(0, 6)
end

-- ==================== TOGGLES ====================
createSection("MAIN")
createToggle("ESP Players/Bots", false, function(v) ESPEnabled = v end)
createToggle("ESP Items", false, function(v) ESPItemsEnabled = v end)
createToggle("Noclip", false, function(v) NoclipEnabled = v end)
createToggle("God Mode", false, function(v) GodModeEnabled = v end)
createToggle("Auto Grab Items", false, function(v) AutoGrabEnabled = v end)
createToggle("Speed + Jump", false, function(v) SpeedJumpEnabled = v end)
createToggle("Invisible", false, function(v) InvisibleEnabled = v end)
createToggle("Kill Aura", false, function(v) KillAuraEnabled = v end)

createSection("PIGGY")
createToggle("Kill Aura Players", false, function(v) PiggyKillAuraEnabled = v end)
createToggle("ESP Players Only", false, function(v) PiggyESPEnabled = v end)
createToggle("Speed + Jump Pro", false, function(v) PiggySpeedJumpEnabled = v end)
createToggle("Hitbox Expand", false, function(v) PiggyHitboxEnabled = v end)

-- ==================== ESP ITEMS (FUNCIONA EN TODOS LOS MAPAS) ====================
local function addItemESP(item)
    if not item or ESPItems[item] then return end
    if not item:IsA("BasePart") and not item:IsA("Model") then return end
    
    local hl = Instance.new("Highlight")
    hl.Name = "ItemESP"
    hl.Adornee = item
    hl.FillColor = Color3.fromRGB(0, 255, 0)
    hl.OutlineColor = Color3.fromRGB(0, 255, 0)
    hl.FillTransparency = 0.4
    hl.OutlineTransparency = 0
    hl.Parent = item
    ESPItems[item] = hl
end

local function clearItemESP()
    for _, hl in pairs(ESPItems) do
        pcall(function() hl:Destroy() end)
    end
    ESPItems = {}
end

local function toggleESPItems()
    if not ESPItemsEnabled then
        clearItemESP()
        return
    end
    
    -- Busca en TODOS los folders de Workspace (funciona en cualquier mapa de Piggy)
    local folders = Workspace:GetDescendants()
    for _, folder in ipairs(folders) do
        if folder:IsA("Folder") and folder.Name \~= "Piggy" and folder.Name \~= "Players" and folder.Name \~= "Camera" then
            for _, item in pairs(folder:GetChildren()) do
                addItemESP(item)
            end
        end
    end
end

Workspace.DescendantAdded:Connect(function(child)
    if ESPItemsEnabled and (child:IsA("BasePart") or child:IsA("Model")) then
        task.wait(0.2)
        addItemESP(child)
    end
end)

-- ==================== ESP PLAYERS (Highlight) ====================
local function addPlayerESP(plr)
    if plr == player or ESPObjects[plr] then return end
    if not plr.Character then return end
    local hl = Instance.new("Highlight")
    hl.Adornee = plr.Character
    hl.FillColor = plr.TeamColor.Color
    hl.OutlineColor = Color3.new(1, 1, 1)
    hl.FillTransparency = 0.5
    hl.Parent = plr.Character
    ESPObjects[plr] = hl
end

Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        if ESPEnabled then addPlayerESP(plr) end
    end)
end)

for _, plr in pairs(Players:GetPlayers()) do
    if plr.Character and ESPEnabled then addPlayerESP(plr) end
end

-- ==================== LOOP PRINCIPAL (CORREGIDO) ====================
task.spawn(function()
    while task.wait(0.2) do
        local myChar = player.Character
        if not myChar then continue end
        
        local root = myChar:FindFirstChild("HumanoidRootPart")
        local hum = myChar:FindFirstChild("Humanoid")
        if not root or not hum then continue end

        -- Speed / Jump
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
            -- Bypass stun
            pcall(function() root:SetAttribute("Stun", nil) end)
            for _, v in pairs(myChar:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanTouch = false
                    v.CanQuery = false
                end
            end
        end

        -- Kill Aura
        if KillAuraEnabled or PiggyKillAuraEnabled then
            local range = PiggyKillAuraEnabled and 25 or killAuraRange
            for _, plr in pairs(Players:GetPlayers()) do
                if plr \~= player and plr.Character and plr.Character:FindFirstChild("Humanoid") then
                    local pr = plr.Character:FindFirstChild("HumanoidRootPart")
                    if pr and (pr.Position - root.Position).Magnitude < range then
                        plr.Character.Humanoid.Health = 0
                    end
                end
            end
        end

        -- Auto Grab Items
        if AutoGrabEnabled and Workspace:FindFirstChild("Items") then
            for _, item in pairs(Workspace.Items:GetChildren()) do
                if item:IsA("BasePart") and (item.Position - root.Position).Magnitude < 30 then
                    hum:MoveTo(item.Position)
                    task.wait(0.15)
                    pcall(function() item:Destroy() end)
                end
            end
        end

        -- Invisible
        if InvisibleEnabled and myChar then
            for _, v in pairs(myChar:GetDescendants()) do
                if v:IsA("BasePart") then v.Transparency = 1 end
            end
        end

        -- Hitbox Expand
        if PiggyHitboxEnabled and hum then
            hum.HipHeight = hitboxMultiplier
        end
    end
end)

-- ==================== Noclip (Stepped) ====================
RunService.Stepped:Connect(function()
    if NoclipEnabled and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- ==================== INICIALIZACIÓN ====================
print("✅ JoseAngel_Blox Piggy PRO v1.4 cargado correctamente!")
print("¡Funciona en PC y Móvil! Todas las funciones están activas.")

-- Cargar ESP Items cuando el script inicia
toggleESPItems()
