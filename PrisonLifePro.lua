-- // PRISON LIFE PRO v1.1
-- // Creado por: JoseAngel_Blox
-- // Fecha: 26/08/2026
-- // Optimizado para Delta Executor

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- ==========================================
-- CONFIGURACIÓN DE LA UI (LIBRERÍA LIGERA)
-- ==========================================
-- Nota: En Delta puedes reemplazar esto por Orion/Owl si prefieres.
-- Esta UI está hecha desde cero para cumplir con tu diseño exacto.

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PrisonLifePro_UI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Marco Principal (Ancho, Azul Marino/Negro, Esquinas Redondeadas)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 750, 0, 450)
MainFrame.Position = UDim2.new(0.5, -375, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 15, 30) -- Azul Marino casi negro
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Título y Créditos
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.Position = UDim2.new(0, 0, 0, 10)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Prison Life Pro"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 22
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Parent = MainFrame

local CreatorLabel = Instance.new("TextLabel")
CreatorLabel.Size = UDim2.new(1, 0, 0, 20)
CreatorLabel.Position = UDim2.new(0, 0, 0, 38)
CreatorLabel.BackgroundTransparency = 1
CreatorLabel.Text = "Creado por JoseAngel_Blox"
CreatorLabel.TextColor3 = Color3.fromRGB(150, 180, 255)
CreatorLabel.TextSize = 14
CreatorLabel.Font = Enum.Font.GothamMedium
CreatorLabel.Parent = MainFrame

-- Contenedor de Pestañas (DERECHA)
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(0, 140, 1, -70)
TabContainer.Position = UDim2.new(1, -145, 0, 65)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

local TabLayout = Instance.new("UIListLayout")
TabLayout.Padding = UDim.new(0, 5)
TabLayout.Parent = TabContainer

-- Contenedor de Funciones (IZQUIERDA)
local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -160, 1, -70)
ContentContainer.Position = UDim2.new(0, 10, 0, 65)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

-- ==========================================
-- SISTEMA DE PESTAÑAS Y FUNCIONES
-- ==========================================
local Tabs = {}
local CurrentTab = nil

local function CreateTab(name, contentData)
    -- Botón de Pestaña
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, 0, 0, 35)
    TabBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabBtn.TextSize = 14
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.Parent = TabContainer
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = TabBtn
    
    -- Frame de Contenido
    local ContentFrame = Instance.new("ScrollingFrame")
    ContentFrame.Size = UDim2.new(1, 0, 1, 0)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.ScrollBarThickness = 4
    ContentFrame.Visible = false
    ContentFrame.Parent = ContentContainer
    
    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Padding = UDim.new(0, 8)
    ListLayout.Parent = ContentFrame
    
    -- Generar contenido según tipo
    if type(contentData) == "string" then
        -- Pestaña INFO
        local InfoText = Instance.new("TextLabel")
        InfoText.Size = UDim2.new(1, -10, 0, 200)
        InfoText.BackgroundTransparency = 1
        InfoText.TextWrapped = true
        InfoText.TextXAlignment = Enum.TextXAlignment.Left
        InfoText.TextYAlignment = Enum.TextYAlignment.Top
        InfoText.Text = contentData
        InfoText.TextColor3 = Color3.fromRGB(220, 220, 220)
        InfoText.TextSize = 14
        InfoText.Font = Enum.Font.Gotham
        InfoText.RichText = true
        InfoText.Parent = ContentFrame
    elseif type(contentData) == "table" then
        -- Pestañas con TOGGLES
        for _, func in ipairs(contentData) do
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Size = UDim2.new(1, -5, 0, 40)
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
            ToggleFrame.Parent = ContentFrame
            
            local TCorner = Instance.new("UICorner")
            TCorner.CornerRadius = UDim.new(0, 6)
            TCorner.Parent = ToggleFrame
            
            local TLabel = Instance.new("TextLabel")
            TLabel.Size = UDim2.new(1, -60, 1, 0)
            TLabel.Position = UDim2.new(0, 10, 0, 0)
            TLabel.BackgroundTransparency = 1
            TLabel.Text = func.name
            TLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
            TLabel.TextSize = 13
            TLabel.Font = Enum.Font.GothamMedium
            TLabel.TextXAlignment = Enum.TextXAlignment.Left
            TLabel.Parent = ToggleFrame
            
            local DescLabel = Instance.new("TextLabel")
            DescLabel.Size = UDim2.new(1, -60, 0, 15)
            DescLabel.Position = UDim2.new(0, 10, 1, -18)
            DescLabel.BackgroundTransparency = 1
            DescLabel.Text = func.desc
            DescLabel.TextColor3 = Color3.fromRGB(120, 140, 180)
            DescLabel.TextSize = 10
            DescLabel.Font = Enum.Font.Gotham
            DescLabel.TextXAlignment = Enum.TextXAlignment.Left
            DescLabel.Parent = ToggleFrame
            
            -- Botón Toggle
            local ToggleBtn = Instance.new("TextButton")
            ToggleBtn.Size = UDim2.new(0, 45, 0, 22)
            ToggleBtn.Position = UDim2.new(1, -52, 0.5, -11)
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            ToggleBtn.Text = "OFF"
            ToggleBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
            ToggleBtn.TextSize = 11
            ToggleBtn.Font = Enum.Font.GothamBold
            ToggleBtn.Parent = ToggleFrame
            
            local TBtnCorner = Instance.new("UICorner")
            TBtnCorner.CornerRadius = UDim.new(0, 6)
            TBtnCorner.Parent = ToggleBtn
            
            local enabled = false
            ToggleBtn.MouseButton1Click:Connect(function()
                enabled = not enabled
                ToggleBtn.Text = enabled and "ON" or "OFF"
                ToggleBtn.BackgroundColor3 = enabled and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(40, 40, 40)
                ToggleBtn.TextColor3 = enabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
                
                if func.callback then
                    func.callback(enabled)
                end
            end)
        end
    end
    
    Tabs[name] = {btn = TabBtn, content = ContentFrame}
    
    TabBtn.MouseButton1Click:Connect(function()
        if CurrentTab then
            CurrentTab.content.Visible = false
            CurrentTab.btn.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
            CurrentTab.btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        ContentFrame.Visible = true
        TabBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 220)
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        CurrentTab = Tabs[name]
    end)
end

-- ==========================================
-- DEFINICIÓN DE PESTAÑAS
-- ==========================================

-- 1) INFO
CreateTab("Info", [[<b>Nombre del creador:</b> JoseAngel_Blox
<b>Fecha de lanzamiento:</b> 26/08/2026
<b>Versión:</b> 1.1

<b>Update:</b> Bienvenidos y bienvenidas a mi script. Este script es uno de los mejores scripts sin key. Espero y lo disfrutes.

Atentamente, <b>JoseAngel_Blox</b>]])

-- 2) MAIN (Guardias)
CreateTab("Main", {
    {name = "Auto-Arrest", desc = "Arresta criminales cercanos automáticamente.", callback = function(on) print("Auto-Arrest:", on) end},
    {name = "Auto-Tase / Stun", desc = "Tasea criminales antes de arrestarlos.", callback = function(on) print("Auto-Tase:", on) end},
    {name = "Guard ESP", desc = "Ver jugadores a través de paredes (Verde/Rojo).", callback = function(on) print("Guard ESP:", on) end},
    {name = "Anti-Escape", desc = "Teletransporta prisioneros fugitivos a celdas.", callback = function(on) print("Anti-Escape:", on) end},
    {name = "Auto-Claim Bounty", desc = "Reclama recompensas automáticamente.", callback = function(on) print("Auto-Claim:", on) end},
    {name = "Weapon Locker Grab", desc = "Toma armas del armero al acercarse.", callback = function(on) print("Locker Grab:", on) end},
})

-- 3) ROL DE PRISIONERO
CreateTab("Prisionero", {
    {name = "Auto-Escape Route", desc = "Teletransporte por rutas seguras de escape.", callback = function(on) print("Escape Route:", on) end},
    {name = "Silent Aim / Aimbot", desc = "Apunta automáticamente a guardias. FOV ajustable.", callback = function(on) print("Silent Aim:", on) end},
    {name = "NoClip / WalkThrough", desc = "Atraviesa paredes, rejas y puertas.", callback = function(on) print("NoClip:", on) end},
    {name = "Auto-Loot Weapons", desc = "Recoge armas del suelo automáticamente.", callback = function(on) print("Auto-Loot:", on) end},
    {name = "Speed Boost / Fly", desc = "Velocidad aumentada o vuelo para escapar.", callback = function(on) print("Speed/Fly:", on) end},
})

-- Seleccionar primera pestaña por defecto
Tabs["Info"].btn:Invoke()

print("[Prison Life Pro v1.1] Cargado correctamente | Creado por JoseAngel_Blox")
