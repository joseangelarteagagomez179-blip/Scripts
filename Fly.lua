-- =============================================
-- JoseAngel_Blox Fly
-- Script de vuelo con noclip para Roblox (Celular + PC)
-- Creador: JoséAngel_Blox
-- Fecha de lanzamiento: 06/07/2026
-- Versión: 1.2
-- =============================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")
local torso = character:WaitForChild("Torso") or character:WaitForChild("UpperTorso")

local isFlying = false
local isNoclipping = false
local flySpeed = 50

-- Crear el paraguas (esquema cuadrado con esquinas redondeadas)
local flyParachute = Instance.new("Parachute")
flyParachute.Name = "JoseAngel_Blox_Fly_Parachute"
flyParachute.Parent = character

local parachutePart = Instance.new("Part")
parachutePart.Name = "Parachute"
parachutePart.Size = Vector3.new(18, 1, 18) -- forma cuadrada
parachutePart.Shape = Enum.PartType.Block
parachutePart.Transparency = 1 -- invisible para que no se vea el paraguas
parachutePart.Parent = flyParachute

local mesh = Instance.new("SpecialMesh")
mesh.MeshType = Enum.MeshType.FileMesh
mesh.MeshId = "rbxassetid://16783298" -- ID de un modelo cuadrado con esquinas redondeadas
mesh.Scale = Vector3.new(1.8, 0.6, 1.8) -- tamaño ajustable (puedes cambiarlo)
mesh.Parent = parachutePart

-- Función para activar/deactivar el Fly
local function toggleFly()
    isFlying = not isFlying
    if isFlying then
        humanoid.PlatformStand = true
        print("¡Fly ACTIVADO! (Velocidad: " .. flySpeed .. ")")
    else
        humanoid.PlatformStand = false
        print("Fly DESACTIVADO")
    end
end

-- Función para activar/desactivar Noclip
local function toggleNoclip()
    isNoclipping = not isNoclipping
    if isNoclipping then
        print("Noclip ACTIVADO")
    else
        print("Noclip DESACTIVADO")
    end
end

-- Interruptores (botones) para celular y PC
local keybinds = {
    ToggleFly = Enum.KeyCode.E,      -- Activar/Desactivar Fly (E)
    ToggleNoclip = Enum.KeyCode.Q,   -- Activar/Desactivar Noclip (Q)
    IncreaseSpeed = Enum.KeyCode.F,  -- Aumentar velocidad (F)
    DecreaseSpeed = Enum.KeyCode.G   -- Disminuir velocidad (G)
}

-- Función de Fly (solo cuando está activado)
local function flyMovement()
    if not isFlying then return end
    
    local direction = Vector3.new()
    local cam = workspace.CurrentCamera
    
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then direction = direction + cam.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then direction = direction - cam.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then direction = direction - cam.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then direction = direction + cam.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direction = direction + Vector3.new(0, 1, 0) end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then direction = direction - Vector3.new(0, 1, 0) end
    
    if direction.Magnitude > 0 then
        direction = direction.Unit
        rootPart.Velocity = direction * flySpeed
        torso.Velocity = direction * flySpeed -- sincroniza torso también
    end
end

-- Función Noclip (ignora colisiones)
local function updateNoclip()
    if not isNoclipping then return end
    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end

-- Loop principal
RunService.Heartbeat:Connect(function()
    flyMovement()
    updateNoclip()
end)

-- Conexión de eventos de teclado (funciona en celular y PC)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == keybinds.ToggleFly then
        toggleFly()
    elseif input.KeyCode == keybinds.ToggleNoclip then
        toggleNoclip()
    elseif input.KeyCode == keybinds.IncreaseSpeed then
        flySpeed = math.min(flySpeed + 10, 500)
        print("Velocidad de Fly aumentada a: " .. flySpeed)
    elseif input.KeyCode == keybinds.DecreaseSpeed then
        flySpeed = math.max(flySpeed - 10, 10)
        print("Velocidad de Fly disminuida a: " .. flySpeed)
    end
end)

-- Mensaje inicial
print("JoseAngel_Blox Fly cargado correctamente.")
print("Usa E para Fly, Q para Noclip, F/G para velocidad.")
print("¡Disfruta del vuelo!")

-- =============================================
-- FIN DEL SCRIPT
-- =============================================
