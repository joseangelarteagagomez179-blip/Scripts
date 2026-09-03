-- ==============================================
-- JoseAngel_Blox 99Nights | Script v1.1
-- Creado por: JoseAngel_Blox
-- Fecha: 02/09/2026
-- ==============================================
-- ⚠️ Solo para uso personal y educativo. Úsalo bajo tu responsabilidad.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- === CREAR INTERFAZ ===
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox_99Nights"
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Ventana principal — AZUL MARINO, ESQUINAS REDONDEADAS
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 580, 0, 420)
MainFrame.Position = UDim2.new(0.5, -290, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 32, 96) -- 🔵 AZUL MARINO
MainFrame.BorderSizePixel = 0
MainFrame.CornerRadius = UDim.new(0, 16) -- 🟦 ESQUINAS REDONDEADAS
MainFrame.Parent = ScreenGui

-- Título principal — LETRAS AZULES
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, 0, 0, 50)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "JoseAngel_Blox 99Nights"
TitleLabel.TextColor3 = Color3.fromRGB(80, 180, 255) -- 🔵 AZUL
TitleLabel.Font = Enum.Font.GothamBlack
TitleLabel.TextSize = 28
TitleLabel.Parent = MainFrame

-- Subtítulo — TRANSPARENTE
local SubTitle = Instance.new("TextLabel")
SubTitle.Name = "SubTitle"
SubTitle.Size = UDim2.new(1, 0, 0, 25)
SubTitle.Position = UDim2.new(0, 0, 0, 45)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Creado por JoseAngel_Blox"
SubTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SubTitle.TextTransparency = 0.5 -- ✅ TRANSPARENTE
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 14
SubTitle.Parent = MainFrame

-- Pestañas LADO IZQUIERDO
local TabFrame = Instance.new("Frame")
TabFrame.Name = "TabFrame"
TabFrame.Size = UDim2.new(0, 130, 1, -80)
TabFrame.Position = UDim2.new(0, 10, 0, 70)
TabFrame.BackgroundTransparency = 1
TabFrame.Parent = MainFrame

-- Contenido LADO DERECHO
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -160, 1, -80)
ContentFrame.Position = UDim2.new(0, 150, 0, 70)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- === ESTADO DEL SCRIPT ===
local state = {
    activeTab = "Info",
    toggles = {
        KillAura = false,
        Godmode = false,
        BringFuel = false,
        BringMetal = false,
        BringFood = false,
        BringItems = false,
        BringAmour = false
    },
    selected = {
        Fuel = nil,
        Metal = nil,
        Food = nil,
        Items = nil,
        Amour = nil
    }
}

-- === ITEMS LISTAS ===
local Items = {
    Fuel = {"Coal", "Log", "Fuel Canister", "Oil Barrer", "Biofuel"},
    Metal = {"Bolt", "Broken Fan", "Broken Microwave", "Cultist Gem", "Gem of the Forest Fragment", "Metal Chair", "Old Car Engine", "Old Radio", "Sheet Metal"},
    Food = {"Berry", "Cake", "Carrot", "Chilli", "Cooked Morsel", "Cooked Steak", "Corn", "Meat? Sandwich", "Morsel", "Pumpkin", "Steak", "Stew"},
    Items = {"Bandage", "Good Sack", "Giant Sack", "Infernal Sack", "Good Axe", "Strong Axe", "Strong Flashlight"},
    Amour = {"Revolver", "Rifle", "Revolver Ammo", "Rifle Ammo", "Crossbow", "Infernal Crossbow"}
}

-- === FUNCIONES PARA CREAR PESTAÑAS ===
local function createTab(name, posY)
    local btn = Instance.new("TextButton")
    btn.Name = name.."Tab"
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Position = UDim2.new(0, 0, 0, posY)
    btn.BackgroundColor3 = name == "Info" and Color3.fromRGB(40, 80, 160) or Color3.fromRGB(20, 50, 120)
    btn.CornerRadius = UDim.new(0, 8)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 15
    btn.Parent = TabFrame
    
    btn.MouseButton1Click:Connect(function()
        state.activeTab = name
        for _, b in ipairs(TabFrame:GetChildren()) do
            if b:IsA("TextButton") then
                b.BackgroundColor3 = Color3.fromRGB(20, 50, 120)
            end
        end
        btn.BackgroundColor3 = Color3.fromRGB(40, 80, 160)
        loadContent(name)
    end)
    return btn
end

-- === CARGAR CONTENIDO DE PESTAÑAS ===
function loadContent(tabName)
    for _, child in ipairs(ContentFrame:GetChildren()) do
        child:Destroy()
    end

    if tabName == "Info" then
        local InfoBox = Instance.new("TextLabel")
        InfoBox.Size = UDim2.new(1, 0, 1, 0)
        InfoBox.BackgroundTransparency = 1
        InfoBox.Text = [[📌 Nombre del creador: JoseAngel_Blox
📅 Fecha de lanzamiento: 02/09/2026
🔢 Versión: 1.1

🔄 UPDATE:
¡Bienvenidos y bienvenidas a mi script 
básico para las nuevas personas usando 
Delta Executor! Este es un script básico 
para 99 Noches en el Bosque, donde 
aprenderás paso a paso a usar un script 
para este juego. Espero y te guste el 
script. Saludos atentamente: JoseAngel_Blox 😉]]
        InfoBox.TextColor3 = Color3.fromRGB(230, 230, 255)
        InfoBox.Font = Enum.Font.Gotham
        InfoBox.TextSize = 14
        InfoBox.TextWrapped = true
        InfoBox.TextXAlignment = Enum.TextXAlignment.Left
        InfoBox.TextYAlignment = Enum.TextYAlignment.Top
        InfoBox.Parent = ContentFrame

    elseif tabName == "Main" then
        local yOffset = 0
        local function addToggle(name, key)
            local container = Instance.new("Frame")
            container.Size = UDim2.new(1, 0, 0, 32)
            container.Position = UDim2.new(0, 0, 0, yOffset)
            container.BackgroundTransparency = 1
            container.Parent = ContentFrame

            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(0.75, 0, 1, 0)
            lbl.BackgroundTransparency = 1
            lbl.Text = name
            lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
            lbl.Font = Enum.Font.Gotham
            lbl.TextSize = 14
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.Parent = container

            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0, 70, 0, 26)
            btn.Position = UDim2.new(0.78, 0, 0.5, -13)
            btn.BackgroundColor3 = state.toggles[key] and Color3.fromRGB(0, 200, 80) or Color3.fromRGB(180, 40, 40)
            btn.CornerRadius = UDim.new(0, 6)
            btn.Text = state.toggles[key] and "ON" or "OFF"
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 12
            btn.Parent = container

            btn.MouseButton1Click:Connect(function()
                state.toggles[key] = not state.toggles[key]
                btn.BackgroundColor3 = state.toggles[key] and Color3.fromRGB(0, 200, 80) or Color3.fromRGB(180, 40, 40)
                btn.Text = state.toggles[key] and "ON" or "OFF"
            end)

            yOffset = yOffset + 35
        end

        local function addSection(title, list, stateKey, toggleKey)
            local header = Instance.new("TextLabel")
            header.Size = UDim2.new(1, 0, 0, 28)
            header.Position = UDim2.new(0, 0, 0, yOffset)
            header.BackgroundTransparency = 1
            header.Text = title
            header.TextColor3 = Color3.fromRGB(255, 210, 0)
            header.Font = Enum.Font.GothamBold
            header.TextSize = 15
            header.TextXAlignment = Enum.TextXAlignment.Left
            header.Parent = ContentFrame
            yOffset = yOffset + 28

            local selected = Instance.new("TextButton")
            selected.Size = UDim2.new(1, 0, 0, 30)
            selected.Position = UDim2.new(0, 0, 0, yOffset)
            selected.BackgroundColor3 = Color3.fromRGB(30, 60, 140)
            selected.CornerRadius = UDim.new(0, 6)
            selected.Text = "Select " .. stateKey .. " ↓"
            selected.TextColor3 = Color3.fromRGB(200, 220, 255)
            selected.Font = Enum.Font.Gotham
            selected.TextSize = 13
            selected.Parent = ContentFrame
            yOffset = yOffset + 35

            local dropdown = Instance.new("Frame")
            dropdown.Size = UDim2.new(1, 0, 0, #list * 28)
            dropdown.Position = UDim2.new(0, 0, 0, yOffset)
            dropdown.BackgroundColor3 = Color3.fromRGB(25, 45, 90)
            dropdown.CornerRadius = UDim.new(0, 6)
            dropdown.Visible = false
            dropdown.Parent = ContentFrame

            for i, item in ipairs(list) do
                local itemBtn = Instance.new("TextButton")
                itemBtn.Size = UDim2.new(1, -10, 0, 24)
                itemBtn.Position = UDim2.new(0, 5, 0, (i - 1) * 26)
                itemBtn.BackgroundTransparency = 1
                itemBtn.Text = item
                itemBtn.TextColor3 = Color3.fromRGB(230, 230, 255)
                itemBtn.Font = Enum.Font.Gotham
                itemBtn.TextSize = 12
                itemBtn.TextXAlignment = Enum.TextXAlignment.Left
                itemBtn.Parent = dropdown

                itemBtn.MouseButton1Click:Connect(function()
                    state.selected[stateKey] = item
                    selected.Text = item .. " ↓"
                    dropdown.Visible = false
                end)
            end

            selected.MouseButton1Click:Connect(function()
                dropdown.Visible = not dropdown.Visible
            end)

            yOffset = yOffset + #list * 28 + 5
            addToggle("Bring " .. stateKey, toggleKey)
        end

        -- === FUNCIONES MAIN ===
        addToggle("💀 Kill Aura → Matar automáticamente", "KillAura")
        addToggle("🛡️ Godmode → Modo dios inmortal", "Godmode")
        yOffset = yOffset + 10

        addSection("🔥 Fuel", Items.Fuel, "Fuel", "BringFuel")
        addSection("⚙️ Metal", Items.Metal, "Metal", "BringMetal")
        addSection("🍕 Food", Items.Food, "Food", "BringFood")
        addSection("📦 Items", Items.Items, "Items", "BringItems")
        addSection("🗡️ Amour", Items.Amour, "Amour", "BringAmour")
    end
end

-- === CREAR PESTAÑAS ===
createTab("Info", 10)
createTab("Main", 55)

-- === CARGAR INFO POR DEFECTO ===
task.wait(0.1)
loadContent("Info")

-- === HACER VENTANA MOVIBLE ===
local dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragStart = UserInputService:GetMouseLocation()
        startPos = MainFrame.Position
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if dragStart and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = UserInputService:GetMouseLocation() - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragStart = nil
    end
end)

-- === CONFIRMACIÓN ===
print("[✅] JoseAngel_Blox 99Nights v1.1 | Cargado correctamente")
game:GetService("StarterGui"):SetCore("Notification", {
    Title = "JoseAngel_Blox 99Nights",
    Text = "Script v1.1 activado ✅",
    Duration = 3
})
