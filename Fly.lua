--[[
╔════════════════════════════════════════╗
║        JOSEANGEL_BLOX FLY v1.2         ║
╠════════════════════════════════════════╣
║  Creador: JoseAngel_Blox               ║
║  Fecha: 06/07/2026                     ║
║  Versión: 1.2                          ║
╚════════════════════════════════════════╝
]]

-- Servicios necesarios
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Jugador y personaje
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Variables de control
local FlyEnabled = false
local NoClipEnabled = false
local FlySpeed = 50
local FlyConnection = nil
local NoclipConnection = nil
local Arrastrando = false
local InicioPosicion = nil
local InicioToque = nil
local VentanaVisible = true

-- ==============================================
-- CREACIÓN DE INTERFAZ
-- ==============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_BloxFly"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Marco principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 380)
MainFrame.Position = UDim2.new(0.02, 0, 0.1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Parent = ScreenGui

-- Esquinas redondeadas
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Borde
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(60, 60, 80)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Barra superior para mover
local BarraMover = Instance.new("TextLabel")
BarraMover.Size = UDim2.new(1, -40, 0, 50)
BarraMover.Position = UDim2.new(0, 0, 0, 0)
BarraMover.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
BarraMover.Text = "🖱️ JoseAngel_Blox Fly v1.2"
BarraMover.TextColor3 = Color3.fromRGB(255, 215, 0)
BarraMover.Font = Enum.Font.GothamBold
BarraMover.TextSize = 18
BarraMover.TextXAlignment = Enum.TextXAlignment.Center
BarraMover.Parent = MainFrame
Instance.new("UICorner", BarraMover).CornerRadius = UDim.new(0, 10)

-- Botón para ocultar/mostrar
local BtnOcultar = Instance.new("TextButton")
BtnOcultar.Size = UDim2.new(0, 40, 0, 50)
BtnOcultar.Position = UDim2.new(1, -40, 0, 0)
BtnOcultar.BackgroundColor3 = Color3.fromRGB(80, 30, 30)
BtnOcultar.Text = "−"
BtnOcultar.TextColor3 = Color3.new(1,1,1)
BtnOcultar.Font = Enum.Font.GothamBold
BtnOcultar.TextSize = 22
BtnOcultar.Parent = MainFrame
Instance.new("UICorner", BtnOcultar).CornerRadius = UDim.new(0, 10)

-- ==============================================
-- SISTEMA PARA MOVER LA VENTANA
-- ==============================================
BarraMover.InputBegan:Connect(function(entrada)
    if entrada.UserInputType == Enum.UserInputType.MouseButton1 or entrada.UserInputType == Enum.UserInputType.Touch then
        Arrastrando = true
        InicioPosicion = MainFrame.Position
        InicioToque = entrada.Position
    end
end)

BarraMover.InputChanged:Connect(function(entrada)
    if Arrastrando and (entrada.UserInputType == Enum.UserInputType.MouseMovement or entrada.UserInputType == Enum.UserInputType.Touch) then
        local Cambio = entrada.Position - InicioToque
        MainFrame.Position = UDim2.new(
            InicioPosicion.X.Scale,
            InicioPosicion.X.Offset + Cambio.X,
            InicioPosicion.Y.Scale,
            InicioPosicion.Y.Offset + Cambio.Y
        )
    end
end)

BarraMover.InputEnded:Connect(function()
    Arrastrando = false
end)

-- ==============================================
-- FUNCIÓN OCULTAR / MOSTRAR
-- ==============================================
BtnOcultar.MouseButton1Click:Connect(function()
    VentanaVisible = not VentanaVisible
    -- Ocultar o mostrar todo el contenido
    for _, hijo in ipairs(MainFrame:GetChildren()) do
        if hijo ~= BarraMover and hijo ~= BtnOcultar then
            hijo.Visible = VentanaVisible
        end
    end
    BtnOcultar.Text = VentanaVisible and "−" or "+"
    BtnOcultar.BackgroundColor3 = VentanaVisible and Color3.fromRGB(80, 30, 30) or Color3.fromRGB(30, 80, 50)
    -- Reducir tamaño cuando está oculta
    MainFrame.Size = VentanaVisible and UDim2.new(0, 300, 0, 380) or UDim2.new(0, 300, 0, 50)
end)

-- ==============================================
-- SECCIÓN INFORMACIÓN Y MANUAL
-- ==============================================
local InfoLabel = Instance.new("TextLabel")
InfoLabel.Size = UDim2.new(1, -20, 0, 120)
InfoLabel.Position = UDim2.new(0, 10, 0, 60)
InfoLabel.BackgroundTransparency = 0.9
InfoLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.TextSize = 14
InfoLabel.TextWrapped = true
InfoLabel.Text = [[📋 INFORMACIÓN
Creador: JoseAngel_Blox
Fecha: 06/07/2026
Versión: 1.2

📖 MANUAL DE USO
¡Bienvenidos y bienvenidas al script JoseAngel_Blox Fly!

✅ PC:
- Activar/Desactivar: Botón
- Mover: W A S D
- Subir: Espacio | Bajar: Ctrl Izq
- Velocidad: Botones + / −

✅ MÓVIL:
- Activar/Desactivar: Botón
- Mover: Joystick del juego
- Subir/Bajar: Automático
- Velocidad: Botones en pantalla

Compatible con cualquier juego y dispositivo.]]
InfoLabel.Parent = MainFrame

-- ==============================================
-- FUNCIÓN NOCLIP
-- ==============================================
local function ToggleNoClip(estado)
    NoClipEnabled = estado
    if NoclipConnection then NoclipConnection:Disconnect() end
    if estado then
        NoclipConnection = RunService.Stepped:Connect(function()
            if Character and Humanoid and Humanoid.Health > 0 then
                for _, parte in ipairs(Character:GetChildren()) do
                    if parte:IsA("BasePart") then
                        parte.CanCollide = false
                    end
                end
            end
        end)
    end
end

-- ==============================================
-- FUNCIÓN VUELO
-- ==============================================
local function ToggleFly(estado)
    FlyEnabled = estado
    if FlyConnection then FlyConnection:Disconnect() end
    ToggleNoClip(estado)

    if estado then
        Humanoid.PlatformStand = true
        RootPart.Velocity = Vector3.new(0, 0, 0)

        FlyConnection = RunService.RenderStepped:Connect(function()
            if not FlyEnabled or not Character or Humanoid.Health <= 0 then return end

            local camara = workspace.CurrentCamera
            local direccion = Vector3.new(0, 0, 0)

            -- Controles PC
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then direccion += camara.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then direccion -= camara.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then direccion -= camara.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then direccion += camara.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direccion += Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then direccion -= Vector3.new(0, 1, 0) end

            -- Controles Móvil
            local movimiento = Humanoid.MoveDirection
            if movimiento.Magnitude > 0 then
                direccion = camara.CFrame:VectorToWorldSpace(Vector3.new(movimiento.X, 0, movimiento.Z))
            end

            -- Aplicar velocidad
            if direccion.Magnitude > 0 then
                direccion = direccion.Unit * FlySpeed
                RootPart.Velocity = direccion
            else
                RootPart.Velocity = Vector3.new(0, 0, 0)
            end
        end)
    else
        Humanoid.PlatformStand = false
        RootPart.Velocity = Vector3.new(0, 0, 0)
    end
end

-- ==============================================
-- CONTROLES VISUALES
-- ==============================================
-- Botón activar vuelo
local FlyToggle = Instance.new("TextButton")
FlyToggle.Size = UDim2.new(1, -20, 0, 45)
FlyToggle.Position = UDim2.new(0, 10, 0, 190)
FlyToggle.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
FlyToggle.Text = "Activar Vuelo"
FlyToggle.TextColor3 = Color3.new(1,1,1)
FlyToggle.Font = Enum.Font.GothamBold
FlyToggle.TextSize = 16
FlyToggle.Parent = MainFrame
Instance.new("UICorner", FlyToggle).CornerRadius = UDim.new(0, 8)

FlyToggle.MouseButton1Click:Connect(function()
    FlyEnabled = not FlyEnabled
    ToggleFly(FlyEnabled)
    FlyToggle.Text = FlyEnabled and "✅ Vuelo ACTIVADO" or "❌ Vuelo DESACTIVADO"
    FlyToggle.BackgroundColor3 = FlyEnabled and Color3.fromRGB(30, 120, 50) or Color3.fromRGB(70, 70, 90)
end)

-- Etiqueta velocidad
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, -20, 0, 30)
SpeedLabel.Position = UDim2.new(0, 10, 0, 245)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Velocidad: "..FlySpeed
SpeedLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextSize = 15
SpeedLabel.Parent = MainFrame

-- Botones velocidad
local SpeedUp = Instance.new("TextButton")
SpeedUp.Size = UDim2.new(0.45, 0, 0, 40)
SpeedUp.Position = UDim2.new(0.05, 0, 0, 280)
SpeedUp.BackgroundColor3 = Color3.fromRGB(50, 80, 130)
SpeedUp.Text = "Aumentar"
SpeedUp.TextColor3 = Color3.new(1,1,1)
SpeedUp.Font = Enum.Font.GothamBold
SpeedUp.Parent = MainFrame
Instance.new("UICorner", SpeedUp).CornerRadius = UDim.new(0, 8)

local SpeedDown = Instance.new("TextButton")
SpeedDown.Size = UDim2.new(0.45, 0, 0, 40)
SpeedDown.Position = UDim2.new(0.50, 0, 0, 280)
SpeedDown.BackgroundColor3 = Color3.fromRGB(130, 50, 50)
SpeedDown.Text = "Reducir"
SpeedDown.TextColor3 = Color3.new(1,1,1)
SpeedDown.Font = Enum.Font.GothamBold
SpeedDown.Parent = MainFrame
Instance.new("UICorner", SpeedDown).CornerRadius = UDim.new(0, 8)

-- Lógica velocidad
SpeedUp.MouseButton1Click:Connect(function()
    FlySpeed = math.clamp(FlySpeed + 10, 10, 300)
    SpeedLabel.Text = "Velocidad: "..FlySpeed
end)

SpeedDown.MouseButton1Click:Connect(function()
    FlySpeed = math.clamp(FlySpeed - 10, 10, 300)
    SpeedLabel.Text = "Velocidad: "..FlySpeed
end)

-- ==============================================
-- RECONEXIÓN AL REAPARECER
-- ==============================================
LocalPlayer.CharacterAdded:Connect(function(nuevoPersonaje)
    Character = nuevoPersonaje
    Humanoid = Character:WaitForChild("Humanoid")
    RootPart = Character:WaitForChild("HumanoidRootPart")
    if FlyEnabled then ToggleFly(true) end
end)
