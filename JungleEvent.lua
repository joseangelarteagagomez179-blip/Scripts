--[[
╔══════════════════════════════════════════════════════════════╗
║        🦧  JoseAngel_Blox AutoObby — Jungle Event          ║
║                                                              ║
║  🤖 Completa el obby SOLO: entra, roba la banana,           ║
║     navega obstáculos, esquiva lava + Glorbo                ║
║  🎯 Totalmente automático — tú solo miras                   ║
║                                                              ║
║  Hecho por Zapia para José Angel                            ║
╚══════════════════════════════════════════════════════════════╝
--]]

-- ============================================
-- ⚙️  CONFIGURACIÓN
-- ============================================
local Settings = {
    WalkSpeed = 28,
    JumpPower = 55,
    JumpHeight = 14,
    LavaDetection = 15,
    PlatformRange = 30,
    GlorboRange = 25,
    StealRange = 8,
    ExitRange = 5,
    CheckInterval = 0.1,
}

-- ============================================
-- 🧩  SERVICIOS
-- ============================================
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LP = Players.LocalPlayer

-- ============================================
-- 🧠  VARIABLES GLOBALES
-- ============================================
local AutoEnabled = false
local State = "IDLE"
local BananaStolen = false
local Connection = nil
local MoveConnection = nil
local TargetPlatform = nil
local LavaParts = {}
local Glorbo = nil
local Portal = nil
local ExitZone = nil

local function isInEvent()
    local char = LP.Character
    if not char then return false end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    return Workspace:FindFirstChild("Jungle") ~= nil or 
           Workspace:FindFirstChild("JungleEvent") ~= nil or
           Workspace:FindFirstChild("JunglePortal") ~= nil
end

-- ============================================
-- 🔍  DETECTOR DE PARTES
-- ============================================

local function findPortal()
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("Part") or v:IsA("MeshPart") then
            local color = v.Color
            if color.R > 0.8 and color.G > 0.7 and color.B < 0.3 then
                if v.Size.X > 3 and v.Size.Y > 5 then
                    return v
                end
            end
            local name = v.Name:lower()
            if name:find("portal") or name:find("jungle") or name:find("event") then
                return v
            end
        end
    end
    return nil
end

local function findBanana()
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") and v:FindFirstChildOfClass("TouchInterest") then
            local color = v.Color
            if color.R > 0.85 and color.G > 0.8 and color.B < 0.4 then
                if v.Size.X < 5 and v.Size.Y < 5 then
                    return v
                end
            end
            local name = v.Name:lower()
            if name:find("banana") or name:find("fruit") then
                return v
            end
        end
    end
    return nil
end

local function findGlorbo()
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then
            local hum = v:FindFirstChildOfClass("Humanoid")
            if hum then
                local name = v.Name:lower()
                if name:find("glorbo") or name:find("gorilla") or name:find("monkey") or name:find("boss") then
                    return v:FindFirstChild("HumanoidRootPart")
                end
            end
        end
    end
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then
            local hrp = v:FindFirstChild("HumanoidRootPart")
            if hrp and hrp.Size.Y > 5 then
                return hrp
            end
        end
    end
    return nil
end

local function scanLava()
    LavaParts = {}
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") and (v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation")) then
            local color = v.Color
            local name = v.Name:lower()
            if color.R > 0.7 and color.G < 0.4 and color.B < 0.2 then
                table.insert(LavaParts, v)
            elseif name:find("lava") or name:find("fire") or name:find("hot") then
                table.insert(LavaParts, v)
            end
        end
    end
end

local function findExit()
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            local name = v.Name:lower()
            if name:find("exit") or name:find("safe") or name:find("finish") or name:find("end") or name:find("zone") then
                return v
            end
        end
    end
    return nil
end

local function findBestPlatform(charPos, direction)
    local best = nil
    local bestDist = math.huge
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") and (v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation")) then
            if table.find(LavaParts, v) then continue end
            local pos = v.Position
            local dist = (pos - charPos).Magnitude
            if dist < Settings.PlatformRange and dist > 1 then
                if pos.Y > charPos.Y - 2 and pos.Y < charPos.Y + 15 then
                    if dist < bestDist then
                        bestDist = dist
                        best = v
                    end
                end
            end
        end
    end
    return best
end

local function isLavaNearby(charPos)
    for _, lava in pairs(LavaParts) do
        local dist = (lava.Position - charPos).Magnitude
        if dist < Settings.LavaDetection then
            return true, lava
        end
    end
    return false, nil
end

-- ============================================
-- 🚀  FUNCIÓN DE MOVIMIENTO AUTÓNOMO
-- ============================================

local function autoMove(targetPos, jumpIfNeeded)
    local char = LP.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not (hrp and hum) then return end
    hum.WalkSpeed = Settings.WalkSpeed
    hum.JumpHeight = Settings.JumpHeight
    hum.JumpPower = Settings.JumpPower
    hum.AutoRotate = true
    hum:MoveTo(targetPos)
    if jumpIfNeeded then
        local delta = targetPos - hrp.Position
        if delta.Y > 2 then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end

local function needsJump(charPos)
    local origin = charPos + Vector3.new(0, -2, 0)
    local direction = Vector3.new(0, -10, 0)
    local ray = Ray.new(origin, direction)
    local hit, pos = Workspace:FindPartOnRay(ray, LP.Character)
    if not hit then return true end
    if (pos - charPos).Magnitude > 7 then return true end
    local lookDir = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if lookDir then
        local lookVector = lookDir.CFrame.LookVector
        local origin2 = charPos + Vector3.new(0, -1, 0) + lookVector * 3
        local ray2 = Ray.new(origin2, Vector3.new(0, -8, 0))
        local hit2 = Workspace:FindPartOnRay(ray2, LP.Character)
        if not hit2 then return true end
    end
    return false
end

-- ============================================
-- 🏃  ESTADOS DEL AUTO-OBBY
-- ============================================

local function idleState()
    local p = findPortal()
    if p then
        State = "ENTERING"
        Portal = p
        return
    end
    if isInEvent() then
        local b = findBanana()
        if b then
            State = "STEALING"
            return
        end
    end
end

local function enteringState()
    if not Portal then
        State = "IDLE"
        return
    end
    local char = LP.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local dist = (Portal.Position - hrp.Position).Magnitude
    if dist < 5 then
        wait(0.5)
        local newPortal = findPortal()
        if not newPortal then
            State = "STEALING"
            Portal = nil
        end
        return
    end
    autoMove(Portal.Position + Vector3.new(0, 3, 0), false)
end

local function stealingState()
    local char = LP.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local banana = findBanana()
    if not banana then
        State = "IDLE"
        return
    end
    local dist = (banana.Position - hrp.Position).Magnitude
    if dist < Settings.StealRange then
        autoMove(banana.Position, false)
        local touch = banana:FindFirstChildOfClass("TouchInterest")
        if touch then
            firetouchinterest(hrp, banana, 0)
            wait(0.1)
            firetouchinterest(hrp, banana, 1)
        end
        autoMove(banana.Position + Vector3.new(0, 2, 0), false)
        wait(0.5)
        local newBanana = findBanana()
        if not newBanana or (newBanana.Position - banana.Position).Magnitude > 3 then
            BananaStolen = true
            State = "RUNNING"
        end
    else
        autoMove(banana.Position, true)
    end
end

local function runningState()
    local char = LP.Character
    if not char then
        State = "IDLE"
        return
    end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not (hrp and hum) then return end
    local glorboPart = findGlorbo()
    if glorboPart then
        local distGlorbo = (glorboPart.Position - hrp.Position).Magnitude
        if distGlorbo < Settings.GlorboRange then
            local escapeDir = (hrp.Position - glorboPart.Position).unit
            local escapePos = hrp.Position + escapeDir * 30
            hum.WalkSpeed = Settings.WalkSpeed + 10
            autoMove(escapePos, true)
            wait(0.3)
            hum.WalkSpeed = Settings.WalkSpeed
        end
    end
    local lavaNear, lavaPart = isLavaNearby(hrp.Position)
    if lavaNear and lavaPart then
        local dodgeDir = (hrp.Position - lavaPart.Position).unit
        local dodgePos = hrp.Position + dodgeDir * 10 + Vector3.new(0, 5, 0)
        hum.WalkSpeed = Settings.WalkSpeed + 10
        autoMove(dodgePos, true)
        wait(0.3)
        hum.WalkSpeed = Settings.WalkSpeed
    end
    local exit = findExit()
    if exit then
        local distExit = (exit.Position - hrp.Position).Magnitude
        if distExit < Settings.ExitRange then
            State = "COMPLETE"
            return
        end
        autoMove(exit.Position, needsJump(hrp.Position))
        return
    end
    local lookVector = hrp.CFrame.LookVector
    local target = hrp.Position + lookVector * 15
    local platform = findBestPlatform(hrp.Position, lookVector)
    if platform then
        target = platform.Position + Vector3.new(0, 3, 0)
    end
    local shouldJump = needsJump(hrp.Position)
    autoMove(target, shouldJump)
    wait(0.5)
end

local function completeState()
    local char = LP.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not (hrp and hum) then return end
    hum.WalkSpeed = 16
    hum:MoveTo(hrp.Position)
    BananaStolen = false
    State = "IDLE"
end

-- ============================================
-- 🔄  LOOP PRINCIPAL
-- ============================================

local function autoLoop()
    while AutoEnabled do
        local char = LP.Character
        if not char then
            wait(1)
            continue
        end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then
            wait(1)
            continue
        end
        scanLava()
        if State == "IDLE" then
            idleState()
        elseif State == "ENTERING" then
            enteringState()
        elseif State == "STEALING" then
            stealingState()
        elseif State == "RUNNING" then
            runningState()
        elseif State == "COMPLETE" then
            completeState()
        end
        wait(Settings.CheckInterval)
    end
end

-- ============================================
-- 🎨  GUI — TEMÁTICA JUNGLA
-- ============================================

local gui = Instance.new("ScreenGui")
gui.Name = "JoseAngelAutoObby"
gui.ResetOnSpawn = false

local box = Instance.new("Frame")
box.Size = UDim2.new(0, 85, 0, 100)
box.Position = UDim2.new(0.5, -42, 0.75, -50)
box.BackgroundColor3 = Color3.fromRGB(13, 45, 20)
box.BackgroundTransparency = 0.1
box.BorderSizePixel = 0
box.Active = true
box.Draggable = true
box.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = box

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(50, 205, 80)
stroke.Thickness = 2.5
stroke.Parent = box

local function hoja(p, r, s, c)
    local h = Instance.new("Frame")
    h.Size = UDim2.new(0, s or 10, 0, s or 10)
    h.Position = p
    h.BackgroundColor3 = c or Color3.fromRGB(34, 139, 34)
    h.BackgroundTransparency = 0.2
    h.BorderSizePixel = 0
    h.Rotation = r or 0
    Instance.new("UICorner").CornerRadius = UDim.new(0, 5)
    Instance.new("UICorner").Parent = h
    h.Parent = box
end
hoja(UDim2.new(0, -3, 0, -3), 45, 12, Color3.fromRGB(50, 180, 50))
hoja(UDim2.new(1, -7, 0, -3), -45, 12, Color3.fromRGB(40, 160, 40))
hoja(UDim2.new(0, -3, 1, -7), -45, 12, Color3.fromRGB(60, 200, 60))
hoja(UDim2.new(1, -7, 1, -7), 45, 12, Color3.fromRGB(34, 139, 34))

local titulo = Instance.new("TextLabel")
titulo.Size = UDim2.new(1, -10, 0, 18)
titulo.Position = UDim2.new(0, 5, 0, 5)
titulo.BackgroundTransparency = 1
titulo.Text = "🦧 AUTO OBBY"
titulo.TextSize = 12
titulo.TextColor3 = Color3.fromRGB(200, 255, 200)
titulo.Font = Enum.Font.SourceSansBold
titulo.Parent = box

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(1, -10, 0, 30)
toggleBtn.Position = UDim2.new(0, 5, 0, 25)
toggleBtn.BackgroundColor3 = Color3.fromRGB(20, 70, 30)
toggleBtn.BackgroundTransparency = 0.3
toggleBtn.BorderSizePixel = 0
toggleBtn.Text = "▶ ACTIVAR"
toggleBtn.TextSize = 14
toggleBtn.TextColor3 = Color3.fromRGB(200, 255, 200)
toggleBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner").CornerRadius = UDim.new(0, 8)
Instance.new("UICorner").Parent = toggleBtn
toggleBtn.Parent = box

local estadoLabel = Instance.new("TextLabel")
estadoLabel.Size = UDim2.new(1, -10, 0, 14)
estadoLabel.Position = UDim2.new(0, 5, 0, 58)
estadoLabel.BackgroundTransparency = 1
estadoLabel.Text = "⏸ DETENIDO"
estadoLabel.TextSize = 11
estadoLabel.TextColor3 = Color3.fromRGB(180, 200, 180)
estadoLabel.Font = Enum.Font.SourceSans
estadoLabel.Parent = box

local detalleLabel = Instance.new("TextLabel")
detalleLabel.Size = UDim2.new(1, -10, 0, 14)
detalleLabel.Position = UDim2.new(0, 5, 0, 72)
detalleLabel.BackgroundTransparency = 1
detalleLabel.Text = "🌴 Esperando..."
detalleLabel.TextSize = 10
detalleLabel.TextColor3 = Color3.fromRGB(140, 200, 140)
detalleLabel.Font = Enum.Font.SourceSans
detalleLabel.Parent = box

local bananaCount = Instance.new("TextLabel")
bananaCount.Size = UDim2.new(1, -10, 0, 12)
bananaCount.Position = UDim2.new(0, 5, 0, 86)
bananaCount.BackgroundTransparency = 1
bananaCount.Text = "🍌 0"
bananaCount.TextSize = 10
bananaCount.TextColor3 = Color3.fromRGB(255, 220, 100)
bananaCount.Font = Enum.Font.SourceSansBold
bananaCount.Parent = box

-- ============================================
-- 🎯  TOGGLES
-- ============================================

local bananasGathered = 0

toggleBtn.MouseButton1Click:Connect(function()
    AutoEnabled = not AutoEnabled
    if AutoEnabled then
        toggleBtn.Text = "⏹ DETENER"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 20)
        box.BackgroundColor3 = Color3.fromRGB(20, 60, 30)
        stroke.Color = Color3.fromRGB(255, 100, 100)
        estadoLabel.Text = "▶ ACTIVO"
        estadoLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        State = "IDLE"
        BananaStolen = false
        coroutine.wrap(autoLoop)()
    else
        toggleBtn.Text = "▶ ACTIVAR"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(20, 70, 30)
        box.BackgroundColor3 = Color3.fromRGB(13, 45, 20)
        stroke.Color = Color3.fromRGB(50, 205, 80)
        estadoLabel.Text = "⏸ DETENIDO"
        estadoLabel.TextColor3 = Color3.fromRGB(180, 200, 180)
        local char = LP.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.WalkSpeed = 16
                hum:MoveTo(char:FindFirstChild("HumanoidRootPart").Position)
            end
        end
    end
end)

spawn(function()
    while true do
        if AutoEnabled then
            local stateText = ""
            if State == "IDLE" then stateText = "🌴 Buscando portal..."
            elseif State == "ENTERING" then stateText = "🚪 Entrando..."
            elseif State == "STEALING" then stateText = "🍌 Robando banana..."
            elseif State == "RUNNING" then stateText = "🏃 Completando obby..."
            elseif State == "COMPLETE" then stateText = "✅ Banana obtenida!"
            end
            detalleLabel.Text = stateText
            bananaCount.Text = "🍌 " .. bananasGathered
        end
        wait(0.3)
    end
end)

LP.CharacterAdded:Connect(function()
    wait(1.5)
    if AutoEnabled then
        State = "IDLE"
    end
end)

spawn(function()
    while true do
        wait(2)
        if AutoEnabled and State == "COMPLETE" then
            bananasGathered = bananasGathered + 1
            local char = LP.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum.WalkSpeed = 16
                end
            end
            State = "IDLE"
            wait(1)
        end
    end
end)

-- ============================================
-- 🖥️  INICIO
-- ============================================

gui.Parent = CoreGui

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "🦧 JoseAngel AutoObby",
    Text = "✅ Cargado! Toca ACTIVAR para auto-farmear",
    Duration = 4
})
