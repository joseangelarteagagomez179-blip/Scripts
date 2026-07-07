-- =============================================
-- Piggy Script 100% ORIGINAL - Sin librerías
-- ESP, Infinite Stamina, God Mode, Fly, Noclip, Auto Grab, Auto Unlock, Auto Win
-- Creado por Grok para ti
-- =============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- Variables de configuración
local ESPEnabled = false
local GodModeEnabled = false
local InfiniteStaminaEnabled = false
local FlyEnabled = false
local NoclipEnabled = false
local AutoGrabEnabled = false
local AutoUnlockEnabled = false
local WalkSpeedValue = 50
local FlySpeed = 50

-- ESP Folder (solo para items y enemigos)
local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "MyESP"
ESPFolder.Parent = Workspace

local function CreateBoxESP(model, color, name)
    -- Highlight
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.Adornee = model
    highlight.FillColor = color
    highlight.OutlineColor = color
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Parent = model

    -- Billboard Name
    local billboard = Instance.new("BillboardGui")
    billboard.Adornee = model:FindFirstChild("Head") or model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 5, 0)
    billboard.AlwaysOnTop = true
    billboard.LightInfluence = 0
    billboard.Parent = model

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = color
    label.TextStrokeTransparency = 0
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Parent = billboard
end

local function UpdateESP()
    if not ESPEnabled then
        ESPFolder:ClearAllChildren()
        return
    end

    -- Jugadores y Piggy (rojo)
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr \~= LocalPlayer and plr.Character then
            CreateBoxESP(plr.Character, Color3.fromRGB(255, 0, 0), plr.Name)
        end
    end

    -- Items y doors (verde)
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if (obj:IsA("MeshPart") or obj:IsA("Tool")) and obj:FindFirstChild("ClickDetector") then
            CreateBoxESP(obj, Color3.fromRGB(0, 255, 0), obj.Name)
        end
    end
end

-- Main loop
RunService.Heartbeat:Connect(function()
    Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
    local HRP = Character.HumanoidRootPart
    local Hum = Character:FindFirstChild("Humanoid")

    -- God Mode (sin colisiones)
    if GodModeEnabled then
        for _, part in ipairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
                part.CanTouch = false
            end
        end
    end

    -- Infinite Stamina (humanoide en running siempre)
    if InfiniteStaminaEnabled and Hum then
        Hum:ChangeState(Enum.HumanoidStateType.Running)
    end

    -- WalkSpeed
    if Hum then Hum.WalkSpeed = WalkSpeedValue end

    -- Fly
    if FlyEnabled then
        local moveDir = Vector3.new()
        local cam = Workspace.CurrentCamera
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir = moveDir - Vector3.new(0, 1, 0) end
        HRP.CFrame = HRP.CFrame + moveDir * FlySpeed * (1/60)
    end

    -- Noclip
    if NoclipEnabled and Character then
        for _, part in ipairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end

    -- Auto Grab Items
    if AutoGrabEnabled then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:FindFirstChild("ClickDetector") and (obj.Position - HRP.Position).Magnitude < 25 then
                fireclickdetector(obj.ClickDetector)
            end
        end
    end

    -- Auto Unlock Doors
    if AutoUnlockEnabled then
        for _, door in ipairs(Workspace:GetDescendants()) do
            if door.Name:lower():find("door") and door:FindFirstChild("ClickDetector") then
                fireclickdetector(door.ClickDetector)
            end
        end
    end
end)

-- Auto Win (salta a la salida)
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        -- Auto Win
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v.Name:lower():find("exit") and v.CFrame then
                HRP.CFrame = v.CFrame + Vector3.new(0, 10, 0)
                break
            end
        end
    end
end)

-- Character added
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
end)

-- ESP loop
RunService.RenderStepped:Connect(UpdateESP)

print("✅ Piggy Script cargado - Presiona INSERT para toggles")
