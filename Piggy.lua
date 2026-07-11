-- =========================================================
-- SCRIPT: JoseAngel_Blox Piggy Pro V1.3
-- CREADO PARA: Piggy 
-- FECHA DE ACTUALIZACIÓN: 10/07/2026
-- =========================================================

local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
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
MainFrame.Size = UDim2.new(0, 450, 0, 350) 
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "JoseAngel_Blox Piggy Pro"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.TextSize = 20
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
OptionsFrame.ScrollBarThickness = 4
OptionsFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 5)
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

-- Detección de Piggy (Bot o Jugador)
local function IsModelPiggy(model)
    if model:IsA("Model") and model:FindFirstChild("HumanoidRootPart") then
        if not Players:GetPlayerFromCharacter(model) then return true end
        if model:FindFirstChild("Bat") or model:FindFirstChild("Weapon") then return true end
    end
    return false
end

local function UpdateESP()
    for _, child in pairs(ESPFolder:GetChildren()) do
        child:Destroy()
    end

    -- ESP Ítems Corregido (Sin números raros)
    if toggles.ESP_Items then
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("ClickDetector") and item.Parent then
                local obj = item.Parent
                -- Filtro estricto: Debe ser texto, no un número, y mayor a 2 letras
                if typeof(obj.Name) == "string" and not tonumber(obj.Name) and string.len(obj.Name) > 2 then
                    local Billboard = Instance.new("BillboardGui", ESPFolder)
                    Billboard.Adornee = obj
                    Billboard.Size = UDim2.new(0, 100, 0, 25)
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
    end

    -- ESP Jugadores y Piggy Corregido
    if toggles.ESP_Players then
        -- Jugadores y Bots mezclados
        for _, model in pairs(workspace:GetChildren()) do
            if model:IsA("Model") and model:FindFirstChild("HumanoidRootPart") and model ~= LocalPlayer.Character then
                local isPlayer = Players:GetPlayerFromCharacter(model)
                local isPiggy = IsModelPiggy(model)
                
                local Billboard = Instance.new("BillboardGui", ESPFolder)
                Billboard.Adornee = model:FindFirstChild("HumanoidRootPart")
                Billboard.Size = UDim2.new(0, 100, 0, 25)
                Billboard.AlwaysOnTop = true
                
                local Text = Instance.new("TextLabel", Billboard)
                Text.Size = UDim2.new(1, 0, 1, 0)
                Text.BackgroundTransparency = 1
                Text.TextScaled = true
                Text.Font = Enum.Font.GothamBold
                
                if isPiggy then
                    Text.Text = isPlayer and "🚨 PIGGY ("..isPlayer.Name..")" or "🚨 PIGGY BOT 🚨"
                    Text.TextColor3 = Color3.fromRGB(255, 0, 0)
                elseif isPlayer then
                    Text.Text = isPlayer.Name
                    Text.TextColor3 = Color3.fromRGB(0, 255, 0)
                end
            end
        end
    end
end

-- Funciones Continuas
RunService.Stepped:Connect(function()
    -- Noclip
    if toggles.Noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end

    -- Godmode Corregido (Elimina TODO el daño de Piggy y Bots)
    if toggles.Godmode then
        for _, model in pairs(workspace:GetChildren()) do
            if model:IsA("Model") and model:FindFirstChild("Humanoid") and model ~= LocalPlayer.Character then
                -- Busca transmisores de toque (lo que te mata al tocarlo) y los destruye
                for _, part in pairs(model:GetDescendants()) do
                    if part:IsA("TouchTransmitter") then
                        part:Destroy()
                    end
                end
            end
        end
    end
    
    -- Auto Matar (Piggy)
    if toggles.PiggyAutoKill and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1.5)
            end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if toggles.Speed and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 25
    end
    if toggles.PiggySpeed and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 35
    end
    if toggles.FullBright then
        game:GetService("Lighting").Ambient = Color3.new(1, 1, 1)
        game:GetService("Lighting").GlobalShadows = false
    end
end)

UserInputService.JumpRequest:Connect(function()
    if toggles.InfJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

task.spawn(function()
    while task.wait(1.5) do
        pcall(UpdateESP)
    end
end)

-- ==================== CREADOR DE INTERFAZ (UI COMPONENTS) ====================
local layoutOrderCounter = 0

local function CreateHeader(text)
    layoutOrderCounter = layoutOrderCounter + 1
    local Header = Instance.new("TextLabel")
    Header.Size = UDim2.new(1, 0, 0, 25)
    Header.BackgroundTransparency = 1
    Header.Text = text
    Header.TextColor3 = Color3.fromRGB(0, 255, 255)
    Header.TextSize = 14
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
    Label.TextColor3 = Color3.fromRGB(180, 180, 180)
    Label.TextSize = 12
    Label.Font = Enum.Font.Gotham
    Label.LayoutOrder = layoutOrderCounter
    Label.Parent = OptionsFrame
end

-- Creación del Interruptor (Toggle Switch) Moderno
local function CreateModernToggle(name, flagName)
    layoutOrderCounter = layoutOrderCounter + 1
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(0.9, 0, 0, 35)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.LayoutOrder = layoutOrderCounter
    ToggleFrame.Parent = OptionsFrame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0.02, 0, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 13
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame

    -- Fondo del interruptor
    local SwitchBack = Instance.new("Frame")
    SwitchBack.Size = UDim2.new(0, 40, 0, 20)
    SwitchBack.Position = UDim2.new(0.85, -10, 0.5, -10)
    SwitchBack.BackgroundColor3 = Color3.fromRGB(255, 50, 50) -- Empieza en rojo
    SwitchBack.Parent = ToggleFrame

    local SwitchCorner = Instance.new("UICorner")
    SwitchCorner.CornerRadius = UDim.new(1, 0)
    SwitchCorner.Parent = SwitchBack

    -- Círculo deslizable
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 16, 0, 16)
    Knob.Position = UDim2.new(0, 2, 0.5, -8)
    Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Knob.Parent = SwitchBack

    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(1, 0)
    KnobCorner.Parent = Knob

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 1, 0)
    Button.BackgroundTransparency = 1
    Button.Text = ""
    Button.Parent = SwitchBack

    Button.MouseButton1Click:Connect(function()
        toggles[flagName] = not toggles[flagName]
        local state = toggles[flagName]

        -- Animaciones
        local goalColor = state and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
        local goalPos = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        
        TweenService:Create(SwitchBack, TweenInfo.new(0.2), {BackgroundColor3 = goalColor}):Play()
        TweenService:Create(Knob, TweenInfo.new(0.2), {Position = goalPos}):Play()

        if state then
            if flagName == "ESP_Items" or flagName == "ESP_Players" then UpdateESP() end
        else
            if flagName == "ESP_Items" or flagName == "ESP_Players" then UpdateESP() end
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

CreateHeader("1) Info ↓")
CreateInfoText("Nombre del Creador: JoseAngel_Blox")
CreateInfoText("Fecha de actualización: 10/07/2026")
CreateInfoText("Versión: 1.3")
CreateInfoText("") 

CreateHeader("2) Main")
CreateModernToggle("🛡️ Godmode (Anti-Piggy/Bots)", "Godmode")
CreateModernToggle("👻 Noclip (Atravesar Paredes)", "Noclip")
CreateModernToggle("🚀 Salto Infinito", "InfJump")
CreateModernToggle("⚡ Correr Rápido (Superviviente)", "Speed")
CreateModernToggle("🔍 ESP Ítems (Filtro numérico)", "ESP_Items")
CreateModernToggle("👀 ESP Jugadores y Piggy", "ESP_Players")
CreateModernToggle("💡 Visión Nocturna", "FullBright")
CreateInfoText("")

CreateHeader("3) Rol Piggy")
CreateModernToggle("🔪 Auto-Matar (Teleport a Todos)", "PiggyAutoKill")
CreateModernToggle("🔥 Correr Súper Rápido (Piggy)", "PiggySpeed")
