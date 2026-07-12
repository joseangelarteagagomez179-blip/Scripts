-- Eliminar versiones anteriores del menú si existen para que no se amontonen
local CoreGui = game:GetService("CoreGui")
if CoreGui:FindFirstChild("JoseAngel_Blox_Menu") then
    CoreGui.JoseAngel_Blox_Menu:Destroy()
end

local TweenService = game:GetService("TweenService")
local Jugador = game.Players.LocalPlayer

-- ==========================================
-- 1. CREACIÓN DE LA INTERFAZ PRINCIPAL (GUI)
-- ==========================================
local MenuGui = Instance.new("ScreenGui")
MenuGui.Name = "JoseAngel_Blox_Menu"
MenuGui.Parent = CoreGui

-- Marco Principal (Fondo verde de jungla oscuro)
local Marco = Instance.new("Frame")
Marco.Parent = MenuGui
Marco.BackgroundColor3 = Color3.fromRGB(34, 70, 34) -- Verde Jungla Oscuro
Marco.Size = UDim2.new(0, 300, 0, 220)
Marco.Position = UDim2.new(0.5, -150, 0.4, -110)
Marco.Active = true
Marco.Draggable = true

-- Esquinas redondeadas para el marco principal
local EsquinasMarco = Instance.new("UICorner")
EsquinasMarco.CornerRadius = UDim.new(0, 12)
EsquinasMarco.Parent = Marco

-- Título
local Titulo = Instance.new("TextLabel")
Titulo.Parent = Marco
Titulo.Size = UDim2.new(1, 0, 0, 40)
Titulo.BackgroundTransparency = 1
Titulo.Text = "🌴 JoseAngel_Blox Jungle Event 🌴"
Titulo.TextColor3 = Color3.fromRGB(255, 215, 0) -- Color Oro/Amarillo bonito
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 16

-- Línea separadora
local Separador = Instance.new("Frame")
Separador.Parent = Marco
Separador.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
Separador.Size = UDim2.new(0.9, 0, 0, 2)
Separador.Position = UDim2.new(0.05, 0, 0, 40)

-- ==========================================
-- 2. SISTEMA DE PESTAÑAS (INFO Y MAIN)
-- ==========================================
local ContenedorBotones = Instance.new("Frame")
ContenedorBotones.Parent = Marco
ContenedorBotones.BackgroundTransparency = 1
ContenedorBotones.Size = UDim2.new(1, 0, 0, 30)
ContenedorBotones.Position = UDim2.new(0, 0, 0, 45)

local BotonMain = Instance.new("TextButton")
BotonMain.Parent = ContenedorBotones
BotonMain.Size = UDim2.new(0.5, 0, 1, 0)
BotonMain.BackgroundTransparency = 1
BotonMain.Text = "MAIN"
BotonMain.TextColor3 = Color3.fromRGB(255, 255, 255)
BotonMain.Font = Enum.Font.GothamBold
BotonMain.TextSize = 14

local BotonInfo = Instance.new("TextButton")
BotonInfo.Parent = ContenedorBotones
BotonInfo.Size = UDim2.new(0.5, 0, 1, 0)
BotonInfo.Position = UDim2.new(0.5, 0, 0, 0)
BotonInfo.BackgroundTransparency = 1
BotonInfo.Text = "INFO ↓"
BotonInfo.TextColor3 = Color3.fromRGB(150, 150, 150)
BotonInfo.Font = Enum.Font.GothamBold
BotonInfo.TextSize = 14

-- Contenedores de contenido
local FrameMain = Instance.new("Frame")
FrameMain.Parent = Marco
FrameMain.BackgroundTransparency = 1
FrameMain.Size = UDim2.new(1, 0, 0, 140)
FrameMain.Position = UDim2.new(0, 0, 0, 80)

local FrameInfo = Instance.new("Frame")
FrameInfo.Parent = Marco
FrameInfo.BackgroundTransparency = 1
FrameInfo.Size = UDim2.new(1, 0, 0, 140)
FrameInfo.Position = UDim2.new(0, 0, 0, 80)
FrameInfo.Visible = false -- Oculto por defecto

-- Función para cambiar de pestaña
BotonMain.MouseButton1Click:Connect(function()
    FrameMain.Visible = true
    FrameInfo.Visible = false
    BotonMain.TextColor3 = Color3.fromRGB(255, 255, 255)
    BotonInfo.TextColor3 = Color3.fromRGB(150, 150, 150)
end)

BotonInfo.MouseButton1Click:Connect(function()
    FrameMain.Visible = false
    FrameInfo.Visible = true
    BotonMain.TextColor3 = Color3.fromRGB(150, 150, 150)
    BotonInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

-- ==========================================
-- 3. CONTENIDO PESTAÑA: INFO
-- ==========================================
local function crearTextoInfo(texto, yPos)
    local lbl = Instance.new("TextLabel")
    lbl.Parent = FrameInfo
    lbl.BackgroundTransparency = 1
    lbl.Size = UDim2.new(1, 0, 0, 30)
    lbl.Position = UDim2.new(0, 0, 0, yPos)
    lbl.Text = texto
    lbl.TextColor3 = Color3.fromRGB(200, 255, 200)
    lbl.Font = Enum.Font.GothamSemibold
    lbl.TextSize = 14
end

crearTextoInfo("Creador: JoseAngel_Blox", 10)
crearTextoInfo("Fecha de lanzamiento: 12/07/2026", 45)
crearTextoInfo("Versión: 1.1", 80)

-- ==========================================
-- 4. CONTENIDO PESTAÑA: MAIN (Interruptores)
-- ==========================================
local function crearInterruptor(parent, yPos, texto, callback)
    local Contenedor = Instance.new("Frame")
    Contenedor.Parent = parent
    Contenedor.BackgroundTransparency = 1
    Contenedor.Size = UDim2.new(0.9, 0, 0, 40)
    Contenedor.Position = UDim2.new(0.05, 0, 0, yPos)
    
    local Etiqueta = Instance.new("TextLabel")
    Etiqueta.Parent = Contenedor
    Etiqueta.BackgroundTransparency = 1
    Etiqueta.Size = UDim2.new(0.6, 0, 1, 0)
    Etiqueta.Text = texto
    Etiqueta.TextColor3 = Color3.fromRGB(255, 255, 255)
    Etiqueta.Font = Enum.Font.GothamSemibold
    Etiqueta.TextSize = 16
    Etiqueta.TextXAlignment = Enum.TextXAlignment.Left
    
    local FondoSwitch = Instance.new("Frame")
    FondoSwitch.Parent = Contenedor
    FondoSwitch.BackgroundColor3 = Color3.fromRGB(100, 50, 50) -- Rojo apagado
    FondoSwitch.Size = UDim2.new(0, 50, 0, 26)
    FondoSwitch.Position = UDim2.new(1, -50, 0.5, -13)
    Instance.new("UICorner", FondoSwitch).CornerRadius = UDim.new(1, 0)
    
    local CirculoSwitch = Instance.new("Frame")
    CirculoSwitch.Parent = FondoSwitch
    CirculoSwitch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CirculoSwitch.Size = UDim2.new(0, 20, 0, 20)
    CirculoSwitch.Position = UDim2.new(0, 3, 0.5, -10)
    Instance.new("UICorner", CirculoSwitch).CornerRadius = UDim.new(1, 0)
    
    local BotonInvisible = Instance.new("TextButton")
    BotonInvisible.Parent = FondoSwitch
    BotonInvisible.Size = UDim2.new(1, 0, 1, 0)
    BotonInvisible.BackgroundTransparency = 1
    BotonInvisible.Text = ""
    
    local encendido = false
    
    BotonInvisible.MouseButton1Click:Connect(function()
        encendido = not encendido
        if encendido then
            -- Animación a encendido (Verde)
            TweenService:Create(CirculoSwitch, TweenInfo.new(0.2), {Position = UDim2.new(1, -23, 0.5, -10)}):Play()
            TweenService:Create(FondoSwitch, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 200, 50)}):Play()
        else
            -- Animación a apagado (Rojo)
            TweenService:Create(CirculoSwitch, TweenInfo.new(0.2), {Position = UDim2.new(0, 3, 0.5, -10)}):Play()
            TweenService:Create(FondoSwitch, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 50, 50)}):Play()
        end
        callback(encendido)
    end)
end

-- Variables Globales para el código
local autoFarmActivo = false
local autoRecogerActivo = false

-- Crear los interruptores
crearInterruptor(FrameMain, 10, "Auto Farm (Patear + Safezone)", function(estado)
    autoFarmActivo = estado
    -- Cuando lo apagamos, devolvemos la velocidad a la normalidad
    if not estado and Jugador.Character and Jugador.Character:FindFirstChild("Humanoid") then
        Jugador.Character.Humanoid.WalkSpeed = 16 
    end
end)

crearInterruptor(FrameMain, 60, "Auto Recoger (Bananas)", function(estado)
    autoRecogerActivo = estado
end)

-- ==========================================
-- 5. LÓGICA DEL SCRIPT (EL MOTOR)
-- ==========================================
task.spawn(function()
    local VirtualUser = game:GetService("VirtualUser")
    
    while task.wait(0.05) do
        local personaje = Jugador.Character
        
        -- LÓGICA DE AUTO FARM
        if autoFarmActivo and personaje then
            local humanoide = personaje:FindFirstChild("Humanoid")
            local root = personaje:FindFirstChild("HumanoidRootPart")
            
            if humanoide and root then
                -- 1. Aumentamos la velocidad drásticamente
                humanoide.WalkSpeed = 70
                
                -- 2. Hacemos que corra hacia la zona principal/safezone 
                -- (Vector3.new(0,0,0) suele ser el centro del mapa en estos juegos)
                humanoide:MoveTo(Vector3.new(0, 0, 0))
                
                -- 3. Pateada "al máximo perfecto" (Simulamos clics extremadamente rápidos)
                VirtualUser:ClickButton1(Vector2.new(0,0))
                
                -- Si el juego usa una herramienta para patear, la usamos
                local herramienta = personaje:FindFirstChildOfClass("Tool")
                if herramienta then
                    herramienta:Activate()
                end
            end
        end
        
        -- LÓGICA DE AUTO RECOGER
        if autoRecogerActivo and personaje and personaje:FindFirstChild("HumanoidRootPart") then
            local root = personaje.HumanoidRootPart
            for _, objeto in pairs(workspace:GetDescendants()) do
                -- Busca monedas, bananas o drops del evento
                if objeto:IsA("TouchInterest") and objeto.Parent then
                    if firetouchinterest then
                        -- Simula tocar el objeto mágicamente a distancia
                        firetouchinterest(root, objeto.Parent, 0)
                        firetouchinterest(root, objeto.Parent, 1)
                    end
                end
            end
        end
    end
end)

