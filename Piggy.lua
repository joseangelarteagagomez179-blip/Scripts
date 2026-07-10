-- Limpieza para evitar clones al ejecutar de nuevo
if game.CoreGui:FindFirstChild("JoseAngelPiggyPro") then
    game.CoreGui:FindFirstChild("JoseAngelPiggyPro"):Destroy()
end

-- 1. CONTENEDOR PRINCIPAL
local Pantalla = Instance.new("ScreenGui")
Pantalla.Name = "JoseAngelPiggyPro"
pcall(function() Pantalla.Parent = game:GetService("CoreGui") end)
if not Pantalla.Parent then
    Pantalla.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

-- 2. VENTANA PRINCIPAL (Esquinas Redondeadas y Rojo Bonito)
local Ventana = Instance.new("Frame")
Ventana.Name = "Ventana"
Ventana.Size = UDim2.new(0, 360, 0, 340)
Ventana.Position = UDim2.new(0.3, 0, 0.25, 0)
Ventana.BackgroundColor3 = Color3.fromRGB(150, 15, 20)
Ventana.Active = true
Ventana.Draggable = true
Ventana.Parent = Pantalla

local CornerVentana = Instance.new("UICorner")
CornerVentana.CornerRadius = UDim.new(0, 14)
CornerVentana.Parent = Ventana

-- 3. TÍTULO EN LETRAS ROJAS
local Titulo = Instance.new("TextLabel")
Titulo.Size = UDim2.new(1, 0, 0, 45)
Titulo.BackgroundColor3 = Color3.fromRGB(90, 8, 10)
Titulo.Text = "JoseAngel_Blox Piggy Pro"
Titulo.TextColor3 = Color3.fromRGB(255, 40, 40)
Titulo.TextSize = 18
Titulo.Font = Enum.Font.SourceSansBold
Titulo.Parent = Ventana

local CornerTitulo = Instance.new("UICorner")
CornerTitulo.CornerRadius = UDim.new(0, 14)
CornerTitulo.Parent = Titulo

-- 4. BARRA DE NAVEGACIÓN (Pestañas)
local BarraPestanas = Instance.new("Frame")
BarraPestanas.Size = UDim2.new(1, 0, 0, 35)
BarraPestanas.Position = UDim2.new(0, 0, 0, 45)
BarraPestanas.BackgroundColor3 = Color3.fromRGB(115, 10, 15)
BarraPestanas.BorderSizePixel = 0
BarraPestanas.Parent = Ventana

local BtnInfo = Instance.new("TextButton")
BtnInfo.Size = UDim2.new(0.33, 0, 1, 0)
BtnInfo.Position = UDim2.new(0, 0, 0, 0)
BtnInfo.BackgroundTransparency = 1
BtnInfo.Text = "Info ↓"
BtnInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnInfo.Font = Enum.Font.SourceSansBold
BtnInfo.TextSize = 14
BtnInfo.Parent = BarraPestanas

local BtnMain = Instance.new("TextButton")
BtnMain.Size = UDim2.new(0.33, 0, 1, 0)
BtnMain.Position = UDim2.new(0.33, 0, 0, 0)
BtnMain.BackgroundTransparency = 1
BtnMain.Text = "Main ↓"
BtnMain.TextColor3 = Color3.fromRGB(200, 200, 200)
BtnMain.Font = Enum.Font.SourceSansBold
BtnMain.TextSize = 14
BtnMain.Parent = BarraPestanas

local BtnRol = Instance.new("TextButton")
BtnRol.Size = UDim2.new(0.34, 0, 1, 0)
BtnRol.Position = UDim2.new(0.66, 0, 0, 0)
BtnRol.BackgroundTransparency = 1
BtnRol.Text = "Rol Piggy ↓"
BtnRol.TextColor3 = Color3.fromRGB(200, 200, 200)
BtnRol.Font = Enum.Font.SourceSansBold
BtnRol.TextSize = 14
BtnRol.Parent = BarraPestanas

-- 5. CONTENEDORES DE CADA PESTAÑA (ScrollingFrames para deslizar con el dedo)
local ContenedorInfo = Instance.new("Frame")
ContenedorInfo.Size = UDim2.new(1, -20, 1, -95)
ContenedorInfo.Position = UDim2.new(0, 10, 0, 85)
ContenedorInfo.BackgroundTransparency = 1
ContenedorInfo.Visible = true
ContenedorInfo.Parent = Ventana

local ContenedorMain = Instance.new("ScrollingFrame")
ContenedorMain.Size = UDim2.new(1, -10, 1, -95)
ContenedorMain.Position = UDim2.new(0, 5, 0, 85)
ContenedorMain.BackgroundTransparency = 1
ContenedorMain.CanvasSize = UDim2.new(0, 0, 0, 560) -- Altura extendida para los botones
ContenedorMain.ScrollBarThickness = 6
ContenedorMain.Visible = false
ContenedorMain.Parent = Ventana

local ContenedorRol = Instance.new("Frame")
ContenedorRol.Size = UDim2.new(1, -20, 1, -95)
ContenedorRol.Position = UDim2.new(0, 10, 0, 85)
ContenedorRol.BackgroundTransparency = 1
ContenedorRol.Visible = false
ContenedorRol.Parent = Ventana

-- Lógica para cambiar de pestañas
BtnInfo.MouseButton1Click:Connect(function()
    ContenedorInfo.Visible = true; ContenedorMain.Visible = false; ContenedorRol.Visible = false
    BtnInfo.TextColor3 = Color3.fromRGB(255,255,255); BtnMain.TextColor3 = Color3.fromRGB(200,200,200); BtnRol.TextColor3 = Color3.fromRGB(200,200,200)
end)
BtnMain.MouseButton1Click:Connect(function()
    ContenedorInfo.Visible = false; ContenedorMain.Visible = true; ContenedorRol.Visible = false
    BtnInfo.TextColor3 = Color3.fromRGB(200,200,200); BtnMain.TextColor3 = Color3.fromRGB(255,255,255); BtnRol.TextColor3 = Color3.fromRGB(200,200,200)
end)
BtnRol.MouseButton1Click:Connect(function()
    ContenedorInfo.Visible = false; ContenedorMain.Visible = false; ContenedorRol.Visible = true
    BtnInfo.TextColor3 = Color3.fromRGB(200,200,200); BtnMain.TextColor3 = Color3.fromRGB(200,200,200); BtnRol.TextColor3 = Color3.fromRGB(255,255,255)
end)

-- ==========================================
-- SECCIÓN 1: INFO
-- ==========================================
local function CrearTextoInfo(texto, yPos)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 30)
    lbl.Position = UDim2.new(0, 0, 0, yPos)
    lbl.BackgroundTransparency = 1
    lbl.Text = texto
    lbl.TextColor3 = Color3.fromRGB(255, 230, 230)
    lbl.TextSize = 16
    lbl.Font = Enum.Font.SourceSansBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = ContenedorInfo
end
CrearTextoInfo("• Nombre del Creador: JoseAngel_Blox", 20)
CrearTextoInfo("• Fecha de actualización: 09/07/2026", 60)
CrearTextoInfo("• Versión: 1.2", 100)

-- Función ayudante para crear botones en las listas
local function CrearBotonMenu(nombre, yPos, parent, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 38)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Text = nombre
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    btn.Parent = parent
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn

    local toggle = false
    btn.MouseButton1Click:Connect(function()
        toggle = not toggle
        if toggle then
            btn.BackgroundColor3 = Color3.fromRGB(30, 140, 40)
        else
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end
        callback(toggle, btn)
    end)
end

-- ==========================================
-- SECCIÓN 2: MAIN (SOBREVIVIENTTE)
-- ==========================================
local Plrs = game:GetService("Players")
local LP = Plrs.LocalPlayer

CrearBotonMenu("Auto Collect Items", 10, ContenedorMain, function(act)
    _G.AutoCollect = act
    while _G.AutoCollect and task.wait(0.5) do
        pcall(function()
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ClickDetector") and v.Parent and (v.Parent:IsA("BasePart") or v.Parent:FindFirstChildOfClass("BasePart")) then
                    local part = v.Parent:IsA("BasePart") and v.Parent or v.Parent:FindFirstChildOfClass("BasePart")
                    if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                        if (LP.Character.HumanoidRootPart.Position - part.Position).Magnitude < 25 then
                            fireclickdetector(v)
                        end
                    end
                end
            end
        end)
    end
end)

CrearBotonMenu("Auto Use Items 👟", 55, ContenedorMain, function(act)
    -- Simulación guiada: Interactúa con cerraduras de proximidad en Piggy
    _G.AutoUse = act
    while _G.AutoUse and task.wait(0.5) do
        pcall(function()
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ProximityPrompt") or v:IsA("TouchTransmitter") then
                    -- Simula uso de herramientas equipadas en la puerta correcta
                    if v:IsA("ProximityPrompt") then fireproximityprompt(v) end
                end
            end
        end)
    end
end)

CrearBotonMenu("God Mode (Inmunidad Bot)", 100, ContenedorMain, function(act)
    if act and LP.Character and LP.Character:FindFirstChild("Humanoid") then
        LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
    else
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then
            LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
        end
    end
end)

CrearBotonMenu("WalkSpeed Changer (Velocidad)", 145, ContenedorMain, function(act)
    if LP.Character and LP.Character:FindFirstChild("Humanoid") then
        LP.Character.Humanoid.WalkSpeed = act and 65 or 16
    end
end)

CrearBotonMenu("Infinite Jump", 190, ContenedorMain, function(act)
    _G.InfJump = act
end)
game:GetService("UserInputService").JumpRequest:Connect(function()
    if _G.InfJump and LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then
        LP.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

CrearBotonMenu("No Clip (Atravesar Paredes)", 235, ContenedorMain, function(act)
    _G.NoClip = act
    game:GetService("RunService").Stepped:Connect(function()
        if _G.NoClip and LP.Character then
            for _, part in pairs(LP.Character:GetChildren()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end)
end)

-- ESP de Jugadores y Piggy alternable
local esp_highlights = {}
CrearBotonMenu("ESP (Ver Asesino/Jugadores)", 280, ContenedorMain, function(act)
    if act then
        for _, p in pairs(Plrs:GetPlayers()) do
            if p ~= LP and p.Character then
                local h = Instance.new("Highlight")
                h.Parent = p.Character
                h.FillColor = p.Name:lower():find("piggy") and Color3.fromRGB(255,0,0) or Color3.fromRGB(0,255,0)
                esp_highlights[p] = h
            end
        end
    else
        for _, h in pairs(esp_highlights) do pcall(function() h:Destroy() end) end
        table.clear(esp_highlights)
    end
end)

local item_esp_boxes = {}
CrearBotonMenu("Item ESP (Resaltar Objetos)", 325, ContenedorMain, function(act)
    if act then
        for _, v in pairs(workspace:GetDescendants()) do
                
