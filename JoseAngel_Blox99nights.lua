--[[
    JoseAngel_Blox 99 Nights
    Creador: JoseAngel_Blox
    Fecha: 02/09/2026
    Versión: 1.1
]]

-- Servicios
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- Variables
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local camera = Workspace.CurrentCamera

-- Configuración
local settings = {
    flyEnabled = false,
    noclipEnabled = false,
    godmodeEnabled = false,
    killAuraEnabled = false,
    killAuraRange = 20,
    autoFuelEnabled = false,
    autoScrapperEnabled = false,
    walkspeed = 16,
    antiLagEnabled = false,
    bringFuelEnabled = false,
    bringMetalEnabled = false,
    bringFoodEnabled = false,
    bringToolsEnabled = false,
    bringGunsEnabled = false
}

-- Items seleccionados
local selectedItems = {
    fuel = {},
    metal = {},
    food = {},
    tools = {},
    guns = {}
}

-- Crear GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Frame principal cuadrado con esquinas redondeadas
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 139) -- Azul marino
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Esquinas redondeadas
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

-- Título
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "JoseAngel_Blox 99 Nights"
Title.TextColor3 = Color3.fromRGB(0, 150, 255) -- Azul claro
Title.TextSize = 24
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

-- Contenedor de pestañas (izquierda)
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Size = UDim2.new(0, 150, 0, 300)
TabContainer.Position = UDim2.new(0, 10, 0, 70)
TabContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 100)
TabContainer.BorderSizePixel = 0
TabContainer.Parent = MainFrame

local TabCorner = Instance.new("UICorner")
TabCorner.CornerRadius = UDim.new(0, 10)
TabCorner.Parent = TabContainer

-- Contenedor de contenido (derecha)
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(0, 420, 0, 300)
ContentFrame.Position = UDim2.new(0, 170, 0, 70)
ContentFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 100)
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 10)
ContentCorner.Parent = ContentFrame

-- Función para crear pestañas
local tabs = {}
local function CreateTab(name, icon)
    local tab = Instance.new("TextButton")
    tab.Name = name
    tab.Size = UDim2.new(1, -10, 0, 40)
    tab.Position = UDim2.new(0, 5, 0, #tabs * 45 + 10)
    tab.BackgroundColor3 = Color3.fromRGB(30, 30, 130)
    tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab.Text = icon .. " " .. name
    tab.TextSize = 16
    tab.Font = Enum.Font.SourceSansBold
    tab.AutoButtonColor = true
    tab.Parent = TabContainer
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 8)
    tabCorner.Parent = tab
    
    tabs[name] = tab
    return tab
end

-- Crear pestañas
CreateTab("Info", "ℹ️")
CreateTab("Main", "🎯")
CreateTab("Auto", "⚡")
CreateTab("Player", "👤")
CreateTab("Teleport", "🚀")

-- Función para limpiar contenido
local function ClearContent()
    for _, child in pairs(ContentFrame:GetChildren()) do
        if child:IsA("Frame") or child:IsA("ScrollingFrame") then
            child:Destroy()
        end
    end
end

-- Función para crear sección con scroll
local function CreateScrollFrame()
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -10, 1, -10)
    scroll.Position = UDim2.new(0, 5, 0, 5)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 5
    scroll.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255)
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.Parent = ContentFrame
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 5)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = scroll
    
    return scroll, layout
end

-- Función para crear toggle
local function CreateToggle(parent, text, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, -10, 0, 30)
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.Parent = parent
    
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 50, 0, 25)
    toggle.Position = UDim2.new(0, 5, 0, 2)
    toggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    toggle.Text = ""
    toggle.Parent = toggleFrame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 12)
    toggleCorner.Parent = toggle
    
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 20, 0, 20)
    knob.Position = UDim2.new(0, 2, 0, 2)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.Parent = toggle
    
    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = knob
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 200, 0, 25)
    label.Position = UDim2.new(0, 60, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 14
    label.Font = Enum.Font.SourceSans
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = toggleFrame
    
    local isEnabled = false
    
    toggle.MouseButton1Click:Connect(function()
        isEnabled = not isEnabled
        if isEnabled then
            toggle.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            knob:TweenPosition(UDim2.new(0, 28, 0, 2), "In", "Linear", 0.1)
        else
            toggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            knob:TweenPosition(UDim2.new(0, 2, 0, 2), "In", "Linear", 0.1)
        end
        callback(isEnabled)
    end)
    
    return toggleFrame
end

-- Función para crear botón
local function CreateButton(parent, text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 35)
    button.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = text
    button.TextSize = 14
    button.Font = Enum.Font.SourceSansBold
    button.Parent = parent
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    button.MouseButton1Click:Connect(callback)
    
    return button
end

-- Función para crear dropdown
local function CreateDropdown(parent, text, items, callback)
    local dropdownFrame = Instance.new("Frame")
    dropdownFrame.Size = UDim2.new(1, -10, 0, 30)
    dropdownFrame.BackgroundTransparency = 1
    dropdownFrame.Parent = parent
    
    local dropdownButton = Instance.new("TextButton")
    dropdownButton.Size = UDim2.new(1, 0, 0, 30)
    dropdownButton.BackgroundColor3 = Color3.fromRGB(50, 50, 150)
    dropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropdownButton.Text = text
    dropdownButton.TextSize = 14
    dropdownButton.Font = Enum.Font.SourceSansBold
    dropdownButton.Parent = dropdownFrame
    
    local dropdownCorner = Instance.new("UICorner")
    dropdownCorner.CornerRadius = UDim.new(0, 8)
    dropdownCorner.Parent = dropdownButton
    
    local itemsFrame = Instance.new("Frame")
    itemsFrame.Size = UDim2.new(1, 0, 0, 0)
    itemsFrame.Position = UDim2.new(0, 0, 1, 0)
    itemsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 100)
    itemsFrame.Visible = false
    itemsFrame.ZIndex = 5
    itemsFrame.Parent = dropdownFrame
    
    local itemsCorner = Instance.new("UICorner")
    itemsCorner.CornerRadius = UDim.new(0, 8)
    itemsCorner.Parent = itemsFrame
    
    local selectedItems = {}
    
    dropdownButton.MouseButton1Click:Connect(function()
        itemsFrame.Visible = not itemsFrame.Visible
        if itemsFrame.Visible then
            itemsFrame.Size = UDim2.new(1, 0, 0, #items * 30)
        else
            itemsFrame.Size = UDim2.new(1, 0, 0, 0)
        end
    end)
    
    for i, item in pairs(items) do
        local itemButton = Instance.new("TextButton")
        itemButton.Size = UDim2.new(1, -10, 0, 25)
        itemButton.Position = UDim2.new(0, 5, 0, (i - 1) * 30 + 5)
        itemButton.BackgroundColor3 = Color3.fromRGB(60, 60, 120)
        itemButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        itemButton.Text = item
        itemButton.TextSize = 12
        itemButton.Font = Enum.Font.SourceSans
        itemButton.Parent = itemsFrame
        
        local itemCorner = Instance.new("UICorner")
        itemCorner.CornerRadius = UDim.new(0, 6)
        itemCorner.Parent = itemButton
        
        itemButton.MouseButton1Click:Connect(function()
            selectedItems[item] = not selectedItems[item]
            if selectedItems[item] then
                itemButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            else
                itemButton.BackgroundColor3 = Color3.fromRGB(60, 60, 120)
            end
            callback(item, selectedItems[item])
        end)
    end
    
    return dropdownFrame, selectedItems
end

-- Funciones del juego
local function getNearestItem(itemName)
    local nearest = nil
    local nearestDist = math.huge
    
    for _, item in pairs(Workspace:GetDescendants()) do
        if item:IsA("BasePart") and item.Name:lower():find(itemName:lower()) then
            local dist = (item.Position - character.HumanoidRootPart.Position).Magnitude
            if dist < nearestDist then
                nearest = item
                nearestDist = dist
            end
        end
    end
    
    return nearest
end

local function bringItem(itemName)
    local item = getNearestItem(itemName)
    if item then
        item.CFrame = character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
    end
end

local function bringAllSelected(category)
    for itemName, selected in pairs(selectedItems[category]) do
        if selected then
            bringItem(itemName)
        end
    end
end

-- Kill Aura
local function killAuraLoop()
    while settings.killAuraEnabled do
        local enemies = {"Bunny", "Wolf", "Alpha Wolf", "Bear", "Cultist", "Crossbow Cultist", "Mossy Wolf"}
        for _, enemyName in pairs(enemies) do
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("Model") and obj.Name:lower():find(enemyName:lower()) then
                    local enemyHumanoid = obj:FindFirstChild("Humanoid")
                    local enemyRoot = obj:FindFirstChild("HumanoidRootPart")
                    if enemyHumanoid and enemyRoot and enemyHumanoid.Health > 0 then
                        local dist = (enemyRoot.Position - character.HumanoidRootPart.Position).Magnitude
                        if dist <= settings.killAuraRange then
                            enemyHumanoid.Health = 0
                        end
                    end
                end
            end
        end
        wait(0.5)
    end
end

-- Auto Fuel
local function autoFuelLoop()
    while settings.autoFuelEnabled do
        local fuelItems = {"Log", "Coal", "Oil Barrel", "Fuel Canister", "Biofuel"}
        for _, fuelItem in pairs(fuelItems) do
            local item = getNearestItem(fuelItem)
            if item then
                local rescueZone = Workspace:FindFirstChild("RescueZone")
                if rescueZone then
                    item.CFrame = rescueZone.CFrame + Vector3.new(0, 3, 0)
                end
            end
        end
        wait(1)
    end
end

-- Auto Scrapper
local function autoScrapperLoop()
    while settings.autoScrapperEnabled do
        local metalItems = {"Bolt", "Broken Fan", "Broken Microwave", "Cultist Gem", "Gem of the Forest Fragment", "Metal Chair", "Old Car Engine", "Old Radio", "Sheet Metal"}
        for _, metalItem in pairs(metalItems) do
            local item = getNearestItem(metalItem)
            if item then
                local scrapper = Workspace:FindFirstChild("Scrapper")
                if scrapper then
                    item.CFrame = scrapper.CFrame + Vector3.new(0, 3, 0)
                end
            end
        end
        wait(1)
    end
end

-- Fly
local function flyLoop()
    while settings.flyEnabled do
        if character and character.HumanoidRootPart then
            local direction = camera.CFrame.LookVector
            local moveDirection = Vector3.new()
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                moveDirection = moveDirection + direction
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                moveDirection = moveDirection - direction
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                moveDirection = moveDirection - camera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                moveDirection = moveDirection + camera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                moveDirection = moveDirection + Vector3.new(0, 1, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                moveDirection = moveDirection - Vector3.new(0, 1, 0)
            end
            
            character.HumanoidRootPart.Velocity = moveDirection * 30
        end
        wait()
    end
end

-- Noclip
local function noclipLoop()
    while settings.noclipEnabled do
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
        wait()
    end
end

-- Godmode
local function godmodeLoop()
    while settings.godmodeEnabled do
        if character and humanoid then
            humanoid.Health = humanoid.MaxHealth
            humanoid.MaxHealth = math.huge
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        end
        wait(0.5)
    end
end

-- Anti Lag
local function antiLagLoop()
    while settings.antiLagEnabled do
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") and not obj:IsDescendantOf(character) then
                obj.Material = Enum.Material.Plastic
            end
        end
        wait(5)
    end
end

-- Teleport
local function teleportTo(locationName)
    local location = Workspace:FindFirstChild(locationName)
    if location then
        character.HumanoidRootPart.CFrame = location.CFrame + Vector3.new(0, 5, 0)
    else
        print("No se encontró: " .. locationName)
    end
end

-- Conectar pestañas
tabs["Info"].MouseButton1Click:Connect(function()
    ClearContent()
    local scroll, layout = CreateScrollFrame()
    
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, -10, 0, 30)
    infoLabel.BackgroundTransparency = 1
    infoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    infoLabel.TextSize = 16
    infoLabel.Font = Enum.Font.SourceSansBold
    infoLabel.Text = "Nombre del creador: JoseAngel_Blox"
    infoLabel.TextXAlignment = Enum.TextXAlignment.Left
    infoLabel.Parent = scroll
    
    local dateLabel = Instance.new("TextLabel")
    dateLabel.Size = UDim2.new(1, -10, 0, 30)
    dateLabel.BackgroundTransparency = 1
    dateLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    dateLabel.TextSize = 16
    dateLabel.Font = Enum.Font.SourceSansBold
    dateLabel.Text = "Fecha de lanzamiento: 02/09/2026"
    dateLabel.TextXAlignment = Enum.TextXAlignment.Left
    dateLabel.Parent = scroll
    
    local versionLabel = Instance.new("TextLabel")
    versionLabel.Size = UDim2.new(1, -10, 0, 30)
    versionLabel.BackgroundTransparency = 1
    versionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    versionLabel.TextSize = 16
    versionLabel.Font = Enum.Font.SourceSansBold
    versionLabel.Text = "Versión 1.1"
    versionLabel.TextXAlignment = Enum.TextXAlignment.Left
    versionLabel.Parent = scroll
    
    scroll.CanvasSize = UDim2.new(0, 0, 0, 100)
end)

tabs["Main"].MouseButton1Click:Connect(function()
    ClearContent()
    local scroll, layout = CreateScrollFrame()
    
    -- Fuel Section
    local fuelLabel = Instance.new("TextLabel")
    fuelLabel.Size = UDim2.new(1, -10, 0, 25)
    fuelLabel.BackgroundTransparency = 1
    fuelLabel.TextColor3 = Color3.fromRGB(255, 100, 0)
    fuelLabel.TextSize = 16
    fuelLabel.Font = Enum.Font.SourceSansBold
    fuelLabel.Text = "🔥 Fuel"
    fuelLabel.TextXAlignment = Enum.TextXAlignment.Left
    fuelLabel.Parent = scroll
    
    local fuelDropdown, fuelItems = CreateDropdown(scroll, "Select All ↓", {"Coal", "Log", "Oil Barrel", "Fuel Canister", "Biofuel"}, function(item, selected)
        selectedItems.fuel[item] = selected
    end)
    
    CreateToggle(scroll, "Bring Items", function(enabled)
        settings.bringFuelEnabled = enabled
        if enabled then
            spawn(function()
                while settings.bringFuelEnabled do
                    bringAllSelected("fuel")
                    wait(0.5)
                end
            end)
        end
    end)
    
    -- Metal Section
    local metalLabel = Instance.new("TextLabel")
    metalLabel.Size = UDim2.new(1, -10, 0, 25)
    metalLabel.BackgroundTransparency = 1
    metalLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
    metalLabel.TextSize = 16
    metalLabel.Font = Enum.Font.SourceSansBold
    metalLabel.Text = "📎 Bring Metal"
    metalLabel.TextXAlignment = Enum.TextXAlignment.Left
    metalLabel.Parent = scroll
    
    local metalDropdown, metalItems = CreateDropdown(scroll, "Select All ↓", {"Bolt", "Broken Fan", "Broken Microwave", "Cultist Gem", "Gem of the Forest Fragment", "Metal Chair", "Old Car Engine", "Old Radio", "Sheet Metal"}, function(item, selected)
        selectedItems.metal[item] = selected
    end)
    
    CreateToggle(scroll, "Bring Item", function(enabled)
        settings.bringMetalEnabled = enabled
        if enabled then
            spawn(function()
                while settings.bringMetalEnabled do
                    bringAllSelected("metal")
                    wait(0.5)
                end
            end)
        end
    end)
    
    -- Food Section
    local foodLabel = Instance.new("TextLabel")
    foodLabel.Size = UDim2.new(1, -10, 0, 25)
    foodLabel.BackgroundTransparency = 1
    foodLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
    foodLabel.TextSize = 16
    foodLabel.Font = Enum.Font.SourceSansBold
    foodLabel.Text = "🥩 Food"
    foodLabel.TextXAlignment = Enum.TextXAlignment.Left
    foodLabel.Parent = scroll
    
    local foodDropdown, foodItems = CreateDropdown(scroll, "Select All ↓", {"Berry", "Cake", "Carrot", "Chilli", "Cooked Morsel", "Cooked Steak", "Corn", "Meat? Sandwich", "Morsel", "Pumpkin", "Steak", "Stew"}, function(item, selected)
        selectedItems.food[item] = selected
    end)
    
    CreateToggle(scroll, "Bring Item", function(enabled)
        settings.bringFoodEnabled = enabled
        if enabled then
                    
