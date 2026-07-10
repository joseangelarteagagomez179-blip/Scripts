--[[
🟥 JoseAngel_Blox Piggy PRO 🟥
Interfaz: Cuadrada, esquinas redondeadas, fondo rojo
Deslizable | Botón Mostrar/Ocultar
Versión: 1.2 | Fecha: 10/07/2026
Compatible con Delta Executor
]]

-- Servicios
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- Crear GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_PiggyPRO"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Marco Principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 340, 0, 460)
MainFrame.Position = UDim2.new(0.05, 0, 0.12, 0)
MainFrame.BackgroundColor3 = Color3.new(0.78, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- ✅ Deslizable
MainFrame.Parent = ScreenGui

-- Esquinas Redondeadas
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 14)
UICorner.Parent = MainFrame

-- Botón Mostrar/Ocultar
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 95, 0, 30)
ToggleBtn.Position = UDim2.new(1, -100, 0, 10)
ToggleBtn.BackgroundColor3 = Color3.new(1, 1, 1)
ToggleBtn.TextColor3 = Color3.new(0, 0, 0)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Text = "ACTIVAR / OCULTAR"
ToggleBtn.TextSize = 12
ToggleBtn.Parent = MainFrame
UICorner:Clone().Parent = ToggleBtn

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 0, 35)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1, 0, 0) -- Rojo brillante
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 22
Title.Text = "JoseAngel_Blox Piggy PRO"
Title.Parent = MainFrame

-- ------------------------------
-- 1️⃣ PESTAÑA: INFO
-- ------------------------------
local InfoFrame = Instance.new("Frame")
InfoFrame.Size = UDim2.new(1, -25, 0, 90)
InfoFrame.Position = UDim2.new(0, 12, 0, 55)
InfoFrame.BackgroundColor3 = Color3.new(0.85, 0, 0)
InfoFrame.BorderSizePixel = 0
InfoFrame.Parent = MainFrame
UICorner:Clone().Parent = InfoFrame

local InfoText = Instance.new("TextLabel")
InfoText.Size = UDim2.new(1, -15, 1, -15)
InfoText.Position = UDim2.new(0, 7, 0, 7)
InfoText.BackgroundTransparency = 1
InfoText.TextColor3 = Color3.new(1, 1, 1)
InfoText.Font = Enum.Font.Gotham
InfoText.TextSize = 14
InfoText.TextWrapped = true
InfoText.Text = [[📋 INFO ↓
👤 Creador: JoseAngel_Blox
📅 Actualización: 10/07/2026
🔖 Versión: 1.2
⚙️ Compatible con Delta v2.727+]]
InfoText.Parent = InfoFrame

-- ------------------------------
-- 2️⃣ PESTAÑA: MAIN
-- ------------------------------
local MainFrameTab = Instance.new("Frame")
MainFrameTab.Size = UDim2.new(1, -25, 0, 150)
MainFrameTab.Position = UDim2.new(0, 12, 0, 155)
MainFrameTab.BackgroundColor3 = Color3.new(0.85, 0, 0)
MainFrameTab.BorderSizePixel = 0
MainFrameTab.Parent = MainFrame
UICorner:Clone().Parent = MainFrameTab

local MainText = Instance.new("TextLabel")
MainText.Size = UDim2.new(1, -15, 1, -15)
MainText.Position = UDim2.new(0, 7, 0, 7)
MainText.BackgroundTransparency = 1
MainText.TextColor3 = Color3.new(1, 1, 1)
MainText.Font = Enum.Font.Gotham
MainText.TextSize = 12
MainText.TextWrapped = true
MainText.Text = [[⚙️ MAIN ↓
• Item ESP
• Piggy ESP
• Anti-Trampas
• Auto-Recoger
• Modo Dios / Invisible
• Noclip (Atravesar)
• Munición Infinita
• Auto-Disparo
• Teletransporte Salida
• Anti-Void]]
MainText.Parent = MainFrameTab

-- ------------------------------
-- 3️⃣ PESTAÑA: ROL PIGGY
-- ------------------------------
local PiggyFrame = Instance.new("Frame")
PiggyFrame.Size = UDim2.new(1, -25, 0, 110)
PiggyFrame.Position = UDim2.new(0, 12, 0, 315)
PiggyFrame.BackgroundColor3 = Color3.new(0.85, 0, 0)
PiggyFrame.BorderSizePixel = 0
PiggyFrame.Parent = MainFrame
UICorner:Clone().Parent = PiggyFrame

local PiggyText = Instance.new("TextLabel")
PiggyText.Size = UDim2.new(1, -15, 1, -15)
PiggyText.Position = UDim2.new(0, 7, 0, 7)
PiggyText.BackgroundTransparency = 1
PiggyText.TextColor3 = Color3.new(1, 1, 1)
PiggyText.Font = Enum.Font.Gotham
PiggyText.TextSize = 12
PiggyText.TextWrapped = true
PiggyText.Text = [[🐷 ROL PIGGY ↓
• Ver Sobrevivientes (ESP)
• Auto-Matar
• Teletransportar a Jugadores
• Trampas Ilimitadas
• Súper Velocidad]]
PiggyText.Parent = PiggyFrame

-- ✅ Función Mostrar/Ocultar
local Mostrar = true
ToggleBtn.MouseButton1Click:Connect(function()
    Mostrar = not Mostrar
    MainFrame.Visible = Mostrar
end)
