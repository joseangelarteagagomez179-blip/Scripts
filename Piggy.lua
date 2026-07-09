-- ==========================================================
-- JOSEANGEL_BLOX PIGGY PRO - V1.3 | PROFESSIONAL EDITION
-- Creador: JoseAngel_Blox | Optimizado por Zapia
-- ==========================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Limpiar versión anterior
pcall(function() CoreGui.JoseAngelPiggyPro:Destroy() end)

-- ==========================================================
-- BASE DE DATOS COMPLETA DE ÍTEMS (Libro 1 + Libro 2)
-- ==========================================================
local ItemDB = {
    -- LLAVES (Keys)
    ["redkey"] = "🔑 Llave Roja", ["bluekey"] = "🔑 Llave Azul",
    ["greenkey"] = "🔑 Llave Verde", ["yellowkey"] = "🔑 Llave Amarilla",
    ["whitekey"] = "🔑 Llave Blanca", ["purplekey"] = "🔑 Llave Morada",
    ["orangekey"] = "🔑 Llave Naranja", ["cyan key"] = "🔑 Llave Cian",
    ["key"] = "🔑 Llave",

    -- HERRAMIENTAS LIBRO 1
    ["hammer"] = "🔨 Martillo", ["wrench"] = "🔧 Llave Inglesa",
    ["plank"] = "🪵 Tabla", ["green gear"] = "⚙️ Engranaje Verde",
    ["red gear"] = "⚙️ Engranaje Rojo", ["gear"] = "⚙️ Engranaje",
    ["gas"] = "⛽ Gasolina", ["gas can"] = "⛽ Gasolina",
    ["battery"] = "🔋 Batería",
    ["red egg"] = "🥚 Huevo Rojo", ["blue egg"] = "🥚 Huevo Azul",
    ["torch"] = "🔥 Antorcha", ["wood"] = "🪵 Leña",
    ["book"] = "📖 Libro", ["syringe"] = "💉 Jeringa",
    ["crossbow"] = "🏹 Ballesta", ["ammo"] = "🎯 Munición",
    ["chain"] = "⛓️ Cadena", ["hook"] = "🪝 Gancho",
    ["grass"] = "🌿 Pasto", ["shovel"] = "🪣 Pala",
    ["code"] = "🔢 Código",

    -- HERRAMIENTAS LIBRO 2
    ["screwdriver"] = "🪛 Destornillador", ["broom"] = "🧹 Escoba",
    ["scissors"] = "✂️ Tijeras", ["carrot"] = "🥕 Zanahoria",
    ["ladder"] = "🪜 Escalera", ["smoke"] = "💨 Humo",
    ["lens"] = "🔍 Lente", ["magnifying glass"] = "🔍 Lente",
    ["crowbar"] = "🔧 Palanca", ["plunger"] = "🪠 Ventosa",
    ["cog"] = "⚙️ Rueda Dentada", ["dynamite"] = "💣 Dinamita",
    ["rope"] = "🪢 Cuerda", ["keypad"] = "🔢 Teclado",
    ["remote"] = "📡 Control Remoto", ["coin"] = "🪙 Moneda",
    ["token"] = "🪙 Ficha", ["transmitter"] = "📡 Transmisor",
    ["crank"] = "🔩 Manivela", ["valve"] = "🔧 Válvula",
    ["arrow"] = "🏹 Flecha",
    ["purple tube"] = "🟣 Tubo Morado",
    ["tube"] = "🧪 Tubo",
    ["munition"] = "🎯 Munición",
}

-- ==========================================================
-- FUNCIÓN PARA TRADUCIR NOMBRES DE ÍTEMS
-- ==========================================================
local function TranslateItem(rawName)
    if not rawName then return nil end
    local n = rawName:lower():gsub("%s+", " ")

    for pattern, translated in pairs(ItemDB) do
        if n:find(pattern, 1, true) then
            return translated
        end
    end

    local keywords = {"key", "gear", "egg", "ammo", "tube", "cog"}
    for _, kw in pairs(keywords) do
        if n:find(kw) then
            return "📦 " .. rawName
        end
    end

    return nil
end

-- ==========================================================
-- INTERFAZ PROFESIONAL
-- ==========================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngelPiggyPro"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 420, 0, 350)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Color = Color3.fromRGB(255, 80, 80)
Stroke.Thickness = 2
Stroke.Transparency = 0.3

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 38)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "JoseAngel_Blox Piggy PRO"
Title.TextColor3 = Color3.fromRGB(255, 80, 80)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -30, 0, 7)
CloseBtn.Text = "✕"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.BackgroundTransparency = 1
CloseBtn.TextSize = 18
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    for _, v in pairs(Workspace:GetDescendants()) do
        if v.Name == "ProESP" or v.Name == "ItemESP" then v:Destroy() end
    end
end)

local Sep = Instance.new("Frame", MainFrame)
Sep.Size = UDim2.new(1, -30, 0, 1)
Sep.Position = UDim2.new(0, 15, 0, 38)
Sep.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
Sep.BackgroundTransparency = 0.7
Sep.BorderSizePixel = 0

-- ==========================================================
-- PESTAÑAS
-- ==========================================================
local TabBar = Instance.new("Frame", MainFrame)
TabBar.Size = UDim2.new(1, -20, 0, 36)
TabBar.Position = UDim2.new(0, 10, 0, 44)
TabBar.BackgroundTransparency = 1

local TabLayout = Instance.new("UIListLayout", TabBar)
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.Padding = UDim.new(0, 6)

local PageHolder = Instance.new("Frame", MainFrame)
PageHolder.Size = UDim2.new(1, -20, 1, -90)
PageHolder.Position = UDim2.new(0, 10, 0, 84)
PageHolder.BackgroundTransparency = 1

local TabButtons = {}
local Pages = {}

local function CreateTab(name)
    local btn = Instance.new("TextButton", TabBar)
    btn.Size = UDim2.new(0, 120, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(180, 180, 180)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 12
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local page = Instance.new("ScrollingFrame", PageHolder)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = Color3.fromRGB(255, 80, 80)
    page.Visible = false
    page.CanvasSize = UDim2.new(0, 0, 0, 0)

    local layout = Instance.new("UIListLayout", page)
    layout.Padding = UDim.new(0, 6)
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        page.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end)

    btn.MouseButton1Click:Connect(function()
        for _, b in pairs(TabButtons) do
            b.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
            b.TextColor3 = Color3.fromRGB(180, 180, 180)
        end
        for _, p in pairs(Pages) do p.Visible = false end
        btn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        page.Visible = true
    end)

    table.insert(TabButtons, btn)
    table.insert(Pages, page)
    return page
end

local PageInfo = CreateTab("📋 Info")
local PagePlayer = CreateTab("🎯 Jugador")
local PagePiggy = CreateTab("👹 Piggy")
local PageItems = CreateTab("📦 Items")

TabButtons[1].BackgroundColor3 = Color3.fromRGB(255, 80, 80)
TabButtons[1].TextColor3 = Color3.fromRGB(255, 255, 255)
Pages[1].Visible = true

-- ==========================================================
-- COMPONENTE: SWITCH PROFESIONAL
-- ==========================================================
local function CreateSwitch(parent, text, callback)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1, -2, 0, 36)
    frame.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local label = Instance.new("TextLabel", frame)
    label.Text = "  " .. text
    label.Size = UDim2.new(1, -55, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(210, 210, 215)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.TextSize = 13

    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0, 38, 0, 20)
    btn.Position = UDim2.new(1, -46, 0.5, -10)
    btn.BackgroundColor3 = Color3.fromRGB(55, 55, 62)
    btn.Text = ""
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)

    local dot = Instance.new("Frame", btn)
    dot.Size = UDim2.new(0, 16, 0, 16)
    dot.Position = UDim2.new(0, 2, 0.5, -8)
    dot.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    dot.BorderSizePixel = 0
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        local targetPos = active and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        local targetColor = active and Color3.fromRGB(255, 80, 80) or Color3.fromRGB(55, 55, 62)
        TweenService:Create(dot, TweenInfo.new(0.2), {Position = targetPos}):Play()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
        callback(active)
    end)
end

local function CreateLabel(parent, text)
    local lbl = Instance.new("TextLabel", parent)
    lbl.Size = UDim2.new(1, -2, 0, 26)
    lbl.BackgroundTransparency = 1
    lbl.Text = " " .. text
    lbl.TextColor3 = Color3.fromRGB(160, 160, 170)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 12
end

-- ==========================================================
-- PÁGINA INFO
-- ==========================================================
CreateLabel(PageInfo, "👑 Creador: JoseAngel_Blox")
CreateLabel(PageInfo, "📅 Versión: 1.3 - Profesional")
CreateLabel(PageInfo, "🎮 Juego: Piggy (Libro 1 y 2)")
CreateLabel(PageInfo, "")
CreateLabel(PageInfo, "✅ ESP Items con traducción completa")
CreateLabel(PageInfo, "✅ ESP Jugadores/Piggy/Bots")
CreateLabel(PageInfo, "✅ Noclip / Godmode / Speed")
CreateLabel(PageInfo, "✅ Auto Grab / Unlock / Kill Aura")
CreateLabel(PageInfo, "✅ Invisible Piggy / Trampas")

-- ==========================================================
-- VARIABLES GLOBALES
-- ==========================================================
local Toggles = {
    ESPMobs = false, ESPItems = false,
    Noclip = false, Godmode = false,
    SpeedJump = false, Stamina = false,
    AutoGrab = false, AutoUnlock = false,
    KillAura = false, Invisible = false
}

-- ==========================================================
-- PÁGINA JUGADOR
-- ==========================================================

CreateSwitch(PagePlayer, "ESP Jugadores / Piggy", function(state)
    Toggles.ESPMobs = state
    while Toggles.ESPMobs and task.wait(1.5) do
        pcall(function()
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("Humanoid") and v ~= LocalPlayer.Character then
                    if not v:FindFirstChild("ProESP_HL") then
                        local hl = Instance.new("Highlight")
                        hl.Name = "ProESP_HL"
                        hl.FillColor = v.Name:find("Piggy") and Color3.new(1, 0, 0) or Color3.new(0, 0.6, 1)
                        hl.OutlineColor = Color3.new(1, 1, 1)
                        hl.FillTransparency = 0.5
                        hl.OutlineTransparency = 0.3
                        hl.Parent = v
                    end
                end
            end
        end)
    end
    for _, v in pairs(Workspace:GetDescendants()) do
        if v.Name == "ProESP_HL" then v:Destroy() end
    end
end)

CreateSwitch(PagePlayer, "Noclip (Atravesar Paredes)", function(state)
    Toggles.Noclip = state
end)

CreateSwitch(PagePlayer, "Godmode (Invencible)", function(state)
    Toggles.Godmode = state
end)

CreateSwitch(PagePlayer, "Speed + Jump (Velocidad)", function(state)
    Toggles.SpeedJump = state
    if not state then
        pcall(function()
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
            LocalPlayer.Character.Humanoid.JumpPower = 50
        end)
    end
end)

CreateSwitch(PagePlayer, "Infinite Stamina (Sin Cansancio)", function(state)
    Toggles.Stamina = state
end)

CreateSwitch(PagePlayer, "Auto Recoger Objetos", function(state)
    Toggles.AutoGrab = state
end)

CreateSwitch(PagePlayer, "Auto Abrir Puertas", function(state)
    Toggles.AutoUnlock = state
end)

-- ==========================================================
-- PÁGINA PIGGY
-- ==========================================================
CreateLabel(PagePiggy, "─═★ Solo si eres Piggy ★═─")

CreateSwitch(PagePiggy, "Kill Aura (Matar Automático)", function(state)
    Toggles.KillAura = state
end)

CreateSwitch(PagePiggy, "Invisible (Modo Fantasma)", function(state)
    Toggles.Invisible = state
    pcall(function()
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = state and 1 or 0
                elseif part:IsA("Decal") then
                    part.Transparency = state and 1 or 0
                end
            end
        end
    end)
end)

-- ==========================================================
-- PÁGINA ITEMS (ESP con traducción)
-- ==========================================================
CreateLabel(PageItems, "📦 ESP completo con traducción")
CreateLabel(PageItems, "   Muestra nombre + distancia")

CreateSwitch(PageItems, "ESP Items (Todos los mapas)", function(state)
    Toggles.ESPItems = state

    while Toggles.ESPItems and task.wait(0.8) do
        pcall(function()
            local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not root then return end

            for _, v in pairs(Workspace:GetDescendants()) do
                if (v:IsA("ClickDetector") or v:IsA("ProximityPrompt")) and v.Parent:IsA("BasePart") then
                    local part = v.Parent
                    local cleanName = TranslateItem(part.Name)
                    if cleanName and not part:FindFirstChild("ItemESP") then
                        local bg = Instance.new("BillboardGui", part)
                        bg.Name = "ItemESP"
                        bg.Size = UDim2.new(0, 160, 0, 50)
                        bg.AlwaysOnTop = true
                        bg.StudsOffset = Vector3.new(0, 2, 0)
                        local txt = Instance.new("TextLabel", bg)
                        txt.Size = UDim2.new(1, 0, 1, 0)
                        txt.BackgroundTransparency = 1
                        txt.TextColor3 = Color3.fromRGB(255, 215, 0)
                        txt.Font = Enum.Font.GothamBold
                        txt.TextSize = 13
                        txt.TextStrokeTransparency = 0.2
                        txt.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                    end

                    local bg = part:FindFirstChild("ItemESP")
                    if bg and bg:FindFirstChild("TextLabel") then
                        local dist = math.floor((root.Position - part.Position).Magnitude)
                        bg.TextLabel.Text = cleanName .. "\n[" .. dist .. "m]"
                    end
                end

                if v:IsA("BasePart") and v.Name:lower():find("key") and not v:FindFirstChild("ItemESP") then
                    local cleanName = TranslateItem(v.Name)
                    if cleanName then
                        local bg = Instance.new("BillboardGui", v)
                        bg.Name = "ItemESP"
                        bg.Size = UDim2.new(0, 160, 0, 50)
                        bg.AlwaysOnTop = true
                        local txt = Instance.new("TextLabel", bg)
                        txt.Size = UDim2.new(1, 0, 1, 0)
                        txt.BackgroundTransparency = 1
                        txt.TextColor3 = Color3.fromRGB(255, 215, 0)
                        txt.Font = Enum.Font.GothamBold
                        txt.TextSize = 13
                        txt.TextStrokeTransparency = 0.2
                        txt.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                    end
                end
            end
        end)
    end

    for _, v in pairs(Workspace:GetDescendants()) do
        if v.Name == "ItemESP" then v:Destroy() end
    end
end)

-- ==========================================================
-- BUCLES DE LÓGICA
-- ==========================================================

RunService.Stepped:Connect(function()
    if Toggles.Noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

task.spawn(function()
    while task.wait() do
        pcall(function()
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChild("Humanoid")
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if not hum or not root then return end

            if Toggles.SpeedJump then
                hum.WalkSpeed = 40
                hum.JumpPower = 75
                hum.UseJumpPower = true
            end

            if Toggles.Stamina then
                hum.WalkSpeed = math.max(hum.WalkSpeed, 22)
                for _, val in pairs(char:GetDescendants()) do
                    if val:IsA("NumberValue") and (val.Name:lower():find("energy") or val.Name:lower():find("stamina")) then
                        val.Value = 100
                    end
                end
            end

            if Toggles.Godmode then
                for _, v in pairs(Workspace:GetDescendants()) do
                    if v:IsA("TouchTransmitter") then
                        v:Destroy()
                    end
                end
            end

            if Toggles.AutoGrab then
                for _, v in pairs(Workspace:GetDescendants()) do
                    if v:IsA("ClickDetector") and v.Parent:IsA("BasePart") then
                        local dist = (root.Position - v.Parent.Position).Magnitude
                        if dist <= 18 then
                            fireclickdetector(v)
                        end
                    end
                    if v:IsA("ProximityPrompt") and v.Parent:IsA("BasePart") then
                        local dist = (root.Position - v.Parent.Position).Magnitude
                        if dist <= 18 then
                            fireproximityprompt(v)
                            task.wait(0.3)
                        end
                    end
                end
            end

            if Toggles.AutoUnlock then
                local tool = char:FindFirstChildOfClass("Tool")
                if tool and tool:FindFirstChild("Handle") then
                    for _, v in pairs(Workspace:GetDescendants()) do
                        if v:IsA("ProximityPrompt") then
                            local dist = (root.Position - v.Parent.Position).Magnitude
                            if dist <= 25 then
                                fireproximityprompt(v)
                            end
                        end
                        if v:IsA("ClickDetector") then
                            local dist = (root.Position - v.Parent.Position).Magnitude
                            if dist <= 25 then
                                fireclickdetector(v)
                            end
                        end
                    end
                end
            end

            if Toggles.KillAura then
                local weapon = char:FindFirstChildOfClass("Tool")
       
