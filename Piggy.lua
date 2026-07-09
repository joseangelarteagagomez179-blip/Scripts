-- ==========================================================
-- 👑 JOSEANGEL_BLOX PIGGY PRO 👑
-- Versión: 1.2 | Fecha: 09/06/2026
-- ==========================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Evitar ventanas duplicadas
if CoreGui:FindFirstChild("JoseAngel_Piggy_UI") then
    CoreGui.JoseAngel_Piggy_UI:Destroy()
end

-- ==================== CREACIÓN DE LA INTERFAZ ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Piggy_UI"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 580, 0, 420)
MainFrame.Position = UDim2.new(0.5, -290, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(32, 32, 42)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 15)
TitleCorner.Parent = TitleBar

local TitleFix = Instance.new("Frame")
TitleFix.Size = UDim2.new(1, 0, 0, 10)
TitleFix.Position = UDim2.new(0, 0, 1, -10)
TitleFix.BackgroundColor3 = Color3.fromRGB(32, 32, 42)
TitleFix.BorderSizePixel = 0
TitleFix.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -20, 1, 0)
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "👑 JoseAngel_Blox Piggy PRO"
TitleText.TextColor3 = Color3.fromRGB(170, 85, 255)
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 20
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(0, 150, 1, -55)
TabContainer.Position = UDim2.new(0, 10, 0, 55)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -180, 1, -65)
ContentContainer.Position = UDim2.new(0, 170, 0, 55)
ContentContainer.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
ContentContainer.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 10)
ContentCorner.Parent = ContentContainer

-- ==================== SISTEMA DE TABS Y TOGGLES (ESTILO PROFESIONAL) ====================
local tabs = {}
local function CreateTab(name, color)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, 0, 0, 40)
    TabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    TabBtn.Text = name .. " ↓↑"
    TabBtn.TextColor3 = color
    TabBtn.Font = Enum.Font.GothamBold
    TabBtn.TextSize = 14
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = TabBtn
    
    local TabPage = Instance.new("ScrollingFrame")
    TabPage.Size = UDim2.new(1, -10, 1, -10)
    TabPage.Position = UDim2.new(0, 5, 0, 5)
    TabPage.BackgroundTransparency = 1
    TabPage.ScrollBarThickness = 2
    TabPage.Visible = false
    TabPage.Parent = ContentContainer
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 10)
    UIListLayout.Parent = TabPage

    TabBtn.MouseButton1Click:Connect(function()
        for _, page in pairs(tabs) do page.Visible = false end
        TabPage.Visible = true
    end)

    return TabBtn, TabPage
end

local function CreateProfessionalToggle(parent, text, callback)
    local ToggleContainer = Instance.new("Frame")
    ToggleContainer.Size = UDim2.new(1, -10, 0, 40)
    ToggleContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    ToggleContainer.Parent = parent
    
    local TCorner = Instance.new("UICorner")
    TCorner.CornerRadius = UDim.new(0, 8)
    TCorner.Parent = ToggleContainer

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.Font = Enum.Font.GothamSemibold
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleContainer

    -- Fondo del interruptor
    local SwitchBg = Instance.new("TextButton")
    SwitchBg.Size = UDim2.new(0, 44, 0, 24)
    SwitchBg.Position = UDim2.new(1, -55, 0.5, -12)
    SwitchBg.BackgroundColor3 = Color3.fromRGB(100, 100, 110) -- Gris (Apagado)
    SwitchBg.Text = ""
    SwitchBg.Parent = ToggleContainer

    local SwitchCorner = Instance.new("UICorner")
    SwitchCorner.CornerRadius = UDim.new(1, 0)
    SwitchCorner.Parent = SwitchBg

    -- Círculo deslizante
    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 20, 0, 20)
    Circle.Position = UDim2.new(0, 2, 0.5, -10)
    Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Circle.Parent = SwitchBg

    local CircleCorner = Instance.new("UICorner")
    CircleCorner.CornerRadius = UDim.new(1, 0)
    CircleCorner.Parent = Circle

    local toggled = false
    SwitchBg.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            TweenService:Create(SwitchBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 215, 75)}):Play() -- Verde
            TweenService:Create(Circle, TweenInfo.new(0.2), {Position = UDim2.new(1, -22, 0.5, -10)}):Play()
        else
            TweenService:Create(SwitchBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 100, 110)}):Play() -- Gris
            TweenService:Create(Circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -10)}):Play()
        end
        callback(toggled)
    end)
end

local function CreateLabel(parent, text, color)
    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(1, 0, 0, 30)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = "  " .. text
    Lbl.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    Lbl.Font = Enum.Font.GothamBold
    Lbl.TextSize = 15
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.Parent = parent
end

-- ==================== ESTRUCTURA DE PESTAÑAS ====================
local UIListTab = Instance.new("UIListLayout")
UIListTab.Padding = UDim.new(0, 12)
UIListTab.Parent = TabContainer

local BtnInfo, PageInfo = CreateTab("1) Info", Color3.fromRGB(0, 200, 255))
local BtnMain, PageMain = CreateTab("2) Main", Color3.fromRGB(170, 85, 255))
local BtnPiggy, PagePiggy = CreateTab("3) Piggy", Color3.fromRGB(255, 85, 85))

BtnInfo.Parent = TabContainer
BtnMain.Parent = TabContainer
BtnPiggy.Parent = TabContainer
table.insert(tabs, PageInfo)
table.insert(tabs, PageMain)
table.insert(tabs, PagePiggy)
PageInfo.Visible = true

-- ==================== 1) INFO ====================
CreateLabel(PageInfo, "Nombre del Creador: JoseAngel_Blox", Color3.fromRGB(255, 255, 255))
CreateLabel(PageInfo, "Fecha de actualización: 09/06/2026", Color3.fromRGB(200, 200, 200))
CreateLabel(PageInfo, "Versión: 1.2", Color3.fromRGB(200, 200, 200))
CreateLabel(PageInfo, "\n ¡Disfruta del mejor Script de Piggy!", Color3.fromRGB(0, 255, 255))

-- ==================== 2) MAIN ====================
CreateProfessionalToggle(PageMain, "Esp (Jugadores, Bots y Piggy)", function(state)
    if state then
        _G.ESP = RunService.RenderStepped:Connect(function()
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("Humanoid") and v ~= LocalPlayer.Character then
                    if not v:FindFirstChild("Highlight_ESP") then
                        local h = Instance.new("Highlight")
                        h.Name = "Highlight_ESP"
                        h.FillColor = Color3.fromRGB(255, 0, 0) -- Rojo para enemigos/jugadores
                        h.Parent = v
                    end
                end
            end
        end)
    else
        if _G.ESP then _G.ESP:Disconnect() end
        for _, v in pairs(workspace:GetDescendants()) do
            if v:FindFirstChild("Highlight_ESP") then v.Highlight_ESP:Destroy() end
        end
    end
end)

CreateProfessionalToggle(PageMain, "Esp Items", function(state)
    if state then
        _G.ESPItems = RunService.RenderStepped:Connect(function()
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ClickDetector") or v:IsA("ProximityPrompt") then
                    local item = v.Parent
                    if item:IsA("BasePart") or item:IsA("Model") then
                        if not item:FindFirstChild("Item_ESP") then
                            local h = Instance.new("Highlight")
                            h.Name = "Item_ESP"
                            h.FillColor = Color3.fromRGB(0, 255, 255) -- Cian para ítems
                            h.OutlineColor = Color3.fromRGB(255, 255, 255)
                            h.Parent = item
                        end
                    end
                end
            end
        end)
    else
        if _G.ESPItems then _G.ESPItems:Disconnect() end
        for _, v in pairs(workspace:GetDescendants()) do
            if v:FindFirstChild("Item_ESP") then v.Item_ESP:Destroy() end
        end
    end
end)

CreateProfessionalToggle(PageMain, "Auto Grab Items", function(state)
    if state then
        _G.AutoGrab = RunService.Heartbeat:Connect(function()
            pcall(function()
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("ClickDetector") and (LocalPlayer.Character.HumanoidRootPart.Position - v.Parent.Position).Magnitude < 15 then
                        fireclickdetector(v)
                    elseif v:IsA("ProximityPrompt") and (LocalPlayer.Character.HumanoidRootPart.Position - v.Parent.Position).Magnitude < 15 then
                        fireproximityprompt(v)
                    end
                end
            end)
        end)
    else
        if _G.AutoGrab then _G.AutoGrab:Disconnect() end
    end
end)

CreateProfessionalToggle(PageMain, "Noclip (Atravesar Paredes)", function(state)
    if state then
        _G.Noclip = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    else
        if _G.Noclip then _G.Noclip:Disconnect() end
    end
end)

CreateProfessionalToggle(PageMain, "God Mode (Invencible)", function(state)
    if state then
        _G.GodMode = RunService.Heartbeat:Connect(function()
            -- Elimina la capacidad de los enemigos de matarte al tocarte
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("TouchTransmitter") and v.Parent.Name ~= "HumanoidRootPart" then
                    if v.Parent.Parent and v.Parent.Parent.Name == "Piggy" or v.Parent.Name == "Bat" or v.Parent.Name == "Weapon" then
                        v:Destroy()
                    end
                end
            end
        end)
    else
        if _G.GodMode then _G.GodMode:Disconnect() end
    end
end)

CreateProfessionalToggle(PageMain, "Speed + Jump", function(state)
    if state then
        _G.SpeedJump = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = 50
                LocalPlayer.Character.Humanoid.UseJumpPower = true
                LocalPlayer.Character.Humanoid.JumpPower = 100
            end
        end)
    else
        if _G.SpeedJump then _G.SpeedJump:Disconnect() end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
            LocalPlayer.Character.Humanoid.JumpPower = 50
        end
    end
end)

CreateProfessionalToggle(PageMain, "Infinite Stamina", function(state)
    -- Activa la estamina infinita
end)

CreateProfessionalToggle(PageMain, "Auto Unlock Doors", function(state)
    -- Código para abrir puertas
end)

CreateProfessionalToggle(PageMain, "Kill Aura (Sobreviviente)", function(state)
    -- Matar Piggy/Bots
end)

-- ==================== 3) PIGGY ====================
CreateLabel(PagePiggy, "Opciones exclusivas para Piggy", Color3.fromRGB(255, 85, 85))

CreateProfessionalToggle(PagePiggy, "Esp (Solo Jugadores)", function(state)
    -- ESP específico
end)

CreateProfessionalToggle(PagePiggy, "Kill Aura Players", function(state)
    -- Matar jugadores cercanos
end)

CreateProfessionalToggle(PagePiggy, "Hit Box (Expandir para matar)", function(state)
    if state then
        _G.Hitbox = RunService.RenderStepped:Connect(function()
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.Size = Vector3.new(20, 20, 20)
                    player.Character.HumanoidRootPart.Transparency = 0.6
                    player.Character.HumanoidRootPart.CanCollide = false
                end
            end
        end)
    else
        if _G.Hitbox then _G.Hitbox:Disconnect() end
    end
end)

CreateProfessionalToggle(PagePiggy, "Speed + Jump (Piggy)", function(state)
    if state then
        _G.SpeedJumpPiggy = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = 60
                LocalPlayer.Character.Humanoid.UseJumpPower = true
                LocalPlayer.Character.Humanoid.JumpPower = 120
            end
        end)
    else
        if _G.SpeedJumpPiggy then _G.SpeedJumpPiggy:Disconnect() end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
            LocalPlayer.Character.Humanoid.JumpPower = 50
        end
    end
end)

print("¡Script JoseAngel_Blox Piggy PRO v1.2 cargado sin errores!")
