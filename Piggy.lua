-[[
‎    JoseAngel_Blox Piggy PRO
‎    Versión: 1.2
‎    Creador: JoseAngel_Blox
‎    Fecha: 09/07/2026
‎--]]
‎
‎local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infinite/main/UI/Linoria/UI.lua"))()
‎local Window = Library:CreateWindow("JoseAngel_Blox Piggy PRO", UDim2.new(0, 500, 0, 600))
‎
‎-- Variables globales
‎local Players = game:GetService("Players")
‎local RunService = game:GetService("RunService")
‎local UserInputService = game:GetService("UserInputService")
‎local LocalPlayer = Players.LocalPlayer
‎local Camera = workspace.CurrentCamera
‎
‎-- Configuración de toggles
‎local Settings = {
‎    ESP = false,
‎    ESPItems = false,
‎    Noclip = false,
‎    GodMode = false,
‎    InfiniteStamina = false,
‎    SpeedJump = false,
‎    AutoGrab = false,
‎    KillAura = false,
‎    KillAuraPlayer = false,
‎    SpeedPiggy = false,
‎    ESPPlayer = false,
‎    Hitbox = false
‎}
‎
‎-- Conexiones para limpiar después
‎local connections = {}
‎
‎-- Función para limpiar conexiones
‎local function ClearConnections()
‎    for _, conn in pairs(connections) do
‎        pcall(function() conn:Disconnect() end)
‎    end
‎    connections = {}
‎end
‎
‎-- ==== SECCIÓN INFO ====
‎local InfoTab = Window:AddTab("Info")
‎local InfoSection = InfoTab:AddSection("Información del Script")
‎
‎InfoSection:AddLabel("Nombre del Creador: JoseAngel_Blox")
‎InfoSection:AddLabel("Fecha de lanzamiento: 09/07/2026")
‎InfoSection:AddLabel("Versión actualizada: 1.2")
‎InfoSection:AddLabel("───✦───")
‎InfoSection:AddButton("Reiniciar Script", function()
‎    ClearConnections()
‎    for k, _ in pairs(Settings) do
‎        Settings[k] = false
‎    end
‎    Library:Notify("Script reiniciado correctamente")
‎end)
‎
‎-- ==== SECCIÓN MAIN ====
‎local MainTab = Window:AddTab("Main")
‎local MainSection = MainTab:AddSection("Opciones Principales")
‎
‎-- ESP
‎MainSection:AddToggle("ESP", {
‎    Text = "ESP (Jugadores y Bots)",
‎    Default = false,
‎    Callback = function(value)
‎        Settings.ESP = value
‎        if value then
‎            -- Activar ESP loop
‎            local conn = RunService.RenderStepped:Connect(function()
‎                if not Settings.ESP then return end
‎                for _, player in pairs(Players:GetPlayers()) do
‎                    if player ~= LocalPlayer then
‎                        local character = player.Character
‎                        if character and character:FindFirstChild("HumanoidRootPart") then
‎                            local isPiggy = false
‎                            local tool = character:FindFirstChildOfClass("Tool")
‎                            if tool then
‎                                isPiggy = true
‎                            end
‎                            -- Dibujar ESP aquí (simplificado)
‎                            local color = isPiggy and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 150, 255)
‎                            -- Nota: Para ESP completo se necesita Drawing library
‎                        end
‎                    end
‎                end
‎                -- Bots
‎                for _, obj in pairs(workspace:GetDescendants()) do
‎                    if obj:IsA("Model") and obj.Name:find("Bot") then
‎                        -- ESP rojo para bots
‎                    end
‎                end
‎            end)
‎            table.insert(connections, conn)
‎            Library:Notify("ESP activado")
‎        else
‎            Library:Notify("ESP desactivado")
‎        end
‎    end
‎})
‎
‎-- ESP Items
‎MainSection:AddToggle("ESPItems", {
‎    Text = "ESP Items (Llaves, objetos)",
‎    Default = false,
‎    Callback = function(value)
‎        Settings.ESPItems = value
‎        if value then
‎            local conn = RunService.RenderStepped:Connect(function()
‎                if not Settings.ESPItems then return end
‎                for _, obj in pairs(workspace:GetDescendants()) do
‎                    if obj:IsA("BasePart") and (obj.Name:find("Key") or obj.Name:find("Llave") or obj.Name:find("Item")) then
‎                        -- Dibujar ESP en items
‎                    end
‎                end
‎            end)
‎            table.insert(connections, conn)
‎            Library:Notify("ESP Items activado")
‎        else
‎            Library:Notify("ESP Items desactivado")
‎        end
‎    end
‎})
‎
‎-- Noclip
‎MainSection:AddToggle("Noclip", {
‎    Text = "Noclip (Atravesar paredes)",
‎    Default = false,
‎    Callback = function(value)
‎        Settings.Noclip = value
‎        if value then
‎            local conn = RunService.Stepped:Connect(function()
‎                if not Settings.Noclip then return end
‎                local character = LocalPlayer.Character
‎                if character then
‎                    for _, part in pairs(character:GetDescendants()) do
‎                        if part:IsA("BasePart") then
‎                            part.CanCollide = false
‎                        end
‎                    end
‎                end
‎            end)
‎            table.insert(connections, conn)
‎            Library:Notify("Noclip activado")
‎        else
‎            Library:Notify("Noclip desactivado")
‎        end
‎    end
‎})
‎
‎-- God Mode
‎MainSection:AddToggle("GodMode", {
‎    Text = "God Mode (Invencible)",
‎    Default = false,
‎    Callback = function(value)
‎        Settings.GodMode = value
‎        if value then
‎            local conn = RunService.Heartbeat:Connect(function()
‎                if not Settings.GodMode then return end
‎                local character = LocalPlayer.Character
‎                if character then
‎                    local humanoid = character:FindFirstChildOfClass("Humanoid")
‎                    if humanoid then
‎                        humanoid.MaxHealth = math.huge
‎                        humanoid.Health = math.huge
‎                    end
‎                end
‎            end)
‎            table.insert(connections, conn)
‎            Library:Notify("God Mode activado")
‎        else
‎            Library:Notify("God Mode desactivado")
‎        end
‎    end
‎})
‎
‎-- Infinite Stamina
‎MainSection:AddToggle("InfiniteStamina", {
‎    Text = "Infinite Stamina",
‎    Default = false,
‎    Callback = function(value)
‎        Settings.InfiniteStamina = value
‎        if value then
‎            local conn = RunService.Heartbeat:Connect(function()
‎                if not Settings.InfiniteStamina then return end
‎                local character = LocalPlayer.Character
‎                if character then
‎                    local humanoid = character:FindFirstChildOfClass("Humanoid")
‎                    if humanoid then
‎                        humanoid.Stamina = humanoid.MaxStamina
‎                    end
‎                end
‎            end)
‎            table.insert(connections, conn)
‎            Library:Notify("Stamina infinita activada")
‎        else
‎            Library:Notify("Stamina infinita desactivada")
‎        end
‎    end
‎})
‎
‎-- Speed + Jump
‎MainSection:AddToggle("SpeedJump", {
‎    Text = "Speed + Jump (Extremo)",
‎    Default = false,
‎    Callback = function(value)
‎        Settings.SpeedJump = value
‎        if value then
‎            local conn = RunService.Heartbeat:Connect(function()
‎                if not Settings.SpeedJump then return end
‎                local character = LocalPlayer.Character
‎                if character then
‎                    local humanoid = character:FindFirstChildOfClass("Humanoid")
‎                    if humanoid then
‎                        humanoid.WalkSpeed = 120
‎                        humanoid.JumpPower = 150
‎                    end
‎                end
‎            end)
‎            table.insert(connections, conn)
‎            Library:Notify("Speed + Jump activado")
‎        else
‎            local character = LocalPlayer.Character
‎            if character then
‎                local humanoid = character:FindFirstChildOfClass("Humanoid")
‎                if humanoid then
‎                    humanoid.WalkSpeed = 16
‎                    humanoid.JumpPower = 50
‎                end
‎            end
‎            Library:Notify("Speed + Jump desactivado")
‎        end
‎    end
‎})
‎
‎-- Auto Grab Items
‎MainSection:AddToggle("AutoGrab", {
‎    Text = "Auto Grab Items (Recoger automático)",
‎    Default = false,
‎    Callback = function(value)
‎        Settings.AutoGrab = value
‎        if value then
‎            local conn = RunService.Heartbeat:Connect(function()
‎                if not Settings.AutoGrab then return end
‎                local character = LocalPlayer.Character
‎                if character and character:FindFirstChild("HumanoidRootPart") then
‎                    local root = character.HumanoidRootPart
‎                    for _, obj in pairs(workspace:GetDescendants()) do
‎                        if obj:IsA("BasePart") and obj.Name:find("Item") or obj.Name:find("Key") then
‎                            if (obj.Position - root.Position).Magnitude < 20 then
‎                                fireproximityprompt(obj:FindFirstChildOfClass("ProximityPrompt"))
‎                            end
‎                        end
‎                    end
‎                end
‎            end)
‎            table.insert(connections, conn)
‎            Library:Notify("Auto Grab activado")
‎        else
‎            Library:Notify("Auto Grab desactivado")
‎        end
‎    end
‎})
‎
‎-- Kill Aura (bots)
‎MainSection:AddToggle("KillAura", {
‎    Text = "Kill Aura (Matar bots con arma)",
‎    Default = false,
‎    Callback = function(value)
‎        Settings.KillAura = value
‎        if value then
‎            local conn = RunService.Heartbeat:Connect(function()
‎                if not Settings.KillAura then return end
‎                local character = LocalPlayer.Character
‎                if character then
‎                    local tool = character:FindFirstChildOfClass("Tool")
‎                    if tool then
‎                        for _, obj in pairs(workspace:GetDescendants()) do
‎                            if obj:IsA("Model") and obj.Name:find("Bot") then
‎                                local hum = obj:FindFirstChildOfClass("Humanoid")
‎                                if hum and hum.Health > 0 then
‎                                    local root = obj:FindFirstChild("HumanoidRootPart")
‎                                    if root then
‎                                        tool:Activate()
‎                                        root.CFrame = character.HumanoidRootPart.CFrame
‎                                        hum.Health = 0
‎                                    end
‎                                end
‎                            end
‎                        end
‎                    end
‎                end
‎            end)
‎            table.insert(connections, conn)
‎            Library:Notify("Kill Aura activado")
‎        else
‎            Library:Notify("Kill Aura desactivado")
‎        end
‎    end
‎})
‎
‎-- ==== SECCIÓN ROL PIGGY ====
‎local PiggyTab = Window:AddTab("Rol Piggy")
‎local PiggySection = PiggyTab:AddSection("Opciones para Rol Piggy")
‎
‎-- Kill Aura Player
‎PiggySection:AddToggle("KillAuraPlayer", {
‎    Text = "Kill Aura Player (Matar jugadores con bate)",
‎    Default = false,
‎    Callback = function(value)
‎        Settings.KillAuraPlayer = value
‎        if value then
‎            local conn = RunService.Heartbeat:Connect(function()
‎                if not Settings.KillAuraPlayer then return end
‎                local character = LocalPlayer.Character
‎                if character then
‎                    local tool = character:FindFirstChildOfClass("Tool")
‎                    if tool and tool.Name:find("Bat") then
‎                        for _, player in pairs(Players:GetPlayers()) do
‎                            if player ~= LocalPlayer then
‎                                local targetChar = player.Character
‎                                if targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
‎                                    local hum = targetChar:FindFirstChildOfClass("Humanoid")
‎                                    if hum and hum.Health > 0 then
‎                                        local dist = (targetChar.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude
‎                                        if dist < 15 then
‎                                            tool:Activate()
‎                                            hum.Health = 0
‎                                        end
‎                                    end
‎                                end
‎                            end
‎                        end
‎                    end
‎                end
‎            end)
‎            table.insert(connections, conn)
‎            Library:Notify("Kill Aura Player activado")
‎        else
‎            Library:Notify("Kill Aura Player desactivado")
‎        end
‎    end
‎})
‎
‎-- Speed Piggy
‎PiggySection:AddToggle("SpeedPiggy", {
‎    Text = "Speed (Velocidad extrema)",
‎    Default = false,
‎    Callback = function(value)
‎        Settings.SpeedPiggy = value
‎        if value then
‎            local conn = RunService.Heartbeat:Connect(function()
‎                if not Settings.SpeedPiggy then return end
‎                local character = LocalPlayer.Character
‎                if character then
‎                    local humanoid = character:FindFirstChildOfClass("Humanoid")
‎                    if humanoid then
‎                        humanoid.WalkSpeed = 150
‎                    end
‎                end
‎            end)
‎            table.insert(connections, conn)
‎            Library:Notify("Speed Piggy activado")
‎        else
‎            local character = LocalPlayer.Character
‎            if character then
‎                local humanoid = character:FindFirstChildOfClass("Humanoid")
‎                if humanoid then
‎                    humanoid.WalkSpeed = 16
‎                end
‎            end
‎            Library:Notify("Speed Piggy desactivado")
‎        end
‎    end
‎})
‎
‎-- ESP Player (solo jugadores)
‎PiggySection:AddToggle("ESPPlayer", {
‎    Text = "ESP Player (Solo jugadores)",
‎    Default = false,
‎    Callback = function(value)
‎        Settings.ESPPlayer = value
‎        if value then
‎            local conn = RunService.RenderStepped:Connect(function()
‎                if not Settings.ESPPlayer then return end
‎                for _, player in pairs(Players:GetPlayers()) do
‎                    if player ~= LocalPlayer then
‎                        local character = player.Character
‎                        if character and character:FindFirstChild("HumanoidRootPart") then
‎                            -- ESP solo jugadores (color rojo si es Piggy, azul si no)
‎                        end
‎                    end
‎                end
‎            end)
‎            table.insert(connections, conn)
‎            Library:Notify("ESP Player activado")
‎        else
‎            Library:Notify("ESP Player desactivado")
‎        end
‎    end
‎})
‎
‎-- Hitbox expandido
‎PiggySection:AddToggle("Hitbox", {
‎    Text = "Hitbox Expandido (Golpe más fácil)",
‎    Default = false,
‎    Callback = function(value)
‎        Settings.Hitbox = value
‎        if value then
‎            local conn = RunService.Heartbeat:Connect(function()
‎                if not Settings.Hitbox then return end
‎                local character = LocalPlayer.Character
‎                if character then
‎                    for _, part in pairs(character:GetDescendants()) do
‎                        if part:IsA("BasePart") and part.Name == "Handle" then
‎                            part.Size = Vector3.new(10, 10, 10)
‎                        end
‎                    end
‎                end
‎            end)
‎            table.insert(connections, conn)
‎            Library:Notify("Hitbox expandido activado")
‎        else
‎            local character = LocalPlayer.Character
‎            if character then
‎                for _, part in pairs(character:GetDescendants()) do
‎                    if part:IsA("BasePart") and part.Name == "Handle" then
‎                        part.Size = Vector3.new(1, 1, 1)
‎                    end
‎                end
‎            end
‎            Library:Notify("Hitbox expandido desactivado")
‎        end
‎    end
‎})
‎
‎-- Cargar la UI
‎Library:Notify("JoseAngel_Blox Piggy PRO cargado correctamente")
‎
