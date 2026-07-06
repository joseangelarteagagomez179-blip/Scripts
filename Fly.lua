--[[
    Nombre: JoseAngel_Blox Fly
    Versión: 1.2
    Creador: JoseAngel_Blox
    Fecha: 06/07/2026
    Características: Vuelo, velocidad ajustable, compatible móvil/PC
]]

-- ==================================
-- SERVICIOS Y VARIABLES PRINCIPALES
-- ==================================
local Servicios = {
    Players = game:GetService("Players"),
    UserInput = game:GetService("UserInputService"),
    Run = game:GetService("RunService")
}

local Jugador = Servicios.Players.LocalPlayer
local Personaje = Jugador.Character or Jugador.CharacterAdded:Wait()
local Humanoide = Personaje:WaitForChild("Humanoid")
local Raiz = Personaje:WaitForChild("HumanoidRootPart")

-- ==================================
-- CONFIGURACIÓN PERSONALIZABLE
-- ==================================
local Config = {
    Activo = false,
    Velocidad = 30,
    VelMin = 10,
    VelMax = 150,
    TeclaActivar = Enum.KeyCode.F,
    TeclaSubir = Enum.KeyCode.Space,
    TeclaBajar = Enum.KeyCode.LeftControl
}

-- ==================================
-- CREACIÓN DE LA INTERFAZ
-- ==================================
local GUI = Instance.new("ScreenGui")
GUI.Name = "JoseAngel_Blox_Fly"
GUI.ResetOnSpawn = false
GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
GUI.Parent = Jugador:WaitForChild("PlayerGui")

-- Marco principal
local Marco = Instance.new("Frame")
Marco.Size = UDim2.new(0, 240, 0, 180)
Marco.Position = UDim2.new(0.02, 0, 0.02, 0)
Marco.BackgroundColor3 = Color3.fromRGB(20, 25, 40)
Marco.BorderSizePixel = 2
Marco.BorderColor3 = Color3.fromRGB(90, 140, 255)
Marco.Active = true
Marco.Draggable = true
Marco.Parent = GUI

-- Título
local Titulo = Instance.new("TextLabel")
Titulo.Size = UDim2.new(1, 0, 0, 32)
Titulo.BackgroundColor3 = Color3.fromRGB(50, 80, 200)
Titulo.Text = "✈️ JoseAngel_Blox Fly v1.2"
Titulo.TextColor3 = Color3.new(1, 1, 1)
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 15
Titulo.Parent = Marco

-- Botón activar/desactivar
local BotonVuelo = Instance.new("TextButton")
BotonVuelo.Size = UDim2.new(0.9, 0, 0, 38)
BotonVuelo.Position = UDim2.new(0.05, 0, 0.28, 0)
BotonVuelo.BackgroundColor3 = Color3.fromRGB(60, 190, 70)
BotonVuelo.Text = "VUELO: ACTIVADO"
BotonVuelo.TextColor3 = Color3.new(1, 1, 1)
BotonVuelo.Font = Enum.Font.GothamSemibold
BotonVuelo.TextSize = 14
BotonVuelo.Parent = Marco

-- Texto de velocidad
local TextoVel = Instance.new("TextLabel")
TextoVel.Size = UDim2.new(1, 0, 0, 28)
TextoVel.Position = UDim2.new(0, 0, 0.55, 0)
TextoVel.BackgroundTransparency = 1
TextoVel.Text = "Velocidad: " .. Config.Velocidad
TextoVel.TextColor3 = Color3.new(1, 1, 1)
TextoVel.Font = Enum.Font.Gotham
TextoVel.TextSize = 13
TextoVel.Parent = Marco

-- Botones de velocidad
local BotonMas = Instance.new("TextButton")
BotonMas.Size = UDim2.new(0.42, 0, 0, 35)
BotonMas.Position = UDim2.new(0.06, 0, 0.78, 0)
BotonMas.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
BotonMas.Text = "+"
BotonMas.TextColor3 = Color3.new(1, 1, 1)
BotonMas.Font = Enum.Font.GothamBold
BotonMas.TextSize = 18
BotonMas.Parent = Marco

local BotonMenos = Instance.new("TextButton")
BotonMenos.Size = UDim2.new(0.42, 0, 0, 35)
BotonMenos.Position = UDim2.new(0.52, 0, 0.78, 0)
BotonMenos.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
BotonMenos.Text = "-"
BotonMenos.TextColor3 = Color3.new(1, 1, 1)
BotonMenos.Font = Enum.Font.GothamBold
BotonMenos.TextSize = 18
BotonMenos.Parent = Marco

-- ==================================
-- LÓGICA DE VUELO
-- ==================================
local Anclaje = nil
local DireccionMovimiento = Vector3.new(0, 0, 0)

-- Función para activar/desactivar
local function CambiarEstado()
    Config.Activo = not Config.Activo
    if Config.Activo then
        BotonVuelo.Text = "VUELO: ACTIVADO"
        BotonVuelo.BackgroundColor3 = Color3.fromRGB(60, 190, 70)
        Humanoide.PlatformStand = true
        Anclaje = Instance.new("BodyPosition")
        Anclaje.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        Anclaje.Position = Raiz.Position
        Anclaje.Parent = Raiz
    else
        BotonVuelo.Text = "VUELO: DESACTIVADO"
        BotonVuelo.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
        Humanoide.PlatformStand = false
        if Anclaje then Anclaje:Destroy() end
    end
end

-- Actualizar movimiento cada fotograma
Servicios.Run.RenderStepped:Connect(function()
    if not Config.Activo or not Raiz or not Anclaje then return end

    DireccionMovimiento = Vector3.new(0, 0, 0)
    local DireccionEntrada = Humanoide.MoveDirection

    -- Movimiento horizontal
    if DireccionEntrada.Magnitude > 0 then
        DireccionMovimiento = CFrame.new(Raiz.Position, Raiz.Position + DireccionEntrada) * Vector3.new(0, 0, -1)
    end

    -- Subir y bajar
    if Servicios.UserInput:IsKeyDown(Config.TeclaSubir) then
        DireccionMovimiento = DireccionMovimiento + Vector3.new(0, 1, 0)
    end
    if Servicios.UserInput:IsKeyDown(Config.TeclaBajar) then
        DireccionMovimiento = DireccionMovimiento + Vector3.new(0, -1, 0)
    end

    -- Aplicar velocidad
    if DireccionMovimiento.Magnitude > 0 then
        DireccionMovimiento = DireccionMovimiento.Unit * Config.Velocidad
    end

    -- Actualizar posición
    Anclaje.Position = Raiz.Position + DireccionMovimiento * 0.1
end)

-- ==================================
-- CONTROLES DE INTERFAZ Y TECLADO
-- ==================================
BotonVuelo.MouseButton1Click:Connect(CambiarEstado)

BotonMas.MouseButton1Click:Connect(function()
    if Config.Velocidad < Config.VelMax then
        Config.Velocidad = Config.Velocidad + 5
        TextoVel.Text = "Velocidad: " .. Config.Velocidad
    end
end)

BotonMenos.MouseButton1Click:Connect(function()
    if Config.Velocidad > Config.VelMin then
        Config.Velocidad = Config.Velocidad - 5
        TextoVel.Text = "Velocidad: " .. Config.Velocidad
    end
end)

Servicios.UserInput.InputBegan:Connect(function(Entrada)
    if Entrada.KeyCode == Config.TeclaActivar and not Servicios.UserInput:GetFocusedTextBox() then
        CambiarEstado()
    end
end)

-- Actualizar si reaparece el personaje
Jugador.CharacterAdded:Connect(function(NuevoPersonaje)
    Personaje = NuevoPersonaje
    Humanoide = Personaje:WaitForChild("Humanoid")
    Raiz = Personaje:WaitForChild("HumanoidRootPart")
    Config.Activo = false
end)

print("✅ JoseAngel_Blox Fly v1.2 cargado con éxito")
