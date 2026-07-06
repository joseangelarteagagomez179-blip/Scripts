--[[
    Nombre: JoseAngel_Blox Fly
    Versión: 1.2
    Creador: JoseAngel_Blox
    Fecha de lanzamiento: 06/07/2026
    Descripción: Sistema de vuelo configurable, compatible con móvil y PC
    Uso recomendado: Solo en juegos propios de Roblox Studio
]]

-- ======================
-- CONFIGURACIÓN GENERAL
-- ======================
local Config = {
    Activo = false,
    Velocidad = 25,
    VelocidadMinima = 10,
    VelocidadMaxima = 120,
    Noclip = false, -- Solo funciona en juegos propios
    TeclaActivar = Enum.KeyCode.F,
    TeclaSubir = Enum.KeyCode.Space,
    TeclaBajar = Enum.KeyCode.LeftControl
}

-- ======================
-- SERVICIOS DEL JUEGO
-- ======================
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local Jugador = Players.LocalPlayer
local Personaje = Jugador.Character or Jugador.CharacterAdded:Wait()
local Humanoide = Personaje:WaitForChild("Humanoid")
local Raiz = Personaje:WaitForChild("HumanoidRootPart")

-- ======================
-- CREACIÓN DE INTERFAZ
-- ======================
local Interfaz = Instance.new("ScreenGui")
Interfaz.Name = "JoseAngel_Blox_Fly_UI"
Interfaz.ResetOnSpawn = false
Interfaz.Parent = Jugador:WaitForChild("PlayerGui")

-- Marco principal
local Marco = Instance.new("Frame")
Marco.Size = UDim2.new(0, 220, 0, 160)
Marco.Position = UDim2.new(0.02, 0, 0.02, 0)
Marco.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Marco.BorderSizePixel = 2
Marco.BorderColor3 = Color3.fromRGB(80, 120, 255)
Marco.Active = true
Marco.Draggable = true
Marco.Parent = Interfaz

-- Título
local Titulo = Instance.new("TextLabel")
Titulo.Size = UDim2.new(1, 0, 0, 30)
Titulo.BackgroundColor3 = Color3.fromRGB(40, 60, 150)
Titulo.Text = "✈️ JoseAngel_Blox Fly v1.2"
Titulo.TextColor3 = Color3.new(1,1,1)
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 14
Titulo.Parent = Marco

-- Interruptor de activación
local BotonActivar = Instance.new("TextButton")
BotonActivar.Size = UDim2.new(0.9, 0, 0, 35)
BotonActivar.Position = UDim2.new(0.05, 0, 0.25, 0)
BotonActivar.BackgroundColor3 = Color3.fromRGB(60, 180, 60)
BotonActivar.Text = "VUELO: ACTIVADO"
BotonActivar.TextColor3 = Color3.new(1,1,1)
BotonActivar.Font = Enum.Font.GothamSemibold
BotonActivar.TextSize = 13
BotonActivar.Parent = Marco

-- Barra de velocidad
local TextoVelocidad = Instance.new("TextLabel")
TextoVelocidad.Size = UDim2.new(1, 0, 0, 25)
TextoVelocidad.Position = UDim2.new(0, 0, 0.52, 0)
TextoVelocidad.BackgroundTransparency = 1
TextoVelocidad.Text = "Velocidad: "..Config.Velocidad
TextoVelocidad.TextColor3 = Color3.new(1,1,1)
TextoVelocidad.Font = Enum.Font.Gotham
TextoVelocidad.TextSize = 12
TextoVelocidad.Parent = Marco

-- Botones para cambiar velocidad
local BotonMas = Instance.new("TextButton")
BotonMas.Size = UDim2.new(0.4, 0, 0, 30)
BotonMas.Position = UDim2.new(0.05, 0, 0.75, 0)
BotonMas.BackgroundColor3 = Color3.fromRGB(80, 140, 255)
BotonMas.Text = "+"
BotonMas.TextColor3 = Color3.new(1,1,1)
BotonMas.Font = Enum.Font.GothamBold
BotonMas.TextSize = 16
BotonMas.Parent = Marco

local BotonMenos = Instance.new("TextButton")
BotonMenos.Size = UDim2.new(0.4, 0, 0, 30)
BotonMenos.Position = UDim2.new(0.55, 0, 0.75, 0)
BotonMenos.BackgroundColor3 = Color3.fromRGB(80, 140, 255)
BotonMenos.Text = "-"
BotonMenos.TextColor3 = Color3.new(1,1,1)
BotonMenos.Font = Enum.Font.GothamBold
BotonMenos.TextSize = 16
BotonMenos.Parent = Marco

-- ======================
-- LÓGICA DE FUNCIONAMIENTO
-- ======================
local CuerpoAnclado
local VectorMovimiento = Vector3.new(0,0,0)

-- Activar/Desactivar vuelo
local function CambiarEstado()
    Config.Activo = not Config.Activo
    if Config.Activo then
        BotonActivar.Text = "VUELO: ACTIVADO"
        BotonActivar.BackgroundColor3 = Color3.fromRGB(60, 180, 60)
        Humanoide.PlatformStand = true
        CuerpoAnclado = Raiz:FindFirstChild("Anclaje") or Instance.new("BodyPosition", Raiz)
        CuerpoAnclado.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    else
        BotonActivar.Text = "VUELO: DESACTIVADO"
        BotonActivar.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
        Humanoide.PlatformStand = false
        if CuerpoAnclado then CuerpoAnclado:Destroy() end
    end
end

-- Actualizar movimiento
RunService.RenderStepped:Connect(function()
    if not Config.Activo or not Raiz then return end

    VectorMovimiento = Vector3.new()
    local Direccion = Humanoide.MoveDirection

    if Direccion.Magnitude > 0 then
        VectorMovimiento = CFrame.new(Raiz.Position, Raiz.Position + Direccion) * Vector3.new(0, 0, -1)
    end

    -- Subir / Bajar altura
    if UserInputService:IsKeyDown(Config.TeclaSubir) then
        VectorMovimiento = VectorMovimiento + Vector3.new(0, 1, 0)
    end
    if UserInputService:IsKeyDown(Config.TeclaBajar) then
        VectorMovimiento = VectorMovimiento + Vector3.new(0, -1, 0)
    end

    -- Aplicar velocidad
    if VectorMovimiento.Magnitude > 0 then
        VectorMovimiento = VectorMovimiento.Unit * Config.Velocidad
    end

    -- Actualizar posición
    CuerpoAnclado.Position = Raiz.Position + VectorMovimiento * 0.1
end)

-- Controles de interfaz
BotonActivar.MouseButton1Click:Connect(CambiarEstado)

BotonMas.MouseButton1Click:Connect(function()
    if Config.Velocidad < Config.VelocidadMaxima then
        Config.Velocidad = Config.Velocidad + 5
        TextoVelocidad.Text = "Velocidad: "..Config.Velocidad
    end
end)

BotonMenos.MouseButton1Click:Connect(function()
    if Config.Velocidad > Config.VelocidadMinima then
        Config.Velocidad = Config.Velocidad - 5
        TextoVelocidad.Text = "Velocidad: "..Config.Velocidad
    end
end)

-- Tecla de activación en PC
UserInputService.InputBegan:Connect(function(Entrada)
    if Entrada.KeyCode == Config.TeclaActivar and not UserInputService:GetFocusedTextBox() then
        CambiarEstado()
    end
end)

-- Actualizar personaje si reaparece
Jugador.CharacterAdded:Connect(function(NuevoPersonaje)
    Personaje = NuevoPersonaje
    Humanoide = Personaje:WaitForChild("Humanoid")
    Raiz = Personaje:WaitForChild("HumanoidRootPart")
    Config.Activo = false
end)

print("✅ JoseAngel_Blox Fly v1.2 cargado correctamente")
