-- JoseAngel_Blox | Auto-Bonds Farm | Dead Rails ONLY
-- PlaceId: 116495829188952 🔒 | No funciona en otro juego

-- === VERIFICACIÓN DE JUEGO ===
local TARGET_PLACEID = 116495829188952
if game.PlaceId ~= TARGET_PLACEID then
    warn("❌ Este script es EXCLUSIVO para Dead Rails")
    return
end

print("✅ Dead Rails detectado — Cargando JoseAngel_Blox Bonds...")

-- === SERVICIOS ===
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui") -- ✅ Corregido

-- === ESTADO ===
local AutoFarmEnabled = false
local Running = false

-- === CREAR GUI ===
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox_Bonds"
ScreenGui.Parent = PlayerGui -- ✅ En PlayerGui, NO CoreGui
ScreenGui.ResetOnSpawn = false -- ✅ No desaparece al morir

-- Frame principal — cuadrado, esquinas redondeadas
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
MainFrame.Position = UDim2.new(0.03, 0, 0.5, -95)
MainFrame.Size = UDim2.new(0, 230, 0, 190)
MainFrame.Active = true
MainFrame.Draggable = true

-- Esquinas redondeadas (compatible con Delta)
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 18)
Corner.Parent = MainFrame

-- Título en ROJO
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 10)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Font = Enum.Font.GothamBold
Title.Text = "JoseAngel_Blox Bonds"
Title.TextColor3 = Color3.fromRGB(255, 0, 0) -- 🔴 Rojo
Title.TextSize = 22

-- Botón interruptor
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = MainFrame
ToggleBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
ToggleBtn.Position = UDim2.new(0.1, 0, 0.35, 0)
ToggleBtn.Size = UDim2.new(0.8, 0, 0, 55)
ToggleBtn.Font = Enum.Font.Gotham
ToggleBtn.Text = "💰 Auto-Bonds Farm"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 16

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 12)
BtnCorner.Parent = ToggleBtn

-- Estado
local Status = Instance.new("TextLabel")
Status.Parent = MainFrame
Status.BackgroundTransparency = 1
Status.Position = UDim2.new(0, 0, 0.75, 0)
Status.Size = UDim2.new(1, 0, 0, 30)
Status.Font = Enum.Font.Gotham
Status.Text = "Estado: ❌ Desactivado"
Status.TextColor3 = Color3.fromRGB(170, 170, 170)
Status.TextSize = 14

-- === FUNCIONES ===
local function updateToggle()
    if AutoFarmEnabled then
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(28, 140, 65)
        Status.Text = "Estado: ✅ Farmear Bonos ACTIVO"
        Status.TextColor3 = Color3.fromRGB(80, 230, 120)
    else
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
        Status.Text = "Estado: ❌ Desactivado"
        Status.TextColor3 = Color3.fromRGB(170, 170, 170)
    end
end

-- Recolectar bonos
local function collectBonds()
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not root or not hum then return end

    for _, v in workspace:GetDescendants() do
        if v:IsA("BasePart") then
            local n = v.Name:lower()
            if n:find("bond") or n:find("bonds") then
                local dist = (v.Position - root.Position).Magnitude
                if dist < 25 then
                    task.spawn(function()
                        hum:MoveTo(v.Position)
                        task.wait(0.35 + math.random() * 0.45)
                        local prompt = v:FindFirstChildOfClass("ProximityPrompt")
                        if prompt then 
                            fireproximityprompt(prompt)
                        end
                    end)
                end
            end
        end
    end
end

-- === BOTÓN DE ACTIVACIÓN ===
ToggleBtn.MouseButton1Click:Connect(function()
    AutoFarmEnabled = not AutoFarmEnabled
    updateToggle()
    
    if AutoFarmEnabled and not Running then
        Running = true
        task.spawn(function()
            while AutoFarmEnabled do
                pcall(collectBonds)
                task.wait(0.45)
            end
            Running = false
        end)
    end
end)

print("✅ Script CARGADO — JoseAngel_Blox Bonds | Toca el botón para empezar")
