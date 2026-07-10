--[[
    🎮 JoseAngel_Blox Piggy PRO
    👤 Creador: JoseAngel_Blox
    📅 Actualización: 09/07/2026
    🔖 Versión: 1.2
    📐 Diseño: Ancho y compacto | Con interruptores
]]

-- Servicios
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local CollectionService = game:GetService("CollectionService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Interfaz principal (MÁS ANCHA, MÁS BAJA)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_BloxPiggyPRO"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 580, 0, 380) -- Ancho:580 | Alto:380
MainFrame.Position = UDim2.new(0.5, -290, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 26, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 14)
UICorner.Parent = MainFrame

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(38, 48, 78)
Title.Text = "🐷 JoseAngel_Blox Piggy PRO"
Title.TextColor3 = Color3.fromRGB(255, 220, 85)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 21
Title.Parent = MainFrame
UICorner:Clone().Parent = Title

-- Botones de pestañas
local ButtonInfo = Instance.new("TextButton")
ButtonInfo.Size = UDim2.new(0.32, -6, 0, 38)
ButtonInfo.Position = UDim2.new(0.02, 0, 0.13, 0)
ButtonInfo.BackgroundColor3 = Color3.fromRGB(52, 72, 125)
ButtonInfo.Text = "ℹ️ Info"
ButtonInfo.TextColor3 = Color3.fromRGB(240, 250, 255)
ButtonInfo.Font = Enum.Font.GothamSemibold
ButtonInfo.TextSize = 16
ButtonInfo.Parent = MainFrame
UICorner:Clone().Parent = ButtonInfo

local ButtonMain = Instance.new("TextButton")
ButtonMain.Size = UDim2.new(0.32, -6, 0, 38)
ButtonMain.Position = UDim2.new(0.35, 0, 0.13, 0)
ButtonMain.BackgroundColor3 = Color3.fromRGB(48, 105, 145)
ButtonMain.Text = "⚙️ Principal"
ButtonMain.TextColor3 = Color3.fromRGB(220, 255, 235)
ButtonMain.Font = Enum.Font.GothamSemibold
ButtonMain.TextSize = 16
ButtonMain.Parent = MainFrame
UICorner:Clone().Parent = ButtonMain

local ButtonPiggy = Instance.new("TextButton")
ButtonPiggy.Size = UDim2.new(0.32, -6, 0, 38)
ButtonPiggy.Position = UDim2.new(0.68, 0, 0.13, 0)
ButtonPiggy.BackgroundColor3 = Color3.fromRGB(125, 52, 92)
ButtonPiggy.Text = "🐷 Rol Piggy"
ButtonPiggy.TextColor3 = Color3.fromRGB(255, 225, 235)
ButtonPiggy.Font = Enum.Font.GothamSemibold
ButtonPiggy.TextSize = 16
ButtonPiggy.Parent = MainFrame
UICorner:Clone().Parent = ButtonPiggy

-- Área de contenido
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(0.96, 0, 0, 275)
ContentFrame.Position = UDim2.new(0.02, 0, 0.26, 0)
ContentFrame.BackgroundColor3 = Color3.fromRGB(26, 32, 52)
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 6
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(90, 120, 190)
ContentFrame.Parent = MainFrame
UICorner:Clone().Parent = ContentFrame

-- Función limpiar contenido
local function Limpiar()
    for _, v in ipairs(ContentFrame:GetChildren()) do
        if v:IsA("GuiObject") then v:Destroy() end
    end
end

-- Tabla de estados de funciones
local Estado = {
    EspJugadores = false,
    Noclip = false,
    ModoDios = false,
    AutoRecoger = false,
    VelSalto = false,
    AuraMuerte = false,
    AuraPiggy = false,
    EspPiggy = false,
    HitAmpliado = false
}

-- Función para crear interruptor
local function CrearInterruptor(texto, posY, variable)
    local Contenedor = Instance.new("Frame")
    Contenedor.Size = UDim2.new(1, -10, 0, 32)
    Contenedor.Position = UDim2.new(0, 5, 0, posY)
    Contenedor.BackgroundTransparency = 1
    Contenedor.Parent = ContentFrame

    local Etiqueta = Instance.new("TextLabel")
    Etiqueta.Size = UDim2.new(0.82, 0, 1, 0)
    Etiqueta.Position = UDim2.new(0, 0, 0, 0)
    Etiqueta.BackgroundTransparency = 1
    Etiqueta.TextColor3 = Color3.fromRGB(230, 240, 255)
    Etiqueta.Font = Enum.Font.Gotham
    Etiqueta.TextSize = 15
    Etiqueta.TextXAlignment = Enum.TextXAlignment.Left
    Etiqueta.Text = texto
    Etiqueta.Parent = Contenedor

    local Switch = Instance.new("TextButton")
    Switch.Size = UDim2.new(0, 36, 0, 22)
    Switch.Position = UDim2.new(0.85, 0, 0.15, 0)
    Switch.BackgroundColor3 = Estado[variable] and Color3.fromRGB(60, 200, 90) or Color3.fromRGB(200, 60, 60)
    Switch.Text = Estado[variable] and "ON" or "OFF"
    Switch.TextColor3 = Color3.new(1,1,1)
    Switch.Font = Enum.Font.GothamBold
    Switch.TextSize = 12
    Switch.Parent = Contenedor
    UICorner:Clone().Parent = Switch

    Switch.MouseButton1Click:Connect(function()
        Estado[variable] = not Estado[variable]
        Switch.BackgroundColor3 = Estado[variable] and Color3.fromRGB(60, 200, 90) or Color3.fromRGB(200, 60, 60)
        Switch.Text = Estado[variable] and "ON" or "OFF"
    end)
end

-- ==============================================
-- 📋 PESTAÑA INFO
-- ==============================================
ButtonInfo.MouseButton1Click:Connect(function()
    Limpiar()
    ContentFrame.CanvasSize = UDim2.new(0,0,0,100)
    local Texto = Instance.new("TextLabel")
    Texto.Size = UDim2.new(1,-10,0,90)
    Texto.Position = UDim2.new(0,5,0,5)
    Texto.BackgroundTransparency = 1
    Texto.TextColor3 = Color3.fromRGB(235,245,255)
    Texto.Font = Enum.Font.Gotham
    Texto.TextSize = 17
    Texto.TextWrapped = true
    Texto.Text = [[
👤 Creador: JoseAngel_Blox
📅 Actualización: 09/07/2026
🔖 Versión: 1.2
🎮 Juego: Piggy Roblox
✅ Interruptores funcionales
    ]]
    Texto.Parent = ContentFrame
end)

-- ==============================================
-- ⚙️ PESTAÑA PRINCIPAL
-- ==============================================
ButtonMain.MouseButton1Click:Connect(function()
    Limpiar()
    ContentFrame.CanvasSize = UDim2.new(0,0,0,220)
    CrearInterruptor("🔍 Espiar Jugadores/Bots/Piggy", 5, "EspJugadores")
    CrearInterruptor("🚧 Noclip (Atravesar paredes)", 42, "Noclip")
    CrearInterruptor("🛡️ Modo Dios (Invencible)", 79, "ModoDios")
    CrearInterruptor("🤲 Auto Recoger Ítems", 116, "AutoRecoger")
    CrearInterruptor("⚡ Velocidad + Salto Alto", 153, "VelSalto")
    CrearInterruptor("💀 Aura de Muerte", 190, "AuraMuerte")
end)

-- ==============================================
-- 🐷 PESTAÑA ROL PIGGY
-- ==============================================
ButtonPiggy.MouseButton1Click:Connect(function()
    Limpiar()
    ContentFrame.CanvasSize = UDim2.new(0,0,0,150)
    CrearInterruptor("💀 Aura Matar Jugadores", 5, "AuraPiggy")
    CrearInterruptor("🔍 Espiar Solo Jugadores", 42, "EspPiggy")
    CrearInterruptor("⚡ Velocidad + Salto Mejorado", 79, "VelSalto")
    CrearInterruptor("📏 Caja de Golpe Ampliada", 116, "HitAmpliado")
end)

-- ==============================================
-- 🚀 SISTEMA DE FUNCIONES ACTIVAS
-- ==============================================

-- Noclip
RunService.Stepped:Connect(function()
    if Character and Humanoid then
        RootPart = Character:FindFirstChild("HumanoidRootPart")
        if not RootPart then return end
        if Estado.Noclip then
            Humanoid.CanCollide = false
            RootPart.Velocity = Vector3.new(0,0,0)
        else
            Humanoid.CanCollide = true
        end
    end
end)

-- Modo Dios
RunService.Heartbeat:Connect(function()
    if Humanoid and Estado.ModoDios then
        Humanoid.MaxHealth = math.huge
        Humanoid.Health = math.huge
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
    end
end)

-- Velocidad y Salto
RunService.Heartbeat:Connect(function()
    if Humanoid then
        if Estado.VelSalto then
            Humanoid.WalkSpeed = 95
            Humanoid.JumpPower = 85
        else
            Humanoid.WalkSpeed = 16
            Humanoid.JumpPower = 50
        end
    end
end)

-- Auto Recoger Ítems
RunService.RenderStepped:Connect(function()
    if Estado.AutoRecoger and RootPart then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Name:find("Key") or obj.Name:find("Item") or obj:FindFirstChild("Pickup") then
                if (obj.Position - RootPart.Position).Magnitude < 12 then
                    fireclickdetector(obj:FindFirstChildOfClass("ClickDetector"))
                end
            end
        end
    end
end)

-- Aura de Muerte
RunService.Heartbeat:Connect(function()
    if not RootPart then return end
    local rango = 18
    if Estado.AuraMuerte then
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("Model") and v ~= Character and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                if v.Name:find("Piggy") or v.Name:find("Bot") then
                    if (v.HumanoidRootPart.Position - RootPart.Position).Magnitude < rango then
                        v.Humanoid.Health = 0
                    end
                end
            end
        end
    end
    if Estado.AuraPiggy then
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
                if (plr.Character.HumanoidRootPart.Position - RootPart.Position).Magnitude < rango then
                    plr.Character.Humanoid.Health = 0
                end
            end
        end
    end
end)

-- Espiar jugadores
RunService.RenderStepped:Connect(function()
    if Estado.EspJugadores or Estado.EspPiggy then
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local parte = plr.Character.HumanoidRootPart
                if not parte:FindFirstChild("EspMarca") then
                    local marca = Instance.new("BillboardGui")
                    marca.Name = "EspMarca"
                    marca.Adornee = parte
                    marca.AlwaysOnTop = true
                    marca.Size = UDim2.new(0, 100, 0, 30)
                    marca.Parent = parte
                    local texto = Instance.new("TextLabel")
                    texto.Size = UDim2.new(1,0,1,0)
                    texto.BackgroundTransparency = 1
                    texto.Font = Enum.Font.GothamBold
                    texto.TextSize = 14
                    texto.Parent = marca
                end
                local lbl = parte.EspMarca.TextLabel
                if Estado.EspJugadores then
                    if plr.TeamColor.Name == "Piggy" then
                        lbl.Text = "🐷 "..plr.Name
                        lbl.TextColor3 = Color3.new(1,0.2,0.2)
                    else
                        lbl.Text = "👤 "..plr.Name
                        lbl.TextColor3 = Color3.new(0.2,0.5,1)
                    end
                elseif Estado.EspPiggy then
                    lbl.Text = "👤 "..plr.Name
                    lbl.TextColor3 = Color3.new(0.2,0.5,1)
                end
            end
        end
    else
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v.Name == "EspMarca" then v:Destroy() end
        end
    end
end)

-- Hitbox ampliado
RunService.Heartbeat:Connect(function()
    if RootPart then
        if Estado.HitAmpliado then
            RootPart.Size = Vector3.new(4, 7, 4)
            RootPart.Transparency = 0.7
            RootPart.CanCollide = false
        else
            RootPart.Size = Vector3.new(2, 3, 1)
            RootPart.Transparency = 0
            RootPart.CanCollide = true
        end
    end
end)

-- Recargar funciones al revivir
LocalPlayer.CharacterAdded:Connect(function(nuevoChar)
    Character = nuevoChar
    Humanoid = Character:WaitForChild("Humanoid")
    RootPart = Character:WaitForChild("HumanoidRootPart")
end)

-- Abrir pestaña inicial
ButtonInfo:Fire("MouseButton1Click")
