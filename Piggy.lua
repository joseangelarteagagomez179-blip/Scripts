-- =============================================
-- JOSEANGEL_BLOX PIGGY PRO
-- Versión: 1.2 | Actualización: 10/07/2026
-- =============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

local Config = {
    AutoFarmCoins = false,
    Noclip = false,
    FlyEnabled = false,
    FlySpeed = 100,
    ESPEnabled = false,
    GodMode = false,
    InfiniteStamina = false,
    AutoGrabItems = false,
    SpeedBoost = false,
    AutoJump = false,
    KillOnTransform = false,
}

local PlayersList = {}
local ItemsFolder = workspace:WaitForChild("Items") -- ¡AJUSTA EL NOMBRE! (muchos mapas usan "ItemFolder1" o "GearFolder")
local ESPObjects = {}
local FlyConnection = nil
local SpeedConnection = nil
local JumpConnection = nil

local Plr = LocalPlayer
local Character = Plr.Character or Plr.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- ==================== GUI ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_BloxPiggyPro"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 520, 0, 620)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -310)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim2.new(0, 12)
MainCorner.Parent = MainFrame

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 60)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.Text = "JOSEANGEL_BLOX PIGGY PRO"
Title.TextColor3 = Color3.fromRGB(255, 50, 50)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame
local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim2.new(0, 12)
TitleCorner.Parent = Title

-- Menú horizontal
local MenuBar = Instance.new("Frame")
MenuBar.Size = UDim2.new(1, 0, 0, 50)
MenuBar.Position = UDim2.new(0, 0, 0, 60)
MenuBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MenuBar.Parent = MainFrame

local MenuLayout = Instance.new("UIListLayout")
MenuLayout.FillDirection = Enum.FillDirection.Horizontal
MenuLayout.SortOrder = Enum.SortOrder.LayoutOrder
MenuLayout.Padding = UDim.new(0, 4)
MenuLayout.Parent = MenuBar

local function CreateMenuButton(text, order)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.23, 0, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.LayoutOrder = order
    btn.Parent = MenuBar
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim2.new(0, 8)
    corner.Parent = btn
    return btn
end

local BtnInfo = CreateMenuButton("INFO", 1)
local BtnMain = CreateMenuButton("MAIN", 2)
local BtnPiggy = CreateMenuButton("ROL PIGGY", 3)

-- ==================== PANELES ====================
local InfoPanel = Instance.new("Frame")
InfoPanel.Size = UDim2.new(1, -20, 1, -140)
InfoPanel.Position = UDim2.new(0, 10, 0, 120)
InfoPanel.BackgroundTransparency = 1
InfoPanel.Visible = true
InfoPanel.Parent = MainFrame

local InfoLabel = Instance.new("TextLabel")
InfoLabel.Size = UDim2.new(1, 0, 1, 0)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = "Nombre del Creador: JoseAngel_Blox\nFecha de actualización: 10/07/2026\nVersión: 1.2"
InfoLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
InfoLabel.TextScaled = true
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.TextWrapped = true
InfoLabel.Parent = InfoPanel

local MainPanel = Instance.new("ScrollingFrame")
MainPanel.Size = UDim2.new(1, -20, 1, -140)
MainPanel.Position = UDim2.new(0, 10, 0, 120)
MainPanel.BackgroundTransparency = 1
MainPanel.Visible = false
MainPanel.ScrollBarThickness = 6
MainPanel.Parent = MainFrame
local MainLayout = Instance.new("UIListLayout")
MainLayout.SortOrder = Enum.SortOrder.LayoutOrder
MainLayout.Padding = UDim.new(0, 8)
MainLayout.Parent = MainPanel

local PiggyPanel = Instance.new("Frame")
PiggyPanel.Size = UDim2.new(1, -20, 1, -140)
PiggyPanel.Position = UDim2.new(0, 10, 0, 120)
PiggyPanel.BackgroundTransparency = 1
PiggyPanel.Visible = false
PiggyPanel.Parent = MainFrame

-- ==================== TOGGLE SYSTEM ====================
local function CreateToggle(parent, text, default, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, 0, 0, 50)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    toggleFrame.Parent = parent
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim2.new(0, 10)
    corner.Parent = toggleFrame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.GothamSemibold
    label.TextScaled = true
    label.Parent = toggleFrame

    local switch = Instance.new("Frame")
    switch.Size = UDim2.new(0, 45, 0, 25)
    switch.Position = UDim2.new(1, -60, 0.5, -12)
    switch.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    switch.Parent = toggleFrame
    local sCorner = Instance.new("UICorner")
    sCorner.CornerRadius = UDim2.new(1, 0)
    sCorner.Parent = switch

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 21, 0, 21)
    knob.Position = UDim2.new(0, 2, 0.5, -10)
    knob.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    knob.Parent = switch
    local kCorner = Instance.new("UICorner")
    kCorner.CornerRadius = UDim2.new(1, 0)
    kCorner.Parent = knob

    local state = default
    local function update()
        if state then
            TweenService:Create(knob, TweenInfo.new(0.2), {Position = UDim2.new(1, -23, 0.5, -10)}):Play()
            TweenService:Create(switch, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 50, 50)}):Play()
        else
            TweenService:Create(knob, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -10)}):Play()
            TweenService:Create(switch, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
        end
    end
    update()

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundTransparency = 1
    button.Text = ""
    button.Parent = toggleFrame

    button.MouseButton1Click:Connect(function()
        state = not state
        callback(state)
        update()
    end)
    return toggleFrame
end

-- ==================== ESP ====================
local function CreateESP()
    if Config.ESPEnabled then
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr \~= LocalPlayer and plr.Character and not ESPObjects[plr] then
                local box = Drawing.new("Square")
                box.Thickness = 2
                box.Color = Color3.fromRGB(255, 50, 50)
                box.Filled = false
                box.Transparency = 1
                ESPObjects[plr] = {Box = box}
            end
        end
    else
        for _, data in pairs(ESPObjects) do
            data.Box:Remove()
        end
        ESPObjects = {}
    end
end

RunService.RenderStepped:Connect(function()
    if not Config.ESPEnabled then return end
    CreateESP()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr \~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local data = ESPObjects[plr]
            if data then
                local root = plr.Character.HumanoidRootPart
                local size = root.Size * Vector3.new(1.8, 2.5, 1)
                data.Box.Size = Vector2.new(size.X, size.Z)
                data.Box.Position = Vector2.new(Camera.WorldToViewportPoint(root.Position).X, Camera.WorldToViewportPoint(root.Position).Y)
                data.Box.Visible = true
            end
        end
    end
end)

-- ==================== FLY + SPEED ====================
local function StartFly()
    Config.FlyEnabled = true
    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    bv.Velocity = Vector3.new(0,0,0)
    bv.Parent = Character.HumanoidRootPart
    local bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    bg.P = 1e4
    bg.Parent = Character.HumanoidRootPart
    FlyConnection = RunService.RenderStepped:Connect(function()
        if not Config.FlyEnabled then return end
        local camCF = Camera.CFrame
        local move = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + camCF.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - camCF.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - camCF.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + camCF.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0,1,0) end
        bv.Velocity = move.Unit * Config.FlySpeed
        bg.CFrame = camCF
    end)
end

local function StopFly()
    Config.FlyEnabled = false
    if FlyConnection then FlyConnection:Disconnect() end
    if Character and Character:FindFirstChild("HumanoidRootPart") then
        Character.HumanoidRootPart:FindFirstChild("BodyVelocity") and Character.HumanoidRootPart.BodyVelocity:Destroy()
        Character.HumanoidRootPart:FindFirstChild("BodyGyro") and Character.HumanoidRootPart.BodyGyro:Destroy()
    end
end

-- ==================== GOD MODE ====================
local function SetupGodMode()
    if Config.GodMode then
        Humanoid.MaxHealth = 9e9
        Humanoid.Health = 9e9
    else
        Humanoid.MaxHealth = 100
        Humanoid.Health = 100
    end
end

Humanoid.HealthChanged:Connect(function()
    if Config.GodMode and Humanoid.Health < 100 then Humanoid.Health = 100 end
end)

-- ==================== AUTO GRAB ====================
local function StartAutoGrab()
    Config.AutoGrabItems = true
    spawn(function()
        while Config.AutoGrabItems do
            for _, item in ipairs(ItemsFolder:GetChildren()) do
                if item:FindFirstChild("Handle") then
                    local root = Character:FindFirstChild("HumanoidRootPart")
                    if root then item.Handle.CFrame = root.CFrame * CFrame.new(0, 3, 0) end
                end
            end
            task.wait(0.1)
        end
    end)
end

-- ==================== SPEED + JUMP ====================
local function StartSpeedBoost()
    Config.SpeedBoost = true
    SpeedConnection = RunService.Heartbeat:Connect(function()
        if Config.SpeedBoost and Humanoid then Humanoid.WalkSpeed = Config.FlySpeed + 50 end
    end)
end

local function StartAutoJump()
    Config.AutoJump = true
    JumpConnection = RunService.Heartbeat:Connect(function()
        if Config.AutoJump and Humanoid and Humanoid:GetState() == Enum.HumanoidStateType.Running then Humanoid.Jump = true end
    end)
end

-- ==================== INFINITE STAMINA ====================
local function InfiniteStamina()
    Config.InfiniteStamina = true
    spawn(function()
        while Config.InfiniteStamina do
            if Humanoid then Humanoid:ChangeState(Enum.HumanoidStateType.Running) end
            task.wait(0.05)
        end
    end)
end

-- ==================== KILL ON TRANSFORM ====================
local function KillOnTransform()
    Config.KillOnTransform = true
    spawn(function()
        while Config.KillOnTransform do
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr \~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health <= 0 then
                    -- Matar automáticamente (ajusta según el juego)
                end
            end
            task.wait(2)
        end
    end)
end

-- ==================== NOCOOP ====================
RunService.Stepped:Connect(function()
    if Config.Noclip then
        for _, part in ipairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- ==================== BOTONES ====================
local function OpenSection(panel)
    InfoPanel.Visible = false
    MainPanel.Visible = false
    PiggyPanel.Visible = false
    panel.Visible = true
end

BtnInfo.MouseButton1Click:Connect(function() OpenSection(InfoPanel) end)
BtnMain.MouseButton1Click:Connect(function() OpenSection(MainPanel) end)
BtnPiggy.MouseButton1Click:Connect(function() OpenSection(PiggyPanel) end)

-- ==================== TOGGLES ====================
CreateToggle(MainPanel, "Auto Farm de monedas/tokens", false, function(v) Config.AutoFarmCoins = v end)
CreateToggle(MainPanel, "Noclip (atravesar paredes)", false, function(v) Config.Noclip = v end)
CreateToggle(MainPanel, "Fly + WalkSpeed", false, function(v)
    if v then StartFly() StartSpeedBoost() else StopFly() Config.SpeedBoost = false end
end)
CreateToggle(MainPanel, "ESP (ver Piggy, jugadores e ítems)", false, function(v)
    Config.ESPEnabled = v
    CreateESP()
end)
CreateToggle(MainPanel, "God Mode (invencible)", false, function(v) Config.GodMode = v SetupGodMode() end)
CreateToggle(MainPanel, "Infinite Stamina", false, function(v) Config.InfiniteStamina = v InfiniteStamina() end)
CreateToggle(MainPanel, "Auto Grab Items", false, function(v) if v then StartAutoGrab() else Config.AutoGrabItems = false end end)
CreateToggle(MainPanel, "Speed + Jump", false, function(v)
    if v then Config.SpeedBoost = true Config.AutoJump = true StartSpeedBoost() StartAutoJump() else Config.SpeedBoost = false Config.AutoJump = false end
end)

CreateToggle(PiggyPanel, "Matar a jugadores automáticamente (cuando te conviertas en Piggy)", false, function(v) Config.KillOnTransform = v KillOnTransform() end)

-- ==================== STATUS ====================
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -20, 0, 30)
Status.Position = UDim2.new(0, 10, 1, -40)
Status.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Status.Text = "Status: Undetected | Last Update: Today"
Status.TextColor3 = Color3.fromRGB(100, 255, 100)
Status.TextScaled = true
Status.Font = Enum.Font.GothamBold
Status.Parent = MainFrame

print("✅ JoseAngel_Blox Piggy Pro cargado correctamente! ¡Ejecuta en Piggy!")
