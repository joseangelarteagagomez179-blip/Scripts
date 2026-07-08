-- ==========================================================
-- Nombre del Creador: JoseAngel_Blox
-- Fecha de Lanzamiento: 09/07/2026
-- Versión: 1.2
-- Juego: Piggy
-- ==========================================================
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
-- ==========================================================
-- INTERFAZ DE USUARIO (GUI)
-- ==========================================================
local PiggyHub = Instance.new("ScreenGui")
PiggyHub.Name = "JoseAngel_Blox_Piggy_PRO"
-- Protegemos la GUI colocándola en CoreGui si el ejecutor lo permite
local success, err = pcall(function() PiggyHub.Parent = CoreGui end)
if not success then PiggyHub.Parent = LocalPlayer:WaitForChild("PlayerGui") end
-- Marco Principal (Bajito y ancho)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = PiggyHub
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30) -- Tema oscuro moderno
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -125)
MainFrame.Size = UDim2.new(0, 450, 0, 250)
MainFrame.Active = true
MainFrame.Draggable = true
-- Bordes redondeados para el marco principal
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame
-- Barra de Título
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "  JoseAngel_Blox Piggy PRO"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 15)
TitleCorner.Parent = Title
-- Parche para que el borde inferior del título no sea redondeado
local TitleBlock = Instance.new("Frame")
TitleBlock.Size = UDim2.new(1, 0, 0, 10)
TitleBlock.Position = UDim2.new(0, 0, 1, -10)
TitleBlock.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
TitleBlock.BorderSizePixel = 0
TitleBlock.Parent = Title
-- Contenedores de las Pestañas (Tabs)
local InfoTab = Instance.new("Frame")
InfoTab.Name = "InfoTab"
InfoTab.Parent = MainFrame
InfoTab.BackgroundTransparency = 1
InfoTab.Position = UDim2.new(0, 0, 0, 40)
InfoTab.Size = UDim2.new(1, 0, 1, -40)
InfoTab.Visible = true
local MainTab = Instance.new("ScrollingFrame")
MainTab.Name = "MainTab"
MainTab.Parent = MainFrame
MainTab.BackgroundTransparency = 1
MainTab.Position = UDim2.new(0, 0, 0, 40)
MainTab.Size = UDim2.new(1, 0, 1, -40)
MainTab.ScrollBarThickness = 4
MainTab.Visible = false
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = MainTab
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
local UIPadding = Instance.new("UIPadding")
UIPadding.Parent = MainTab
UIPadding.PaddingTop = UDim.new(0, 10)
UIPadding.PaddingBottom = UDim.new(0, 10)
-- Sistema de Flechas para navegar
local TabLabel = Instance.new("TextLabel")
TabLabel.Parent = Title
TabLabel.BackgroundTransparency = 1
TabLabel.Position = UDim2.new(1, -120, 0, 0)
TabLabel.Size = UDim2.new(0, 60, 1, 0)
TabLabel.Font = Enum.Font.Gotham
TabLabel.Text = "Info"
TabLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
TabLabel.TextSize = 14
local LeftArrow = Instance.new("TextButton")
LeftArrow.Parent = Title
LeftArrow.BackgroundTransparency = 1
LeftArrow.Position = UDim2.new(1, -150, 0, 0)
LeftArrow.Size = UDim2.new(0, 30, 1, 0)
LeftArrow.Font = Enum.Font.GothamBold
LeftArrow.Text = "<"
LeftArrow.TextColor3 = Color3.fromRGB(255, 255, 255)
LeftArrow.TextSize = 20
local RightArrow = Instance.new("TextButton")
RightArrow.Parent = Title
RightArrow.BackgroundTransparency = 1
RightArrow.Position = UDim2.new(1, -60, 0, 0)
RightArrow.Size = UDim2.new(0, 30, 1, 0)
RightArrow.Font = Enum.Font.GothamBold
RightArrow.Text = ">"
RightArrow.TextColor3 = Color3.fromRGB(255, 255, 255)
RightArrow.TextSize = 20
-- Lógica de las Flechas
local currentTab = 1
local function updateTabs()
if currentTab == 1 then
InfoTab.Visible = true
MainTab.Visible = false
TabLabel.Text = "Info"
else
InfoTab.Visible = false
MainTab.Visible = true
TabLabel.Text = "Main"
end
end
LeftArrow.MouseButton1Click:Connect(function() currentTab = 1 updateTabs() end)
RightArrow.MouseButton1Click:Connect(function() currentTab = 2 updateTabs() end)
-- Contenido de la Pestaña "Info"
local InfoText = Instance.new("TextLabel")
InfoText.Parent = InfoTab
InfoText.BackgroundTransparency = 1
InfoText.Size = UDim2.new(1, 0, 1, 0)
InfoText.Font = Enum.Font.Gotham
InfoText.TextColor3 = Color3.fromRGB(220, 220, 220)
InfoText.TextSize = 16
InfoText.Text = "Nombre del Creador: JoseAngel_Blox\nFecha de Lanzamiento: 09/07/2026\nVersión: 1.2\nJuego: Piggy"
InfoText.TextYAlignment = Enum.TextYAlignment.Center
-- Función constructora de Interruptores (Toggles)
local function CreateToggle(name, parent, callback)
local Frame = Instance.new("Frame")
Frame.Parent = parent
Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
Frame.Size = UDim2.new(0, 420, 0, 35)
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 6)
Corner.Parent = Frame
local Label = Instance.new("TextLabel")
Label.Parent = Frame
Label.BackgroundTransparency = 1
Label.Position = UDim2.new(0, 15, 0, 0)
Label.Size = UDim2.new(0.7, 0, 1, 0)
Label.Font = Enum.Font.Gotham
Label.Text = name
Label.TextColor3 = Color3.fromRGB(220, 220, 220)
Label.TextSize = 13
Label.TextXAlignment = Enum.TextXAlignment.Left
local Button = Instance.new("TextButton")
Button.Parent = Frame
Button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Button.Position = UDim2.new(1, -55, 0.5, -10)
Button.Size = UDim2.new(0, 40, 0, 20)
Button.Text = ""
local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(1, 0)
BtnCorner.Parent = Button
local Indicator = Instance.new("Frame")
Indicator.Parent = Button
Indicator.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
Indicator.Position = UDim2.new(0, 2, 0, 2)
Indicator.Size = UDim2.new(0, 16, 0, 16)
local IndCorner = Instance.new("UICorner")
IndCorner.CornerRadius = UDim.new(1, 0)
IndCorner.Parent = Indicator
local toggled = false
Button.MouseButton1Click:Connect(function()
toggled = not toggled
if toggled then
Indicator:TweenPosition(UDim2.new(1, -18, 0, 2), "Out", "Quad", 0.2, true)
Indicator.BackgroundColor3 = Color3.fromRGB(60, 255, 60)
else
Indicator:TweenPosition(UDim2.new(0, 2, 0, 2), "Out", "Quad", 0.2, true)
Indicator.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
end
callback(toggled)
end)
end
-- ==========================================================
-- LÓGICA DE FUNCIONES Y HACKS
-- ==========================================================
local Toggles = {
ESP = false,
ESPItems = false,
SpeedJump = false,
Noclip = false,
AutoGrab = false,
AutoUnlock = false,
InfiniteStamina = false,
Godmode = false
}
-- Función auxiliar para el ESP
local function addESP(part, name, color)
local bg = Instance.new("BillboardGui")
bg.Name = "ProESP"
bg.AlwaysOnTop = true
bg.Size = UDim2.new(0, 200, 0, 50)
bg.ExtentsOffset = Vector3.new(0, 2.5, 0)
local tl = Instance.new("TextLabel")
tl.Parent = bg
tl.BackgroundTransparency = 1
tl.Size = UDim2.new(1, 0, 1, 0)
tl.Font = Enum.Font.GothamBold
tl.Text = name
tl.TextColor3 = color
tl.TextSize = 13
tl.TextStrokeTransparency = 0.3
tl.TextStrokeColor3 = Color3.fromRGB(0,0,0)
bg.Parent = part
-- Actualizar distancia en vivo
task.spawn(function()
while bg.Parent and (Toggles.ESP or Toggles.ESPItems) do
pcall(function()
local playerPos = LocalPlayer.Character.HumanoidRootPart.Position
local dist = math.floor((playerPos - part.Position).Magnitude)
tl.Text = name .. " [" .. dist .. " studs]"
end)
task.wait(0.2)
end
end)
end
-- 1. ESP (Jugadores / Bots / Piggy)
CreateToggle("ESP (Jugadores = Azul, Bots/Piggy = Rojo)", MainTab, function(state)
Toggles.ESP = state
if state then
task.spawn(function()
while Toggles.ESP do
pcall(function()
for _, v in pairs(Workspace:GetDescendants()) do
if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v.Name ~= LocalPlayer.Name then
if not v.HumanoidRootPart:FindFirstChild("ProESP") then
local isPlayer = Players:GetPlayerFromCharacter(v)
local color = isPlayer and Color3.fromRGB(50, 150, 255) or Color3.fromRGB(255, 50, 50)
local name = isPlayer and v.Name or "BOT / PIGGY"
addESP(v.HumanoidRootPart, name, color)
end
end
end
end)
task.wait(2)
end
-- Limpieza al apagar
for _, v in pairs(Workspace:GetDescendants()) do
if v.Name == "ProESP" and (v.TextLabel.TextColor3 == Color3.fromRGB(50,150,255) or v.TextLabel.TextColor3 == Color3.fromRGB(255,50,50)) then
v:Destroy()
end
end
end)
end
end)
-- 2. ESP Items
CreateToggle("ESP Items (Llaves, Objetos)", MainTab, function(state)
Toggles.ESPItems = state
if state then
task.spawn(function()
while Toggles.ESPItems do
pcall(function()
for _, v in pairs(Workspace:GetDescendants()) do
if v:IsA("BasePart") and (v.Name:lower():find("key") or v.Name:lower():find("item")) then
if not v:FindFirstChild("ProESP") then
addESP(v, v.Name, Color3.fromRGB(255, 215, 0)) -- Color dorado
end
end
end
end)
task.wait(2)
end
-- Limpieza de Items ESP
for _, v in pairs(Workspace:GetDescendants()) do
if v.Name == "ProESP" and v.TextLabel.TextColor3 == Color3.fromRGB(255, 215, 0) then
v:Destroy()
end
end
end)
end
end)
-- 3. Speed + Jump
CreateToggle("Speed + Jump", MainTab, function(state)
Toggles.SpeedJump = state
task.spawn(function()
while Toggles.SpeedJump do
pcall(function()
local human = LocalPlayer.Character.Humanoid
human.WalkSpeed = 35
human.JumpPower = 65
human.UseJumpPower = true
end)
task.wait(0.5)
end
-- Devolver a la normalidad al apagar
pcall(function()
LocalPlayer.Character.Humanoid.WalkSpeed = 16
LocalPlayer.Character.Humanoid.JumpPower = 50
end)
end)
end)
-- 4. Noclip (Atravesar paredes)
CreateToggle("Noclip (Atravesar Objetos)", MainTab, function(state)
Toggles.Noclip = state
end)
RunService.Stepped:Connect(function()
if Toggles.Noclip and LocalPlayer.Character then
for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
if part:IsA("BasePart") then
part.CanCollide = false
end
end
end
end)
-- 5. Auto Grab Items
CreateToggle("Auto Grab Items (Cercanos)", MainTab, function(state)
Toggles.AutoGrab = state
task.spawn(function()
while Toggles.AutoGrab do
pcall(function()
for _, v in pairs(Workspace:GetDescendants()) do
if v:IsA("ClickDetector") or v:IsA("ProximityPrompt") then
local parentName = v.Parent.Name:lower()
if parentName:find("key") or parentName:find("item") then
local dist = (LocalPlayer.Character.HumanoidRootPart.Position - v.Parent.Position).Magnitude
if dist <= 15 then -- Si estás a menos de 15 studs, lo recoge automático
if v:IsA("ClickDetector") then fireclickdetector(v) end
if v:IsA("ProximityPrompt") then fireproximityprompt(v) end
end
end
end
end
end)
task.wait(0.5)
end
end)
end)
-- 6. Auto Unlock Doors
CreateToggle("Auto Unlock Doors", MainTab, function(state)
Toggles.AutoUnlock = state
task.spawn(function()
while Toggles.AutoUnlock do
pcall(function()
for _, v in pairs(Workspace:GetDescendants()) do
if v:IsA("ClickDetector") or v:IsA("ProximityPrompt") then
local parentName = v.Parent.Name:lower()
if parentName:find("door") or parentName:find("lock") then
local dist = (LocalPlayer.Character.HumanoidRootPart.Position - v.Parent.Position).Magnitude
if dist <= 15 then
if v:IsA("ClickDetector") then fireclickdetector(v) end
if v:IsA("ProximityPrompt") then fireproximityprompt(v) end
end
end
end
end
end)
task.wait(0.5)
end
end)
end)
-- 7. Infinite Stamina
CreateToggle("Infinite Stamina", MainTab, function(state)
Toggles.InfiniteStamina = state
task.spawn(function()
while Toggles.InfiniteStamina do
pcall(function()
-- Evita que la energía baje reseteando los valores del personaje
if LocalPlayer.Character:FindFirstChild("Energy") then
LocalPlayer.Character.Energy.Value = 100
end
if LocalPlayer.Character:FindFirstChild("Stamina") then
LocalPlayer.Character.Stamina.Value = 100
end
end)
task.wait(0.1)
end
end)
end)
-- 8. Godmode (Invencible)
CreateToggle("Godmode (Invencible)", MainTab, function(state)
Toggles.Godmode = state
task.spawn(function()
while Toggles.Godmode do
pcall(function()
-- Una técnica común de Godmode en juegos con bots es borrar las partes que los bots usan para detectar el daño (Touch Interests)
for _, bot in pairs(Workspace:GetDescendants()) do
if bot:IsA("Model") and bot.Name ~= LocalPlayer.Name and bot:FindFirstChild("HumanoidRootPart") then
for _, weapon in pairs(bot:GetDescendants()) do
if weapon:IsA("TouchTransmitter") then
weapon:Destroy()
end
end
end
end
end)
task.wait(1)
end
end)
end)
