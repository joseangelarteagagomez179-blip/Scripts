-- =========================================================
-- SCRIPT: JoseAngel_Blox Piggy Pro V2
-- CREADO PARA: Piggy (Nuevas Funciones Avanzadas)
-- =========================================================

local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Eliminar versión anterior si existe
if CoreGui:FindFirstChild("JoseAngel_BloxPiggyPro") then
    CoreGui.JoseAngel_BloxPiggyPro:Destroy()
end

-- ==================== CREACIÓN DE LA INTERFAZ ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_BloxPiggyPro"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 420) -- Un poco más alto para que quepa más
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "JoseAngel_Blox Piggy Pro"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local Separator = Instance.new("Frame")
Separator.Size = UDim2.new(0.9, 0, 0, 2)
Separator.Position = UDim2.new(0.05, 0, 0, 50)
Separator.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
Separator.Parent = MainFrame

local OptionsFrame = Instance.new("ScrollingFrame")
OptionsFrame.Size = UDim2.new(1, 0, 1, -60)
OptionsFrame.Position = UDim2.new(0, 0, 0, 60)
OptionsFrame.BackgroundTransparency = 1
OptionsFrame.ScrollBarThickness = 6
OptionsFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Parent = OptionsFrame

-- ==================== LÓGICA DE LAS FUNCIONES ====================
local toggles = {
    ESP_Items = false,
    ESP_Players = false,
    FullBright = false,
    Speed = false,
    Noclip = false,
    Godmode = false,
    InfJump = false
}

local itemList = {
    "Key", "Llave", "Hammer", "Martillo", "Wrench", "Plank", "Tabla", 
    "Gear", "Engranaje", "Gas", "Battery", "Bateria", "Torch", "Antorcha", 
    "Wood", "Leña", "Book", "Libro", "Syringe", "Jeringa", "Crossbow", "Ballesta", 
    "Ammo", "Municion", "Chain", "Cadena", "Hook", "Gancho", "Grass", "Pasto", 
    "Shovel", "Pala", "Code", "Codigo", "Tube", "Tubo", "Screwdriver", "Destornillador", 
    "Broom", "Escoba", "Scissors", "Tijeras", "Carrot", "Zanahoria", "Ladder", 
    "Escalera", "Smoke", "Humo", "Lens", "Lente", "Crowbar", "Palanca"
}

local ESPFolder = Instance.new("Folder", CoreGui)
ESPFolder.Name = "JoseAngel_ESP"

local function UpdateESP()
    for _, child in pairs(ESPFolder:GetChildren()) do
        child:Destroy()
    end

    -- ESP Ítems
    if toggles.ESP_Items then
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("Part") or item:IsA("MeshPart") then
                if item:FindFirstChildOfClass("ClickDetector") then
                    local isItem = false
                    for _, name in pairs(itemList) do
                        if string.find(string.lower(item.Name), string.lower(name)) or string.find(string.lower(item.Parent.Name), string.lower(name)) then
                            isItem = true
                        end
                    end
                    if isItem then
                        local Billboard = Instance.new("BillboardGui", ESPFolder)
                        Billboard.Adornee = item
                        Billboard.Size = UDim2.new(0, 100, 0, 30)
                        Billboard.AlwaysOnTop = true
                        local Text = Instance.new("TextLabel", Billboard)
                        Text.Size = UDim2.new(1, 0, 1, 0)
                        Text.BackgroundTransparency = 1
                        Text.Text = item.Parent.Name
                        Text.TextColor3 = Color3.fromRGB(255, 255, 0)
                        Text.TextScaled = true
                        Text.Font = Enum.Font.GothamBold
                    end
                end
            end
        end
    end

    -- ESP Jugadores y Piggy
    if toggles.ESP_Players then
        -- Jugadores
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local Billboard = Instance.new("BillboardGui", ESPFolder)
                Billboard.Adornee = player.Character.HumanoidRootPart
                Billboard.Size = UDim2.new(0, 100, 0, 30)
                Billboard.AlwaysOnTop = true
                local Text = Instance.new("TextLabel", Billboard)
                Text.Size = UDim2.new(1, 0, 1, 0)
                Text.BackgroundTransparency = 1
                Text.Text = player.Name
                Text.TextColor3 = Color3.fromRGB(0, 255, 0) -- Verde
                Text.TextScaled = true
                Text.Font = Enum.Font.GothamBold
            end
        end
        -- Piggy (NPC)
        for _, model in pairs(workspace:GetChildren()) do
            if model:IsA("Model") and model:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(model) then
                local Billboard = Instance.new("BillboardGui", ESPFolder)
                Billboard.Adornee = model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart
                Billboard.Size = UDim2.new(0, 100, 0, 30)
                Billboard.AlwaysOnTop = true
                local Text = Instance.new("TextLabel", Billboard)
                Text.Size = UDim2.new(1, 0, 1, 0)
                Text.BackgroundTransparency = 1
                Text.Text = "🚨 PIGGY 🚨"
                Text.TextColor3 = Color3.fromRGB(255, 0, 0) -- Rojo
                Text.TextScaled = true
                Text.Font = Enum.Font.GothamBold
            end
        end
    end
end

-- Bucle rápido para funciones continuas
RunService.Stepped:Connect(function()
    -- Noclip (Atravesar paredes)
    if toggles.Noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end

    -- Godmode (Anti-Piggy)
    if toggles.Godmode then
        for _, model in pairs(workspace:GetChildren()) do
            -- Detectar si es un NPC (Piggy)
            if model:IsA("Model") and model:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(model) then
                -- Buscar el arma u objeto que mata y borrarle la colisión de daño
                for _, part in pairs(model:GetDescendants()) do
                    if part:IsA("BasePart") and part:FindFirstChild("TouchInterest") then
                        part.TouchInterest:Destroy()
                    end
                end
            end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if toggles.Speed and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 25
    end
    
    if toggles.FullBright then
        game:GetService("Lighting").Ambient = Color3.new(1, 1, 1)
        game:GetService("Lighting").GlobalShadows = false
    end
end)

-- Salto Infinito
UserInputService.JumpRequest:Connect(function()
    if toggles.InfJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Actualizar ESP cada 2 segundos
task.spawn(function()
    while task.wait(2) do
        UpdateESP()
    end
end)

-- ==================== CREADOR DE BOTONES (INTERRUPTORES) ====================
local function CreateToggle(name, flagName)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(0.9, 0, 0, 40)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    ToggleFrame.Parent = OptionsFrame

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 8)
    ToggleCorner.Parent = ToggleFrame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0.05, 0, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 15
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 60, 0, 26)
    Button.Position = UDim2.new(0.8, -10, 0.5, -13)
    Button.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    Button.Text = "OFF"
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.GothamBold
    Button.Parent = ToggleFrame

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 13)
    BtnCorner.Parent = Button

    Button.MouseButton1Click:Connect(function()
        toggles[flagName] = not toggles[flagName]
        if toggles[flagName] then
            Button.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
            Button.Text = "ON"
            if flagName == "ESP_Items" or flagName == "ESP_Players" then UpdateESP() end
        else
            Button.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            Button.Text = "OFF"
            if flagName == "ESP_Items" or flagName == "ESP_Players" then UpdateESP() end
            
            -- Restaurar valores
            if flagName == "Speed" and LocalPlayer.Character then
                LocalPlayer.Character.Humanoid.WalkSpeed = 16
            elseif flagName == "FullBright" then
                game:GetService("Lighting").Ambient = Color3.fromRGB(127, 127, 127)
                game:GetService("Lighting").GlobalShadows = true
            end
        end
    end)
end

-- ==================== AGREGAR LAS OPCIONES AL MENÚ ====================
CreateToggle("🛡️ Godmode (Anti-Piggy)", "Godmode")
CreateToggle("👻 Noclip (Atravesar Paredes)", "Noclip")
CreateToggle("🚀 Salto Infinito", "InfJump")
CreateToggle("⚡ Correr Rápido", "Speed")
CreateToggle("🔍 ESP Ítems (Ver llaves)", "ESP_Items")
CreateToggle("👀 ESP Jugadores y Piggy", "ESP_Players")
CreateToggle("💡 Visión Nocturna", "FullBright")

print("JoseAngel_Blox Piggy Pro V2 cargado correctamente.")
