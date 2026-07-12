--[[
╔══════════════════════════════════════════════════════════╗
║   🐒  KICK A LUCKY BLOCK — JUNGLE EVENT AUTO-FARM      ║
║   Evento de la Selva — Auto Banana Farmer                ║
║   Hecho por Zapia para José Angel                       ║
╚══════════════════════════════════════════════════════════╝
--]]

-- ============================================
-- ⚙️  CONFIGURACIÓN
-- ============================================
local Settings = {
    ToggleKey = "X",
    AutoKick = true,
    DebugMode = false,
    JumpInterval = 0.3,
    RunSpeed = 22,
    MaxCourseTime = 45,
    LavaDetectionHeight = 3,
    AutoReturnToZone = true,
}

-- ============================================
-- 🧩  VARIABLES GLOBALES
-- ============================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

local Running = false
local IsInCourse = false
local EventActive = false
local CurrentTask = "🟢 Esperando..."

-- ============================================
-- 📢  NOTIFICACIONES
-- ============================================
local function notify(msg)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "🌴 Evento Selva",
        Text = msg,
        Duration = 5
    })
end

local function log(msg)
    if Settings.DebugMode then
        print("[🌴 Selva] " .. msg)
    end
end

-- ============================================
-- 🔍  DETECCIÓN DE ELEMENTOS DEL EVENTO
-- ============================================

local function findPortal()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        local name = obj.Name:lower()
        if (name:find("portal") or name:find("jungle") or name:find("event")) and obj:IsA("Part") then
            if obj.BrickColor and obj.BrickColor.Name == "Bright yellow" then
                return obj
            end
            local color = obj.Color
            if color and color.r > 0.8 and color.g > 0.7 and color.b < 0.3 then
                return obj
            end
        end
    end
    return nil
end

local function findBanana()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        local name = obj.Name:lower()
        if (name:find("banana") or name:find("platano") or name:find("fruit")) and obj:IsA("BasePart") then
            return obj
        end
    end
    return nil
end

local function findFinishLine()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        local name = obj.Name:lower()
        if (name:find("finish") or name:find("meta") or name:find("goal") or name:find("end") or name:find("llegada")) and obj:IsA("BasePart") then
            return obj
        end
    end
    return nil
end

-- ============================================
-- 🦶  MOVIMIENTO Y PARKOUR AUTOMÁTICO
-- ============================================

local function moveTo(targetPos, speed)
    speed = speed or Settings.RunSpeed
    local direction = (targetPos - HumanoidRootPart.Position).Unit
    Humanoid:Move(direction, true)
end

local function stopMoving()
    Humanoid:Move(Vector3.zero, false)
end

local function jump()
    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
end

local function isLavaBelow()
    local origin = HumanoidRootPart.Position
    local ray = Ray.new(origin, Vector3.new(0, -Settings.LavaDetectionHeight, 0))
    local hit, pos = Workspace:FindPartOnRay(ray, Character)
    if hit then
        local name = hit.Name:lower()
        if name:find("lava") or name:find("fire") or name:find("fuego") or name:find("damage") or hit.BrickColor.Name == "Bright red" or hit.BrickColor.Name == "Really red" then
            return true
        end
    end
    return false
end

local function isObstacleAhead(distance)
    distance = distance or 5
    local origin = HumanoidRootPart.Position
    local lookDir = HumanoidRootPart.CFrame.LookVector
    local ray = Ray.new(origin + Vector3.new(0, 1, 0), lookDir * distance)
    local hit = Workspace:FindPartOnRay(ray, Character)
    return hit ~= nil
end

-- ============================================
-- 🏃  NAVEGACIÓN DEL RECORRIDO
-- ============================================

local function navigateObstacleCourse()
    IsInCourse = true
    local startTime = tick()

    while IsInCourse and (tick() - startTime) < Settings.MaxCourseTime do
        local finish = findFinishLine()
        if finish then
            local dist = (HumanoidRootPart.Position - finish.Position).Magnitude
            if dist < 5 then
                stopMoving()
                IsInCourse = false
                return true
            end
            moveTo(finish.Position)
        else
            local lookDir = HumanoidRootPart.CFrame.LookVector
            moveTo(HumanoidRootPart.Position + lookDir * 20)
        end

        if isLavaBelow() then
            jump()
            wait(0.1)
        end

        if isObstacleAhead(4) then
            jump()
            wait(0.15)
        end

        if HumanoidRootPart.Position.Y < -10 then
            IsInCourse = false
            return false
        end

        wait(Settings.JumpInterval)
    end

    stopMoving()
    IsInCourse = false
    return false
end

-- ============================================
-- 🔄  CICLO PRINCIPAL DEL EVENTO
-- ============================================

local function executeJungleRun()
    notify("Buscando portal del evento...")
    wait(2)

    local portal = findPortal()
    if not portal then
        return false
    end

    HumanoidRootPart.CFrame = portal.CFrame + Vector3.new(0, 3, 0)
    wait(1.5)

    local banana = findBanana()
    if not banana then
        return false
    end

    HumanoidRootPart.CFrame = banana.CFrame + Vector3.new(0, 2, 1)
    wait(0.5)

    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, nil)
    wait(0.1)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, nil)

    notify("🍌 Plátano robado! A correr!")
    wait(0.5)

    local success = navigateObstacleCourse()

    if success then
        notify("🎉 Banana obtenida!")
        return true
    else
        return false
    end
end

-- ============================================
-- 🦶  AUTO KICK (mientras espera)
-- ============================================

local function autoKick()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        local name = obj.Name:lower()
        if (name:find("block") or name:find("lucky") or name:find("kick")) and obj:IsA("BasePart") and obj:FindFirstChild("ClickDetector") then
            fireclickdetector(obj.ClickDetector)
            return
        end
    end

    local parts = Workspace:GetPartsInPart(HumanoidRootPart, 15)
    for _, part in ipairs(parts) do
        if part:FindFirstChild("ClickDetector") then
            fireclickdetector(part.ClickDetector)
            return
        end
    end
end

-- ============================================
-- 🚀  MAIN LOOP
-- ============================================

local function farmLoop()
    while Running do
        local portal = findPortal()
        EventActive = portal ~= nil

        if EventActive then
            notify("🌴 Evento de la Selva detectado!")
            local ok = executeJungleRun()

            if ok and Settings.AutoReturnToZone then
                wait(2)
                local spawnLocation = Workspace:FindFirstChild("SpawnLocation") or
                                     Workspace:FindFirstChild("Spawn") or
                                     Workspace:FindFirstChild("Baseplate")
                if spawnLocation then
                    HumanoidRootPart.CFrame = spawnLocation.CFrame + Vector3.new(0, 5, 0)
                end
                wait(3)
            elseif not ok then
                wait(5)
            end
        else
            if Settings.AutoKick then
                autoKick()
            end
            wait(2.5)
        end
        wait(1)
    end
end

-- ============================================
-- 🎮  CONTROLES
-- ============================================

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode[Settings.ToggleKey] then
        Running = not Running
        if Running then
            notify("🌴 Auto-Farm ACTIVADO")
            coroutine.wrap(farmLoop)()
        else
            notify("⏸️ Auto-Farm PAUSADO")
            IsInCourse = false
            stopMoving()
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
    Humanoid = char:WaitForChild("Humanoid")
end)

print([[
╔══════════════════════════════════════════╗
║  🌴  KICK A LUCKY BLOCK                  ║
║     JUNGLE EVENT AUTO-FARM               ║
║                                          ║
║  Presiona X para iniciar                 ║
║  Corre cada 2h — Dura 15 min             ║
║  Hasta el 19 de Julio 2026               ║
╚══════════════════════════════════════════╝
]])

notify("🌴 Script cargado! Presiona X para iniciar")
