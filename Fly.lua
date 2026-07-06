--[[
    Nombre: JoseAngel_Blox Fly
    Versión: 1.2.1 (Bug Fix)
    Mejoras: Joystick sincronizado, estabilidad de altura y noclip mejorado.
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")
local camera = workspace.CurrentCamera

-- Variables de Estado
local isFlying = false
local flySpeed = 60
local bv, bg -- Objetos de fuerza física

-- 1) Creación de la UI (Misma estética profesional)
local sg = Instance.new("ScreenGui", player.PlayerGui)
sg.Name = "JoseAngel_Fly_Fix"
sg.ResetOnSpawn = false

local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 200, 0, 160)
frame.Position = UDim2.new(0.05, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", frame)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "JoseAngel_Blox Fly"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold

local toggle = Instance.new("TextButton", frame)
toggle.Size = UDim2.new(0.8, 0, 0, 35)
toggle.Position = UDim2.new(0.1, 0, 0.3, 0)
toggle.Text = "VUELO: OFF"
toggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
toggle.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", toggle)

local speedLabel = Instance.new("TextLabel", frame)
speedLabel.Size = UDim2.new(1, 0, 0, 30)
speedLabel.Position = UDim2.new(0, 0, 0.55, 0)
speedLabel.Text = "Velocidad: " .. flySpeed
speedLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8)
speedLabel.BackgroundTransparency = 1

-- 2) Lógica de Vuelo Mejorada
local function startFlying()
    isFlying = true
    toggle.Text = "VUELO: ON"
    toggle.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    
    -- Desactivamos estado de caída para evitar que baje solo
    humanoid.PlatformStand = true 
    
    -- Creamos fuerzas físicas para estabilidad total
    bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
    bv.Velocity = Vector3.new(0, 0, 0)
    bv.Parent = rootPart
    
    bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
    bg.CFrame = rootPart.CFrame
    bg.Parent = rootPart
end

local function stopFlying()
    isFlying = false
    toggle.Text = "VUELO: OFF"
    toggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    
    humanoid.PlatformStand = false
    if bv then bv:Destroy() end
    if bg then bg:Destroy() end
end

toggle.MouseButton1Click:Connect(function()
    if isFlying then stopFlying() else startFlying() end
end)

-- 3) Control de movimiento (Fix de Joystick y PC)
RunService.RenderStepped:Connect(function()
    if isFlying and rootPart and bv and bg then
        local moveDir = humanoid.MoveDirection -- Dirección del Joystick/Teclado
        
        if moveDir.Magnitude > 0 then
            -- Esta es la clave: Convertimos la dirección del joystick para que siga a la cámara
            -- Sin importar si es móvil o PC
            bv.Velocity = camera.CFrame:VectorToWorldSpace(camera.CFrame:VectorToObjectSpace(moveDir)) * flySpeed
        else
            bv.Velocity = Vector3.new(0, 0, 0) -- Se queda quieto si no mueves el joystick
        end
        
        -- El personaje siempre mira hacia donde apunta la cámara
        bg.CFrame = camera.CFrame
        
        -- Noclip activo
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- Tecla F para PC
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.F then
        if isFlying then stopFlying() else startFlying() end
    end
end)
