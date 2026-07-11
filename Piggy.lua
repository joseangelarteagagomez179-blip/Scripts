-- =========================================================
-- SCRIPT: JoseAngel_Blox Piggy Pro V1.4
-- CREADO PARA: Piggy (Fix Ítems, Godmode y Menú Ocultable)
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

-- Botón para Ocultar/Mostrar Menú
local ToggleMenuBtn = Instance.new("TextButton")
ToggleMenuBtn.Size = UDim2.new(0, 150, 0, 40)
ToggleMenuBtn.Position = UDim2.new(0, 10, 0, 10)
ToggleMenuBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ToggleMenuBtn.Text = "👁️ Abrir / Cerrar Menú"
ToggleMenuBtn.TextColor3 = Color3.fromRGB(0, 255, 255)
ToggleMenuBtn.Font = Enum.Font.GothamBold
ToggleMenuBtn.TextSize = 12
ToggleMenuBtn.Parent = ScreenGui

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = ToggleMenuBtn

-- Marco Principal (MainFrame)
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

-- Funcionalidad del botón ocultar
ToggleMenuBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "JoseAngel_Blox Piggy Pro V1.4"
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

-- Diccionario de ítems extraído de tu lista (Libro 1 y Libro 2)
local validItems = {
    "key", "llave", "hammer", "martillo", "wrench", "inglesa", 
    "plank", "tabla", "gear", "engranaje", "gas", "battery", 
    "bateria", "egg", "huevo", "torch", "antorcha", "wood", 
    "leña", "book", "libro", "syringe", "jeringa", "crossbow", 
    "ballesta", "ammo", "municion", "chain", "cadena", "hook", 
    "gancho", "grass", "pasto", "shovel", "pala", "code", "codigo", 
    "tube", "tubo", "screwdriver", "destornillador", "broom", 
    "escoba", "scissors", "tijeras", "carrot", "zanahoria", 
    "ladder", "escalera", "smoke", "humo", "lens", "lente", 
    "crowbar", "palanca", "elevator", "ascensor"
}

local function UpdateESP()
    for _, child in pairs(ESPFolder:GetChildren()) do
        child:Destroy()
    end

    -- ESP Ítems Corregido (Usando diccionario exacto)
    if toggles.ESP_Items then
        for _, clickDetect in pairs(workspace:GetDescendants()) do
            if clickDetect:IsA("ClickDetector") and clickDetect.Parent then
                local objName = string.lower(clickDetect.Parent.Name)
                local isRealItem = false
                
                -- Verificar si el nombre coincide con algún ítem de la lista
                for _, itemName in pairs(validItems) do
                    if string.find(objName, itemName) then
                        isRealItem = true
                        break
                    end
                end
                
                if isRealItem then
                    local Billboard = Instance.new("BillboardGui", ESPFolder)
                    Billboard.Adornee = clickDetect.Parent
                    Billboard.Size = UDim2.new(0, 100, 0, 25)
                    Billboard.AlwaysOnTop = true
                    
                    local Text = Instance.new("TextLabel", Billboard)
                    Text.Size = UDim2.new(1, 0, 1, 0)
                    Text.BackgroundTransparency = 1
                    Text.Text = clickDetect.Parent.Name
                    Text.TextColor3 = Color3.fromRGB(255, 255, 0) -- Amarillo
                    Text.TextScaled = true
                    Text.Font = Enum.Font.GothamBold
                end
            end
        end
    end

    -- ESP Jugadores y Piggy Corregido
    if toggles.ESP_Players then
        -- Buscar Jugadores
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local Billboard = Instance.new("BillboardGui", ESPFolder)
                Billboard.Adornee = player.Character:FindFirstChild("Head") or player.Character.PrimaryPart
                Billboard.Size = UDim2.new(0, 100, 0, 25)
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
        
        -- Buscar Bots (NPCs)
        for _, model in pairs(workspace:GetDescendants()) do
            if model:IsA("Model") and model:FindFirstChild("Humanoid") and model ~= LocalPlayer.Character then
                if not Players:GetPlayerFromCharacter(model) then -- Si no es un jugador, es el Bot Asesino
                    local Billboard = Instance.new("BillboardGui", ESPFolder)
                    Billboard.Adornee = model:FindFirstChild("Head") or model.PrimaryPart
                    Billboard.Size = UDim2.new(0, 120, 0, 30)
                    Billboard.AlwaysOnTop = true
                    
                    local Text = Instance.new("TextLabel", Billboard)
                    Text.Size = UDim2.new(1, 0, 1, 0)
                    Text.BackgroundTransparency = 1
                    Text.Text = "🚨 PIGGY BOT 🚨"
                    Text.TextColor3 = Color3.fromRGB(255, 0, 0) -- Rojo
                    Text.TextScaled = true
                    Text.Font = Enum.Font.GothamBlack
                end
            end
        end
    end
end

-- Funciones Continuas Rápidas (Godmode y más)
RunService.Stepped:Connect(function()
    -- Noclip
    if toggles.Noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end

    -- Godmode Total: Bloquea toques y destruye armas enemigas
    if toggles.Godmode and LocalPlayer.Character then
        for _, enemy in pairs(workspace:GetDescendants()) do
            if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") and enemy ~= LocalPlayer.Character then
                local isPlayer = Players:GetPlayerFromCharacter(enemy)
                local isEnemyBot = not isPlayer
                local isPiggyPlayer = enemy:FindFirstChild("Bat") or enemy:FindFirstChild("Weapon")
                
                if isEnemyBot or isPiggyPlayer then
                    for _, part in pairs(enemy:GetDescendants()) do
                        -- Deshabilita CanTouch para que su script de daño no funcione
                        if part:IsA("BasePart") then
                            part.CanTouch = false 
                        end
                        -- Destruye cualquier herramienta que tenga
                        if part:IsA("Tool") or part.Name == "Bat" or part.Name == "Weapon" then
                            part:Destroy()
                        end
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

-- ==================== CREADOR DE INTERFAZ ====================
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

    local SwitchBack = Instance.new("Frame")
    SwitchBack.Size = UDim2.new(0, 40, 0, 20)
    SwitchBack.Position = UDim2.new(0.85, -10, 0.5, -10)
    SwitchBack.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    SwitchBack.Parent = ToggleFrame

    local SwitchCorner = Instance.new("UICorner")
    SwitchCorner.CornerRadius = UDim.new(1, 0)
    SwitchCorner.Parent = SwitchBack

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

        local goalColor = state and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
        local goalPos = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        
        TweenService:Create(SwitchBack, TweenInfo.new(0.2), {BackgroundColor3 = goalColor}):Play()
        TweenService:Create(Knob, TweenInfo.new(0.2), {Position = goalPos}):Play()

        pcall(UpdateESP)

        if not state then
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
CreateInfoText("Versión: 1.4")
CreateInfoText("") 

CreateHeader("2) Main")
CreateModernToggle("🛡️ Godmode (Inmortalidad Total)", "Godmode")
CreateModernToggle("👻 Noclip (Atravesar Paredes)", "Noclip")
CreateModernToggle("🚀 Salto Infinito", "InfJump")
CreateModernToggle("⚡ Correr Rápido (Superviviente)", "Speed")
CreateModernToggle("🔍 ESP Ítems (Lista Libro 1 y 2)", "ESP_Items")
CreateModernToggle("👀 ESP Jugadores y Bots", "ESP_Players")
CreateModernToggle("💡 Visión Nocturna", "FullBright")
CreateInfoText("")

CreateHeader("3) Rol Piggy")
CreateModernToggle("🔪 Auto-Matar (Teleport a Todos)", "PiggyAutoKill")
CreateModernToggle("🔥 Correr Súper Rápido (Piggy)", "PiggySpeed")
