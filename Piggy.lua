-- ==========================================================
-- Nombre del Creador: JoseAngel_Blox
-- Fecha de Lanzamiento: 09/07/2026
-- Versión: 2.2 - Nombres Limpios & Auto-Fixes
-- Juego: Piggy (Libro 1 & Libro 2)
-- CORRECIONES: Nombres en ESP traducidos, AutoGrab/Unlock reparados
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

-- Protegemos la GUI
local success, err = pcall(function() PiggyHub.Parent = CoreGui end)
if not success then PiggyHub.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- Marco Principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = PiggyHub
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -125)
MainFrame.Size = UDim2.new(0, 450, 0, 250)
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "  JoseAngel_Blox Piggy PRO v2.2"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 15)
TitleCorner.Parent = Title

local TitleBlock = Instance.new("Frame")
TitleBlock.Size = UDim2.new(1, 0, 0, 10)
TitleBlock.Position = UDim2.new(0, 0, 1, -10)
TitleBlock.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
TitleBlock.BorderSizePixel = 0
TitleBlock.Parent = Title

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

local InfoText = Instance.new("TextLabel")
InfoText.Parent = InfoTab
InfoText.BackgroundTransparency = 1
InfoText.Size = UDim2.new(1, 0, 1, 0)
InfoText.Font = Enum.Font.Gotham
InfoText.TextColor3 = Color3.fromRGB(220, 220, 220)
InfoText.TextSize = 16
InfoText.Text = "Creador: JoseAngel_Blox\nVersión: 2.2 (Nombres Limpios)\n\n✅ Nombres de ESP corregidos\n✅ Auto Grab & Unlock agresivos"
InfoText.TextYAlignment = Enum.TextYAlignment.Center

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
-- LÓGICA DE FUNCIONES Y DICCIONARIO
-- ==========================================================
local Toggles = {ESP = false, ESPItems = false, SpeedJump = false, Noclip = false, AutoGrab = false, AutoUnlock = false, InfiniteStamina = false, Godmode = false}

-- Diccionario para traducir IDs/Nombres feos a Nombres Limpios
local function getCleanItemName(rawName)
	if not rawName then return nil end
	local n = rawName:lower()
	
	-- Llaves de colores
	if n:find("red") and n:find("key") then return "Llave Roja" end
	if n:find("blue") and n:find("key") then return "Llave Azul" end
	if n:find("green") and n:find("key") then return "Llave Verde" end
	if n:find("yellow") and n:find("key") then return "Llave Amarilla" end
	if n:find("white") and n:find("key") then return "Llave Blanca" end
	if n:find("purple") and n:find("key") then return "Llave Morada" end
	if n:find("orange") and n:find("key") then return "Llave Naranja" end
	if n:find("cyan") and n:find("key") then return "Llave Cian" end
	if n:find("elevator") and n:find("key") then return "Llave Ascensor" end
	if n:find("key") then return "Llave" end
	
	-- Herramientas Libro 1 y 2
	local items = {
		["hammer"] = "Martillo", ["wrench"] = "Llave Inglesa", ["plank"] = "Tabla", ["board"] = "Tabla",
		["greengear"] = "Engranaje Verde", ["redgear"] = "Engranaje Rojo", ["gear"] = "Engranaje", ["cog"] = "Engranaje",
		["gas"] = "Gasolina", ["gasoline"] = "Gasolina", ["redbattery"] = "Batería Roja", ["bluebattery"] = "Batería Azul", ["battery"] = "Batería",
		["redegg"] = "Huevo Rojo", ["blueegg"] = "Huevo Azul", ["torch"] = "Antorcha", ["wood"] = "Leña",
		["book"] = "Libro", ["syringe"] = "Jeringa", ["crossbow"] = "Ballesta", ["munition"] = "Munición", ["ammo"] = "Munición",
		["chain"] = "Cadena", ["hook"] = "Gancho", ["grass"] = "Pasto", ["shovel"] = "Pala",
		["code"] = "Código", ["purpletube"] = "Tubo Morado", ["screwdriver"] = "Destornillador",
		["broom"] = "Escoba", ["scissors"] = "Tijeras", ["carrot"] = "Zanahoria", ["ladder"] = "Escalera",
		["smoke"] = "Humo", ["lens"] = "Lente", ["crowbar"] = "Palanca", ["dynamite"] = "Dinamita",
		["rope"] = "Cuerda", ["keypad"] = "Teclado", ["coin"] = "Moneda"
	}
	
	for key, clean in pairs(items) do
		if n:find(key) then return clean end
	end
	
	return nil
end

local function isDoorName(name)
	if not name then return false end
	local n = name:lower()
	local doorKeywords = {"door", "lock", "gate", "barrier", "obstacle", "fence", "wall", "cage", "trap", "block", "barricade", "shield", "cover", "entrance", "exit", "access", "panel", "hatch", "window", "bars", "cell"}
	for _, kw in pairs(doorKeywords) do
		if n:find(kw) then return true end
	end
	return false
end

local function addESP(part, cleanName, color)
	-- Prevenir duplicados en la misma pieza
	if part:FindFirstChild("ProESP") then return end
	
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
	tl.Text = cleanName
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
				tl.Text = cleanName .. " [" .. dist .. "]"
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
							local isPlayer = Players:GetPlayerFromCharacter(v)
							local color = isPlayer and Color3.fromRGB(50, 150, 255) or Color3.fromRGB(255, 50, 50)
							local name = isPlayer and v.Name or "BOT / PIGGY"
							addESP(v.HumanoidRootPart, name, color)
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

-- 2. ESP Items (VERSIÓN CORREGIDA - SOLO NOMBRES LIMPIOS)
CreateToggle("ESP Items (Llaves, Objetos)", MainTab, function(state)
	Toggles.ESPItems = state
	if state then
		task.spawn(function()
			while Toggles.ESPItems do
				pcall(function()
					-- Filtrar por ClickDetectors para garantizar que sean recogibles
					for _, v in pairs(Workspace:GetDescendants()) do
						if v:IsA("ClickDetector") or v:IsA("ProximityPrompt") then
							-- Revisar el nombre del padre (ej. "Hammer", "RedKey_12345")
							local parentName = v.Parent.Name
							local cleanName = getCleanItemName(parentName)
							
							if cleanName and v.Parent:IsA("BasePart") then
								addESP(v.Parent, cleanName, Color3.fromRGB(255, 215, 0))
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

-- 4. Noclip (Atravesar paredes)
CreateToggle("Noclip (Atravesar Objetos)", MainTab, function(state)
	Toggles.Noclip = state
end)
RunService.Stepped:Connect(function()
	if Toggles.Noclip and LocalPlayer.Character then
		for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
			if part:IsA("BasePart") then part.CanCollide = false end
		end
	end
end)

-- 5. Auto Grab Items (REPARADO Y AGRESIVO)
CreateToggle("Auto Grab Items (Cercanos)", MainTab, function(state)
	Toggles.AutoGrab = state
	task.spawn(function()
		while Toggles.AutoGrab do
			pcall(function()
				local char = LocalPlayer.Character
				if not char or not char:FindFirstChild("HumanoidRootPart") then return end
				local pos = char.HumanoidRootPart.Position

				for _, v in pairs(Workspace:GetDescendants()) do
					if v:IsA("ClickDetector") then
						local cleanName = getCleanItemName(v.Parent.Name)
						if cleanName then
							local dist = (pos - v.Parent.Position).Magnitude
							if dist <= 12 then -- Distancia segura para evitar kicks del servidor
								fireclickdetector(v)
							end
						end
					elseif v:IsA("ProximityPrompt") then
						local cleanName = getCleanItemName(v.Parent.Name)
						if cleanName then
							local dist = (pos - v.Parent.Position).Magnitude
							if dist <= v.MaxActivationDistance then
								fireproximityprompt(v)
							end
						end
					end
				end
			end)
			task.wait(0.2) -- Loop más rápido para recoger al instante
		end
	end)
end)

-- 6. Auto Unlock Doors (REPARADO Y AGRESIVO)
CreateToggle("Auto Unlock Doors", MainTab, function(state)
	Toggles.AutoUnlock = state
	task.spawn(function()
		while Toggles.AutoUnlock do
			pcall(function()
				local char = LocalPlayer.Character
				if not char or not char:FindFirstChild("HumanoidRootPart") then return end
				local pos = char.HumanoidRootPart.Position

				for _, v in pairs(Workspace:GetDescendants()) do
					if v:IsA("ClickDetector") then
						if isDoorName(v.Parent.Name) or (v.Parent.Parent and isDoorName(v.Parent.Parent.Name)) then
							local dist = (pos - v.Parent.Position).Magnitude
							if dist <= 12 then
								fireclickdetector(v)
							end
						end
					elseif v:IsA("ProximityPrompt") then
						if isDoorName(v.Parent.Name) or (v.Parent.Parent and isDoorName(v.Parent.Parent.Name)) then
							local dist = (pos - v.Parent.Position).Magnitude
							if dist <= v.MaxActivationDistance then
								fireproximityprompt(v)
							end
						end
					end
				end
			end)
			task.wait(0.2)
		end
	end)
end)

-- 7. Infinite Stamina
CreateToggle("Infinite Stamina", MainTab, function(state)
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

print("JoseAngel_Blox Piggy PRO v2.2 - Cargado con Nombres Limpios y Fixes!")
