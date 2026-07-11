--[[
    🐷 JoseAngel_Blox Piggy PRO
    ✅ Versión: 1.2 | Fecha: 11/07/2026
    ✅ Compatible: Delta / PC / Celular
    ✅ Juego: Piggy (ID: 4623386862)
]]

-- Esperar carga completa
if not game:IsLoaded() then game.Loaded:Wait() end

-- Servicios necesarios
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Debris = game:GetService("Debris")

-- Variables del jugador
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Variables globales de funciones
_G.ESP_Jugadores = false
_G.ESP_Items = false
_G.NoClip = false
_G.GodMode = false
_G.SpeedJump = false
_G.InfiniteStamina = false
_G.KillAura = false
_G.PiggySpeedJump = false
_G.ESP_PiggyRol = false

-- ==================================
-- 🎨 CREACIÓN DEL MENÚ
-- ==================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox_Piggy_PRO"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Marco principal: cuadrado, esquinas redondeadas, borde rojo
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 320)
MainFrame.Position = UDim2.new(0.03, 0, 0.15, 0)
MainFrame.BackgroundColor3 = Color3.new(0.12, 0.12, 0.15)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.new(0.9, 0, 0) -- Rojo
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Esquinas redondeadas
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Título principal
local Titulo = Instance.new("TextLabel")
Titulo.Size = UDim2.new(1, 0, 0, 45)
Titulo.BackgroundColor3 = Color3.new(0.18, 0, 0)
Titulo.Text = "🐷 JoseAngel_Blox Piggy PRO"
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 16
Titulo.TextColor3 = Color3.new(1, 1, 1)
Titulo.Parent = MainFrame

local UICornerTitulo = Instance.new("UICorner")
UICornerTitulo.CornerRadius = UDim.new(0, 10)
UICornerTitulo.Parent = Titulo

-- Función para crear secciones desplegables
local function CrearSeccion(nombre, posY)
    local SeccionBtn = Instance.new("TextButton")
    SeccionBtn.Size = UDim2.new(0.9, 0, 0, 30)
    SeccionBtn.Position = UDim2.new(0.05, 0, posY, 0)
    SeccionBtn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.25)
    SeccionBtn.Text = nombre .. " ↓"
    SeccionBtn.Font = Enum.Font.GothamSemibold
    SeccionBtn.TextSize = 14
    SeccionBtn.TextColor3 = Color3.new(1, 1, 1)
    SeccionBtn.Parent = MainFrame

    local UICornerSec = Instance.new("UICorner")
    UICornerSec.CornerRadius = UDim.new(0, 8)
    UICornerSec.Parent = SeccionBtn

    local Contenido = Instance.new("Frame")
    Contenido.Size = UDim2.new(0.9, 0, 0, 0)
    Contenido.Position = UDim2.new(0.05, 0, posY + 0.07, 0)
    Contenido.BackgroundTransparency = 1
    Contenido.Visible = false
    Contenido.Parent = MainFrame

    local Abierto = false
    SeccionBtn.MouseButton1Click:Connect(function()
        Abierto = not Abierto
        SeccionBtn.Text = nombre .. (Abierto and " ↑" or " ↓")
        Contenido.Visible = Abierto
        TweenService:Create(Contenido, TweenInfo.new(0.25), {Size = Abierto and UDim2.new(0.9, 0, 0, 150) or UDim2.new(0.9, 0, 0, 0)}):Play()
    end)

    return Contenido
end

-- Función para crear interruptores
local function CrearInterruptor(contenedor, texto, posY, variableGlobal)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 28)
    Btn.Position = UDim2.new(0, 0, posY, 0)
    Btn.BackgroundColor3 = Color3.new(0.25, 0.25, 0.3)
    Btn.Text = texto .. ": OFF"
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 13
    Btn.TextColor3 = Color3.new(1, 1, 1)
    Btn.Parent = contenedor

    local UICornerBtn = Instance.new("UICorner")
    UICornerBtn.CornerRadius = UDim.new(0, 6)
    UICornerBtn.Parent = Btn

    Btn.MouseButton1Click:Connect(function()
        _G[variableGlobal] = not _G[variableGlobal]
        Btn.Text = texto .. ": " .. (_G[variableGlobal] and "ON" or "OFF")
        Btn.BackgroundColor3 = _G[variableGlobal] and Color3.new(0.15, 0.5, 0.25) or Color3.new(0.5, 0.15, 0.2)
    end)
end

-- ==================================
-- 📋 ARMAR LAS SECCIONES
-- ==================================

-- 1) INFO
local ContenidoInfo = CrearSeccion("Info", 0.18)
local TextoInfo = Instance.new("TextLabel")
TextoInfo.Size = UDim2.new(1, 0, 1, 0)
TextoInfo.BackgroundTransparency = 1
TextoInfo.Text = [[
Creador: JoseAngel_Blox
Fecha: 11/07/2026
Versión: 1.2
]]
TextoInfo.Font = Enum.Font.Gotham
TextoInfo.TextSize = 12
TextoInfo.TextColor3 = Color3.new(0.9, 0.9, 0.9)
TextoInfo.TextWrapped = true
TextoInfo.Parent = ContenidoInfo

-- 2) MAIN
local ContenidoMain = CrearSeccion("Main", 0.38)
CrearInterruptor(ContenidoMain, "ESP (Todos)", 0.02, "ESP_Jugadores")
CrearInterruptor(ContenidoMain, "ESP Objetos", 0.18, "ESP_Items")
CrearInterruptor(ContenidoMain, "NoClip", 0.34, "NoClip")
CrearInterruptor(ContenidoMain, "Modo Dios", 0.50, "GodMode")
CrearInterruptor(ContenidoMain, "Velocidad + Salto", 0.66, "SpeedJump")
CrearInterruptor(ContenidoMain, "Resistencia Infinita", 0.82, "InfiniteStamina")

-- 3) ROL PIGGY
local ContenidoPiggy = CrearSeccion("Rol Piggy", 0.62)
CrearInterruptor(ContenidoPiggy, "Aura para Matar", 0.02, "KillAura")
CrearInterruptor(ContenidoPiggy, "Velocidad + Salto", 0.22, "PiggySpeedJump")
CrearInterruptor(ContenidoPiggy, "ESP Jugadores", 0.42, "ESP_PiggyRol")

-- ==================================
-- ⚙️ FUNCIONES DEL SCRIPT
-- ==================================

-- Modo Dios
RunService.Heartbeat:Connect(function()
    if _G.GodMode and Humanoid and Humanoid.Health > 0 then
        Humanoid.MaxHealth = math.huge
        Humanoid.Health = Humanoid.MaxHealth
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
    elseif Humanoid then
        Humanoid.MaxHealth = 100
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
    end
end)

-- NoClip
RunService.RenderStepped:Connect(function()
    if not Humanoid or Humanoid.Health <= 0 then return end
    Character = LocalPlayer.Character or Character
    RootPart = Character:FindFirstChild("HumanoidRootPart")
    if not RootPart then return end

    if _G.NoClip then
        Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        RootPart.CanCollide = false
    else
        RootPart.CanCollide = true
    end
end)

-- Velocidad y Salto
RunService.Heartbeat:Connect(function()
    if not Humanoid or Humanoid.Health <= 0 then return end
    if _G.SpeedJump then
        Humanoid.WalkSpeed = 65
        Humanoid.JumpPower = 60
    elseif _G.PiggySpeedJump then
        Humanoid.WalkSpeed = 90
        Humanoid.JumpPower = 75
    else
        Humanoid.WalkSpeed = 16
        Humanoid.JumpPower = 50
    end
end)

-- Resistencia Infinita
RunService.Heartbeat:Connect(function()
    if _G.InfiniteStamina and Humanoid and Humanoid.Health > 0 then
        Humanoid:SetAttribute("Stamina", 100)
    end
end)

-- Función para crear ESP
local function CrearESP(objetivo, color)
    if objetivo:FindFirstChild("ESP_JABP") then return end
    local parte = objetivo:FindFirstChild("HumanoidRootPart") or objetivo:FindFirstChild("PrimaryPart")
    if not parte then return end

    local esp = Instance.new("BillboardGui")
    esp.Name = "ESP_JABP"
    esp.AlwaysOnTop = true
    esp.Size = UDim2.new(0, 120, 0, 30)
    esp.Adornee = parte
    esp.Parent = objetivo

    local texto = Instance.new("TextLabel")
    texto.Size = UDim2.new(1, 0, 1, 0)
    texto.BackgroundTransparency = 1
    texto.TextColor3 = color
    texto.Font = Enum.Font.GothamBold
    texto.TextSize = 14
    texto.Text = objetivo.Name
    texto.Parent = esp

    Debris:AddItem(esp, 0.1)
end

-- Actualizar ESP
RunService.Heartbeat:Connect(function()
    -- ESP Jugadores / Bots / Piggy
    if _G.ESP_Jugadores then
        for _, entidad in ipairs(Workspace:GetChildren()) do
            if entidad:IsA("Model") and entidad:FindFirstChild("Humanoid") and entidad ~= Character then
                if entidad.Name:find("Piggy") then
                    CrearESP(entidad, Color3.new(1, 0, 0)) -- Rojo
                else
                    CrearESP(entidad, Color3.new(0, 0.7, 1)) -- Azul
                end
            end
        end
    end

    -- ESP Objetos
    if _G.ESP_Items then
        for _, objeto in ipairs(Workspace:GetDescendants()) do
            if objeto:IsA("Model") and (
                objeto.Name:find("Key") or objeto.Name:find("Hammer") or
                objeto.Name:find("Plank") or objeto.Name:find("Gear") or
                objeto.Name:find("Item")
            ) then
                CrearESP(objeto, Color3.new(0, 1, 0)) -- Verde
            end
        end
    end

    -- ESP para Rol Piggy
    if _G.ESP_PiggyRol then
        for _, jugador in ipairs(Players:GetPlayers()) do
            if jugador ~= LocalPlayer and jugador.Character and jugador.Character:FindFirstChild("HumanoidRootPart") then
                CrearESP(jugador.Character, Color3.new(1, 0.8, 0)) -- Amarillo
            end
        end
    end
end)

-- Aura para matar (Rol Piggy)
RunService.Heartbeat:Connect(function()
    if not _G.KillAura or not RootPart or Humanoid.Health <= 0 then return end
    local distanciaMax = 12
    for _, objetivo in ipairs(Workspace:GetChildren()) do
        if objetivo:IsA("Model") and objetivo:FindFirstChild("Humanoid") and objetivo ~= Character then
            local distancia = (RootPart.Position - objetivo.HumanoidRootPart.Position).Magnitude
            if distancia <= distanciaMax and objetivo.Humanoid.Health > 0 then
                objetivo.Humanoid.Health = 0
            end
        end
    end
end)

-- Notificación de inicio
StarterGui:SetCore("SendNotification", {
    Title = "✅ Script Cargado",
    Text = "JoseAngel_Blox Piggy PRO v1.2",
    Duration = 3
})

--[[
📌 CÓDIGO PARA CARGAR DESDE GITHUB:
Reemplaza con tus datos:
loadstring(game:HttpGet("https://raw.githubusercontent.com/TU_USUARIO/TU_REPOSITORIO/main/JoseAngel_Blox_Piggy_PRO.lua"))()
]]
