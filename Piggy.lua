-- ==========================================================
-- 👑 JOSEANGEL_BLOX PIGGY PRO v1.7 | FIXED + PIGGY TAB + ROLE SUPPORT
-- Versión optimizada para Delta (Mobile)
-- ==========================================================

local CoreGui = (gethui and gethui()) or game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Funciones seguras
local safeFireClick = fireclickdetector or function() end
local safeFireProx = fireproximityprompt or function() end

-- Limpieza anterior
if CoreGui:FindFirstChild("JoseAngel_Piggy_UI") then
    CoreGui.JoseAngel_Piggy_UI:Destroy()
end

-- ==================== GUI ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Piggy_UI"
ScreenGui.Parent = CoreGui

local ToggleMenuBtn = Instance.new("TextButton")
ToggleMenuBtn.Size = UDim2.new(0, 120, 0, 40)
ToggleMenuBtn.Position = UDim2.new(0, 15, 0, 15)
ToggleMenuBtn.BackgroundColor3 = Color3.fromRGB(32, 32, 42)
ToggleMenuBtn.Text = "👑 Piggy PRO"
ToggleMenuBtn.TextColor3 = Color3.fromRGB(170, 85, 255)
ToggleMenuBtn.Font = Enum.Font.GothamBold
ToggleMenuBtn.TextSize = 14
ToggleMenuBtn.Active = true
ToggleMenuBtn.Draggable = true
ToggleMenuBtn.Parent = ScreenGui
Instance.new("UICorner", ToggleMenuBtn).CornerRadius = UDim.new(0, 8)

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 480, 0, 340)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -170)
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 15)

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(32, 32, 42)
TitleBar.Parent = MainFrame
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 15)

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -20, 1, 0)
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "👑 JoseAngel_Blox Piggy PRO v1.7"
TitleText.TextColor3 = Color3.fromRGB(170, 85, 255)
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 18
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- ==================== TABS (FIXED) ====================
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(0, 130, 1, -55)
TabContainer.Position = UDim2.new(0, 10, 0, 55)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

local ContentContainer = Instance.new("ScrollingFrame")
ContentContainer.Size = UDim2.new(1, -150, 1, -65)
ContentContainer.Position = UDim2.new(0, 140, 0, 55)
ContentContainer.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
ContentContainer.ScrollBarThickness = 4
ContentContainer.Parent = MainFrame
Instance.new("UICorner", ContentContainer).CornerRadius = UDim.new(0, 10)

local tabs = {}
local function CreateTab(name, color)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, 0, 0, 35)
    TabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    TabBtn.Text = name
    TabBtn.TextColor3 = color
    TabBtn.Font = Enum.Font.GothamBold
    TabBtn.TextSize = 13
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 8)

    local TabPage = Instance.new("Frame")
    TabPage.Size = UDim2.new(1, -10, 1, -10)
    TabPage.Position = UDim2.new(0, 5, 0, 5)
    TabPage.BackgroundTransparency = 1
    TabPage.Visible = false
    TabPage.Parent = ContentContainer

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 8)
    UIListLayout.Parent = TabPage

    TabBtn.MouseButton1Click:Connect(function()
        for _, page in pairs(tabs) do page.Visible = false end
        TabPage.Visible = true
        ContentContainer.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 20)
    end)

    TabBtn.Parent = TabContainer
    table.insert(tabs, TabPage)
    return TabBtn, TabPage, UIListLayout
end

local BtnMain, PageMain, LMain = CreateTab("1) Main", Color3.fromRGB(170, 85, 255))
local BtnPiggy, PagePiggy, LPiggy = CreateTab("2) Piggy", Color3.fromRGB(255, 85, 85))
local BtnRole, PageRole, LRole = CreateTab("3) Piggy (Rol)", Color3.fromRGB(255, 200, 100))

BtnMain.Parent = TabContainer
BtnPiggy.Parent = TabContainer
BtnRole.Parent = TabContainer
table.insert(tabs, PageMain)
table.insert(tabs, PagePiggy)
table.insert(tabs, PageRole)
PageMain.Visible = true

-- ==================== TOGGLE (CORREGIDO) ====================
local function CreateToggle(parent, text, layout, callback)
    local ToggleContainer = Instance.new("Frame")
    ToggleContainer.Size = UDim2.new(1, 0, 0, 35)
    ToggleContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    ToggleContainer.Parent = parent
    Instance.new("UICorner", ToggleContainer).CornerRadius = UDim.new(0, 8)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -50, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.Font = Enum.Font.GothamSemibold
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleContainer

    local SwitchBg = Instance.new("TextButton")
    SwitchBg.Size = UDim2.new(0, 40, 0, 20)
    SwitchBg.Position = UDim2.new(1, -45, 0.5, -10)
    SwitchBg.BackgroundColor3 = Color3.fromRGB(100, 100, 110)
    SwitchBg.Text = ""
    SwitchBg.Parent = ToggleContainer
    Instance.new("UICorner", SwitchBg).CornerRadius = UDim.new(1, 0)

    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 16, 0, 16)
    Circle.Position = UDim2.new(0, 2, 0.5, -8)
    Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Circle.Parent = SwitchBg
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

    local toggled = false
    SwitchBg.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            TweenService:Create(SwitchBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 215, 75)}):Play()
            TweenService:Create(Circle, TweenInfo.new(0.2), {Position = UDim2.new(1, -18, 0.5, -8)}):Play()
        else
            TweenService:Create(SwitchBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 100, 110)}):Play()
            TweenService:Create(Circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -8)}):Play()
        end
        pcall(callback, toggled)
    end)
end

-- ==================== ROLES (PIGGY / SURVIVOR) ====================
local currentRole = "Survivor" -- por defecto

local function updateRoleESP()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("Humanoid") then return end
    local hum = LocalPlayer.Character.Humanoid

    -- Detectar rol
    if string.find(hum.Name:lower(), "piggy") or hum:GetAttribute("Role") == "Piggy" or hum:GetAttribute("IsPiggy") then
        currentRole = "Piggy"
    else
        currentRole = "Survivor"
    end
end

RunService.Heartbeat:Connect(updateRoleESP)

-- ==================== 1) MAIN ====================
CreateToggle(PageMain, "Esp (Jugadores, Bots y Piggy)", LMain, function(state)
    if state then
        getgenv().ESP = RunService.RenderStepped:Connect(function()
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v \~= LocalPlayer.Character then
                    local player = Players:GetPlayerFromCharacter(v)
                    local isBot = (player == nil)
                    local espColor = Color3.fromRGB(0, 150, 255)
                    local espText = player and player.Name or "Desconocido"

                    if isBot then
                        espColor = Color3.fromRGB(255, 0, 0)
                        espText = "Bot"
                    else
                        local isPiggy = v.Name == "Piggy" or (v:FindFirstChild("Humanoid") and string.find(v.Humanoid.Name:lower(), "piggy"))
                        if isPiggy then
                            espColor = Color3.fromRGB(255, 0, 0)
                            espText = "Player Piggy"
                        end
                    end

                    if not v:FindFirstChild("Highlight_ESP") then
                        local h = Instance.new("Highlight")
                        h.Name = "Highlight_ESP"
                        h.Parent = v
                    end
                    v.Highlight_ESP.FillColor = espColor
                    v.Highlight_ESP.OutlineColor = espColor

                    if not v.HumanoidRootPart:FindFirstChild("ESP_Text") then
                        local bgui = Instance.new("BillboardGui")
                        bgui.Name = "ESP_Text"
                        bgui.Size = UDim2.new(0, 150, 0, 30)
                        bgui.StudsOffset = Vector3.new(0, 3.5, 0)
                        bgui.AlwaysOnTop = true
                        local label = Instance.new("TextLabel")
                        label.Name = "NameLabel"
                        label.Size = UDim2.new(1, 0, 1, 0)
                        label.BackgroundTransparency = 1
                        label.Font = Enum.Font.GothamBold
                        label.TextSize = 12
                        label.Parent = bgui
                        bgui.Parent = v.HumanoidRootPart
                    end
                    v.HumanoidRootPart.ESP_Text.NameLabel.Text = espText
                    v.HumanoidRootPart.ESP_Text.NameLabel.TextColor3 = espColor
                end
            end
        end)
    else
        if getgenv().ESP then getgenv().ESP:Disconnect() end
        for _, v in pairs(workspace:GetDescendants()) do
            if v:FindFirstChild("Highlight_ESP") then v.Highlight_ESP:Destroy() end
            if v:FindFirstChild("HumanoidRootPart") and v.HumanoidRootPart:FindFirstChild("ESP_Text") then
                v.HumanoidRootPart.ESP_Text:Destroy()
            end
        end
    end
end)

CreateToggle(PageMain, "Esp Items", LMain, function(state)
    if state then
        getgenv().ESPItems = RunService.RenderStepped:Connect(function()
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ClickDetector") or v:IsA("ProximityPrompt") then
                    local target = v.Parent
                    if target:IsA("BasePart") and target.Parent:IsA("Model") and target.Parent.Name \~= "Workspace" then
                        target = target.Parent
                    end
                    if isRealItem(target) and not target:FindFirstChild("Item_ESP") then
                        local h = Instance.new("Highlight")
                        h.Name = "Item_ESP"
                        h.FillColor = Color3.fromRGB(0, 255, 255)
                        h.OutlineColor = Color3.fromRGB(255, 255, 255)
                        h.Parent = target
                    end
                end
            end
        end)
    else
        if getgenv().ESPItems then getgenv().ESPItems:Disconnect() end
        for _, v in pairs(workspace:GetDescendants()) do
            if v:FindFirstChild("Item_ESP") then v.Item_ESP:Destroy() end
        end
    end
end)

CreateToggle(PageMain, "Auto Grab Items", LMain, function(state)
    if state then
        getgenv().AutoGrab = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("ClickDetector") or v:IsA("ProximityPrompt") then
                        local target = v.Parent
                        if target:IsA("BasePart") and target.Parent:IsA("Model") and target.Parent.Name \~= "Workspace" then
                            target = target.Parent
                        end
                        if isRealItem(target) then
                            local dist = (LocalPlayer.Character.HumanoidRootPart.Position - target.Position).Magnitude
                            if dist < 12 then
                                if v:IsA("ClickDetector") then safeFireClick(v) end
                                if v:IsA("ProximityPrompt") then safeFireProx(v) end
                            end
                        end
                    end
                end
            end
        end)
    else
        if getgenv().AutoGrab then getgenv().AutoGrab:Disconnect() end
    end
end)

CreateToggle(PageMain, "Noclip (Atravesar)", LMain, function(state)
    if state then
        getgenv().Noclip = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    else
        if getgenv().Noclip then getgenv().Noclip:Disconnect() end
    end
end)

CreateToggle(PageMain, "God Mode", LMain, function(state)
    if state then
        getgenv().GodMode = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.MaxHealth = 9999
                LocalPlayer.Character.Humanoid.Health = 9999
            end
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("Humanoid") and v \~= LocalPlayer.Character then
                    for _, p in pairs(v:GetDescendants()) do
                        if p:IsA("BasePart") then p.CanTouch = false end
                    end
                end
            end
        end)
    else
        if getgenv().GodMode then getgenv().GodMode:Disconnect() end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.MaxHealth = 100
            LocalPlayer.Character.Humanoid.Health = 100
        end
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Model") and v \~= LocalPlayer.Character then
                for _, p in pairs(v:GetDescendants()) do
                    if p:IsA("BasePart") then p.CanTouch = true end
                end
            end
        end
    end
end)

CreateToggle(PageMain, "Speed + Jump (Safe)", LMain, function(state)
    if state then
        getgenv().SpeedJump = RunService.RenderStepped:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = 40
                LocalPlayer.Character.Humanoid.JumpPower = 90
            end
        end)
    else
        if getgenv().SpeedJump then getgenv().SpeedJump:Disconnect() end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
            LocalPlayer.Character.Humanoid.JumpPower = 50
        end
    end
end)

CreateToggle(PageMain, "Inf Stamina", LMain, function(state)
    if state then
        getgenv().InfStamina = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.MaxHealth = 9999
                LocalPlayer.Character.Humanoid.Health = 9999
            end
        end)
    else
        if getgenv().InfStamina then getgenv().InfStamina:Disconnect() end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.MaxHealth = 100
            LocalPlayer.Character.Humanoid.Health = 100
        end
    end
end)

CreateToggle(PageMain, "Fly", LMain, function(state)
    if state then
        getgenv().Fly = RunService.RenderStepped:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local root = LocalPlayer.Character.HumanoidRootPart
                local hum = LocalPlayer.Character.Humanoid
                hum.PlatformStand = true
                local move = LocalPlayer:GetMouse().Hit.Position - root.Position
                root.Velocity = Vector3.new(move.X * 5, root.Velocity.Y, move.Z * 5)
            end
        end)
    else
        if getgenv().Fly then getgenv().Fly:Disconnect() end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.PlatformStand = false
        end
    end
end)

CreateToggle(PageMain, "Fullbright", LMain, function(state)
    if state then
        game:GetService("Lighting").Brightness = 2
        game:GetService("Lighting").ClockTime = 14
        game:GetService("Lighting").FogEnd = 999999
    else
        game:GetService("Lighting").Brightness = 1
        game:GetService("Lighting").ClockTime = 12
        game:GetService("Lighting").FogEnd = 100000
    end
end)

CreateToggle(PageMain, "Auto Escape", LMain, function(state)
    if state then
        getgenv().AutoEscape = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                -- Teleporta al exit (ajusta nombre según tu mapa)
                local exit = workspace:FindFirstChild("Exit") or workspace:FindFirstChild("Door") or workspace:FindFirstChild("Escape")
                if exit then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = exit.CFrame + Vector3.new(0, 5, 0)
                end
            end
        end)
    else
        if getgenv().AutoEscape then getgenv().AutoEscape:Disconnect() end
    end
end)

-- ==================== 2) PIGGY ====================
CreateToggle(PagePiggy, "Hit Box (Expandir Todos)", LPiggy, function(state)
    if state then
        getgenv().Hitbox = RunService.RenderStepped:Connect(function()
            for _, player in pairs(Players:GetPlayers()) do
                if player \~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.Size = Vector3.new(15, 15, 15)
                    player.Character.HumanoidRootPart.Transparency = 0.7
                    player.Character.HumanoidRootPart.CanCollide = false
                end
            end
        end)
    else
        if getgenv().Hitbox then getgenv().Hitbox:Disconnect() end
        for _, player in pairs(Players:GetPlayers()) do
            if player \~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
                player.Character.HumanoidRootPart.Transparency = 1
                player.Character.HumanoidRootPart.CanCollide = true
            end
        end
    end
end)

CreateToggle(PagePiggy, "Auto Kill (Cerca de ti)", LPiggy, function(state)
    if state then
        getgenv().AutoKill = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                for _, player in pairs(Players:GetPlayers()) do
                    if player \~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                        if dist < 15 then
                            for _, obj in pairs(LocalPlayer.Character:GetDescendants()) do
          
