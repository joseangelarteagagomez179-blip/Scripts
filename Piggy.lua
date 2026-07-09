-- ====================================================================
-- SCRIPT: JoseAngel_Blox Piggy PRO
-- VERSIÓN: 1.2 | FECHA DE LANZAMIENTO: 09/06/2026
-- CREADOR: JoseAngel_Blox
-- ====================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- Evitar duplicados del script
if CoreGui:FindFirstChild("JoseAngelPiggyPro") then
    CoreGui.JoseAngelPiggyPro:Destroy()
end

-- ==========================================
-- LISTA MAESTRA DE ITEMS (LIBRO 1 Y LIBRO 2)
-- ==========================================
local ItemWhitelist = {
    -- Llaves (Ambos Libros)
    "Key", "Llave", "GreenKey", "RedKey", "BlueKey", "PurpleKey", "WhiteKey", "YellowKey", "OrangeKey",
    -- Libro 1: Herramientas
    "Hammer", "Wrench", "Plank", "GreenGear", "RedGear", "Gasoline", "Battery", "RedEgg", 
    "BlueEgg", "Torch", "Firewood", "Book", "Syringe", "Gas", "Crossbow", "Arrow", 
    "Chain", "Hook", "Grass", "Shovel", "Code", "PurpleTube",
    "Martillo", "Llave inglesa", "Tabla", "Engranaje Verde", "Engranaje Rojo", "Gasolina", 
    "Batería", "Huevo Rojo", "Huevo Azul", "Antorcha", "Leña", "Libro", "Jeringa", 
    "Gas", "Ballesta", "Munición", "Cadena", "Gancho", "Pasto", "Pala", "Código", "Tubo morado",
    -- Libro 2: Herramientas
    "Screwdriver", "Broom", "Scissors", "Carrot", "Ladder", "Smoke", "ElevatorKey", "Lens", "Crowbar", "Gear",
    "Destornillador", "Escoba", "Tijeras", "Zanahoria", "Escalera", "Humo", "Llave ascensor", "Lente", "Palanca", "Engranaje"
}

-- Estados Globales de las Funciones
local ESP_Mobs, ESP_Items = false, false
local Noclip, SpeedJump, InfiniteStamina, GodMode, AutoUnlock, AutoGrab = false, false, false, false, false, false
local KillAura, AutoTraps, PiggyInvis = false, false, false

-- ==========================================
-- DISEÑO DE INTERFAZ (CUADRADA, BAJA Y ANCHA)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngelPiggyPro"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 680, 0, 310) -- Estructura baja y ancha
MainFrame.Position = UDim2.new(0.5, -340, 0.5, -155)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(180, 40, 40)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Línea estética decorativa superior
local TopLine = Instance.new("Frame")
TopLine.Size = UDim2.new(1, 0, 0, 4)
TopLine.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
TopLine.BorderSizePixel = 0
TopLine.Parent = MainFrame
Instance.new("UICorner", TopLine).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Text = "JoseAngel_Blox Piggy PRO"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.Parent = MainFrame

-- Fila de Fichas Cliqueables (Ordenadas en Fila Horizontal)
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -20, 0, 35)
TabContainer.Position = UDim2.new(0, 10, 0, 50)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 10)
TabListLayout.Parent = TabContainer

local PageContainer = Instance.new("Frame")
PageContainer.Size = UDim2.new(1, -20, 1, -110)
PageContainer.Position = UDim2.new(0, 10, 0, 95)
PageContainer.BackgroundTransparency = 1
PageContainer.Parent = MainFrame

local tabs, pages = {}, {}

local function createTab(name, order)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 210, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(230, 230, 230)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.LayoutOrder = order
    btn.Parent = TabContainer
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 5
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.Visible = false
    page.Parent = PageContainer
    
    local pageLayout = Instance.new("UIHorizontalLayout") or Instance.new("UIGridLayout")
    -- Usamos UIGridLayout para ordenar las opciones de forma limpia dentro de las fichas
    local grid = Instance.new("UIGridLayout")
    grid.CellSize = UDim2.new(0, 315, 0, 38)
    grid.CellPadding = UDim2.new(0, 15, 0, 10)
    grid.Parent = page
    
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        for _, t in pairs(tabs) do t.BackgroundColor3 = Color3.fromRGB(30, 30, 40) t.TextColor3 = Color3.fromRGB(230, 230, 230) end
        page.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    
    table.insert(tabs, btn)
    table.insert(pages, page)
    return page
end

local function createToggle(page, text, callback)
    local btn = Instance.new("TextButton")
    btn.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
    btn.Text = "  [OFF] " .. text
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 13
    btn.Parent = page
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(45, 45, 60)
    stroke.Thickness = 1
    stroke.Parent = btn

    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = state and "  [ON]  " .. text or "  [OFF] " .. text
        btn.TextColor3 = state and Color3.fromRGB(50, 255, 130) or Color3.fromRGB(200, 200, 200)
        stroke.Color = state and Color3.fromRGB(50, 255, 130) or Color3.fromRGB(45, 45, 60)
        callback(state)
    end)
end

-- Generación de las Pestañas Principales ordenadas en fila
local PageInfo = createTab("1) info↓", 1)
local PagePlayers = createTab("2) Funciones players", 2)
local PagePiggy = createTab("3) funciones de Piggy↓", 3)

-- Activar primera pestaña por defecto
tabs[1].BackgroundColor3 = Color3.fromRGB(255, 50, 50)
pages[1].Visible = true

-- ==========================================
-- SECCIÓN 1: ASIGNACIÓN DE INFO
-- ==========================================
local function addInfoLabel(page, title, val)
    local f = Instance.new("Frame")
    f.BackgroundTransparency = 1
    f.Parent = page
    local tl = Instance.new("TextLabel")
    tl.Size = UDim2.new(1, 0, 1, 0)
    tl.BackgroundTransparency = 1
    tl.Text = title .. ": " .. val
    tl.TextColor3 = Color3.fromRGB(220, 220, 220)
    tl.Font = Enum.Font.Gotham
    tl.TextSize = 13
    tl.TextXAlignment = Enum.TextXAlignment.Left
    tl.Parent = f
end

addInfoLabel(PageInfo, "Nombre del Creador", "JoseAngel_Blox")
addInfoLabel(PageInfo, "Fecha de lanzamiento", "09/06/2026")
addInfoLabel(PageInfo, "Versión", "1.2")

-- ==========================================
-- SECCIÓN 2: LOGICA CORREGIDA (PLAYERS)
-- ==========================================

-- 1. ESP Mobs (Jugadores, Bots, Piggy, Transformados)
createToggle(PagePlayers, "Esp (Players/Bots/Piggy)", function(state)
    ESP_Mobs = state
    if not state then
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("Highlight") and (v.Name == "PlayerESP" or v.Name == "PiggyESP") then v:Destroy() end
        end
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if ESP_Mobs then
            -- Escaneo de Jugadores Reales y Transformados
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local char = p.Character
                    local isPiggy = (p.TeamColor == BrickColor.new("Really red") or char:FindFirstChild("Bat") or char.Name:lower():find("piggy"))
                    
                    local hl = char:FindFirstChild("PlayerESP")
                    if not hl then
                        hl = Instance.new("Highlight", char)
                        hl.Name = "PlayerESP"
                    end
                    hl.FillColor = isPiggy and Color3.fromRGB(255, 0, 50) or Color3.fromRGB(50, 150, 255)
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                end
            end
            -- Escaneo de Bots del Servidor
            for _, v in pairs(Workspace:GetChildren()) do
                if v:IsA("Model") and v:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(v) then
                    if v.Name:lower():find("piggy") or v.Name:lower():find("bot") or v:FindFirstChild("Bat") then
                        local hl = v:FindFirstChild("PiggyESP")
                        if not hl then
                            hl = Instance.new("Highlight", v)
                            hl.Name = "PiggyESP"
                        end
                        hl.FillColor = Color3.fromRGB(255, 0, 0)
                    end
                end
            end
        end
    end
end)

-- 2. ESP Items Completo (Lista del Libro 1 y 2)
createToggle(PagePlayers, "Esp items", function(state)
    ESP_Items = state
    if not state then
        for _, v in pairs(Workspace:GetDescendants()) do
            if v.Name == "ItemMarker" then v:Destroy() end
        end
    end
end)

task.spawn(function()
    while task.wait(0.6) do
        if ESP_Items and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local root = LocalPlayer.Character.HumanoidRootPart
            for _, item in pairs(Workspace:GetDescendants()) do
                if item:IsA("ProximityPrompt") or item:IsA("ClickDetector") then
                    local folder = item.Parent
                    if folder and (folder:IsA("BasePart") or folder:IsA("Model")) then
                        local matchFound = false
                        for _, matchName in pairs(ItemWhitelist) do
                            if folder.Name:lower():find(matchName:lower()) then
                                matchFound = true
                                break
                            end
                        end
                        
                        if matchFound then
                            local part = folder:IsA("Model") and folder.PrimaryPart or folder
                            if part then
                                local bg = part:FindFirstChild("ItemMarker")
                                if not bg then
                                    bg = Instance.new("BillboardGui", part)
                                    bg.Name = "ItemMarker"
                                    bg.Size = UDim2.new(0, 140, 0, 45)
                                    bg.AlwaysOnTop = true
                                    local txt = Instance.new("TextLabel", bg)
                                    txt.Size = UDim2.new(1, 0, 1, 0)
                                    txt.BackgroundTransparency = 1
                                    txt.TextColor3 = Color3.fromRGB(255, 215, 0)
                                    txt.Font = Enum.Font.GothamBold
                                    txt.TextSize = 13
                                    txt.TextStrokeTransparency = 0
                                end
                                local dist = math.round((root.Position - part.Position).Magnitude)
                                bg.TextLabel.Text = folder.Name .. "\n[" .. dist .. " Studs]"
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- 3. Noclip (Corregido sin caídas infinitas)
createToggle(PagePlayers, "Noclip (Paredes)", function(state)
    Noclip = state
end)

RunService.Stepped:Connect(function()
    if Noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetChildren()) do
            if part:IsA("BasePart") and part.Name ~= "Terrain" then
                part.CanCollide = false
            end
        end
    end
end)

-- 4. Speed + Jump 
createToggle(PagePlayers, "Speed + Jump 🦘", function(state)
    SpeedJump = state
    if not state and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
        LocalPlayer.Character.Humanoid.JumpPower = 50
    end
end)

-- 5. Infinite Stamina
createToggle(PagePlayers, "Infinite stamina", function(state)
    InfiniteStamina = state
end)

RunService.Heartbeat:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        if SpeedJump then
            LocalPlayer.Character.Humanoid.WalkSpeed = 48
            LocalPlayer.Character.Humanoid.JumpPower = 75
            LocalPlayer.Character.Humanoid.UseJumpPower = true
        elseif InfiniteStamina then
            -- Mantiene la velocidad máxima de carrera nativa sin cansancio
            LocalPlayer.Character.Humanoid.WalkSpeed = 24
        end
    end
end)

-- 6. God Mode (CORREGIDO - Bloqueo de colisiones letales)
createToggle(PagePlayers, "God Mode", function(state)
    GodMode = state
    if not state and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanTouch = true end
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if GodMode and LocalPlayer.Character then
            -- Desactivamos CanTouch en nuestro personaje constantemente para anular los eventos .Touched del enemigo
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") and part.CanTouch == true then
                    part.CanTouch = false
                end
            end
        end
    end
end)

-- 7. Unlock Doors (Auto Desbloqueo Inteligente)
createToggle(PagePlayers, "Unlock Doors", function(state)
    AutoUnlock = state
end)

task.spawn(function()
    while task.wait(0.4) do
        if AutoUnlock and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local root = LocalPlayer.Character.HumanoidRootPart
            local currentTool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
            
            if currentTool then
                for _, prompt in pairs(Workspace:GetDescendants()) do
                    if prompt:IsA("ProximityPrompt") or prompt:IsA("ClickDetector") then
                        local door = prompt.Parent
                        if door and door.Name:lower():find("door") or door.Name:lower():find("padlock") or door.Name:lower():find("puerta") then
                            local part = door:IsA("Model") and door.PrimaryPart or door
                            if part and (root.Position - part.Position).Magnitude <= 20 then
                                if prompt:IsA("ProximityPrompt") then
                                    fireproximityprompt(prompt, 1, true)
                                elseif prompt:IsA("ClickDetector") then
                                    fireclickdetector(prompt)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- 8. Auto Grab Items (Lento y Seguro)
createToggle(PagePlayers, "Auto Grab items", function(state)
    AutoGrab = state
end)

task.spawn(function()
    while task.wait(1.2) do -- Delay lento configurado estructuralmente para evitar bugs de inventario
        if AutoGrab and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local root = LocalPlayer.Character.HumanoidRootPart
            for _, prompt in pairs(Workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") and prompt.Parent then
                    local itemModel = prompt.Parent
                    local isItem = false
                    for _, name in pairs(ItemWhitelist) do
                        if itemModel.Name:lower():find(name:lower()) then
                            isItem = true
                            break
                        end
                    end
                    
                    if isItem and itemModel:IsA("BasePart") then
                        if (root.Position - itemModel.Position).Magnitude <= 18 then
                            fireproximityprompt(prompt, 1, true)
                            break -- Pausa el ciclo actual para asegurar la recolección limpia de un ítem por segundo
                        end
                    end
                end
            end
        end
    end
end)

-- ==========================================
-- SECCIÓN 3: LOGICA CORREGIDA (PIGGY)
-- ==========================================

-- 1. Kill Aura 
createToggle(PagePiggy, "Kill Aura", function(state)
    KillAura = state
end)

task.spawn(function()
    while task.wait(0.2) do
        if KillAura and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local myRoot = LocalPlayer.Character.HumanoidRootPart
            local weapon = LocalPlayer.Character:FindFirstChild("Bat") or LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if weapon and weapon:FindFirstChild("Handle") then
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local enemyRoot = p.Character.HumanoidRootPart
                        if (myRoot.Position - enemyRoot.Position).Magnitude <= 15 then
                            firetouchinterest(weapon.Handle, enemyRoot, 0)
                            firetouchinterest(weapon.Handle, enemyRoot, 1)
                        end
                    end
                end
            end
        end
    end
end)

-- 2. Auto-poner Trampas
createToggle(PagePiggy, "Auto Traps", function(state)
    AutoTraps = state
end)

task.spawn(function()
    while task.wait(4.0) do
        if AutoTraps and LocalPlayer.Character then
            local trap = LocalPlayer.Character:FindFirstChild("Trap") or LocalPlayer.Backpack:FindFirstChild("Trap")
            if trap then
                trap.Parent = LocalPlayer.Character
                trap:Activate()
            end
        end
    end
end)

-- 3. Invisibilidad de Piggy Glitch
createToggle(PagePiggy, "Invisibilidad", function(state)
    PiggyInvis = state
    if LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
                v.Transparency = PiggyInvis and 1 or 0
            elseif v:IsA("Decal") then
                v.Transparency = PiggyInvis and 1 or 0
            end
        end
    end
end)
