JoseAngel_Blox Bonds - Farmeador de Bonds para Dead Rails
    Compatible con Delta Executor
    Versión: 1.0
]]

local Player = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- Configuración
local Config = {
    AutoCollect = true,      -- Auto recolectar bonds
    AutoFarm = true,         -- Modo farmeo automático
    TeleportToBonds = true,  -- Teletransportarse a los bonds
    FarmRadius = 500,        -- Radio de búsqueda (estuds)
    WaitTime = 1,            -- Tiempo entre acciones (segundos)
    SafeMode = true          -- Evita caídas / zonas peligrosas
}

-- UI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ToggleAutoFarm = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")
local Credits = Instance.new("TextLabel")

ScreenGui.Name = "JoseAngelBondsGUI"
ScreenGui.Parent = game:GetService("CoreGui")

MainFrame.Size = UDim2.new(0, 350, 0, 250)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Esquinas redondeadas
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Título
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
Title.Text = "JoseAngel_Blox Bonds"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- Botón Auto Farm
ToggleAutoFarm.Size = UDim2.new(0, 200, 0, 45)
ToggleAutoFarm.Position = UDim2.new(0.5, -100, 0, 70)
ToggleAutoFarm.BackgroundColor3 = Color3.fromRGB(0, 170, 85)
ToggleAutoFarm.Text = "▶ INICIAR FARMEO"
ToggleAutoFarm.TextColor3 = Color3.new(1, 1, 1)
ToggleAutoFarm.TextScaled = true
ToggleAutoFarm.Font = Enum.Font.GothamBold
ToggleAutoFarm.Parent = MainFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = ToggleAutoFarm

-- Estado
StatusLabel.Size = UDim2.new(1, 0, 0, 40)
StatusLabel.Position = UDim2.new(0, 0, 0, 140)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Estado: Esperando..."
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusLabel.TextScaled = true
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Parent = MainFrame

-- Créditos
Credits.Size = UDim2.new(1, 0, 0, 30)
Credits.Position = UDim2.new(0, 0, 0, 220)
Credits.BackgroundTransparency = 1
Credits.Text = "by JoseAngel_Blox | Delta Executor"
Credits.TextColor3 = Color3.fromRGB(150, 150, 150)
Credits.TextScaled = true
Credits.Font = Enum.Font.Gotham
Credits.Parent = MainFrame

-- Variables internas
local Farming = false
local CurrentTarget = nil

-- Función para encontrar bonds cercanos
local function GetNearestBond()
    local closest = nil
    local shortestDist = Config.FarmRadius
    local character = Player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return nil end
    local rootPos = character.HumanoidRootPart.Position
    
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name:lower():find("bond") or v.Name:lower():find("coin") then
            local dist = (v.Position - rootPos).Magnitude
            if dist < shortestDist then
                shortestDist = dist
                closest = v
            end
        end
    end
    return closest
end

-- Teletransporte seguro
local function TeleportTo(position)
    local character = Player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = CFrame.new(position)
        task.wait(0.1)
    end
end

-- Auto recolectar
local function CollectBond(bond)
    if bond and bond.Parent then
        local character = Player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            if Config.TeleportToBonds then
                TeleportTo(bond.Position + Vector3.new(0, 2, 0))
            end
            -- Simular toque (touch)
            firetouchinterest(character.HumanoidRootPart, bond, 0)
            task.wait(0.1)
            firetouchinterest(character.HumanoidRootPart, bond, 1)
        end
    end
end

-- Loop principal de farmeo
local function FarmLoop()
    while Farming do
        task.wait(Config.WaitTime)
        local bond = GetNearestBond()
        if bond then
            StatusLabel.Text = "Estado: Recolectando Bond..."
            CollectBond(bond)
            StatusLabel.Text = "Estado: Bond recolectado ✅"
        else
            StatusLabel.Text = "Estado: Buscando Bonds..."
        end
    end
end

-- Control del farmeo
local function StartFarming()
    if Farming then return end
    Farming = true
    StatusLabel.Text = "Estado: Farmeando Bonds..."
    ToggleAutoFarm.Text = "⏹ DETENER FARMEO"
    ToggleAutoFarm.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    task.spawn(FarmLoop)
end

local function StopFarming()
    Farming = false
    StatusLabel.Text = "Estado: Detenido"
    ToggleAutoFarm.Text = "▶ INICIAR FARMEO"
    ToggleAutoFarm.BackgroundColor3 = Color3.fromRGB(0, 170, 85)
    CurrentTarget = nil
end

-- Botón toggle
ToggleAutoFarm.MouseButton1Click:Connect(function()
    if Farming then
        StopFarming()
    else
        StartFarming()
    end
end)

-- Mover UI con mouse
local dragging = false
local dragStart
local startPos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

print("✅ JoseAngel_Blox Bonds cargado correctamente
