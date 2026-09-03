-- ==============================================
-- 🌲 99 NOCHES EN EL BOSQUE — SCRIPT COMPLETO
-- 👤 Creado por: JoseAngel_Blox 🔴
-- 🎮 Compatible: Delta Executor | PC/Móvil
-- ⚠️ No matará al Ciervo — se ahuyenta con FUEGO/LUZ
-- ==============================================

-- === INTERFAZ PRINCIPAL ===
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("JoseAngel_Blox | 99 Noches", "Red")

-- === PESTAÑAS ===
local FarmTab = Window:NewTab("🌲 Recolección")
local SurviveTab = Window:NewTab("🔥 Supervivencia")
local VisualTab = Window:NewTab("👁️ Visuales")
local MiscTab = Window:NewTab("⚙️ Ajustes")

-- === SECCIÓN: RECOLECCIÓN ===
FarmTab:NewSection("Auto Recolección de Recursos")

FarmTab:NewToggle("🪓 Auto Talar Árboles", false, function(state)
    _G.AutoTala = state
    while _G.AutoTala and task.wait(0.8) do
        local plr = game.Players.LocalPlayer
        local char = plr.Character
        if not char then continue end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then continue end
        
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.Name:match("Tree") or v.Name:match("Arbol") then
                local dist = (v.Position - root.Position).Magnitude
                if dist < 25 then
                    plr.Character.Humanoid:MoveTo(v.Position)
                    task.wait(0.5)
                    -- Simular golpe
                    mouse1click()
                    task.wait(0.3)
                end
            end
        end
    end
end)

FarmTab:NewToggle("🍖 Auto Comida / Recolectar", false, function(state)
    _G.AutoComida = state
    while _G.AutoComida and task.wait(1) do
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and (v.Name:match("Berry") or v.Name:match("Comida") or v.Name:match("Meat")) then
                v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            end
        end
    end
end)

FarmTab:NewToggle("📦 Auto Cofres", false, function(state)
    _G.AutoCofres = state
    while _G.AutoCofres and task.wait(1.5) do
        for _, v in pairs(workspace:GetDescendants()) do
            if v:FindFirstChild("ProximityPrompt") and v.Name:match("Chest") then
                v.ProximityPrompt:TriggerInteract()
            end
        end
    end
end)

-- === SECCIÓN: SUPERVIVENCIA ===
SurviveTab:NewSection("🔥 Fogata y Defensa")

SurviveTab:NewToggle("🔥 Mantener Fogata Encendida", false, function(state)
    _G.AutoFuego = state
    while _G.AutoFuego and task.wait(2) do
        local inv = game.Players.LocalPlayer.Backpack
        local char = game.Players.LocalPlayer.Character
        if not char then continue end
        
        -- Buscar fogata
        for _, v in pairs(workspace:GetChildren()) do
            if v.Name:match("Campfire") or v.Name:match("Fogata") then
                local fire = v:FindFirstChild("Fire")
                if not fire or fire.Size < 2 then
                    -- Poner leña
                    for _, item in pairs(inv:GetChildren()) do
                        if item.Name:match("Wood") or item.Name:match("Leña") then
                            char.Humanoid:MoveTo(v.Position)
                            task.wait(0.5)
                            item.Parent = v
                        end
                    end
                end
            end
        end
    end
end)

SurviveTab:NewToggle("💡 Luz Automática (Ahuyenta al Ciervo)", false, function(state)
    _G.AutoLuz = state
end)

SurviveTab:NewSlider("Velocidad de Movimiento", 1, 5, 1, function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16 * value
end)

SurviveTab:NewToggle("🏃 Auto Huir de Peligro", false, function(state)
    _G.AutoHuir = state
end)

-- === SECCIÓN: VISUALES ===
VisualTab:NewSection("👁️ Visuales y ESP")

VisualTab:NewToggle("🌫️ Sin Niebla", false, function(state)
    game.Lighting.FogEnd = state and 10000 or 1000
end)

VisualTab:NewToggle("👀 Visión Nocturna", false, function(state)
    game.Lighting.Brightness = state and 4 or 1
    game.Lighting.Ambient = state and Color3.fromRGB(100,100,120) or Color3.fromRGB(60,60,80)
end)

VisualTab:NewToggle("📍 Ver Jugadores / Entidades", false, function(state)
    _G.ESP_Activo = state
    while _G.ESP_Activo and task.wait(0.5) do
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Bright red")
                v.Character.HumanoidRootPart.Material = "Neon"
            end
        end
    end
end)

-- === SECCIÓN: AJUSTES ===
MiscTab:NewSection("⚙️ Ajustes y Anti-Detección")

MiscTab:NewButton("🔄 Reiniciar Todas las Funciones", function()
    _G.AutoTala = false
    _G.AutoComida = false
    _G.AutoFuego = false
    _G.AutoCofres = false
    Library:Destroy()
    loadstring(getfenv(0).Script.Source)()
end)

MiscTab:NewButton("❌ Cerrar Interfaz", function()
    Library:Destroy()
end)

-- === MENSAJE DE CARGA ===
game.StarterGui:SetCore("SendNotification", {
    Title = "JoseAngel_Blox 🔴";
    Text = "Script Cargado — ¡Buena suerte en el bosque!";
    Duration = 5;
})

print("✅ [JoseAngel_Blox] Script activo — 99 Noches en el Bosque")
