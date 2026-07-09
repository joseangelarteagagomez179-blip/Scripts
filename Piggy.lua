-- ==========================================
-- JOSEANGEL_BLOX PIGGY PRO - V1.2
-- ==========================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

-- Eliminar versión anterior si existe
if CoreGui:FindFirstChild("JoseAngelPiggyPro") then
    CoreGui.JoseAngelPiggyPro:Destroy()
end

-- ==========================================
-- INTERFAZ GRÁFICA (GUI)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngelPiggyPro"
ScreenGui.Parent = CoreGui

-- Fondo Principal (Ancho y Bajo)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 650, 0, 320)
MainFrame.Position = UDim2.new(0.5, -325, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Permite mover la ventana
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 80, 80)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "JoseAngel_Blox Piggy PRO"
Title.TextColor3 = Color3.fromRGB(255, 80, 80)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.Parent = MainFrame

-- Contenedor de Pestañas (Fila superior)
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -20, 0, 40)
TabContainer.Position = UDim2.new(0, 10, 0, 45)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 10)
TabListLayout.Parent = TabContainer

-- Contenedor de Páginas (Donde van las opciones)
local PageContainer = Instance.new("Frame")
PageContainer.Size = UDim2.new(1, -20, 1, -100)
PageContainer.Position = UDim2.new(0, 10, 0, 90)
PageContainer.BackgroundTransparency = 1
PageContainer.Parent = MainFrame

-- ==========================================
-- SISTEMA DE PESTAÑAS Y BOTONES
-- ==========================================
local tabs = {}
local pages = {}

local function createTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 200, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.Parent = TabContainer
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 4
    page.Visible = false
    page.Parent = PageContainer
    
    local pageLayout = Instance.new("UIListLayout")
    pageLayout.Padding = UDim.new(0, 8)
    pageLayout.Parent = page
    
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        for _, t in pairs(tabs) do t.BackgroundColor3 = Color3.fromRGB(40, 40, 50) end
        page.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    end)
    
    table.insert(tabs, btn)
    table.insert(pages, page)
    return page
end

local function createLabel(page, text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -10, 0, 30)
    lbl.BackgroundTransparency = 1
    lbl.Text = " " .. text
    lbl.TextColor3 = Color3.fromRGB(200, 200, 200)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 14
    lbl.Parent = page
end

local function createToggle(page, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    btn.Text = " [OFF] " .. text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.Parent = page
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = state and " [ON]  " .. text or " [OFF] " .. text
        btn.TextColor3 = state and Color3.fromRGB(80, 255, 80) or Color3.fromRGB(255, 255, 255)
        callback(state)
    end)
end

-- ==========================================
-- CONSTRUYENDO LAS PÁGINAS
-- ==========================================
local PageInfo = createTab("1) Info ↓")
local PagePlayers = createTab("2) Funciones Players")
local PagePiggy = createTab("3) Funciones de Piggy ↓")

-- Activar primera pestaña por defecto
tabs[1].BackgroundColor3 = Color3.fromRGB(255, 80, 80)
pages[1].Visible = true

-- [ PESTAÑA 1: INFO ]
createLabel(PageInfo, "Nombre del Creador: JoseAngel_Blox")
createLabel(PageInfo, "Fecha de lanzamiento: 09/06/2026")
createLabel(PageInfo, "Versión: 1.2")
createLabel(PageInfo, "Estado: Indetectable y Seguro")

-- ==========================================
-- LÓGICA DE LAS FUNCIONES (PLAYERS)
-- ==========================================

-- Variables Globales de Toggles
local ESP_Mobs, ESP_Items = false, false
local Noclip, GodMode, AutoGrab, AutoUnlock = false, false, false, false

-- 1. ESP Mobs (Jugadores y Piggy)
createToggle(PagePlayers, "ESP (Jugadores, Bots, Piggy)", function(state)
    ESP_Mobs = state
    while ESP_Mobs do
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:FindFirstChild("Humanoid") and v ~= LocalPlayer.Character then
                if not v:FindFirstChild("ESPHighlight") then
                    local hl = Instance.new("Highlight")
                    hl.Name = "ESPHighlight"
                    hl.FillColor = v.Name == "Piggy" and Color3.new(1, 0, 0) or Color3.new(0, 1, 0)
                    hl.Parent = v
                end
            end
        end
        task.wait(1)
    end
    -- Limpieza al apagar
    if not ESP_Mobs then
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:FindFirstChild("ESPHighlight") then v.ESPHighlight:Destroy() end
        end
    end
end)

-- 2. ESP Items (Mostrando Nombre y Studs)
createToggle(PagePlayers, "ESP Items", function(state)
    ESP_Items = state
    while ESP_Items do
        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        for _, item in pairs(Workspace:GetDescendants()) do
            if item:IsA("ProximityPrompt") or item:IsA("ClickDetector") then
                local part = item.Parent
                if part and part:IsA("BasePart") and root then
                    local dist = math.round((root.Position - part.Position).Magnitude)
                    
                    if not part:FindFirstChild("ItemESP") then
                        local bg = Instance.new("BillboardGui", part)
                        bg.Name = "ItemESP"
                        bg.Size = UDim2.new(0, 100, 0, 40)
                        bg.AlwaysOnTop = true
                        local txt = Instance.new("TextLabel", bg)
                        txt.Size = UDim2.new(1, 0, 1, 0)
                        txt.BackgroundTransparency = 1
                        txt.TextColor3 = Color3.new(0, 1, 1)
                        txt.Font = Enum.Font.GothamBold
                        txt.TextSize = 12
                    end
                    part.ItemESP.TextLabel.Text = part.Name .. "\n[" .. dist .. " studs]"
                end
            end
        end
        task.wait(0.5)
    end
    -- Limpieza
    if not ESP_Items then
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BillboardGui") and v.Name == "ItemESP" then v:Destroy() end
        end
    end
end)

-- 3. Noclip (Atravesar paredes)
createToggle(PagePlayers, "Noclip (Atravesar paredes)", function(state)
    Noclip = state
    RunService.Stepped:Connect(function()
        if Noclip and LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end)

-- 4. Speed + Jump
createToggle(PagePlayers, "Speed + Jump (Velocidad y Salto)", function(state)
    if state then
        LocalPlayer.Character.Humanoid.WalkSpeed = 50
        LocalPlayer.Character.Humanoid.JumpPower = 80
    else
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
        LocalPlayer.Character.Humanoid.JumpPower = 50
    end
end)

-- 5. Infinite Stamina
createToggle(PagePlayers, "Infinite Stamina", function(state)
    -- En Piggy, la estamina suele controlarse en un LocalScript. 
    -- Al forzar constantemente la velocidad, evitamos que el juego nos ponga a caminar.
    local connection
    if state then
        connection = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = 24 -- Velocidad de sprint constante
            end
        end)
    else
        if connection then connection:Disconnect() end
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

-- 6. God Mode
createToggle(PagePlayers, "God Mode", function(state)
    GodMode = state
    -- Eliminamos las partes táctiles enemigas localmente para que Piggy no pueda tocarnos
    while GodMode do
        for _, v in pairs(Workspace:GetDescendants()) do
            if v.Name == "Piggy" and v:FindFirstChild("HumanoidRootPart") then
                for _, part in pairs(v:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanTouch = false
                    end
                end
            end
        end
        task.wait(2)
    end
end)

-- 7. Unlock Doors Automático
createToggle(PagePlayers, "Unlock Doors (Desbloquear Auto)", function(state)
    AutoUnlock = state
    while AutoUnlock do
        local character = LocalPlayer.Character
        local tool = character and character:FindFirstChildOfClass("Tool")
        
        if tool then
            for _, door in pairs(Workspace:GetDescendants()) do
                if door:IsA("ProximityPrompt") then
                    -- Verifica si el nombre de la herramienta coincide con la puerta
                    if door.Parent.Name:match(tool.Name) or tool.Name:match(door.Parent.Name) then
                        local dist = (character.HumanoidRootPart.Position - door.Parent.Position).Magnitude
                        if dist <= 15 then -- Rango de distancia para usar la llave
                            fireproximityprompt(door, 1, true)
                        end
                    end
                end
            end
        end
        task.wait(0.5)
    end
end)

-- 8. Auto Grab Items (Lento para evitar bugs)
createToggle(PagePlayers, "Auto Grab Items (Lento)", function(state)
    AutoGrab = state
    while AutoGrab do
        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if root then
            for _, item in pairs(Workspace:GetDescendants()) do
                if item:IsA("ProximityPrompt") and item.ActionText == "Pick up" then
                    local dist = (root.Position - item.Parent.Position).Magnitude
                    if dist <= 20 then
                        fireproximityprompt(item, 1, true)
                        task.wait(1.5) -- Espera lenta para no bugear el inventario
                    end
                end
            end
        end
        task.wait(0.5)
    end
end)

-- ==========================================
-- LÓGICA DE LAS FUNCIONES (PIGGY)
-- ==========================================

createLabel(PagePiggy, "Úsalas si te toca ser el impostor/Piggy:")

createToggle(PagePiggy, "Kill Aura (Matar cerca automáticamente)", function(state)
    local KillAura = state
    while KillAura do
        local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local weapon = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Bat") or LocalPlayer.Character:FindFirstChildOfClass("Tool")
        
        if myRoot and weapon and weapon:FindFirstChild("Handle") then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (myRoot.Position - player.Character.HumanoidRootPart.Position).Magnitude
                    if dist <= 12 then -- Distancia del Kill Aura
                        firetouchinterest(weapon.Handle, player.Character.HumanoidRootPart, 0)
                        firetouchinterest(weapon.Handle, player.Character.HumanoidRootPart, 1)
                    end
                end
            end
        end
        task.wait(0.2)
    end
end)

createToggle(PagePiggy, "Auto-poner Trampas (Cerca de jugadores)", function(state)
    local AutoTraps = state
    while AutoTraps do
        -- Lógica: Activar la herramienta de trampas en el momento justo
        local trapsTool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Trap") or LocalPlayer.Backpack:FindFirstChild("Trap")
        if trapsTool then
            trapsTool.Parent = LocalPlayer.Character -- Equipar
            trapsTool:Activate() -- Colocar
            task.wait(5) -- Cooldown natural de las trampas
        end
        task.wait(1)
    end
end)

createToggle(PagePiggy, "Invisibilidad de Piggy (Local/Glitch)", function(state)
    if state and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.Transparency = 1
            elseif part:IsA("Decal") then
                part.Transparency = 1
            end
        end
    else
        if LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.Transparency = 0
                elseif part:IsA("Decal") then
                    part.Transparency = 0
                end
            end
        end
    end
end)
