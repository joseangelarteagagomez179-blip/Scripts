--[[
╔════════════════════════════════════════════════════════╗
║              🚀 JoseAngel_Blox Fly v1.2                ║
╠════════════════════════════════════════════════════════╣
║  📌 Creador:      JoseAngel_Blox                       ║
║  📅 Lanzamiento:  06/07/2026                           ║
║  📋 Versión:      1.2                                   ║
╚════════════════════════════════════════════════════════╝

📖 MANUAL DE USO
────────────────────────────────────────────────────────
¡Bienvenidos y bienvenidas al script JoseAngel_Blox Fly! ✨
Este script te permite volar libremente, atravesar paredes (noclip)
y ajustar la velocidad a tu gusto. Funciona en cualquier dispositivo.

🖥️ USO EN PC:
• Activar/Desactivar vuelo: Tecla F
• Aumentar velocidad: Tecla Flecha Arriba
• Disminuir velocidad: Tecla Flecha Abajo
• Moverte: Teclas W A S D
• Subir: Espacio | Bajar: Tecla Control

📱 USO EN MÓVIL:
• Activar/Desactivar vuelo: Botón en pantalla
• Aumentar velocidad: Botón +
• Disminuir velocidad: Botón -
• Moverte: Joystick de tu pantalla
• Subir/Bajar: Botones de dirección vertical en pantalla
────────────────────────────────────────────────────────
]]

-- ⚙️ SERVICIOS
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

-- 🧑‍🦱 JUGADOR Y PERSONAJE
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- 🎚️ VARIABLES PRINCIPALES
local FlyEnabled = false
local NoclipEnabled = true
local FlySpeed = 50
local BaseSpeed = 50
local MaxSpeed = 300
local MinSpeed = 10
local FlyGyro = nil
local FlyBodyVelocity = nil

-- 🖥️ DETECTAR DISPOSITIVO
local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- 🚀 FUNCIÓN: ACTIVAR / DESACTIVAR VUELO
local function ToggleFly()
    FlyEnabled = not FlyEnabled

    if FlyEnabled then
        -- Crear efectos de movimiento
        FlyGyro = Instance.new("Gyro")
        FlyBodyVelocity = Instance.new("BodyVelocity")

        FlyGyro.Name = "FlyGyro"
        FlyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
        FlyGyro.P = 10000
        FlyGyro.D = 100
        FlyGyro.CFrame = RootPart.CFrame
        FlyGyro.Parent = RootPart

        FlyBodyVelocity.Name = "FlyVelocity"
        FlyBodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
        FlyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
        FlyBodyVelocity.Parent = RootPart

        Humanoid.PlatformStand = true
        print("✅ Vuelo ACTIVADO")
    else
        -- Eliminar efectos
        if FlyGyro then FlyGyro:Destroy() end
        if FlyBodyVelocity then FlyBodyVelocity:Destroy() end
        Humanoid.PlatformStand = false
        Humanoid.Sit = false
        print("❌ Vuelo DESACTIVADO")
    end
end

-- 🚫 FUNCIÓN: NOCLIP (atravesar objetos)
local function UpdateNoclip()
    if NoclipEnabled and FlyEnabled then
        for _, Part in ipairs(Character:GetDescendants()) do
            if Part:IsA("BasePart") then
                Part.CanCollide = false
            end
        end
    end
end

-- ➡️ FUNCIÓN: ACTUALIZAR MOVIMIENTO Y VELOCIDAD
local function UpdateFly()
    if not FlyEnabled or not FlyGyro or not FlyBodyVelocity then return end

    local Camera = workspace.CurrentCamera
    local Direction = Vector3.new(0, 0, 0)

    -- Obtener dirección de movimiento
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then Direction += Camera.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then Direction -= Camera.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then Direction -= Camera.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then Direction += Camera.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then Direction += Vector3.new(0, 1, 0) end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then Direction -= Vector3.new(0, 1, 0) end

    -- Normalizar dirección
    if Direction.Magnitude > 0 then
        Direction = Direction.Unit
    end

    -- Aplicar movimiento
    FlyGyro.CFrame = Camera.CFrame
    FlyBodyVelocity.Velocity = Direction * FlySpeed
end

-- ⌨️ CONTROLES PC
if not IsMobile then
    UserInputService.InputBegan:Connect(function(Input, Processed)
        if Processed then return end
        if Input.KeyCode == Enum.KeyCode.F then
            ToggleFly()
        elseif Input.KeyCode == Enum.KeyCode.Up then
            FlySpeed = math.min(FlySpeed + 10, MaxSpeed)
            print("⚡ Velocidad: " .. FlySpeed)
        elseif Input.KeyCode == Enum.KeyCode.Down then
            FlySpeed = math.max(FlySpeed - 10, MinSpeed)
            print("🐢 Velocidad: " .. FlySpeed)
        end
    end)
end

-- 📱 INTERFAZ Y CONTROLES MÓVIL
if IsMobile then
    -- Crear botones en pantalla
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "JoseAngel_Blox_Fly_UI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local ButtonFly = Instance.new("TextButton")
    ButtonFly.Size = UDim2.new(0, 80, 0, 80)
    ButtonFly.Position = UDim2.new(0.05, 0, 0.5, -40)
    ButtonFly.BackgroundColor3 = Color3.new(0.1, 0.6, 1)
    ButtonFly.TextColor3 = Color3.new(1, 1, 1)
    ButtonFly.Font = Enum.Font.GothamBold
    ButtonFly.Text = "VOLAR"
    ButtonFly.TextSize = 18
    ButtonFly.BorderSizePixel = 0
    ButtonFly.Parent = ScreenGui

    local ButtonSpeedUp = Instance.new("TextButton")
    ButtonSpeedUp.Size = UDim2.new(0, 60, 0, 60)
    ButtonSpeedUp.Position = UDim2.new(0.05, 0, 0.62, 0)
    ButtonSpeedUp.BackgroundColor3 = Color3.new(0.2, 0.8, 0.2)
    ButtonSpeedUp.TextColor3 = Color3.new(1, 1, 1)
    ButtonSpeedUp.Font = Enum.Font.GothamBold
    ButtonSpeedUp.Text = "+"
    ButtonSpeedUp.TextSize = 24
    ButtonSpeedUp.BorderSizePixel = 0
    ButtonSpeedUp.Parent = ScreenGui

    local ButtonSpeedDown = Instance.new("TextButton")
    ButtonSpeedDown.Size = UDim2.new(0, 60, 0, 60)
    ButtonSpeedDown.Position = UDim2.new(0.05, 0, 0.73, 0)
    ButtonSpeedDown.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
    ButtonSpeedDown.TextColor3 = Color3.new(1, 1, 1)
    ButtonSpeedDown.Font = Enum.Font.GothamBold
    ButtonSpeedDown.Text = "-"
    ButtonSpeedDown.TextSize = 24
    ButtonSpeedDown.BorderSizePixel = 0
    ButtonSpeedDown.Parent = ScreenGui

    local SpeedLabel = Instance.new("TextLabel")
    SpeedLabel.Size = UDim2.new(0, 100, 0, 30)
    SpeedLabel.Position = UDim2.new(0.05, 0, 0.85, 0)
    SpeedLabel.BackgroundTransparency = 1
    SpeedLabel.TextColor3 = Color3.new(1, 1, 1)
    SpeedLabel.Font = Enum.Font.Gotham
    SpeedLabel.Text = "Vel: " .. FlySpeed
    SpeedLabel.TextSize = 16
    SpeedLabel.Parent = ScreenGui

    -- Funciones de botones
    ButtonFly.MouseButton1Click:Connect(function()
        ToggleFly()
        ButtonFly.Text = FlyEnabled and "✓ ACTIVO" or "VOLAR"
        ButtonFly.BackgroundColor3 = FlyEnabled and Color3.new(0.2, 0.8, 0.2) or Color3.new(0.1, 0.6, 1)
    end)

    ButtonSpeedUp.MouseButton1Click:Connect(function()
        FlySpeed = math.min(FlySpeed + 10, MaxSpeed)
        SpeedLabel.Text = "Vel: " .. FlySpeed
    end)

    ButtonSpeedDown.MouseButton1Click:Connect(function()
        FlySpeed = math.max(FlySpeed - 10, MinSpeed)
        SpeedLabel.Text = "Vel: " .. FlySpeed
    end)
end

-- 🔄 ACTUALIZACIÓN CONTINUA
RunService.Heartbeat:Connect(function()
    UpdateNoclip()
    UpdateFly()
end)

-- 🔁 RECONSTRUIR SI EL PERSONAJE RENACE
LocalPlayer.CharacterAdded:Connect(function(NuevoPersonaje)
    Character = NuevoPersonaje
    Humanoid = Character:WaitForChild("Humanoid")
    RootPart = Character:WaitForChild("HumanoidRootPart")
    FlyEnabled = false
end)

print("✅ JoseAngel_Blox Fly v1.2 cargado correctamente")
