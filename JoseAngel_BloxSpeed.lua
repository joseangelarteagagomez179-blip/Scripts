-- ============================================
-- 🏃 Carrera Turbo a KickReady (SIN teletransporte)
-- Juego: Kick a Lucky Block
-- ============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Root = Character:WaitForChild("HumanoidRootPart")

-- ===== CONFIGURACIÓN =====
local RUN_SPEED = 150      -- Velocidad de carrera (muy rápida pero real)
local STOP_DISTANCE = 6    -- Distancia para detenerse al llegar

-- Zona destino: Workspace > Areas > KickReady
local TargetZone = Workspace:WaitForChild("Areas"):WaitForChild("KickReady")

-- Obtener posición de la zona
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

local targetPos = GetTargetPosition()
if not targetPos then
    warn("❌ No se encontró KickReady")
    return
end

-- Saltar obstáculos pequeños automáticamente
Humanoid.AutoJumpEnabled = true

print("🏃 Corriendo a KickReady a velocidad turbo...")

local connection
connection = RunService.Heartbeat:Connect(function()
    if not Root or not Root.Parent or not Humanoid or not Humanoid.Parent then
        connection:Disconnect()
        return
    end

    -- Mantener la velocidad alta (por si el juego intenta reiniciarla)
    Humanoid.WalkSpeed = RUN_SPEED

    local current = Root.Position
    local flat = Vector3.new(targetPos.X, current.Y, targetPos.Z)
    local distance = (flat - current).Magnitude

    -- Al llegar, se detiene y vuelve a velocidad normal
    if distance <= STOP_DISTANCE then
        connection:Disconnect()
        Humanoid.WalkSpeed = 16
        print("✅ ¡Llegaste a KickReady! Ahora te dará el brainrot 🧠")
        return
    end

    -- Movimiento REAL: el personaje corre por el suelo (sin teletransporte)
    Humanoid:MoveTo(flat)
end)
