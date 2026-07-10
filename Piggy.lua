--[[
    JoseAngel_Blox Piggy PRO v1.2
    Creador: JoseAngel_Blox | 10/07/2026
--]]

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local mouse = player:GetMouse()

-- ===== VARIABLES =====
local ESPEnabled = false
local ESPItemsEnabled = false
local NoclipEnabled = false
local GodModeEnabled = false
local AutoGrabEnabled = false
local SpeedJumpEnabled = false
local InvisibleEnabled = false
local KillAuraEnabled = false
local PiggyKillAuraEnabled = false
local PiggyESPEnabled = false
local PiggySpeedJumpEnabled = false
local PiggyHitboxEnabled = false

local speedValue = 24
local jumpValue = 70
local piggySpeedValue = 40
local piggyJumpValue = 120
local killAuraRange = 20
local piggyKillAuraRange = 25
local hitboxMultiplier = 3

local ESPObjects = {}
local ESPItems = {}
local connections = {}

-- ===== CREAR GUI =====
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "JoseAngel_Blox_GUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- MAIN FRAME (cuadrado con bordes rojos redondeados)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 380, 0, 520)
mainFrame.Position = UDim2.new(0.5, -190, 0.5, -260)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BackgroundTransparency = 0.08
mainFrame.BorderColor3 = Color3.fromRGB(200, 0, 0)
mainFrame.BorderSizePixel = 3
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.ClipsDescendants = true

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = mainFrame

-- TITLE BAR
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
titleBar.BackgroundTransparency = 0
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

-- TITLE (letras rojas)
local titleText = Instance.new("TextLabel")
titleText.Name = "TitleText"
titleText.Size = UDim2.new(1, 0, 1, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "JoseAngel_Blox Piggy PRO"
titleText.TextColor3 = Color3.fromRGB(220, 0, 0)
titleText.TextSize = 18
titleText.TextFont = Enum.Font.GothamBold
titleText.TextScaled = true
titleText.Font = Enum.Font.GothamBold
titleText.Parent = titleBar

-- CLOSE BUTTON
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 16
closeBtn.TextFont = Enum.Font.GothamBold
closeBtn.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

-- SCROLLING FRAME
local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Name = "ScrollingFrame"
scrollingFrame.Size = UDim2.new(1, -10, 1, -50)
scrollingFrame.Position = UDim2.new(0, 5, 0, 45)
scrollingFrame.BackgroundTransparency = 1
scrollingFrame.BorderSizePixel = 0
scrollingFrame.ScrollBarThickness = 6
scrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(180, 0, 0)
scrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollingFrame.Parent = mainFrame

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.Padding = UDim.new(0, 6)
uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiListLayout.Parent = scrollingFrame

-- ===== FUNCIONES AUXILIARES =====

function createSection(parent, title, icon)
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, -10, 0, 30)
    section.BackgroundColor3 = Color3.fromRGB(35, 10, 10)
    section.BackgroundTransparency = 0.2
    section.BorderSizePixel = 0
    section.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = section

    local sectionLabel = Instance.new("TextLabel")
    sectionLabel.Size = UDim2.new(1, -15, 1, 0)
    sectionLabel.Position = UDim2.new(0, 10, 0, 0)
    sectionLabel.BackgroundTransparency = 1
    sectionLabel.Text = icon .. " " .. title
    sectionLabel.TextColor3 = Color3.fromRGB(220, 0, 0)
    sectionLabel.TextSize = 16
    sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
    sectionLabel.TextFont = Enum.Font.GothamBold
    sectionLabel.Font = Enum.Font.GothamBold
    sectionLabel.Parent = section
    return section
end

function createInfoText(parent, text)
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, -10, 0, 22)
    infoLabel.BackgroundTransparency = 1
    infoLabel.Text = text
    infoLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    infoLabel.TextSize = 13
    infoLabel.TextXAlignment = Enum.TextXAlignment.Left
    infoLabel.TextFont = Enum.Font.Gotham
    infoLabel.Font = Enum.Font.Gotham
    infoLabel.Parent = parent
    return infoLabel
end

function createToggleButton(parent, text, callback)
    local container = Instance.new("Frame")
    container.Name = text:gsub("%s+", "_")
    container.Size = UDim2.new(1, -10, 0, 36)
    container.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    container.BackgroundTransparency = 0.15
    container.BorderSizePixel = 0
    container.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = container

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(60, 0, 0)
    stroke.Thickness = 1
    stroke.Transparency = 0.5
    stroke.Parent = container

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -45, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(200, 200, 200)
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextFont = Enum.Font.Gotham
    label.Font = Enum.Font.Gotham
    label.Parent = container

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 32, 0, 20)
    toggleBtn.Position = UDim2.new(1, -40, 0.5, -10)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
    toggleBtn.Text = ""
    toggleBtn.Parent = container

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 10)
    toggleCorner.Parent = toggleBtn

    local toggleCircle = Instance.new("Frame")
    toggleCircle.Name = "Circle"
    toggleCircle.Size = UDim2.new(0, 16, 0, 16)
    toggleCircle.Position = UDim2.new(0, 2, 0.5, -8)
    toggleCircle.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
    toggleCircle.BorderSizePixel = 0
    toggleCircle.Parent = toggleBtn

    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(0, 8)
    circleCorner.Parent = toggleCircle

    local enabled = false
    local function updateUI()
        if enabled then
            toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
            toggleCircle.Position = UDim2.new(0, 14, 0.5, -8)
            toggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        else
            toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
            toggleCircle.Position = UDim2.new(0, 2, 0.5, -8)
            toggleCircle.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
        end
    end

    toggleBtn.MouseButton1Click:Connect(function()
        enabled = not enabled
        updateUI()
        pcall(callback, enabled)
    end)
    return container, function() return enabled end
end

function getBots()
    local bots = {}
    for _, obj in pairs(game.Workspace:GetChildren()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and not game.Players:GetPlayerFromCharacter(obj) then
            table.insert(bots, obj)
        end
    end
    return bots
end

-- ============================================================
--  SECCIÓN 1: INFO
-- ============================================================
createSection(scrollingFrame, "Info", "📌")
createInfoText(scrollingFrame, "    ✦ Creador: JoseAngel_Blox")
createInfoText(scrollingFrame, "    ✦ Lanzamiento: 10/07/2026")
createInfoText(scrollingFrame, "    ✦ Versión: 1.2")

local sep1 = Instance.new("Frame")
sep1.Size = UDim2.new(1, -20, 0, 1)
sep1.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
sep1.BorderSizePixel = 0
sep1.Parent = scrollingFrame

-- ============================================================
--  SECCIÓN 2: MAIN
-- ============================================================
createSection(scrollingFrame, "Main", "⚙️")

local _, getESP
local _, getESPItems
local _, getNoclip
local _, getGodMode
local _, getAutoGrab
local _, getSpeedJump
local _, getInvisible
local _, getKillAura

-- ESP
_, getESP = createToggleButton(scrollingFrame, "ESP (Jugadores, Bots, Piggy)", function(state)
    ESPEnabled = state
    if state then enableESP() else disableESP() end
end)

-- ESP Items
_, getESPItems = createToggleButton(scrollingFrame, "ESP Items", function(state)
    ESPItemsEnabled = state
    if state then enableESPItems() else disableESPItems() end
end)

-- Noclip
_, getNoclip = createToggleButton(scrollingFrame, "Noclip", function(state)
    NoclipEnabled = state
    if state then enableNoclip() else disableNoclip() end
end)

-- God Mode
_, getGodMode = createToggleButton(scrollingFrame, "God Mode", function(state)
    GodModeEnabled = state
    if state then enableGodMode() else disableGodMode() end
end)

-- Auto Grab Items
_, getAutoGrab = createToggleButton(scrollingFrame, "Auto Grab Items", function(state)
    AutoGrabEnabled = state
end)

-- Speed + Jump
_, getSpeedJump = createToggleButton(scrollingFrame, "Speed + Jump", function(state)
    SpeedJumpEnabled = state
    if state then enableSpeedJump() else disableSpeedJump() end
end)

-- Invisible
_, getInvisible = createToggleButton(scrollingFrame, "Invisible", function(state)
    InvisibleEnabled = state
    if state then enableInvisible() else disableInvisible() end
end)

-- Kill Aura
_, getKillAura = createToggleButton(scrollingFrame, "Kill Aura", function(state)
    KillAuraEnabled = state
end)

local sep2 = Instance.new("Frame")
sep2.Size = UDim2.new(1, -20, 0, 1)
sep2.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
sep2.BorderSizePixel = 0
sep2.Parent = scrollingFrame

-- ============================================================
--  SECCIÓN 3: ROL PIGGY
-- ============================================================
createSection(scrollingFrame, "Rol Piggy", "🐷")

local _, getPiggyKillAura
local _, getPiggyESP
local _, getPiggySpeedJump
local _, getPiggyHitbox

_, getPiggyKillAura = createToggleButton(scrollingFrame, "Kill Aura Players", function(state)
    PiggyKillAuraEnabled = state
end)

_, getPiggyESP = createToggleButton(scrollingFrame, "ESP (Jugadores)", function(state)
    PiggyESPEnabled = state
    if state then enablePiggyESP() else disablePiggyESP() end
end)

_, getPiggySpeedJump = createToggleButton(scrollingFrame, "Speed + Jump (Extremo)", function(state)
    PiggySpeedJumpEnabled = state
    if state then enablePiggySpeedJump() else disablePiggySpeedJump() end
end)

_, getPiggyHitbox = createToggleButton(scrollingFrame, "Hit Box Expandido", function(state)
    PiggyHitboxEnabled = state
    if state then enablePiggyHitbox() else disablePiggyHitbox() end
end)

-- ============================================================
--  FUNCIONALIDADES
-- ============================================================

-- === ESP GENERAL ===
function enableESP()
    disableESP()
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= player then createESP(plr) end
    end
    connections.espAdded = game.Players.PlayerAdded:Connect(function(plr)
        if plr ~= player then
            plr.CharacterAdded:Connect(function()
                if ESPEnabled then createESP(plr) end
            end)
            if ESPEnabled then createESP(plr) end
        end
    end)
    local bots = getBots()
    for _, bot in pairs(bots) do createBotESP(bot) end
end

function disableESP()
    for _, obj in pairs(ESPObjects) do
        if obj and obj.Parent then obj:Destroy() end
    end
    ESPObjects = {}
    if connections.espAdded then connections.espAdded:Disconnect() connections.espAdded = nil end
end

function createESP(plr)
    local function setupChar(character)
        if not character or not ESPEnabled then return end
        local highlight = Instance.new("Highlight")
        highlight.Name = "JoseAngel_ESP"
        highlight.Adornee = character
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0.3
        highlight.FillColor = Color3.fromRGB(0, 100, 255)
        highlight.OutlineColor = Color3.fromRGB(0, 150, 255)
        highlight.Parent = character

        local billboard = Instance.new("BillboardGui")
        billboard.Name = "JoseAngel_ESP_Label"
        billboard.Adornee = character
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true

        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = plr.Name
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.TextSize = 14
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextStrokeTransparency = 0.3
        nameLabel.Parent = billboard

        local distLabel = Instance.new("TextLabel")
        distLabel.Size = UDim2.new(1, 0, 0.5, 0)
        distLabel.Position = UDim2.new(0, 0, 0.5, 0)
        distLabel.BackgroundTransparency = 1
        distLabel.Text = "Distancia: --"
        distLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        distLabel.TextSize = 12
        distLabel.Font = Enum.Font.Gotham
        distLabel.TextStrokeTransparency = 0.3
        distLabel.Parent = billboard

        billboard.Parent = character
        table.insert(ESPObjects, highlight)
        table.insert(ESPObjects, billboard)

        coroutine.wrap(function()
            while ESPEnabled and billboard and billboard.Parent do
                task.wait(0.5)
                local root = character:FindFirstChild("HumanoidRootPart")
                local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if root and myRoot then
                    local dist = math.floor((root.Position - myRoot.Position).Magnitude)
                    if distLabel then distLabel.Text = "📏 " .. tostring(dist) .. " studs" end
                end
            end
        end)()
    end
    if plr.Character then setupChar(plr.Character) end
    plr.CharacterAdded:Connect(function(char)
        if ESPEnabled then setupChar(char) end
    end)
end

function createBotESP(botModel)
    if not botModel or not botModel:FindFirstChild("Humanoid") then return end
    local highlight = Instance.new("Highlight")
    highlight.Name = "JoseAngel_Bot_ESP"
    highlight.Adornee = botModel
    highlight.FillTransparency = 0.4
    highlight.OutlineTransparency = 0.2
    highlight.FillColor = Color3.fromRGB(200, 0, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 50, 0)
    highlight.Parent = botModel

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "JoseAngel_Bot_Label"
    billboard.Adornee = botModel
    billboard.Size = UDim2.new(0, 150, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "🐷 BOT"
    nameLabel.TextColor3 = Color3.fromRGB(255, 50, 0)
    nameLabel.TextSize = 14
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextStrokeTransparency = 0.3
    nameLabel.Parent = billboard

    billboard.Parent = botModel
    table.insert(ESPObjects, highlight)
    table.insert(ESPObjects, billboard)
end

-- === ESP ITEMS ===
function enableESPItems()
    disableESPItems()
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Transparency < 1 then
            if obj.Name:lower():find("key") or obj.Name:lower():find("item") or obj.Name:lower():find("coin") or obj.Name:lower():find("gem") or obj.Name:lower():find("tool") then
                createItemESP(obj)
            end
        end
    end
    connections.itemAdded = game.Workspace.DescendantAdded:Connect(function(obj)
        if ESPItemsEnabled and obj:IsA("BasePart") and obj.Transparency < 1 then
            if obj.Name:lower():find("key") or obj.Name:lower():find("item") or obj.Name:lower():find("coin") or obj.Name:lower():find("gem") or obj.Name:lower():find("tool") then
                createItemESP(obj)
            end
        end
    end)
end

function disableESPItems()
    for _, obj in pairs(ESPItems) do
        if obj and obj.Parent then obj:Destroy() end
    end
    ESPItems = {}
    if connections.itemAdded then connections.itemAdded:Disconnect() connections.itemAdded = nil end
end

function createItemESP(part)
    local highlight = Instance.new("Highlight")
    highlight.Name = "JoseAngel_Item_ESP"
    highlight.Adornee = part
    highlight.FillTransparency = 0.3
    highlight.OutlineTransparency = 0
    highlight.FillColor = Color3.fromRGB(255, 215, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 200, 0)
    highlight.Parent = part

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "JoseAngel_Item_Label"
    billboard.Adornee = part
    billboard.Size = UDim2.new(0, 100, 0, 30)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.AlwaysOnTop = true

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "⭐ " .. part.Name
    label.TextColor3 = Color3.fromRGB(255, 215, 0)
    label.TextSize = 12
    label.Font = Enum.Font.GothamBold
    label.TextStrokeTransparency = 0.3
    label.Parent = billboard

    billboard.Parent = part
    table.insert(ESPItems, highlight)
    table.insert(ESPItems, billboard)
end

-- === NOCLIP ===
function enableNoclip()
    disableNoclip()
    connections.noclipStepped = game.RunService.Stepped:Connect(function()
        if NoclipEnabled and player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end)
end

function disableNoclip()
    if connections.noclipStepped then connections.noclipStepped:Disconnect() connections.noclipStepped = nil end
    if player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = true end
        end
    end
end

-- === GOD MODE ===
function enableGodMode()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        local hum = player.Character:FindFirstChild("Humanoid")
        hum.MaxHealth = math.huge
        hum.Health = math.huge
        connections.godMode = hum.HealthChanged:Connect(function()
            if GodModeEnabled and hum then hum.Health = math.huge end
        end)
    end
end

function disableGodMode()
    if connections.godMode then connections.godMode:Disconnect() connections.godMode = nil end
end

-- === SPEED + JUMP ===
function enableSpeedJump()
    connections.speedJump = game.RunService.RenderStepped:Connect(function()
        if SpeedJumpEnabled and player.Character then
            local hum = player.Character:FindFirstChild("Humanoid")
            if hum then hum.WalkSpeed = speedValue hum.JumpPower = jumpValue end
        end
    end)
end

