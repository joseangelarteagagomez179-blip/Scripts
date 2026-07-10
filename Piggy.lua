-- =========================================================
-- SCRIPT: JoseAngel_Blox Piggy Pro V2.1
-- CREADO PARA: Piggy (Nuevas Funciones Avanzadas y Corregidas)
-- FECHA: 10/07/2026
-- =========================================================

local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Eliminar versión anterior si existe para evitar duplicados
if CoreGui:FindFirstChild("JoseAngel_BloxPiggyPro") then
    CoreGui.JoseAngel_BloxPiggyPro:Destroy()
end

-- ==================== CREACIÓN DE LA INTERFAZ ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_BloxPiggyPro"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
-- Hacemos la interfaz más ancha (450) y más baja (350)
MainFrame.Size = UDim2.new(0, 450, 0, 350) 
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "JoseAngel_Blox Piggy Pro"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local Separator = Instance.new("Frame")
Separator.Size = UDim2.new(0.9, 0, 0, 2)
Separator.Position = UDim2.new(0.05, 0, 0, 40)
Separator.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
Separator.Parent = MainFrame

local OptionsFrame = Instance.new("ScrollingFrame")
OptionsFrame.Size = UDim2.new(1, 0, 1, -50)
OptionsFrame.Position = UDim2.new(0, 0, 0, 50)
OptionsFrame.BackgroundTransparency = 1
OptionsFrame.ScrollBarThickness = 6
OptionsFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = OptionsFrame

-- ==================== LÓGICA DE LAS FUNCIONES ====================
local toggles = {
    ESP_Items = false,
    ESP_Players = false,
    FullBright = false,
    Speed = false,
    Noclip = false,
    Godmode = false,
    InfJump = false,
    PiggyAutoKill = false,
    PiggySpeed = false
}

local ESPFolder = Instance.new("Folder", CoreGui)
ESPFolder.Name = "JoseAngel_ESP"

-- Función para detectar quién es Piggy de forma más precisa
local function IsModelPiggy(model)
    if model:IsA("Model") and model:FindFirstChild("HumanoidRootPart") then
        -- Si es NPC (no es jugador)
        if not Players:GetPlayerFromCharacter(model) then
            return true
        end
        -- Si es un jugador, revisamos si tiene un arma equipada típica de Piggy
        local char = model
        if char:FindFirstChild("Bat") or char:FindFirstChild("Weapon") or char:FindFirstChild("Stick") then
            return true
        end
    end
    return false
end

local function UpdateESP()
    for _, child in pairs(ESPFolder:GetChildren()) do
        child:Destroy()
    end

    -- ESP Ítems Corregido
    if toggles.ESP_Items then
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("ClickDetector") and item.Parent then
                local obj = item.Parent
                local Billboard = Instance.new("BillboardGui", ESPFolder)
                Billboard.Adornee = obj
                Billboard.Size = UDim2.new(0, 100, 0, 30)
                Billboard.AlwaysOnTop = true
                
                local Text = Instance.new("TextLabel", Billboard)
                Text.Size = UDim2.new(1, 0, 1, 0)
                Text.BackgroundTransparency = 1
                Text.Text = obj.Name
                Text.TextColor3 = Color3.fromRGB(255, 255, 0)
                Text.TextScaled = true
                Text.Font = Enum.Font.GothamBold
            end
        end
    end

    -- ESP Jugadores y Piggy Corregido
    if toggles.ESP_Players then
        -- Jugadores Normales
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local isPiggy = IsModelPiggy(player.Character)
                
                local Billboard = Instance.new("BillboardGui", ESPFolder)
                Billboard.Adornee = player.Character.HumanoidRootPart
                Billboard.Size = UDim2.new(0, 100, 0, 30)
                Billboard.AlwaysOnTop = true
                
                local Text = Instance.new("TextLabel", Billboard)
                Text.Size = UDim2.new(1, 0, 1, 0)
                Text.BackgroundTransparency = 1
                
                if isPiggy then
                    Text.Text = "🚨 PIGGY ("..player.Name..") 🚨"
                    Text.TextColor3 = Color3.fromRGB(255, 0, 0) -- Rojo para el jugador asesino
                else
                    Text.Text = player.Name
                    Text.TextColor3 = Color3.fromRGB(0, 255, 0) -- Verde para supervivientes
                end
                
                Text.TextScaled = true
                Text.Font = Enum.Font.GothamBold
            end
        end
        
        -- Piggy NPC (Bot)
        for _, model in pairs(workspace:GetChildren()) do
            if IsModelPiggy(model) and not Players:GetPlayerFromCharacter(model) then
                local Billboard = Instance.new("BillboardGui", ESPFolder)
                Billboard.Adornee = model:FindFirstChild("HumanoidRootPart")
                Billboard.Size = UDim2.new(0, 100, 0, 30)
                Billboard.AlwaysOnTop = true
                
                local Text = Instance.new("TextLabel", Billboard)
                Text.Size = UDim2.new(1, 0, 1, 0)
                Text.BackgroundTransparency = 1
                Text.Text = "🚨 PIGGY BOT 🚨"
                Text.TextColor3 = Color3.fromRGB(255, 0, 0)
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

    -- Godmode Corregido (Destruye las armas de Piggy si te acercas)
    if toggles.Godmode then
        for _, model in pairs(workspace:GetDescendants()) do
            if model:IsA("Model") and IsModelPiggy(model) and model ~= LocalPlayer.Character then
                for _, part in pairs(model:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name == "Bat" or part.Name == "Weapon" then
                        if part:FindFirstChild("TouchInterest") then
                            part.TouchInterest:Destroy()
                        end
                    end
                end
            end
        end
    end
    
    -- Auto Matar (Solo si eres Piggy)
    if toggles.PiggyAutoKill and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                -- Teletransportarse detrás de los jugadores constantemente
                LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
            end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    -- Velocidad Superviviente
    if toggles.Speed and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 25
    end
    
    -- Velocidad Rol Piggy
    if toggles.PiggySpeed and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 35
    end
    
    -- Fullbright
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

-- Actualizar ESP cada 1.5 segundos con pcall para evitar crasheos
task.spawn(function()
    while task.wait(1.5) do
        pcall(function()
            UpdateESP()
        end)
    end
end)

-- ==================== CREADOR DE COMPONENTES DE UI ====================
local layoutOrderCounter = 0

local function CreateHeader(text)
    layoutOrderCounter = layoutOrderCounter + 1
    local Header = Instance.new("TextLabel")
    Header.Size = UDim2.new(1, 0, 0, 25)
    Header.BackgroundTransparency = 1
    Header.Text = text
    Header.TextColor3 = Color3.fromRGB(0, 255, 255)
    Header.TextSize = 16
    Header.Font = Enum.Font.GothamBlack
    Header.LayoutOrder = layoutOrderCounter
    Header.Parent = OptionsFrame
end

local function CreateInfoText(text)
    layoutOrderCounter = layoutOrderCounter + 1
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 18)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.TextSize = 14
    Label.Font = Enum.Font.Gotham
    Label.LayoutOrder = layoutOrderCounter
    Label.Parent = OptionsFrame
end

local function CreateToggle(name, flagName)
    layoutOrderCounter = layoutOrderCounter + 1
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(0.95, 0, 0, 35)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    ToggleFrame.LayoutOrder = layoutOrderCounter
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
    Label.TextSize = 14
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 50, 0, 24)
    Button.Position = UDim2.new(0.85, -10, 0.5, -12)
    Button.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    Button.Text = "OFF"
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.GothamBold
    Button.Parent = ToggleFrame

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 12)
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
            
            -- Restaurar valores normales
            if flagName == "Speed" or flagName == "PiggySpeed" then
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                    LocalPlayer.Character.Humanoid.WalkSpeed = 16
                end
            elseif flagName == "FullBright" then
                game:GetService("Lighting").Ambient = Color3.fromRGB(127, 127, 127)
                game:GetService("Lighting").GlobalShadows = true
            end
        end
    end)
end

-- ==================== CONSTRUCCIÓN DEL MENÚ ====================

-- 1) INFO
CreateHeader("1) Info ↓")
CreateInfoText("Nombre del Creador: JoseAngel_Blox")
CreateInfoText("Fecha de actualización: 10/07/2026")
CreateInfoText("Versión: 1.2")

-- ESPACIO
CreateInfoText("") 

-- 2) MAIN
CreateHeader("2) Main")
CreateToggle("🛡️ Godmode (Anti-Piggy)", "Godmode")
CreateToggle("👻 Noclip (Atravesar Paredes)", "Noclip")
CreateToggle("🚀 Salto Infinito", "InfJump")
CreateToggle("⚡ Correr Rápido (Superviviente)", "Speed")
CreateToggle("🔍 ESP Ítems (Ver llaves autom.)", "ESP_Items")
CreateToggle("👀 ESP Jugadores y Piggy", "ESP_Players")
CreateToggle("💡 Visión Nocturna", "FullBright")

-- ESPACIO
CreateInfoText("")

-- 3) ROL PIGGY
CreateHeader("3) Rol Piggy")
CreateToggle("🔪 Auto-Matar (Teleport a Todos)", "PiggyAutoKill")
CreateToggle("🔥 Correr Súper Rápido (Piggy)", "PiggySpeed")

print("JoseAngel_Blox Piggy Pro V1.2 cargado correctamente. ¡Disfruta!")
