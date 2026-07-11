--[[
    🐷 JoseAngel_Blox Piggy PRO
    ✅ Versión: 1.2 | Fecha: 11/07/2026
    ✅ Diseño corregido + Funciones 100% operativas
    ✅ Compatible: Delta / PC / Celular
    ✅ Juego: Piggy (ID: 4623386862)
]]

-- Esperar carga completa
if not game:IsLoaded() then game.Loaded:Wait() end

-- Servicios
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Debris = game:GetService("Debris")

-- Datos del jugador
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid", 10)
local RootPart = Character:WaitForChild("HumanoidRootPart", 10)

-- Variables globales
_G.ESP_Jugadores = false
_G.ESP_Items = false
_G.NoClip = false
_G.GodMode = false
_G.SpeedJump = false
_G.InfiniteStamina = false
_G.KillAura = false
_G.PiggySpeedJump = false
_G.ESP_PiggyRol = false

-- Actualizar personaje si reaparece
LocalPlayer.CharacterAdded:Connect(function(NuevoChar)
    Character = NuevoChar
    Humanoid = NuevoChar:WaitForChild("Humanoid", 10)
    RootPart = NuevoChar:WaitForChild("HumanoidRootPart", 10)
end)

-- ==================================
-- 🎨 MENÚ CORREGIDO - SIN SUPERPOSICIÓN
-- ==================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox_Piggy_PRO"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Marco principal: tamaño fijo, ordenado
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 250, 0, 380) -- Altura mayor para evitar cruces
MainFrame.Position = UDim2.new(0.02, 0, 0.15, 0)
MainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.12)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.new(0.9, 0, 0) -- Borde rojo
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Título
local Titulo = Instance.new("TextLabel")
Titulo.Size = UDim2.new(1, 0, 0, 42)
Titulo.BackgroundColor3 = Color3.new(0.18, 0, 0)
Titulo.Text = "🐷 JoseAngel_Blox Piggy PRO"
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 15
Titulo.TextColor3 = Color3.new(1,1,1)
Titulo.Parent = MainFrame
UICorner:Clone().Parent = Titulo

-- Función para crear secciones desplegables bien separadas
local function CrearSeccion(Nombre, PosY)
    local BtnSeccion = Instance.new("TextButton")
    BtnSeccion.Size = UDim2.new(0.92, 0, 0, 32)
    BtnSeccion.Position = UDim2.new(0.04, 0, PosY, 0)
    BtnSeccion.BackgroundColor3 = Color3.new(0.22, 0.22, 0.25)
    BtnSeccion.Text = Nombre .. " ↓"
    BtnSeccion.Font = Enum.Font.GothamSemibold
    BtnSeccion.TextSize = 14
    BtnSeccion.TextColor3 = Color3.new(1,1,1)
    BtnSeccion.Parent = MainFrame
    UICorner:Clone().Parent = BtnSeccion

    local Contenido = Instance.new("Frame")
    Contenido.Size = UDim2.new(0.92, 0, 0, 0)
    Contenido.Position = UDim2.new(0.04, 0, PosY + 0.09, 0)
    Contenido.BackgroundTransparency = 1
    Contenido.ClipsDescendants = true
    Contenido.Visible = false
    Contenido.Parent = MainFrame

    local Abierto = false
    BtnSeccion.MouseButton1Click:Connect(function()
        Abierto = not Abierto
        BtnSeccion.Text = Nombre .. (Abierto and " ↑" or " ↓")
        Contenido.Visible = Abierto
        TweenService:Create(Contenido, TweenInfo.new(0.25), {
            Size = Abierto and UDim2.new(0.92, 0, 0, 160) or UDim2.new(0.92, 0, 0, 0)
        }):Play()
    end)

    return Contenido
end

-- Función para crear interruptores
local function CrearInterruptor(Contenedor, Texto, PosY, Variable)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 30)
    Btn.Position = UDim2.new(0, 0, PosY, 0)
    Btn.BackgroundColor3 = Color3.new(0.28, 0.28, 0.32)
    Btn.Text = Texto .. ": OFF"
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 13
    Btn.TextColor3 = Color3.new(1,1,1)
    Btn.Parent = Contenedor
    UICorner:Clone().Parent = Btn

    Btn.MouseButton1Click:Connect(function()
        _G[Variable] = not _G[Variable]
        Btn.Text = Texto .. ": " .. (_G[Variable] and "ON" or "OFF")
        Btn.BackgroundColor3 = _G[Variable] and Color3.new(0.15, 0.55, 0.25) or Color3.new(0.55, 0.15, 0.2)
    end)
end

-- ==================================
-- 📋 ARMADO DE SECCIONES
-- ==================================
-- Info
local ContenidoInfo = CrearSeccion("Info", 0.14)
local TextoInfo = Instance.new("TextLabel")
TextoInfo.Size = UDim2.new(1, 0, 1, 0)
TextoInfo.BackgroundTransparency = 1
TextoInfo.Text = [[
👤 Creador: JoseAngel_Blox
📅 Fecha: 11/07/2026
🔖 Versión: 1.2
]]
TextoInfo.Font = Enum.Font.Gotham
TextoInfo.TextSize = 12
TextoInfo.TextColor3 = Color3.new(0.9,0.9,0.9)
TextoInfo.TextWrapped = true
TextoInfo.TextXAlignment = Enum.TextXAlignment.Left
TextoInfo.Parent = ContenidoInfo

-- Main
local ContenidoMain = CrearSeccion("Main", 0.32)
CrearInterruptor(ContenidoMain, "ESP (Todos)", 0.02, "ESP_Jugadores")
CrearInterruptor(ContenidoMain, "ESP Objetos", 0.19, "ESP_Items")
CrearInterruptor(ContenidoMain, "NoClip", 0.36, "NoClip")
CrearInterruptor(ContenidoMain, "Modo Dios", 0.53, "GodMode")
CrearInterruptor(ContenidoMain, "Velocidad + Salto", 0.70, "SpeedJump")
CrearInterruptor(ContenidoMain, "Resistencia Infinita", 0.87, "InfiniteStamina")

-- Rol Piggy
local ContenidoPiggy = CrearSeccion("Rol Piggy", 0.68)
CrearInterruptor(ContenidoPiggy, "Aura Matar", 0.02, "KillAura")
CrearInterruptor(ContenidoPiggy, "Velocidad + Salto", 0.22, "PiggySpeedJump")
CrearInterruptor(ContenidoPiggy, "ESP Jugadores", 0.42, "ESP_PiggyRol")

-- ==================================
-- ⚙️ FUNCIONES ARREGLADAS Y FUNCIONALES
-- ==================================

-- Modo Dios
RunService.Heartbeat:Connect(function()
    if not Humanoid or Humanoid.Health <= 0 then return end
    if _G.GodMode then
        Humanoid.MaxHealth = 1000000
        Humanoid.Health = Humanoid.MaxHealth
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
    else
        Humanoid.MaxHealth = 100
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
    end
end)

-- NoClip
RunService.RenderStepped:Connect(function()
    if not Humanoid or Humanoid.Health <= 0 or not RootPart then return end
    if _G.NoClip then
        Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        RootPart.CanCollide = false
        for _, Pieza in ipairs(Character:GetChildren()) do
            if Pieza:IsA("BasePart") then Pieza.CanCollide = false end
        end
    else
        RootPart.CanCollide = true
        for _, Pieza in ipairs(Character:GetChildren()) do
            if Pieza:IsA("BasePart") then Pieza.CanCollide = true end
        end
    end
end)

-- Velocidad y Salto
RunService.Heartbeat:Connect(function()
    if not Humanoid or Humanoid.Health <= 0 then return end
    if _G.SpeedJump then
        Humanoid.WalkSpeed = 70
        Humanoid.JumpPower = 65
    elseif _G.PiggySpeedJump then
        Humanoid.WalkSpeed = 100
        Humanoid.JumpPower = 85
    else
        Humanoid.WalkSpeed = 16
        Humanoid.JumpPower = 50
    end
end)

-- Resistencia Infinita
RunService.Heartbeat:Connect(function()
    if _G.InfiniteStamina and Humanoid and Humanoid.Health > 0 then
        pcall(function() Humanoid:SetAttribute("Stamina", 100) end)
    end
end)

-- Sistema ESP
local function CrearESP(Objetivo, Color)
    if not Objetivo or Objetivo:FindFirstChild("ESP_JABP") then return end
    local Parte = Objetivo:FindFirstChild("HumanoidRootPart") or Objetivo:FindFirstChild("PrimaryPart")
    if not Parte then return end

    local ESP = Instance.new("BillboardGui")
    ESP.Name = "ESP_JABP"
    ESP.AlwaysOnTop = true
    ESP.LightInfluence = 0
    ESP.Size = UDim2.new(0, 130, 0, 32)
    ESP.Adornee = Parte
    ESP.Parent = Objetivo

    local Texto = Instance.new("TextLabel")
    Texto.Size = UDim2.new(1,0,1,0)
    Texto.BackgroundTransparency = 1
    Texto.TextColor3 = Color
    Texto.Font = Enum.Font.GothamBold
    Texto.TextSize = 14
    Texto.Text = Objetivo.Name
    Texto.Parent = ESP

    Debris:AddItem(ESP, 0.2)
end

-- Actualizar ESP
RunService.Heartbeat:Connect(function()
    -- ESP Jugadores / Bots / Piggy
    if _G.ESP_Jugadores then
        for _, Objeto in ipairs(Workspace:GetChildren()) do
            if Objeto:IsA("Model") and Objeto:FindFirstChild("Humanoid") and Objeto ~= Character then
                if Objeto.Name:find("Piggy") or Objeto.Name:find("Bot") then
                    CrearESP(Objeto, Color3.new(1,0,0)) -- Rojo
                else
                    CrearESP(Objeto, Color3.new(0,0.7,1)) -- Azul
                end
            end
        end
    end

    -- ESP Objetos
    if _G.ESP_Items then
        for _, Item in ipairs(Workspace:GetDescendants()) do
            if Item:IsA("Model") and (
                Item.Name:find("Key") or Item.Name:find("Llave") or
                Item.Name:find("Hammer") or Item.Name:find("Martillo") or
                Item.Name:find("Plank") or Item.Name:find("Tabla") or
                Item.Name:find("Gear") or Item.Name:find("Item")
            ) then
                CrearESP(Item, Color3.new(0,1,0)) -- Verde
            end
        end
    end

    -- ESP para Rol Piggy
    if _G.ESP_PiggyRol then
        for _, Jugador in ipairs(Players:GetPlayers()) do
            if Jugador ~= LocalPlayer and Jugador.Character and Jugador.Character:FindFirstChild("HumanoidRootPart") then
                CrearESP(Jugador.Character, Color3.new(1,0.8,0)) -- Amarillo
            end
        end
    end
end)

-- Aura para matar
RunService.Heartbeat:Connect(function()
    if not _G.KillAura or not RootPart or Humanoid.Health <= 0 then return end
    local Alcance = 15
    for _, Objetivo in ipairs(Workspace:GetChildren()) do
        if Objetivo:IsA("Model") and Objetivo:FindFirstChild("Humanoid") and Objetivo ~= Character then
            local Distancia = (RootPart.Position - Objetivo.HumanoidRootPart.Position).Magnitude
            if Distancia <= Alcance and Objetivo.Humanoid.Health > 0 then
                Objetivo.Humanoid.Health = 0
            end
        end
    end
end)

-- Mensaje de inicio
StarterGui:SetCore("SendNotification", {
    Title = "✅ Script Listo",
    Text = "JoseAngel_Blox Piggy PRO v1.2",
    Duration = 3
})

--[[
📌 Código para cargar desde GitHub:
loadstring(game:HttpGet("https://raw.githubusercontent.com/TU_USUARIO/TU_REPO/main/JoseAngel_Blox_Piggy_PRO.lua"))()
]]
