-- ==================================
-- PASO 1 + 2 + 3 + 4 + 5 + 6
-- JoseAngel_Blox Piggy PRO
-- ==================================

-- Servicios
local Jugador = game:GetService("Players").LocalPlayer
local Entrada = game:GetService("UserInputService")
local Tiempo = game:GetService("RunService")
local Pantalla = Jugador:WaitForChild("PlayerGui")

-- Contenedor principal
local Interfaz = Instance.new("ScreenGui")
Interfaz.Name = "JoseAngel_Script"
Interfaz.ResetOnSpawn = false
Interfaz.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Interfaz.Parent = Pantalla

-- Ventana principal
local Ventana = Instance.new("Frame")
Ventana.Name = "VentanaPrincipal"
Ventana.Size = UDim2.new(0, 320, 0, 550)
Ventana.Position = UDim2.new(0.05, 0, 0.1, 0)
Ventana.BackgroundColor3 = Color3.new(0.12, 0.12, 0.15)
Ventana.BorderSizePixel = 0
Ventana.Visible = true
Ventana.Parent = Interfaz

local Esquinas = Instance.new("UICorner")
Esquinas.CornerRadius = UDim.new(0, 12)
Esquinas.Parent = Ventana

-- Barra superior
local BarraSuperior = Instance.new("Frame")
BarraSuperior.Size = UDim2.new(1, 0, 0, 40)
BarraSuperior.BackgroundColor3 = Color3.new(0.18, 0.18, 0.22)
BarraSuperior.BorderSizePixel = 0
BarraSuperior.Parent = Ventana

local EsquinasBarra = Instance.new("UICorner")
EsquinasBarra.CornerRadius = UDim.new(0, 12)
EsquinasBarra.Parent = BarraSuperior

-- Título
local Titulo = Instance.new("TextLabel")
Titulo.Size = UDim2.new(1, -80, 1, 0)
Titulo.Position = UDim2.new(0, 10, 0, 0)
Titulo.BackgroundTransparency = 1
Titulo.Text = "JoseAngel_Blox Piggy PRO"
Titulo.TextColor3 = Color3.new(1,1,1)
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 16
Titulo.TextXAlignment = Enum.TextXAlignment.Left
Titulo.Parent = BarraSuperior

-- Botón Ocultar
local BotonOcultar = Instance.new("TextButton")
BotonOcultar.Size = UDim2.new(0, 30, 0, 30)
BotonOcultar.Position = UDim2.new(1, -70, 0, 5)
BotonOcultar.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
BotonOcultar.Text = "✕"
BotonOcultar.TextColor3 = Color3.new(1,1,1)
BotonOcultar.Font = Enum.Font.GothamBold
BotonOcultar.TextSize = 18
BotonOcultar.BorderSizePixel = 0
BotonOcultar.Parent = BarraSuperior

local EsquinasOcultar = Instance.new("UICorner")
EsquinasOcultar.CornerRadius = UDim.new(0, 6)
EsquinasOcultar.Parent = BotonOcultar

-- Botón Mostrar
local BotonMostrar = Instance.new("TextButton")
BotonMostrar.Size = UDim2.new(0, 50, 0, 50)
BotonMostrar.Position = UDim2.new(0.02, 0, 0.05, 0)
BotonMostrar.BackgroundColor3 = Color3.new(0.2, 0.6, 0.2)
BotonMostrar.Text = "📌"
BotonMostrar.Visible = false
BotonMostrar.BorderSizePixel = 0
BotonMostrar.Parent = Interfaz

local EsquinasMostrar = Instance.new("UICorner")
EsquinasMostrar.CornerRadius = UDim.new(0, 8)
EsquinasMostrar.Parent = BotonMostrar

-- Área de contenido
local Contenido = Instance.new("ScrollingFrame")
Contenido.Size = UDim2.new(1, -20, 1, -60)
Contenido.Position = UDim2.new(0, 10, 0, 50)
Contenido.BackgroundTransparency = 1
Contenido.BorderSizePixel = 0
Contenido.ScrollBarThickness = 4
Contenido.ScrollBarImageColor3 = Color3.new(0.4, 0.4, 0.4)
Contenido.Parent = Ventana

local Lista = Instance.new("UIListLayout")
Lista.Padding = UDim.new(0, 8)
Lista.SortOrder = Enum.SortOrder.LayoutOrder
Lista.Parent = Contenido

-- ==================================
-- PASO 4: SECCIÓN INFO
-- ==================================
local ContInfo = Instance.new("Frame")
ContInfo.Size = UDim2.new(1, 0, 0, 40)
ContInfo.BackgroundColor3 = Color3.new(0.2, 0.2, 0.25)
ContInfo.BorderSizePixel = 0
ContInfo.Parent = Contenido

local EsqInfo = Instance.new("UICorner")
EsqInfo.CornerRadius = UDim.new(0, 8)
EsqInfo.Parent = ContInfo

local BtnInfo = Instance.new("TextButton")
BtnInfo.Size = UDim2.new(1, 0, 1, 0)
BtnInfo.BackgroundTransparency = 1
BtnInfo.Text = "Info ↓"
BtnInfo.TextColor3 = Color3.new(1,1,1)
BtnInfo.Font = Enum.Font.GothamSemibold
BtnInfo.TextSize = 15
BtnInfo.TextXAlignment = Enum.TextXAlignment.Left
BtnInfo.Position = UDim2.new(0, 12, 0, 0)
BtnInfo.Parent = ContInfo

local PanelInfo = Instance.new("Frame")
PanelInfo.Size = UDim2.new(1, 0, 0, 0)
PanelInfo.Position = UDim2.new(0, 0, 1, 5)
PanelInfo.BackgroundColor3 = Color3.new(0.15, 0.15, 0.2)
PanelInfo.Visible = false
PanelInfo.Parent = ContInfo

local EsqPanelInfo = Instance.new("UICorner")
EsqPanelInfo.CornerRadius = UDim.new(0, 8)
EsqPanelInfo.Parent = PanelInfo

local TextoInfo = Instance.new("TextLabel")
TextoInfo.Size = UDim2.new(1, -20, 1, -10)
TextoInfo.Position = UDim2.new(0, 10, 0, 5)
TextoInfo.BackgroundTransparency = 1
TextoInfo.Text = [[Nombre del Creador: JoseAngel_Blox
Fecha de Lanzamiento: 09/07/2026
Versión: 1.2]]
TextoInfo.TextColor3 = Color3.new(0.9,0.9,0.9)
TextoInfo.Font = Enum.Font.Gotham
TextoInfo.TextSize = 14
TextoInfo.TextXAlignment = Enum.TextXAlignment.Left
TextoInfo.TextWrapped = true
TextoInfo.Parent = PanelInfo

local InfoAbierto = false
BtnInfo.MouseButton1Click:Connect(function()
    InfoAbierto = not InfoAbierto
    if InfoAbierto then
        PanelInfo.Visible = true
        PanelInfo.Size = UDim2.new(1,0,0,80)
        BtnInfo.Text = "Info ↑"
        ContInfo.Size = UDim2.new(1,0,0,130)
    else
        PanelInfo.Visible = false
        PanelInfo.Size = UDim2.new(1,0,0,0)
        BtnInfo.Text = "Info ↓"
        ContInfo.Size = UDim2.new(1,0,0,40)
    end
    task.wait(0.05)
    Contenido.CanvasSize = UDim2.new(0,0,Lista.AbsoluteContentSize.Y,0)
end)

-- ==================================
-- PASO 5: SECCIÓN FUNCIONES PLAYERS
-- ==================================
local ContFunciones = Instance.new("Frame")
ContFunciones.Size = UDim2.new(1, 0, 0, 40)
ContFunciones.BackgroundColor3 = Color3.new(0.2, 0.2, 0.25)
ContFunciones.BorderSizePixel = 0
ContFunciones.Parent = Contenido

local EsqFunciones = Instance.new("UICorner")
EsqFunciones.CornerRadius = UDim.new(0, 8)
EsqFunciones.Parent = ContFunciones

local BtnFunciones = Instance.new("TextButton")
BtnFunciones.Size = UDim2.new(1, 0, 1, 0)
BtnFunciones.BackgroundTransparency = 1
BtnFunciones.Text = "Funciones Players ↓"
BtnFunciones.TextColor3 = Color3.new(1,1,1)
BtnFunciones.Font = Enum.Font.GothamSemibold
BtnFunciones.TextSize = 15
BtnFunciones.TextXAlignment = Enum.TextXAlignment.Left
BtnFunciones.Position = UDim2.new(0, 12, 0, 0)
BtnFunciones.Parent = ContFunciones

local PanelFunciones = Instance.new("Frame")
PanelFunciones.Size = UDim2.new(1, 0, 0, 0)
PanelFunciones.Position = UDim2.new(0, 0, 1, 5)
PanelFunciones.BackgroundColor3 = Color3.new(0.15, 0.15, 0.2)
PanelFunciones.Visible = false
PanelFunciones.Parent = ContFunciones

local EsqPanelFunciones = Instance.new("UICorner")
EsqPanelFunciones.CornerRadius = UDim.new(0, 8)
EsqPanelFunciones.Parent = PanelFunciones

local ListaFunciones = Instance.new("UIListLayout")
ListaFunciones.Padding = UDim.new(0, 6)
ListaFunciones.Parent = PanelFunciones

-- Variables generales
local Activo = {
    -- Players
    EspJugadores = false,
    EspItems = false,
    AutoRecoger = false,
    Noclip = false,
    AutoAbrir = false,
    Dios = false,
    Resistencia = false,
    AuraMata = false,
    -- Piggy
    EspJugadoresPiggy = false,
    AuraMatarPiggy = false,
    HitBoxGrande = false,
    VelocidadSalto = false
}

-- Función para crear interruptores
local function CrearOpcion(nombre, clave)
    local Fila = Instance.new("Frame")
    Fila.Size = UDim2.new(1, -16, 0, 32)
    Fila.BackgroundTransparency = 1
    Fila.Parent = PanelFunciones

    local Texto = Instance.new("TextLabel")
    Texto.Size = UDim2.new(1, -40, 1, 0)
    Texto.Position = UDim2.new(0, 5, 0, 0)
    Texto.BackgroundTransparency = 1
    Texto.Text = nombre
    Texto.TextColor3 = Color3.new(0.9,0.9,0.9)
    Texto.Font = Enum.Font.Gotham
    Texto.TextSize = 14
    Texto.TextXAlignment = Enum.TextXAlignment.Left
    Texto.Parent = Fila

    local Interruptor = Instance.new("TextButton")
    Interruptor.Size = UDim2.new(0, 30, 0, 20)
    Interruptor.Position = UDim2.new(1, -35, 0.5, -10)
    Interruptor.BackgroundColor3 = Color3.new(0.6, 0.2, 0.2)
    Interruptor.Text = "OFF"
    Interruptor.TextColor3 = Color3.new(1,1,1)
    Interruptor.Font = Enum.Font.GothamBold
    Interruptor.TextSize = 10
    Interruptor.BorderSizePixel = 0
    Interruptor.Parent = Fila

    local EsqInt = Instance.new("UICorner")
    EsqInt.CornerRadius = UDim.new(0, 5)
    EsqInt.Parent = Interruptor

    Interruptor.MouseButton1Click:Connect(function()
        Activo[clave] = not Activo[clave]
        if Activo[clave] then
            Interruptor.BackgroundColor3 = Color3.new(0.2, 0.7, 0.3)
            Interruptor.Text = "ON"
        else
            Interruptor.BackgroundColor3 = Color3.new(0.6, 0.2, 0.2)
            Interruptor.Text = "OFF"
        end
    end)
end

-- Opciones Players
CrearOpcion("Esp jugadores / Bots / Piggy", "EspJugadores")
CrearOpcion("Espiar todos los ítems", "EspItems")
CrearOpcion("Auto Recoger ítems", "AutoRecoger")
CrearOpcion("Noclip (atravesar paredes)", "Noclip")
CrearOpcion("Abrir puertas automáticamente", "AutoAbrir")
CrearOpcion("Modo Dios (Invencible)", "Dios")
CrearOpcion("Resistencia Infinita", "Resistencia")
CrearOpcion("Aura de Matar", "AuraMata")

local FuncionesAbierto = false
BtnFunciones.MouseButton1Click:Connect(function()
    FuncionesAbierto = not FuncionesAbierto
    if FuncionesAbierto then
        PanelFunciones.Visible = true
        PanelFunciones.Size = UDim2.new(1,0,0, 320)
        BtnFunciones.Text = "Funciones Players ↑"
        ContFunciones.Size = UDim2.new(1,0,0, 370)
    else
        PanelFunciones.Visible = false
        PanelFunciones.Size = UDim2.new(1,0,0,0)
        BtnFunciones.Text = "Funciones Players ↓"
        ContFunciones.Size = UDim2.new(1,0,0,40)
    end
    task.wait(0.05)
    Contenido.CanvasSize = UDim2.new(0,0,Lista.AbsoluteContentSize.Y,0)
end)

-- ==================================
-- PASO 6: SECCIÓN FUNCIONES DE PIGGY
-- ==================================
local ContPiggy = Instance.new("Frame")
ContPiggy.Size = UDim2.new(1, 0, 0, 40)
ContPiggy.BackgroundColor3 = Color3.new(0.2, 0.2, 0.25)
ContPiggy.BorderSizePixel = 0
ContPiggy.Parent = Contenido

local EsqContPiggy = Instance.new("UICorner")
EsqContPiggy.CornerRadius = UDim.new(0, 8)
EsqContPiggy.Parent = ContPiggy

local BtnPiggy = Instance.new("TextButton")
BtnPiggy.Size = UDim2.new(1, 0, 1, 0)
BtnPiggy.BackgroundTransparency = 1
BtnPiggy.Text = "Funciones de Piggy ↓"
BtnPiggy.TextColor3 = Color3.new(1,1,1)
BtnPiggy.Font = Enum.Font.GothamSemibold
BtnPiggy.TextSize = 15
BtnPiggy.TextXAlignment = Enum.TextXAlignment.Left
BtnPiggy.Position = UDim2.new(0, 12, 0, 0)
BtnPiggy.Parent = ContPiggy

local PanelPiggy = Instance.new("Frame")
PanelPiggy.Size = UDim2.new(1, 0, 0, 0)
PanelPiggy.Position = UDim2.new(0, 0, 1, 5)
PanelPiggy.BackgroundColor3 = Color3.new(0.15, 0.15, 0.2)
PanelPiggy.Visible = false
PanelPiggy.Parent = ContPiggy

local EsqPanelPiggy = Instance.new("UICorner")
EsqPanelPiggy.CornerRadius = UDim.new(0, 8)
EsqPanelPiggy.Parent = PanelPiggy

local ListaPiggy = Instance.new("UIListLayout")
ListaPiggy.Padding = UDim.new(0, 6)
ListaPiggy.Parent = PanelPiggy

-- Opciones para Piggy
CrearOpcion("Espiar Jugadores", "EspJugadoresPiggy")
CrearOpcion("Aura de Matar Jugadores", "AuraMatarPiggy")
CrearOpcion("Hit Box Ampliada", "HitBoxGrande")
CrearOpcion("Velocidad + Salto Mejorado 🦘", "VelocidadSalto")

local PiggyAbierto = false
BtnPiggy.MouseButton1Click:Connect(function()
    PiggyAbierto = not PiggyAbierto
    if PiggyAbierto then
        PanelPiggy.Visible = true
        PanelPiggy.Size = UDim2.new(1,0,0, 170)
        BtnPiggy.Text = "Funciones de Piggy ↑"
        ContPiggy.Size = UDim2.new(1,0,0, 220)
    else
        PanelPiggy.Visible = false
        PanelPiggy.Size = UDim2.new(1,0,0,0)
        BtnPiggy.Text = "Funciones de Piggy ↓"
        ContPiggy.Size = UDim2.new(1,0,0,40)
    end
    task.wait(0.05)
    Contenido.CanvasSize = UDim2.new(0,0,Lista.AbsoluteContentSize.Y,0)
end)

-- ==================================
-- LÓGICA DE TODAS LAS FUNCIONES
-- ==================================
local Personaje = Jugador.Character or Jugador.CharacterAdded:Wait()
local Humanoide = Personaje:WaitForChild("Humanoid")
local Raiz = Personaje:WaitForChild("HumanoidRootPart")

Jugador.CharacterAdded:Connect(function(nuevo)
    Personaje = nuevo
    Humanoide = nuevo:WaitForChild("Humanoid")
    Raiz = nuevo:WaitForChild("HumanoidRootPart")
end)

-- Limpiar marcadores viejos
local function LimpiarMarcadores()
    for _, v in ipairs(Pantalla:GetChildren()) do
        if v:IsA("SelectionBox") and (v.Name == "EspMarcado" or v.Name == "EspItem" or v.Name == "EspPiggy") then
            v:Destroy()
        end
    end
end

Tiempo.Heartbeat:Connect(function()
    if not Humanoide or Humanoide.Health <= 0 then return end

    -- Limpiar cada cierto tiempo
    LimpiarMarcadores()

    -- -------------------
    -- Funciones Players
    -- -------------------
    if Activo.Dios then
        Humanoide.MaxHealth = math.huge
        Humanoide.Health = math.huge
    end

    if Activo.Noclip then
        for _, parte in ipairs(Personaje:GetDescendants()) do
            if parte:IsA("BasePart") then
                parte.CanCollide = false
            end
        end
    end

    if Activo.Resistencia and Humanoide:FindFirstChild("Stamina") then
        Humanoide.Stamina.Value = 100
    end

    if Activo.EspJugadores then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and obj ~= Personaje and (obj:FindFirstChild("Humanoid") or obj.Name:find("Piggy") or obj.Name:find("Bot")) then
                local parte = obj:FindFirstChildOfClass("BasePart")
                if parte then
                    local borde = Instance.new("SelectionBox")
                    borde.Name = "EspMarcado"
                    borde.Color3 = obj.Name:find("Piggy") and Color3.new(1,0,0) or Color3.new(0,0.5,1)
                    borde.Adornee = parte
                    borde.Parent = Pantalla
                end
            end
        end
    end

    if Activo.EspItems then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and (obj.Name:find("Key") or obj.Name:find("Item") or obj.Name:find("Tool")) then
                local parte = obj:FindFirstChild("Handle") or obj:FindFirstChildOfClass("BasePart")
                if parte then
                    local borde = Instance.new("SelectionBox")
                    borde.Name = "EspItem"
                    borde.Color3 = Color3.new(0,1,0)
                    borde.Adornee = parte
                    borde.Parent = Pantalla
                end
            end
        end
    end

    if Activo.AutoRecoger then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and (obj.Name:find("Key") or obj.Name:find("Item")) then
                local parte = obj:FindFirstChildOfClass("BasePart")
                if parte and (parte.Position - Raiz.Position).Magnitude < 12 then
                    local prompt = parte:FindFirstChildOfClass("ProximityPrompt")
                    if prompt then fireproximityprompt(prompt) end
                end
            end
        end
    end

    if Activo.AutoAbrir and Humanoide:FindFirstChildOfClass("Tool") then
        for _, puerta in ipairs(workspace:GetDescendants()) do
            if puerta.Name:find("Door") and (puerta.Position - Raiz.Position).Magnitude < 10 then
                local prompt = puerta:FindFirstChildOfClass("ProximityPrompt")
                if prompt then fireproximityprompt(prompt) end
            end
        end
    end

    if Activo.AuraMata and Humanoide:FindFirstChildOfClass("Tool") then
        for _, objetivo in ipairs(workspace:GetDescendants()) do
            if objetivo:IsA("Model") and objetivo ~= Personaje and objetivo:FindFirstChild("Humanoid") and (objetivo.HumanoidRootPart.Position - Raiz.Position).Magnitude < 15 then
                firetouchinterest(Raiz, objetivo.HumanoidRootPart, 0)
                task.wait(0.05)
                firetouchinterest(Raiz, objetivo.HumanoidRootPart, 1)
            end
        end
    end

    -- -------------------
    -- Funciones Piggy
    -- -------------------
    if Activo.EspJugadoresPiggy then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and obj ~= Personaje and obj:FindFirstChild("Humanoid") and not obj.Name:find("Piggy") and not obj.Name:find("Bot") then
                local parte = obj:FindFirstChildOfClass("BasePart")
                if parte then
                    local borde = Instance.new("SelectionBox")
                    borde.Name = "EspPiggy"
                    borde.Color3 = Color3.new(1, 0.8, 0) -- Amarillo para jugadores
                    borde.Adornee = parte
                    borde.Parent = Pantalla
                end
            end
        end
    end

    if Activo.AuraMatarPiggy then
        for _, objetivo in ipairs(workspace:GetDescendants()) do
            if objetivo:IsA("Model") and objetivo ~= Personaje and objetivo:FindFirstChild("Humanoid") and not objetivo.Name:find("Piggy") and not objetivo.Name:find("Bot") then
                local distancia = (objetivo.HumanoidRootPart.Position - Raiz.Position).Magnitude
                if distancia < (Activo.HitBoxGrande and 25 or 12) then
                    firetouchinterest(Raiz, objetivo.HumanoidRootPart, 0)
                    task.wait(0.03)
                    firetouchinterest(Raiz, objetivo.HumanoidRootPart, 1)
                end
            end
        end
    end

    if Activo.VelocidadSalto then
        Humanoide.WalkSpeed = 55
        Humanoide.JumpPower = 85
    else
        -- Volver a valores normales si se apaga
        Humanoide.WalkSpeed = 20
        Humanoide.JumpPower = 50
    end

end)

-- ==================================
-- CONTROL DE ARRASTRE Y BOTONES
-- ==================================
local Arrastrando = false
local InicioPos, InicioRaton

BarraSuperior.InputBegan:Connect(function(e)
    if e.UserInputType == Enum.UserInputType.MouseButton1 or e.UserInputType == Enum.UserInputType.Touch then
        Arrastrando = true
        InicioPos = Ventana.Position
        InicioRaton = Entrada:GetMouseLocation()
    end
end)

Entrada.InputChanged:Connect(function(e)
    if Arrastrando and (e.UserInputType == Enum.UserInputType.MouseMovement or e.UserInputType == Enum.UserInputType.Touch) then
        local act = Entrada:GetMouseLocation()
        local dif = act - InicioRaton
        Ventana.Position = UDim2.new(InicioPos.X.Scale, InicioPos.X.Offset + dif.X, InicioPos.Y.Scale, InicioPos.Y.Offset + dif.Y)
    end
end)

Entrada.InputEnded:Connect(function(e)
    if e.UserInputType == Enum.UserInputType.MouseButton1 or e.UserInputType == Enum.UserInputType.Touch then
        Arrastrando = false
    end
end)

BotonOcultar.MouseButton1Click:Connect(function()
    Ventana.Visible = false
    BotonMostrar.Visible = true
end)

BotonMostrar.MouseButton1Click:Connect(function()
    Ventana.Visible = true
    BotonMostrar.Visible = false
end)

-- Sombra
local Sombra = Instance.new("ImageLabel")
Sombra.BackgroundTransparency = 1
Sombra.Size = UDim2.new(1,30,1,30)
Sombra.Position = UDim2.new(0,-15,0,-15)
Sombra.Image = "rbxassetid://1316045217"
Sombra.ImageColor3 = Color3.new(0,0,0)
Sombra.ImageTransparency = 0.6
Sombra.ScaleType = Enum.ScaleType.Slice
Sombra.SliceCenter = Rect.new(10,10,118,118)
Sombra.Parent = Ventana
