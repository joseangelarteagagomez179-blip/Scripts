--[[
    1) INFO
    Nombre del Creador: JoseAngel_Blox
    Fecha de lanzamiento: 06/07/2026
    Versión: 1.2
    
    MANUAL DE USO:
    ¡Bienvenidos y bienvenidas al script JoseAngel_Blox! 
    Este sistema ha sido diseñado profesionalmente para ofrecerte la mejor experiencia de vuelo.
    
    COMO SE USA:
    - EN PC: Puedes activar o desactivar el modo de vuelo presionando la tecla 'F'. 
      Usa las teclas W, A, S, D para moverte. El personaje volará hacia donde apunte tu cámara.
    - EN MÓVIL: Verás un interruptor (Toggle) en la parte lateral de tu pantalla. 
      Al activarlo, usa el Joystick normal para desplazarte. La dirección se controla 
      moviendo la cámara con el dedo.
    - VELOCIDAD: Usa los botones [+] y [-] para ajustar qué tan rápido quieres ir.
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")
local camera = workspace.CurrentCamera

-- 2) MAIN (Lógica y UI)
local isFlying = false
local flySpeed = 50
local noclip = true -- El vuelo incluye noclip por defecto en este modo

-- Creación de la UI
local sg = Instance.new("ScreenGui")
sg.Name = "JoseAngel_Fly_UI"
sg.ResetOnSpawn = false
sg.Parent = player.PlayerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 180)
mainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = sg

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)
local stroke = Instance.new("UIStroke", mainFrame)
stroke.Color = Color3.fromRGB(80, 80, 80)
stroke.Thickness = 2

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "JoseAngel_Blox Fly"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.BackgroundTransparency = 1
title.Parent = mainFrame

-- Botón de Vuelo (Interruptor)
local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(0.8, 0, 0, 35)
toggle.Position = UDim2.new(0.1, 0, 0.25, 0)
toggle.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
toggle.Text = "VUELO: OFF"
toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
toggle.Font = Enum.Font.GothamBold
toggle.Parent = mainFrame
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 8)

-- Control de Velocidad
local speedDisplay = Instance.new("TextLabel")
speedDisplay.Size = UDim2.new(1, 0, 0, 30)
speedDisplay.Position = UDim2.new(0, 0, 0.5, 0)
speedDisplay.Text = "Velocidad: " .. flySpeed
speedDisplay.TextColor3 = Color3.fromRGB(200, 200, 200)
speedDisplay.BackgroundTransparency = 1
speedDisplay.Font = Enum.Font.Gotham
speedDisplay.Parent = mainFrame

local btnPlus = Instance.new("TextButton")
btnPlus.Size = UDim2.new(0.35, 0, 0, 30)
btnPlus.Position = UDim2.new(0.55, 0, 0.7, 0)
btnPlus.Text = "+"
btnPlus.Parent = mainFrame

local btnMinus = Instance.new("TextButton")
btnMinus.Size = UDim2.new(0.35, 0, 0, 30)
btnMinus.Position = UDim2.new(0.1, 0, 0.7, 0)
btnMinus.Text = "-"
btnMinus.Parent = mainFrame

-- Funcionalidad
local function setFly(state)
    isFlying = state
    if isFlying then
        toggle.Text = "VUELO: ON"
        toggle.BackgroundColor3 = Color3.fromRGB(60, 200, 60)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    else
        toggle.Text = "VUELO: OFF"
        toggle.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
        humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
    end
end

toggle.MouseButton1Click:Connect(function()
    setFly(not isFlying)
end)

btnPlus.MouseButton1Click:Connect(function()
    flySpeed = math.min(flySpeed + 10, 300)
    speedDisplay.Text = "Velocidad: " .. flySpeed
end)

btnMinus.MouseButton1Click:Connect(function()
    flySpeed = math.max(flySpeed - 10, 10)
    speedDisplay.Text = "Velocidad: " .. flySpeed
end)

-- Bucle de movimiento
RunService.RenderStepped:Connect(function()
    if isFlying and character:FindFirstChild("HumanoidRootPart") then
        local moveDir = humanoid.MoveDirection
        rootPart.Velocity = (camera.CFrame.LookVector * moveDir.Z + camera.CFrame.RightVector * moveDir.X).Unit * flySpeed
        
        -- Mantener posición si no hay entrada
        if moveDir.Magnitude == 0 then
            rootPart.Velocity = Vector3.new(0, 0.1, 0)
        end
        
        -- Noclip básico (Desactiva colisiones del personaje)
        if noclip then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- Soporte Tecla F
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.F then
        setFly(not isFlying)
    end
end)
