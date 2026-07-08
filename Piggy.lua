--[[
▓▒░ JOSEANGEL_BLOX SCRIPTS PRO ░▒▓
Versión: 1.1 | Fecha: 08/07/2026
Estilo: Oscuro + Azul Neón | Relación 1:1
Funciones completas y operativas
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
local CollectionService = game:GetService("CollectionService")

-- =============================================
-- VARIABLES PRINCIPALES
-- =============================================
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- CONFIGURACIÓN GENERAL
local Config = {
    UI_Visible = true,
    GodMode = false,
    ItemESP = false,
    AutoUnlockDoors = false,
    AutoGrabItems = false,
    NoClip = false,
    SpeedJump = false,
    SpeedValue = 50,
    JumpValue = 95,
    FullBright = false,
    PlayerESP = false
}

-- Tabla para guardar marcadores ESP
local ESP_Objects = {}

-- =============================================
-- CREACIÓN DE LA INTERFAZ
-- =============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngelBlox_ScriptsPRO"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Ventana principal (360x360 = relación 1:1)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "VentanaPrincipal"
MainFrame.Size = UDim2.new(0, 360, 0, 360)
MainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 15, 22)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(40, 120, 255)
MainFrame.ClipsDescendants = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

-- Barra superior
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(18, 23, 34)
TopBar.BorderSizePixel = 1
TopBar.BorderColor3 = Color3.fromRGB(40, 120, 255)
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 12)
TopCorner.Parent = TopBar

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -15, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.Text = "JoseAngel_Blox Scripts PRO"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 17
Title.TextColor3 = Color3.fromRGB(80, 160, 255)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

-- Área de contenido
local Content = Instance.new("ScrollingFrame")
Content.Size = UDim2.new(1, -16, 1, -50)
Content.Position = UDim2.new(0, 8, 0, 44)
Content.BackgroundTransparency = 1
Content.ScrollBarThickness = 5
Content.ScrollBarImageColor3 = Color3.fromRGB(40, 120, 255)
Content.BorderSizePixel = 0
Content.Parent = MainFrame

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 9)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
Layout.Parent = Content

-- =============================================
-- FUNCIÓN PARA CREAR INTERRUPTORES FUNCIONALES
-- =============================================
local function CrearInterruptor(nombre, claveConfig)
    local Marco = Instance.new("Frame")
    Marco.Size = UDim2.new(1, 0, 0, 34)
    Marco.BackgroundColor3 = Color3.fromRGB(16, 20, 30)
    Marco.BorderSizePixel = 1
    Marco.BorderColor3 = Color3.fromRGB(30, 90, 200)
    Marco.Parent = Content

    local Esquina = Instance.new("UICorner")
    Esquina.CornerRadius = UDim.new(0, 8)
    Esquina.Parent = Marco

    local Texto = Instance.new("TextLabel")
    Texto.Size = UDim2.new(0.75, 0, 1, 0)
    Texto.Position = UDim2.new(0, 12, 0, 0)
    Texto.Text = nombre
    Texto.Font = Enum.Font.GothamSemibold
    Texto.TextSize = 14
    Texto.TextColor3 = Color3.fromRGB(210, 225, 255)
    Texto.BackgroundTransparency = 1
    Texto.TextXAlignment = Enum.TextXAlignment.Left
    Texto.Parent = Marco

    -- Interruptor visual
    local Interruptor = Instance.new("Frame")
    Interruptor.Size = UDim2.new(0, 42, 0, 20)
    Interruptor.Position = UDim2.new(1, -52, 0.5, -10)
    Interruptor.BackgroundColor3 = Color3.fromRGB(25, 32, 48)
    Interruptor.BorderSizePixel = 1
    Interruptor.BorderColor3 = Color3.fromRGB(40, 120, 255)
    Interruptor.Parent = Marco

    local EsquinaInt = Instance.new("UICorner")
    EsquinaInt.CornerRadius = UDim.new(1, 0)
    EsquinaInt.Parent = Interruptor

    local Punto = Instance.new("Frame")
    Punto.Size = UDim2.new(0, 16, 0, 16)
    Punto.Position = UDim2.new(0, 2, 0.5, -8)
    Punto.BackgroundColor3 = Color3.fromRGB(200, 210, 230)
    Punto.Parent = Interruptor

    local EsquinaPunto = Instance.new("UICorner")
    EsquinaPunto.CornerRadius = UDim.new(1, 0)
    EsquinaPunto.Parent = Punto

    -- Actualizar estado
    local function CambiarEstado(activo)
        Config[claveConfig] = activo
        if activo then
            Interruptor.BackgroundColor3 = Color3.fromRGB(25, 60, 120)
            Punto.BackgroundColor3 = Color3.fromRGB(60, 140, 255)
            TweenService:Create(Punto, TweenInfo.new(0.2), {Position = UDim2.new(0, 24, 0.5, -8)}):Play()
        else
            Interruptor.BackgroundColor3 = Color3.fromRGB(25, 32, 48)
            Punto.BackgroundColor3 = Color3.fromRGB(200, 210, 230)
            TweenService:Create(Punto, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -8)}):Play()
        end
    end

    -- Detectar clic
    Marco.InputBegan:Connect(function(entrada)
        if entrada.UserInputType == Enum.UserInputType.MouseButton1 then
            CambiarEstado(not Config[claveConfig])
        end
    end)
end

-- =============================================
-- SECCIONES DE LA INTERFAZ
-- =============================================
-- Información
local InfoPanel = Instance.new("TextLabel")
InfoPanel.Size = UDim2.new(1, 0, 0, 65)
InfoPanel.BackgroundColor3 = Color3.fromRGB(15, 22, 35)
InfoPanel.BorderSizePixel = 1
InfoPanel.BorderColor3 = Color3.fromRGB(40, 120, 255)
InfoPanel.Text = [[1) INFO ↓
• Nombre del Creador: JoseAngel_Blox
• Fecha de lanzamiento: 08/07/2026
• Versión: 1.1]]
InfoPanel.Font = Enum.Font.Gotham
InfoPanel.TextSize = 13
InfoPanel.TextColor3 = Color3.fromRGB(150, 200, 255)
InfoPanel.TextWrapped = true
InfoPanel.TextXAlignment = Enum.TextXAlignment.Left
InfoPanel.TextYAlignment = Enum.TextYAlignment.Top
InfoPanel.Parent = Content

local InfoCorner = Instance.new("UICorner")
InfoCorner.CornerRadius = UDim.new(0, 8)
InfoCorner.Parent = InfoPanel

-- Título Principal
local MainLabel = Instance.new("TextLabel")
MainLabel.Size = UDim2.new(1, 0, 0, 28)
MainLabel.BackgroundColor3 = Color3.fromRGB(18, 25, 40)
MainLabel.BorderSizePixel = 1
MainLabel.BorderColor3 = Color3.fromRGB(40, 120, 255)
MainLabel.Text = "2) MAIN ↓"
MainLabel.Font = Enum.Font.GothamBold
MainLabel.TextSize = 15
MainLabel.TextColor3 = Color3.fromRGB(80, 160, 255)
MainLabel.Parent = Content

local MainCornerLabel = Instance.new("UICorner")
MainCornerLabel.CornerRadius = UDim.new(0, 8)
MainCornerLabel.Parent = MainLabel

-- Crear todos los interruptores
CrearInterruptor("God Mode (Invencible)", "GodMode")
CrearInterruptor("Item ESP", "ItemESP")
CrearInterruptor("Auto Unlock Doors", "AutoUnlockDoors")
CrearInterruptor("Auto Grab Items", "AutoGrabItems")
CrearInterruptor("No Clip", "NoClip")
CrearInterruptor("Speed & Jump", "SpeedJump")
CrearInterruptor("FullBright", "FullBright")
CrearInterruptor("ESP (Jugadores / Piggy)", "PlayerESP")

-- Ajustar tamaño del contenido
Content:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Content.CanvasSize = UDim2.new(0, 0, 0, Content.AbsoluteContentSize.Y)
end)

-- =============================================
-- FUNCIÓN PARA CREAR MARCADORES ESP
-- =============================================
local function CrearESP(objeto, color, texto)
    if ESP_Objects[objeto] then return end

    local Marco = Drawing.new("Square")
    Marco.Visible = false
    Marco.Color = color
    Marco.Thickness = 2
    Marco.Filled = false
    Marco.ZIndex = 5

    local Etiqueta = Drawing.new("Text")
    Etiqueta.Visible = false
    Etiqueta.Text = texto
    Etiqueta.Color = color
    Etiqueta.Size = 14
    Etiqueta.Center = true
    Etiqueta.Outline = true
    Etiqueta.OutlineColor = Color3.new(0,0,0)

    ESP_Objects[objeto] = {Marco = Marco, Etiqueta = Etiqueta}

    objeto.AncestryChanged:Connect(function()
        if not objeto:IsDescendantOf(Workspace) then
            Marco:Remove()
            Etiqueta:Remove()
            ESP_Objects[objeto] = nil
        end
    end)
end

-- =============================================
-- BUCLE PRINCIPAL DE EJECUCIÓN
-- =============================================
RunService.RenderStepped:Connect(function()
    -- Actualizar personaje si reaparece
    Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    Humanoid = Character:FindFirstChildOfClass("Humanoid")
    if not Humanoid or Humanoid.Health <= 0 then
        -- Ocultar ESP si mueres
        for _, v in pairs(ESP_Objects) do
            v.Marco.Visible = false
            v.Etiqueta.Visible = false
        end
        return
    end

    -- 🔹 GOD MODE
    if Config.GodMode then
        Humanoid.MaxHealth = math.huge
        Humanoid.Health = Humanoid.MaxHealth
        Humanoid.BreakJointsOnDeath = false
        Humanoid.SetStateEnabled(Enum.HumanoidStateType.Dead, false)
    else
        Humanoid.MaxHealth = 100
        if Humanoid.Health > 100 then Humanoid.Health = 100 end
        Humanoid.BreakJointsOnDeath = true
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
    end

    -- 🔹 NO CLIP
    if Config.NoClip then
        for _, parte in ipairs(Character:GetDescendants()) do
            if parte:IsA("BasePart") then
                parte.CanCollide = false
            end
        end
    else
        for _, parte in ipairs(Character:GetDescendants()) do
            if parte:IsA("BasePart") and parte.Name ~= "HumanoidRootPart" then
                parte.CanCollide = true
            end
        end
    end

    -- 🔹 VELOCIDAD Y SALTO
    if Config.SpeedJump then
        Humanoid.WalkSpeed = Config.SpeedValue
        Humanoid.JumpPower = Config.JumpValue
    else
        Humanoid.WalkSpeed = 16
        Humanoid.JumpPower = 50
    end

    -- 🔹 FULLBRIGHT
    if Config.FullBright then
        Lighting.Brightness = 3
        Lighting.FogEnd = 100000
        Lighting.FogStart = 0
        Lighting.ClockTime = 14
        Lighting.Ambient = Color3.new(1,1,1)
        Lighting.GlobalShadows = false
    else
        Lighting.Brightness = 1
        Lighting.FogEnd = 150
        Lighting.FogStart = 0
        Lighting.ClockTime = 12
        Lighting.Ambient = Color3.new(0.5,0.5,0.5)
        Lighting.GlobalShadows = true
    end

    -- 🔹 ITEM ESP
    if Config.ItemESP then
        for _, item in ipairs(Workspace:GetDescendants()) do
            if item:IsA("Model") and (item.Name:find("Key") or item.Name:find("Item") or item.Name:find("Tool") or item.Name:find("Puzzle")) then
                local partePrincipal = item:FindFirstChild("PrimaryPart") or item:FindFirstChildOfClass("BasePart")
                if partePrincipal then
                    CrearESP(partePrincipal, Color3.new(1, 0.8, 0), "Ítem: "..item.Name)
                end
            end
        end
    else
        for obj, datos in pairs(ESP_Objects) do
            if datos.Etiqueta.Text:find("Ítem") then
                datos.Marco.Visible = false
                datos.Etiqueta.Visible = false
            end
        end
    end

    -- 🔹 JUGADOR Y PIGGY ESP
    if Config.PlayerESP then
        -- Otros jugadores
        for _, jugador in ipairs(Players:GetPlayers()) do
            if jugador ~= LocalPlayer and jugador.Character and jugador.Character:FindFirstChild("HumanoidRootPart") and jugador.Character.Humanoid.Health > 0 then
                CrearESP(jugador.Character.HumanoidRootPart, Color3.new(0, 0.8, 1), "Jugador: "..jugador.Name)
            end
        end
        -- Piggy / Enemigos
        for _, npc in ipairs(Workspace:GetDescendants()) do
            if npc:IsA("Model") and npc.Name:find("Piggy") and npc:FindFirstChild("HumanoidRootPart") then
                CrearESP(npc.HumanoidRootPart, Color3.new(1, 0, 0), "⚠️ PIGGY")
            end
        end
    else
        for obj, datos in pairs(ESP_Objects) do
            if datos.Etiqueta.Text:find("Jugador") or datos.Etiqueta.Text:find("PIGGY") then
                datos.Marco.Visible = false
                datos.Etiqueta.Visible = false
            end
        end
    end

    -- Actualizar posición de los marcadores ESP
    for parte, datos in pairs(ESP_Objects) do
        if parte and parte:IsDescendantOf(Workspace) then
            local pantalla, enPantalla = Camera:WorldToViewportPoint(parte.Position)
            datos.Marco.Visible = enPantalla and (Config.ItemESP or Config.PlayerESP)
            datos.Etiqueta.Visible = enPantalla and (Config.ItemESP or Config.PlayerESP)

            if enPantalla then
                local tam = 1800 / (pantalla.Z * 2)
                datos.Marco.Size = Vector2.new(tam, tam)
                datos.Marco.Position = Vector2.new(pantalla.X - tam/2, pantalla.Y - tam/2)
                datos.Etiqueta.Position = Vector2.new(pantalla.X, pantalla.Y - tam - 15)
            end
        end
    end

    -- 🔹 AUTO ABRIR PUERTAS
    if Config.AutoUnlockDoors then
        local miPos = Character.HumanoidRootPart.Position
        for _, puerta in ipairs(Workspace:GetDescendants()) do
            if puerta.Name:find("Door") and puerta:FindFirstChild("ClickDetector") then
                if (miPos - puerta.Position).Magnitude < 20 then
                    fireclickdetector(puerta.ClickDetector)
                end
            end
        end
    end

    -- 🔹 AUTO COGER OBJETOS
    if Config.AutoGrabItems then
        local miPos = Character.HumanoidRootPart.Position
        for _, herramienta in ipairs(Workspace:GetDescendants()) do
            if herramienta:IsA("Tool") and herramienta:FindFirstChild("Handle") then
                if (miPos - herramienta.Handle.Position).Magnitude < 12 then
                    firetouchinterest(Character.HumanoidRootPart, herramienta.Handle, 0)
                    task.wait(0.05)
                    firetouchinterest(Character.HumanoidRootPart, herramienta.Handle, 1)
                end
            end
        end
    end

end)

-- =============================================
-- TECLA INSERT PARA MOSTRAR / OCULTAR
-- =============================================
UserInputService.InputBegan:Connect(function(entrada, procesado)
    if procesado then return end
    if entrada.KeyCode == Enum.KeyCode.Insert then
        Config.UI_Visible = not Config.UI_Visible
        MainFrame.Visible = Config.UI_Visible
    end
end)

-- =============================================
-- MENSAJE DE CARGA
-- =============================================
StarterGui:SetCore("SendNotification", {
    Title = "✅ SCRIPT CARGADO",
    Text = "JoseAngel_Blox Scripts PRO | Presiona INSERT para abrir/cerrar",
    Duration = 5
})
