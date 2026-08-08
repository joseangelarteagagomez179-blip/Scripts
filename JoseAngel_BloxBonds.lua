-- ═══════════════════════════════════════════════════════════
-- JoseAngel_Blox Bonds - Auto Farm Script para Dead Rails
-- Optimizado para Delta Executor
-- ═══════════════════════════════════════════════════════════

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ═══════════════════════════════════════════════════════════
-- CONFIGURACIÓN
-- ═══════════════════════════════════════════════════════════
local Settings = {
    FarmEnabled = false,
    FarmSpeed = 1, -- Segundos entre cada acción
    CollectRadius = 100 -- Radio para detectar items
}

-- ═══════════════════════════════════════════════════════════
-- CREACIÓN DE LA UI
-- ═══════════════════════════════════════════════════════════
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngelBloxUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = playerGui

-- Frame principal (cuadrado con esquinas redondeadas)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Esquinas redondeadas
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

-- Borde decorativo
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 215, 0) -- Dorado
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Título: JoseAngel_Blox Bonds (en amarillo)
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 10)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Title.BackgroundTransparency = 1
Title.Text = "JoseAngel_Blox Bonds"
Title.TextColor3 = Color3.fromRGB(255, 215, 0) -- Amarillo
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- Separador
local Separator = Instance.new("Frame")
Separator.Size = UDim2.new(0.9, 0, 0, 2)
Separator.Position = UDim2.new(0.05, 0, 0, 55)
Separator.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
Separator.BorderSizePixel = 0
Separator.Parent = MainFrame

-- Label de la función
local FunctionLabel = Instance.new("TextLabel")
FunctionLabel.Name = "FunctionLabel"
FunctionLabel.Size = UDim2.new(1, 0, 0, 30)
FunctionLabel.Position = UDim2.new(0, 0, 0, 70)
FunctionLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
FunctionLabel.BackgroundTransparency = 1
FunctionLabel.Text = "Auto Farm Bonds"
FunctionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FunctionLabel.TextSize = 18
FunctionLabel.Font = Enum.Font.GothamMedium
FunctionLabel.Parent = MainFrame

-- Botón de Toggle
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0.7, 0, 0, 40)
ToggleButton.Position = UDim2.new(0.15, 0, 0, 110)
ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
ToggleButton.Text = "OFF"
ToggleButton.TextColor3 = Color3.fromRGB(255, 80, 80) -- Rojo cuando está OFF
ToggleButton.TextSize = 18
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Parent = MainFrame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 10)
ToggleCorner.Parent = ToggleButton

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(255, 80, 80)
ToggleStroke.Thickness = 2
ToggleStroke.Parent = ToggleButton

-- Estado actual
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Position = UDim2.new(0, 0, 0, 160)
StatusLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Estado: Inactivo"
StatusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
StatusLabel.TextSize = 14
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Parent = MainFrame

-- ═══════════════════════════════════════════════════════════
-- LÓGICA DEL AUTO FARM
-- ═══════════════════════════════════════════════════════════
local function collectBonds()
    if not Settings.FarmEnabled then return end
    
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    -- Buscar items de valor (coal, scrap, gold, etc.)
    for _, item in pairs(workspace:GetDescendants()) do
        if not Settings.FarmEnabled then break end
        
        if item:IsA("Model") or item:IsA("Part") then
            local itemName = string.lower(item.Name)
            
            -- Detectar items que dan bonds
            if itemName:find("coal") or itemName:find("scrap") or 
               itemName:find("gold") or itemName:find("corpse") or
               itemName:find("bond") or itemName:find("money") then
                
                local itemPosition = item:FindFirstChild("HumanoidRootPart") 
                    and item.HumanoidRootPart.Position 
                    or item.Position
                
                local distance = (humanoidRootPart.Position - itemPosition).Magnitude
                
                if distance <= Settings.CollectRadius then
                    -- Teletransportar al item
                    humanoidRootPart.CFrame = CFrame.new(itemPosition)
                    wait(0.5)
                    
                    -- Intentar recoger el item
                    local tool = item:FindFirstChildWhichIsA("Tool")
                    if tool then
                        tool.Parent = character
                        wait(0.2)
                    end
                end
            end
        end
    end
end

-- Loop principal del Auto Farm
spawn(function()
    while wait(Settings.FarmSpeed) do
        if Settings.FarmEnabled then
            collectBonds()
        end
    end
end)

-- ═══════════════════════════════════════════════════════════
-- EVENTOS DEL TOGGLE
-- ═══════════════════════════════════════════════════════════
ToggleButton.MouseButton1Click:Connect(function()
    Settings.FarmEnabled = not Settings.FarmEnabled
    
    if Settings.FarmEnabled then
        ToggleButton.Text = "ON"
        ToggleButton.TextColor3 = Color3.fromRGB(80, 255, 80) -- Verde
        ToggleStroke.Color = Color3.fromRGB(80, 255, 80)
        StatusLabel.Text = "Estado: Farmeando Bonds..."
        StatusLabel.TextColor3 = Color3.fromRGB(80, 255, 80)
    else
        ToggleButton.Text = "OFF"
        ToggleButton.TextColor3 = Color3.fromRGB(255, 80, 80) -- Rojo
        ToggleStroke.Color = Color3.fromRGB(255, 80, 80)
        StatusLabel.Text = "Estado: Inactivo"
        StatusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    end
end)

-- Hacer el Frame arrastrable
local dragging = false
local dragInput, mousePos, framePos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        mousePos = input.Position
        framePos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - mousePos
        MainFrame.Position = UDim2.new(
            framePos.X.Scale,
            framePos.X.Offset + delta.X,
            framePos.Y.Scale,
            framePos.Y.Offset + delta.Y
        )
    end
end)

print("✅ JoseAngel_Blox Bonds Script cargado correctamente!")
print("🎮 Auto Farm Bonds: " .. (Settings.FarmEnabled and "ACTIVADO" or "DESACTIVADO"))
