--[[
    Nombre: JoseAngel_Blox Fly
    Función: Volar estable con controles para celular
    Compatible: Delta Executor
]]

-- Servicios
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ContextActionService = game:GetService("ContextActionService")

-- Variables principales
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

local flying = false
local velocidadActual = 50
local controlVuelo

-- ─────────────────────────────────────
-- INTERFAZ
-- ─────────────────────────────────────
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngelBlox_Fly"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game:GetService("CoreGui")

local Marco = Instance.new("Frame")
Marco.Size = UDim2.new(0, 300, 0, 260)
Marco.Position = UDim2.new(0.5, -150, 0.5, -130)
Marco.BackgroundColor3 = Color3.fromRGB(18, 22, 28)
Marco.BorderSizePixel = 0
Instance.new("UICorner", Marco).CornerRadius = UDim.new(0, 12)
Marco.Parent = ScreenGui

local Titulo = Instance.new("TextLabel")
Titulo.Size = UDim2.new(1, 0, 0, 50)
Titulo.BackgroundColor3 = Color3.fromRGB(30, 36, 46)
Titulo.Text = "✈️ JoseAngel_Blox Fly"
Titulo.TextColor3 = Color3.fromRGB(255, 215, 0)
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 19
Instance.new("UICorner", Titulo).CornerRadius = UDim.new(0, 12)
Titulo.Parent = Marco

local Cerrar = Instance.new("TextButton")
Cerrar.Size = UDim2.new(0, 32, 0, 32)
Cerrar.Position = UDim2.new(1, -38, 0, 9)
Cerrar.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
Cerrar.Text = "X"
Cerrar.TextColor3 = Color3.new(1,1,1)
Cerrar.Font = Enum.Font.GothamBold
Cerrar.TextSize = 16
Instance.new("UICorner", Cerrar).CornerRadius = UDim.new(0, 8)
Cerrar.Parent = Marco

local TextoVel = Instance.new("TextLabel")
TextoVel.Size = UDim2.new(0.8, 0, 0, 40)
TextoVel.Position = UDim2.new(0.1, 0, 0.28, 0)
TextoVel.BackgroundTransparency = 1
TextoVel.Text = "Velocidad: " .. velocidadActual
TextoVel.TextColor3 = Color3.new(1,1,1)
TextoVel.Font = Enum.Font.GothamSemibold
TextoVel.TextSize = 17
TextoVel.Parent = Marco

local BotonMenos = Instance.new("TextButton")
BotonMenos.Size = UDim2.new(0.35, 0, 0, 45)
BotonMenos.Position = UDim2.new(0.1, 0, 0.48, 0)
BotonMenos.BackgroundColor3 = Color3.fromRGB(45, 52, 62)
BotonMenos.Text = "➖ Menos"
BotonMenos.TextColor3 = Color3.new(1,1,1)
BotonMenos.Font = Enum.Font.GothamBold
BotonMenos.TextSize = 16
Instance.new("UICorner", BotonMenos).CornerRadius = UDim.new(0, 10)
BotonMenos.Parent = Marco

local BotonMas = Instance.new("TextButton")
BotonMas.Size = UDim2.new(0.35, 0, 0, 45)
BotonMas.Position = UDim2.new(0.55, 0, 0.48, 0)
BotonMas.BackgroundColor3 = Color3.fromRGB(45, 52, 62)
BotonMas.Text = "➕ Más"
BotonMas.TextColor3 = Color3.new(1,1,1)
BotonMas.Font = Enum.Font.GothamBold
BotonMas.TextSize = 16
Instance.new("UICorner", BotonMas).CornerRadius = UDim.new(0, 10)
BotonMas.Parent = Marco

local BotonVolar = Instance.new("TextButton")
BotonVolar.Size = UDim2.new(0.8, 0, 0, 50)
BotonVolar.Position = UDim2.new(0.1, 0, 0.72, 0)
BotonVolar.BackgroundColor3 = Color3.fromRGB(34, 139, 34)
BotonVolar.Text = "✅ Comenzar a Volar"
BotonVolar.TextColor3 = Color3.new(1,1,1)
BotonVolar.Font = Enum.Font.GothamBold
BotonVolar.TextSize = 17
Instance.new("UICorner", BotonVolar).CornerRadius = UDim.new(0, 10)
BotonVolar.Parent = Marco

-- ─────────────────────────────────────
-- FUNCIONES DE CONTROL
-- ─────────────────────────────────────
local function ActualizarTexto()
    TextoVel.Text = "Velocidad: " .. velocidadActual
end

BotonMenos.MouseButton1Click:Connect(function()
    velocidadActual = math.max(10, velocidadActual - 10)
    ActualizarTexto()
end)

BotonMas.MouseButton1Click:Connect(function()
    velocidadActual = math.min(350, velocidadActual + 10)
    ActualizarTexto()
end)

-- Activar / Desactivar vuelo
local function AlternarVuelo()
    flying = not flying

    if flying then
        BotonVolar.Text = "❌ Desactivar Vuelo"
        BotonVolar.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
        Humanoid.PlatformStand = true -- Para no caerse

        -- Control de movimiento estable
        controlVuelo = RunService.Heartbeat:Connect(function()
            if not flying or not RootPart or not RootPart:IsDescendantOf(workspace) then return end

            local cam = workspace.CurrentCamera
            local dir = Vector3.new()

            -- Leer entrada del jugador (funciona con joystick en celular)
            local mov = Humanoid.MoveDirection
            if mov.Magnitude > 0 then
                dir = (cam.CFrame * CFrame.new(mov.X, 0, mov.Z)).LookVector
            end

            -- Subir / Bajar: toca 2 veces rápido el botón de saltar para subir, agacharse para bajar
            if Humanoid.Jump then
                dir += Vector3.new(0, 0.8, 0)
            end
            if Humanoid.Sit then
                dir -= Vector3.new(0, 0.8, 0)
            end

            -- Aplicar movimiento
            RootPart.Velocity = dir * velocidadActual
            RootPart.CFrame = CFrame.new(RootPart.Position, cam.CFrame.Position + cam.CFrame.LookVector * 10)
        end)

    else
        BotonVolar.Text = "✅ Comenzar a Volar"
        BotonVolar.BackgroundColor3 = Color3.fromRGB(34, 139, 34)
        Humanoid.PlatformStand = false
        if controlVuelo then controlVuelo:Disconnect() end
        RootPart.Velocity = Vector3.new(0, 0, 0)
    end
end

BotonVolar.MouseButton1Click:Connect(AlternarVuelo)

-- Cerrar todo
Cerrar.MouseButton1Click:Connect(function()
    if flying then AlternarVuelo() end
    ScreenGui:Destroy()
end)

-- Si reapareces
LocalPlayer.CharacterAdded:Connect(function(nuevoChar)
    Character = nuevoChar
    Humanoid = Character:WaitForChild("Humanoid")
    RootPart = Character:WaitForChild("HumanoidRootPart")
    if flying then AlternarVuelo() end
end)
