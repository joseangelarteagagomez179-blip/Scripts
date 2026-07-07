local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- === CONFIGURACIÓN ===
local ESPEnabled = false
local GodModeEnabled = false
local InfiniteStaminaEnabled = false
local FlyEnabled = false
local NoclipEnabled = false
local AutoGrabEnabled = false
local AutoUnlockEnabled = false
local WalkSpeedValue = 50

local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "PiggyESP"
ESPFolder.Parent = Workspace

local function CreateBoxESP(model, color, name)
    -- Highlight
    local hl = Instance.new("Highlight")
    hl.Adornee = model
    hl.FillColor = color
    hl.OutlineColor = color
    hl.FillTransparency = 0.5
    hl.OutlineTransparency = 0
    hl.Parent = model

    -- Nombre en pantalla
    local bg = Instance.new("BillboardGui")
    bg.Adornee = model:FindFirstChild("Head") or model:FindFirstChild("HumanoidRootPart")
    bg.Size = UDim2.new(0, 200, 0, 40)
    bg.StudsOffset = Vector3.new(0, 5, 0)
    bg.AlwaysOnTop = true
    bg.Parent = model

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,0,1,0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = color
    label.TextStrokeTransparency = 0
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Parent = bg
end

-- ESP automático (se actualiza cada frame)
RunService.RenderStepped:Connect(function()
    if not ESPEnabled then
        ESPFolder:ClearAllChildren()
        return
    end

    -- Jugadores y Piggy (rojo)
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr \~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
            CreateBoxESP(plr.Character, Color3.fromRGB(255, 0, 0), plr.Name)
        end
    end

    -- Items y puertas (verde)
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:FindFirstChild("ClickDetector") and (obj:IsA("MeshPart") or obj:IsA("Tool")) then
            CreateBoxESP(obj, Color3.fromRGB(0, 255, 0), obj.Name)
        end
    end
end)

-- LOOP PRINCIPAL
RunService.Heartbeat:Connect(function()
    Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
    local HRP = Character.HumanoidRootPart
    local Hum = Character:FindFirstChild("Humanoid")

    -- God Mode
    if GodModeEnabled then
        for _, part in ipairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
                part.CanTouch = false
            end
        end
    end

    -- Infinite Stamina
    if InfiniteStaminaEnabled and Hum then
        Hum:ChangeState(Enum.HumanoidStateType.Running)
    end

    -- WalkSpeed
    if Hum then Hum.WalkSpeed = WalkSpeedValue end

    -- Fly
    if FlyEnabled then
        local move = Vector3.new()
        local cam = Workspace.CurrentCamera
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0,1,0) end
        HRP.CFrame += move * 50 * (1/60)
    end

    -- Noclip
    if NoclipEnabled and Character then
        for _, part in ipairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end

    -- Auto Grab
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

-- Auto Win con INSERT
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v.Name:lower():find("exit") and v.CFrame then
                HRP.CFrame = v.CFrame + Vector3.new(0, 10, 0)
                break
            end
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
end)

print("✅ Script Piggy cargado correctamente - Presiona INSERT para toggles")
