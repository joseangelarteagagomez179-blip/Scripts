--[[
    =========================================
    1) INFO
    =========================================
    Nombre del Creador: JoseAngel_Blox
    Fecha de lanzamiento: 06/07/2026
    Versión: 1.2

    MANUAL:
    ¡Bienvenidos y bienvenidas al script JoseAngel_Blox!

    Este sistema ha sido diseñado para ofrecerte la mejor experiencia de vuelo
    en cualquier juego de Roblox.

    MODO DE USO:
    - MÓVIL: Pulsa el interruptor profesional para activar el vuelo. 
      Usa el Joystick de tu pantalla para moverte. El personaje volará
      automáticamente hacia donde apunte tu cámara.

    - PC: Presiona la tecla 'F' para activar/desactivar el vuelo. 
      Usa las teclas W, A, S, D para desplazarte por el mapa.

    - VELOCIDAD: Puedes ajustar la potencia de vuelo usando los botones 
      [+] y [-] en el menú. La velocidad va de 10 a 400.
    =========================================
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")
local camera = workspace.CurrentCamera

-- Variables de Control
local isFlying = false
local flySpeed = 60
local bv, bg
local noclipConnection

-- =========================================
-- 2) MAIN (INTERFAZ Y LÓGICA)
-- =========================================

-- Crear Interfaz "Muy Bonita"
local sg = Instance.new("ScreenGui", player.PlayerGui)
sg.Name = "JoseAngel_Blox_Fly"
sg.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", sg)
mainFrame.Size = UDim2.new(0, 240, 0, 220)
mainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 15)

-- Borde brillante profesional
local stroke = Instance.new("UIStroke", mainFrame)
stroke.Color = Color3.fromRGB(0, 170, 255)
stroke.Thickness = 2

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 45)
title.Text = "JoseAngel_Blox Fly v1.2"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.BackgroundTransparency = 1

-- Botón Toggle Profesional
local toggleBtn = Instance.new("TextButton", mainFrame)
toggleBtn.Size = UDim2.new(0.85, 0, 0, 40)
toggleBtn.Position = UDim2.new(0.075, 0, 0.25, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
toggleBtn.Text = "VUELO: APAGADO"
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 14
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 8)

-- Control de Velocidad
local speedDisplay = Instance.new("TextLabel", mainFrame)
speedDisplay.Size = UDim2.new(1, 0, 0, 30)
speedDisplay.Position = UDim2.new(0, 0, 0.5, 0)
speedDisplay.Text = "Velocidad: " .. flySpeed
speedDisplay.TextColor3 = Color3.fromRGB(200, 200, 200)
speedDisplay.Font = Enum.Font.GothamSemibold
speedDisplay.BackgroundTransparency = 1

local btnMinus = Instance.new("TextButton", mainFrame)
btnMinus.Size = UDim2.new(0, 40, 0, 40)
btnMinus.Position = UDim2.new(0.2, 0, 0.7, 0)
btnMinus.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
btnMinus.Text = "-"
btnMinus.TextColor3 = Color3.new(1, 1, 1)
btnMinus.Font = Enum.Font.GothamBold
Instance.new("UICorner", btnMinus)

local btnPlus = Instance.new("TextButton", mainFrame)
btnPlus.Size = UDim2.new(0, 40, 0, 40)
btnPlus.Position = UDim2.new(0.63, 0, 0.7, 0)
btnPlus.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
btnPlus.Text = "+"
btnPlus.TextColor3 = Color3.new(1, 1, 1)
btnPlus.Font = Enum.Font.GothamBold
Instance.new("UICorner", btnPlus)

-- =========================================
-- LÓGICA DE VUELO Y NOCLIP
-- =========================================
local function setFlying(state)
    isFlying = state

    if isFlying then
        toggleBtn.Text = "VUELO: ENCENDIDO"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 220, 60)

        humanoid.PlatformStand = true

        bv = Instance.new("BodyVelocity", rootPart)
        bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
        bv.Velocity = Vector3.new(0, 0, 0)

        bg = Instance.new("BodyGyro", rootPart)
        bg.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
        bg.CFrame = rootPart.CFrame

        -- Noclip integrado
        noclipConnection = RunService.Stepped:Connect(function()
            if isFlying then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)

    else
        toggleBtn.Text = "VUELO: APAGADO"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        humanoid.PlatformStand = false

        if bv then bv:Destroy() end
        if bg then bg:Destroy() end
        if noclipConnection then noclipConnection:Disconnect() end
    end
end

-- Eventos de botones
toggleBtn.MouseButton1Click:Connect(function()
    setFlying(not isFlying)
end)

btnPlus.MouseButton1Click:Connect(function()
    flySpeed = math.min(flySpeed + 10, 400)
    speedDisplay.Text = "Velocidad: " .. flySpeed
end)

btnMinus.MouseButton1Click:Connect(function()
    flySpeed = math.max(flySpeed - 10, 10)
    speedDisplay.Text = "Velocidad: " .. flySpeed
end)

-- Loop de movimiento sincronizado (móvil + PC)
RunService.RenderStepped:Connect(function()
    if isFlying and rootPart and bv and bg then
        local moveDir = humanoid.MoveDirection

        if moveDir.Magnitude > 0 then
            -- La clave: convierte la dirección del joystick/teclado para que siga la cámara
            bv.Velocity = camera.CFrame:VectorToWorldSpace(camera.CFrame:VectorToObjectSpace(moveDir)) * flySpeed
        else
            bv.Velocity = Vector3.new(0, 0.1, 0) -- flotar en el sitio
        end

        -- Siempre mira hacia donde apunta la cámara
        bg.CFrame = camera.CFrame
    end
end)

-- Tecla F para PC
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.F then
        setFlying(not isFlying)
    end
end)
