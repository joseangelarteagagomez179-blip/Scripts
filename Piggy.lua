-- ==========================================================
-- Nombre del Creador: JoseAngel_Blox
-- Fecha de Lanzamiento: 08/07/2026
-- Versión: 4.1 - ULTIMATE PREMIUM
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
	for _, v in pairs(Workspace:GetDescendants()) do
		if v.Name == "ProESP" then pcall(function() v:Destroy() end) end
	end
	local gui = CoreGui:FindFirstChild("JoseAngel_Blox_Piggy_PRO")
	if gui then gui:Destroy() end
	gui = LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("JoseAngel_Blox_Piggy_PRO")
	if gui then gui:Destroy() end
	pcall(function()
		LocalPlayer.Character.Humanoid.WalkSpeed = 16
		LocalPlayer.Character.Humanoid.JumpPower = 50
	end)
	print("JoseAngel_Blox Piggy PRO v4.1 - Script destruido.")
end

DestroyScript() -- Limpiar ejecuciones previas

-- ==========================================================
-- INTERFAZ DE USUARIO (GUI) - DISEÑO PREMIUM
-- ==========================================================
local PiggyHub = Instance.new("ScreenGui")
PiggyHub.Name = "JoseAngel_Blox_Piggy_PRO"
PiggyHub.ResetOnSpawn = false
local success, err = pcall(function() PiggyHub.Parent = CoreGui end)
if not success then PiggyHub.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- FONDO DE PANTALLA BONITO (OVERLAY GRADIENTE)
local BackgroundOverlay = Instance.new("Frame")
BackgroundOverlay.Name = "BackgroundOverlay"
BackgroundOverlay.Parent = PiggyHub
BackgroundOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BackgroundOverlay.BackgroundTransparency = 0.55
BackgroundOverlay.Size = UDim2.new(1, 0, 1, 0)
BackgroundOverlay.ZIndex = 0

local GlowTop = Instance.new("Frame")
GlowTop.Parent = BackgroundOverlay
GlowTop.BackgroundColor3 = Color3.fromRGB(200, 80, 255)
GlowTop.BackgroundTransparency = 0.92
GlowTop.Size = UDim2.new(1, 0, 0, 8)
GlowTop.Position = UDim2.new(0, 0, 0, 0)
GlowTop.ZIndex = 2

local GlowBottom = Instance.new("Frame")
GlowBottom.Parent = BackgroundOverlay
GlowBottom.BackgroundColor3 = Color3.fromRGB(80, 20, 200)
GlowBottom.BackgroundTransparency = 0.92
GlowBottom.Size = UDim2.new(1, 0, 0, 8)
GlowBottom.Position = UDim2.new(0, 0, 1, -8)
GlowBottom.ZIndex = 2

-- ==========================================================
-- MARCO PRINCIPAL
-- ==========================================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = PiggyHub
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -160)
MainFrame.Size = UDim2.new(0, 550, 0, 320)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ZIndex = 5

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

-- Gradiente en el fondo del marco
local FrameGradient = Instance.new("UIGradient")
FrameGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 35, 50)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 20))
})
FrameGradient.Rotation = 45
FrameGradient.Parent = MainFrame

-- Borde con glow morado
local FrameBorder = Instance.new("Frame")
FrameBorder.Parent = MainFrame
FrameBorder.BackgroundColor3 = Color3.fromRGB(140, 50, 230)
FrameBorder.BackgroundTransparency = 0.6
FrameBorder.Size = UDim2.new(1, 0, 1, 0)
FrameBorder.ZIndex = 4
FrameBorder.BorderSizePixel = 0
local BorderCorner = Instance.new("UICorner")
BorderCorner.CornerRadius = UDim.new(0, 17)
BorderCorner.Parent = FrameBorder

-- ==========================================================
-- BARRA DE TÍTULO SUPERIOR (NOMBRE ARRIBA)
-- ==========================================================
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.ZIndex = 7

local TitleBarCorner = Instance.new("UICorner")
TitleBarCorner.CornerRadius = UDim.new(0, 15)
TitleBarCorner.Parent = TitleBar

-- Bloque cuadrado para evitar bordes redondeados abajo
local TitleBlock = Instance.new("Frame")
TitleBlock.Size = UDim2.new(1, 0, 0, 12)
TitleBlock.Position = UDim2.new(0, 0, 1, -12)
TitleBlock.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
TitleBlock.BorderSizePixel = 0
TitleBlock.Parent = TitleBar
TitleBlock.ZIndex = 7

-- Título principal
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = TitleBar
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.Font = Enum.Font.GothamBlack
Title.Text = "JoseAngel_Blox Piggy PRO v4.1"
Title.TextColor3 = Color3.fromRGB(235, 235, 255)
Title.TextSize = 17
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 8

-- Subtexto decorativo bajo el título
local SepLine = Instance.new("Frame")
SepLine.Name = "SepLine"
SepLine.Parent = MainFrame
SepLine.BackgroundColor3 = Color3.fromRGB(140, 50, 230)
SepLine.BackgroundTransparency = 0.4
SepLine.Size = UDim2.new(0.9, 0, 0, 1)
SepLine.Position = UDim2.new(0.05, 0, 0, 40)
SepLine.ZIndex = 7
SepLine.BorderSizePixel = 0

-- Botón de Cerrar (X)
local DestroyBtn = Instance.new("TextButton")
DestroyBtn.Parent = TitleBar
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
DestroyBtn.MouseButton1Click:Connect(DestroyScript)
DestroyBtn.MouseEnter:Connect(function()
	TweenService:Create(DestroyBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
end)
DestroyBtn.MouseLeave:Connect(function()
	TweenService:Create(DestroyBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0.2}):Play()
end)

-- ==========================================================
-- SIDEBAR + CONTENEDOR DE PÁGINAS
-- ==========================================================
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
Sidebar.Size = UDim2.new(0, 130, 1, -40)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.ZIndex = 6
local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 10)
SideCorner.Parent = Sidebar
local SideFix = Instance.new("Frame")
SideFix.Parent = Sidebar
SideFix.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
SideFix.Position = UDim2.new(1, -10, 0, 0)
SideFix.Size = UDim2.new(0, 10, 1, 0)
SideFix.BorderSizePixel = 0
SideFix.ZIndex = 6

-- Contenedor de pestañas
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Parent = MainFrame
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0, 130, 0, 40)
TabContainer.Size = UDim2.new(1, -130, 1, -40)
TabContainer.ZIndex = 7

-- Páginas
local InfoPage = Instance.new("Frame", TabContainer)
InfoPage.Size = UDim2.new(1, 0, 1, 0)
InfoPage.BackgroundTransparency = 1
InfoPage.Visible = true

local MainPage = Instance.new("ScrollingFrame", TabContainer)
MainPage.Size = UDim2.new(1, 0, 1, 0)
MainPage.BackgroundTransparency = 1
MainPage.ScrollBarThickness = 4
MainPage.ScrollBarImageColor3 = Color3.fromRGB(140, 50, 230)
MainPage.Visible = false
MainPage.CanvasSize = UDim2.new(0, 0, 0, 0)

local ProPage = Instance.new("ScrollingFrame", TabContainer)
ProPage.Size = UDim2.new(1, 0, 1, 0)
ProPage.BackgroundTransparency = 1
ProPage.ScrollBarThickness = 4
ProPage.ScrollBarImageColor3 = Color3.fromRGB(140, 50, 230)
ProPage.Visible = false
ProPage.CanvasSize = UDim2.new(0, 0, 0, 0)

-- Layouts para scroll frames
for _, page in pairs({MainPage, ProPage}) do
	local layout = Instance.new("UIListLayout", page)
	layout.Padding = UDim.new(0, 8)
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	local pad = Instance.new("UIPadding", page)
	pad.PaddingTop = UDim.new(0, 12)
	pad.PaddingBottom = UDim.new(0, 12)
end

-- ==========================================================
-- BOTONES DE NAVEGACIÓN (SIDEBAR)
-- ==========================================================
local function createSideButton(text, posY)
	local btn = Instance.new("TextButton")
	btn.Parent = Sidebar
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
	btn.Position = UDim2.new(0.05, 0, 0, posY)
	btn.Size = UDim2.new(0.9, 0, 0, 36)
	btn.Font = Enum.Font.GothamBold
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(200, 200, 210)
	btn.TextSize = 13
	btn.BorderSizePixel = 0
	btn.ZIndex = 8
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = btn
	return btn
end

local pages = {InfoPage, MainPage, ProPage}
local pageNames = {"Info", "Main", "Controles Pro"}
local btnInfo = createSideButton("📋 Info", 60)
local btnMain = createSideButton("⚙️ Main", 105)
local btnPro = createSideButton("🎮 Pro", 150)
local sideBtns = {btnInfo, btnMain, btnPro}

for i, btn in pairs(sideBtns) do
	btn.MouseButton1Click:Connect(function()
		for _, p in pairs(pages) do p.Visible = false end
		for _, b in pairs(sideBtns) do
			b.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
			b.TextColor3 = Color3.fromRGB(200, 200, 210)
		end
		pages[i].Visible = true
		btn.BackgroundColor3 = Color3.fromRGB(100, 50, 200)
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	end)
end

-- Info Page Content
local InfoText = Instance.new("TextLabel", InfoPage)
InfoText.BackgroundTransparency = 1
InfoText.Size = UDim2.new(1, -15, 1, -15)
InfoText.Position = UDim2.new(0, 15, 0, 15)
InfoText.Font = Enum.Font.Gotham
InfoText.TextColor3 = Color3.fromRGB(210, 210, 230)
InfoText.TextSize = 14
InfoText.TextXAlignment = Enum.TextXAlignment.Left
InfoText.TextYAlignment = Enum.TextYAlignment.Top
InfoText.Text = [[👑 JoseAngel_Blox Piggy PRO v4.1

📌 Versión Definitiva
🎮 Piggy (Libro 1 & Libro 2)

✅ ESP Items + Traducción
✅ Auto Unlock (Holding Key)
✅ Auto Grab Items
✅ Godmode (Invencible)
✅ Speed + Jump / Noclip
✅ Piggy Mode (Kill Aura)
✅ Hitbox Expansión
✅ Controles Pro (Vuelo)

❌ Presiona ✕ para cerrar]]

-- ==========================================================
-- FUNCIÓN DE TOGGLE PREMIUM
-- ==========================================================
local function CreateToggle(name, parent, callback)
	local Frame = Instance.new("Frame", parent)
	Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
	Frame.BorderSizePixel = 0
	Frame.Size = UDim2.new(0, 390, 0, 36)
	
	local Corner = Instance.new("UICorner", Frame)
	Corner.CornerRadius = UDim.new(0, 8)
	
	-- Borde sutil
	local TglBorder = Instance.new("Frame", Frame)
	TglBorder.BackgroundColor3 = Color3.fromRGB(140, 50, 230)
	TglBorder.BackgroundTransparency = 0.85
	TglBorder.Size = UDim2.new(1, 0, 1, 0)
	TglBorder.ZIndex = 6
	TglBorder.BorderSizePixel = 0
	local TglBorderCorner = Instance.new("UICorner", TglBorder)
	TglBorderCorner.CornerRadius = UDim.new(0, 8)
	
	local Label = Instance.new("TextLabel", Frame)
	Label.BackgroundTransparency = 1
	Label.Position = UDim2.new(0, 14, 0, 0)
	Label.Size = UDim2.new(0.7, 0, 1, 0)
	Label.Font = Enum.Font.Gotham
	Label.Text = name
	Label.TextColor3 = Color3.fromRGB(210, 210, 230)
	Label.TextSize = 13
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.ZIndex = 7
	
	local Button = Instance.new("TextButton", Frame)
	Button.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	Button.BorderSizePixel = 0
	Button.Position = UDim2.new(1, -50, 0.5, -10)
	Button.Size = UDim2.new(0, 40, 0, 20)
	Button.Text = ""
	Button.ZIndex = 7
	
	local BtnCorner = Instance.new("UICorner", Button)
	BtnCorner.CornerRadius = UDim.new(1, 0)
	
	local Indicator = Instance.new("Frame", Button)
	Indicator.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
	Indicator.Position = UDim2.new(0, 3, 0, 3)
	Indicator.Size = UDim2.new(0, 14, 0, 14)
	Indicator.BorderSizePixel = 0
	local IndCorner = Instance.new("UICorner", Indicator)
	IndCorner.CornerRadius = UDim.new(1, 0)
	
	local toggled = false
	Button.MouseButton1Click:Connect(function()
		toggled = not toggled
		if toggled then
			TweenService:Create(Indicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Position = UDim2.new(1, -17, 0, 3),
				BackgroundColor3 = Color3.fromRGB(60, 220, 80)
			}):Play()
		else
			TweenService:Create(Indicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Position = UDim2.new(0, 3, 0, 3),
				BackgroundColor3 = Color3.fromRGB(220, 50, 50)
			}):Play()
		end
		callback(toggled)
	end)
end

-- ==========================================================
-- FUNCIÓN SLIDER PREMIUM
-- ==========================================================
local function CreateSlider(name, parent, min, max, default, callback)
	local Frame = Instance.new("Frame", parent)
	Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
	Frame.BorderSizePixel = 0
	Frame.Size = UDim2.new(0, 390, 0, 55)
	
	local Corner = Instance.new("UICorner", Frame)
	Corner.CornerRadius = UDim.new(0, 8)
	
	local Label = Instance.new("TextLabel", Frame)
	Label.BackgroundTransparency = 1
	Label.Size = UDim2.new(1, -20, 0, 22)
	Label.Position = UDim2.new(0, 14, 0, 5)
	Label.Font = Enum.Font.Gotham
	Label.Text = name .. ": " .. tostring(default)
	Label.TextColor3 = Color3.fromRGB(210, 210, 230)
	Label.TextSize = 13
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.ZIndex = 7
	
	local SliderBack = Instance.new("Frame", Frame)
	SliderBack.Size = UDim2.new(1, -30, 0, 6)
	SliderBack.Position = UDim2.new(0, 15, 0, 38)
	SliderBack.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
	SliderBack.BorderSizePixel = 0
	SliderBack.ZIndex = 7
	Instance.new("UICorner", SliderBack).CornerRadius = UDim.new(1, 0)
	
	local SliderFill = Instance.new("Frame", SliderBack)
	SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
	SliderFill.BackgroundColor3 = Color3.fromRGB(120, 50, 220)
	SliderFill.BorderSizePixel = 0
	Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(1, 0)
	
	local isDragging = false
	local function update(input)
		local pos = math.clamp((input.Position.X - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X, 0, 1)
		SliderFill.Size = UDim2.new(pos, 0, 1, 0)
		local val = math.floor(min + (pos * (max - min)))
		Label.Text = name .. ": " .. tostring(val)
		callback(val)
	end
	
	SliderBack.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			isDragging = true
			update(input)
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			update(input)
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			isDragging = false
		end
	end)
end

-- ==========================================================
-- VARIABLES DE TOGGLES
-- ==========================================================
local Toggles = {
	ESP = false,
	ESPItems = false,
	SpeedJump = false,
	Noclip = false,
	AutoGrab = false,
	AutoUnlock = false,
	InfiniteStamina = false,
	Godmode = false,
	Fly = false,
	PiggyESP = false,
	KillAura = false,
	Hitbox = false
}

local FlySettings = {
	Speed = 50,
	BV = nil,
	BG = nil,
	Connection = nil
}

-- ==========================================================
-- UTILIDADES
-- ==========================================================
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
	if n:find("key") then return "🔑 Llave" end
	
	local items = {
		["hammer"] = "Martillo", ["wrench"] = "Llave Inglesa", ["plank"] = "Tabla",
		["greengear"] = "Engranaje Verde", ["redgear"] = "Engranaje Rojo", ["gear"] = "Engranaje",
		["gas"] = "Gasolina", ["battery"] = "Batería", ["redegg"] = "Huevo Rojo", ["blueegg"] = "Huevo Azul",
		["torch"] = "Antorcha", ["wood"] = "Leña", ["book"] = "Libro", ["syringe"] = "Jeringa",
		["crossbow"] = "Ballesta", ["chain"] = "Cadena", ["hook"] = "Gancho", ["grass"] = "Pasto",
		["shovel"] = "Pala", ["code"] = "Código", ["purpletube"] = "Tubo Morado",
		["screwdriver"] = "Destornillador", ["broom"] = "Escoba", ["scissors"] = "Tijeras",
		["carrot"] = "Zanahoria", ["ladder"] = "Escalera", ["smoke"] = "Humo", ["lens"] = "Lente",
		["crowbar"] = "Palanca", ["dynamite"] = "Dinamita", ["rope"] = "Cuerda",
		["keypad"] = "Teclado", ["coin"] = "Moneda", ["remote"] = "Control", ["token"] = "Ficha"
	}
	for key, clean in pairs(items) do
		if n:find(key) then return clean end
	end
	return nil
end

local function isDoorName(name)
	if not name then return false end
	local n = name:lower()
	local doorKeywords = {"door", "lock", "gate", "padlock", "safe", "plank", "barrier",
		"exit", "entrance", "cage", "cell", "bars", "hatch", "lid", "trap", "fence"}
	for _, kw in pairs(doorKeywords) do
		if n:find(kw) then return true end
	end
	return false
end

local function isItemName(name)
	local n = name:lower()
	if n:find("key") then return true end
	local book1 = {"hammer","wrench","plank","gear","gas","battery","egg","torch","wood","book",
		"syringe","crossbow","transmitter","chain","hook","grass","shovel","code","tube","munition","arrow","crank","valve"}
	local book2 = {"screwdriver","broom","scissors","carrot","ladder","smoke","lens","crowbar",
		"plunger","cog","dynamite","rope","keypad","remote","coin","token"}
	for _, item in pairs(book1) do if n:find(item) then return true end end
	for _, item in pairs(book2) do if n:find(item) then return true end end
	return false
end

-- Función ESP
local function addESP(part, cleanName, color)
	if part:FindFirstChild("ProESP") then return end
	local bg = Instance.new("BillboardGui", part)
	bg.Name = "ProESP"
	bg.AlwaysOnTop = true
	bg.Size = UDim2.new(0, 200, 0, 50)
	bg.ExtentsOffset = Vector3.new(0, 2.5, 0)
	local tl = Instance.new("TextLabel", bg)
	tl.BackgroundTransparency = 1
	tl.Size = UDim2.new(1, 0, 1, 0)
	tl.Font = Enum.Font.GothamBold
	tl.Text = cleanName
	tl.TextColor3 = color
	tl.TextSize = 13
	tl.TextStrokeTransparency = 0.3
	tl.TextStrokeColor3 = Color3.fromRGB(0,0,0)
	
	task.spawn(function()
		while bg.Parent and Toggles do
			pcall(function()
				local p = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				if p then
					local dist = math.floor((p.Position - part.Position).Magnitude)
					tl.Text = cleanName .. " [" .. dist .. "]"
				end
			end)
			task.wait(0.3)
		end
	end)
end

-- ==========================================================
-- =============== PESTAÑA MAIN =============================
-- ==========================================================

-- 1. ESP (Jugadores/Bots)
CreateToggle("ESP (Jugadores / Bots)", MainPage, function(state)
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

-- 2. ESP Items (Traducido)
CreateToggle("ESP Items (Llaves / Objetos)", MainPage, function(state)
	Toggles.ESPItems = state
	if state then
		task.spawn(function()
			while Toggles.ESPItems do
				pcall(function()
					for _, v in pairs(Workspace:GetDescendants()) do
						-- Por ClickDetector/ProximityPrompt
						if (v:IsA("ClickDetector") or v:IsA("ProximityPrompt")) and v.Parent:IsA("BasePart") then
							local cleanName = getCleanItemName(v.Parent.Name)
							if cleanName and not v.Parent:FindFirstChild("ProESP") and not isDoorName(v.Parent.Name) then
								addESP(v.Parent, cleanName, Color3.fromRGB(255, 215, 0))
							end
						end
						-- Por nombre de ítem
						if v:IsA("BasePart") and isItemName(v.Name) then
							local cleanName = getCleanItemName(v.Name) or v.Name
							if not v:FindFirstChild("ProESP") then
								addESP(v, cleanName, Color3.fromRGB(255, 215, 0))
							end
						end
					end
				end)
				task.wait(2)
			end
			for _, v in pairs(Workspace:GetDescendants()) do
				if v.Name == "ProESP" and v.TextLabel.TextColor3 == Color3.fromRGB(255, 215, 0) then v:Destroy() end
			end
		end)
	end
end)

-- 3. Auto Grab Items
CreateToggle("Auto Grab Items (Cercanos)", MainPage, function(state)
	Toggles.AutoGrab = state
	task.spawn(function()
		while Toggles.AutoGrab do
			pcall(function()
				local pos = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				if not pos then return end
				pos = pos.Position
				for _, v in pairs(Workspace:GetDescendants()) do
					if v:IsA("ClickDetector") or v:IsA("ProximityPrompt") then
						local target = v.Parent
						if target:IsA("Model") and target.PrimaryPart then target = target.PrimaryPart end
						if target and target:IsA("BasePart") and isItemName(target.Name) then
							if (pos - target.Position).Magnitude <= 15 then
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

-- 4. Auto Unlock Doors (HOLDING KEY - A CUALQUIER DISTANCIA)
CreateToggle("Auto Unlock (Holding Key)", MainPage, function(state)
	Toggles.AutoUnlock = state
	if state then
		task.spawn(function()
			while Toggles.AutoUnlock do
				pcall(function()
					local char = LocalPlayer.Character
					if not char then return end
					local tool = char:FindFirstChildOfClass("Tool")
					if tool and (tool.Name:find("Key") or tool.Name:find("key") or tool:FindFirstChild("Handle")) then
						-- Buscar TODAS las puertas/interactivos del mapa y abrirlos
						for _, v in pairs(Workspace:GetDescendants()) do
							-- ClickDetectors
							if v:IsA("ClickDetector") then
								local target = v.Parent
								if target:IsA("Model") and target.PrimaryPart then target = target.PrimaryPart end
								if target and target:IsA("BasePart") then
									pcall(function() fireclickdetector(v) end)
								end
							end
							-- ProximityPrompts
							if v:IsA("ProximityPrompt") then
								pcall(function() fireproximityprompt(v) end)
							end
							-- TouchInterests (contacto físico con Handle)
							if v:IsA("BasePart") and (isDoorName(v.Name) or isDoorName(v.Parent and v.Parent.Name or "")) then
								if tool:FindFirstChild("Handle") then
									pcall(function()
										firetouchinterest(tool.Handle, v, 0)
										task.wait(0.05)
										firetouchinterest(tool.Handle, v, 1)
									end)
								end
							end
						end
					end
				end)
				task.wait(0.3) -- Rápido para respuesta inmediata
			end
		end)
	end
end)

-- 5. Speed + Jump
CreateToggle("Speed + Jump (Altos)", MainPage, function(state)
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

-- 6. Noclip (sin bug de caída)
CreateToggle("Noclip (Atravesar paredes)", MainPage, function(state)
	Toggles.Noclip = state
end)
RunService.Stepped:Connect(function()
	if Toggles.Noclip and LocalPlayer.Character then
		for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
			if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" and part.Name ~= "LowerTorso" and part.Name ~= "UpperTorso" then
				part.CanCollide = false
			end
		end
	end
end)

-- 7. Infinite Stamina
CreateToggle("Infinite Stamina", MainPage, function(state)
	Toggles.InfiniteStamina = state
	task.spawn(function()
		while Toggles.InfiniteStamina do
			pcall(function()
				if LocalPlayer.Character:FindFirstChild("Energy") then LocalPlayer.Character.Energy.Value = 100 end
				if LocalPlayer.Character:FindFirstChild("Stamina") then LocalPlayer.Character.Stamina.Value = 100 end
			end)
			task.wait(0.1)
		end
	end)
end)

-- 8. Godmode (Invencible)
CreateToggle("Godmode (Invencible)", MainPage, function(state)
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

-- 9. Expandir Hitboxes (Golpear fácil)
CreateToggle("Expandir Hitboxes (Golpe fácil)", MainPage, function(state)
	Toggles.Hitbox = state
	task.spawn(function()
		while Toggles.Hitbox do
			pcall(function()
				for _, player in pairs(Players:GetPlayers()) do
					if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
						local hrp = player.Character.HumanoidRootPart
						hrp.Size = Vector3.new(15, 15, 15)
						hrp.Transparency = 0.7
						hrp.BrickColor = BrickColor.new("Bright red")
						hrp.CanCollide = false
					end
				end
			end)
			task.wait(1)
		end
		pcall(function()
			for _, player in pairs(Players:GetPlayers()) do
				if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
					player.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
					player.Character.HumanoidRootPart.Transparency = 1
				end
			end
		end)
	end)
end)

-- ==========================================================
-- =============== PESTAÑA PRO (PIGGY MODE + VUELO) =========
-- ==========================================================

-- Modo Piggy: ESP solo supervivientes
CreateToggle("ESP Supervivientes (Solo Humanos)", ProPage, function(state)
	Toggles.PiggyESP = state
	if state then
		task.spawn(function()
			while Toggles.PiggyESP do
				pcall(function()
					for _, player in pairs(Players:GetPlayers()) do
						if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
							if not player.Character:FindFirstChild("Bat") and not player.Character:FindFirstChild("Weapon") then
								addESP(player.Character.HumanoidRootPart, player.Name, Color3.fromRGB(50, 255, 100))
							end
						end
					end
				end)
				task.wait(2)
			end
			for _, v in pairs(Workspace:GetDescendants()) do
				if v.Name == "ProESP" and v.TextLabel.TextColor3 == Color3.fromRGB(50, 255, 100) then v:Destroy() end
			end
		end)
	end
end)

-- Kill Aura (Auto Atacar)
CreateToggle("Kill Aura (Auto Atacar)", ProPage, function(state)
	Toggles.KillAura = state
	task.spawn(function()
		while Toggles.KillAura do
			pcall(function()
				local char = LocalPlayer.Character
				local tool = char:FindFirstChildOfClass("Tool")
				if tool and tool:FindFirstChild("Handle") then
					local pos = char.HumanoidRootPart.Position
					for _, target in pairs(Players:GetPlayers()) do
						if target ~= LocalPlayer and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
							local targetPart = target.Character.HumanoidRootPart
							if (pos - targetPart.Position).Magnitude <= 15 then
								firetouchinterest(tool.Handle, targetPart, 0)
								task.wait(0.01)
								firetouchinterest(tool.Handle, targetPart, 1)
							end
						end
					end
				end
			end)
			task.wait(0.1)
		end
	end)
end)

-- Fly Mode (Controles Pro)
CreateToggle("Fly Mode (Vuelo Pro)", ProPage, function(state)
	Toggles.Fly = state
	if state then
		local char = LocalPlayer.Character
		if not char then return end
		local root = char:WaitForChild("HumanoidRootPart")
		local hum = char:WaitForChild("Humanoid")
		
		FlySettings.BV = Instance.new("BodyVelocity", root)
		FlySettings.BV.MaxForce = Vector3.new(1e8, 1e8, 1e8)
		FlySettings.BV.Velocity = Vector3.new(0, 0, 0)
		
		FlySettings.BG = Instance.new("BodyGyro", root)
		FlySettings.BG.MaxTorque = Vector3.new(1e8, 1e8, 1e8)
		FlySettings.BG.P = 20000
		FlySettings.BG.D = 100
		
		FlySettings.Connection = RunService.RenderStepped:Connect(function()
			if not char or not char.Parent then return end
			hum.PlatformStand = true
			local moveDir = hum.MoveDirection
			local camCF = Workspace.CurrentCamera.CFrame
			local velocity = Vector3.new(0, 0.1, 0)
			
			if moveDir.Magnitude > 0 then
				velocity = camCF.Rotation * Vector3.new(moveDir.X, 0, moveDir.Z).Unit * FlySettings.Speed
			end
			
			if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
				velocity = velocity + Vector3.new(0, FlySettings.Speed, 0)
			elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
				velocity = velocity + Vector3.new(0, -FlySettings.Speed, 0)
			end
			
			FlySettings.BV.Velocity = velocity
			FlySettings.BG.CFrame = CFrame.new(root.Position, root.Position + camCF.LookVector)
		end)
	else
		if FlySettings.Connection then FlySettings.Connection:Disconnect(); FlySettings.Connection = nil end
		if FlySettings.BV then FlySettings.BV:Destroy(); FlySettings.BV = nil end
		if FlySettings.BG then FlySettings.BG:Destroy(); FlySettings.BG = nil end
		pcall(function()
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
				LocalPlayer.Character.Humanoid.PlatformStand = false
			end
		end)
	end
end)

-- Slider de velocidad de vuelo
CreateSlider("Velocidad Vuelo", ProPage, 10, 200, 50, function(val)
	FlySettings.Speed = val
end)

-- ==========================================================
-- AJUSTE FINAL: CanvasSize
-- ==========================================================
task.wait(0.1)
local function updateCanvas()
	for _, page in pairs({MainPage, ProPage}) do
		local layout = page:FindFirstChildOfClass("UIListLayout")
		if layout then
			page.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
		end
	end
end
updateCanvas()
MainPage.ChildAdded:Connect(updateCanvas)
ProPage.ChildAdded:Connect(updateCanvas)

print("JoseAngel_Blox Piggy PRO v4.1 - Ultimate Premium cargado correctamente!")
