--[[
    Nombre: JoseAngel_Blox Fly
    Botón F para mostrar/ocultar menú
    Compatible: Delta Executor - Celular
]]

-- Servicios
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Variables principales
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

local flying = false
local velocidadActual = 50
local posicionGuardada
local conexionVuelo

-- ─────────────────────────────────────
-- INTERFAZ
-- ─────────────────────────────────────
local Gui = Instance.new("ScreenGui")
Gui.Name = "JoseAngel_Blox"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = game:GetService("CoreGui")

-- Marco del menú
local Menu = Instance.new("Frame")
Menu.Name = "MenuPrincipal"
Menu.Size = UDim2.new(0, 300, 0, 260)
Menu.Position = UDim2.new(0.5, -150, 0.5, -130)
Menu.BackgroundColor3 = Color3.fromRGB(18, 22, 28)
Menu.BorderSizePixel = 0
Instance.new("UICorner", Menu).CornerRadius = UDim.new(0, 12)
Menu.Parent = Gui

-- Título
local Titulo = Instance.new("TextLabel")
Titulo.Size = UDim2.new(1, 0, 0, 50)
Titulo.BackgroundColor3 = Color3.fromRGB(30, 36, 46)
Titulo.Text = "✈️ JoseAngel_Blox Fly"
Titulo.TextColor3 = Color3.fromRGB(255, 215, 0)
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 19
Instance.new("UICorner", Titulo).CornerRadius = UDim.new(0, 12)
Titulo.Parent = Menu

-- Texto velocidad
local TextoVel = Instance.new("TextLabel")
TextoVel.Size = UDim2.new(0.8, 0, 0, 40)
TextoVel.Position = UDim2.new(0.1, 0, 0.28, 0)
TextoVel.BackgroundTransparency = 1
TextoVel.Text = "Velocidad: " .. velocidadActual
TextoVel.TextColor3 = Color3.new(1, 1, 1)
TextoVel.Font = Enum.Font.GothamSemibold
TextoVel.TextSize = 17
TextoVel.Parent = Menu

-- Botón menos velocidad
local BtnMenos = Instance.new("TextButton")
BtnMenos.Size = UDim2.new(0.35, 0, 0, 45)
BtnMenos.Position = UDim2.new(0.1, 0, 0.48, 0)
BtnMenos.BackgroundColor3 = Color3.fromRGB(45, 52, 62)
BtnMenos.Text = "➖ Menos"
BtnMenos.TextColor3 = Color3.new(1, 1, 1)
BtnMenos.Font = Enum.Font.GothamBold
BtnMenos.TextSize = 16
Instance.new("UICorner", BtnMenos).CornerRadius = UDim.new(0, 10)
BtnMenos.Parent = Menu

-- Botón más velocidad
local BtnMas = Instance.new("TextButton")
BtnMas.Size = UDim2.new(0.35, 0, 0, 45)
BtnMas.Position = UDim2.new(0.55, 0, 0.48, 0)
BtnMas.BackgroundColor3 = Color3.fromRGB(45, 52, 62)
BtnMas.Text = "➕ Más"
BtnMas.TextColor3 = Color3.new(1, 1, 1)
BtnMas.Font = Enum.Font.GothamBold
BtnMas.TextSize = 16
Instance.new("UICorner", BtnMas).CornerRadius = UDim.new(0, 10)
BtnMas.Parent = Menu

-- Botón volar / detener
local BtnVolar = Instance.new("TextButton")
BtnVolar.Size = UDim2.new(0.8, 0, 0, 50)
BtnVolar.Position = UDim2.new(0.1, 0, 0.72, 0)
BtnVolar.BackgroundColor3 = Color3.fromRGB(34, 139, 34)
BtnVolar.Text = "✅ Comenzar a Volar"
BtnVolar.TextColor3 = Color3.new(1, 1, 1)
BtnVolar.Font = Enum.Font.GothamBold
BtnVolar.TextSize = 17
Instance.new("UICorner", BtnVolar).CornerRadius = UDim.new(0, 10)
BtnVolar.Parent = Menu

-- ─────────────────────────────────────
-- BURBUJA CON LETRA F
-- ─────────────────────────────────────
local BtnFlotante = Instance.new("TextButton")
BtnFlotante.Size = UDim2.new(0, 55, 0, 55)
BtnFlotante.Position = UDim2.new(0.05, 0, 0.85, 0) -- Abajo a la izquierda
BtnFlotante.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
BtnFlotante.Text = "F"
BtnFlotante.TextColor3 = Color3.fromRGB(20, 20, 20)
BtnFlotante.Font = Enum.Font.GothamBlack
BtnFlotante.TextSize = 28
BtnFlotante.ZIndex = 10
Instance.new("UICorner", BtnFlotante).CornerRadius = UDim.new(1, 0) -- Completamente redondo
Instance.new("UIStroke", BtnFlotante).Color = Color3.new(1, 1, 1)
Instance.new("UIStroke", BtnFlotante).Thickness = 2
BtnFlotante.Parent = Gui

-- ─────────────────────────────────────
-- FUNCIONES
-- ─────────────────────────────────────

-- Mostrar / Ocultar menú con la burbuja F
BtnFlotante.MouseButton1Click:Connect(function()
    Menu.Visible = not Menu.Visible
end)

-- Actualizar texto de velocidad
local function ActualizarTexto()
    TextoVel.Text = "Velocidad: " .. velocidadActual
end

BtnMenos.MouseButton1Click:Connect(function()
    velocidadActual = math.max(10, velocidadActual - 10)
    ActualizarTexto()
end)

BtnMas.MouseButton1Click:Connect(function()
    velocidadActual = math.min(400, velocidadActual + 10)
    ActualizarTexto()
end)

-- Activar / Desactivar vuelo
local function AlternarVuelo()
    flying = not flying

    if flying then
        BtnVolar.Text = "❌ Detener Vuelo"
        BtnVolar.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
        Humanoid.PlatformStand = true
        posicionGuardada = RootPart.Position

        conexionVuelo = RunService.RenderStepped:Connect(function()
            if not flying or not RootPart:IsDescendantOf(workspace) then return end

            local cam = workspace.CurrentCamera
            local mov = Humanoid.MoveDirection
            local dir = Vector3.new()

            if mov.Magnitude > 0 then
                dir = (cam.CFrame * CFrame.new(mov.X, 0, mov.Z)).LookVector
                posicionGuardada = RootPart.Position
            end

            if Humanoid.Jump then
                dir += Vector3.new(0, 1, 0)
                posicionGuardada = RootPart.Position
            end
            if Humanoid.Sit then
                dir -= Vector3.new(0, 1, 0)
                posicionGuardada = RootPart.Position
            end

            if dir.Magnitude == 0 then
                RootPart.CFrame = CFrame.new(posicionGuardada, cam.CFrame.Position + cam.CFrame.LookVector * 10)
                RootPart.Velocity = Vector3.new(0, 0, 0)
            else
                RootPart.Velocity = dir * velocidadActual
            end
        end)

    else
        BtnVolar.Text = "✅ Comenzar a Volar"
        BtnVolar.BackgroundColor3 = Color3.fromRGB(34, 139, 34)
        Humanoid.PlatformStand = false
        if conexionVuelo then conexionVuelo:Disconnect() end
        RootPart.Velocity = Vector3.new(0, 0, 0)
    end
end

BtnVolar.MouseButton1Click:Connect(AlternarVuelo)

-- Actualizar si el personaje reaparece
LocalPlayer.CharacterAdded:Connect(function(nuevoChar)
    Character = nuevoChar
    Humanoid = Character:WaitForChild("Humanoid")
    RootPart = Character:WaitForChild("HumanoidRootPart")
    if flying then AlternarVuelo() end
end)
