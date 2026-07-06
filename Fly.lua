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
Con esta herramienta podrás volar libremente, atravesar paredes (noclip)
y cambiar la velocidad de vuelo a tu gusto. Funciona en casi cualquier
juego de Roblox y es compatible con PC y dispositivos móviles.

🖥️ USO EN PC:
• Activar/Desactivar vuelo: Tecla F
• Aumentar velocidad: Flecha Arriba
• Disminuir velocidad: Flecha Abajo
• Moverte: Teclas W A S D
• Subir: Espacio | Bajar: Control Izquierdo

📱 USO EN MÓVIL:
• Activar/Desactivar vuelo: Botón principal "VOLAR"
• Aumentar velocidad: Botón "+"
• Disminuir velocidad: Botón "-"
• Moverte: Joystick de tu pantalla
• Subir/Bajar: Inclinación o controles de movimiento
────────────────────────────────────────────────────────
]]

-- ⚙️ SERVICIOS
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- 🧑‍🦱 JUGADOR Y PERSONAJE
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- ⚙️ CONFIGURACIÓN
local FlyEnabled = false
local NoclipEnabled = true
local FlySpeed = 50
local MaxSpeed = 300
local MinSpeed = 10
local FlyGyro = nil
local FlyVelocity = nil
local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- 🚀 ACTIVAR / DESACTIVAR VUELO
local function ToggleFly()
    FlyEnabled = not FlyEnabled

    if FlyEnabled then
        FlyGyro = Instance.new("Gyro")
        FlyGyro.MaxTorque = Vector3.new(9e4, 9e4, 9e4)
        FlyGyro.P = 12000
        FlyGyro.D = 200
        FlyGyro.CFrame = RootPart.CFrame
        FlyGyro.Parent = RootPart

        FlyVelocity = Instance.new("BodyVelocity")
        FlyVelocity.MaxForce = Vector3.new(9e4, 9e4, 9e4)
        FlyVelocity.Velocity = Vector3.new(0, 0, 0)
        FlyVelocity.Parent = RootPart

        Humanoid.PlatformStand = true
        print("[✅] Vuelo activado")
    else
        if FlyGyro then FlyGyro:Destroy() end
        if FlyVelocity then FlyVelocity:Destroy() end
        Humanoid.PlatformStand = false
        Humanoid.Sit = false
        print("[❌] Vuelo desactivado")
    end
end

-- 🚫 FUNCIÓN NOCLIP
local function UpdateNoclip()
    if FlyEnabled and NoclipEnabled then
        for _, v in ipairs(Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end

-- ➡️ ACTUALIZAR MOVIMIENTO
local function UpdateFly()
    if not FlyEnabled or not FlyGyro or not FlyVelocity then return end

    local Cam = workspace.CurrentCamera
    local dir = Vector3.new()

    if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += Cam.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= Cam.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= Cam.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += Cam.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0, 1, 0) end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.new(0, 1, 0) end

    if dir.Magnitude > 0 then dir = dir.Unit end

    FlyGyro.CFrame = Cam.CFrame
    FlyVelocity.Velocity = dir * FlySpeed
end

-- ⌨️ CONTROLES PC
if not IsMobile then
    UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == Enum.KeyCode.F then
            ToggleFly()
        elseif input.KeyCode == Enum.KeyCode.Up then
            FlySpeed = math.min(FlySpeed + 10, MaxSpeed)
            print("[⚡] Velocidad: "..FlySpeed)
        elseif input.KeyCode == Enum.KeyCode.Down then
            FlySpeed = math.max(FlySpeed - 10, MinSpeed)
            print("[🐢] Velocidad: "..FlySpeed)
        end
    end)
end

-- 📱 INTERFAZ MÓVIL PROFESIONAL Y LIMPIA
if IsMobile then
    local UI = Instance.new("ScreenGui")
    UI.Name = "JoseAngel_Blox_Fly"
    UI.ResetOnSpawn = false
    UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    UI.Parent = LocalPlayer:WaitForChild("PlayerGui")

    -- Contenedor principal
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 120, 0, 160)
    MainFrame.Position = UDim2.new(0.02, 0, 0.4, 0)
    MainFrame.BackgroundColor3 = Color3.new(0.12, 0.12, 0.15)
    MainFrame.BorderSizePixel = 0
    MainFrame.BackgroundTransparency = 0.1
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = UI

    -- Esquinas redondeadas
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0.12, 0)
    UICorner.Parent = MainFrame

    -- Título
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.BackgroundTransparency = 1
    Title.Text = "FLY v1.2"
    Title.Font = Enum.Font.GothamBold
    Title.TextColor3 = Color3.new(1,1,1)
    Title.TextSize = 14
    Title.Parent = MainFrame

    -- Botón Volar
    local BtnFly = Instance.new("TextButton")
    BtnFly.Size = UDim2.new(0.8, 0, 0, 45)
    BtnFly.Position = UDim2.new(0.1, 0, 0.25, 0)
    BtnFly.BackgroundColor3 = Color3.new(0.15, 0.45, 0.8)
    BtnFly.Text = "VOLAR"
    BtnFly.Font = Enum.Font.GothamBold
    BtnFly.TextColor3 = Color3.new(1,1,1)
    BtnFly.TextSize = 16
    Instance.new("UICorner", BtnFly).CornerRadius = UDim.new(0.15, 0)
    BtnFly.Parent = MainFrame

    -- Botón Velocidad +
    local BtnUp = Instance.new("TextButton")
    BtnUp.Size = UDim2.new(0.35, 0, 0, 35)
    BtnUp.Position = UDim2.new(0.1, 0, 0.6, 0)
    BtnUp.BackgroundColor3 = Color3.new(0.2, 0.7, 0.3)
    BtnUp.Text = "+"
    BtnUp.Font = Enum.Font.GothamBold
    BtnUp.TextColor3 = Color3.new(1,1,1)
    BtnUp.TextSize = 20
    Instance.new("UICorner", BtnUp).CornerRadius = UDim.new(0.2, 0)
    BtnUp.Parent = MainFrame

    -- Botón Velocidad -
    local BtnDown = Instance.new("TextButton")
    BtnDown.Size = UDim2.new(0.35, 0, 0, 35)
    BtnDown.Position = UDim2.new(0.55, 0, 0.6, 0)
    BtnDown.BackgroundColor3 = Color3.new(0.7, 0.2, 0.2)
    BtnDown.Text = "-"
    BtnDown.Font = Enum.Font.GothamBold
    BtnDown.TextColor3 = Color3.new(1,1,1)
    BtnDown.TextSize = 20
    Instance.new("UICorner", BtnDown).CornerRadius = UDim.new(0.2, 0)
    BtnDown.Parent = MainFrame

    -- Etiqueta velocidad
    local SpeedLabel = Instance.new("TextLabel")
    SpeedLabel.Size = UDim2.new(1, 0, 0, 25)
    SpeedLabel.Position = UDim2.new(0, 0, 0.85, 0)
    SpeedLabel.BackgroundTransparency = 1
    SpeedLabel.Text = "Vel: "..FlySpeed
    SpeedLabel.Font = Enum.Font.Gotham
    SpeedLabel.TextColor3 = Color3.new(0.9,0.9,0.9)
    SpeedLabel.TextSize = 14
    SpeedLabel.Parent = MainFrame

    -- Funciones de botones
    BtnFly.MouseButton1Click:Connect(function()
        ToggleFly()
        BtnFly.Text = FlyEnabled and "ACTIVO" or "VOLAR"
        BtnFly.BackgroundColor3 = FlyEnabled and Color3.new(0.2, 0.7, 0.3) or Color3.new(0.15, 0.45, 0.8)
    end)

    BtnUp.MouseButton1Click:Connect(function()
        FlySpeed = math.min(FlySpeed + 10, MaxSpeed)
        SpeedLabel.Text = "Vel: "..FlySpeed
    end)

    BtnDown.MouseButton1Click:Connect(function()
        FlySpeed = math.max(FlySpeed - 10, MinSpeed)
        SpeedLabel.Text = "Vel: "..FlySpeed
    end)
end

-- 🔄 ACTUALIZACIÓN CONSTANTE
RunService.Heartbeat:Connect(function()
    UpdateNoclip()
    UpdateFly()
end)

-- 🔁 RECONFIGURAR AL RENACER
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = Character:WaitForChild("Humanoid")
    RootPart = Character:WaitForChild("HumanoidRootPart")
    FlyEnabled = false
end)

print("✅ JoseAngel_Blox Fly v1.2 cargado con éxito")
