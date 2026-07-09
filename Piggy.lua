-- ==========================================================
-- 👑 JOSEANGEL_BLOX PIGGY PRO 👑
-- Versión: 1.2 | Fecha: 09/06/2026
-- ==========================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Evitar duplicados si ejecutas el script dos veces
if CoreGui:FindFirstChild("JoseAngel_Piggy_UI") then
    CoreGui.JoseAngel_Piggy_UI:Destroy()
end

-- ==================== CREACIÓN DE LA INTERFAZ ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Piggy_UI"
ScreenGui.Parent = CoreGui

-- Fondo Principal (Cuadrado ancho con bordes redondeados)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 550, 0, 420) -- Un poquito ancho y cuadrado
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25) -- Gris muy oscuro
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Permite mover el menú por la pantalla
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12) -- Esquinas redondeadas
MainCorner.Parent = MainFrame

-- Título Superior
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

-- Corrección del borde inferior del título para que se fusione con el fondo
local TitleFix = Instance.new("Frame")
TitleFix.Size = UDim2.new(1, 0, 0, 10)
TitleFix.Position = UDim2.new(0, 0, 1, -10)
TitleFix.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TitleFix.BorderSizePixel = 0
TitleFix.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, 0, 1, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = " 👑 JoseAngel_Blox Piggy PRO"
TitleText.TextColor3 = Color3.fromRGB(170, 85, 255) -- Púrpura Neón bonito
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 20
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- Contenedor de Botones Laterales (Pestañas)
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(0, 140, 1, -50)
TabContainer.Position = UDim2.new(0, 10, 0, 50)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

-- Contenedor de Contenido (Donde van las opciones)
local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -170, 1, -60)
ContentContainer.Position = UDim2.new(0, 160, 0, 50)
ContentContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
ContentContainer.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 8)
ContentCorner.Parent = ContentContainer

-- ==================== FUNCIONES DE CREACIÓN DE UI ====================
local tabs = {}
local function CreateTab(name, color)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, 0, 0, 35)
    TabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    TabBtn.Text = name .. " ↓↑"
    TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.TextSize = 14
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = TabBtn
    
    local TabPage = Instance.new("ScrollingFrame")
    TabPage.Size = UDim2.new(1, -10, 1, -10)
    TabPage.Position = UDim2.new(0, 5, 0, 5)
    TabPage.BackgroundTransparency = 1
    TabPage.ScrollBarThickness = 4
    TabPage.Visible = false
    TabPage.Parent = ContentContainer
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 8)
    UIListLayout.Parent = TabPage

    TabBtn.MouseButton1Click:Connect(function()
        for _, page in pairs(tabs) do page.Visible = false end
        TabPage.Visible = true
    end)

    return TabBtn, TabPage
end

local function CreateToggle(parent, text, callback)
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(1, -10, 0, 35)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    ToggleBtn.Text = "  " .. text
    ToggleBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    ToggleBtn.Font = Enum.Font.Gotham
    ToggleBtn.TextSize = 14
    ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
    ToggleBtn.Parent = parent

    local TCorner = Instance.new("UICorner")
    TCorner.CornerRadius = UDim.new(0, 6)
    TCorner.Parent = ToggleBtn

    local Status = Instance.new("Frame")
    Status.Size = UDim2.new(0, 10, 0, 10)
    Status.Position = UDim2.new(1, -20, 0.5, -5)
    Status.BackgroundColor3 = Color3.fromRGB(255, 50, 50) -- Rojo (Apagado)
    Status.Parent = ToggleBtn

    local SCorner = Instance.new("UICorner")
    SCorner.CornerRadius = UDim.new(1, 0)
    SCorner.Parent = Status

    local toggled = false
    ToggleBtn.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            Status.BackgroundColor3 = Color3.fromRGB(50, 255, 100) -- Verde (Encendido)
            ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            Status.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            ToggleBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        callback(toggled)
    end)
end

local function CreateLabel(parent, text, color)
    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(1, 0, 0, 30)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = text
    Lbl.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    Lbl.Font = Enum.Font.GothamBold
    Lbl.TextSize = 16
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.Parent = parent
end

-- ==================== ESTRUCTURA DE PESTAÑAS ====================
local UIListTab = Instance.new("UIListLayout")
UIListTab.Padding = UDim.new(0, 10)
UIListTab.Parent = TabContainer

local BtnInfo, PageInfo = CreateTab("1) Info", Color3.fromRGB(0, 170, 255))
local BtnMain, PageMain = CreateTab("2) Main", Color3.fromRGB(170, 85, 255))
local BtnPiggy, PagePiggy = CreateTab("3) Piggy", Color3.fromRGB(255, 85, 85))

BtnInfo.Parent = TabContainer
BtnMain.Parent = TabContainer
BtnPiggy.Parent = TabContainer
table.insert(tabs, PageInfo)
table.insert(tabs, PageMain)
table.insert(tabs, PagePiggy)
PageInfo.Visible = true -- Pestaña por defecto

-- ==================== 1) INFO ↓↑ ====================
CreateLabel(PageInfo, " Datos del Script:", Color3.fromRGB(170, 85, 255))
CreateLabel(PageInfo, " Nombre del Creador: JoseAngel_Blox")
CreateLabel(PageInfo, " Fecha de actualización: 09/06/2026")
CreateLabel(PageInfo, " Versión: 1.2")
CreateLabel(PageInfo, "\n ¡Disfruta de Piggy PRO!", Color3.fromRGB(0, 255, 255))

-- ==================== 2) MAIN ↓↑ ====================
CreateToggle(PageMain, "Esp (Jugadores, Bots y Piggy)", function(state)
    -- Lógica de ESP
    if state then
        _G.ESP = RunService.RenderStepped:Connect(function()
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("Humanoid") and v ~= LocalPlayer.Character then
                    if not v:FindFirstChild("Highlight_ESP") then
                        local h = Instance.new("Highlight")
                        h.Name = "Highlight_ESP"
                        h.FillColor = Color3.fromRGB(0, 255, 255)
                        h.Parent = v
                    end
                end
            end
        end)
    else
        if _G.ESP then _G.ESP:Disconnect() end
        for _, v in pairs(workspace:GetDescendants()) do
            if v:FindFirstChild("Highlight_ESP") then v.Highlight_ESP:Destroy() end
        end
    end
end)

CreateToggle(PageMain, "Esp Items (Ver todos los ítems)", function(state)
    -- ESP para ítems
end)

CreateToggle(PageMain, "Auto Grab Items", function(state)
    -- Recoger ítems cercanos
end)

CreateToggle(PageMain, "Noclip (Atravesar Paredes)", function(state)
    if state then
        _G.Noclip = RunService.Stepped:Connect(function()
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end)
    else
        if _G.Noclip then _G.Noclip:Disconnect() end
    end
end)

CreateToggle(PageMain, "Auto Unlock Doors", function(state)
    -- Desbloquear puertas con llave en mano
end)

CreateToggle(PageMain, "God Mode (Invencible)", function(state)
    -- God Mode (Borrar partes de colisión con los bots)
end)

CreateToggle(PageMain, "Infinite Stamina", function(state)
    -- Reseteo constante de la estamina a 100
end)

CreateToggle(PageMain, "Kill Aura (Sobreviviente)", function(state)
    -- Matar Bots/Piggy con arma automáticamente
end)

-- ==================== 3) FUNCIONES DE PIGGY ↓↑ ====================
CreateLabel(PagePiggy, " Opciones exclusivas siendo Piggy", Color3.fromRGB(255, 85, 85))

CreateToggle(PagePiggy, "Esp (Jugadores)", function(state)
    -- Mismo ESP pero enfocado solo en sobrevivientes
end)

CreateToggle(PagePiggy, "Kill Aura Players", function(state)
    -- Matar jugadores cercanos siendo Piggy
end)

CreateToggle(PagePiggy, "Hit Box (Expandir para matar)", function(state)
    if state then
        _G.Hitbox = RunService.RenderStepped:Connect(function()
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.Size = Vector3.new(15, 15, 15)
                    player.Character.HumanoidRootPart.Transparency = 0.5
                end
            end
        end)
    else
        if _G.Hitbox then _G.Hitbox:Disconnect() end
    end
end)

CreateToggle(PagePiggy, "Speed + Jump (Correr y Saltar 🦘)", function(state)
    if state then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 50
            LocalPlayer.Character.Humanoid.UseJumpPower = true
            LocalPlayer.Character.Humanoid.JumpPower = 100
        end
    else
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
            LocalPlayer.Character.Humanoid.JumpPower = 50
        end
    end
end)

print("¡Script JoseAngel_Blox Piggy PRO cargado correctamente!")
