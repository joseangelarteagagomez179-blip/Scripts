-- JoseAngel_Blox | Auto-Bonds Farm | Dead Rails ONLY
-- PlaceId: 116495829188952 | No funciona en otro juego 🔒

local TARGET_PLACEID = 116495829188952
if game.PlaceId ~= TARGET_PLACEID then
    warn("❌ Este script es solo para Dead Rails")
    return
end

-- Servicios
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Gui = game:GetService("CoreGui")

-- Estado
local AutoFarmEnabled = false
local Running = false

-- Crear GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ToggleBtn = Instance.new("TextButton")
local Status = Instance.new("TextLabel")

ScreenGui.Parent = Gui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Ventana cuadrada con esquinas redondeadas
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.02, 0, 0.5, -90)
MainFrame.Size = UDim2.new(0, 220, 0, 180)
MainFrame.CornerRadius = UDim.new(0, 16) -- Esquinas redondeadas
MainFrame.Active = true
MainFrame.Draggable = true

-- Título en ROJO
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Font = Enum.Font.GothamBold
Title.Text = "JoseAngel_Blox Bonds"
Title.TextColor3 = Color3.fromRGB(255, 0, 0) -- Rojo
Title.TextScaled = true
Title.TextWrapped = true

-- Botón interruptor
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Parent = MainFrame
ToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ToggleBtn.Position = UDim2.new(0.1, 0, 0.35, 0)
ToggleBtn.Size = UDim2.new(0.8, 0, 0, 55)
ToggleBtn.CornerRadius = UDim.new(0, 12)
ToggleBtn.Font = Enum.Font.Gotham
ToggleBtn.Text = "💰 Auto-Bonds Farm"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextScaled = true

-- Estado
Status.Name = "Status"
Status.Parent = MainFrame
Status.BackgroundTransparency = 1
Status.Position = UDim2.new(0, 0, 0.72, 0)
Status.Size = UDim2.new(1, 0, 0, 35)
Status.Font = Enum.Font.Gotham
Status.Text = "Estado: ❌ Desactivado"
Status.TextColor3 = Color3.fromRGB(180, 180, 180)
Status.TextSize = 14

-- Actualizar botón
local function updateToggle()
    if AutoFarmEnabled then
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 136, 60)
        Status.Text = "Estado: ✅ Activado — Farmear Bonos"
        Status.TextColor3 = Color3.fromRGB(80, 220, 120)
    else
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        Status.Text = "Estado: ❌ Desactivado"
        Status.TextColor3 = Color3.fromRGB(180, 180, 180)
    end
end

-- Lógica de recolección de bonos
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
                if dist < 20 then
                    task.spawn(function()
                        hum:MoveTo(v.Position)
                        task.wait(0.3 + math.random() * 0.4)
                        local prompt = v:FindFirstChildOfClass("ProximityPrompt")
                        if prompt then fireproximityprompt(prompt) end
                    end)
                end
            end
        end
    end
end

-- Bucle principal
ToggleBtn.MouseButton1Click:Connect(function()
    AutoFarmEnabled = not AutoFarmEnabled
    updateToggle()
    if AutoFarmEnabled and not Running then
        Running = true
        task.spawn(function()
            while AutoFarmEnabled do
                pcall(collectBonds)
                task.wait(0.5)
            end
            Running = false
        end)
    end
end)

print("✅ JoseAngel_Blox Bonds cargado | Solo Dead Rails")
