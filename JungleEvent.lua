--[[
╔══════════════════════════════════════════════════════════╗
║   🐒  KICK A LUCKY BLOCK - JUNGLE EVENT AUTO-FARM      ║
║   Versión MÓVIL con botón táctil                       ║
╚══════════════════════════════════════════════════════════╝
--]]

-- ⚙️ CONFIGURACIÓN
local Settings = {
    AutoKick = true,
    JumpInterval = 0.3,
    MaxCourseTime = 45,
    AutoReturn = true,
}

-- 🧩 SERVICIOS
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local VirtualInputManager = game:GetService("VirtualInputManager")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LP = Players.LocalPlayer

-- 🎨 GUI FLOTANTE
local gui = Instance.new("ScreenGui")
gui.Name = "JungleEventGUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local btn = Instance.new("Frame")
btn.Size = UDim2.new(0, 60, 0, 60)
btn.Position = UDim2.new(0.5, -30, 0.85, -30)
btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
btn.BackgroundTransparency = 0.15
btn.BorderSizePixel = 0
btn.Active = true
btn.Draggable = true
btn.Parent = gui

Instance.new("UICorner").CornerRadius = UDim.new(0, 30)
Instance.new("UICorner").Parent = btn

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 170, 0)
stroke.Thickness = 2
stroke.Parent = btn

local icono = Instance.new("TextLabel")
icono.Size = UDim2.new(1, 0, 1, 0)
icono.BackgroundTransparency = 1
icono.Text = "🌴"
icono.TextSize = 28
icono.Font = Enum.Font.SourceSansBold
icono.Parent = btn

local estado = Instance.new("TextLabel")
estado.Size = UDim2.new(0, 140, 0, 20)
estado.Position = UDim2.new(0.5, -70, 1, 5)
estado.BackgroundTransparency = 1
estado.Text = "👆 Toca para activar"
estado.TextSize = 13
estado.TextColor3 = Color3.fromRGB(200, 200, 0)
estado.Font = Enum.Font.SourceSans
estado.Parent = btn

local contador = Instance.new("TextLabel")
contador.Size = UDim2.new(0, 140, 0, 20)
contador.Position = UDim2.new(0.5, -70, -25, 0)
contador.BackgroundTransparency = 1
contador.Text = "🍌 0"
contador.TextSize = 13
contador.TextColor3 = Color3.fromRGB(255, 200, 0)
contador.Font = Enum.Font.SourceSans
contador.Parent = btn

-- 🔄 ESTADO
local Running = false
local Bananas = 0
local InCourse = false

-- 📢 NOTIFICACIONES
local function noti(m)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "🌴 Selva", Text = m, Duration = 3
        })
    end)
end

-- 🔍 DETECCIÓN
local function findPortal()
    for _, o in ipairs(Workspace:GetDescendants()) do
        local n = o.Name:lower()
        if (n:find("portal") or n:find("jungle")) and o:IsA("Part") then
            local c = o.Color
            if c and c.r > 0.8 and c.g > 0.7 and c.b < 0.3 then return o end
        end
    end
end

local function findFinish()
    for _, o in ipairs(Workspace:GetDescendants()) do
        local n = o.Name:lower()
        if (n:find("finish") or n:find("meta")) and o:IsA("BasePart") then return o end
    end
end

local function findDescendant(p)
    p = p:lower()
    for _, o in ipairs(Workspace:GetDescendants()) do
        if o.Name:lower():find(p) and o:IsA("BasePart") then return o end
    end
end

-- 🏃 PARKOUR
local function parkour()
    InCourse = true
    local inicio = tick()
    while InCourse and (tick() - inicio) < Settings.MaxCourseTime do
        local c = LP.Character
        local hrp = c and c:FindFirstChild("HumanoidRootPart")
        local hum = c and c:FindFirstChildOfClass("Humanoid")
        if not (c and hrp and hum) then InCourse = false; return false end

        local finish = findFinish()
        if finish then
            local dist = (hrp.Position - finish.Position).Magnitude
            if dist < 8 then InCourse = false; return true end
            local dir = (finish.Position - hrp.Position).Unit
            hum:Move(dir, true)
            local ray = Ray.new(hrp.Position + Vector3.new(0, 0.5, 0), hrp.CFrame.LookVector * 5)
            if Workspace:FindPartOnRay(ray, c) then hum:ChangeState(Enum.HumanoidStateType.Jumping); wait(0.2) end
            if hrp.Position.Y < -5 then wait(2); InCourse = false; return false end
        else
            hum:Move(hrp.CFrame.LookVector, true)
        end
        wait(Settings.JumpInterval)
    end
    InCourse = false; return false
end

-- 🍌 EJECUTAR EVENTO
local function doEvent()
    estado.Text = "🔍 Buscando portal..."
    estado.TextColor3 = Color3.fromRGB(255, 200, 0)
    local portal = findPortal()
    if not portal then estado.Text = "❌ Sin portal"; return false end

    estado.Text = "🚪 Entrando..."
    local c = LP.Character
    local hrp = c and c:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame = portal.CFrame + Vector3.new(0, 5, 0) end
    wait(1.5)

    local banana = findDescendant("banana") or findDescendant("platano")
    if not banana then estado.Text = "❌ Sin plátano"; return false end

    estado.Text = "🍌 Robando..."
    local c2 = LP.Character
    local hrp2 = c2 and c2:FindFirstChild("HumanoidRootPart")
    if hrp2 then hrp2.CFrame = banana.CFrame + Vector3.new(0, 2, 2) end
    wait(0.5)

    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, nil)
    wait(0.15)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, nil)
    estado.Text = "🏃 Huyendo!"
    wait(0.5)

    local ok = parkour()
    if ok then
        Bananas = Bananas + 1
        contador.Text = "🍌 " .. Bananas
        noti("🎉 Banana #" .. Bananas .. " conseguida!")
        estado.Text = "✅ Banana!"
        return true
    else
        estado.Text = "💀 Falló"
        return false
    end
end

-- 🦶 AUTO KICK
local function autoKick()
    local c = LP.Character
    local hrp = c and c:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local parts = Workspace:GetPartsInPart(hrp, 20)
    for _, p in ipairs(parts) do
        local cd = p:FindFirstChild("ClickDetector")
        if cd then fireclickdetector(cd); return end
    end
    for _, o in ipairs(Workspace:GetDescendants()) do
        local n = o.Name:lower()
        if (n:find("block") or n:find("lucky")) and o:IsA("BasePart") then
            local cd = o:FindFirstChild("ClickDetector")
            if cd then fireclickdetector(cd); return end
        end
    end
end

-- 🚀 LOOP
local function mainLoop()
    while Running do
        local portal = findPortal()
        if portal then
            noti("🌴 Evento detectado!")
            doEvent()
            if Settings.AutoReturn then
                wait(2)
                local c = LP.Character
                local hrp = c and c:FindFirstChild("HumanoidRootPart")
                local sp = Workspace:FindFirstChild("SpawnLocation") or Workspace:FindFirstChild("Spawn")
                if sp and hrp then hrp.CFrame = sp.CFrame + Vector3.new(0, 5, 0) end
                wait(3)
            end
        else
            if Settings.AutoKick then autoKick() end
            wait(2.5)
        end
        wait(1)
    end
end

-- 🎯 TOGGLE AL TOCAR
btn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        Running = not Running
        if Running then
            btn.BackgroundColor3 = Color3.fromRGB(20, 80, 20)
            stroke.Color = Color3.fromRGB(0, 255, 0)
            estado.Text = "🟢 Farmeando..."
            estado.TextColor3 = Color3.fromRGB(0, 255, 100)
            noti("🌴 Auto-Farm ACTIVADO")
            coroutine.wrap(mainLoop)()
        else
            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            stroke.Color = Color3.fromRGB(255, 170, 0)
            estado.Text = "⏸️ Pausado"
            estado.TextColor3 = Color3.fromRGB(200, 200, 200)
            InCourse = false
            local c = LP.Character
            local hum = c and c:FindFirstChildOfClass("Humanoid")
            if hum then hum:Move(Vector3.zero, false) end
            noti("⏸️ Pausado")
        end
    end
end)

-- 🖥️ INICIO
local function ini()
    local parent = pcall(function() gui.Parent = CoreGui end) and CoreGui or LP:WaitForChild("PlayerGui")
    gui.Parent = parent
    print("🌴 Botón táctil creado. Tócalo para activar.")
    noti("🌴 Botón creado! Tócalo para activar")
end
ini()
