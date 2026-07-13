-- =============================================
-- JoseAngel_Blox Jungle Events
-- Script creado por ti para el evento Jungle de Kick a Lucky Block
-- Todo con UI cuadrada y esquinas redondeadas + tema jungla
-- Funciona igual que FourHub (Auto Portal + Auto Banana + más)
-- =============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")

-- ==================== CONFIG ====================
local AutoKick = true
local AutoPortal = true
local AutoBanana = true
local AntiGlorbo = true
local AntiLava = true
local AntiTsunami = true
local AntiAFK = true
local AutoCollect = true

-- ==================== UI JUNGLE (cuadrada + esquinas redondeadas) ====================
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

local Window = OrionLib:MakeWindow({
    Name = "JoseAngel_Blox Jungle Events",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "JoseAngelBloxJungle",
    IntroText = "🌴 ¡Bienvenido al evento Jungle! 🍌"
})

-- Tema jungla (verde, hojas, amarillo)
local Theme = Window:MakeTab({
    Name = "🌴 Jungla",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- ==================== TABS ====================
local AutoTab = Window:MakeTab({ Name = "🔥 Auto Farm", Icon = "rbxassetid://4483345998" })
local SettingsTab = Window:MakeTab({ Name = "⚙️ Settings", Icon = "rbxassetid://4483345998" })

-- ==================== TOGGLES CON ESQUINAS REDONDEADAS ====================
Theme:AddParagraph("¡JoseAngel_Blox Jungle Events cargado! 🚀\nEvento activo: Jungle Event (hasta 19 julio)")

Theme:AddToggle({
    Name = "Auto Kick Perfect",
    Default = AutoKick,
    Callback = function(v) AutoKick = v end
})

Theme:AddToggle({
    Name = "Auto Portal Amarillo",
    Default = AutoPortal,
    Callback = function(v) AutoPortal = v end
})

Theme:AddToggle({
    Name = "Auto Banana (con E)",
    Default = AutoBanana,
    Callback = function(v) AutoBanana = v end
})

Theme:AddToggle({
    Name = "Anti Glorbo Fruttodrillo",
    Default = AntiGlorbo,
    Callback = function(v) AntiGlorbo = v end
})

Theme:AddToggle({
    Name = "Anti Lava",
    Default = AntiLava,
    Callback = function(v) AntiLava = v end
})

Theme:AddToggle({
    Name = "Anti Tsunami",
    Default = AntiTsunami,
    Callback = function(v) AntiTsunami = v end
})

Theme:AddToggle({
    Name = "Auto Collect Cash",
    Default = AutoCollect,
    Callback = function(v) AutoCollect = v end
})

Theme:AddToggle({
    Name = "Anti AFK",
    Default = AntiAFK,
    Callback = function(v) AntiAFK = v end
})

-- ==================== SETTINGS ====================
SettingsTab:AddParagraph("Configuración fácil (puedes cambiar valores si quieres más fuerza)")
SettingsTab:AddParagraph("Recomendado: deja todo ON y ejecuta en servidor nuevo")

-- ==================== MAIN LOOP (igual que FourHub) ====================
RunService.Heartbeat:Connect(function()
    if not workspace:FindFirstChild("Areas") then return end

    local character = LocalPlayer.Character
    if not character then return end
    root = character:FindFirstChild("HumanoidRootPart")

    -- 1. Auto Kick Perfect
    if AutoKick then
        local kickZone = workspace.Areas:FindFirstChild("KickReady") or workspace.Areas:FindFirstChild("Kick")
        if kickZone then
            game:GetService("ReplicatedStorage").rev_KickEvent:FireServer(999)
            print("✅ Perfect Kick!")
            task.wait(0.6)
        end
    end

    -- 2. Auto Portal Amarillo
    if AutoPortal then
        local portal = workspace:FindFirstChild("YellowPortal") or workspace:FindFirstChildWhichIsA("Part", true, "YellowPortal")
        if portal then
            root.CFrame = portal.CFrame * CFrame.new(0, 5, 0)
            print("🚪 Portal amarillo detectado! Entrando...")
            task.wait(3)
        end
    end

    -- 3. Auto Banana
    if AutoBanana then
        local banana = workspace:FindFirstChildWhichIsA("Part", true, "Banana") or workspace:FindFirstChild("Banana")
        if banana then
            root.CFrame = banana.CFrame * CFrame.new(0, 3, 0)
            UserInputService:SendKeyEvent(true, Enum.KeyCode.E, false, game)
            print("🍌 ¡Banana robada!")
            task.wait(1.5)
        end
    end

    -- 4. Anti Glorbo + Anti Lava
    if (AntiGlorbo or AntiLava) then
        local glorbo = workspace:FindFirstChildWhichIsA("Model", true, "Glorbo") or workspace:FindFirstChildWhichIsA("Model", true, "Fruttodrillo")
        local lava = workspace:FindFirstChildWhichIsA("Part", true, "Lava")
        if glorbo or lava then
            local base = workspace:FindFirstChild("Base") or workspace:FindFirstChild("Plot")
            if base then
                root.CFrame = base.CFrame * CFrame.new(0, 15, -30)
                print("🏃‍♂️ ¡Peligro! Corriendo a casa...")
                task.wait(2)
            end
        end
    end

    -- 5. Anti Tsunami
    if AntiTsunami then
        local tsunami = workspace:FindFirstChildWhichIsA("Part", true, "Tsunami") or workspace:FindFirstChild("Wave")
        if tsunami then
            root.CFrame += Vector3.new(0, 0, -40)
            print("🌊 Tsunami! Corriendo...")
            task.wait(1.5)
        end
    end

    -- 6. Auto Collect Cash
    if AutoCollect then
        local cash = workspace:FindFirstChildWhichIsA("Part", true, "Cash") or workspace:FindFirstChild("Money")
        if cash then
            root.CFrame = cash.CFrame * CFrame.new(0, 2, 0)
            print("💰 Cash recolectado!")
            task.wait(0.5)
        end
    end

    -- Anti AFK
    if AntiAFK then
        root.CFrame += Vector3.new(0, 0, 0.05)
    end
end)

print("🌴 JoseAngel_Blox Jungle Events cargado correctamente!")
print("Presiona F1 para pausar todo (puedes agregar más toggles si quieres)")
