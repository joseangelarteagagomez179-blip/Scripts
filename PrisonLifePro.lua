-- [[ Prison Life Pro v1.2 - UI Optimizada ]]
-- Creado por JoseAngel_Blox

local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Crear UI
local ui = Instance.new("ScreenGui")
ui.Name = "PrisonLifePro"
ui.Parent = game.CoreGui
ui.ResetOnSpawn = false

-- ==========================================
-- BOTÓN BURBUJA (ABRIR/CERRAR)
-- ==========================================
local bubbleBtn = Instance.new("TextButton")
bubbleBtn.Name = "BubbleButton"
bubbleBtn.Size = UDim2.new(0, 45, 0, 45)
bubbleBtn.Position = UDim2.new(0, 20, 0, 20)
bubbleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
bubbleBtn.BorderSizePixel = 0
bubbleBtn.Text = "PL"
bubbleBtn.Font = Enum.Font.FredokaOne
bubbleBtn.TextSize = 18
bubbleBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
bubbleBtn.Parent = ui

local bubbleCorner = Instance.new("UICorner")
bubbleCorner.CornerRadius = UDim.new(1, 0) -- Hace que sea un círculo perfecto
bubbleCorner.Parent = bubbleBtn

local bubbleStroke = Instance.new("UIStroke")
bubbleStroke.Color = Color3.fromRGB(0, 0, 255)
bubbleStroke.Thickness = 2
bubbleStroke.Parent = bubbleBtn

-- ==========================================
-- INTERFAZ PRINCIPAL (MÁS PEQUEÑA)
-- ==========================================
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 380, 0, 260) -- Tamaño reducido
mainFrame.Position = UDim2.new(0.5, -190, 0.5, -130)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false -- Oculto por defecto
mainFrame.Parent = ui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = mainFrame

local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(60, 60, 60)
uiStroke.Thickness = 2
uiStroke.Parent = mainFrame

-- Título
local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, 0, 0, 30)
titleText.BackgroundTransparency = 1
titleText.Text = " Prison Life Pro v1.2"
titleText.Font = Enum.Font.FredokaOne
titleText.TextSize = 16
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = mainFrame

-- Marco de pestañas (Izquierda)
local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(0, 100, 0, 210)
tabFrame.Position = UDim2.new(0, 10, 0, 40)
tabFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
tabFrame.BorderSizePixel = 0
tabFrame.Parent = mainFrame

local tabCorner = Instance.new("UICorner")
tabCorner.CornerRadius = UDim.new(0, 8)
tabCorner.Parent = tabFrame

-- Marco de contenido (Derecha)
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(0, 250, 0, 210)
contentFrame.Position = UDim2.new(0, 120, 0, 40)
contentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 8)
contentCorner.Parent = contentFrame

local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Size = UDim2.new(1, -10, 1, -10)
scrollingFrame.Position = UDim2.new(0, 5, 0, 5)
scrollingFrame.BackgroundTransparency = 1
scrollingFrame.BorderSizePixel = 0
scrollingFrame.ScrollBarThickness = 3
scrollingFrame.Parent = contentFrame

-- ==========================================
-- FUNCIONES DE SISTEMA UI
-- ==========================================

-- Lógica para abrir/cerrar con la burbuja
bubbleBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

local function makeDraggable(guiObject)
    local dragging, dragInput, dragStart, startPos
    
    guiObject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = guiObject.Position
        end
    end)
    
    guiObject.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            guiObject.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    guiObject.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

-- Hacer arrastrables la burbuja y el menú
makeDraggable(bubbleBtn)
makeDraggable(mainFrame)

-- ==========================================
-- CREADOR DE BOTONES Y LÓGICA
-- ==========================================
local selectedTab = nil

local function createTab(name, position)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 90, 0, 25)
    button.Position = UDim2.new(0, 5, 0, position)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    button.Text = name
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 12
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Parent = tabFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = button
    
    return button
end

local function createToggle(name, position, parent, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, -10, 0, 30)
    toggleFrame.Position = UDim2.new(0, 5, 0, position)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    toggleFrame.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = toggleFrame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 150, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.Font = Enum.Font.SourceSans
    label.TextSize = 12
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = toggleFrame
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 35, 0, 18)
    btn.Position = UDim2.new(1, -45, 0.5, -9)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.Text = "OFF"
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 10
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Parent = toggleFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = btn
    
    local enabled = false
    
    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            btn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
            btn.Text = "ON"
        else
            btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            btn.Text = "OFF"
        end
        if callback then callback(enabled) end
    end)
end

local function createButton(name, position, parent, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Position = UDim2.new(0, 5, 0, position)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.Text = name
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 12
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
end

-- ==========================================
-- CONSTRUCCIÓN DE PESTAÑAS Y LÓGICA
-- ==========================================
local tabs = {
    {name = "Info", pos = 5},
    {name = "Movement", pos = 35},
    {name = "ESP", pos = 65},
    {name = "Items", pos = 95}
}

local tabButtons = {}

for _, tab in pairs(tabs) do
    local btn = createTab(tab.name, tab.pos)
    
    btn.MouseButton1Click:Connect(function()
        if selectedTab then selectedTab.BackgroundColor3 = Color3.fromRGB(45, 45, 45) end
        selectedTab = btn
        btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        
        for _, child in pairs(scrollingFrame:GetChildren()) do
            if child:IsA("Frame") or child:IsA("TextButton") or child:IsA("TextLabel") then child:Destroy() end
        end
        
        if tab.name == "Info" then
            scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 150)
            local infoText = Instance.new("TextLabel")
            infoText.Size = UDim2.new(1, 0, 1, 0)
            infoText.BackgroundTransparency = 1
            infoText.Text = "Creado por: JoseAngel_Blox\n\nPresiona la burbuja 'PL' para ocultar/mostrar este menú.\n\nLa burbuja y el menú se pueden arrastrar."
            infoText.Font = Enum.Font.SourceSans
            infoText.TextSize = 13
            infoText.TextColor3 = Color3.fromRGB(200, 200, 200)
            infoText.TextWrapped = true
            infoText.Parent = scrollingFrame
            
        elseif tab.name == "Movement" then
            scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 200)
            
            createToggle("Speed (50)", 5, scrollingFrame, function(state)
                if state then
                    player.Character.Humanoid.WalkSpeed = 50
                else
                    player.Character.Humanoid.WalkSpeed = 16
                end
            end)
            
            createToggle("High Jump", 40, scrollingFrame, function(state)
                if state then
                    player.Character.Humanoid.JumpPower = 100
                else
                    player.Character.Humanoid.JumpPower = 50
                end
            end)
            
            createToggle("Infinite Jump", 75, scrollingFrame, function(state)
                getgenv().InfJump = state
            end)
            
        elseif tab.name == "ESP" then
            scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 100)
            
            createToggle("Player ESP", 5, scrollingFrame, function(state)
                if state then
                    for _, v in pairs(game.Players:GetPlayers()) do
                        if v ~= player and v.Character and not v.Character:FindFirstChild("MyESP") then
                            local esp = Instance.new("Highlight")
                            esp.Name = "MyESP"
                            esp.FillColor = Color3.fromRGB(255, 0, 0)
                            esp.Parent = v.Character
                        end
                    end
                else
                    for _, v in pairs(game.Players:GetPlayers()) do
                        if v.Character and v.Character:FindFirstChild("MyESP") then
                            v.Character.MyESP:Destroy()
                        end
                    end
                end
            end)
            
        elseif tab.name == "Items" then
            scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 150)
            
            createButton("Conseguir M9", 5, scrollingFrame, function()
                local item = workspace.Prison_ITEMS.giver:FindFirstChild("M9")
                if item then workspace.Remote.ItemHandler:InvokeServer(item.ITEMPICKUP) end
            end)
            
            createButton("Conseguir Remington 870", 40, scrollingFrame, function()
                local item = workspace.Prison_ITEMS.giver:FindFirstChild("Remington 870")
                if item then workspace.Remote.ItemHandler:InvokeServer(item.ITEMPICKUP) end
            end)
        end
    end)
    tabButtons[tab.name] = btn
end

-- Lógica para Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if getgenv().InfJump and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:ChangeState("Jumping")
    end
end)

-- Iniciar en la pestaña Info
tabButtons["Info"].BackgroundColor3 = Color3.fromRGB(70, 70, 70)
selectedTab = tabButtons["Info"]
tabButtons["Info"].MouseButton1Click:Fire()
