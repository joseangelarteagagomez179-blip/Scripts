--[[
▓▒░ JOSEANGEL_BLOX SCRIPTS PRO ░▒▓
Versión: 1.1 | Fecha: 08/07/2026
Estilo: Oscuro Azul Neón | Proporción 3:2
Mejoras: God Mode, ESP, Auto Puertas, Auto Recoger, Minimizar
]]

-- =============================================
-- SERVICIOS DEL JUEGO
-- =============================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")

-- =============================================
-- DATOS DEL JUGADOR
-- =============================================
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- Actualizar personaje si reaparece
LocalPlayer.CharacterAdded:Connect(function(nuevoChar)
    Character = nuevoChar
    Humanoid = Character:WaitForChild("Humanoid", 10)
end)

-- =============================================
-- CONFIGURACIÓN PRINCIPAL
-- =============================================
local Config = {
    UI_Visible = true,
    GodMode = false,
    ItemESP = false,
    AutoUnlockDoors = false,
    AutoGrabItems = false,
    NoClip = false,
    SpeedJump = false,
    SpeedValue = 50,
    JumpValue = 90,
    FullBright = false,
    PlayerESP = false
}

local ESP_Objetos = {}

-- =============================================
-- CREACIÓN DE LA INTERFAZ (IGUAL A LA IMAGEN)
-- =============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngelBlox_ScriptsPRO"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Ventana Principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "Ventana"
MainFrame.Size = UDim2.new(0, 420, 0, 320)
MainFrame.Position = UDim2.new(0.05, 0, 0.12, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
MainFrame.BorderSizePixel = 1
MainFrame.BorderColor3 = Color3.fromRGB(45, 50, 65)
MainFrame.ClipsDescendants = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- Barra Superior con Botón Minimizar
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 28, 40)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 8)
TopCorner.Parent = TopBar

local Titulo = Instance.new("TextLabel")
Titulo.Size = UDim2.new(1, -50, 1, 0)
Titulo.Position = UDim2.new(12, 0, 0, 0)
Titulo.Text = "JoseAngel_Blox Scripts PRO"
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 16
Titulo.TextColor3 = Color3.fromRGB(75, 160, 255)
Titulo.BackgroundTransparency = 1
Titulo.TextXAlignment = Enum.TextXAlignment.Left
Titulo.Parent = TopBar

-- Botón Minimizar
local BtnMinimizar = Instance.new("TextButton")
BtnMinimizar.Size = UDim2.new(0, 30, 0, 25)
BtnMinimizar.Position = UDim2.new(1, -35, 0.5, -12)
BtnMinimizar.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
BtnMinimizar.Text = "-"
BtnMinimizar.Font = Enum.Font.GothamBold
BtnMinimizar.TextSize = 18
BtnMinimizar.TextColor3 = Color3.fromRGB(200, 210, 255)
BtnMinimizar.AutoButtonColor = false
BtnMinimizar.Parent = TopBar

local MinimizarCorner = Instance.new("UICorner")
MinimizarCorner.CornerRadius = UDim.new(0, 5)
MinimizarCorner.Parent = BtnMinimizar

-- Área de Contenido
local Contenido = Instance.new("ScrollingFrame")
Contenido.Size = UDim2.new(1, -20, 1, -50)
Contenido.Position = UDim2.new(10, 0, 45, 0)
Contenido.BackgroundTransparency = 1
Contenido.BorderSizePixel = 0
Contenido.ScrollBarThickness = 4
Contenido.ScrollBarImageColor3 = Color3.fromRGB(45, 120, 255)
Contenido.Parent = MainFrame

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 10)
Layout.Parent = Contenido

Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Contenido.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y)
end)

-- =============================================
-- FUNCIÓN PARA CREAR INTERRUPTORES FUNCIONALES
-- =============================================
local function CrearInterruptor(nombre, claveConfig)
    local Fila = Instance.new("Frame")
    Fila.Size = UDim2.new(1, 0, 0, 36)
    Fila.BackgroundTransparency = 1
    Fila.Parent = Contenido

    local TextoOpcion = Instance.new("TextLabel")
    TextoOpcion.Size = UDim2.new(0.75, 0, 1, 0)
    TextoOpcion.Position = UDim2.new(5, 0, 0, 0)
    TextoOpcion.Text = nombre
    TextoOpcion.Font = Enum.Font.GothamSemibold
    TextoOpcion.TextSize = 14
    TextoOpcion.TextColor3 = Color3.fromRGB(220, 225, 255)
    TextoOpcion.BackgroundTransparency = 1
    TextoOpcion.TextXAlignment = Enum.TextXAlignment.Left
    TextoOpcion.Parent = Fila

    -- Interruptor
    local Interruptor = Instance.new("Frame")
    Interruptor.Size = UDim2.new(0, 42, 0, 20)
    Interruptor.Position = UDim2.new(1, -47, 0.5, -10)
    Interruptor.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
    Interruptor.Parent = Fila

    local InterruptorEsquina = Instance.new("UICorner")
    InterruptorEsquina.CornerRadius = UDim.new(1, 0)
    InterruptorEsquina.Parent = Interruptor

    local Bola = Instance.new("Frame")
    Bola.Size = UDim2.new(0, 16, 0, 16)
    Bola.Position = UDim2.new(2, 2, 0, 0)
    Bola.BackgroundColor3 = Color3.fromRGB(200, 205, 220)
    Bola.Parent = Interruptor

    local BolaEsquina = Instance.new("UICorner")
    BolaEsquina.CornerRadius = UDim.new(1, 0)
    BolaEsquina.Parent = Bola

    -- Lógica de cambio
    local function CambiarEstado()
        Config[claveConfig] = not Config[claveConfig]
        if Config[claveConfig] then
            TweenService:Create(Interruptor, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 130, 255)}):Play()
            TweenService:Create(Bola, TweenInfo.new(0.2), {Position = UDim2.new(24, 2, 0, 0), BackgroundColor3 = Color3.new(1,1,1)}):Play()
        else
            TweenService:Create(Interruptor, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 45, 60)}):Play()
            TweenService:Create(Bola, TweenInfo.new(0.2), {Position = UDim2.new(2, 2, 0, 0), BackgroundColor3 = Color3.fromRGB(200, 205, 220)}):Play()
        end
    end

    Fila.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            CambiarEstado()
        end
    end)
end

-- =============================================
-- CREAR TODAS LAS OPCIONES
-- =============================================
CrearInterruptor("God Mode (Invencible)", "GodMode")
CrearInterruptor("Item ESP", "ItemESP")
CrearInterruptor("Auto Unlock Doors", "AutoUnlockDoors")
CrearInterruptor("Auto Grab Items", "AutoGrabItems")
CrearInterruptor("No Clip", "NoClip")
CrearInterruptor("Speed & Jump", "SpeedJump")
CrearInterruptor("FullBright", "FullBright")
CrearInterruptor("ESP: Jugadores / Piggy", "PlayerESP")

-- =============================================
-- FUNCIÓN ESP
-- =============================================
local function CrearESP(parte, color, texto)
    if ESP_Objetos[parte] then return end

    local marco = Drawing.new("Square")
    marco.Visible = false
    marco.Color = color
    marco.Thickness = 2
    marco.Filled = false
    marco.Transparency = 0.8

    local etiqueta = Drawing.new("Text")
    etiqueta.Visible = false
    etiqueta.Text = texto
    etiqueta.Color = color
    etiqueta.Size = 14
    etiqueta.Center = true
    etiqueta.Outline = true
    etiqueta.OutlineColor = Color3.new(0,0,0)

    ESP_Objetos[parte] = {Marco = marco, Etiqueta = etiqueta}

    parte.AncestryChanged:Connect(function()
        if not parte:IsDescendantOf(Workspace) then
            marco:Remove()
            etiqueta:Remove()
            ESP_Objetos[parte] = nil
        end
    end)
end

-- =============================================
-- BOTÓN MINIMIZAR / MAXIMIZAR
-- =============================================
local minimizado = false
BtnMinimizar.MouseButton1Click:Connect(function()
    minimizado = not minimizado
    if minimizado then
        Contenido.Visible = false
        MainFrame.Size = UDim2.new(0, 420, 0, 40)
        BtnMinimizar.Text = "+"
    else
        Contenido.Visible = true
        MainFrame.Size = UDim2.new(0, 420, 0, 320)
        BtnMinimizar.Text = "-"
    end
end)

-- =============================================
-- TECLA INSERT PARA OCULTAR / MOSTRAR TODO
-- =============================================
UserInputService.InputBegan:Connect(function(input, procesado)
    if procesado then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        Config.UI_Visible = not Config.UI_Visible
        MainFrame.Visible = Config.UI_Visible
    end
end)

-- =============================================
-- BUCLE PRINCIPAL CON FUNCIONES CORREGIDAS
-- =============================================
RunService.RenderStepped:Connect(function()
    if not Character or not Humanoid or Humanoid.Health <= 0 then
        for _, v in pairs(ESP_Objetos) do v.Marco.Visible = false; v.Etiqueta.Visible = false end
        return
    end

    -- ✅ GOD MODE ARREGLADO
    if Config.GodMode then
        Humanoid.MaxHealth = math.huge
        Humanoid.Health = Humanoid.MaxHealth
        Humanoid.BreakJointsOnDeath = false
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    else
        Humanoid.MaxHealth = 100
        if Humanoid.Health > 100 then Humanoid.Health = 100 end
        Humanoid.BreakJointsOnDeath = true
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
    end

    -- ✅ NO CLIP SIN BUG
    if Config.NoClip then
        for _, parte in ipairs(Character:GetDescendants()) do
            if parte:IsA("BasePart") then
                parte.CanCollide = false
            end
        end
    else
        -- Restaurar colisiones correctamente al desactivar
        for _, parte in ipairs(Character:GetDescendants()) do
            if parte:IsA("BasePart") and parte.Name ~= "HumanoidRootPart" then
                parte.CanCollide = true
            end
        end
        Humanoid:ChangeState(Enum.HumanoidStateType.Running)
    end

    -- ✅ VELOCIDAD Y SALTO
    Humanoid.WalkSpeed = Config.SpeedJump and Config.SpeedValue or 16
    Humanoid.JumpPower = Config.SpeedJump and Config.JumpValue or 50

    -- ✅ FULLBRIGHT
    Lighting.Brightness = Config.FullBright and 3 or 1
    Lighting.FogEnd = Config.FullBright and 100000 or 150
    Lighting.ClockTime = Config.FullBright and 14 or 12
    Lighting.Ambient = Config.FullBright and Color3.new(1,1,1) or Color3.new(0.5,0.5,0.5)

    -- ✅ ITEM ESP ARREGLADO
    if Config.ItemESP then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("Model") or obj:IsA("Tool") then
                local nombre = string.lower(obj.Name)
                if nombre:find("key") or nombre:find("llave") or nombre:find("tool") or nombre:find("item") or nombre:find("moneda") or nombre:find("libro") then
                    local parte = obj:FindFirstChildOfClass("BasePart") or obj.PrimaryPart
                    if parte then CrearESP(parte, Color3.new(1, 0.7, 0), "📦 "..obj.Name) end
                end
            end
        end
    else
        for _, v in pairs(ESP_Objetos) do if v.Etiqueta.Text:find("📦") then v.Marco.Visible = false; v.Etiqueta.Visible = false end end
    end

    -- ✅ ESP JUGADORES Y PIGGY
    if Config.PlayerESP then
        -- Jugadores
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character.Humanoid.Health > 0 then
                CrearESP(plr.Character.HumanoidRootPart, Color3.new(0, 0.8, 1), "👤 "..plr.Name)
            end
        end
        -- Piggy / Enemigos
        for _, npc in ipairs(Workspace:GetDescendants()) do
            if npc:IsA("Model") and npc.Name:find("Piggy") and npc:FindFirstChild("HumanoidRootPart") then
                CrearESP(npc.HumanoidRootPart, Color3.new(1, 0, 0), "⚠️ PIGGY")
            end
        end
    else
        for _, v in pairs(ESP_Objetos) do if v.Etiqueta.Text:find("👤") or v.Etiqueta.Text:find("⚠️") then v.Marco.Visible = false; v.Etiqueta.Visible = false end end
    end

    -- Actualizar posición ESP
    for parte, datos in pairs(ESP_Objetos) do
        if parte and parte:IsDescendantOf(Workspace) then
            local pantalla, visible = Camera:WorldToViewportPoint(parte.Position)
            datos.Marco.Visible = visible
            datos.Etiqueta.Visible = visible
            if visible then
                local tam = 1500 / pantalla.Z
                datos.Marco.Size = Vector2.new(tam, tam)
                datos.Marco.Position = Vector2.new(pantalla.X - tam/2, pantalla.Y - tam/2)
                datos.Etiqueta.Position = Vector2.new(pantalla.X, pantalla.Y - tam - 15)
            end
        end
    end

    -- ✅ AUTO ABRIR PUERTAS
    if Config.AutoUnlockDoors then
        local miPos = Character.HumanoidRootPart.Position
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj.Name:find("Door") or obj.Name:find("Puerta") then
                local detector = obj:FindFirstChildOfClass("ClickDetector")
                if detector and (miPos - obj.Position).Magnitude < 25 then
                    fireclickdetector(detector)
                end
            end
        end
    end

    -- ✅ AUTO COGER ITEMS
    if Config.AutoGrabItems then
        local miPos = Character.HumanoidRootPart.Position
        for _, herramienta in ipairs(Workspace:GetDescendants()) do
            if herramienta:IsA("Tool") and herramienta:FindFirstChild("Handle") then
                if (miPos - herramienta.Handle.Position).Magnitude < 16 then
                    firetouchinterest(Character.HumanoidRootPart, herramienta.Handle, 0)
                    task.wait(0.03)
                    firetouchinterest(Character.HumanoidRootPart, herramienta.Handle, 1)
                end
            end
        end
    end

end)

-- =============================================
-- MENSAJE DE CARGA
-- =============================================
StarterGui:SetCore("SendNotification", {
    Title = "✅ SCRIPT CARGADO",
    Text = "JoseAngel_Blox Scripts PRO | INSERT = Mostrar/Ocultar | -/+ = Minimizar",
    Duration = 5
})
