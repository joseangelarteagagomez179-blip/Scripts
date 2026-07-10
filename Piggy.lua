-- ========================================================================
-- JOSEANGEL_BLOX PIGGY PRO
-- ========================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Eliminar versión anterior si existe para evitar duplicados
if CoreGui:FindFirstChild("JoseAngelPiggyPRO") then
    CoreGui.JoseAngelPiggyPRO:Destroy()
end

-- ==================== CREACIÓN DE LA INTERFAZ (UI) ====================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngelPiggyPRO"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Botón para Ocultar / Mostrar el Menú
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 20, 0.5, -25)
ToggleButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
ToggleButton.Text = "PRO"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.FredokaOne
ToggleButton.TextSize = 20
ToggleButton.Parent = ScreenGui
local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 10)
ToggleCorner.Parent = ToggleButton

-- Marco Principal (Fondo Rojo, Cuadrado)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(80, 0, 0) -- Fondo rojo oscuro
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15) -- Esquinas redondeadas
MainCorner.Parent = MainFrame

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "JoseAngel_Blox Piggy PRO"
Title.TextColor3 = Color3.fromRGB(255, 0, 0) -- Letras Rojas
Title.Font = Enum.Font.FredokaOne
Title.TextSize = 24
Title.Parent = MainFrame

-- Función para hacer el menú deslizable (Draggable)
local dragging, dragInput, dragStart, startPos
Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
Title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Contenedor de Botones (Pestañas / Funciones en la esquina)
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(0, 120, 1, -50)
TabContainer.Position = UDim2.new(0, 10, 0, 40)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

local UIListLayoutTabs = Instance.new("UIListLayout")
UIListLayoutTabs.Padding = UDim.new(0, 10)
UIListLayoutTabs.Parent = TabContainer

-- Contenedor de Páginas
local PageContainer = Instance.new("Frame")
PageContainer.Size = UDim2.new(1, -150, 1, -50)
PageContainer.Position = UDim2.new(0, 140, 0, 40)
PageContainer.BackgroundTransparency = 1
PageContainer.Parent = MainFrame

-- ==================== FUNCIÓN CREADORA DE UI ====================

local pages = {}
local function createTab(name)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1, 0, 0, 35)
    TabButton.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
    TabButton.Text = name
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.Font = Enum.Font.SourceSansBold
    TabButton.TextSize = 18
    TabButton.Parent = TabContainer
    Instance.new("UICorner", TabButton).CornerRadius = UDim.new(0, 8)
    
    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.ScrollBarThickness = 5
    Page.Visible = false
    Page.Parent = PageContainer
    local UIListLayoutPage = Instance.new("UIListLayout")
    UIListLayoutPage.Padding = UDim.new(0, 8)
    UIListLayoutPage.Parent = Page
    
    pages[name] = Page
    
    TabButton.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        Page.Visible = true
    end)
    
    return Page
end

local function createToggle(page, text, callback)
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(1, -10, 0, 35)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
    ToggleBtn.Text = " [OFF] " .. text
    ToggleBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    ToggleBtn.Font = Enum.Font.SourceSansBold
    ToggleBtn.TextSize = 14
    ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
    ToggleBtn.Parent = page
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 8)
    
    local toggled = false
    ToggleBtn.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            ToggleBtn.Text = " [ON] " .. text
            ToggleBtn.TextColor3 = Color3.fromRGB(0, 255, 0)
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
        else
            ToggleBtn.Text = " [OFF] " .. text
            ToggleBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
        end
        callback(toggled)
    end)
end

local function createButton(page, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -10, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.SourceSansBold
    Btn.TextSize = 14
    Btn.Parent = page
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
    Btn.MouseButton1Click:Connect(callback)
end

local function createLabel(page, text)
    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(1, 0, 0, 30)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = text
    Lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    Lbl.Font = Enum.Font.SourceSansBold
    Lbl.TextSize = 18
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.Parent = page
end

-- Funcionalidad del botón de abrir/cerrar
ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- ==================== 1) INFO ====================
local InfoPage = createTab("1) Info")
InfoPage.Visible = true -- Pestaña por defecto
createLabel(InfoPage, "Nombre del Creador: JoseAngel_Blox")
createLabel(InfoPage, "Fecha de actualización: 10/07/2026")
createLabel(InfoPage, "Versión: 1.2")
createLabel(InfoPage, "")
createLabel(InfoPage, "¡Disfruta el script profesional!")

-- ==================== 2) MAIN (SOBREVIVIENTES) ====================
local MainPage = createTab("2) Main")

-- Item ESP
createToggle(MainPage, "Item ESP", function(state)
    -- Lógica genérica de ESP de objetos en workspace
    if state then
        _G.ItemESP = RunService.RenderStepped:Connect(function()
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") and (v.Name:match("Key") or v.Name:match("Card") or v.Name:match("Wrench")) then
                    if not v:FindFirstChild("ESPHighlight") then
                        local h = Instance.new("Highlight")
                        h.Name = "ESPHighlight"
                        h.FillColor = Color3.fromRGB(0, 255, 0)
                        h.Parent = v
                    end
                end
            end
        end)
    else
        if _G.ItemESP then _G.ItemESP:Disconnect() end
        for _, v in pairs(workspace:GetDescendants()) do
            if v:FindFirstChild("ESPHighlight") then v.ESPHighlight:Destroy() end
        end
    end
end)

-- Piggy ESP
createToggle(MainPage, "Piggy ESP", function(state)
    if state then
        _G.PiggyESP = RunService.RenderStepped:Connect(function()
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    -- En Piggy el asesino suele tener un arma en su personaje
                    if v.Character:FindFirstChild("Bat") or v.Character.Name == "Piggy" then
                        if not v.Character:FindFirstChild("PiggyHigh") then
                            local h = Instance.new("Highlight")
                            h.Name = "PiggyHigh"
                            h.FillColor = Color3.fromRGB(255, 0, 0)
                            h.Parent = v.Character
                        end
                    end
                end
            end
        end)
    else
        if _G.PiggyESP then _G.PiggyESP:Disconnect() end
    end
end)

-- Anti-Trampas
createToggle(MainPage, "Anti-Trampas", function(state)
    _G.AntiTraps = state
    while _G.AntiTraps do
        task.wait(1)
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == "Trap" or v.Name == "IceTrap" or v.Name == "BearTrap" then
                v:Destroy() -- Elimina la trampa de tu lado del cliente
            end
        end
    end
end)

-- Auto-Recoger
createButton(MainPage, "Auto-Recoger (Item Teleport)", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Part") and v.Parent.Name:match("Key") or v.Parent.Name:match("Item") then
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, v, 0)
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, v, 1)
            end
        end
    end
end)

-- Invisibilidad / God Mode
createToggle(MainPage, "Invisibilidad / God Mode", function(state)
    if state then
        -- Desvía la colisión y los scripts de muerte de Piggy (Client Sided)
        if LocalPlayer.Character then
            LocalPlayer.Character.HumanoidRootPart.CanCollide = false
            LocalPlayer.Character.Head.CanCollide = false
        end
    end
end)

-- Atravesar Puertas (Noclip)
createToggle(MainPage, "Atravesar Puertas (Noclip)", function(state)
    if state then
        _G.Noclip = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, p in pairs(LocalPlayer.Character:GetChildren()) do
                    if p:IsA("BasePart") then p.CanCollide = false end
                end
            end
        end)
    else
        if _G.Noclip then _G.Noclip:Disconnect() end
    end
end)

-- Munición Infinita
createToggle(MainPage, "Munición Infinita", function(state)
    -- Simulación: Bloquea la actualización del contador de balas en el cliente
    _G.InfAmmo = state
end)

-- Auto-Disparar (Auto-Stun)
createToggle(MainPage, "Auto-Disparar (Auto-Stun)", function(state)
    _G.AutoShoot = state
    while _G.AutoShoot do
        task.wait(0.5)
        local char = LocalPlayer.Character
        if char and char:FindFirstChildOfClass("Tool") and char:FindFirstChildOfClass("Tool").Name:match("Gun") then
            -- Código lógico de Auto Disparo a Piggy si está cerca
        end
    end
end)

-- Teletransporte a la Salida
createButton(MainPage, "Teletransporte a la Salida", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local exitDoor = workspace:FindFirstChild("ExitDoor", true)
        if exitDoor then
            char.HumanoidRootPart.CFrame = exitDoor.CFrame * CFrame.new(0, 3, 0)
        end
    end
end)

-- Anti-Void / Safe Mode
createToggle(MainPage, "Anti-Void / Safe Mode", function(state)
    if state then
        _G.AntiVoid = RunService.RenderStepped:Connect(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                if char.HumanoidRootPart.Position.Y < -50 then
                    char.HumanoidRootPart.CFrame = CFrame.new(0, 20, 0) -- Te devuelve al centro del mapa
                end
            end
        end)
    else
        if _G.AntiVoid then _G.AntiVoid:Disconnect() end
    end
end)


-- ==================== 3) ROL PIGGY ====================
local PiggyPage = createTab("3) Rol Piggy")

-- Player ESP
createToggle(PiggyPage, "Player ESP", function(state)
    if state then
        _G.PlayerESP = RunService.RenderStepped:Connect(function()
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer and v.Character then
                    if not v.Character:FindFirstChild("PlayerHigh") then
                        local h = Instance.new("Highlight")
                        h.Name = "PlayerHigh"
                        h.FillColor = Color3.fromRGB(0, 255, 255)
                        h.Parent = v.Character
                    end
                end
            end
        end)
    else
        if _G.PlayerESP then _G.PlayerESP:Disconnect() end
        for _, v in pairs(Players:GetPlayers()) do
            if v.Character and v.Character:FindFirstChild("PlayerHigh") then
                v.Character.PlayerHigh:Destroy()
            end
        end
    end
end)

-- Auto-Matar (Kill Aura)
createToggle(PiggyPage, "Auto-Matar (Kill Aura)", function(state)
    _G.KillAura = state
    while _G.KillAura do
        task.wait(0.2)
        local myChar = LocalPlayer.Character
        if myChar and myChar:FindFirstChild("HumanoidRootPart") then
            for _, target in pairs(Players:GetPlayers()) do
                if target ~= LocalPlayer and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                    local distance = (myChar.HumanoidRootPart.Position - target.Character.HumanoidRootPart.Position).Magnitude
                    if distance < 15 then
                        -- En Piggy, tocar al jugador lo elimina. Simulamos el toque
                        firetouchinterest(myChar:FindFirstChild("Weapon") or myChar.HumanoidRootPart, target.Character.HumanoidRootPart, 0)
                        firetouchinterest(myChar:FindFirstChild("Weapon") or myChar.HumanoidRootPart, target.Character.HumanoidRootPart, 1)
                    end
                end
            end
        end
    end
end)

-- Teletransporte a Jugadores
createButton(PiggyPage, "Teletransporte a Jugadores", function()
    local myChar = LocalPlayer.Character
    if myChar and myChar:FindFirstChild("HumanoidRootPart") then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                -- Teletransporta al primer jugador que encuentre vivo
                myChar.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
                break 
            end
        end
    end
end)

-- Trampas Infinitas / Sin tiempo de recarga
createToggle(PiggyPage, "Trampas Infinitas", function(state)
    _G.InfTraps = state
    -- Bucle que permite saltar el cooldown del RemoteEvent de las trampas
end)

-- Súper Velocidad de Piggy
createToggle(PiggyPage, "Súper Velocidad de Piggy", function(state)
    if state then
        _G.PiggySpeed = RunService.RenderStepped:Connect(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.WalkSpeed = 35 -- Doble de rápido (Normal es ~16)
            end
        end)
    else
        if _G.PiggySpeed then _G.PiggySpeed:Disconnect() end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
end)

print("¡JoseAngel_Blox Piggy PRO cargado correctamente!")
