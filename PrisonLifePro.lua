-- [[ Prison Life Pro v1.1 ]]
-- Creado por JoseAngel_Blox

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local camera = workspace.CurrentCamera

-- Crear UI
local ui = Instance.new("ScreenGui")
ui.Name = "PrisonLifePro"
ui.Parent = game.CoreGui
ui.ResetOnSpawn = false

-- Frame principal
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 500, 0, 350)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = ui

-- Esquinas redondeadas
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = mainFrame

-- Borde
local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(60, 60, 60)
uiStroke.Thickness = 2
uiStroke.Parent = mainFrame

-- Título con degradado (mitad rojo, mitad azul)
local titleFrame = Instance.new("Frame")
titleFrame.Size = UDim2.new(0, 300, 0, 40)
titleFrame.Position = UDim2.new(0.5, -150, 0, 10)
titleFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
titleFrame.BorderSizePixel = 0
titleFrame.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = titleFrame

-- Gradiente
local titleGradient = Instance.new("UIGradient")
titleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),  -- Rojo
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 0, 255)), -- Transición
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 255))   -- Azul
})
titleGradient.Parent = titleFrame

-- Texto del título
local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, 0, 1, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "Prison Life Pro v1.1"
titleText.Font = Enum.Font.FredokaOne
titleText.TextSize = 20
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextStrokeTransparency = 0.5
titleText.Parent = titleFrame

-- Texto del creador (transparente)
local creatorText = Instance.new("TextLabel")
creatorText.Size = UDim2.new(0, 200, 0, 20)
creatorText.Position = UDim2.new(0.5, -100, 0, 55)
creatorText.BackgroundTransparency = 1
creatorText.Text = "Creado por JoseAngel_Blox"
creatorText.Font = Enum.Font.SourceSansItalic
creatorText.TextSize = 14
creatorText.TextColor3 = Color3.fromRGB(255, 255, 255)
creatorText.TextTransparency = 0.3
creatorText.Parent = mainFrame

-- Marco de pestañas (izquierda)
local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(0, 120, 0, 250)
tabFrame.Position = UDim2.new(0, 10, 0, 90)
tabFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
tabFrame.BorderSizePixel = 0
tabFrame.Parent = mainFrame

local tabCorner = Instance.new("UICorner")
tabCorner.CornerRadius = UDim.new(0, 8)
tabCorner.Parent = tabFrame

-- Marco de contenido (derecha)
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(0, 350, 0, 250)
contentFrame.Position = UDim2.new(0, 140, 0, 90)
contentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 8)
contentCorner.Parent = contentFrame

-- ScrollingFrame para el contenido
local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Size = UDim2.new(1, -10, 1, -10)
scrollingFrame.Position = UDim2.new(0, 5, 0, 5)
scrollingFrame.BackgroundTransparency = 1
scrollingFrame.BorderSizePixel = 0
scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
scrollingFrame.ScrollBarThickness = 4
scrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
scrollingFrame.Parent = contentFrame

-- Variables para botones
local selectedTab = nil
local buttons = {}

-- Función para crear pestañas
local function createTab(name, position)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 100, 0, 30)
    button.Position = UDim2.new(0, 10, 0, position)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    button.BorderSizePixel = 0
    button.Text = name
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 13
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Parent = tabFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = button
    
    return button
end

-- Función para crear toggle buttons
local function createToggle(name, position, parent)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(0, 330, 0, 35)
    toggleFrame.Position = UDim2.new(0, 5, 0, position)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    toggleFrame.BorderSizePixel = 0
    toggleFrame.Parent = parent
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 5)
    toggleCorner.Parent = toggleFrame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 180, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.Font = Enum.Font.SourceSans
    label.TextSize = 12
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = toggleFrame
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 40, 0, 20)
    toggleButton.Position = UDim2.new(1, -50, 0.5, -10)
    toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    toggleButton.BorderSizePixel = 0
    toggleButton.Text = "OFF"
    toggleButton.Font = Enum.Font.SourceSansBold
    toggleButton.TextSize = 10
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.Parent = toggleFrame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 4)
    toggleCorner.Parent = toggleButton
    
    local enabled = false
    
    toggleButton.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            toggleButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
            toggleButton.Text = "ON"
        else
            toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            toggleButton.Text = "OFF"
        end
    end)
    
    return toggleButton, function() return enabled end
end

-- Crear pestañas
local tabs = {
    {name = "Info", pos = 10},
    {name = "Main", pos = 45},
    {name = "Movement", pos = 80},
    {name = "ESP", pos = 115},
    {name = "Funciones Pro", pos = 150},
    {name = "Auto Farm", pos = 185}
}

local tabButtons = {}

for i, tab in pairs(tabs) do
    local btn = createTab(tab.name, tab.pos)
    btn.MouseButton1Click:Connect(function()
        if selectedTab then
            selectedTab.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        end
        selectedTab = btn
        btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        
        -- Limpiar scrollingFrame
        for _, child in pairs(scrollingFrame:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy()
            end
        end
        
        -- Mostrar contenido según pestaña
        if tab.name == "Info" then
            scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 300)
            
            local infoFrame = Instance.new("Frame")
            infoFrame.Size = UDim2.new(1, -10, 0, 150)
            infoFrame.Position = UDim2.new(0, 5, 0, 10)
            infoFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            infoFrame.BorderSizePixel = 0
            infoFrame.Parent = scrollingFrame
            
            local infoCorner = Instance.new("UICorner")
            infoCorner.CornerRadius = UDim.new(0, 5)
            infoCorner.Parent = infoFrame
            
            local infoText = Instance.new("TextLabel")
            infoText.Size = UDim2.new(1, -20, 1, -20)
            infoText.Position = UDim2.new(0, 10, 0, 10)
            infoText.BackgroundTransparency = 1
            infoText.Text = "Nombre del creador: JoseAngel_Blox\n\nFecha de lanzamiento: 27/08/2026\n\nVersión: 1.1"
            infoText.Font = Enum.Font.SourceSansBold
            infoText.TextSize = 14
            infoText.TextColor3 = Color3.fromRGB(255, 255, 255)
            infoText.TextXAlignment = Enum.TextXAlignment.Left
            infoText.TextYAlignment = Enum.TextYAlignment.Top
            infoText.Parent = infoFrame
            
        elseif tab.name == "Main" then
            scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 300)
            createToggle("Aimbot", 10, scrollingFrame)
            createToggle("Silent Aim", 50, scrollingFrame)
            createToggle("Infinite Ammo", 90, scrollingFrame)
            createToggle("Rapid Fire", 130, scrollingFrame)
            createToggle("One Shot Kill", 170, scrollingFrame)
            createToggle("Auto Shoot", 210, scrollingFrame)
            
        elseif tab.name == "Movement" then
            scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 250)
            createToggle("Speed Hack", 10, scrollingFrame)
            createToggle("Infinite Jump", 50, scrollingFrame)
            createToggle("Fly", 90, scrollingFrame)
            createToggle("Noclip", 130, scrollingFrame)
            createToggle("Jump Power", 170, scrollingFrame)
            
        elseif tab.name == "ESP" then
            scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 250)
            createToggle("Player ESP", 10, scrollingFrame)
            createToggle("Team ESP", 50, scrollingFrame)
            createToggle("Health ESP", 90, scrollingFrame)
            createToggle("Full Bright", 130, scrollingFrame)
            
        elseif tab.name == "Funciones Pro" then
            scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 200)
            createToggle("Open All Doors", 10, scrollingFrame)
            createToggle("Remove Doors", 50, scrollingFrame)
            createToggle("God Mode", 90, scrollingFrame)
            
        elseif tab.name == "Auto Farm" then
            scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 300)
            createToggle("Auto Kill Guards", 10, scrollingFrame)
            createToggle("Auto Kill Inmates", 50, scrollingFrame)
            createToggle("Auto Arrest", 90, scrollingFrame)
            createToggle("Auto Escape", 130, scrollingFrame)
            createToggle("Auto Pickup Guns", 170, scrollingFrame)
        end
    end)
    
    tabButtons[tab.name] = btn
end

-- Activar primera pestaña por defecto
if tabButtons["Info"] then
    tabButtons["Info"].BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    selectedTab = tabButtons["Info"]
end

-- Función para conseguir armas
local function giveGun(gunName)
    local gun = game.ServerStorage:FindFirstChild(gunName)
    if gun then
        local clone = gun:Clone()
        clone.Parent = player.Backpack
    end
end

-- Funciones del script (lógica básica)
local function enableAimbot()
    -- Lógica de aimbot aquí
end

local function enableESP()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character then
            local highlight = Instance.new("Highlight")
            highlight.Parent = v.Character
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
        end
    end
end

-- Hacer el script arrastrable
local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

mainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
