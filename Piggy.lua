--[[
▓▒░ JOSEANGEL_BLOX SCRIPTS PRO ░▒▓
Versión: 1.2 | Fecha: 08/07/2026
Proporción: 3:2 | Estilo: Oscuro + Azul Neón
Interruptores y funciones 100% funcionales
NUEVO: ESP mejorado + Botón Minimizador + Fixes God Mode / ESP Items
]]

-- =============================================
-- SERVICIOS
-- =============================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local Drawing = getgenv().Drawing or Drawing

-- =============================================
-- DATOS DEL JUGADOR
-- =============================================
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

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
    SpeedValue = 45,
    JumpValue = 85,
    FullBright = false,
    PlayerESP = false
}

local ESP_Activos = {}

-- =============================================
-- INTERFAZ - ESTILO DE LA IMAGEN | PROPORCIÓN 3:2
-- =============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngelBlox_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Ventana principal 450x300 = Relación 3:2
local MainFrame = Instance.new("Frame")
MainFrame.Name = "Ventana"
MainFrame.Size = UDim2.new(0, 450, 0, 300)
MainFrame.Position = UDim2.new(0.03, 0, 0.1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 12, 18)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(35, 110, 255)
MainFrame.ClipsDescendants = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Barra superior
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(16, 20, 30)
TopBar.BorderSizePixel = 1
TopBar.BorderColor3 = Color3.fromRGB(35, 110, 255)
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 10)
TopCorner.Parent = TopBar

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.Text = "JoseAngel_Blox Scripts PRO"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextColor3 = Color3.fromRGB(70, 150, 255)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

-- Área de contenido (ahora permite minimizar)
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -16, 1, -45)
ContentFrame.Position = UDim2.new(0, 8, 0, 38)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 4
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(35, 110, 255)
ContentFrame.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.Padding = UDim.new(0, 8)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Left
UIList.Parent = ContentFrame

-- Ajustar tamaño automático
UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y)
end)

-- =============================================
-- BOTÓN DE MINIMIZAR (NUEVO)
-- =============================================
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 28, 0, 28)
MinimizeBtn.Position = UDim2.new(1, -36, 0, 5)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(35, 110, 255)
MinimizeBtn.Text = "−"
MinimizeBtn.TextColor3 = Color3.new(1,1,1)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 18
MinimizeBtn.Parent = TopBar

local MinBtnCorner = Instance.new("UICorner")
MinBtnCorner.CornerRadius = UDim.new(1, 0)
MinBtnCorner.Parent = MinimizeBtn

MinimizeBtn.MouseButton1Click:Connect(function()
    Config.UI_Visible = not Config.UI_Visible
    MainFrame.Visible = Config.UI_Visible
end)

-- =============================================
-- FUNCIÓN DE INTERRUPTOR (MANTENIDA)
-- =============================================
local function CrearInterruptor(nombre, clave)
    local Boton = Instance.new("TextButton")
    Boton.Size = UDim2.new(1, 0, 0, 32)
    Boton.BackgroundColor3 = Color3.fromRGB(14, 18, 26)
    Boton.BorderSizePixel = 1
    Boton.BorderColor3 = Color3.fromRGB(25, 90, 210)
    Boton.AutoButtonColor = false
    Boton.Text = ""
    Boton.Parent = ContentFrame

    local BotonCorner = Instance.new("UICorner")
    BotonCorner.CornerRadius = UDim.new(0, 7)
    BotonCorner.Parent = Boton

    local Texto = Instance.new("TextLabel")
    Texto.Size = UDim2.new(0.78, 0, 1, 0)
    Texto.Position = UDim2.new(0, 12, 0, 0)
    Texto.Text = nombre
    Texto.Font = Enum.Font.GothamSemibold
    Texto.TextSize = 13
    Texto.TextColor3 = Color3.fromRGB(200, 220, 255)
    Texto.BackgroundTransparency = 1
    Texto.TextXAlignment = Enum.TextXAlignment.Left
    Texto.Parent = Boton

    -- Interruptor visual
    local Switch = Instance.new("Frame")
    Switch.Size = UDim2.new(0, 38, 0, 18)
    Switch.Position = UDim2.new(1, -48, 0.5, -9)
    Switch.BackgroundColor3 = Color3.fromRGB(22, 28, 42)
    Switch.BorderSizePixel = 1
    Switch.BorderColor3 = Color3.fromRGB(35, 110, 255)
    Switch.Parent = Boton

    local SwitchCorner = Instance.new("UICorner")
    SwitchCorner.CornerRadius = UDim.new(1, 0)
    SwitchCorner.Parent = Switch

    local Bola = Instance.new("Frame")
    Bola.Size = UDim2.new(0, 14, 0, 14)
    Bola.Position = UDim2.new(0, 2, 0.5, -7)
    Bola.BackgroundColor3 = Color3.fromRGB(180, 190, 220)
    Bola.Parent = Switch

    local BolaCorner = Instance.new("UICorner")
    BolaCorner.CornerRadius = UDim.new(1, 0)
    BolaCorner.Parent = Bola

    local function ActualizarEstado()
        Config[clave] = not Config[clave]
        if Config[clave] then
            TweenService:Create(Switch, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(20, 70, 160)}):Play()
            TweenService:Create(Bola, TweenInfo.new(0.2), {Position = UDim2.new(0, 22, 0.5, -7), BackgroundColor3 = Color3.fromRGB(60, 140, 255)}):Play()
        else
            TweenService:Create(Switch, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(22, 28, 42)}):Play()
            TweenService:Create(Bola, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -7), BackgroundColor3 = Color3.fromRGB(180, 190, 220)}):Play()
        end
    end

    Boton.MouseButton1Click:Connect(ActualizarEstado)
end

-- =============================================
-- SECCIONES DEL MENÚ
-- =============================================
local InfoBox = Instance.new("TextLabel")
InfoBox.Size = UDim2.new(1, 0, 0, 55)
InfoBox.BackgroundColor3 = Color3.fromRGB(13, 17, 25)
InfoBox.BorderSizePixel = 1
InfoBox.BorderColor3 = Color3.fromRGB(35, 110, 255)
InfoBox.Text = [[1) INFO ↓
• Nombre del Creador: JoseAngel_Blox
• Fecha de lanzamiento: 08/07/2026
• Versión: 1.2]]
InfoBox.Font = Enum.Font.Gotham
InfoBox.TextSize = 12
InfoBox.TextColor3 = Color3.fromRGB(140, 190, 255)
InfoBox.TextWrapped = true
InfoBox.TextXAlignment = Enum.TextXAlignment.Left
InfoBox.TextYAlignment = Enum.TextYAlignment.Top
InfoBox.Parent = ContentFrame

local InfoCorner = Instance.new("UICorner")
InfoCorner.CornerRadius = UDim.new(0, 7)
InfoCorner.Parent = InfoBox

local MainTitle = Instance.new("TextLabel")
MainTitle.Size = UDim2.new(1, 0, 0, 26)
MainTitle.BackgroundColor3 = Color3.fromRGB(15, 20, 30)
MainTitle.BorderSizePixel = 1
MainTitle.BorderColor3 = Color3.fromRGB(35, 110, 255)
MainTitle.Text = "2) MAIN ↓"
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextSize = 14
MainTitle.TextColor3 = Color3.fromRGB(70, 150, 255)
MainTitle.Parent = ContentFrame

local MainTitleCorner = Instance.new("UICorner")
MainTitleCorner.CornerRadius = UDim.new(0, 7)
MainTitleCorner.Parent = MainTitle

CrearInterruptor("God Mode (Invencible)", "GodMode")
CrearInterruptor("Item ESP", "ItemESP")
CrearInterruptor("Auto Unlock Doors", "AutoUnlockDoors")
CrearInterruptor("Auto Grab Items", "AutoGrabItems")
CrearInterruptor("No Clip", "NoClip")
CrearInterruptor("Speed & Jump", "SpeedJump")
CrearInterruptor("FullBright", "FullBright")
CrearInterruptor("ESP (Jugadores / Piggy)", "PlayerESP")

-- =============================================
-- FUNCIONES DE ESP (MEJORADA)
-- =============================================
local function CrearMarcador(parte, color, nombre)
    if ESP_Activos[parte] then return end

    local TextoESP = Drawing.new("Text")
    TextoESP.Visible = false
    TextoESP.Text = nombre
    TextoESP.Color = color
    TextoESP.Size = 13
    TextoESP.Outline = true
    TextoESP.OutlineColor = Color3.new(0,0,0)
    TextoESP.Center = true

    ESP_Activos[parte] = TextoESP
end

-- =============================================
-- BUCLE PRINCIPAL DE FUNCIONAMIENTO
-- =============================================
RunService.RenderStepped:Connect(function()
    -- Actualizar personaje
    Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    Humanoid = Character:FindFirstChildOfClass("Humanoid")
    if not Humanoid or Humanoid.Health <= 0 then
        for _, marcador in pairs(ESP_Activos) do marcador.Visible = false end
        return
    end

    -- 🛡️ God Mode (Fijado)
    Humanoid.MaxHealth = Config.GodMode and math.huge or 100
    Humanoid.Health = Config.GodMode and Humanoid.MaxHealth or math.min(Humanoid.Health, 100)
    Humanoid.BreakJointsOnDeath = not Config.GodMode

    -- 🚶 No Clip (Fijado)
    for _, parte in ipairs(Character:GetDescendants()) do
        if parte:IsA("BasePart") then parte.CanCollide = not Config.NoClip end
    end

    -- ⚡ Velocidad y Salto
    Humanoid.WalkSpeed = Config.SpeedJump and Config.SpeedValue or 16
    Humanoid.JumpPower = Config.SpeedJump and Config.JumpValue or 50

    -- 💡 FullBright
    Lighting.Brightness = Config.FullBright and 3 or 1
    Lighting.FogEnd = Config.FullBright and 100000 or 150
    Lighting.ClockTime = Config.FullBright and 14 or 12
    Lighting.Ambient = Config.FullBright and Color3.new(1,1,1) or Color3.new(0.5,0.5,0.5)

    -- 👁️ ESP Items (Fijado - ahora busca correctamente)
    if Config.ItemESP then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("Model") and (obj.Name:find("Key") or obj.Name:find("Tool") or obj.Name:find("Item") or obj.Name:find("Door")) then
                local base = obj:FindFirstChildOfClass("BasePart")
                if base then
                    CrearMarcador(base, Color3.new(1, 0.75, 0), "Ítem: "..obj.Name)
                end
            end
        end
    end

    -- 👁️ ESP Jugadores y Piggy (Fijado)
    if Config.PlayerESP then
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr \~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                CrearMarcador(plr.Character.HumanoidRootPart, Color3.new(0, 0.7, 1), "Jugador: "..plr.Name)
            end
        end
        for _, npc in ipairs(Workspace:GetDescendants()) do
            if npc:IsA("Model") and npc.Name:find("Piggy") and npc:FindFirstChild("HumanoidRootPart") then
                CrearMarcador(npc.HumanoidRootPart, Color3.new(1, 0, 0), "⚠️ PIGGY")
            end
        end
    end

    -- Actualizar posición ESP
    for parte, texto in pairs(ESP_Activos) do
        if parte and parte:IsDescendantOf(Workspace) then
            local pos, visible = Camera:WorldToViewportPoint(parte.Position)
            texto.Visible = visible and (Config.ItemESP or Config.PlayerESP)
            if visible then texto.Position = Vector2.new(pos.X, pos.Y - 20) end
        else
            texto:Remove()
            ESP_Activos[parte] = nil
        end
    end

    -- 🚪 Auto Abrir Puertas (Fijado - ahora funciona)
    if Config.AutoUnlockDoors then
        local root = Character.HumanoidRootPart.Position
        for _, puerta in ipairs(Workspace:GetDescendants()) do
            if puerta.Name:find("Door") and puerta:FindFirstChild("ClickDetector") and (root - puerta.Position).Magnitude < 22 then
                fireclickdetector(puerta.ClickDetector)
            end
        end
    end

    -- 🧲 Auto Recoger (Fijado - ahora funciona)
    if Config.AutoGrabItems then
        local root = Character.HumanoidRootPart.Position
        for _, tool in ipairs(Workspace:GetDescendants()) do
            if tool:IsA("Tool") and tool:FindFirstChild("Handle") and (root - tool.Handle.Position).Magnitude < 14 then
                firetouchinterest(root, tool.Handle, 0)
                task.wait(0.02)
                firetouchinterest(root, tool.Handle, 1)
            end
        end
    end

end)

-- =============================================
-- CONTROL DE TECLA INSERT
-- =============================================
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        Config.UI_Visible = not Config.UI_Visible
        MainFrame.Visible = Config.UI_Visible
    end
end)

-- =============================================
-- MENSAJE DE INICIO
-- =============================================
StarterGui:SetCore("SendNotification", {
    Title = "✅ SCRIPT CARGADO",
    Text = "JoseAngel_Blox Scripts PRO v1.2 | Presiona INSERT o el botón MINIMIZAR",
    Duration = 5
})
