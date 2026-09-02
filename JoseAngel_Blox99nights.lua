-- ========================================================
-- SCRIPT COMPLETO: JoseAngel_Blox 99nights
-- Creado para: 99 Noches en el Bosque
-- ========================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()

-- Asignación de Interfaz Segura (Anti-Bloqueo)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox_UI"
ScreenGui.ResetOnSpawn = false

if gethui then
    pcall(function() ScreenGui.Parent = gethui() end)
elseif syn and syn.protect_gui then
    pcall(function()
        syn.protect_gui(ScreenGui)
        ScreenGui.Parent = game:GetService("CoreGui")
    end)
else
    pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end)
end

if not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- ========================================================
-- 1. PANTALLA DE CARGA (ANIMACIÓN DE 1% A 100%)
-- ========================================================
local LoadingFrame = Instance.new("Frame")
LoadingFrame.Size = UDim2.new(0, 360, 0, 160)
LoadingFrame.Position = UDim2.new(0.5, -180, 0.5, -80)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(10, 20, 38) -- Fondo Azul Marino
LoadingFrame.BorderSizePixel = 0
LoadingFrame.Parent = ScreenGui

local LoadingCorner = Instance.new("UICorner")
LoadingCorner.CornerRadius = UDim.new(0, 12)
LoadingCorner.Parent = LoadingFrame

local WelcomeText = Instance.new("TextLabel")
WelcomeText.Size = UDim2.new(1, -20, 0, 40)
WelcomeText.Position = UDim2.new(0, 10, 0, 15)
WelcomeText.BackgroundTransparency = 1
WelcomeText.Text = "Bienvenidos a Scripts JoseAngel_Blox"
WelcomeText.TextColor3 = Color3.fromRGB(0, 162, 255) -- Letras Azules
WelcomeText.TextSize = 16
WelcomeText.Font = Enum.Font.SourceSansBold
WelcomeText.Parent = LoadingFrame

local PercentText = Instance.new("TextLabel")
PercentText.Size = UDim2.new(1, 0, 0, 25)
PercentText.Position = UDim2.new(0, 0, 0, 60)
PercentText.BackgroundTransparency = 1
PercentText.Text = "Cargando... 0%"
PercentText.TextColor3 = Color3.fromRGB(200, 220, 255)
PercentText.TextSize = 14
PercentText.Font = Enum.Font.SourceSans
PercentText.Parent = LoadingFrame

local BarBackground = Instance.new("Frame")
BarBackground.Size = UDim2.new(0.85, 0, 0, 12)
BarBackground.Position = UDim2.new(0.075, 0, 0, 100)
BarBackground.BackgroundColor3 = Color3.fromRGB(20, 35, 60)
BarBackground.BorderSizePixel = 0
BarBackground.Parent = LoadingFrame

local BarCorner = Instance.new("UICorner")
BarCorner.CornerRadius = UDim.new(0, 6)
BarCorner.Parent = BarBackground

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
BarFill.BorderSizePixel = 0
BarFill.Parent = BarBackground

local FillCorner = Instance.new("UICorner")
FillCorner.CornerRadius = UDim.new(0, 6)
FillCorner.Parent = BarFill

-- ========================================================
-- 2. INTERFAZ PRINCIPAL (MENÚ AZUL MARINO)
-- ========================================================
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 520, 0, 340)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -170)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 20, 38) -- Azul Marino
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Títulos
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 0, 25)
Title.Position = UDim2.new(0, 15, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "JoseAngel_Blox 99nights"
Title.TextColor3 = Color3.fromRGB(0, 162, 255) -- Letras Azules
Title.TextSize = 18
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, -20, 0, 20)
Subtitle.Position = UDim2.new(0, 15, 0, 32)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Creado por JoseAngel_Blox"
Subtitle.TextColor3 = Color3.fromRGB(255, 255, 255)
Subtitle.TextTransparency = 0.5 -- Transparente
Subtitle.TextSize = 13
Subtitle.Font = Enum.Font.SourceSansItalic
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = MainFrame

-- Contenedores
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(0, 120, 0, 260)
TabContainer.Position = UDim2.new(0, 10, 0, 65)
TabContainer.BackgroundColor3 = Color3.fromRGB(15, 28, 52)
TabContainer.BorderSizePixel = 0
TabContainer.Parent = MainFrame

local TabCorner = Instance.new("UICorner")
TabCorner.CornerRadius = UDim.new(0, 8)
TabCorner.Parent = TabContainer

local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(0, 370, 0, 260)
ContentContainer.Position = UDim2.new(0, 140, 0, 65)
ContentContainer.BackgroundColor3 = Color3.fromRGB(15, 28, 52)
ContentContainer.BorderSizePixel = 0
ContentContainer.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 8)
ContentCorner.Parent = ContentContainer

-- Pestañas
local InfoTab = Instance.new("ScrollingFrame")
InfoTab.Size = UDim2.new(1, -20, 1, -20)
InfoTab.Position = UDim2.new(0, 10, 0, 10)
InfoTab.BackgroundTransparency = 1
InfoTab.BorderSizePixel = 0
InfoTab.ScrollBarThickness = 4
InfoTab.Visible = true
InfoTab.Parent = ContentContainer

local MainTab = Instance.new("ScrollingFrame")
MainTab.Size = UDim2.new(1, -20, 1, -20)
MainTab.Position = UDim2.new(0, 10, 0, 10)
MainTab.BackgroundTransparency = 1
MainTab.BorderSizePixel = 0
MainTab.ScrollBarThickness = 4
MainTab.Visible = false
MainTab.Parent = ContentContainer

-- ========================================================
-- CONTENIDO: PESTAÑA 1 (INFO)
-- ========================================================
local function AddInfoLabel(texto, posY, color, bold)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 22)
    lbl.Position = UDim2.new(0, 0, 0, posY)
    lbl.BackgroundTransparency = 1
    lbl.Text = texto
    lbl.TextColor3 = color or Color3.fromRGB(220, 235, 255)
    lbl.TextSize = 13
    lbl.Font = bold and Enum.Font.SourceSansBold or Enum.Font.SourceSans
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = InfoTab
end

AddInfoLabel("Nombre del Creador: JoseAngel_Blox", 0, Color3.fromRGB(0, 162, 255), true)
AddInfoLabel("Fecha de lanzamiento: 02/09/2026", 25)
AddInfoLabel("Versión: 1.1", 50)
AddInfoLabel("UPDATE:", 80, Color3.fromRGB(0, 162, 255), true)

local updateText = Instance.new("TextLabel")
updateText.Size = UDim2.new(1, 0, 0, 100)
updateText.Position = UDim2.new(0, 0, 0, 105)
updateText.BackgroundTransparency = 1
updateText.Text = "Bienvenidos a mi nuevo script de 99 noches en el bosque este script es uno de los básicos para aprender a usar un script espero y te guste el script atentamente JoseAngel_Blox.."
updateText.TextColor3 = Color3.fromRGB(200, 220, 245)
updateText.TextSize = 13
updateText.Font = Enum.Font.SourceSans
updateText.TextWrapped = true
updateText.TextXAlignment = Enum.TextXAlignment.Left
updateText.TextYAlignment = Enum.TextYAlignment.Top
updateText.Parent = InfoTab

InfoTab.CanvasSize = UDim2.new(0, 0, 0, 220)

-- ========================================================
-- CONTENIDO: PESTAÑA 2 (MAIN)
-- ========================================================
local function CrearOpcionMain(titulo, descripcion, posY, callback)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, -5, 0, 55)
    card.Position = UDim2.new(0, 0, 0, posY)
    card.BackgroundColor3 = Color3.fromRGB(22, 40, 70)
    card.BorderSizePixel = 0
    card.Parent = MainTab

    local cardCorner = Instance.new("UICorner")
    cardCorner.CornerRadius = UDim.new(0, 6)
    cardCorner.Parent = card

    local tLbl = Instance.new("TextLabel")
    tLbl.Size = UDim2.new(0.7, 0, 0, 20)
    tLbl.Position = UDim2.new(0, 8, 0, 5)
    tLbl.BackgroundTransparency = 1
    tLbl.Text = titulo
    tLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    tLbl.TextSize = 13
    tLbl.Font = Enum.Font.SourceSansBold
    tLbl.TextXAlignment = Enum.TextXAlignment.Left
    tLbl.Parent = card

    local dLbl = Instance.new("TextLabel")
    dLbl.Size = UDim2.new(0.7, 0, 0, 25)
    dLbl.Position = UDim2.new(0, 8, 0, 24)
    dLbl.BackgroundTransparency = 1
    dLbl.Text = descripcion
    dLbl.TextColor3 = Color3.fromRGB(170, 190, 220)
    dLbl.TextSize = 11
    dLbl.Font = Enum.Font.SourceSans
    dLbl.TextWrapped = true
    dLbl.TextXAlignment = Enum.TextXAlignment.Left
    dLbl.Parent = card

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.24, 0, 0, 32)
    btn.Position = UDim2.new(0.73, 0, 0.2, 0)
    btn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    btn.Text = "OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 12
    btn.Parent = card

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 5)
    btnCorner.Parent = btn

    local estado = false
    btn.MouseButton1Click:Connect(function()
        estado = not estado
        btn.Text = estado and "ON" or "OFF"
        btn.BackgroundColor3 = estado and Color3.fromRGB(40, 167, 69) or Color3.fromRGB(0, 120, 215)
        callback(estado)
    end)
end

-- Variables de Estado
local killAuraOn = false
local autoFeedOn = false
local autoCollectOn = false
local godmodeOn = false

CrearOpcionMain("Kill Aura", "Ataca automáticamente a cualquier monstruo que se acerque.", 0, function(val)
    killAuraOn = val
end)

CrearOpcionMain("Auto-Alimentar Fogata", "Deposita madera automáticamente en la fogata.", 62, function(val)
    autoFeedOn = val
end)

CrearOpcionMain("Auto-Recolectar", "Recoge madera y recursos cercanos automáticamente.", 124, function(val)
    autoCollectOn = val
end)

CrearOpcionMain("Godmode", "Aumenta la velocidad y curación del jugador.", 186, function(val)
    godmodeOn = val
    if not val and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

MainTab.CanvasSize = UDim2.new(0, 0, 0, 250)

-- Botones de Navegación
local function CrearBotonTab(nombre, posY, tabTarget)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(22, 40, 70)
    btn.Text = nombre
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 13
    btn.Parent = TabContainer

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        InfoTab.Visible = false
        MainTab.Visible = false
        tabTarget.Visible = true
    end)
end

CrearBotonTab("1) info", 10, InfoTab)
CrearBotonTab("2) Main", 52, MainTab)

-- ========================================================
-- 3. BURBUJA FLOTANTE "JB"
-- ========================================================
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 15, 0.4, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(10, 20, 38)
ToggleBtn.Text = "JB"
ToggleBtn.TextColor3 = Color3.fromRGB(0, 162, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 16
ToggleBtn.Visible = false
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(0, 162, 255)
ToggleStroke.Thickness = 2
ToggleStroke.Parent = ToggleBtn

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- ========================================================
-- 4. BUCLE PRINCIPAL DE FUNCIONES DEL JUEGO
-- ========================================================
task.spawn(function()
    while task.wait(0.2) do
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then

                -- 1. Kill Aura (Equipa arma y ataca enemigos en rango)
                if killAuraOn then
                    for _, mob in pairs(workspace:GetChildren()) do
                        if mob:IsA("Model") and mob ~= char and mob:FindFirstChildOfClass("Humanoid") then
                            local mobRoot = mob:FindFirstChild("HumanoidRootPart") or mob.PrimaryPart
                            if mobRoot and (mobRoot.Position - char.HumanoidRootPart.Position).Magnitude <= 22 then
                                local tool = char:FindFirstChildOfClass("Tool") or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                                if tool then
                                    tool.Parent = char
                                    tool:Activate()
                                end
                            end
                        end
                    end
                end

                -- 2. Auto-Recolectar y Auto-Alimentar Fogata (ProximityPrompts)
                if autoCollectOn or autoFeedOn then
                    for _, prompt in pairs(workspace:GetDescendants()) do
                        if prompt:IsA("ProximityPrompt") then
                            local parentPart = prompt.Parent
                            if parentPart and parentPart:IsA("BasePart") then
                                local dist = (parentPart.Position - char.HumanoidRootPart.Position).Magnitude
                                if dist <= prompt.MaxActivationDistance then
                                    if fireproximityprompt then
                                        fireproximityprompt(prompt)
                                    end
                                end
                            end
                        end
                    end
                end

                -- 3. Godmode / Súper Resistencia y Velocidad
                if godmodeOn and char:FindFirstChild("Humanoid") then
                    char.Humanoid.WalkSpeed = 45
                    char.Humanoid.Health = char.Humanoid.MaxHealth
                end

            end
        end)
    end
end)

-- ========================================================
-- 5. ANIMACIÓN DE CARGA (0% A 100%)
-- ========================================================
task.spawn(function()
    for i = 1, 100 do
        PercentText.Text = "Cargando... " .. i .. "%"
        BarFill.Size = UDim2.new(i / 100, 0, 1, 0)
        task.wait(0.02)
    end

    LoadingFrame:Destroy()
    MainFrame.Visible = true
    ToggleBtn.Visible = true
end)
