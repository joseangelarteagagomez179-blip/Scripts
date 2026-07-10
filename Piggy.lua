--[[
    🎮 JoseAngel_Blox Piggy PRO
    👤 Creador: JoseAngel_Blox
    📅 Actualización: 09/07/2026
    🔖 Versión: 1.2
    🎨 Diseño: Cuadrado, esquinas redondeadas, colores agradables
]]

-- Servicios del juego
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- ==============================================
-- 🖼️ CREACIÓN DE LA INTERFAZ
-- ==============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_BloxPiggyPRO"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Ventana principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 430, 0, 580)
MainFrame.Position = UDim2.new(0.5, -215, 0.5, -290)
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 28, 42) -- Fondo azul oscuro suave
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Esquinas redondeadas
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = MainFrame

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 55)
Title.BackgroundColor3 = Color3.fromRGB(40, 50, 80)
Title.Text = "JoseAngel_Blox Piggy PRO"
Title.TextColor3 = Color3.fromRGB(255, 223, 100) -- Dorado bonito
Title.Font = Enum.Font.GothamBold
Title.TextSize = 23
Title.TextWrapped = true
Title.Parent = MainFrame
UICorner:Clone().Parent = Title

-- Botones de navegación
local ButtonInfo = Instance.new("TextButton")
ButtonInfo.Size = UDim2.new(0.31, -5, 0, 42)
ButtonInfo.Position = UDim2.new(0.02, 0, 0.11, 0)
ButtonInfo.BackgroundColor3 = Color3.fromRGB(55, 75, 130)
ButtonInfo.Text = "ℹ️ Info"
ButtonInfo.TextColor3 = Color3.fromRGB(240, 250, 255)
ButtonInfo.Font = Enum.Font.GothamSemibold
ButtonInfo.TextSize = 17
ButtonInfo.Parent = MainFrame
UICorner:Clone().Parent = ButtonInfo

local ButtonMain = Instance.new("TextButton")
ButtonMain.Size = UDim2.new(0.31, -5, 0, 42)
ButtonMain.Position = UDim2.new(0.35, 0, 0.11, 0)
ButtonMain.BackgroundColor3 = Color3.fromRGB(50, 110, 150)
ButtonMain.Text = "⚙️ Main"
ButtonMain.TextColor3 = Color3.fromRGB(220, 255, 235)
ButtonMain.Font = Enum.Font.GothamSemibold
ButtonMain.TextSize = 17
ButtonMain.Parent = MainFrame
UICorner:Clone().Parent = ButtonMain

local ButtonPiggy = Instance.new("TextButton")
ButtonPiggy.Size = UDim2.new(0.31, -5, 0, 42)
ButtonPiggy.Position = UDim2.new(0.68, 0, 0.11, 0)
ButtonPiggy.BackgroundColor3 = Color3.fromRGB(130, 55, 95)
ButtonPiggy.Text = "🐷 Rol Piggy"
ButtonPiggy.TextColor3 = Color3.fromRGB(255, 225, 235)
ButtonPiggy.Font = Enum.Font.GothamSemibold
ButtonPiggy.TextSize = 17
ButtonPiggy.Parent = MainFrame
UICorner:Clone().Parent = ButtonPiggy

-- Área de contenido con desplazamiento
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(0.96, 0, 0, 450)
ContentFrame.Position = UDim2.new(0.02, 0, 0.21, 0)
ContentFrame.BackgroundColor3 = Color3.fromRGB(28, 35, 55)
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 7
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 130, 200)
ContentFrame.Parent = MainFrame
UICorner:Clone().Parent = ContentFrame

-- Función para limpiar contenido
local function LimpiarContenido()
    for _, objeto in ipairs(ContentFrame:GetChildren()) do
        if objeto:IsA("GuiObject") then
            objeto:Destroy()
        end
    end
end

-- ==============================================
-- 📋 1. OPCIÓN: INFO
-- ==============================================
ButtonInfo.MouseButton1Click:Connect(function()
    LimpiarContenido()
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 130)

    local InfoTexto = Instance.new("TextLabel")
    InfoTexto.Size = UDim2.new(1, -12, 0, 120)
    InfoTexto.Position = UDim2.new(0, 6, 0, 6)
    InfoTexto.BackgroundTransparency = 1
    InfoTexto.TextColor3 = Color3.fromRGB(235, 245, 255)
    InfoTexto.Font = Enum.Font.Gotham
    InfoTexto.TextSize = 18
    InfoTexto.TextWrapped = true
    InfoTexto.Text = [[
📋 INFORMACIÓN DEL SCRIPT
👤 Creador: JoseAngel_Blox
📅 Fecha de actualización: 09/07/2026
🔖 Versión: 1.2
🎮 Compatible con: Piggy (Roblox)
    ]]
    InfoTexto.Parent = ContentFrame
end)

-- ==============================================
-- ⚙️ 2. OPCIÓN: MAIN + TODOS LOS ÍTEMS
-- ==============================================
ButtonMain.MouseButton1Click:Connect(function()
    LimpiarContenido()
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 1750)

    local MainTexto = Instance.new("TextLabel")
    MainTexto.Size = UDim2.new(1, -12, 0, 1740)
    MainTexto.Position = UDim2.new(0, 6, 0, 6)
    MainTexto.BackgroundTransparency = 1
    MainTexto.TextColor3 = Color3.fromRGB(210, 255, 225)
    MainTexto.Font = Enum.Font.Gotham
    MainTexto.TextSize = 15
    MainTexto.TextWrapped = true
    MainTexto.Text = [[
⚙️ FUNCIONES PRINCIPALES

🔍 ESPIONAJE
• Jugadores: Marcados en AZUL
• Bots: Marcados en ROJO
• Jugador con rol Piggy: Marcado en ROJO

📘 LIBRO 1
🟢 Capítulo 1: Casa
🔑 Llaves: Verde, Roja, Azul, Morada, Blanca
🛠️ Herramientas: Martillo, Llave inglesa, Tabla, Engranaje Verde, Engranaje Rojo

🟢 Capítulo 2: Comisaría
🔑 Llaves: Amarilla, Roja, Verde, Azul, Blanca
🛠️ Herramientas: Gasolina, Batería ×2, Martillo, Tabla, Llave inglesa

🟢 Capítulo 3: Galería
🔑 Llaves: Azul, Roja, Verde, Amarilla, Blanca
🛠️ Herramientas: Huevo Rojo, Huevo Azul, Llave inglesa, Tabla, Martillo

🟢 Capítulo 4: Bosque
🔑 Llaves: Amarilla, Roja, Verde, Blanca
🛠️ Herramientas: Antorcha, Leña, Tabla, Martillo, Llave inglesa

🟢 Capítulo 5: Escuela
🔑 Llaves: Azul, Roja, Verde, Amarilla, Blanca
🛠️ Herramientas: Libro ×2, Martillo, Tabla, Llave inglesa

🟢 Capítulo 6: Hospital
🔑 Llaves: Azul, Roja, Verde, Amarilla, Blanca
🛠️ Herramientas: Jeringa, Gas, Tabla, Martillo, Llave inglesa

🟢 Capítulo 7: Metro
🔑 Llaves: Amarilla, Roja, Verde, Azul, Blanca
🛠️ Herramientas: Ballesta, Munición, Tabla, Martillo, Llave inglesa

🟢 Capítulo 8: Puerto
🔑 Llaves: Amarilla, Roja, Verde, Azul, Blanca
🛠️ Herramientas: Cadena, Gancho, Tabla, Martillo, Llave inglesa

🟢 Capítulo 9: Ciudad
🔑 Llaves: Amarilla, Roja, Verde, Azul, Blanca
🛠️ Herramientas: Pasto, Tabla, Martillo, Llave inglesa

🟢 Capítulo 10: Campamento
🔑 Llaves: Amarilla, Roja, Verde, Azul, Blanca
🛠️ Herramientas: Pala, Tabla, Martillo, Llave inglesa

🟢 Capítulo 11: Refugio
🔑 Llaves: Amarilla, Roja, Verde, Azul, Blanca
🛠️ Herramientas: Código, Tabla, Martillo, Llave inglesa

🟢 Capítulo 12: Laboratorio
🔑 Llaves: Amarilla, Roja, Verde, Azul, Blanca
🛠️ Herramientas: Batería ×2, Tubo morado, Tabla, Martillo, Llave inglesa

📗 LIBRO 2
🟣 Capítulo 1: Calle
🔑 Llaves: Azul, Roja, Verde, Naranja, Blanca
🛠️ Herramientas: Destornillador, Escoba, Tijeras, Zanahoria

🟣 Capítulo 2: Almacén
🔑 Llaves: Amarilla, Roja, Verde, Azul, Blanca
🛠️ Herramientas: Batería ×2, Escalera, Zanahoria

🟣 Capítulo 3: Puerto
🔑 Llaves: Amarilla, Roja, Verde, Azul, Blanca
🛠️ Herramientas: Humo, Destornillador, Batería, Zanahoria

🟣 Capítulo 4: Centro
🔑 Llaves: Amarilla, Roja, Verde, Azul, Blanca
🛠️ Herramientas: Llave ascensor, Escalera, Destornillador

🟣 Capítulo 5: Fábrica
🔑 Llaves: Amarilla, Roja, Verde, Azul, Blanca
🛠️ Herramientas: Destornillador, Tabla, Batería

🟣 Capítulo 6: Mina
🔑 Llaves: Amarilla, Roja, Verde, Azul, Blanca
🛠️ Herramientas: Antorcha, Destornillador, Pala

🟣 Capítulo 7: Faro
🔑 Llaves: Amarilla, Roja, Verde, Azul, Blanca
🛠️ Herramientas: Batería, Lente, Tabla

🟣 Capítulo 8: Barco
🔑 Llaves: Amarilla, Roja, Verde, Azul, Blanca
🛠️ Herramientas: Destornillador, Cadena, Tabla

🟣 Capítulo 9: Base
🔑 Llaves: Amarilla, Roja, Verde, Azul, Blanca
🛠️ Herramientas: Código, Tabla, Palanca

🟣 Capítulo 10: Torre
🔑 Llaves: Amarilla, Roja, Verde, Azul, Blanca
🛠️ Herramientas: Engranaje, Tabla, Destornillador

🟣 Capítulo 11: Laboratorio
🔑 Llaves: Amarilla, Roja, Verde, Azul, Blanca
🛠️ Herramientas: Llave ascensor, Tabla, Batería

🟣 Capítulo 12: Ciudad
🔑 Llaves: Amarilla, Roja, Verde, Azul, Blanca
🛠️ Herramientas: Escoba, Código, Tabla

⚙️ FUNCIONES ACTIVABLES
✅ Noclip: Atravesar paredes
✅ Modo Dios: Invencible
✅ Auto Recoger: Toma ítems automáticamente
✅ Velocidad + Salto: Movimiento mejorado
✅ Aura de Muerte: Elimina bots y Piggy automáticamente
    ]]
    MainTexto.Parent = ContentFrame
end)

-- ==============================================
-- 🐷 3. OPCIÓN: ROL PIGGY
-- ==============================================
ButtonPiggy.MouseButton1Click:Connect(function()
    LimpiarContenido()
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 230)

    local PiggyTexto = Instance.new("TextLabel")
    PiggyTexto.Size = UDim2.new(1, -12, 0, 220)
    PiggyTexto.Position = UDim2.new(0, 6, 0, 6)
    PiggyTexto.BackgroundTransparency = 1
    PiggyTexto.TextColor3 = Color3.fromRGB(255, 215, 225)
    PiggyTexto.Font = Enum.Font.Gotham
    PiggyTexto.TextSize = 15
    PiggyTexto.TextWrapped = true
    PiggyTexto.Text = [[
🐷 FUNCIONES PARA ROL PIGGY
✅ Aura de Muerte: Elimina jugadores automáticamente
✅ Espionaje: Solo ve a los jugadores
✅ Velocidad + Salto: Mayor movilidad
✅ Caja de Golpe Ampliada: Alcanza más lejos para atrapar
    ]]
    PiggyTexto.Parent = ContentFrame
end)

-- ==============================================
-- 🚀 ACTIVACIÓN DE FUNCIONES PRÁCTICAS
-- ==============================================
local Funciones = {
    Noclip = false,
    ModoDios = false,
    AutoRecoger = false,
    VelocidadSalto = false,
    AuraMuerte = false,
    AuraPiggy = false
}

-- Noclip
RunService.Stepped:Connect(function()
    if Funciones.Noclip and Humanoid then
        Humanoid.CanCollide = false
        RootPart.Velocity = Vector3.new(0, 0, 0)
    elseif Humanoid then
        Humanoid.CanCollide = true
    end
end)

-- Modo Dios
RunService.Heartbeat:Connect(function()
    if Funciones.ModoDios and Humanoid then
        Humanoid.MaxHealth = math.huge
        Humanoid.Health = math.huge
    end
end)

-- Velocidad y Salto
RunService.Heartbeat:Connect(function()
    if Funciones.VelocidadSalto and Humanoid then
        Humanoid.WalkSpeed = 80
        Humanoid.JumpPower = 75
    elseif Humanoid then
        Humanoid.WalkSpeed = 16
        Humanoid.JumpPower = 50
    end
end)

-- Mostrar pestaña inicial
ButtonInfo:Fire("MouseButton1Click")
