--[[
🍌 Jungle Collector v3 - Roba banana → TP a base
   Compatible con PC (tecla END) y Celular (botón táctil)
   Hecho para Delta Executor
--]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer

local running = false
local searchRadius = 60

-- ============================================================
-- 🖥️ Interfaz (botón para celular + indicador)
-- ============================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "JungleCollectorGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 50, 0, 50)
frame.Position = UDim2.new(0.5, -25, 0.85, 0)
frame.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
frame.BackgroundTransparency = 0.2
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(1, 0, 1, 0)
button.BackgroundTransparency = 1
button.Text = "🍌"
button.TextSize = 28
button.TextScaled = true
button.Parent = frame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0, 80, 0, 20)
statusLabel.Position = UDim2.new(0.5, -40, 1, 5)
statusLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
statusLabel.BackgroundTransparency = 0.3
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.Text = "OFF"
statusLabel.TextSize = 14
statusLabel.Font = Enum.Font.GothamBold
statusLabel.TextScaled = true
local corner2 = Instance.new("UICorner")
corner2.CornerRadius = UDim.new(0, 6)
corner2.Parent = statusLabel
statusLabel.Parent = frame

local function UpdateUI()
    if running then
        frame.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
        statusLabel.Text = "ON"
        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
    else
        frame.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
        statusLabel.Text = "OFF"
        statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end
UpdateUI()

-- ============================================================
-- 🔍 Encontrar base / plot del jugador
-- ============================================================
local function FindBase()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        local name = obj.Name:lower()
        if (name:find("plot") or name:find("base") or name:find("spawn")
            or name:find("safe") or name:find("home") or name:find("tycoon"))
            and obj:IsA("BasePart") then
            return obj
        end
    end

    local playerName = player.Name:lower()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        local name = obj.Name:lower()
        if name:find(playerName) and obj:IsA("BasePart") then
            return obj
        end
    end

    local spawn = Workspace:FindFirstChild("SpawnLocation")
    if spawn then return spawn end

    return nil
end

-- ============================================================
-- 🍌 Robar banana
-- ============================================================
local function GetCharacter()
    local char = player.Character
    if not char then char = player.CharacterAdded:Wait() end
    return char, char:WaitForChild("HumanoidRootPart")
end

local function FindAndGrabBanana()
    local char, hrp = GetCharacter()
    if not hrp then return false end

    for _, obj in ipairs(Workspace:GetDescendants()) do
        local name = obj.Name:lower()
        if not name:find("banana") then continue end
        if not obj:IsA("BasePart") then continue end

        local dist = (obj.Position - hrp.Position).Magnitude
        if dist > searchRadius then continue end

        -- Ir a la banana
        hrp.CFrame = CFrame.new(obj.Position)
        task.wait(0.15)

        -- Buscar ProximityPrompt en el objeto y sus hijos
        local function FindPrompt(container)
            if container:IsA("ProximityPrompt") then return container end
            for _, child in ipairs(container:GetChildren()) do
                local result = FindPrompt(child)
                if result then return result end
            end
            return nil
        end

        local prompt = FindPrompt(obj)
        if prompt then
            fireproximityprompt(prompt)
            print("[🍌] Banana robada!")
            return true
        else
            -- Fallback: simular tecla E
            local VirtualInput = game:GetService("VirtualInputManager")
            VirtualInput:SendKeyEvent(true, Enum.KeyCode.E, false, game)
            task.wait(0.05)
            VirtualInput:SendKeyEvent(false, Enum.KeyCode.E, false, game)
            print("[🍌] E presionada")
            return true
        end
    end
    return false
end

-- ============================================================
-- 🏠 TP a la base
-- ============================================================
local function TeleportToBase()
    task.wait(0.3)
    local char, hrp = GetCharacter()
    if not hrp then return end

    local base = FindBase()
    if base then
        hrp.CFrame = CFrame.new(base.Position + Vector3.new(0, 5, 0))
        print("[🏠] TP a la base!")
    else
        print("[⚠️] No encontré la base, TP a spawn...")
        hrp.CFrame = CFrame.new(0, 10, 0)
    end
end

-- ============================================================
-- 🔄 Loop
-- ============================================================
local function Loop()
    while running do
        local found = FindAndGrabBanana()
        if found then
            task.wait(0.2)
            TeleportToBase()
            task.wait(0.5)
        end
        task.wait(0.3)
    end
end

-- ============================================================
-- 🎮 Toggle: Botón táctil + tecla END
-- ============================================================
local function Toggle()
    running = not running
    UpdateUI()
    if running then
        print("🍌 Jungle Collector: ON")
        coroutine.wrap(Loop)()
    else
        print("🍌 Jungle Collector: OFF")
    end
end

-- Botón táctil (funciona en celular y PC)
button.MouseButton1Click:Connect(Toggle)
button.TouchTap:Connect(Toggle)

-- Tecla END solo en PC
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.End then
        Toggle()
    end
end)

-- ============================================================
-- 🚀 Inicio
-- ============================================================
print("🍌 Jungle Collector v3 — Listo!")
print("   📱 Celular: Toca el botón 🍌 en pantalla")
print("   💻 PC: Presiona END")
print("   😈 Roba banana → 🚀 TP a tu base")

-- Auto-start
running = true
UpdateUI()
coroutine.wrap(Loop)()
