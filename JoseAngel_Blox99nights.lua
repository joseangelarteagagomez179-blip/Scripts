-- ==============================================
-- Script: 99 noches en el bosque
-- Creado por: JoseAngel_Blox
-- Versión: 1.2 — ARREGLADO Y FUNCIONAL
-- ==============================================

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Header = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Subtitle = Instance.new("TextLabel")
local SideBar = Instance.new("Frame")
local ContentArea = Instance.new("Frame")
local UIListLayout_SideBar = Instance.new("UIListLayout")

-- SERVICIOS
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Player = Players.LocalPlayer
local Character, RootPart

-- ACTUALIZAR PERSONAJE
local function updateChar()
    Character = Player.Character
    if Character then RootPart = Character:FindFirstChild("HumanoidRootPart") end
end
updateChar()
Player.CharacterAdded:Connect(updateChar)

-- ESTADO DE LOS TOGGLES
local Estado = {
    TraerTroncos = false,
    TraerCarbon = false,
    DistanciaMax = 150
}

-- ==============================================
-- LÓGICA PRINCIPAL — TRAER OBJETOS
-- ==============================================
local function TraerRecursos()
    if not RootPart then return end
    
    for _, objeto in pairs(Workspace:GetDescendants()) do
        if not objeto:IsA("BasePart") then continue end
        
        local distancia = (RootPart.Position - objeto.Position).Magnitude
        if distancia > Estado.DistanciaMax then continue end
        
        -- 🪵 TRONCOS
        if Estado.TraerTroncos and objeto.Name == "Log" then
            pcall(function()
                objeto.Anchored = false
                objeto.Position = RootPart.Position + Vector3.new(math.random(-2,2), 2, math.random(-2,2))
            end)
        end
        
        -- ⛏️ CARBÓN
        if Estado.TraerCarbon and objeto.Name == "Coal" then
            pcall(function()
                objeto.Anchored = false
                objeto.Position = RootPart.Position + Vector3.new(math.random(-2,2), 2, math.random(-2,2))
            end)
        end
    end
end

-- BUCLE DE RECOLECCIÓN
task.spawn(function()
    while task.wait(0.8) do
        if Estado.TraerTroncos or Estado.TraerCarbon then
            TraerRecursos()
        end
    end
end)

-- ==============================================
-- INTERFAZ — TAL CUAL LA TENÍAS (corregida)
-- ==============================================

-- Configuración Base ScreenGui
ScreenGui.Name = "99NochesEnElBosqueGui"
ScreenGui.Parent = game:GetService("CoreGui") or Player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Frame Principal
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

-- Título y Subtítulo
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 10)
Title.Size = UDim2.new(0, 470, 0, 20)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "99 noches en el bosque"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left

Subtitle.Name = "Subtitle"
Subtitle.Parent = MainFrame
Subtitle.BackgroundTransparency = 1
Subtitle.Position = UDim2.new(0, 15, 0, 30)
Subtitle.Size = UDim2.new(0, 470, 0, 15)
Subtitle.Font = Enum.Font.SourceSans
Subtitle.Text = "Creado por JoseAngel_Blox"
Subtitle.TextColor3 = Color3.fromRGB(255, 255, 255)
Subtitle.TextTransparency = 0.5
Subtitle.TextSize = 14
Subtitle.TextXAlignment = Enum.TextXAlignment.Left

-- Barra Lateral
SideBar.Name = "SideBar"
SideBar.Parent = MainFrame
SideBar.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
SideBar.Position = UDim2.new(0, 10, 0, 55)
SideBar.Size = UDim2.new(0, 120, 0, 280)

local SideBarCorner = Instance.new("UICorner")
SideBarCorner.CornerRadius = UDim.new(0, 8)
SideBarCorner.Parent = SideBar

UIListLayout_SideBar.Parent = SideBar
UIListLayout_SideBar.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_SideBar.Padding = UDim.new(0, 5)

-- Área de Contenido
ContentArea.Name = "ContentArea"
ContentArea.Parent = MainFrame
ContentArea.BackgroundTransparency = 1
ContentArea.Position = UDim2.new(0, 140, 0, 55)
ContentArea.Size = UDim2.new(0, 350, 0, 280)

-- PESTAÑAS
local Tabs = {}
local TabButtons = {}

local function CreateTab(name)
    local Button = Instance.new("TextButton")
    Button.Name = name .. "TabBtn"
    Button.Parent = SideBar
    Button.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    Button.Size = UDim2.new(1, 0, 0, 35)
    Button.Font = Enum.Font.SourceSansBold
    Button.Text = name
    Button.TextColor3 = Color3.fromRGB(200, 200, 200)
    Button.TextSize = 15

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = Button

    local Page = Instance.new("ScrollingFrame")
    Page.Name = name .. "Page"
    Page.Parent = ContentArea
    Page.BackgroundTransparency = 1
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.Visible = false
    Page.ScrollBarThickness = 4

    local PageLayout = Instance.new("UIListLayout")
    PageLayout.Parent = Page
    PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PageLayout.Padding = UDim.new(0, 8)

    Tabs[name] = Page
    TabButtons[name] = Button

    Button.MouseButton1Click:Connect(function()
        for _, p in pairs(Tabs) do p.Visible = false end
        for _, b in pairs(TabButtons) do b.TextColor3 = Color3.fromRGB(200, 200, 200) end
        Page.Visible = true
        Button.TextColor3 = Color3.fromRGB(0, 220, 130)
    end)

    return Page
end

-- CREAR PESTAÑAS
local InfoPage = CreateTab("Info")
local MainPage = CreateTab("Main")
local RecolectorPage = CreateTab("Recolector") -- ✅ NUEVA PESTAÑA
local TpPage = CreateTab("Tp")

-- Mostrar primera pestaña
Tabs["Info"].Visible = true
TabButtons["Info"].TextColor3 = Color3.fromRGB(0, 220, 130)

-- ==============================================
-- PESTAÑA: INFO
-- ==============================================
local function AddInfoLabel(text, size, bold)
    local lbl = Instance.new("TextLabel")
    lbl.Parent = InfoPage
    lbl.BackgroundTransparency = 1
    lbl.Size = UDim2.new(1, -10, 0, size or 20)
    lbl.Font = bold and Enum.Font.SourceSansBold or Enum.Font.SourceSans
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(230, 230, 230)
    lbl.TextSize = 14
    lbl.TextWrapped = true
    lbl.TextXAlignment = Enum.TextXAlignment.Left
end

AddInfoLabel("Nombre del creador: JoseAngel_Blox", 20, true)
AddInfoLabel("Fecha de lanzamiento: 03/09/2026", 20, false)
AddInfoLabel("Versión: 1.2 — Funcional", 20, false)
AddInfoLabel("----------------------------------------", 15, false)
AddInfoLabel("Script para traer Troncos y Carbón automáticamente. Activa los toggles en la pestaña Recolector.", 80, false)

-- ==============================================
-- FUNCIONES AUXILIARES
-- ==============================================
local function CreateSectionHeader(parent, title)
    local lbl = Instance.new("TextLabel")
    lbl.Parent = parent
    lbl.BackgroundTransparency = 1
    lbl.Size = UDim2.new(1, -10, 0, 25)
    lbl.Font = Enum.Font.SourceSansBold
    lbl.Text = title
    lbl.TextColor3 = Color3.fromRGB(255, 180, 50)
    lbl.TextSize = 16
    lbl.TextXAlignment = Enum.TextXAlignment.Left
end

local function CreateToggle(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Font = Enum.Font.SourceSans
    btn.Text = text .. " [OFF]"
    btn.TextColor3 = Color3.fromRGB(255, 100, 100)
    btn.TextSize = 14

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = btn

    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = text .. (state and " [ON]" or " [OFF]")
        btn.TextColor3 = state and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
        task.spawn(callback, state)
    end)
end

local function CreateButton(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.BackgroundColor3 = Color3.fromRGB(50, 60, 80)
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function() task.spawn(callback) end)
end

-- ==============================================
-- ✅ PESTAÑA: RECOLECTOR (¡AQUÍ ESTÁ LO QUE BUSCAS!)
-- ==============================================
CreateSectionHeader(RecolectorPage, "🪵 Recolección de Recursos")
CreateToggle(RecolectorPage, "Traer Troncos (Madera)", function(estado)
    Estado.TraerTroncos = estado
    print("Traer Troncos:", estado and "ACTIVADO ✅" or "DESACTIVADO ❌")
end)
CreateToggle(RecolectorPage, "Traer Carbón", function(estado)
    Estado.TraerCarbon = estado
    print("Traer Carbón:", estado and "ACTIVADO ✅" or "DESACTIVADO ❌")
end)

-- ==============================================
-- PESTAÑA: MAIN
-- ==============================================
CreateSectionHeader(MainPage, "🔥 Fuel")
CreateButton(MainPage, "Select Fuel: Coal, Log, Oil Barrer, Fuel Canister, Biofuel", function()
    print("Selección de combustible")
end)
CreateToggle(MainPage, "Spawn ítem (Fuel)", function(state)
    print("Spawn Fuel Item:", state)
end)

CreateSectionHeader(MainPage, "🥩 Food")
CreateButton(MainPage, "Select Food: Morsel, Steak", function()
    print("Selección de comida")
end)
CreateToggle(MainPage, "Spawn ítem (Food)", function(state)
    print("Spawn Food Item:", state)
end)

CreateSectionHeader(MainPage, "🗡️ Auto")
CreateToggle(MainPage, "Kill aura (Matar a lo lejos)", function(state)
    print("Kill aura:", state)
end)
CreateToggle(MainPage, "Auto Fuel (Llevar combustible a RescueZone)", function(state)
    print("Auto Fuel:", state)
end)
CreateToggle(MainPage, "Godmode (Modo dios)", function(state)
    print("Godmode:", state)
end)

-- ==============================================
-- PESTAÑA: TP
-- ==============================================
CreateSectionHeader(TpPage, "📍 Teleports")

CreateButton(TpPage, "Tp al camp (RescueZone)", function()
    if not Player.Character then return end
    local Root = Player.Character:FindFirstChild("HumanoidRootPart")
    local Zone = Workspace:FindFirstChild("RescueZone")
    if Root and Zone then Root.CFrame = Zone.CFrame end
end)

CreateButton(TpPage, "Tp a stronghold", function()
    if not Player.Character then return end
    local Root = Player.Character:FindFirstChild("HumanoidRootPart")
    local Zone = Workspace:FindFirstChild("stronghold") or Workspace:FindFirstChild("Stronghold")
    if Root and Zone then Root.CFrame = Zone.CFrame end
end)

print("✅ SCRIPT CARGADO — JoseAngel_Blox | Versión 1.2")
