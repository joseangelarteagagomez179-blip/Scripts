-- ============================================
-- FOXSTYLE HUB - 99 NIGHTS IN THE FOREST
-- Versión 2.0 (Optimizado para Delta)
-- Creado especialmente para ti, compadre
-- ============================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

-- ============================================
-- INTERFAZ DE USUARIO (UI)
-- ============================================
local uiParent = (gethui and gethui()) or game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")

if uiParent:FindFirstChild("FoxStyleHub") then
    uiParent.FoxStyleHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FoxStyleHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = uiParent

-- Marco principal (movible)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 380, 0, 420)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 15, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = MainFrame

-- Título
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 0, 0, 10)
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Text = "🦊 FOXSTYLE HUB"
TitleLabel.TextColor3 = Color3.fromRGB(255, 170, 0)
TitleLabel.TextSize = 24

-- Subtítulo
local SubLabel = Instance.new("TextLabel")
SubLabel.Parent = MainFrame
SubLabel.BackgroundTransparency = 1
SubLabel.Position = UDim2.new(0, 0, 0, 40)
SubLabel.Size = UDim2.new(1, 0, 0, 18)
SubLabel.Font = Enum.Font.SourceSansItalic
SubLabel.Text = "99 Nights in the Forest - Optimizado"
SubLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SubLabel.TextSize = 13

-- ============================================
-- SISTEMA DE PESTAÑAS (TABS)
-- ============================================
local TabHolder = Instance.new("Frame")
TabHolder.Parent = MainFrame
TabHolder.Position = UDim2.new(0, 10, 0, 65)
TabHolder.Size = UDim2.new(0, 70, 0, 345)
TabHolder.BackgroundColor3 = Color3.fromRGB(15, 25, 50)
TabHolder.BorderSizePixel = 0

local TabCorner = Instance.new("UICorner")
TabCorner.CornerRadius = UDim.new(0, 10)
TabCorner.Parent = TabHolder

local TabLayout = Instance.new("UIListLayout")
TabLayout.Parent = TabHolder
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Padding = UDim.new(0, 4)

local ContentHolder = Instance.new("Frame")
ContentHolder.Parent = MainFrame
ContentHolder.Position = UDim2.new(0, 88, 0, 65)
ContentHolder.Size = UDim2.new(0, 282, 0, 345)
ContentHolder.BackgroundColor3 = Color3.fromRGB(15, 25, 50)
ContentHolder.BorderSizePixel = 0

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 10)
ContentCorner.Parent = ContentHolder

-- ============================================
-- CREACIÓN DE PÁGINAS
-- ============================================
local pages = {}
local pageNames = {"🏠 Inicio", "⚔️ Combate", "🌲 Farmeo", "🚀 Utilidad", "📦 Items"}

local function CreatePage(name)
    local page = Instance.new("ScrollingFrame")
    page.Parent = ContentHolder
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 3
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.Visible = false
    
    local layout = Instance.new("UIListLayout")
    layout.Parent = page
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    
    local padding = Instance.new("UIPadding")
    padding.Parent = page
    padding.PaddingTop = UDim.new(0, 8)
    padding.PaddingBottom = UDim.new(0, 8)
    padding.PaddingLeft = UDim.new(0, 8)
    padding.PaddingRight = UDim.new(0, 8)
    
    return page
end

local pagesList = {}
for i, name in ipairs(pageNames) do
    pagesList[i] = CreatePage(name)
end
pagesList[1].Visible = true

-- Botones de pestañas
local function CreateTabButton(text, pageIndex)
    local btn = Instance.new("TextButton")
    btn.Parent = TabHolder
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(25, 45, 90)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 11
    btn.TextWrapped = true
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        for i, page in ipairs(pagesList) do
            page.Visible = (i == pageIndex)
        end
    end)
    return btn
end

for i, name in ipairs(pageNames) do
    CreateTabButton(name, i)
end

-- ============================================
-- FUNCIONES AUXILIARES
-- ============================================
local function CreateToggle(parent, text, callback)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.Size = UDim2.new(1, 0, 0, 32)
    frame.BackgroundColor3 = Color3.fromRGB(20, 35, 70)
    frame.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    
    local btn = Instance.new("TextButton")
    btn.Parent = frame
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = text .. ": OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.TextXAlignment = Enum.TextXAlignment.Left
    
    local status = Instance.new("TextLabel")
    status.Parent = frame
    status.Size = UDim2.new(0, 60, 1, 0)
    status.Position = UDim2.new(1, -65, 0, 0)
    status.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
    status.Font = Enum.Font.SourceSansBold
    status.Text = "OFF"
    status.TextColor3 = Color3.fromRGB(255, 255, 255)
    status.TextSize = 12
    
    local statusCorner = Instance.new("UICorner")
    statusCorner.CornerRadius = UDim.new(0, 4)
    statusCorner.Parent = status
    
    local toggled = false
    btn.MouseButton1Click:Connect(function()
        toggled = not toggled
        btn.Text = text .. (toggled and ": ON" or ": OFF")
        status.BackgroundColor3 = toggled and Color3.fromRGB(40, 180, 80) or Color3.fromRGB(180, 40, 40)
        status.Text = toggled and "ON" or "OFF"
        callback(toggled)
    end)
    
    return {btn = btn, status = status, frame = frame}
end

local function CreateButton(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function CreateSlider(parent, text, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.Size = UDim2.new(1, 0, 0, 40)
    frame.BackgroundColor3 = Color3.fromRGB(20, 35, 70)
    frame.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.Size = UDim2.new(1, 0, 0, 16)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.SourceSans
    label.Text = text .. ": " .. default
    label.TextColor3 = Color3.fromRGB(200, 200, 200)
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local slider = Instance.new("TextBox")
    slider.Parent = frame
    slider.Position = UDim2.new(0, 0, 0, 18)
    slider.Size = UDim2.new(1, 0, 0, 18)
    slider.BackgroundColor3 = Color3.fromRGB(10, 20, 45)
    slider.Font = Enum.Font.SourceSansBold
    slider.Text = tostring(default)
    slider.TextColor3 = Color3.fromRGB(255, 170, 0)
    slider.TextSize = 14
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 4)
    sliderCorner.Parent = slider
    
    slider.FocusLost:Connect(function()
        local val = tonumber(slider.Text)
        if val then
            val = math.clamp(val, min, max)
            slider.Text = tostring(val)
            label.Text = text .. ": " .. val
            callback(val)
        else
            slider.Text = tostring(default)
        end
    end)
    
    return {frame = frame, slider = slider, label = label}
end

-- ============================================
-- VARIABLES GLOBALES
-- ============================================
_G.FoxStyle = {
    KillAura = false,
    AutoFarm = false,
    AutoCook = false,
    AutoFuel = false,
    AutoScrapper = false,
    AutoRescue = false,
    Fly = false,
    InfinityJump = false,
    GodMode = false,
    NoHunger = false,
    Teleport = false,
    Speed = 16,
    JumpPower = 50,
    KillRange = 25,
}

-- ============================================
-- PÁGINA 1: INICIO (Información)
-- ============================================
local infoPage = pagesList[1]
local infoText = Instance.new("TextLabel")
infoText.Parent = infoPage
infoText.Size = UDim2.new(1, 0, 0, 0)
infoText.AutomaticSize = Enum.AutomaticSize.Y
infoText.BackgroundTransparency = 1
infoText.Font = Enum.Font.SourceSans
infoText.Text = [[🦊 FOXSTYLE HUB v2.0

Script optimizado para 99 Nights in the Forest
Funciona en Delta Executor y otros ejecutores

🔹 Creado para sobrevivir en el bosque
🔹 Sin claves ni verificaciones
🔹 Interfaz amigable y estable

Créditos: Inspirado en Foxname Hub
Desarrollado para la comunidad]]
infoText.TextColor3 = Color3.fromRGB(200, 200, 200)
infoText.TextSize = 13
infoText.TextWrapped = true
infoText.TextXAlignment = Enum.TextXAlignment.Left

-- ============================================
-- PÁGINA 2: COMBATE
-- ============================================
local combatPage = pagesList[2]

-- Kill Aura
CreateToggle(combatPage, "⚔️ Kill Aura", function(val)
    _G.FoxStyle.KillAura = val
end)

-- God Mode
CreateToggle(combatPage, "🛡️ God Mode", function(val)
    _G.FoxStyle.GodMode = val
    if val then
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.MaxHealth = math.huge
                hum.Health = math.huge
            end
        end
    end
end)

-- Rango de Kill Aura
CreateSlider(combatPage, "Rango de Ataque", 5, 50, 25, function(val)
    _G.FoxStyle.KillRange = val
end)

-- No Hunger (sin hambre)
CreateToggle(combatPage, "🍖 Sin Hambre", function(val)
    _G.FoxStyle.NoHunger = val
end)

-- ============================================
-- PÁGINA 3: FARMEO
-- ============================================
local farmPage = pagesList[3]

-- Auto Farm (genérico)
CreateToggle(farmPage, "🌲 Auto Farm (General)", function(val)
    _G.FoxStyle.AutoFarm = val
end)

-- Auto Cook
CreateToggle(farmPage, "🍳 Auto Cocinar", function(val)
    _G.FoxStyle.AutoCook = val
end)

-- Auto Fuel
CreateToggle(farmPage, "⛽ Auto Combustible", function(val)
    _G.FoxStyle.AutoFuel = val
end)

-- Auto Scrapper
CreateToggle(farmPage, "🔧 Auto Scrapper", function(val)
    _G.FoxStyle.AutoScrapper = val
end)

-- Auto Rescue
CreateToggle(farmPage, "🆘 Auto Rescate", function(val)
    _G.FoxStyle.AutoRescue = val
end)

-- Botón para traer items
CreateButton(farmPage, "📦 Traer Items al Jugador", function()
    pcall(function()
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        local pos = char.HumanoidRootPart.Position
        
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and v:IsA("Tool") and v.Parent and v.Parent:IsA("Model") then
                local distance = (v.Position - pos).Magnitude
                if distance < 100 then
                    v.CFrame = CFrame.new(pos + Vector3.new(0, 2, 0))
                end
            end
        end
    end)
end)

-- ============================================
-- PÁGINA 4: UTILIDAD
-- ============================================
local utilityPage = pagesList[4]

-- Fly
CreateToggle(utilityPage, "✈️ Fly", function(val)
    _G.FoxStyle.Fly = val
end)

-- Infinity Jump
CreateToggle(utilityPage, "🦘 Salto Infinito", function(val)
    _G.FoxStyle.InfinityJump = val
end)

-- Speed Slider
CreateSlider(utilityPage, "Velocidad", 10, 100, 16, function(val)
    _G.FoxStyle.Speed = val
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = val end
    end
end)

-- Jump Power Slider
CreateSlider(utilityPage, "Fuerza de Salto", 30, 200, 50, function(val)
    _G.FoxStyle.JumpPower = val
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.JumpPower = val end
    end
end)

-- Anti-AFK
CreateToggle(utilityPage, "🔄 Anti-AFK", function(val)
    _G.FoxStyle.AntiAFK = val
end)

-- ============================================
-- PÁGINA 5: ITEMS Y TELEPORT
-- ============================================
local itemsPage = pagesList[5]

-- Teletransportes
CreateButton(itemsPage, "🏕️ TP al Campamento", function()
    pcall(function()
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        local rescueZone = workspace:FindFirstChild("Map")
            and workspace.Map:FindFirstChild("Campground")
            and workspace.Map.Campground:FindFirstChild("NPCWaypoints")
            and workspace.Map.Campground.NPCWaypoints:FindFirstChild("RescueZone")
        if rescueZone then
            char.HumanoidRootPart.CFrame = rescueZone.CFrame + Vector3.new(0, 3, 0)
        end
    end)
end)

CreateButton(itemsPage, "🏰 TP a Stronghold", function()
    pcall(function()
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        local stronghold = workspace:FindFirstChild("Stronghold", true)
        if stronghold then
            char.HumanoidRootPart.CFrame = stronghold.CFrame + Vector3.new(0, 3, 0)
        end
    end)
end)

CreateButton(itemsPage, "🔄 TP al Scrapper", function()
    pcall(function()
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        local scrapper = workspace:FindFirstChild("Map")
            and workspace.Map:FindFirstChild("Campground")
            and workspace.Map.Campground:FindFirstChild("Scrapper")
        if scrapper then
            char.HumanoidRootPart.CFrame = scrapper.CFrame + Vector3.new(0, 3, 0)
        end
    end)
end)

CreateButton(itemsPage, "💎 TP a Diamantes", function()
    pcall(function()
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and string.lower(v.Name):find("diamond") then
                char.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0, 2, 0)
                break
            end
        end
    end)
end)

-- ============================================
-- BUCLE PRINCIPAL (LOOPS)
-- ============================================

-- KILL AURA
task.spawn(function()
    while task.wait(0.1) do
        if _G.FoxStyle.KillAura then
            pcall(function()
                local char = LocalPlayer.Character
                if not char then return end
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                local myPos = hrp.Position
                local range = _G.FoxStyle.KillRange or 25
                
                for _, v in ipairs(workspace:GetDescendants()) do
                    if v:IsA("Model") and v ~= char then
                        local enemyHrp = v:FindFirstChild("HumanoidRootPart")
                        local enemyHum = v:FindFirstChild("Humanoid")
                        if enemyHrp and enemyHum and enemyHum.Health > 0 then
                            if not Players:GetPlayerFromCharacter(v) then
                                if (enemyHrp.Position - myPos).Magnitude <= range then
                                    local tool = char:FindFirstChildOfClass("Tool")
                                    if tool then
                                        tool:Activate()
                                        task.wait(0.05)
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- AUTO COOK
task.spawn(function()
    while task.wait(2) do
        if _G.FoxStyle.AutoCook then
            pcall(function()
                local char = LocalPlayer.Character
                if not char then return end
                local hum = char:FindFirstChildOfClass("Humanoid")
                if not hum or hum.Health > 80 then return end
                
                local backpack = LocalPlayer.Backpack
                for _, item in ipairs(backpack:GetChildren()) do
                    if item:IsA("Tool") then
                        local name = item.Name:lower()
                        if name:find("steak") or name:find("morsel") or name:find("berry") then
                            char.Humanoid:EquipTool(item)
                            task.wait(0.3)
                            item:Activate()
                            break
                        end
                    end
                end
            end)
        end
    end
end)

-- AUTO FUEL
task.spawn(function()
    while task.wait(3) do
        if _G.FoxStyle.AutoFuel then
            pcall(function()
                local campfire = workspace:FindFirstChild("Map")
                    and workspace.Map:FindFirstChild("Campground")
                    and workspace.Map.Campground:FindFirstChild("Fire")
                if not campfire then return end
                if campfire.Size.Y > 5 then return end
                
                local backpack = LocalPlayer.Backpack
                for _, item in ipairs(backpack:GetChildren()) do
                    if item:IsA("Tool") then
                        local name = item.Name:lower()
                        if name:find("biofuel") or name:find("coal") or name:find("log") then
                            LocalPlayer.Character.Humanoid:EquipTool(item)
                            task.wait(0.3)
                            item:Activate()
                            break
                        end
                    end
                end
            end)
        end
    end
end)

-- AUTO SCRAPPER
task.spawn(function()
    while task.wait(0.5) do
        if _G.FoxStyle.AutoScrapper then
            pcall(function()
                local char = LocalPlayer.Character
                if not char then return end
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                
                local scrapper = workspace:FindFirstChild("Map")
                    and workspace.Map:FindFirstChild("Campground")
                    and workspace.Map.Campground:FindFirstChild("Scrapper")
       
