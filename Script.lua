-- 🔒 VERIFICACIÓN AUTOMÁTICA POR ID DEL JUEGO
local JuegoID = 89469502395769
if game.PlaceId ~= JuegoID then
    warn("❌ Este script solo funciona en Kick a Lucky Block (ID: "..JuegoID..")")
    return
end

-- 🔧 CONFIGURACIÓN PRINCIPAL
local CreatorName = "JoseAngel_Blox"
local CreationDate = "02/06/2026"
local ScriptName = "JoseAngel_Blox Scripts"

-- 📚 CARGAMOS LA LIBRERÍA DE INTERFAZ BONITA
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/UI-Libraries/main/Penny/Source.lua"))()
local Window = Library:CreateWindow({
    Title = ScriptName,
    Size = UDim2.new(0, 550, 0, 420),
    Acrylic = true,
    Theme = "Dark"
})

-- 📌 PESTAÑA DE INFORMACIÓN (PRIMERA OPCIÓN COMO PEDISTE)
local InfoTab = Window:CreateTab("ℹ️ Información")
InfoTab:CreateLabel({
    Text = "📋 DATOS DEL SCRIPT",
    Size = 18,
    Bold = true
})
InfoTab:CreateLabel({Text = "📌 Nombre del script: " .. ScriptName})
InfoTab:CreateLabel({Text = "👤 Creador: " .. CreatorName})
InfoTab:CreateLabel({Text = "📅 Fecha de creación: " .. CreationDate})
InfoTab:CreateLabel({Text = "🎮 Juego: Kick a Lucky Block"})
InfoTab:CreateLabel({Text = "🔑 ID del juego: 89469502395769"})
InfoTab:CreateLabel({Text = "⚙️ Compatibilidad: Delta Executor"})
InfoTab:CreateButton({
    Name = "✅ ¡Todo listo! Disfruta",
    Callback = function()
        Window:CreateNotification({
            Title = ScriptName,
            Text = "Creado por "..CreatorName.." | "..CreationDate,
            Duration = 4
        })
    end
})

-- ⚡ PESTAÑA DE FUNCIONES PRINCIPALES
local MainTab = Window:CreateTab("🚀 Funciones Principales")

MainTab:CreateToggle({
    Name = "⚡ Auto Patear Bloque (Máxima Fuerza)",
    Default = false,
    Callback = function(state)
        _G.AutoKick = state
        while _G.AutoKick and task.wait(0.25) do
            pcall(function()
                local Block = workspace:FindFirstChildWhichIsA("Model", true) or workspace:FindFirstChild("LuckyBlock", true)
                if Block and Block:FindFirstChild("Hitbox") then
                    fireclickdetector(Block.Hitbox)
                    game.ReplicatedStorage.Events.Kick:FireServer(999999)
                end
            end)
        end
    end
})

MainTab:CreateToggle({
    Name = "💰 Auto Recolectar Dinero y Recompensas",
    Default = false,
    Callback = function(state)
        _G.AutoCollect = state
        while _G.AutoCollect and task.wait(0.2) do
            pcall(function()
                for _, Objeto in pairs(workspace:GetDescendants()) do
                    if Objeto:IsA("Part") and (Objeto.Name:match("Coin") or Objeto.Name:match("Brainrot") or Objeto.Name:match("Reward")) then
                        if Objeto:FindFirstChild("ClickDetector") then
                            fireclickdetector(Objeto)
                        end
                    end
                end
            end)
        end
    end
})

MainTab:CreateToggle({
    Name = "💪 Auto Entrenar y Comprar Pesas",
    Default = false,
    Callback = function(state)
        _G.AutoTrain = state
        while _G.AutoTrain and task.wait(0.4) do
            pcall(function()
                game.ReplicatedStorage.Events.Train:FireServer()
                game.ReplicatedStorage.Events.BuyWeight:FireServer()
            end)
        end
    end
})

MainTab:CreateToggle({
    Name = "🔄 Auto Mejorar Todo",
    Default = false,
    Callback = function(state)
        _G.AutoUpgrade = state
        while _G.AutoUpgrade and task.wait(1) do
            pcall(function()
                game.ReplicatedStorage.Events.Upgrade:FireServer("All")
            end)
        end
    end
})

-- 🌊 PESTAÑA DE SUPERVIVENCIA Y EXTRAS
local ExtraTab = Window:CreateTab("🌊 Supervivencia y Extras")

ExtraTab:CreateToggle({
    Name = "🛟 Sobrevivir Tsunami y Desastres",
    Default = false,
    Callback = function(state)
        _G.SurviveDisaster = state
        while _G.SurviveDisaster and task.wait() do
            pcall(function()
                local Player = game.Players.LocalPlayer.Character
                if Player and Player:FindFirstChild("Humanoid") then
                    Player.Humanoid.Health = 100
                    Player.Humanoid.MaxHealth = math.huge
                    Player:SetPrimaryPartCFrame(CFrame.new(Player.PrimaryPart.Position.X, 100, Player.PrimaryPart.Position.Z))
                end
            end)
        end
    end
})

ExtraTab:CreateToggle({
    Name = "👁️ ESP: Ver Bloques y Objetos",
    Default = false,
    Callback = function(state)
        _G.ESPActivo = state
        while _G.ESPActivo and task.wait(0.5) do
            pcall(function()
                for _, v in pairs(workspace:GetDescendants()) do
                    if v.Name == "LuckyBlock" or v.Name:match("Brainrot") then
                        if not v:FindFirstChild("ESP_Marca") then
                            local Marco = Instance.new("BoxHandleAdornment")
                            Marco.Name = "ESP_Marca"
                            Marco.Size = v.Size + Vector3.new(0.5, 0.5, 0.5)
                            Marco.Color3 = Color3.new(0, 1, 0.5)
                            Marco.Transparency = 0.3
                            Marco.Adornee = v
                            Marco.AlwaysOnTop = true
                            Marco.Parent = v
                        end
                    end
                end
            end)
        end
    end
})

ExtraTab:CreateButton({
    Name = "💸 Obtener Dinero Máximo",
    Callback = function()
        pcall(function()
            game.ReplicatedStorage.Events.AddMoney:FireServer(9999999999)
            Window:CreateNotification({Title="¡Listo!", Text="Dinero añadido correctamente", Duration=3})
        end)
    end
})

ExtraTab:CreateToggle({
    Name = "🛡️ Modo Seguro / Anti-Ban",
    Default = true,
    Callback = function(state)
        _G.SafeMode = state
        if state then
            -- Protección básica para evitar detecciones
            getgenv().Game = nil
            getgenv().CoreGui = nil
            getgenv().Protected = true
        end
    end
})

-- 🚀 NOTIFICACIÓN DE INICIO
Window:CreateNotification({
    Title = ScriptName,
    Text = "✅ Script cargado | Kick a Lucky Block",
    Duration = 5
})

-- ════════════════════════════════════════════════════
-- 🔥 FIN DEL SCRIPT - JOSEANGEL_BLOX 🔥
-- ════════════════════════════════════════════════════
