--[[
    JoseAngel_Blox Scripts PRO v1.1
    Fecha: 08/07/2026
    Relación: 4:3 | Estilo: Profesional
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer

-- Configuración Inicial
local config = {
    GodMode = false,
    ItemESP = false,
    AutoUnlock = false,
    AutoGrab = false,
    NoClip = false,
    SpeedHack = false,
    FullBright = false,
    PlayerESP = false,
    WalkSpeed = 32,
    JumpPower = 50
}

-- INTERFAZ PRINCIPAL
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngelPRO"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Frame 4:3 (Ej: 400x300)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 0, 40)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "JoseAngel_Blox Scripts PRO"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

-- Sidebar de Secciones (Fila a la izquierda)
local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Size = UDim2.new(0, 100, 1, -60)
Sidebar.Position = UDim2.new(0, 10, 0, 50)
Sidebar.BackgroundTransparency = 1
Sidebar.ScrollBarThickness = 0
Sidebar.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.Padding = UDim.new(0, 5)
UIList.Parent = Sidebar

-- Función para crear Toggles profesionales
local function createToggle(parent, text, configPath)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -10, 0, 25)
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Button.Text = text .. ": OFF"
    Button.TextColor3 = Color3.fromRGB(200, 200, 200)
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 12
    Button.Parent = parent

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Button

    Button.MouseButton1Click:Connect(function()
        config[configPath] = not config[configPath]
        Button.Text = text .. (config[configPath] and ": ON" or ": OFF")
        Button.TextColor3 = config[configPath] and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(200, 200, 200)
    end)
end

-- SECCIÓN 1: INFO (Esquina Inferior Izquierda)
local InfoLabel = Instance.new("TextLabel")
InfoLabel.Size = UDim2.new(0, 150, 0, 40)
InfoLabel.Position = UDim2.new(0, 10, 1, -45)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = "Creador: JoseAngel_Blox\nLanzamiento: 08/07/2026\nVersión: 1.1"
InfoLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.TextSize = 10
InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
InfoLabel.Parent = MainFrame

-- SECCIÓN 2: MAIN (Contenedor de Opciones)
local OptionsFrame = Instance.new("ScrollingFrame")
OptionsFrame.Size = UDim2.new(1, -130, 1, -60)
OptionsFrame.Position = UDim2.new(0, 120, 0, 50)
OptionsFrame.BackgroundTransparency = 1
OptionsFrame.CanvasSize = UDim2.new(0, 0, 1.5, 0)
OptionsFrame.ScrollBarThickness = 2
OptionsFrame.Parent = MainFrame

local OptionsList = Instance.new("UIListLayout")
OptionsList.Padding = UDim.new(0, 8)
OptionsList.Parent = OptionsFrame

-- Agregar Toggles
createToggle(OptionsFrame, "God Mode", "GodMode")
createToggle(OptionsFrame, "Item ESP", "ItemESP")
createToggle(OptionsFrame, "Auto Unlock", "AutoUnlock")
createToggle(OptionsFrame, "Auto Grab", "AutoGrab")
createToggle(OptionsFrame, "No Clip", "NoClip")
createToggle(OptionsFrame, "Speed & Jump", "SpeedHack")
createToggle(OptionsFrame, "FullBright", "FullBright")
createToggle(OptionsFrame, "Player ESP", "PlayerESP")

-- LÓGICA DE FUNCIONES
RunService.Stepped:Connect(function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        -- Speed & Jump
        if config.SpeedHack then
            player.Character.Humanoid.WalkSpeed = config.WalkSpeed
            player.Character.Humanoid.JumpPower = config.JumpPower
        else
            player.Character.Humanoid.WalkSpeed = 16
        end

        -- No Clip
        if config.NoClip then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end
    
    -- FullBright
    if config.FullBright then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
    end
end)

-- Toggle con tecla INSERT
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.Insert then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

print("✅ JoseAngel_Blox Scripts PRO cargado. Presiona INSERT para abrir.")
