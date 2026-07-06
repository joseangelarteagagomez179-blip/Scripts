-- ==================================================
-- 📄 INFORMACIÓN
-- ==================================================
-- Nombre del Script: JoseAngel_Blox Fly
-- Nombre del Creador: JoseAngel_Blox
-- Fecha de lanzamiento: 06/07/2026
-- Versión: 1.2
-- Compatibilidad: PC / Móvil / Tablet

-- 📖 MANUAL DE USO
-- ¡Bienvenidos y bienvenidas al script JoseAngel_Blox Fly!
-- Aquí te explicamos cómo utilizar todas sus funciones de forma sencilla:

-- 🖥️ EN PC:
-- • Activar / Desactivar vuelo: Tecla F
-- • Moverse: Teclas W (adelante), S (atrás), A (izquierda), D (derecha)
-- • Subir altura: Tecla Espacio
-- • Bajar altura: Tecla Control Izquierdo
-- • Aumentar velocidad: Tecla +
-- • Disminuir velocidad: Tecla -
-- • Activar / Desactivar Noclip: Tecla N

-- 📱 EN MÓVIL:
-- • Activar / Desactivar vuelo: Botón "Vuelo" en pantalla
-- • Moverse: Usa el joystick táctil
-- • Subir altura: Desliza el dedo hacia arriba
-- • Bajar altura: Desliza el dedo hacia abajo
-- • Aumentar velocidad: Botón "+ Velocidad"
-- • Disminuir velocidad: Botón "- Velocidad"
-- • Activar / Desactivar Noclip: Botón "Noclip" en pantalla

-- ==================================================
-- ⚙️ MAIN - FUNCIONES PRINCIPALES
-- ==================================================

-- Servicios necesarios
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")

-- Datos del jugador
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Configuración del script
local Config = {
    FlyActivo = false,
    Velocidad = 50,
    VelocidadMin = 10,
    VelocidadMax = 150,
    NoclipActivo = false
}

-- Variables de control
local CuerpoVelocidad = Instance.new("BodyVelocity")
CuerpoVelocidad.MaxForce = Vector3.new(999999, 999999, 999999)
CuerpoVelocidad.Velocity = Vector3.new(0, 0, 0)

-- Interfaz gráfica para móvil
local function CrearInterfaz()
    if UserInputService.TouchEnabled then
        local Pantalla = Instance.new("ScreenGui")
        Pantalla.Name = "JoseAngel_Blox_UI"
        Pantalla.ResetOnSpawn = false
        Pantalla.Parent = LocalPlayer:WaitForChild("PlayerGui")

        -- Botón Vuelo
        local BotonVuelo = Instance.new("TextButton")
        BotonVuelo.Size = UDim2.new(0, 120, 0, 50)
        BotonVuelo.Position = UDim2.new(0.02, 0, 0.2, 0)
        BotonVuelo.BackgroundColor3 = Color3.new(0.2, 0.6, 1)
        BotonVuelo.Text = "Vuelo: OFF"
        BotonVuelo.TextColor3 = Color3.new(1,1,1)
        BotonVuelo.Font = Enum.Font.GothamBold
        BotonVuelo.TextSize = 16
        BotonVuelo.Parent = Pantalla

        -- Botón Noclip
        local BotonNoclip = BotonVuelo:Clone()
        BotonNoclip.Position = UDim2.new(0.02, 0, 0.3, 0)
        BotonNoclip.Text = "Noclip: OFF"
        BotonNoclip.Parent = Pantalla

        -- Botón + Velocidad
        local BotonMas = BotonVuelo:Clone()
        BotonMas.Position = UDim2.new(0.02, 0, 0.4, 0)
        BotonMas.Size = UDim2.new(0, 55, 0, 50)
        BotonMas.Text = "+"
        BotonMas.Parent = Pantalla

        -- Botón - Velocidad
        local BotonMenos = BotonMas:Clone()
        BotonMenos.Position = UDim2.new(0.08, 0, 0.4, 0)
        BotonMenos.Text = "-"
        BotonMenos.Parent = Pantalla

        -- Etiqueta velocidad
        local EtiquetaVel = Instance.new("TextLabel")
        EtiquetaVel.Size = UDim2.new(0, 120, 0, 30)
        EtiquetaVel.Position = UDim2.new(0.02, 0, 0.48, 0)
        EtiquetaVel.BackgroundTransparency = 1
        EtiquetaVel.Text = "Vel: "..Config.Velocidad
        EtiquetaVel.TextColor3 = Color3.new(1,1,1)
        EtiquetaVel.Font = Enum.Font.GothamBold
        EtiquetaVel.TextSize = 14
        EtiquetaVel.Parent = Pantalla

        -- Actualizar interfaz
        local function ActualizarUI()
            BotonVuelo.Text = Config.FlyActivo and "Vuelo: ON" or "Vuelo: OFF"
            BotonVuelo.BackgroundColor3 = Config.FlyActivo and Color3.new(0.2, 0.8, 0.3) or Color3.new(0.2, 0.6, 1)
            BotonNoclip.Text = Config.NoclipActivo and "Noclip: ON" or "Noclip: OFF"
            BotonNoclip.BackgroundColor3 = Config.NoclipActivo and Color3.new(0.8, 0.2, 0.3) or Color3.new(0.2, 0.6, 1)
            EtiquetaVel.Text = "Vel: "..Config.Velocidad
        end

        -- Conexiones de botones
        BotonVuelo.MouseButton1Click:Connect(function() AlternarVuelo() ActualizarUI() end)
        BotonNoclip.MouseButton1Click:Connect(function() AlternarNoclip() ActualizarUI() end)
        BotonMas.MouseButton1Click:Connect(function() CambiarVelocidad(10) ActualizarUI() end)
        BotonMenos.MouseButton1Click:Connect(function() CambiarVelocidad(-10) ActualizarUI() end)
    end
end

-- Función: Activar / Desactivar vuelo
function AlternarVuelo()
    Config.FlyActivo = not Config.FlyActivo
    if Config.FlyActivo then
        CuerpoVelocidad.Parent = RootPart
        Humanoid.PlatformStand = true
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
    else
        CuerpoVelocidad.Parent = nil
        Humanoid.PlatformStand = false
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
        CuerpoVelocidad.Velocity = Vector3.new(0,0,0)
    end
end

-- Función: Activar / Desactivar Noclip
function AlternarNoclip()
    Config.NoclipActivo = not Config.NoclipActivo
end

-- Función: Cambiar velocidad
function CambiarVelocidad(cantidad)
    Config.Velocidad = math.clamp(Config.Velocidad + cantidad, Config.VelocidadMin, Config.VelocidadMax)
end

-- Función: Aplicar Noclip
local function AplicarNoclip()
    if Config.NoclipActivo and Humanoid then
        Humanoid.CanCollide = false
        for _, parte in ipairs(Character:GetChildren()) do
            if parte:IsA("BasePart") then
                parte.CanCollide = false
            end
        end
    elseif not Config.NoclipActivo and Humanoid then
        Humanoid.CanCollide = true
    end
end

-- Función: Actualizar movimiento
local function ActualizarMovimiento()
    if not Config.FlyActivo then return end

    local Camara = workspace.CurrentCamera
    local Direccion = Vector3.new()

    -- Entrada teclado
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then Direccion += Camara.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then Direccion -= Camara.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then Direccion -= Camara.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then Direccion += Camara.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then Direccion += Vector3.new(0,1,0) end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then Direccion -= Vector3.new(0,1,0) end

    -- Normalizar y aplicar
    if Direccion.Magnitude > 0 then
        Direccion = Direccion.Unit * Config.Velocidad
    end
    CuerpoVelocidad.Velocity = Direccion
end

-- Conexión de teclas para PC
UserInputService.InputBegan:Connect(function(entrada, procesado)
    if procesado then return end
    if entrada.KeyCode == Enum.KeyCode.F then AlternarVuelo() end
    if entrada.KeyCode == Enum.KeyCode.N then AlternarNoclip() end
    if entrada.KeyCode == Enum.KeyCode.Equals then CambiarVelocidad(10) end
    if entrada.KeyCode == Enum.KeyCode.Minus then CambiarVelocidad(-10) end
end)

-- Ejecución continua
RunService.RenderStepped:Connect(function()
    ActualizarMovimiento()
    AplicarNoclip()
end)

-- Crear interfaz al iniciar
CrearInterfaz()

-- Mensaje de inicio
print("✅ JoseAngel_Blox Fly v1.2 cargado correctamente")
print("ℹ️ Recuerda: Uso permitido solo en juegos propios o autorizados")
