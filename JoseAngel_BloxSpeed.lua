--[[
    ============================================
    JoseAngel_Blox Speed v1.1
    Creado por: JoseAngel_Blox
    Fecha de lanzamiento: 05/08/2026
    ============================================
]]

-- Servicios
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

-- Parent seguro para Delta
local function GetParent()
    if gethui then
        return gethui()
    end
    return game:GetService("CoreGui")
end

-- Variables
local SpeedEnabled = false
local CurrentSpeed = 16

-- ============================================
-- GUI PRINCIPAL
-- ============================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_BloxSpeed"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = GetParent()

-- Ventana cuadrada con esquinas redondeadas
local Main = Instance.new("Frame")
Main.Name = "MainWindow"
Main.Size = UDim2.new(0, 420, 0, 420)
Main.Position = UDim2.new(0.5, -210, 0.5, -210)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(0, 120, 255)
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.4
MainStroke.Parent = Main

-- Título con gradiente azul animado
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "JoseAngel_Blox Speed"
Title.TextSize = 26
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(0, 150, 255)
Title.Parent = Main

local TitleGradient = Instance.new("UIGradient")
TitleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 80, 255)),
    ColorSequenceKeypoint.new(0.25, Color3.fromRGB(100, 180, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 240, 255)),
    ColorSequenceKeypoint.new(0.75, Color3.fromRGB(100, 180, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 80, 255))
})
TitleGradient.Parent = Title

-- Animación del reflejo en movimiento
task.spawn(function()
    local offset = -1
    while ScreenGui.Parent do
        offset = offset + 0.005
        if offset > 1 then offset = -1 end
        TitleGradient.Offset = Vector2.new(offset, 0)
        RunService.RenderStepped:Wait()
    end
end)

-- ============================================
-- ARRASTRAR VENTANA
-- ============================================
local dragging = false
local dragInput, mousePos, framePos

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        mousePos = input.Position
        framePos = Main.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement 
    or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - mousePos
        Main.Position = UDim2.new(
            framePos.X.Scale, framePos.X.Offset + delta.X,
            framePos.Y.Scale, framePos.Y.Offset + delta.Y
        )
    end
end)

-- ============================================
-- PESTAÑAS (izquierda)
-- ============================================
local TabsFrame = Instance.new("Frame")
TabsFrame.Name = "TabsFrame"
TabsFrame.Size = UDim2.new(0, 105, 1, -55)
TabsFrame.Position = UDim2.new(0, 5, 0, 50)
TabsFrame.BackgroundTransparency = 1
TabsFrame.Parent = Main

local TabsLayout = Instance.new("UIListLayout")
TabsLayout.Padding = UDim.new(0, 6)
TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabsLayout.Parent = TabsFrame

-- ============================================
-- CONTENIDO (derecha)
-- ============================================
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -115, 1, -60)
ContentFrame.Position = UDim2.new(0, 110, 0, 55)
ContentFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 42)
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = Main

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 10)
ContentCorner.Parent = ContentFrame

-- Función: crear botón de pestaña
local function CreateTabButton(name, order)
    local Button = Instance.new("TextButton")
    Button.Name = name .. "TabBtn"
    Button.Size = UDim2.new(1, 0, 0, 38)
    Button.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
    Button.Text = name
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 15
    Button.Font = Enum.Font.GothamSemibold
    Button.BorderSizePixel = 0
    Button.LayoutOrder = order
    Button.Parent = TabsFrame
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = Button
    
    return Button
end

-- Función: crear página
local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = name .. "Page"
    Page.Size = UDim2.new(1, -10, 1, -10)
    Page.Position = UDim2.new(0, 5, 0, 5)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 4
    Page.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255)
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.Visible = false
    Page.Parent = ContentFrame
    
    local PageLayout = Instance.new("UIListLayout")
    PageLayout.Padding = UDim.new(0, 8)
    PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PageLayout.Parent = Page
    
    local PagePadding = Instance.new("UIPadding")
    PagePadding.PaddingLeft = UDim.new(0, 10)
    PagePadding.PaddingRight = UDim.new(0, 10)
    PagePadding.PaddingTop = UDim.new(0, 10)
    PagePadding.Parent = Page
    
    return Page
end

-- Crear pestañas y páginas
local InfoTab = CreateTabButton("Info", 1)
local SpeedTab = CreateTabButton("Speed", 2)

local InfoPage = CreatePage("Info")
local SpeedPage = CreatePage("Speed")

-- Sistema de pestañas
local CurrentPage = nil
local TabButtons = {InfoTab, SpeedTab}

local function SwitchPage(page, activeTab)
    if CurrentPage then
        CurrentPage.Visible = false
    end
    page.Visible = true
    CurrentPage = page
    
    for _, btn in ipairs(TabButtons) do
        btn.BackgroundColor3 = Color3.fromRGB(38, 38, 58)
    end
    if activeTab then
        activeTab.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    end
end

-- ============================================
-- PÁGINA: INFO
-- ============================================
local function CreateInfoLabel(text, order, isBold, fontSize)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 0)
    Label.AutomaticSize = Enum.AutomaticSize.Y
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = fontSize or 14
    Label.Font = isBold and Enum.Font.GothamBold or Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextWrapped = true
    Label.LayoutOrder = order
    Label.Parent = InfoPage
    return Label
end

CreateInfoLabel("Nombre del Creador: JoseAngel_Blox", 1, true, 16)
CreateInfoLabel("Fecha de lanzamiento: 05/08/2026", 2, false, 14)
CreateInfoLabel("Versión: 1.1", 3, false, 14)
CreateInfoLabel("", 4, false, 8)
CreateInfoLabel("Agradecimiento:", 5, true, 16)
CreateInfoLabel("Hola bienvenidos y bienvenidas a mi Script este script es de lo mas básico lo que hace este script es darte velocidad gratis a tu personaje espero y disfrutes el script", 6, false, 13)

-- ============================================
-- PÁGINA: SPEED
-- ============================================

-- Label de velocidad actual
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, 0, 0, 30)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "WalkSpeed: " .. CurrentSpeed
SpeedLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
SpeedLabel.TextSize = 18
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Center
SpeedLabel.LayoutOrder = 1
SpeedLabel.Parent = SpeedPage

-- Contenedor de botones + y -
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Size = UDim2.new(1, 0, 0, 40)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.LayoutOrder = 2
ButtonContainer.Parent = SpeedPage

local ButtonLayout = Instance.new("UIListLayout")
ButtonLayout.FillDirection = Enum.FillDirection.Horizontal
ButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ButtonLayout.Padding = UDim.new(0, 15)
ButtonLayout.Parent = ButtonContainer

-- Botón +
local PlusButton = Instance.new("TextButton")
PlusButton.Size = UDim2.new(0, 90, 0, 35)
PlusButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
PlusButton.Text = "+"
PlusButton.TextColor3 = Color3.fromRGB(255, 255, 255)
PlusButton.TextSize = 24
PlusButton.Font = Enum.Font.GothamBold
PlusButton.BorderSizePixel = 0
PlusButton.Parent = ButtonContainer

local PlusCorner = Instance.new("UICorner")
PlusCorner.CornerRadius = UDim.new(0, 8)
PlusCorner.Parent = PlusButton

-- Botón -
local MinusButton = Instance.new("TextButton")
MinusButton.Size = UDim2.new(0, 90, 0, 35)
MinusButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
MinusButton.Text = "-"
MinusButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinusButton.TextSize = 24
MinusButton.Font = Enum.Font.GothamBold
MinusButton.BorderSizePixel = 0
MinusButton.Parent = ButtonContainer

local MinusCorner = Instance.new("UICorner")
MinusCorner.CornerRadius = UDim.new(0, 8)
MinusCorner.Parent = MinusButton

-- TextBox: velocidad infinita personalizada
local SpeedInput = Instance.new("TextBox")
SpeedInput.Size = UDim2.new(1, 0, 0, 35)
SpeedInput.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
SpeedInput.PlaceholderText = "Escribe la velocidad que quieras..."
SpeedInput.PlaceholderColor3 = Color3.fromRGB(140, 140, 140)
SpeedInput.Text = ""
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedInput.TextSize = 15
SpeedInput.Font = Enum.Font.Gotham
SpeedInput.BorderSizePixel = 0
SpeedInput.LayoutOrder = 3
SpeedInput.Parent = SpeedPage

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 8)
InputCorner.Parent = SpeedInput

local InputPadding = Instance.new("UIPadding")
InputPadding.PaddingLeft = UDim.new(0, 8)
InputPadding.Parent = SpeedInput

-- Toggle para activar/desactivar
local ToggleContainer = Instance.new("Frame")
ToggleContainer.Size = UDim2.new(1, 0, 0, 40)
ToggleContainer.BackgroundTransparency = 1
ToggleContainer.LayoutOrder = 4
ToggleContainer.Parent = SpeedPage

local ToggleLabel = Instance.new("TextLabel")
ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
ToggleLabel.BackgroundTransparency = 1
ToggleLabel.Text = "Activar Speed"
ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleLabel.TextSize = 16
ToggleLabel.Font = Enum.Font.GothamSemibold
ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
ToggleLabel.Parent = ToggleContainer

local ToggleBackground = Instance.new("TextButton")
ToggleBackground.Size = UDim2.new(0, 50, 0, 26)
ToggleBackground.Position = UDim2.new(1, -55, 0.5, -13)
ToggleBackground.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ToggleBackground.Text = ""
ToggleBackground.BorderSizePixel = 0
ToggleBackground.AutoButtonColor = false
ToggleBackground.Parent = ToggleContainer

local ToggleBgCorner = Instance.new("UICorner")
ToggleBgCorner.CornerRadius = UDim.new(1, 0)
ToggleBgCorner.Parent = ToggleBackground

local ToggleCircle = Instance.new("Frame")
ToggleCircle.Size = UDim2.new(0, 20, 0, 20)
ToggleCircle.Position = UDim2.new(0, 3, 0, 3)
ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ToggleCircle.BorderSizePixel = 0
ToggleCircle.Parent = ToggleBackground

local CircleCorner = Instance.new("UICorner")
CircleCorner.CornerRadius = UDim.new(1, 0)
CircleCorner.Parent = ToggleCircle

-- ============================================
-- LÓGICA DEL SPEED
-- ============================================

local function UpdateSpeedLabel()
    SpeedLabel.Text = "WalkSpeed: " .. CurrentSpeed
end

local function ApplySpeed()
    local Character = Player.Character
    if Character then
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        if Humanoid then
            Humanoid.WalkSpeed = CurrentSpeed
        end
    end
end

local function RestoreDefaultSpeed()
    local Character = Player.Character
    if Character then
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        if Humanoid then
            Humanoid.WalkSpeed = 16
        end
    end
end

-- Botón +
PlusButton.MouseButton1Click:Connect(function()
    CurrentSpeed = CurrentSpeed + 5
    UpdateSpeedLabel()
    if SpeedEnabled then
        ApplySpeed()
    end
end)

-- Botón -
MinusButton.MouseButton1Click:Connect(function()
    CurrentSpeed = CurrentSpeed - 5
    UpdateSpeedLabel()
    if SpeedEnabled then
        ApplySpeed()
    end
end)

-- TextBox: velocidad personalizada sin límite
SpeedInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local value = tonumber(SpeedInput.Text)
        if value then
            CurrentSpeed = value
            UpdateSpeedLabel()
            if SpeedEnabled then
                ApplySpeed()
            end
        end
        SpeedInput.Text = ""
    end
end)

-- Toggle
local function SetToggle(state)
    SpeedEnabled = state
    if state then
        TweenService:Create(ToggleBackground, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        }):Play()
        TweenService:Create(ToggleCircle, TweenInfo.new(0.2), {
            Position = UDim2.new(0, 27, 0, 3)
        }):Play()
        ApplySpeed()
    else
        TweenService:Create(ToggleBackground, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        }):Play()
        TweenService:Create(ToggleCircle, TweenInfo.new(0.2), {
            Position = UDim2.new(0, 3, 0, 3)
        }):Play()
        RestoreDefaultSpeed()
    end
end

ToggleBackground.MouseButton1Click:Connect(function()
    SetToggle(not SpeedEnabled)
end)

-- Mantener velocidad al respawnear
Player.CharacterAdded:Connect(function(character)
    task.wait(1)
    if SpeedEnabled then
        local Humanoid = character:WaitForChild("Humanoid", 5)
        if Humanoid then
            Humanoid.WalkSpeed = CurrentSpeed
        end
    end
end)

-- ============================================
-- EVENTOS DE PESTAÑAS
-- ============================================
InfoTab.MouseButton1Click:Connect(function()
    SwitchPage(InfoPage, InfoTab)
end)

SpeedTab.MouseButton1Click:Connect(function()
    SwitchPage(SpeedPage, SpeedTab)
end)

-- Iniciar con Info visible
SwitchPage(InfoPage, InfoTab)

print("JoseAngel_Blox Speed v1.1 cargado correctamente!")
