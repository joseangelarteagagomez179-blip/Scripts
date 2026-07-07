--[[
    Nombre: JoseAngel_Blox Fly
    Versión: 1.2
    Fecha: 06/07/2026
    Creador: JoseAngel_Blox
    Funciona en: PC y Celular
]]

-- Servicios
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Variables principales
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid", 10)
local RootPart = Character:WaitForChild("HumanoidRootPart", 10)

-- ⚙️ Configuración
local Config = {
    Activo = false,
    Velocidad = 80,
    VelocidadMin = 20,
    VelocidadMax = 300,
    TeclaActivar = Enum.KeyCode.E
}

-- Variables internas
local ConexionVuelo = nil
local GravedadOriginal = true
local UI = {}

-- 🔄 Actualizar personaje si renace
LocalPlayer.CharacterAdded:Connect(function(NuevoPersonaje)
    Character = NuevoPersonaje
    Humanoid = Character:WaitForChild("Humanoid", 10)
    RootPart = Character:WaitForChild("HumanoidRootPart", 10)
    DesactivarVuelo()
end)

-- ✅ Activar vuelo
function ActivarVuelo()
    if Config.Activo then return end
    Config.Activo = true

    GravedadOriginal = Humanoid.UseGravity
    Humanoid.UseGravity = false
    Humanoid.PlatformStand = true

    ConexionVuelo = RunService.RenderStepped:Connect(function()
        if not RootPart or Humanoid.Health <= 0 then
            DesactivarVuelo()
            return
        end

        local Camara = workspace.CurrentCamera
        local Direccion = Vector3.new()

        -- Controles PC
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then Direccion += Camara.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then Direccion -= Camara.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then Direccion -= Camara.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then Direccion += Camara.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then Direccion += Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then Direccion -= Vector3.new(0, 1, 0) end

        -- Controles Móvil
        local Movimiento = Humanoid.MoveDirection
        if Movimiento.Magnitude > 0 then
            local Relativo = Camara.CFrame:VectorToWorldSpace(Movimiento)
            Direccion += Vector3.new(Relativo.X, 0, Relativo.Z).Unit
        end

        -- Aplicar movimiento
        if Direccion.Magnitude > 0 then
            Direccion = Direccion.Unit * Config.Velocidad
            RootPart.Velocity = Direccion
        else
            RootPart.Velocity = Vector3.new(0, 0, 0)
        end

        -- ✨ Noclip
        for _, Parte in ipairs(Character:GetDescendants()) do
            if Parte:IsA("BasePart") then
                Parte.CanCollide = false
            end
        end
    end)

    if UI.BotonPrincipal then
        UI.BotonPrincipal.Text = "VUELO: ACTIVO\nVel: "..Config.Velocidad
    end
end

-- ❌ Desactivar vuelo
function DesactivarVuelo()
    if not Config.Activo then return end
    Config.Activo = false

    Humanoid.UseGravity = GravedadOriginal
    Humanoid.PlatformStand = false
    RootPart.Velocity = Vector3.new(0, 0, 0)

    -- Restaurar colisiones
    for _, Parte in ipairs(Character:GetDescendants()) do
        if Parte:IsA("BasePart") then
            Parte.CanCollide = true
        end
    end

    if ConexionVuelo then
        ConexionVuelo:Disconnect()
        ConexionVuelo = nil
    end

    if UI.BotonPrincipal then
        UI.BotonPrincipal.Text = "VUELO: INACTIVO\nVel: "..Config.Velocidad
    end
end

-- 🎚️ Cambiar velocidad
function CambiarVelocidad(aumentar)
    if aumentar then
        Config.Velocidad = math.min(Config.Velocidad + 20, Config.VelocidadMax)
    else
        Config.Velocidad = math.max(Config.Velocidad - 20, Config.VelocidadMin)
    end
    if UI.BotonPrincipal then
        UI.BotonPrincipal.Text = (Config.Activo and "VUELO: ACTIVO" or "VUELO: INACTIVO").."\nVel: "..Config.Velocidad
    end
end

-- ℹ️ Ventana de información
function MostrarInfo()
    UI.VentanaInfo.Visible = not UI.VentanaInfo.Visible
end

-- 📱 Crear interfaz
local function CrearInterfaz()
    local Pantalla = LocalPlayer:WaitForChild("PlayerGui", 10)
    if not Pantalla then return end

    local GUI = Instance.new("ScreenGui")
    GUI.Name = "JoseAngel_Blox_Fly_v1.2"
    GUI.ResetOnSpawn = false
    GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    GUI.Parent = Pantalla

    -- Botón Principal
    UI.BotonPrincipal = Instance.new("TextButton")
    UI.BotonPrincipal.Size = UDim2.new(0, 130, 0, 65)
    UI.BotonPrincipal.Position = UDim2.new(0.02, 0, 0.72, 0)
    UI.BotonPrincipal.BackgroundColor3 = Color3.new(0.1, 0.55, 0.9)
    UI.BotonPrincipal.TextColor3 = Color3.new(1, 1, 1)
    UI.BotonPrincipal.Font = Enum.Font.GothamBold
    UI.BotonPrincipal.TextSize = 14
    UI.BotonPrincipal.Text = "VUELO: INACTIVO\nVel: "..Config.Velocidad
    UI.BotonPrincipal.Parent = GUI

    -- Botón + Velocidad
    local BotonMas = Instance.new("TextButton")
    BotonMas.Size = UDim2.new(0, 50, 0, 50)
    BotonMas.Position = UDim2.new(0.16, 0, 0.63, 0)
    BotonMas.BackgroundColor3 = Color3.new(0.2, 0.75, 0.2)
    BotonMas.TextColor3 = Color3.new(1, 1, 1)
    BotonMas.Font = Enum.Font.GothamBold
    BotonMas.TextSize = 24
    BotonMas.Text = "+"
    BotonMas.Parent = GUI

    -- Botón - Velocidad
    local BotonMenos = Instance.new("TextButton")
    BotonMenos.Size = UDim2.new(0, 50, 0, 50)
    BotonMenos.Position = UDim2.new(0.02, 0, 0.63, 0)
    BotonMenos.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
    BotonMenos.TextColor3 = Color3.new(1, 1, 1)
    BotonMenos.Font = Enum.Font.GothamBold
    BotonMenos.TextSize = 24
    BotonMenos.Text = "-"
    BotonMenos.Parent = GUI

    -- Botón INFO
    local BotonInfo = Instance.new("TextButton")
    BotonInfo.Size = UDim2.new(0, 85, 0, 45)
    BotonInfo.Position = UDim2.new(0.02, 0, 0.55, 0)
    BotonInfo.BackgroundColor3 = Color3.new(0.9, 0.6, 0.1)
    BotonInfo.TextColor3 = Color3.new(1, 1, 1)
    BotonInfo.Font = Enum.Font.GothamBold
    BotonInfo.TextSize = 16
    BotonInfo.Text = "INFO"
    BotonInfo.Parent = GUI

    -- Ventana de información
    UI.VentanaInfo = Instance.new("Frame")
    UI.VentanaInfo.Size = UDim2.new(0, 300, 0, 420)
    UI.VentanaInfo.Position = UDim2.new(0.5, -150, 0.5, -210)
    UI.VentanaInfo.BackgroundColor3 = Color3.new(0.12, 0.12, 0.15)
    UI.VentanaInfo.BorderSizePixel = 2
    UI.VentanaInfo.BorderColor3 = Color3.new(0.9, 0.9, 0.9)
    UI.VentanaInfo.Visible = false
    UI.VentanaInfo.Parent = GUI

    -- Texto de información
    local TextoInfo = Instance.new("TextLabel")
    TextoInfo.Size = UDim2.new(1, -20, 1, -40)
    TextoInfo.Position = UDim2.new(0, 10, 0, 10)
    TextoInfo.BackgroundTransparency = 1
    TextoInfo.TextColor3 = Color3.new(1, 1, 1)
    TextoInfo.Font = Enum.Font.Gotham
    TextoInfo.TextSize = 13
    TextoInfo.TextWrapped = true
    TextoInfo.TextXAlignment = Enum.TextXAlignment.Left
    TextoInfo.TextYAlignment = Enum.TextYAlignment.Top
    TextoInfo.Text = [[
📋 INFORMACIÓN DEL SCRIPT

👤 Creador: JoseAngel_Blox
📅 Lanzamiento: 06/07/2026
🔖 Versión: 1.2

────────────────────
📖 MANUAL DE USO

🖥️ PC:
• E → Activar/Desactivar
• WASD → Moverse
• Espacio → Subir
• Ctrl Izq → Bajar
• Flechas ↑↓ → Cambiar velocidad

📱 CELULAR:
• Botón VUELO → Activar/Desactivar
• Joystick → Moverte
• Botones + / - → Velocidad
• Noclip automático al volar

⚠️ ADVERTENCIA:
Úsalo bajo tu propia responsabilidad. Puede incumplir reglas de Roblox.
]]
    TextoInfo.Parent = UI.VentanaInfo

    -- Botón cerrar
    local BotonCerrar = Instance.new("TextButton")
    BotonCerrar.Size = UDim2.new(0, 30, 0, 30)
    BotonCerrar.Position = UDim2.new(1, -35, 0, 5)
    BotonCerrar.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
    BotonCerrar.TextColor3 = Color3.new(1, 1, 1)
    BotonCerrar.Font = Enum.Font.GothamBold
    BotonCerrar.Text = "X"
    BotonCerrar.Parent = UI.VentanaInfo

    -- Conexiones
    UI.BotonPrincipal.MouseButton1Click:Connect(function() Config.Activo = not Config.Activo; if Config.Activo then ActivarVuelo() else DesactivarVuelo() end end)
    UI.BotonPrincipal.TouchTap:Connect(function() Config.Activo = not Config.Activo; if Config.Activo then ActivarVuelo() else DesactivarVuelo() end end)

    BotonMas.MouseButton1Click:Connect(function() CambiarVelocidad(true) end)
    BotonMas.TouchTap:Connect(function() CambiarVelocidad(true) end)

    BotonMenos.MouseButton1Click:Connect(function() CambiarVelocidad(false) end)
    BotonMenos.TouchTap:Connect(function() CambiarVelocidad(false) end)

    BotonInfo.MouseButton1Click:Connect(MostrarInfo)
    BotonInfo.TouchTap:Connect(MostrarInfo)

    BotonCerrar.MouseButton1Click:Connect(function() UI.VentanaInfo.Visible = false end)
    BotonCerrar.TouchTap:Connect(function() UI.VentanaInfo.Visible = false end)
end

-- Controles de teclado PC
UserInputService.InputBegan:Connect(function(Entrada, Procesado)
    if Procesado then return end
    if Entrada.KeyCode == Config.TeclaActivar then
        Config.Activo = not Config.Activo
        if Config.Activo then ActivarVuelo() else DesactivarVuelo() end
    elseif Entrada.KeyCode == Enum.KeyCode.Up then
        CambiarVelocidad(true)
    elseif Entrada.KeyCode == Enum.KeyCode.Down then
        CambiarVelocidad(false)
    end
end)

-- Ejecutar todo
CrearInterfaz()
print("✅ JoseAngel_Blox Fly v1.2 CARGADO CORRECTAMENTE")
