-- ==========================================================
-- Nombre del Creador: JoseAngel_Blox
-- Fecha de Lanzamiento: 09/07/2026
-- Versión: 3.0 - ULTIMATE FIX
-- Juego: Piggy (Libro 1 & Libro 2)
-- ==========================================================
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- ==========================================================
-- FUNCIÓN PARA DESTRUIR EL SCRIPT LIMPIAMENTE
-- ==========================================================
local function DestroyScript()
	-- Limpiar ESPs
	for _, v in pairs(Workspace:GetDescendants()) do
		if v.Name == "ProESP" then
			pcall(function() v:Destroy() end)
		end
	end
	-- Limpiar GUI
	local gui = CoreGui:FindFirstChild("JoseAngel_Blox_Piggy_PRO")
	if gui then gui:Destroy() end
	gui = LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("JoseAngel_Blox_Piggy_PRO")
	if gui then gui:Destroy() end
	-- Resetear stats del personaje
	pcall(function()
		LocalPlayer.Character.Humanoid.WalkSpeed = 16
		LocalPlayer.Character.Humanoid.JumpPower = 50
	end)
	print("JoseAngel_Blox Piggy PRO - Script destruido correctamente.")
end

-- ==========================================================
-- INTERFAZ DE USUARIO (GUI) CON DISEÑO MEJORADO
-- ==========================================================
local PiggyHub = Instance.new("ScreenGui")
PiggyHub.Name = "JoseAngel_Blox_Piggy_PRO"
PiggyHub.ResetOnSpawn = false

local success, err = pcall(function() PiggyHub.Parent = CoreGui end)
if not success then PiggyHub.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- ==========================================================
-- FONDO DE PANTALLA BONITO (OVERLAY GRADIENTE)
-- ==========================================================
local BackgroundOverlay = Instance.new("Frame")
BackgroundOverlay.Name = "BackgroundOverlay"
BackgroundOverlay.Parent = PiggyHub
BackgroundOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BackgroundOverlay.BackgroundTransparency = 0.55
BackgroundOverlay.Size = UDim2.new(1, 0, 1, 0)
BackgroundOverlay.ZIndex = 0

local GradientOverlay = Instance.new("Frame")
GradientOverlay.Name = "GradientOverlay"
GradientOverlay.Parent = BackgroundOverlay
GradientOverlay.BackgroundColor3 = Color3.fromRGB(120, 20, 200)
GradientOverlay.BackgroundTransparency = 0.85
GradientOverlay.Size = UDim2.new(1, 0, 1, 0)
GradientOverlay.ZIndex = 1

local GlowTop = Instance.new("Frame")
GlowTop.Name = "GlowTop"
GlowTop.Parent = BackgroundOverlay
GlowTop.BackgroundColor3 = Color3.fromRGB(200, 80, 255)
GlowTop.BackgroundTransparency = 0.92
GlowTop.Size = UDim2.new(1, 0, 0, 8)
GlowTop.Position = UDim2.new(0, 0, 0, 0)
GlowTop.ZIndex = 2

local GlowBottom = Instance.new("Frame")
GlowBottom.Name = "GlowBottom"
GlowBottom.Parent = BackgroundOverlay
GlowBottom.BackgroundColor3 = Color3.fromRGB(80, 20, 200)
GlowBottom.BackgroundTransparency = 0.92
GlowBottom.Size = UDim2.new(1, 0, 0, 8)
GlowBottom.Position = UDim2.new(0, 0, 1, -8)
GlowBottom.ZIndex = 2

-- Marco Principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = PiggyHub
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -125)
MainFrame.Size = UDim2.new(0, 450, 0, 260)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ZIndex = 5

-- Borde con glow
local FrameBorder = Instance.new("Frame")
FrameBorder.Name = "FrameBorder"
FrameBorder.Parent = MainFrame
FrameBorder.BackgroundColor3 = Color3.fromRGB(140, 50, 230)
FrameBorder.BackgroundTransparency = 0.6
FrameBorder.Size = UDim2.new(1, 0, 1, 0)
FrameBorder.ZIndex = 4
local BorderCorner = Instance.new("UICorner")
BorderCorner.CornerRadius = UDim.new(0, 17)
BorderCorner.Parent = FrameBorder

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

-- Barra de Título con estilo
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Title.BorderSizePixel = 0
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "  ⚡ JoseAngel_Blox Piggy PRO v3.0"
Title.TextColor3 = Color3.fromRGB(235, 235, 255)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 7

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 15)
TitleCorner.Parent = Title

local TitleBlock = Instance.new("Frame")
TitleBlock.Size = UDim2.new(1, 0, 0, 10)
TitleBlock.Position = UDim2.new(0, 0, 1, -10)
TitleBlock.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
TitleBlock.BorderSizePixel = 0
TitleBlock.Parent = Title
TitleBlock.ZIndex = 7

-- Separador decorativo bajo el título
local SepLine = Instance.new("Frame")
SepLine.Name = "SepLine"
SepLine.Parent = MainFrame
SepLine.BackgroundColor3 = Color3.fromRGB(140, 50, 230)
SepLine.BackgroundTransparency = 0.5
SepLine.Size = UDim2.new(0.9, 0, 0, 1)
SepLine.Position = UDim2.new(0.05, 0, 0, 40)
SepLine.ZIndex = 7
SepLine.BorderSizePixel = 0

-- ==========================================================
-- BOTÓN DE DESTRUIR (X) - QUITAR EL SCRIPT
-- ==========================================================
local DestroyBtn = Instance.new("TextButton")
DestroyBtn.Parent = Title
DestroyBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
DestroyBtn.BackgroundTransparency = 0.2
DestroyBtn.Position = UDim2.new(1, -32, 0.5, -10)
DestroyBtn.Size = UDim2.new(0, 20, 0, 20)
DestroyBtn.Font = Enum.Font.GothamBold
DestroyBtn.Text = "✕"
DestroyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DestroyBtn.TextSize = 14
DestroyBtn.ZIndex = 10
DestroyBtn.BorderSizePixel = 0

local DBtnCorner = Instance.new("UICorner")
DBtnCorner.CornerRadius = UDim.new(1, 0)
DBtnCorner.Parent = DestroyBtn

DestroyBtn.MouseButton1Click:Connect(function()
	DestroyScript()
end)

DestroyBtn.MouseEnter:Connect(function()
	TweenService:Create(DestroyBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
end)
DestroyBtn.MouseLeave:Connect(function()
	TweenService:Create(DestroyBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0.2}):Play()
end)

-- ==========================================================
-- PESTAÑAS
-- ==========================================================
local InfoTab = Instance.new("Frame")
InfoTab.Name = "InfoTab"
InfoTab.Parent = MainFrame
InfoTab.BackgroundTransparency = 1
InfoTab.Position = UDim2.new(0, 0, 0, 44)
InfoTab.Size = UDim2.new(1, 0, 1, -48)
InfoTab.Visible = true
InfoTab.ZIndex = 7

local MainTab = Instance.new("ScrollingFrame")
MainTab.Name = "MainTab"
MainTab.Parent = MainFrame
MainTab.BackgroundTransparency = 1
MainTab.BorderSizePixel = 0
MainTab.Position = UDim2.new(0, 0, 0, 44)
MainTab.Size = UDim2.new(1, 0, 1, -48)
MainTab.ScrollBarThickness = 4
MainTab.ScrollBarImageColor3 = Color3.fromRGB(140, 50, 230)
MainTab.CanvasSize = UDim2.new(0, 0, 0, 0)
MainTab.Visible = false
MainTab.ZIndex = 7

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = MainTab
UIListLayout.Padding = UDim.new(0, 6)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local UIPadding = Instance.new("UIPadding")
UIPadding.Parent = MainTab
UIPadding.PaddingTop = UDim.new(0, 8)
UIPadding.PaddingBottom = UDim.new(0, 8)

-- Navegación de pestañas
local TabLabel = Instance.new("TextLabel")
TabLabel.Parent = Title
TabLabel.BackgroundTransparency = 1
TabLabel.Position = UDim2.new(1, -120, 0, 0)
TabLabel.Size = UDim2.new(0, 60, 1, 0)
TabLabel.Font = Enum.Font.Gotham
TabLabel.Text = "Info"
TabLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
TabLabel.TextSize = 14
TabLabel.ZIndex = 7

local LeftArrow = Instance.new("TextButton")
LeftArrow.Parent = Title
LeftArrow.BackgroundTransparency = 1
LeftArrow.Position = UDim2.new(1, -150, 0, 0)
LeftArrow.Size = UDim2.new(0, 30, 1, 0)
LeftArrow.Font = Enum.Font.GothamBold
LeftArrow.Text = "<"
LeftArrow.TextColor3 = Color3.fromRGB(200, 200, 255)
LeftArrow.TextSize = 20
LeftArrow.ZIndex = 7

local RightArrow = Instance.new("TextButton")
RightArrow.Parent = Title
RightArrow.BackgroundTransparency = 1
RightArrow.Position = UDim2.new(1, -60, 0, 0)
RightArrow.Size = UDim2.new(0, 30, 1, 0)
RightArrow.Font = Enum.Font.GothamBold
RightArrow.Text = ">"
RightArrow.TextColor3 = Color3.fromRGB(200, 200, 255)
RightArrow.TextSize = 20
RightArrow.ZIndex = 7

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

-- Info Tab content
local InfoText = Instance.new("TextLabel")
InfoText.Parent = InfoTab
InfoText.BackgroundTransparency = 1
InfoText.Size = UDim2.new(1, 0, 1, 0)
InfoText.Font = Enum.Font.Gotham
InfoText.TextColor3 = Color3.fromRGB(210, 210, 230)
InfoText.TextSize = 15
InfoText.Text = "  👑 JoseAngel_Blox Piggy PRO\n\n  📌 Versión 3.0 - Ultimate Fix\n  🎮 Piggy (Libro 1 & Libro 2)\n\n  ✅ ESP Items universal\n  ✅ Auto Unlock Doors mejorado\n  ✅ Diseño premium\n\n  ❌ Presiona ✕ para cerrar"
InfoText.TextXAlignment = Enum.TextXAlignment.Left
InfoText.TextYAlignment = Enum.TextYAlignment.Center

-- ==========================================================
-- FUNCIÓN DE TOGGLE CON DISEÑO MEJORADO
-- ==========================================================
local function CreateToggle(name, parent, callback)
	local Frame = Instance.new("Frame")
	Frame.Parent = parent
	Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
	Frame.BorderSizePixel = 0
	Frame.Size = UDim2.new(0, 420, 0, 32)

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 6)
	Corner.Parent = Frame

	-- Borde sutil al toggle
	local TglBorder = Instance.new("Frame")
	TglBorder.Parent = Frame
	TglBorder.BackgroundColor3 = Color3.fromRGB(140, 50, 230)
	TglBorder.BackgroundTransparency = 0.85
	TglBorder.Size = UDim2.new(1, 0, 1, 0)
	TglBorder.ZIndex = 6
	local TglBorderCorner = Instance.new("UICorner")
	TglBorderCorner.CornerRadius = UDim.new(0, 6)
	TglBorderCorner.Parent = TglBorder

	local Label = Instance.new("TextLabel")
	Label.Parent = Frame
	Label.BackgroundTransparency = 1
	Label.Position = UDim2.new(0, 12, 0, 0)
	Label.Size = UDim2.new(0.7, 0, 1, 0)
	Label.Font = Enum.Font.Gotham
	Label.Text = name
	Label.TextColor3 = Color3.fromRGB(210, 210, 230)
	Label.TextSize = 13
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.ZIndex = 7

	local Button = Instance.new("TextButton")
	Button.Parent = Frame
	Button.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	Button.BorderSizePixel = 0
	Button.Position = UDim2.new(1, -50, 0.5, -9)
	Button.Size = UDim2.new(0, 38, 0, 18)
	Button.Text = ""

	local BtnCorner = Instance.new("UICorner")
	BtnCorner.CornerRadius = UDim.new(1, 0)
	BtnCorner.Parent = Button

	local Indicator = Instance.new("Frame")
	Indicator.Parent = Button
	Indicator.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
	Indicator.Position = UDim2.new(0, 2, 0, 2)
	Indicator.Size = UDim2.new(0, 14, 0, 14)
	Indicator.BorderSizePixel = 0
	local IndCorner = Instance.new("UICorner")
	IndCorner.CornerRadius = UDim.new(1, 0)
	IndCorner.Parent = Indicator

	local toggled = false
	Button.MouseButton1Click:Connect(function()
		toggled = not toggled
		if toggled then
			TweenService:Create(Indicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Position = UDim2.new(1, -16, 0, 2),
				BackgroundColor3 = Color3.fromRGB(60, 220, 80)
			}):Play()
		else
			TweenService:Create(Indicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Position = UDim2.new(0, 2, 0, 2),
				BackgroundColor3 = Color3.fromRGB(220, 50, 50)
			}):Play()
		end
		callback(toggled)
	end)
end

-- ==========================================================
-- LÓGICA DE FUNCIONES
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

-- ==========================================================
-- LISTA UNIVERSAL DE ÍTEMS (Libro 1 + Libro 2)
-- ==========================================================
local function isItemName(name)
	local n = name:lower()
	if n:find("key") then return true end
	local book1Items = {
		"hammer", "wrench", "plank", "greengear", "redgear", "gas", "battery",
		"redegg", "blueegg", "torch", "wood", "book", "syringe", "crossbow",
		"transmitter", "chain", "hook", "grass", "shovel", "code", "purpletube",
		"munition", "arrow", "crank", "valve", "handle", "weed", "flowerpot",
		"redbattery", "bluebattery", "keycard"
	}
	local book2Items = {
		"screwdriver", "broom", "scissors", "carrot", "ladder", "smoke",
		"elevatorkey", "elevator_key", "lens", "crowbar", "gear", "plunger",
		"cog", "dynamite", "rope", "keypad", "remote", "coin", "token"
	}
	for _, item in pairs(book1Items) do
		if n:find(item) then return true end
	end
	for _, item in pairs(book2Items) do
		if n:find(item) then return true end
	end
	return false
end

-- ==========================================================
-- LISTA DE PUERTAS
-- ==========================================================
local function isDoorName(name)
	local n = name:lower()
	local doorKeywords = {
		"door", "lock", "gate", "barrier", "fence", "wall",
		"cage", "trap", "hold", "block", "barricade", "hatch",
		"entrance", "exit", "access", "panel", "cell", "bars",
		"gateway", "window", "barrier", "lid"
	}
	for _, kw in pairs(doorKeywords) do
		if n:find(kw) then return true end
	end
	return false
end

-- Función ESP
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

-- 1. ESP (Jugadores)
CreateToggle("ESP (Jugadores/Bots)", MainTab, function(state)
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
								addESP(v.HumanoidRootPart, isPlayer and v.Name or "BOT / PIGGY", color)
							end
						end
					end
				end)
				task.wait(2)
			end
			for _, v in pairs(Workspace:GetDescendants()) do
				if v.Name == "ProESP" and (v.TextLabel.TextColor3 == Color3.fromRGB(50,150,255) or v.TextLabel.TextColor3 == Color3.fromRGB(255,50,50)) then
					v:Destroy()
				end
			end
		end)
	end
end)

-- 2. ESP Items (CORREGIDO - LISTA COMPLETA)
CreateToggle("ESP Items (Llaves, Objetos)", MainTab, function(state)
	Toggles.ESPItems = state
	if state then
		task.spawn(function()
			while Toggles.ESPItems do
				pcall(function()
					for _, v in pairs(Workspace:GetDescendants()) do
						if v:IsA("BasePart") and isItemName(v.Name) then
							if not v:FindFirstChild("ProESP") then
								addESP(v, v.Name, Color3.fromRGB(255, 215, 0))
							end
						elseif v:IsA("Model") and v.PrimaryPart and isItemName(v.Name) then
							if not v.PrimaryPart:FindFirstChild("ProESP") then
								addESP(v.PrimaryPart, v.Name, Color3.fromRGB(255, 215, 0))
							end
						elseif v:IsA("BasePart") and (v:FindFirstChildOfClass("ClickDetector") or v:FindFirstChildOfClass("ProximityPrompt")) then
							if not v:FindFirstChild("ProESP") and not isDoorName(v.Name) then
								addESP(v, v.Name, Color3.fromRGB(255, 215, 0))
							end
						elseif v:IsA("Model") and v.PrimaryPart then
							local hasInteractive = v:FindFirstChildOfClass("ClickDetector") or v:FindFirstChildOfClass("ProximityPrompt")
							if hasInteractive and not v.PrimaryPart:FindFirstChild("ProESP") and not isDoorName(v.Name) then
								addESP(v.PrimaryPart, v.Name, Color3.fromRGB(255, 215, 0))
							end
						end
					end
				end)
				task.wait(2)
			end
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
		pcall(function()
			LocalPlayer.Character.Humanoid.WalkSpeed = 16
			LocalPlayer.Character.Humanoid.JumpPower = 50
		end)
	end)
end)

-- 4. Noclip
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
						local parentPart = v.Parent
						if parentPart:IsA("Model") and parentPart.PrimaryPart then
							parentPart = parentPart.PrimaryPart
						end
						if parentPart and parentPart:IsA("BasePart") and isItemName(parentPart.Name) then
							local dist = (LocalPlayer.Character.HumanoidRootPart.Position - parentPart.Position).Magnitude
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

-- ==========================================================
-- 6. AUTO UNLOCK DOORS (VERSIÓN CORREGIDA - SUPER AGRESIVA)
-- ==========================================================
CreateToggle("Auto Unlock Doors", MainTab, function(state)
	Toggles.AutoUnlock = state
	if state then
		task.spawn(function()
			while Toggles.AutoUnlock do
				pcall(function()
					local char = LocalPlayer.Character
					if not char then return end
					local root = char:FindFirstChild("HumanoidRootPart")
					if not root then return end
					local playerPos = root.Position

					-- MÉTODO 1: Disparar TODOS los ClickDetectors/ProximityPrompts 
					-- cercanos, sin importar el nombre
					for _, v in pairs(Workspace:GetDescendants()) do
						if v:IsA("ClickDetector") or v:IsA("ProximityPrompt") then
							local target = v.Parent
							if target:IsA("Model") and target.PrimaryPart then
								target = target.PrimaryPart
							end
							if target and target:IsA("BasePart") then
								local dist = (playerPos - target.Position).Magnitude
								if dist <= 22 then
									if v:IsA("ClickDetector") then
										fireclickdetector(v)
									else
										fireproximityprompt(v)
									end
								end
							end
						end
					end

					-- MÉTODO 2: Partes con nombre de puerta
					for _, v in pairs(Workspace:GetDescendants()) do
						if v:IsA("BasePart") and (isDoorName(v.Name) or v.Name:lower():find("unlock") or v.Name:lower():find("open")) then
							local dist = (playerPos - v.Position).Magnitude
							if dist <= 22 then
								local detector = v:FindFirstChildOfClass("ClickDetector")
								if detector then fireclickdetector(detector) end
								local prompt = v:FindFirstChildOfClass("ProximityPrompt")
								if prompt then fireproximityprompt(prompt) end
							end
						end
					end

					-- MÉTODO 3: Modelos con nombre de puerta
					for _, v in pairs(Workspace:GetDescendants()) do
						if v:IsA("Model") and v.PrimaryPart and (isDoorName(v.Name) or v.Name:lower():find("unlock") or v.Name:lower():find("open")) then
							local dist = (playerPos - v.PrimaryPart.Position).Magnitude
							if dist <= 22 then
								local detector = v:FindFirstChildOfClass("ClickDetector")
								if detector then fireclickdetector(detector) end
								local prompt = v:FindFirstChildOfClass("ProximityPrompt")
								if prompt then fireproximityprompt(prompt) end
							end
						end
					end
				end)
				task.wait(0.4)
			end
		end)
	end
end)

-- 7. Infinite Stamina
CreateToggle("Infinite Stamina", MainTab, function(state)
	Toggles.InfiniteStamina = state
	task.spawn(function()
		while Toggles.InfiniteStamina do
			pcall(function()
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

-- 8. Godmode
CreateToggle("Godmode (Invencible)", MainTab, function(state)
	Toggles.Godmode = state
	task.spawn(function()
		while Toggles.Godmode do
			pcall(function()
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

-- Ajustar CanvasSize del ScrollingFrame
task.wait(0.1)
MainTab.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 20)

print("JoseAngel_Blox Piggy PRO v3.0 - Ultimate Fix cargado correctamente!")
