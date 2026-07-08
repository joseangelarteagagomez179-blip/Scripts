--[[
▓▒░ JOSEANGEL_BLOX SCRIPTS PRO ░▒▓
Relación: 1:1 | Esquinas redondeadas | Interfaz optimizada
Fecha: 08/07/2026 | Versión: 1.1
]]

-- Servicios necesarios
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- ⚙️ CONFIGURACIÓN PRINCIPAL
local Config = {
    InterfazActiva = true,
    GodMode = false,
    ItemESP = false,
    AutoUnlockDoors = false,
    AutoGrabItems = false,
    NoClip = false,
    Speed = false,
    SpeedValor = 40,
    Jump = false,
    JumpValor = 80,
    FullBright = false,
    JugadorESP = false
}

-- 🎨 CREACIÓN DE LA INTERFAZ (CUADRADA 1:1, ESQUINAS REDONDEADAS)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngelBlox_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainWindow"
MainFrame.Size = UDim2.new(0, 350, 0, 350) -- Relación 1:1
MainFrame.Position = UDim2.new(0.02, 0, 0.1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.BorderMode = Enum.BorderMode.Outline
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Esquinas redondeadas
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Barra superior
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local UICornerTop = Instance.new("UICorner")
UICornerTop.CornerRadius = UDim.new(0, 12)
UICornerTop.Parent = TopBar

local Titulo = Instance.new("TextLabel")
Titulo.Size = UDim2.new(1, -10, 1, 0)
Titulo.Position = UDim2.new(0, 10, 0, 0)
Titulo.Text = "JoseAngel_Blox Scripts PRO"
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 16
Titulo.TextColor3 = Color3.fromRGB(255, 215, 0)
Titulo.BackgroundTransparency = 1
Titulo.TextXAlignment = Enum.TextXAlignment.Left
Titulo.Parent = TopBar

-- Área de contenido
local ContenidoFrame = Instance.new("ScrollingFrame")
ContenidoFrame.Size = UDim2.new(1, -20, 1, -45)
ContenidoFrame.Position = UDim2.new(0, 10, 0, 40)
ContenidoFrame.BackgroundTransparency = 1
ContenidoFrame.BorderSizePixel = 0
ContenidoFrame.ScrollBarThickness = 4
ContenidoFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 150)
ContenidoFrame.Parent = MainFrame

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 8)
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.Parent = ContenidoFrame

-- 📋 FUNCIÓN PARA CREAR INTERRUPTORES
local function CrearInterruptor(texto, posicion)
    local BotonFrame = Instance.new("Frame")
    BotonFrame.Size = UDim2.new(1, 0, 0, 30)
    BotonFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    BotonFrame.BorderSizePixel = 0
    BotonFrame.LayoutOrder = posicion
    BotonFrame.Parent = ContenidoFrame

    local UICornerBtn = Instance.new("UICorner")
    UICornerBtn.CornerRadius = UDim.new(0, 6)
    UICornerBtn.Parent = BotonFrame

    local TextoOpcion = Instance.new("TextLabel")
    TextoOpcion.Size = UDim2.new(0.8, -10, 1, 0)
    TextoOpcion.Position = UDim2.new(0, 10, 0, 0)
    TextoOpcion.Text = texto
    TextoOpcion.Font = Enum.Font.GothamSemibold
    TextoOpcion.TextSize = 13
    TextoOpcion.TextColor3 = Color3.fromRGB(230, 230, 255)
    TextoOpcion.BackgroundTransparency = 1
    TextoOpcion.TextXAlignment = Enum.TextXAlignment.Left
    TextoOpcion.Parent = BotonFrame

    local Interruptor = Instance.new("Frame")
    Interruptor.Size = UDim2.new(0, 36, 0, 18)
    Interruptor.Position = UDim2.new(1, -45, 0.5, -9)
    Interruptor.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    Interruptor.BorderSizePixel = 0
    Interruptor.Parent = BotonFrame

    local UICornerInt = Instance.new("UICorner")
    UICornerInt.CornerRadius = UDim.new(1, 0)
    UICornerInt.Parent = Interruptor

    local Bola = Instance.new("Frame")
    Bola.Size = UDim2.new(0, 14, 0, 14)
    Bola.Position = UDim2.new(0, 2, 0.5, -7)
    Bola.BackgroundColor3 = Color3.fromRGB(200, 200, 220)
    Bola.BorderSizePixel = 0
    Bola.Parent = Interruptor

    local UICornerBola = Instance.new("UICorner")
    UICornerBola.CornerRadius = UDim.new(1, 0)
    UICornerBola.Parent = Bola

    local activado = false
    return {
        Frame = BotonFrame,
        Interruptor = Interruptor,
        Bola = Bola,
        Toggle = function()
            activado = not activado
            if activado then
                Interruptor.BackgroundColor3 = Color3.fromRGB(50, 180, 80)
                Bola.Position = UDim2.new(0, 20, 0.5, -7)
            else
                Interruptor.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
                Bola.Position = UDim2.new(0, 2, 0.5, -7)
            end
            return activado
        end
    }
end

-- 📄 SECCIÓN INFORMACIÓN
local InfoLabel = Instance.new("TextLabel")
InfoLabel.Size = UDim2.new(1, 0, 0, 60)
InfoLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
InfoLabel.BorderSizePixel = 0
InfoLabel.Text = [[1) INFO ↓
• Creador: JoseAngel_Blox
• Lanzamiento: 08/07/2026
• Versión: 1.1]]
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.TextSize = 12
InfoLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
InfoLabel.TextWrapped = true
InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
InfoLabel.TextYAlignment = Enum.TextYAlignment.Top
InfoLabel.LayoutOrder = 1
InfoLabel.Parent = ContenidoFrame

local UICornerInfo = Instance.new("UICorner")
UICornerInfo.CornerRadius = UDim.new(0, 6)
UICornerInfo.Parent = InfoLabel

-- 🎮 SECCIÓN DE FUNCIONES PRINCIPALES
local MainLabel = Instance.new("TextLabel")
MainLabel.Size = UDim2.new(1, 0, 0, 25)
MainLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
MainLabel.BorderSizePixel = 0
MainLabel.Text = "2) MAIN ↓"
MainLabel.Font = Enum.Font.GothamBold
MainLabel.TextSize = 14
MainLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
MainLabel.LayoutOrder = 2
MainLabel.Parent = ContenidoFrame

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 6)
UICornerMain.Parent = MainLabel

-- Crear todos los interruptores
local GodModeBtn = CrearInterruptor("God Mode (Invencible)", 3)
local ItemESPBtn = CrearInterruptor("Item ESP", 4)
local AutoDoorsBtn = CrearInterruptor("Auto Unlock Doors", 5)
local AutoGrabBtn = CrearInterruptor("Auto Grab Items", 6)
local NoClipBtn = CrearInterruptor("No Clip", 7)
local SpeedBtn = CrearInterruptor("Speed & Jump", 8)
local FullBrightBtn = CrearInterruptor("FullBright", 9)
local JugadorESPBtn = CrearInterruptor("ESP (Jugadores / Piggy)", 10)

-- ⌨️ TECLA DE ACTIVACIÓN GENERAL (INSERT)
UserInputService.InputBegan:Connect(function(entrada, procesada)
    if procesada then return end
    if entrada.KeyCode == Enum.KeyCode.Insert then
        Config.InterfazActiva = not Config.InterfazActiva
        MainFrame.Visible = Config.InterfazActiva
    end
end)

-- 🚀 CONEXIÓN DE FUNCIONES A LOS INTERRUPTORES
GodModeBtn.Frame.MouseButton1Click:Connect(function()
    Config.GodMode = GodModeBtn.Toggle()
end)

ItemESPBtn.Frame.MouseButton1Click:Connect(function()
    Config.ItemESP = ItemESPBtn.Toggle()
end)

AutoDoorsBtn.Frame.MouseButton1Click:Connect(function()
    Config.AutoUnlockDoors = AutoDoorsBtn.Toggle()
end)

AutoGrabBtn.Frame.MouseButton1Click:Connect(function()
    Config.AutoGrabItems = AutoGrabBtn.Toggle()
end)

NoClipBtn.Frame.MouseButton1Click:Connect(function()
    Config.NoClip = NoClipBtn.Toggle()
end)

SpeedBtn.Frame.MouseButton1Click:Connect(function()
    Config.Speed = SpeedBtn.Toggle()
    Config.Jump = Config.Speed
end)

FullBrightBtn.Frame.MouseButton1Click:Connect(function()
    Config.FullBright = FullBrightBtn.Toggle()
end)

JugadorESPBtn.Frame.MouseButton1Click:Connect(function()
    Config.JugadorESP = JugadorESPBtn.Toggle()
end)

-- ⚡ EJECUCIÓN DE FUNCIONES EN BUCLE
RunService.RenderStepped:Connect(function()
    if not Character or not Humanoid then return end
    if Humanoid.Health <= 0 then return end

    -- God Mode
    Humanoid.MaxHealth = Config.GodMode and math.huge or 100
    Humanoid.Health = Config.GodMode and Humanoid.MaxHealth or Humanoid.Health

    -- No Clip
    for _, parte in ipairs(Character:GetDescendants()) do
        if parte:IsA("BasePart") then
            parte.CanCollide = not Config.NoClip
        end
    end

    -- Velocidad y Salto
    Humanoid.WalkSpeed = Config.Speed and Config.SpeedValor or 16
    Humanoid.JumpPower = Config.Jump and Config.JumpValor or 50

    -- FullBright
    Workspace.Lighting.Brightness = Config.FullBright and 2 or 1
    Workspace.Lighting.ClockTime = Config.FullBright and 14 or 12
    Workspace.Lighting.FogEnd = Config.FullBright and 100000 or 1000

end)

-- Mensaje de inicio
StarterGui:SetCore("SendNotification", {
    Title = "JoseAngel_Blox Scripts PRO",
    Text = "Cargado correctamente | Presiona INSERT para mostrar/ocultar",
    Duration = 5
})
