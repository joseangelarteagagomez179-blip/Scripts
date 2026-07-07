-- =============================================
-- JoseAngel_Blox Scripts PRO - Versión 1.1
-- Creado por: JoseAngel_Blox
-- Fecha de lanzamiento: 08/07/2026
-- =============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ==================== CREACIÓN DE LA VENTANA CUADRADA 4:3 ====================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "JoseAngel_Blox_Pro"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "Main"
mainFrame.Size = UDim2.new(0, 640, 0, 480)  -- 640x480 = relación 4:3 exacta
mainFrame.Position = UDim2.new(0.5, -320, 0.5, -240)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Thickness = 3
stroke.Color = Color3.fromRGB(0, 255, 100)
stroke.Parent = mainFrame

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.Text = "JoseAngel_Blox Scripts PRO"
title.TextColor3 = Color3.fromRGB(0, 255, 100)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame
title.LayoutOrder = 1

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 16)
titleCorner.Parent = title

-- ==================== Opciones en fila (horizontal) ====================
local optionHolder = Instance.new("Frame")
optionHolder.Size = UDim2.new(1, 0, 0, 400)
optionHolder.Position = UDim2.new(0, 0, 0, 50)
optionHolder.BackgroundTransparency = 1
optionHolder.Parent = mainFrame

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.FillDirection = Enum.FillDirection.Horizontal
uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
uiListLayout.Padding = UDim.new(0, 12)
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Parent = optionHolder

-- ==================== FUNCIÓN CREAR SWITCH PROFESIONAL ====================
local function createSwitch(text, defaultState, callback)
	local switchFrame = Instance.new("Frame")
	switchFrame.Size = UDim2.new(0.23, 0, 0, 55)
	switchFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	switchFrame.Parent = optionHolder

	local switchCorner = Instance.new("UICorner")
	switchCorner.CornerRadius = UDim.new(0, 12)
	switchCorner.Parent = switchFrame

	local switchLabel = Instance.new("TextLabel")
	switchLabel.Size = UDim2.new(0.7, 0, 1, 0)
	switchLabel.BackgroundTransparency = 1
	switchLabel.Text = text
	switchLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
	switchLabel.TextScaled = true
	switchLabel.Font = Enum.Font.GothamSemibold
	switchLabel.TextXAlignment = Enum.TextXAlignment.Left
	switchLabel.Parent = switchFrame

	local toggle = Instance.new("Frame")
	toggle.Size = UDim2.new(0, 48, 0, 24)
	toggle.Position = UDim2.new(1, -58, 0.5, -12)
	toggle.BackgroundColor3 = defaultState and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(60, 60, 60)
	toggle.Parent = switchFrame

	local toggleCorner = Instance.new("UICorner")
	toggleCorner.CornerRadius = UDim.new(0, 12)
	toggleCorner.Parent = toggle

	local knob = Instance.new("Frame")
	knob.Size = UDim2.new(0, 20, 0, 20)
	knob.Position = defaultState and UDim2.new(1, -24, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
	knob.BackgroundColor3 = Color3.new(1, 1, 1)
	knob.Parent = toggle
	local knobCorner = Instance.new("UICorner")
	knobCorner.CornerRadius = UDim.new(0, 10)
	knobCorner.Parent = knob

	local tween = game:GetService("TweenService")
	local isOn = defaultState

	local function toggleSwitch()
		isOn = not isOn
		local targetColor = isOn and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(60, 60, 60)
		local targetKnob = isOn and UDim2.new(1, -24, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)

		tween:Create(toggle, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {BackgroundColor3 = targetColor}):Play()
		tween:Create(knob, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {Position = targetKnob}):Play()

		callback(isOn)
	end

	switchFrame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			toggleSwitch()
		end
	end)
	knob.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			toggleSwitch()
		end
	end)

	return switchFrame
end

-- ==================== VARIABLES DE ESTADO ====================
local godMode = false
local itemESP = false
local itemGrab = false
local autoUnlock = false
local fullBright = false
local noclip = false
local speedEnabled = false
local speedValue = 50
local jumpEnabled = false
local jumpValue = 50

-- ==================== FUNCIONES ====================
local function toggleGodMode(state)
	godMode = state
end

local function toggleItemESP(state)
	itemESP = state
end

local function toggleItemGrab(state)
	itemGrab = state
end

local function toggleAutoUnlock(state)
	autoUnlock = state
end

local function toggleFullBright(state)
	fullBright = state
end

local function toggleNoClip(state)
	noclip = state
end

local function toggleSpeed(state)
	speedEnabled = state
end

local function toggleJump(state)
	jumpEnabled = state
end

-- ==================== FUNCIONES DE GAMEPLAY ====================
local connection

local function applyFeatures()
	if connection then connection:Disconnect() end
	connection = RunService.Heartbeat:Connect(function()
		-- God Mode
		if godMode then
			for _, char in ipairs(Workspace:GetChildren()) do
				if char:IsA("Model") and char:FindFirstChild("Humanoid") and char:FindFirstChild("HumanoidRootPart") then
					char.Humanoid.MaxHealth = 9e9
					char.Humanoid.Health = 9e9
				end
			end
		end

		-- Item ESP (pinta en amarillo)
		if itemESP then
			for _, obj in ipairs(Workspace:GetDescendants()) do
				if obj:IsA("BasePart") and (obj.Name:lower():find("item") or obj.Name:lower():find("pick") or obj.Name:lower():find("box")) then
					obj.Color = Color3.fromRGB(255, 255, 0)
					obj.Transparency = 0.3
				end
			end
		end

		-- Auto Grab Items
		if itemGrab then
			for _, obj in ipairs(Workspace:GetChildren()) do
				if obj:IsA("BasePart") and (obj.Name:lower():find("item") or obj.Name:lower():find("pick") or obj.Name:lower():find("box")) then
					obj.Parent = player.Character
				end
			end
		end

		-- Auto Unlock Doors
		if autoUnlock then
			for _, door in ipairs(Workspace:GetChildren()) do
				if door:IsA("Model") and door:FindFirstChild("Door") and door:FindFirstChild("Hinge") then
					door:FindFirstChild("Hinge").CurrentAngle = 0
				end
			end
		end

		-- Full Bright
		if fullBright then
			game.Lighting.Brightness = 2
			game.Lighting.ClockTime = 12
			game.Lighting.FogEnd = 100000
			game.Lighting.GlobalShadows = false
		end

		-- No Clip
		if noclip then
			if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				player.Character.HumanoidRootPart.CanCollide = false
			end
		end

		-- Speed & Jump
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			local hum = player.Character.Humanoid
			if speedEnabled then hum.WalkSpeed = speedValue end
			if jumpEnabled then hum.JumpPower = jumpValue end
		end
	end)
end

applyFeatures()

-- ==================== TOGGLE GLOBAL CON INSERT ====================
UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.Insert then
		-- Aquí podrías hacer un toggle global de todo, pero por ahora usaremos INSERT como ayuda
		print("JoseAngel_Blox Scripts PRO - Todo activado/desactivado con INSERT")
	end
end)

-- ==================== LISTA FINAL DE Opciones (en fila) ====================
local options = {
	{ "God Mode (invencible)", false, toggleGodMode },
	{ "Item ESP (ve items a través de paredes)", false, toggleItemESP },
	{ "Toggle con la tecla INSERT (para activar/desactivar todo)", false, function() end }, -- placeholder
	{ "Auto Unlock Doors (abre puertas automáticamente)", false, toggleAutoUnlock },
	{ "Auto Grab Items (coge todo lo que está cerca)", false, toggleItemGrab },
	{ "No Clip: Por si necesitas atravesar una pared en emergencia", false, toggleNoClip },
	{ "Speed & Jump: Para correr más rápido que Piggy si te persigue.", false, function(s) toggleSpeed(s); toggleJump(s) end },
	{ "FullBright: Para ver perfectamente en los mapas oscuros.", false, toggleFullBright },
	{ "ESP (Ver a través de paredes): Para saber siempre dónde está Piggy y dónde están los demás jugadores.", false, toggleItemESP }, -- reutilizamos Item ESP
}

for i, opt in ipairs(options) do
	createSwitch(opt[1], opt[2], opt[3])
end

print("✅ JoseAngel_Blox Scripts PRO cargado correctamente - Versión 1.1")
