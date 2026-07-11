-- =========================================================
-- SCRIPT: JoseAngel_Blox Piggy Pro V1.6 - MÓDULOS SEPARADOS
-- =========================================================

-- SERVICIOS GENERALES
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

-- LIMPIEZA PREVIA
if CoreGui:FindFirstChild("JoseAngel_BloxPiggyPro") then
    CoreGui.JoseAngel_BloxPiggyPro:Destroy()
end
if CoreGui:FindFirstChild("JoseAngel_ESP") then
    CoreGui.JoseAngel_ESP:Destroy()
end

-- VARIABLES PRINCIPALES
local toggles = {
    ESP_Items = false,
    ESP_Players = false,
    ESP_Bots = false,
    FullBright = false,
    Speed = false,
    Noclip = false,
    Godmode = false,
    InfJump = false,
    PiggyAutoKill = false,
    PiggySpeed = false
}

local ESPFolder = Instance.new("Folder", CoreGui)
ESPFolder.Name = "JoseAngel_ESP"

-- =========================================================
-- 📦 MÓDULO 1: ESP ÍTEMS
-- =========================================================
local function UpdateESP_Items()
    -- Borrar solo etiquetas de ítems
    for _, child in ipairs(ESPFolder:GetChildren()) do
        if child.Name == "ESP_Item" then
            child:Destroy()
        end
    end

    if not toggles.ESP_Items then return end

    pcall(function()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("ClickDetector") or (obj:IsA("BasePart") and not obj.Parent:FindFirstChild("Humanoid")) then
                local target = obj:IsA("ClickDetector") and obj.Parent or obj
                local nombre = target.Name

                if not tonumber(nombre) and #nombre > 2 and not target:FindFirstChild("Humanoid") then
                    local gui = Instance.new("BillboardGui")
                    gui.Name = "ESP_Item"
                    gui.Adornee = target:IsA("Model") and target:FindFirstChild("PrimaryPart") or target
                    gui.Size = UDim2.new(0, 120, 0, 30)
                    gui.AlwaysOnTop = true
                    gui.Parent = ESPFolder

                    local txt = Instance.new("TextLabel")
                    txt.Size = UDim2.new(1, 0, 1, 0)
                    txt.BackgroundTransparency = 1
                    txt.Text = "📦 " .. nombre
                    txt.TextColor3 = Color3.new(1, 1, 0)
                    txt.Font = Enum.Font.GothamBold
                    txt.TextScaled = true
                    txt.Parent = gui
                end
            end
        end
    end)
end

-- =========================================================
-- 👥 MÓDULO 2: ESP JUGADORES
-- =========================================================
local function UpdateESP_Players()
    -- Borrar solo etiquetas de jugadores
    for _, child in ipairs(ESPFolder:GetChildren()) do
        if child.Name == "ESP_Player" then
            child:Destroy()
        end
    end

    if not toggles.ESP_Players then return end

    pcall(function()
        for _, jugador in ipairs(Players:GetPlayers()) do
            if jugador ~= LocalPlayer then
                local char = jugador.Character or jugador.CharacterAdded:Wait()
                local cabeza = char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
                if cabeza then
                    local gui = Instance.new("BillboardGui")
                    gui.Name = "ESP_Player"
                    gui.Adornee = cabeza
                    gui.Size = UDim2.new(0, 130, 0, 35)
                    gui.AlwaysOnTop = true
                    gui.Parent = ESPFolder

                    local txt = Instance.new("TextLabel")
                    txt.Size = UDim2.new(1, 0, 1, 0)
                    txt.BackgroundTransparency = 1
                    txt.Text = "👤 " .. jugador.Name
                    txt.TextColor3 = Color3.new(0, 1, 0)
                    txt.Font = Enum.Font.GothamBold
                    txt.TextScaled = true
                    txt.Parent = gui
                end
            end
        end
    end)
end

-- =========================================================
-- 🐷 MÓDULO 3: ESP BOTS / PIGGY
-- =========================================================
local function UpdateESP_Bots()
    -- Borrar solo etiquetas de bots
    for _, child in ipairs(ESPFolder:GetChildren()) do
        if child.Name == "ESP_Bot" then
            child:Destroy()
        end
    end

    if not toggles.ESP_Bots then return end

    pcall(function()
        for _, modelo in ipairs(workspace:GetChildren()) do
            if modelo:IsA("Model") and modelo ~= LocalPlayer.Character then
                local hum = modelo:FindFirstChild("Humanoid")
                if hum and not Players:GetPlayerFromCharacter(modelo) then
                    local cabeza = modelo:FindFirstChild("Head") or modelo:FindFirstChild("HumanoidRootPart")
                    if cabeza then
                        local gui = Instance.new("BillboardGui")
                        gui.Name = "ESP_Bot"
                        gui.Adornee = cabeza
                        gui.Size = UDim2.new(0, 140, 0, 40)
                        gui.AlwaysOnTop = true
                        gui.Parent = ESPFolder

                        local txt = Instance.new("TextLabel")
                        txt.Size = UDim2.new(1, 0, 1, 0)
                        txt.BackgroundTransparency = 1
                        txt.Text = "🚨 PIGGY 🚨"
                        txt.TextColor3 = Color3.new(1, 0, 0)
                        txt.Font = Enum.Font.GothamBlack
                        txt.TextScaled = true
                        txt.Parent = gui
                    end
                end
            end
        end
    end)
end

-- =========================================================
-- 👻 MÓDULO 4: NOCLIP
-- =========================================================
local function UpdateNoclip()
    local char = LocalPlayer.Character
    if not char then return end

    pcall(function()
        for _, parte in ipairs(char:GetDescendants()) do
            if parte:IsA("BasePart") then
                parte.CanCollide = not toggles.Noclip
            end
        end
    end)
end

-- =========================================================
-- 🛡️ MÓDULO 5: GODMODE
-- =========================================================
local function UpdateGodmode()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return end

    pcall(function()
        if toggles.Godmode then
            hum.MaxHealth = math.huge
            hum.Health = math.huge
            hum.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
        else
            hum.MaxHealth = 100
            hum.Health = 100
            hum.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOn
        end
    end)
end

-- =========================================================
-- ⚙️ OTROS MÓDULOS ADICIONALES
-- =========================================================
local function UpdateVelocidad()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return end

    if toggles.PiggySpeed then
        hum.WalkSpeed = 35
    elseif toggles.Speed then
        hum.WalkSpeed = 25
    else
        hum.WalkSpeed = 16
    end
end

local function UpdateFullBright()
    if toggles.FullBright then
        Lighting.Ambient = Color3.new(1,1,1)
        Lighting.GlobalShadows = false
        Lighting.Brightness = 2
    else
        Lighting.Ambient = Color3.new(0.25,0.25,0.25)
        Lighting.GlobalShadows = true
        Lighting.Brightness = 1
    end
end

-- =========================================================
-- 🔄 BUCLES DE ACTUALIZACIÓN
-- =========================================================
-- Actualizar ESP cada 1 segundo
task.spawn(function()
    while task.wait(1) do
        UpdateESP_Items()
        UpdateESP_Players()
        UpdateESP_Bots()
    end
end)

-- Actualizar Noclip y Godmode cada cuadro
RunService.Stepped:Connect(function()
    UpdateNoclip()
    UpdateGodmode()
end)

-- Actualizar velocidad y luz
RunService.RenderStepped:Connect(function()
    UpdateVelocidad()
    UpdateFullBright()
end)

-- Salto infinito
UserInputService.JumpRequest:Connect(function()
    if toggles.InfJump then
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChild("Humanoid")
        if hum and hum:GetState() ~= Enum.HumanoidStateType.Freefall then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Auto matar
RunService.RenderStepped:Connect(function()
    if toggles.PiggyAutoKill then
        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChild("Humanoid")
        if not hum then return end
        for _, jugador in ipairs(Players:GetPlayers()) do
            if jugador ~= LocalPlayer and jugador.Character and jugador.Character:FindFirstChild("HumanoidRootPart") then
                char:SetPrimaryPartCFrame(jugador.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,3))
            end
        end
    end
end)

-- =========================================================
-- 🎨 INTERFAZ DEL MENÚ
-- =========================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_BloxPiggyPro"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local ToggleMenuBtn = Instance.new("TextButton")
ToggleMenuBtn.Size = UDim2.new(0, 150, 0, 40)
ToggleMenuBtn.Position = UDim2.new(0, 10, 0, 10)
ToggleMenuBtn.BackgroundColor3 = Color3.fromRGB(15,15,15)
ToggleMenuBtn.Text = "👁️ Abrir/Cerrar Menú"
ToggleMenuBtn.TextColor3 = Color3.new(0,1,1)
ToggleMenuBtn.Font = Enum.Font.GothamBold
ToggleMenuBtn.TextSize = 12
ToggleMenuBtn.Parent = ScreenGui
Instance.new("UICorner", ToggleMenuBtn).CornerRadius = UDim.new(0,8)

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0,450,0,380)
MainFrame.Position = UDim2.new(0.5,-225,0.5,-190)
MainFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0,10)

ToggleMenuBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.Text = "JoseAngel_Blox Piggy Pro V1.6"
Title.TextColor3 = Color3.new(0,1,1)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold

local Separator = Instance.new("Frame", MainFrame)
Separator.Size = UDim2.new(0.9,0,0,2)
Separator.Position = UDim2.new(0.05,0,0,40)
Separator.BackgroundColor3 = Color3.new(0,1,1)

local OptionsFrame = Instance.new("ScrollingFrame", MainFrame)
OptionsFrame.Size = UDim2.new(1,0,1,-50)
OptionsFrame.Position = UDim2.new(0,0,0,50)
OptionsFrame.BackgroundTransparency = 1
OptionsFrame.ScrollBarThickness = 4

local UIListLayout = Instance.new("UIListLayout", OptionsFrame)
UIListLayout.Padding = UDim.new(0,5)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- =========================================================
-- 🛠️ FUNCIÓN PARA CREAR BOTONES
-- =========================================================
local layoutOrder = 0
local function CreateToggle(nombre, clave)
    layoutOrder += 1
    local Frame = Instance.new("Frame", OptionsFrame)
    Frame.Size = UDim2.new(0.9,0,0,35)
    Frame.BackgroundTransparency = 1
    Frame.LayoutOrder = layoutOrder

    local Label = Instance.new("TextLabel", Frame)
    Label.Size = UDim2.new(0.7,0,1,0)
    Label.Position = UDim2.new(0.02,0,0,0)
    Label.BackgroundTransparency = 1
    Label.Text = nombre
    Label.TextColor3 = Color3.new(1,1,1)
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local Switch = Instance.new("Frame", Frame)
    Switch.Size = UDim2.new(0,40,0,20)
    Switch.Position = UDim2.new(0.85,-10,0.5,-10)
    Switch.BackgroundColor3 = Color3.new(1,0.2,0.2)
    Instance.new("UICorner", Switch).CornerRadius = UDim.new(1,0)

    local Knob = Instance.new("Frame", Switch)
    Knob.Size = UDim2.new(0,16,0,16)
    Knob.Position = UDim2.new(0,2,0.5,-8)
    Knob.BackgroundColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(1,0)

    local Btn = Instance.new("TextButton", Switch)
    Btn.Size = UDim2.new(1,0,1,0)
    Btn.BackgroundTransparency = 1
    Btn.Text = ""

    Btn.MouseButton1Click:Connect(function()
        toggles[clave] = not toggles[clave]
        local estado = toggles[clave]
        TweenService:Create(Switch, TweenInfo.new(0.2), {BackgroundColor3 = estado and Color3.new(0.2,1,0.2) or Color3.new(1,0.2,0.2)}):Play()
        TweenService:Create(Knob, TweenInfo.new(0.2), {Position = estado and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8)}):Play()
    end)
end

-- =========================================================
-- 📋 ARMAR OPCIONES DEL MENÚ
-- =========================================================
local function AddHeader(texto)
    layoutOrder += 1
    local lbl = Instance.new("TextLabel", OptionsFrame)
    lbl.Size = UDim2.new(1,0,0,25)
    lbl.BackgroundTransparency = 1
    lbl.Text = texto
    lbl.TextColor3 = Color3.new(0,1,1)
    lbl.Font = Enum.Font.GothamBlack
    lbl.LayoutOrder = layoutOrder
end

AddHeader("📦 ESP")
CreateToggle("ESP Ítems", "ESP_Items")
CreateToggle("ESP Jugadores", "ESP_Players")
CreateToggle("ESP Piggy/Bots", "ESP_Bots")

AddHeader("👻 MOVIMIENTO")
CreateToggle("Noclip", "Noclip")
CreateToggle("Salto Infinito", "InfJump")
CreateToggle("Velocidad Superviviente", "Speed")
CreateToggle("Velocidad Piggy", "PiggySpeed")

AddHeader("🛡️ PROTECCIÓN")
CreateToggle("Godmode", "Godmode")
CreateToggle("Visión Completa", "FullBright")

AddHeader("🔪 ACCIONES")
CreateToggle("Auto Matar", "PiggyAutoKill")

print("✅ Script cargado | Módulos separados correctamente")
