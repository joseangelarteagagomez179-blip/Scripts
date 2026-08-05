-- ============================================
-- 🚀 Vuelo Rápido a KickReady
-- Juego: Kick a Lucky Block
-- ============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Root = Character:WaitForChild("HumanoidRootPart")

-- ===== CONFIGURACIÓN =====
local SPEED = 250          -- Velocidad de vuelo (súbele para ir más rápido)
local FLOOR_OFFSET = 2.5   -- Altura sobre el piso (vuelo pegado al piso)
local STOP_DISTANCE = 6    -- Distancia a la que se detiene al llegar

-- Zona destino según tu imagen: Workspace > Areas > KickReady
local TargetZone = Workspace:WaitForChild("Areas"):WaitForChild("KickReady")

-- Obtener la posición de la zona
local function GetTargetPosition()
    if TargetZone:IsA("Model") and TargetZone.PrimaryPart then
        return TargetZone.PrimaryPart.Position
    end
    if TargetZone:IsA("BasePart") then
        return TargetZone.Position
    end
    for _, child in ipairs(TargetZone:GetDescendants()) do
        if child:IsA("BasePart") then
            return child.Position
        end
    end
    return nil
end

-- Detectar la altura del piso para ir pegado a él
local function GetGroundHeight(x, z, fallback)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {Character}
    local result = Workspace:Raycast(Vector3.new(x, 2000, z), Vector3.new(0, -4000, 0), params)
    return result and result.Position.Y or fallback
end

local targetPos = GetTargetPosition()
if not targetPos then
    warn("❌ No se encontró la posición de KickReady")
    return
end

print("🚀 Volando a KickReady...")

-- Bucle de vuelo
local connection
connection = RunService.Heartbeat:Connect(function(dt)
    if not Root or not Root.Parent then
        connection:Disconnect()
        return
    end

    local current = Root.Position
    local flat = Vector3.new(targetPos.X, current.Y, targetPos.Z)
    local direction = flat - current
    local distance = direction.Magnitude

    -- Al llegar a la zona, se detiene solo
    if distance <= STOP_DISTANCE then
        connection:Disconnect()
        print("✅ ¡Llegaste a KickReady!")
        return
    end

    direction = direction.Unit

    -- Altura pegada al piso (sigue el terreno)
    local groundY = GetGroundHeight(current.X, current.Z, current.Y)
    local targetY = groundY + FLOOR_OFFSET
    local newY = current.Y + (targetY - current.Y) * math.min(1, dt * 10)

    -- Movimiento a la velocidad configurada
    local step = math.min(SPEED * dt, distance)
    local newPos = current + direction * step
    newPos = Vector3.new(newPos.X, newY, newPos.Z)

    -- El personaje mira hacia donde vuela
    local rotation = CFrame.lookAt(Vector3.new(0, 0, 0), direction)
    Root.CFrame = CFrame.new(newPos) * rotation
end)
