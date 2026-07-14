-- =========================================================
-- Script: Fly Jungle events obbys (Universal PC/Mobile)
-- Creado por: JoseAngel_Blox
-- =========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- Variables
local flying = false
local flySpeed = 50
local flyLoop = nil
local BodyVelocity = nil
local BodyGyro = nil
local verticalMovement = 0 -- 1 (arriba), -1 (abajo), 0 (quieto)

-- =========================================================
-- CREACIÓN DE LA INTERFAZ GUI (REFORZADA PARA MÓVIL)
-- =========================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JungleJungleGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 350) -- Un poco más alto para botones extra
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(24, 46, 24)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

-- Título y otros elementos (omito repetir todo el estilo para brevedad, igual al anterior)
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "Fly Jungle events obbys"
Title.TextColor3 = Color3.fromRGB(163, 224, 104)
Title.Font = Enum.Font.FredokaOne
Title.TextSize = 22

-- (Nota: Puedes mantener los botones de pestañas igual que antes para ahorrar espacio)

-- =========================================================
-- OPCIÓN MAIN (BOTONES MÓVIL/PC)
-- =========================================================
local MainContainer = Instance.new("Frame", MainFrame)
MainContainer.Size = UDim2.new(1, 0, 0, 250)
MainContainer.Position = UDim2.new(0, 0, 0, 60)
MainContainer.BackgroundTransparency = 1

local FlyToggle = Instance.new("TextButton", MainContainer)
FlyToggle.Size = UDim2.new(0, 200, 0, 45)
FlyToggle.Position = UDim2.new(0.5, -100, 0, 10)
FlyToggle.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
FlyToggle.Text = "Fly: OFF"
FlyToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyToggle.Font = Enum.Font.GothamBold
Instance.new("UICorner", FlyToggle).CornerRadius = UDim.new(0, 8)

-- Botones para Celular (Subir/Bajar)
local BtnUp = Instance.new("TextButton", MainContainer)
BtnUp.Text = "Subir (▲)"
BtnUp.Size = UDim2.new(0, 80, 0, 40)
BtnUp.Position = UDim2.new(0.5, -90, 0, 70)
BtnUp.BackgroundColor3 = Color3.fromRGB(76, 133, 44)
Instance.new("UICorner", BtnUp).CornerRadius = UDim.new(0, 8)

local BtnDown = Instance.new("TextButton", MainContainer)
BtnDown.Text = "Bajar (▼)"
BtnDown.Size = UDim2.new(0, 80, 0, 40)
BtnDown.Position = UDim2.new(0.5, 10, 0, 70)
BtnDown.BackgroundColor3 = Color3.fromRGB(76, 133, 44)
Instance.new("UICorner", BtnDown).CornerRadius = UDim.new(0, 8)

-- Lógica para botones de altura
BtnUp.MouseButton1Down:Connect(function() verticalMovement = 1 end)
BtnUp.MouseButton1Up:Connect(function() verticalMovement = 0 end)
BtnDown.MouseButton1Down:Connect(function() verticalMovement = -1 end)
BtnDown.MouseButton1Up:Connect(function() verticalMovement = 0 end)

-- (Mantén aquí el código de los botones de velocidad '+' y '-' del script anterior)

-- =========================================================
-- LÓGICA UNIVERSAL (FUNCIONA EN CUALQUIER PLATAFORMA)
-- =========================================================
local function startFly()
    local char = LocalPlayer.Character
    local root = char and (char:FindFirstChild("HumanoidRootPart"))
    local humanoid = char and char:FindFirstChildOfClass("Humanoid")
    if not root or not humanoid then return end

    flying = true
    FlyToggle.Text = "Fly: ON"
    FlyToggle.BackgroundColor3 = Color3.fromRGB(76, 133, 44)
    humanoid.PlatformStand = true

    BodyGyro = Instance.new("BodyGyro", root)
    BodyGyro.P = 9e4
    BodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    BodyGyro.cframe = root.CFrame

    BodyVelocity = Instance.new("BodyVelocity", root)
    BodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)

    flyLoop = RunService.RenderStepped:Connect(function()
        if not flying then return end
        
        -- Movimiento basado en la dirección del Humanoide (Joystick móvil o WASD)
        local moveDir = humanoid.MoveDirection
        
        -- Si no te mueves, nos quedamos quietos, pero respetamos los botones de subir/bajar
        local velocity = (moveDir * flySpeed) + (Vector3.new(0, 1, 0) * verticalMovement * flySpeed)
        
        BodyVelocity.Velocity = velocity
        BodyGyro.cframe = Camera.CFrame
    end)
end

local function stopFly()
    flying = false
    FlyToggle.Text = "Fly: OFF"
    FlyToggle.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
    if flyLoop then flyLoop:Disconnect() end
    if BodyVelocity then BodyVelocity:Destroy() end
    if BodyGyro then BodyGyro:Destroy() end
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character.Humanoid.PlatformStand = false
    end
end

FlyToggle.MouseButton1Click:Connect(function()
    if flying then stopFly() else startFly() end
end)
