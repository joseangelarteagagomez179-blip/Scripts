-- =============================================
-- JoseAngel_Blox Piggy PRO - Versión 1.1
-- Creado por JoseAngel_Blox - 07/06/2026
-- Script 100% sin librerías externas - Compatible PC y Celular
-- =============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Camera = Workspace.CurrentCamera

local config = {}
local configFile = "JoseAngel_Blox_Piggy_PRO_Config.json"

-- Cargar configuración guardada (se guarda automáticamente)
local function loadConfig()
    local success, data = pcall(function()
        return game:GetService("HttpService"):JSONDecode(readfile(configFile))
    end)
    if success then
        config = data
    else
        config = {
            Godmode = false,
            ESP = false,
            Noclip = false,
            AutoGrab = false,
            Fly = false,
            Speed = 50,
            WalkSpeed = 16,
            InfiniteJump = false
        }
    end
end

-- Guardar configuración
local function saveConfig()
    pcall(function()
        writefile(configFile, game:GetService("HttpService"):JSONEncode(config))
    end)
end

-- Crear GUI simple (sin librerías externas - usa solo CanvasGroup y TextButton)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox_Piggy_PRO"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "Main"
MainFrame.Size = UDim2.new(0, 380, 0, 520)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -260)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -100, 1, 0)
TitleLabel.Position = UDim2.new(0, 20, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "JoseAngel_Blox Piggy PRO"
TitleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
TitleLabel.TextSize = 22
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Parent = TitleBar

local VersionLabel = Instance.new("TextLabel")
VersionLabel.Size = UDim2.new(0, 100, 0, 30)
VersionLabel.Position = UDim2.new(1, -110, 0, 10)
VersionLabel.BackgroundTransparency = 1
VersionLabel.Text = "v1.1 | 07/06/2026"
VersionLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
VersionLabel.TextSize = 14
VersionLabel.Font = Enum.Font.Gotham
VersionLabel.Parent = TitleBar

local InfoButton = Instance.new("TextButton")
InfoButton.Size = UDim2.new(0, 50, 0, 40)
InfoButton.Position = UDim2.new(1, -60, 0, 5)
InfoButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
InfoButton.Text = "↓"
InfoButton.TextColor3 = Color3.new(1, 1, 1)
InfoButton.TextSize = 28
InfoButton.Font = Enum.Font.GothamBold
InfoButton.Parent = TitleBar

local InfoCorner = Instance.new("UICorner")
InfoCorner.CornerRadius = UDim.new(0, 8)
InfoCorner.Parent = InfoButton

-- Información (se abre con el botón ↓)
local InfoFrame = Instance.new("Frame")
InfoFrame.Name = "Info"
InfoFrame.Size = UDim2.new(0, 300, 0, 200)
InfoFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
InfoFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
InfoFrame.Visible = false
InfoFrame.Parent = MainFrame

local InfoCorner = Instance.new("UICorner")
InfoCorner.CornerRadius = UDim.new(0, 12)
InfoCorner.Parent = InfoFrame

local InfoTitle = Instance.new("TextLabel")
InfoTitle.Size = UDim2.new(1, 0, 0, 40)
InfoTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
InfoTitle.Text = "Creador: JoseAngel_Blox"
InfoTitle.TextColor3 = Color3.new(1, 1, 1)
InfoTitle.TextSize = 18
InfoTitle.Font = Enum.Font.GothamBold
InfoTitle.Parent = InfoFrame

local InfoText = Instance.new("TextLabel")
InfoText.Size = UDim2.new(1, -20, 0, 120)
InfoText.Position = UDim2.new(0, 10, 0, 50)
InfoText.BackgroundTransparency = 1
InfoText.Text = [[Nombre del Creador: JoseAngel_Blox
Fecha de lanzamiento: 07/06/2026
Versión: 1.1

Godmode • ESP • Noclip • Auto Grab
Fly • Speed +50 • Infinite Jump

Funciona en PC y Celular (tocando botones)]
InfoText.TextColor3 = Color3.new(1, 1, 1)
InfoText.TextSize = 15
InfoText.TextWrapped = true
InfoText.Font = Enum.Font.Gotham
InfoText.Parent = InfoFrame

local InfoClose = Instance.new("TextButton")
InfoClose.Size = UDim2.new(0, 30, 0, 30)
InfoClose.Position = UDim2.new(1, -40, 0, 5)
InfoClose.BackgroundTransparency = 1
InfoClose.Text = "X"
InfoClose.TextColor3 = Color3.fromRGB(255, 50, 50)
InfoClose.TextSize = 24
InfoClose.Parent = InfoFrame

-- Crear botones de Main
local function createToggle(name, y, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 50)
    btn.Position = UDim2.new(0.05, 0, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    btn.Text = name .. ": OFF"
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextSize = 18
    btn.Font = Enum.Font.Gotham
    btn.Parent = MainFrame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn

    local state = false
    local conn
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = name .. (state and ": ON" or ": OFF")
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(40, 40, 60)
        callback(state)
        saveConfig()
    end)
    return btn
end

-- Crear sliders
local function createSlider(name, y, minVal, maxVal, defaultVal, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(0.9, 0, 0, 70)
    sliderFrame.Position = UDim2.new(0.05, 0, 0, y)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    sliderFrame.Parent = MainFrame

    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 8)
    sliderCorner.Parent = sliderFrame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 30)
    label.BackgroundTransparency = 1
    label.Text = name .. ": " .. defaultVal
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextSize = 16
    label.Parent = sliderFrame

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(0.85, 0, 0, 8)
    bar.Position = UDim2.new(0.075, 0, 0, 40)
    bar.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    bar.Parent = sliderFrame

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    fill.Parent = bar

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 12, 0, 12)
    knob.Position = UDim2.new((defaultVal - minVal) / (maxVal - minVal), -6, 0.5, -6)
    knob.BackgroundColor3 = Color3.new(1, 1, 1)
    knob.Parent = bar

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = knob

    local dragging = false
    knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local relX = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            local val = math.floor(minVal + (maxVal - minVal) * relX + 0.5)
            fill.Size = UDim2.new(relX, 0, 1, 0)
            knob.Position = UDim2.new(relX, -6, 0.5, -6)
            label.Text = name .. ": " .. val
            callback(val)
        end
    end)
end

-- =============================================
-- FUNCIONES DE SCRIPT
-- =============================================
loadConfig()

local espHighlights = {}
local connections = {}

local function setupESP()
    if config.ESP then
        -- Piggy ESP (busca NPC)
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj.Name:lower():find("piggy") or obj.Name:lower():find("npc") then
                local hl = Instance.new("Highlight")
                hl.FillColor = Color3.fromRGB(255, 0, 0)
                hl.OutlineColor = Color3.new(1, 1, 1)
                hl.FillTransparency = 0.7
                hl.Parent = obj
                table.insert(espHighlights, hl)
            end
        end

        -- Player ESP
        for _, plr in pairs(Players:GetPlayers()) do
            if plr \~= LocalPlayer and plr.Character then
                local hl = Instance.new("Highlight")
                hl.FillColor = Color3.fromRGB(0, 255, 255)
                hl.OutlineColor = Color3.new(1, 1, 1)
                hl.Parent = plr.Character
                table.insert(espHighlights, hl)
            end
        end
    else
        for _, hl in pairs(espHighlights) do hl:Destroy() end
        espHighlights = {}
    end
end

-- Godmode (inf HP + anti-stun)
local godConn
local function toggleGodmode(state)
    if state then
        godConn = RunService.Heartbeat:Connect(function()
            if Character and Humanoid then
                Humanoid.MaxHealth = 9999
                Humanoid.Health = 9999
                -- Anti-stun
                if Humanoid:FindFirstChild("IsStunned") then
                    Humanoid.IsStunned.Value = false
                end
            end
        end)
    else
        if godConn then godConn:Disconnect() end
    end
end

-- Noclip
local noclipConn
local function toggleNoclip(state)
    if state then
        noclipConn = RunService.Stepped:Connect(function()
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end)
    else
        if noclipConn then noclipConn:Disconnect() end
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = true end
        end
    end
end

-- Auto Grab Items
local autoGrabConn
local function toggleAutoGrab(state)
    if state then
        autoGrabConn = RunService.Heartbeat:Connect(function()
            for _, item in pairs(Workspace:GetDescendants()) do
                if item:IsA("Tool") or (item:FindFirstChild("Handle") and item.Handle:IsA("BasePart")) then
                    local mag = (item.Position - RootPart.Position).Magnitude
                    if mag < 15 then
                        firetouchinterest(RootPart, item, 0)
                        firetouchinterest(RootPart, item, 1)
                    end
                end
            end
        end)
    else
        if autoGrabConn then autoGrabConn:Disconnect() end
    end
end

-- Fly (compatible PC y móvil)
local flyConnection
local isFlying = false
local flySpeed = 50
local function toggleFly(state)
    if state then
        isFlying = true
        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bv.Parent = RootPart

        local bg = Instance.new("BodyGyro")
        bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
        bg.P = 12500
        bg.Parent = RootPart

        flyConnection = RunService.RenderStepped:Connect(function()
            if not isFlying then return end
            local camCFrame = Camera.CFrame
            local move = Vector3.new()
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + camCFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - camCFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - camCFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + camCFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0, 1, 0) end

            bv.Velocity = move.Unit * flySpeed
            bg.CFrame = camCFrame
        end)
    else
        isFlying = false
        if flyConnection then flyConnection:Disconnect() end
        if RootPart:FindFirstChildOfClass("BodyVelocity") then RootPart:FindFirstChildOfClass("BodyVelocity"):Destroy() end
        if RootPart:FindFirstChildOfClass("BodyGyro") then RootPart:FindFirstChildOfClass("BodyGyro"):Destroy() end
    end
end

-- Infinite Jump
local infJumpConn
local function toggleInfiniteJump(state)
    if state then
        infJumpConn = UserInputService.JumpRequest:Connect(function()
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end)
    else
        if infJumpConn then infJumpConn:Disconnect() end
    end
end

-- Speed hack
local speedConn
local function setWalkSpeed(value)
    if speedConn then speedConn:Disconnect() end
    speedConn = RunService.Heartbeat:Connect(function()
        if Humanoid then Humanoid.WalkSpeed = value end
    end)
end

-- =============================================
-- EVENTOS
-- =============================================
Character.ChildAdded:Connect(function(child)
    if child.Name == "Humanoid" then
        Humanoid = child
        setupESP()
    end
end)

LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid")
    RootPart = newChar:WaitForChild("HumanoidRootPart")
    setupESP()
end)

InfoButton.MouseButton1Click:Connect(function()
    InfoFrame.Visible = not InfoFrame.Visible
end)

InfoClose.MouseButton1Click:Connect(function()
    InfoFrame.Visible = false
end)

-- Crear todos los toggles y sliders
createToggle("Godmode", 60, toggleGodmode)
createToggle("ESP", 120, function(v) config.ESP = v; setupESP() end)
createToggle("Noclip", 180, toggleNoclip)
createToggle("Auto Grab Items", 240, toggleAutoGrab)
createToggle("Fly (mantén presionado)", 300, toggleFly)
createToggle("Infinite Jump", 360, toggleInfiniteJump)

createSlider("Fly Speed", 420, 10, 100, config.Speed, function(v)
    config.Speed = v
    flySpeed = v
end)

createSlider("WalkSpeed", 480, 16, 100, config.WalkSpeed, function(v)
    config.WalkSpeed = v
    setWalkSpeed(v)
end)

-- Guardar al cerrar
MainFrame.AncestryChanged:Connect(function()
    saveConfig()
end)

-- Inicializar
setupESP()
Humanoid.WalkSpeed = config.WalkSpeed
setWalkSpeed(config.WalkSpeed)

print("✅ JoseAngel_Blox Piggy PRO cargado correctamente")
