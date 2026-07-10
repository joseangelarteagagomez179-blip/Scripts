-- ========================================================================
-- JOSEANGEL_BLOX PIGGY PRO
-- ========================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- Variables de Estado para los Toggles
local Toggles = {
    ItemESP = false,
    PiggyESP = false,
    AntiTraps = false,
    GodMode = false,
    Noclip = false,
    InfAmmo = false,
    AutoStun = false,
    AntiVoid = false,
    PlayerESP = false,
    KillAura = false,
    InfTraps = false,
    PiggySpeed = false
}

-- Eliminar versión anterior si existe
if CoreGui:FindFirstChild("JoseAngelPiggyPRO") then
    CoreGui.JoseAngelPiggyPRO:Destroy()
end

-- ==================== CREACIÓN DE LA INTERFAZ (UI) ====================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngelPiggyPRO"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 20, 0.5, -25)
ToggleButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
ToggleButton.Text = "PRO"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.FredokaOne
ToggleButton.TextSize = 20
ToggleButton.Parent = ScreenGui
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 10)

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 550, 0, 400)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 15)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "JoseAngel_Blox Piggy PRO"
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.Font = Enum.Font.FredokaOne
Title.TextSize = 24
Title.Parent = MainFrame

-- Draggable
local dragging, dragInput, dragStart, startPos
Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true; dragStart = input.Position; startPos = MainFrame.Position
    end
end)
Title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(0, 130, 1, -50)
TabContainer.Position = UDim2.new(0, 10, 0, 40)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame
local UIListLayoutTabs = Instance.new("UIListLayout")
UIListLayoutTabs.Padding = UDim.new(0, 10)
UIListLayoutTabs.Parent = TabContainer

local PageContainer = Instance.new("Frame")
PageContainer.Size = UDim2.new(1, -160, 1, -50)
PageContainer.Position = UDim2.new(0, 150, 0, 40)
PageContainer.BackgroundTransparency = 1
PageContainer.Parent = MainFrame

local pages = {}
local function createTab(name)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1, 0, 0, 35)
    TabButton.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
    TabButton.Text = name
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.Font = Enum.Font.SourceSansBold
    TabButton.TextSize = 18
    TabButton.Parent = TabContainer
    Instance.new("UICorner", TabButton).CornerRadius = UDim.new(0, 8)
    
    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.ScrollBarThickness = 5
    Page.Visible = false
    Page.Parent = PageContainer
    local UIListLayoutPage = Instance.new("UIListLayout")
    UIListLayoutPage.Padding = UDim.new(0, 8)
    UIListLayoutPage.Parent = Page
    
    pages[name] = Page
    TabButton.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        Page.Visible = true
    end)
    return Page
end

local function createToggle(page, text, flagName)
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(1, -10, 0, 35)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
    ToggleBtn.Text = " [OFF] " .. text
    ToggleBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    ToggleBtn.Font = Enum.Font.SourceSansBold
    ToggleBtn.TextSize = 14
    ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
    ToggleBtn.Parent = page
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 8)
    
    ToggleBtn.MouseButton1Click:Connect(function()
        Toggles[flagName] = not Toggles[flagName]
        if Toggles[flagName] then
            ToggleBtn.Text = " [ON] " .. text
            ToggleBtn.TextColor3 = Color3.fromRGB(0, 255, 0)
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
        else
            ToggleBtn.Text = " [OFF] " .. text
            ToggleBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
            -- Limpieza inmediata al apagar
            if flagName == "ItemESP" or flagName == "PiggyESP" or flagName == "PlayerESP" then
                for _, v in pairs(Workspace:GetDescendants()) do
                    if v:FindFirstChild(flagName.."High") then v[flagName.."High"]:Destroy() end
                end
            end
            if flagName == "GodMode" and LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                    if part:IsA("BasePart") then part.CanTouch = true end
                end
            end
        end
    end)
end

local function createButton(page, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -10, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.SourceSansBold
    Btn.TextSize = 14
    Btn.Parent = page
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
    Btn.MouseButton1Click:Connect(callback)
end

local function createLabel(page, text)
    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(1, 0, 0, 30)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = text
    Lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    Lbl.Font = Enum.Font.SourceSansBold
    Lbl.TextSize = 18
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.Parent = page
end

ToggleButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- ==================== 1) INFO ====================
local InfoPage = createTab("1) Info")
InfoPage.Visible = true 
createLabel(InfoPage, "Nombre del Creador: JoseAngel_Blox")
createLabel(InfoPage, "Fecha de actualización: 10/07/2026")
createLabel(InfoPage, "Versión: 1.2")
createLabel(InfoPage, "")
createLabel(InfoPage, "¡Script Corregido y Optimizado!")

-- ==================== 2) MAIN (SOBREVIVIENTES) ====================
local MainPage = createTab("2) Main")

createToggle(MainPage, "Item ESP", "ItemESP")
createToggle(MainPage, "Piggy ESP", "PiggyESP")
createToggle(MainPage, "Anti-Trampas", "AntiTraps")

createButton(MainPage, "Auto-Recoger (Item Teleport)", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("ClickDetector") then
                fireclickdetector(v)
            elseif v:IsA("Part") and (v.Name:match("Key") or v.Name:match("Card") or v.Name:match("Wrench")) then
                firetouchinterest(char.HumanoidRootPart, v, 0)
                firetouchinterest(char.HumanoidRootPart, v, 1)
            end
        end
    end
end)

createToggle(MainPage, "Invisibilidad / God Mode", "GodMode")
createToggle(MainPage, "Atravesar Puertas (Noclip)", "Noclip")
createToggle(MainPage, "Munición Infinita", "InfAmmo")
createToggle(MainPage, "Auto-Disparar (Auto-Stun)", "AutoStun")

createButton(MainPage, "Teletransporte a la Salida", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        for _, v in pairs(Workspace:GetDescendants()) do
            if v.Name:lower():match("exit") or v.Name:lower():match("door") then
                char.HumanoidRootPart.CFrame = v.CFrame * CFrame.new(0, 3, 0)
                break
            end
        end
    end
end)

createToggle(MainPage, "Anti-Void / Safe Mode", "AntiVoid")

-- ==================== 3) ROL PIGGY ====================
local PiggyPage = createTab("3) Rol Piggy")

createToggle(PiggyPage, "Player ESP", "PlayerESP")
createToggle(PiggyPage, "Auto-Matar (Kill Aura)", "KillAura")

createButton(PiggyPage, "Teletransporte a Jugadores", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                break 
            end
        end
    end
end)

createToggle(PiggyPage, "Trampas Infinitas", "InfTraps")
createToggle(PiggyPage, "Súper Velocidad de Piggy", "PiggySpeed")

-- ==================== BUCLES PRINCIPALES (MOTOR DEL SCRIPT) ====================

RunService.RenderStepped:Connect(function()
    -- Item ESP
    if Toggles.ItemESP then
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("Model") and (v.Name:match("Key") or v.Name:match("Card") or v.Name:match("Item") or v.Name:match("Wrench")) then
                if not v:FindFirstChild("ItemESPHigh") then
                    local h = Instance.new("Highlight")
                    h.Name = "ItemESPHigh"
                    h.FillColor = Color3.fromRGB(0, 255, 0)
                    h.Parent = v
                end
            end
        end
    end

    -- Piggy ESP
    if Toggles.PiggyESP then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character then
                if v.Character:FindFirstChild("Bat") or v.Character.Name == "Piggy" or v.Character:FindFirstChild("Weapon") then
                    if not v.Character:FindFirstChild("PiggyESPHigh") then
                        local h = Instance.new("Highlight")
                        h.Name = "PiggyESPHigh"
                        h.FillColor = Color3.fromRGB(255, 0, 0)
                        h.Parent = v.Character
                    end
                end
            end
        end
    end

    -- Player ESP
    if Toggles.PlayerESP then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character then
                if not v.Character:FindFirstChild("PlayerESPHigh") then
                    local h = Instance.new("Highlight")
                    h.Name = "PlayerESPHigh"
                    h.FillColor = Color3.fromRGB(0, 255, 255)
                    h.Parent = v.Character
                end
            end
        end
    end

    -- Súper Velocidad de Piggy
    if Toggles.PiggySpeed and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 45
    elseif not Toggles.PiggySpeed and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        if LocalPlayer.Character.Humanoid.WalkSpeed == 45 then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end

    -- Anti-Void
    if Toggles.AntiVoid and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        if LocalPlayer.Character.HumanoidRootPart.Position.Y < -50 then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 20, 0)
        end
    end
    
    -- God Mode (Deshabilita que Piggy pueda tocarte para matarte)
    if Toggles.GodMode and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanTouch = false
            end
        end
    end
end)

-- Bucle de Físicas (Noclip)
RunService.Stepped:Connect(function()
    if Toggles.Noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Bucle Lento (Para Acciones Pesadas como Trampas, KillAura y Stun)
task.spawn(function()
    while task.wait(0.5) do
        local char = LocalPlayer.Character
        
        -- Anti-Trampas
        if Toggles.AntiTraps then
            for _, v in pairs(Workspace:GetDescendants()) do
                if v.Name == "Trap" or v.Name == "IceTrap" or v.Name == "BearTrap" then
                    v:Destroy()
                end
            end
        end
        
        -- Auto-Matar (Kill Aura)
        if Toggles.KillAura and char and char:FindFirstChild("HumanoidRootPart") then
            for _, target in pairs(Players:GetPlayers()) do
                if target ~= LocalPlayer and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                    local distance = (char.HumanoidRootPart.Position - target.Character.HumanoidRootPart.Position).Magnitude
                    if distance < 15 then
                        local weapon = char:FindFirstChild("Weapon") or char:FindFirstChild("Bat") or char.HumanoidRootPart
                        firetouchinterest(weapon, target.Character.HumanoidRootPart, 0)
                        firetouchinterest(weapon, target.Character.HumanoidRootPart, 1)
                    end
                end
            end
        end
        
        -- Munición Infinita (Elimina el gasto de balas interceptando la herramienta)
        if Toggles.InfAmmo and char then
            local gun = char:FindFirstChildOfClass("Tool")
            if gun and gun:FindFirstChild("Ammo") then
                gun.Ammo.Value = 999
            end
        end
        
        -- Auto-Stun
        if Toggles.AutoStun and char and char:FindFirstChild("HumanoidRootPart") then
            local gun = char:FindFirstChildOfClass("Tool")
            if gun and (gun.Name:match("Gun") or gun.Name:match("Crossbow")) then
                -- Buscar a Piggy cerca
                for _, v in pairs(Players:GetPlayers()) do
                    if v ~= LocalPlayer and v.Character and (v.Character.Name == "Piggy" or v.Character:FindFirstChild("Bat")) then
                        if v.Character:FindFirstChild("HumanoidRootPart") then
                            local dist = (char.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
                            if dist < 30 then
                                gun:Activate()
                            end
                        end
                    end
                end
            end
        end
    end
end)
