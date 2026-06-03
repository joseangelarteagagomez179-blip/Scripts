--[[
    Nombre: JoseAngel_Blox Fly
    Función: Volar con control de velocidad
    Compatible: Delta Executor
    Diseñado para: Celular y PC
]]

-- Servicios necesarios
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Variables principales
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local RootPart = Character:WaitForChild("HumanoidRootPart")

local flying = false
local velocidadActual = 50 -- Velocidad inicial
local bodyVelocity, gyro

-- ─────────────────────────────────────
-- CREACIÓN DE LA INTERFAZ
-- ─────────────────────────────────────
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngelBlox_Fly"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game:GetService("CoreGui")

-- Marco principal
local MarcoPrincipal = Instance.new("Frame")
MarcoPrincipal.Size = UDim2.new(0, 300, 0, 260)
MarcoPrincipal.Position = UDim2.new(0.5, -150, 0.5, -130)
MarcoPrincipal.BackgroundColor3 = Color3.fromRGB(18, 22, 28)
MarcoPrincipal.BorderSizePixel = 0
MarcoPrincipal.BackgroundTransparency = 0.05
MarcoPrincipal.Parent = ScreenGui

-- Esquinas redondeadas
local Esquinas = Instance.new("UICorner")
Esquinas.CornerRadius = UDim.new(0, 12)
Esquinas.Parent = MarcoPrincipal

-- Título
local Titulo = Instance.new("TextLabel")
Titulo.Size = UDim2.new(1, 0, 0, 50)
Titulo.BackgroundColor3 = Color3.fromRGB(30, 36, 46)
Titulo.Text = "✈️ JoseAngel_Blox Fly"
Titulo.TextColor3 = Color3.fromRGB(255, 215, 0)
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 19
Titulo.Parent = MarcoPrincipal
Instance.new("UICorner", Titulo).CornerRadius = UDim.new(0, 12)

-- Botón Cerrar
local BotonCerrar = Instance.new("TextButton")
BotonCerrar.Size = UDim2.new(0, 32, 0, 32)
BotonCerrar.Position = UDim2.new(1, -38, 0, 9)
BotonCerrar.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
BotonCerrar.Text = "X"
BotonCerrar.TextColor3 = Color3.new(1,1,1)
BotonCerrar.Font = Enum.Font.GothamBold
BotonCerrar.TextSize = 16
BotonCerrar.Parent = MarcoPrincipal
Instance.new("UICorner", BotonCerrar).CornerRadius = UDim.new(0, 8)

-- Texto de velocidad actual
local TextoVelocidad = Instance.new("TextLabel")
TextoVelocidad.Size = UDim2.new(0.8, 0, 0, 40)
TextoVelocidad.Position = UDim2.new(0.1, 0, 0.28, 0)
TextoVelocidad.BackgroundTransparency = 1
TextoVelocidad.Text = "Velocidad: " .. velocidadActual
TextoVelocidad.TextColor3 = Color3.new(1,1,1)
TextoVelocidad.Font = Enum.Font.GothamSemibold
TextoVelocidad.TextSize = 17
TextoVelocidad.Parent = MarcoPrincipal

-- Botón Reducir Velocidad
local BotonMenos = Instance.new("TextButton")
BotonMenos.Size = UDim2.new(0.35, 0, 0, 45)
BotonMenos.Position = UDim2.new(0.1, 0, 0.48, 0)
BotonMenos.BackgroundColor3 = Color3.fromRGB(45, 52, 62)
BotonMenos.Text = "➖ Menos"
BotonMenos.TextColor3 = Color3.new(1,1,1)
BotonMenos.Font = Enum.Font.GothamBold
BotonMenos.TextSize = 16
BotonMenos.Parent = MarcoPrincipal
Instance.new("UICorner", BotonMenos).CornerRadius = UDim.new(0, 10)

-- Botón Aumentar Velocidad
local BotonMas = Instance.new("TextButton")
BotonMas.Size = UDim2.new(0.35, 0, 0, 45)
BotonMas.Position = UDim2.new(0.55, 0, 0.48, 0)
BotonMas.BackgroundColor3 = Color3.fromRGB(45, 52, 62)
BotonMas.Text = "➕ Más"
BotonMas.TextColor3 = Color3.new(1,1,1)
BotonMas.Font = Enum.Font.GothamBold
BotonMas.TextSize = 16
BotonMas.Parent = MarcoPrincipal
Instance.new("UICorner", BotonMas).CornerRadius = UDim.new(0, 10)

-- Botón Activar/Desactivar Vuelo
local BotonVolar = Instance.new("TextButton")
BotonVolar.Size = UDim2.new(0.8, 0, 0, 50)
BotonVolar.Position = UDim2.new(0.1, 0, 0.72, 0)
BotonVolar.BackgroundColor3 = Color3.fromRGB(34, 139, 34)
BotonVolar.Text = "✅ Comenzar a Volar"
BotonVolar.TextColor3 = Color3.new(1,1,1)
BotonVolar.Font = Enum.Font.GothamBold
BotonVolar.TextSize = 17
BotonVolar.Parent = MarcoPrincipal
Instance.new("UICorner", BotonVolar).CornerRadius = UDim.new(0, 10)

-- ─────────────────────────────────────
-- FUNCIONES DEL SCRIPT
-- ─────────────────────────────────────

-- Actualizar el texto de velocidad
local function ActualizarTextoVel()
    TextoVelocidad.Text = "Velocidad: " .. velocidadActual
end

-- Reducir velocidad
BotonMenos.MouseButton1Click:Connect(function()
    velocidadActual = math.max(10, velocidadActual - 10) -- Mínimo 10
    ActualizarTextoVel()
end)

-- Aumentar velocidad
BotonMas.MouseButton1Click:Connect(function()
    velocidadActual = math.min(300, velocidadActual + 10) -- Máximo 300
    ActualizarTextoVel()
end)

-- Activar o desactivar vuelo
local function CambiarEstadoVuelo()
    flying = not flying

    if flying then
        BotonVolar.Text = "❌ Desactivar Vuelo"
        BotonVolar.BackgroundColor3 = Color3.fromRGB(200, 40, 40)

        -- Crear fuerzas para volar
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(1e9, 1e9, 1e9)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = RootPart

        gyro = Instance.new("BodyGyro")
        gyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
        gyro.CFrame = RootPart.CFrame
        gyro.Parent = RootPart

        -- Movimiento continuo
        RunService.RenderStepped:Connect(function()
            if flying and bodyVelocity and gyro then
                local camara = workspace.CurrentCamera
                local direccion = Vector3.new()

                -- Controles de movimiento
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then direccion += camara.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then direccion -= camara.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then direccion -= camara.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then direccion += camara.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direccion += Vector3.new(0, 1, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then direccion -= Vector3.new(0, 1, 0) end

                -- Aplicar velocidad
                direccion = direccion.Magnitude > 0 and direccion.Unit * velocidadActual or Vector3.new(0, 0, 0)
                bodyVelocity.Velocity = direccion
                gyro.CFrame = camara.CFrame
            end
        end)

    else
        BotonVolar.Text = "✅ Comenzar a Volar"
        BotonVolar.BackgroundColor3 = Color3.fromRGB(34, 139, 34)

        -- Eliminar fuerzas
        if bodyVelocity then bodyVelocity:Destroy() end
        if gyro then gyro:Destroy() end
    end
end

BotonVolar.MouseButton1Click:Connect(CambiarEstadoVuelo)

-- Cerrar la interfaz
BotonCerrar.MouseButton1Click:Connect(function()
    if flying then CambiarEstadoVuelo() end
    ScreenGui:Destroy()
end)

-- Actualizar personaje si reaparece
LocalPlayer.CharacterAdded:Connect(function(nuevoPersonaje)
    Character = nuevoPersonaje
    RootPart = Character:WaitForChild("HumanoidRootPart")
    if flying then CambiarEstadoVuelo() end
end)
