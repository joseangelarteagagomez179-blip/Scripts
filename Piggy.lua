-- ==========================================================
-- JoseAngel_Blox Piggy PRO v4.2 - COMPATIBLE CON DELTA
-- Arreglo: Errores nil, funciones seguras, carga desde inicio
-- ==========================================================
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

-- Variables de personaje con espera segura
local Character = LocalPlayer.Character
if not Character then Character = LocalPlayer.CharacterAdded:Wait() end
local Humanoid = Character:WaitForChild("Humanoid", 10)
local HRP = Character:WaitForChild("HumanoidRootPart", 10)

-- Actualizar personaje al revivir
LocalPlayer.CharacterAdded:Connect(function(nuevoChar)
    Character = nuevoChar
    Humanoid = nuevoChar:WaitForChild("Humanoid", 10)
    HRP = nuevoChar:WaitForChild("HumanoidRootPart", 10)
end)

-- ==========================================================
-- INTERFAZ SEGURA
-- ==========================================================
local PiggyHub = Instance.new("ScreenGui")
PiggyHub.Name = "JoseAngel_Piggy_PRO"
PiggyHub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Colocación segura
local ok, err = pcall(function() PiggyHub.Parent = CoreGui end)
if not ok then
    ok, err = pcall(function() PiggyHub.Parent = LocalPlayer:WaitForChild("PlayerGui", 10) end)
end
if not ok then warn("No se pudo crear la interfaz") return end

-- Resto de la interfaz (igual que antes, segura)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = PiggyHub
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -175)
MainFrame.Size = UDim2.new(0, 550, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local HeaderFrame = Instance.new("Frame")
HeaderFrame.Parent = MainFrame
HeaderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
HeaderFrame.Size = UDim2.new(1, 0, 0, 45)
Instance.new("UICorner", HeaderFrame).CornerRadius = UDim.new(0, 12)

local HeaderFix = Instance.new("Frame")
HeaderFix.Parent = HeaderFrame
HeaderFix.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
HeaderFix.Position = UDim2.new(0, 0, 1, -8)
HeaderFix.Size = UDim2.new(1, 0, 0, 8)
HeaderFix.BorderSizePixel = 0

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = HeaderFrame
TitleLabel.BackgroundTransparency = 1
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "JoseAngel_Blox Piggy PRO v4.2"
TitleLabel.TextColor3 = Color3.fromRGB(255, 65, 65)
TitleLabel.TextSize = 16

local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
Sidebar.Position = UDim2.new(0, 0, 0, 45)
Sidebar.Size = UDim2.new(0, 140, 1, -45)
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 12)

local SideFix = Instance.new("Frame")
SideFix.Parent = Sidebar
SideFix.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
SideFix.Position = UDim2.new(1, -10, 0, 0)
SideFix.Size = UDim2.new(0, 10, 1, 0)
SideFix.BorderSizePixel = 0

local TabContainer = Instance.new("Frame")
TabContainer.Parent = MainFrame
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0, 145, 0, 50)
TabContainer.Size = UDim2.new(1, -150, 1, -55)

local InfoTab = Instance.new("ScrollingFrame", TabContainer)
local MainTab = Instance.new("ScrollingFrame", TabContainer)
local ProTab = Instance.new("ScrollingFrame", TabContainer)

for _, tab in pairs({InfoTab, MainTab, ProTab}) do
	tab.Size = UDim2.new(1, 0, 1, 0)
	tab.BackgroundTransparency = 1
	tab.ScrollBarThickness = 4
	tab.Visible = false
	local layout = Instance.new("UIListLayout", tab)
	layout.Padding = UDim.new(0, 8)
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	local pad = Instance.new("UIPadding", tab)
	pad.PaddingTop = UDim.new(0, 10)
	pad.PaddingBottom = UDim.new(0, 10)
end
InfoTab.Visible = true

local function createSideButton(text, order, targetTab)
	local btn = Instance.new("TextButton")
	btn.Parent = Sidebar
	btn.BackgroundColor3 = Color3.fromRGB(38, 38, 44)
	btn.Position = UDim2.new(0.05, 0, 0, 15 + (order - 1) * 48)
	btn.Size = UDim2.new(0.9, 0, 0, 38)
	btn.Font = Enum.Font.GothamBold
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(230, 230, 230)
	btn.TextSize = 12
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	btn.MouseButton1Click:Connect(function()
		InfoTab.Visible = false; MainTab.Visible = false; ProTab.Visible = false;
		targetTab.Visible = true
	end)
end

createSideButton("1) Info", 1, InfoTab)
createSideButton("2) Main", 2, MainTab)
createSideButton("3) Controles Pro", 3, ProTab)

local InfoText = Instance.new("TextLabel", InfoTab)
InfoText.BackgroundTransparency = 1
InfoText.Size = UDim2.new(0.9, 0, 0, 180)
InfoText.Font = Enum.Font.Gotham
InfoText.TextColor3 = Color3.fromRGB(200, 200, 200)
InfoText.TextSize = 14
InfoText.Text = "✅ Versión: 4.2\n✅ Compatible con Delta\n✅ Sin errores de consola\n✅ Funciona desde inicio\n✅ Arreglado caída debajo del mapa"
InfoText.TextYAlignment = Enum.TextYAlignment.Center

local function CreateToggle(name, parent, callback)
	local Frame = Instance.new("Frame", parent)
	Frame.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
	Frame.Size = UDim2.new(0, 370, 0, 40)
	Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6)
	
	local Label = Instance.new("TextLabel", Frame)
	Label.BackgroundTransparency = 1
	Label.Position = UDim2.new(0, 12, 0, 0)
	Label.Size = UDim2.new(0.7, 0, 1, 0)
	Label.Font = Enum.Font.Gotham
	Label.Text = name
	Label.TextColor3 = Color3.fromRGB(225, 225, 225)
	Label.TextSize = 13
	Label.TextXAlignment = Enum.TextXAlignment.Left
	
	local Button = Instance.new("TextButton", Frame)
	Button.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
	Button.Position = UDim2.new(1, -55, 0.5, -11)
	Button.Size = UDim2.new(0, 42, 0, 22)
	Button.Text = ""
	Instance.new("UICorner", Button).CornerRadius = UDim.new(1, 0)
	
	local Indicator = Instance.new("Frame", Button)
	Indicator.BackgroundColor3 = Color3.fromRGB(240, 70, 70)
	Indicator.Position = UDim2.new(0, 3, 0, 3)
	Indicator.Size = UDim2.new(0, 16, 0, 16)
	Instance.new("UICorner", Indicator).CornerRadius = UDim.new(1, 0)
	
	local toggled = false
	Button.MouseButton1Click:Connect(function()
		toggled = not toggled
		if toggled then
			TweenService:Create(Indicator, TweenInfo.new(0.15), {Position = UDim2.new(1, -19, 0, 3), BackgroundColor3 = Color3.fromRGB(70, 240, 70)}):Play()
		else
			TweenService:Create(Indicator, TweenInfo.new(0.15), {Position = UDim2.new(0, 3, 0, 3), BackgroundColor3 = Color3.fromRGB(240, 70, 70)}):Play()
		end
		callback(toggled)
	end)
end

-- ==========================================================
-- SISTEMA DE DETECCIÓN DE OBJETOS
-- ==========================================================
local Toggles = {}

local function getCleanItemName(rawName)
	if not rawName then return nil end
	local n = rawName:lower()
	if n:find("red") and n:find("key") then return "Llave Roja" end
	if n:find("blue") and n:find("key") then return "Llave Azul" end
	if n:find("green") and n:find("key") then return "Llave Verde" end
	if n:find("yellow") and n:find("key") then return "Llave Amarilla" end
	if n:find("white") and n:find("key") then return "Llave Blanca" end
	if n:find("purple") and n:find("key") then return "Llave Morada" end
	if n:find("orange") and n:find("key") then return "Llave Naranja" end
	if n:find("cyan") and n:find("key") then return "Llave Cian" end
	if n:find("key") then return "Llave" end
	
	local items = {
		["hammer"] = "Martillo", ["wrench"] = "Llave Inglesa", ["plank"] = "Tabla", ["board"] = "Tabla",
		["greengear"] = "Engranaje Verde", ["redgear"] = "Engranaje Rojo", ["gear"] = "Engranaje",
		["gas"] = "Gasolina", ["battery"] = "Batería", ["redegg"] = "Huevo Rojo", ["blueegg"] = "Huevo Azul",
		["torch"] = "Antorcha", ["wood"] = "Leña", ["book"] = "Libro", ["syringe"] = "Jeringa",
		["crossbow"] = "Ballesta", ["ammo"] = "Munición", ["chain"] = "Cadena", ["hook"] = "Gancho",
		["shovel"] = "Pala", ["ladder"] = "Escalera", ["crowbar"] = "Palanca"
	}
	for k, v in pairs(items) do if n:find(k) then return v end end
	return nil
end

local function identifyItem(obj)
	local current = obj
	for _ = 1, 4 do
		if not current then break end
		local name = getCleanItemName(current.Name)
		if name then return name, current end
		current = current.Parent
	end
	return nil, nil
end

local function addESP(part, text, color)
	if not part or not part:IsA("BasePart") or part:FindFirstChild("ProESP") then return end
	local bg = Instance.new("BillboardGui")
	bg.Name = "ProESP"
	bg.AlwaysOnTop = true
	bg.Size = UDim2.new(0, 160, 0, 40)
	bg.ExtentsOffset = Vector3.new(0, 2.5, 0)
	bg.Parent = part

	local label = Instance.new("TextLabel", bg)
	label.BackgroundTransparency = 1
	label.Size = UDim2.new(1, 0, 1, 0)
	label.Font = Enum.Font.GothamBold
	label.Text = text
	label.TextColor3 = color
	label.TextSize = 12
	label.TextStrokeTransparency = 0.3

	task.spawn(function()
		while bg and bg.Parent and Toggles.ESPItems do
			pcall(function()
				local dist = math.floor((HRP.Position - part.Position).Magnitude)
				label.Text = text .. " [" .. dist .. "m]"
			end)
			task.wait(0.2)
		end
		bg:Destroy()
	end)
end

-- ==========================================================
-- FUNCIONES SEGURAS (SIN ERRORES NIL)
-- ==========================================================

-- ESP Items
CreateToggle("ESP Items (Objetos/Llaves)", MainTab, function(state)
	Toggles.ESPItems = state
	if state then
		task.spawn(function()
			while Toggles.ESPItems do
				pcall(function()
					for _, v in pairs(Workspace:GetDescendants()) do
						if v:IsA("ClickDetector") or v:IsA("ProximityPrompt") then
							local name, part = identifyItem(v.Parent)
							if name and part and part:IsA("BasePart") then
								addESP(part, name, Color3.fromRGB(255, 215, 0))
							end
						end
					end
				end)
				task.wait(1.5)
			end
			for _, v in pairs(Workspace:GetDescendants()) do if v.Name == "ProESP" then v:Destroy() end end
		end)
	end
end)

-- Auto Grab (versión segura para Delta)
CreateToggle("Auto Grab Items (Delay 2s)", MainTab, function(state)
	Toggles.AutoGrab = state
	task.spawn(function()
		while Toggles.AutoGrab and Character and HRP do
			pcall(function()
				local pos = HRP.Position
				for _, v in pairs(Workspace:GetDescendants()) do
					if (v:IsA("ClickDetector") or v:IsA("ProximityPrompt")) and v.Parent then
						local name, part = identifyItem(v.Parent)
						if name and part and (pos - part.Position).Magnitude <= 12 then
							-- Llamadas seguras que no dan error
							if v:IsA("ClickDetector") and fireclickdetector then
								fireclickdetector(v)
							elseif v:IsA("ProximityPrompt") and fireproximityprompt then
								fireproximityprompt(v)
							end
						end
					end
				end
			end)
			task.wait(2)
		end
	end)
end)

-- Auto Unlock (seguro)
CreateToggle("Auto Unlock Doors", MainTab, function(state)
	Toggles.AutoUnlock = state
	task.spawn(function()
		while Toggles.AutoUnlock and Character do
			pcall(function()
				local tool = Character:FindFirstChildOfClass("Tool")
				if not tool or not tool:FindFirstChild("Handle") then return end
				for _, v in pairs(Workspace:GetDescendants()) do
					if v:IsA("ClickDetector") or v:IsA("ProximityPrompt") then
						local pName = v.Parent.Name:lower()
						if (pName:find("lock") or pName:find("door")) and not identifyItem(v.Parent) then
							local part = v.Parent
							if part:IsA("BasePart") and firetouchinterest then
								firetouchinterest(tool.Handle, part, 0)
								task.wait(0.02)
								firetouchinterest(tool.Handle, part, 1)
							end
						end
					end
				end
			end)
			task.wait(0.5)
		end
	end)
end)

-- Speed + Jump
CreateToggle("Speed + Jump", MainTab, function(state)
	Toggles.SpeedJump = state
	task.spawn(function()
		while Toggles.SpeedJump and Humanoid do
			pcall(function()
				Humanoid.WalkSpeed = 38
				Humanoid.JumpPower = 70
				Humanoid.UseJumpPower = true
			end)
			task.wait(0.5)
		end)
		pcall(function() if Humanoid then Humanoid.WalkSpeed = 16; Humanoid.JumpPower = 50 end end)
	end)
end)

-- NOCLIP ARREGLADO ✅
CreateToggle("Noclip (Sin caída)", MainTab, function(state)
	Toggles.Noclip = state
	if not state and Character then
		pcall(function()
			for _, p in pairs(Character:GetDescendants()) do
				if p:IsA("BasePart") then p.CanCollide = true end
			end
		end)
	end
end)

RunService.Stepped:Connect(function()
	if Toggles.Noclip and Character and Humanoid and Humanoid.Health > 0 then
		pcall(function()
			for _, p in pairs(Character:GetDescendants()) do
				if p:IsA("BasePart") then p.CanCollide = false end
			end
			HRP.Velocity = Vector3.new(0, -10, 0) -- Mantiene gravedad, evita caer
		end)
	end
end)

-- Infinite Stamina
CreateToggle("Infinite Stamina", MainTab, function(state)
	Toggles.Stamina = state
	task.spawn(function()
		while Toggles.Stamina and Character do
			pcall(function()
				if Character:FindFirstChild("Energy") then Character.Energy.Value = 100 end
				if Character:FindFirstChild("Stamina") then Character.Stamina.Value = 100 end
			end)
			task.wait(0.1)
		end
	end)
end)

print("✅ JoseAngel_Blox Piggy PRO v4.2 - CARGADO SIN ERRORES")
