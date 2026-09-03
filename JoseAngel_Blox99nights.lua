-- ╔══════════════════════════════════════════════╗
-- ║          99 Noches en el Bosque               ║
-- ║         Creado por: JoseAngel_Blox            ║
-- ║              Versión 1.1 📱 Móvil             ║
-- ║            ✅ ERROR CORREGIDO                 ║
-- ╚══════════════════════════════════════════════╝

-- === SERVICIOS ===
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- === VARIABLES GLOBALES ===
local selectedFuel = nil
local selectedFood = nil
local spawnFuelEnabled = false
local spawnFoodEnabled = false
local killAuraEnabled = false
local autoFuelEnabled = false
local godmodeEnabled = false
local currentTab = "Info"

-- === FUNCIÓN AUXILIAR: ESQUINAS REDONDEADAS (compatible) ===
local function addCornerRadius(instance, radius)
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, radius)
    UICorner.Parent = instance
    return UICorner
end

-- === CREAR INTERFAZ — DISEÑO COMPATIBLE ===
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "99NochesScript"
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Ventana Principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.05, 0, 0.05, 0)
MainFrame.Size = UDim2.new(0, 340, 0, 420)
MainFrame.Active = true
MainFrame.Draggable = true
addCornerRadius(MainFrame, 16) -- ✅ Esquinas redondeadas SIN error

-- Título Principal
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0.5, 0, 0, 15)
TitleLabel.Size = UDim2.new(0, 310, 0, 35)
TitleLabel.Font = Enum.Font.GothamBlack
TitleLabel.Text = "99 Noches en el Bosque"
TitleLabel.TextColor3 = Color3.fromRGB(255, 60, 60)
TitleLabel.TextScaled = true
TitleLabel.TextXAlignment = Enum.TextXAlignment.Center

-- Subtítulo — Creado por (transparente)
local CreatorLabel = Instance.new("TextLabel")
CreatorLabel.Name = "CreatorLabel"
CreatorLabel.Parent = MainFrame
CreatorLabel.BackgroundTransparency = 1
CreatorLabel.Position = UDim2.new(0.5, 0, 0, 52)
CreatorLabel.Size = UDim2.new(0, 280, 0, 22)
CreatorLabel.Font = Enum.Font.Gotham
CreatorLabel.Text = "Creado por JoseAngel_Blox"
CreatorLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
CreatorLabel.TextTransparency = 0.4
CreatorLabel.TextScaled = true
CreatorLabel.TextXAlignment = Enum.TextXAlignment.Center

-- Línea Separadora
local Line = Instance.new("Frame")
Line.Parent = MainFrame
Line.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
Line.Position = UDim2.new(0.05, 0, 0, 80)
Line.Size = UDim2.new(0.9, 0, 2, 0)

-- Panel Pestañas (Izquierda)
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Parent = MainFrame
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0.03, 0, 0, 90)
TabContainer.Size = UDim2.new(0, 90, 0, 320)

-- Panel Contenido (Derecha)
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Parent = MainFrame
ContentContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
ContentContainer.Position = UDim2.new(0.32, 0, 0, 90)
ContentContainer.Size = UDim2.new(0, 225, 0, 320)
addCornerRadius(ContentContainer, 10)

-- === FUNCIÓN PARA CREAR BOTONES DE PESTAÑA ===
local function createTabButton(name, posY)
    local btn = Instance.new("TextButton")
    btn.Name = name.."Tab"
    btn.Parent = TabContainer
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    btn.Position = UDim2.new(0, 0, 0, posY)
    btn.Size = UDim2.new(0, 85, 0, 40)
    btn.Font = Enum.Font.GothamBold
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    btn.TextScaled = true
    btn.AutoLocalize = false
    addCornerRadius(btn, 8)
    return btn
end

-- Crear Pestañas
local InfoTabBtn = createTabButton("Info", 0)
local MainTabBtn = createTabButton("Main", 50)
local TpTabBtn = createTabButton("Tp", 100)

-- === FUNCIÓN PARA ACTIVAR/DESTACAR PESTAÑA ===
local function setActiveTab(tabName)
    currentTab = tabName
    InfoTabBtn.BackgroundColor3 = tabName == "Info" and Color3.fromRGB(255, 60, 60) or Color3.fromRGB(50, 50, 70)
    MainTabBtn.BackgroundColor3 = tabName == "Main" and Color3.fromRGB(255, 60, 60) or Color3.fromRGB(50, 50, 70)
    TpTabBtn.BackgroundColor3 = tabName == "Tp" and Color3.fromRGB(255, 60, 60) or Color3.fromRGB(50, 50, 70)
end

-- === FUNCIÓN PARA LIMPIAR CONTENIDO ===
local function clearContent()
    for _, child in ipairs(ContentContainer:GetChildren()) do
        if child:IsA("GuiObject") or child:IsA("UICorner") then child:Destroy() end
    end
end

-- === FUNCIÓN PARA CREAR BOTONES Y TOGGLES ===
local function createToggle(name, posY, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = ContentContainer
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
    btn.Position = UDim2.new(0.05, 0, 0, posY)
    btn.Size = UDim2.new(0.9, 0, 0, 32)
    btn.Font = Enum.Font.Gotham
    btn.Text = "❌ "..name
    btn.TextColor3 = Color3.fromRGB(230, 230, 230)
    btn.TextScaled = true
    btn.AutoLocalize = false
    addCornerRadius(btn, 6)
    local enabled = false
    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        btn.Text = (enabled and "✅ " or "❌ ")..name
        btn.BackgroundColor3 = enabled and Color3.fromRGB(40, 120, 70) or Color3.fromRGB(60, 60, 90)
        callback(enabled)
    end)
    return btn
end

local function createButton(name, posY, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = ContentContainer
    btn.BackgroundColor3 = Color3.fromRGB(70, 50, 100)
    btn.Position = UDim2.new(0.05, 0, 0, posY)
    btn.Size = UDim2.new(0.9, 0, 0, 30)
    btn.Font = Enum.Font.Gotham
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.AutoLocalize = false
    addCornerRadius(btn, 6)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function createLabel(text, posY, color)
    local lbl = Instance.new("TextLabel")
    lbl.Parent = ContentContainer
    lbl.BackgroundTransparency = 1
    lbl.Position = UDim2.new(0.05, 0, 0, posY)
    lbl.Size = UDim2.new(0.9, 0, 0, 22)
    lbl.Font = Enum.Font.GothamBold
    lbl.Text = text
    lbl.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    lbl.TextScaled = true
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.AutoLocalize = false
    return lbl
end

-- === CONTENIDO PESTAÑA INFO ===
local function loadInfoTab()
    clearContent()
    createLabel("📋 Información", 5, Color3.fromRGB(255, 100, 100))
    createLabel("Nombre del creador:", 40)
    createLabel("  JoseAngel_Blox", 62)
    createLabel("Fecha de lanzamiento:", 92)
    createLabel("  03/09/2026", 114)
    createLabel("Versión:", 144)
    createLabel("  1.1", 166)
    createLabel("UPDATE:", 196, Color3.fromRGB(255, 200, 60))
    local updateBox = Instance.new("TextLabel")
    updateBox.Parent = ContentContainer
    updateBox.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    updateBox.Position = UDim2.new(0.05, 0, 220)
    updateBox.Size = UDim2.new(0.9, 0, 0, 80)
    updateBox.Font = Enum.Font.Gotham
    updateBox.Text = "Nuevo script sencillo y facil de usar con este script aprenderas a usar un script para 99 noches en el bosque y después le vamos aumentando la dificultad espero y lo disfrutes.."
    updateBox.TextColor3 = Color3.fromRGB(220, 220, 220)
    updateBox.TextScaled = true
    updateBox.TextWrapped = true
    updateBox.TextXAlignment = Enum.TextXAlignment.Left
    updateBox.TextYAlignment = Enum.TextYAlignment.Top
    updateBox.AutoLocalize = false
    addCornerRadius(updateBox, 6)
end

-- === CONTENIDO PESTAÑA MAIN ===
local function loadMainTab()
    clearContent()
    local y = 5
    
    -- 🔥 FUEL
    createLabel("🔥 Fuel", y, Color3.fromRGB(255, 140, 0))
    y = y + 25
    createLabel("Select Fuel ↓", y)
    y = y + 25
    createButton("Coal", y, function() selectedFuel = "Coal"; print("✅ Seleccionado: Coal") end); y += 30
    createButton("Log", y, function() selectedFuel = "Log"; print("✅ Seleccionado: Log") end); y += 30
    createButton("Oil Barrer", y, function() selectedFuel = "Oil Barrer"; print("✅ Seleccionado: Oil Barrer") end); y += 30
    createButton("Fuel Canister", y, function() selectedFuel = "Fuel Canister"; print("✅ Seleccionado: Fuel Canister") end); y += 30
    createButton("Biofuel", y, function() selectedFuel = "Biofuel"; print("✅ Seleccionado: Biofuel") end); y += 35
    createToggle("Spawn ítem (Toggle)", y, function(enabled) spawnFuelEnabled = enabled end); y += 40
    
    -- 🥩 FOOD
    createLabel("🥩 Food", y, Color3.fromRGB(220, 60, 60))
    y = y + 25
    createLabel("Select Food ↓", y)
    y = y + 25
    createButton("Morsel", y, function() selectedFood = "Morsel"; print("✅ Seleccionado: Morsel") end); y += 30
    createButton("Steak", y, function() selectedFood = "Steak"; print("✅ Seleccionado: Steak") end); y += 35
    createToggle("Spawn ítem (Toggle)", y, function(enabled) spawnFoodEnabled = enabled end); y += 40
    
    -- 🗡️ AUTO
    createLabel("🗡️ Auto", y, Color3.fromRGB(120, 200, 60))
    y = y + 25
    createToggle("Kill Aura", y, function(e) killAuraEnabled = e end); y += 35
    createToggle("Auto Fuel", y, function(e) autoFuelEnabled = e end); y += 35
    createToggle("Godmode", y, function(e) godmodeEnabled = e end)
end

-- === CONTENIDO PESTAÑA TP ===
local function loadTpTab()
    clearContent()
    createLabel("📍 Teletransportación", 5, Color3.fromRGB(80, 200, 255))
    createButton("Tp al Camp (RescueZone)", 45, function()
        local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
        local zone = workspace:FindFirstChild("RescueZone")
        if hrp and zone then hrp.CFrame = zone.CFrame end
    end)
    createButton("Tp a Stronghold", 90, function()
        local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
        local sh = workspace:FindFirstChild("Stronghold")
        if hrp and sh then hrp.CFrame = sh.CFrame end
    end)
end

-- === ASIGNAR CLICKS A PESTAÑAS ===
InfoTabBtn.MouseButton1Click:Connect(function() setActiveTab("Info"); loadInfoTab() end)
MainTabBtn.MouseButton1Click:Connect(function() setActiveTab("Main"); loadMainTab() end)
TpTabBtn.MouseButton1Click:Connect(function() setActiveTab("Tp"); loadTpTab() end)

-- === CARGAR PESTAÑA INICIAL ===
loadInfoTab()
setActiveTab("Info")

-- === LOOP DE FUNCIONES ACTIVAS ===
task.spawn(function()
    while task.wait(0.5) do
        local char = Player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChild("Humanoid")
        if not hrp or not hum then continue end
        
        -- Godmode
        if godmodeEnabled then hum.Health = 100 end
        
        -- Kill Aura
        if killAuraEnabled then
            for _, v in ipairs(workspace:GetChildren()) do
                if v:IsA("Model") and v ~= char and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
                    local dist = (v.HumanoidRootPart.Position - hrp.Position).Magnitude
                    if dist < 25 then v.Humanoid.Health = 0 end
                end
            end
        end
        
        -- Auto Fuel
        if autoFuelEnabled then
            local zone = workspace:FindFirstChild("RescueZone")
            if zone and selectedFuel then
                for _, v in ipairs(workspace:GetChildren()) do
                    if v:IsA("BasePart") and string.find(v.Name:lower(), selectedFuel:lower()) then
                        v.Position = zone.Position + Vector3.new(math.random(-3,3), 2, math.random(-3,3))
                    end
                end
            end
        end
    end
end)

-- === NOTIFICACIÓN DE CARGA ===
pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "✅ Script Cargado",
        Text = "99 Noches en el Bosque — JoseAngel_Blox",
        Duration = 3
    })
end)

print("[✅] Script cargado correctamente — 99 Noches en el Bosque v1.1 (Corregido)")
