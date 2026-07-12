-- Script corregido: JoseAngel_Blox Jungle Event
local MenuGui = Instance.new("ScreenGui")
MenuGui.Name = "JoseAngel_Blox_Menu"
MenuGui.Parent = game:GetService("CoreGui")

-- Crear la ventana principal
local Marco = Instance.new("Frame")
Marco.Parent = MenuGui
Marco.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Marco.Size = UDim2.new(0, 250, 0, 200)
Marco.Position = UDim2.new(0.5, -125, 0.4, -100)
Marco.Active = true
Marco.Draggable = true -- Se puede arrastrar en PC y móvil

-- Título Corregido
local Titulo = Instance.new("TextLabel")
Titulo.Parent = Marco
Titulo.Size = UDim2.new(1, 0, 0, 40)
Titulo.Text = "JoseAngel_Blox Jungle Event" -- Nombre corregido
Titulo.TextColor3 = Color3.fromRGB(255, 255, 255)
Titulo.BackgroundColor3 = Color3.fromRGB(85, 0, 170) 
Titulo.Font = Enum.Font.SourceSansBold
Titulo.TextSize = 16

-- Función para crear botones grandes
local function crearBoton(nombre, posicion, color)
    local btn = Instance.new("TextButton")
    btn.Parent = Marco
    btn.Size = UDim2.new(0.9, 0, 0, 50)
    btn.Position = posicion
    btn.Text = nombre
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 20
    return btn
end

local BotonPatear = crearBoton("Auto-Patear: OFF", UDim2.new(0.05, 0, 0.25, 0), Color3.fromRGB(200, 50, 50))
local BotonRecolectar = crearBoton("Auto-Recoger: OFF", UDim2.new(0.05, 0, 0.6, 0), Color3.fromRGB(200, 50, 50))

-- Variables
local autoPatear = false
local autoRecolectar = false
local jugador = game.Players.LocalPlayer

-- Lógica de los botones
BotonPatear.MouseButton1Click:Connect(function()
    autoPatear = not autoPatear
    BotonPatear.Text = autoPatear and "Auto-Patear: ON" or "Auto-Patear: OFF"
    BotonPatear.BackgroundColor3 = autoPatear and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

BotonRecolectar.MouseButton1Click:Connect(function()
    autoRecolectar = not autoRecolectar
    BotonRecolectar.Text = autoRecolectar and "Auto-Recoger: ON" or "Auto-Recoger: OFF"
    BotonRecolectar.BackgroundColor3 = autoRecolectar and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

-- Bucle principal
task.spawn(function()
    while task.wait(0.1) do
        -- Auto-Patear
        if autoPatear then
            local VirtualUser = game:GetService("VirtualUser")
            VirtualUser:ClickButton1(Vector2.new(0,0))
        end
        
        -- Auto-Recoger
        if autoRecolectar and jugador.Character and jugador.Character:FindFirstChild("HumanoidRootPart") then
            local root = jugador.Character.HumanoidRootPart
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("TouchInterest") and v.Parent then
                    if firetouchinterest then
                        firetouchinterest(root, v.Parent, 0)
                        firetouchinterest(root, v.Parent, 1)
                    end
                end
            end
        end
    end
end)
