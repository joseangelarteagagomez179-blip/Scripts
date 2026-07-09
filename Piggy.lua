-- ==========================================================
-- Nombre del Creador: JoseAngel_Blox
-- Fecha de Lanzamiento: 09/07/2026
-- Versión: 3.0 - Sidebar UI & Piggy Mode
-- Juego: Piggy (Libro 1 & Libro 2)
-- ==========================================================
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- ==========================================================
-- INTERFAZ DE USUARIO (GUI) CON SIDEBAR
-- ==========================================================
local PiggyHub = Instance.new("ScreenGui")
PiggyHub.Name = "JoseAngel_Blox_Piggy_PRO"

local success, err = pcall(function() PiggyHub.Parent = CoreGui end)
if not success then PiggyHub.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- Marco Principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = PiggyHub
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -150)
MainFrame.Size = UDim2.new(0, 550, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Barra Lateral (Sidebar)
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Sidebar.Size = UDim2.new(0, 130, 1, 0)

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 10)
SideCorner.Parent = Sidebar
local SideFix = Instance.new("Frame") -- Para que la derecha no sea redonda
SideFix.Parent = Sidebar
SideFix.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
SideFix.Position = UDim2.new(1, -10, 0, 0)
SideFix.Size = UDim2.new(0, 10, 1, 0)
SideFix.BorderSizePixel = 0

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = Sidebar
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 0, 0, 10)
TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "JoseAngel\nPRO v3.0"
TitleLabel.TextColor3 = Color3.fromRGB(255, 60, 60)
TitleLabel.TextSize = 14

-- Contenedor de Pestañas
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Parent = MainFrame
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0, 130, 0, 0)
TabContainer.Size = UDim2.new(1, -130, 1, 0)

-- Pestañas
local InfoTab = Instance.new("Frame", TabContainer)
InfoTab.Size = UDim2.new(1, 0, 1, 0)
InfoTab.BackgroundTransparency = 1
InfoTab.Visible = true

local MainTab = Instance.new("ScrollingFrame", TabContainer)
MainTab.Size = UDim2.new(1, 0, 1, 0)
MainTab.BackgroundTransparency = 1
MainTab.ScrollBarThickness = 4
MainTab.Visible = false

local ProTab = Instance.new("ScrollingFrame", TabContainer)
ProTab.Size = UDim2.new(1, 0, 1, 0)
ProTab.BackgroundTransparency = 1
ProTab.ScrollBarThickness = 4
ProTab.Visible = false

-- Layouts para ScrollingFrames
for _, tab in pairs({MainTab, ProTab}) do
	local layout = Instance.new("UIListLayout", tab)
	layout.Padding = UDim.new(0, 8)
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	local pad = Instance.new("UIPadding", tab)
	pad.PaddingTop = UDim.new(0, 15)
	pad.PaddingBottom = UDim.new(0, 15)
end

-- Botones del Menú Lateral
local function createSideButton(text, pos, targetTab)
	local btn = Instance.new("TextButton")
	btn.Parent = Sidebar
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
	btn.Position = UDim2.new(0.05, 0, 0, pos)
	btn.Size = UDim2.new(0.9, 0, 0, 35)
	btn.Font = Enum.Font.GothamBold
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(220, 220, 220)
	btn.TextSize = 13
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = btn
	
	btn.MouseButton1Click:Connect(function()
		InfoTab.Visible = false
		MainTab.Visible = false
		ProTab.Visible = false
		targetTab.Visible = true
	end)
	return btn
end

createSideButton("1) Info", 70, InfoTab)
createSideButton("2) Main", 115, MainTab)
createSideButton("3) Controles Pro", 160, ProTab)

-- Contenido de Info
local InfoText = Instance.new("TextLabel", InfoTab)
InfoText.BackgroundTransparency = 1
InfoText.Size = UDim2.new(1, 0, 1, 0)
InfoText.Font = Enum.Font.Gotham
InfoText.TextColor3 = Color3.fromRGB(220, 220, 220)
InfoText.TextSize = 15
InfoText.Text = "Creador: JoseAngel_Blox\n\n✅ Bug Noclip / Caída Reparado\n✅ Unlock Físico Directo\n✅ Modo Piggy Añadido"

-- Creador de Toggles
local function CreateToggle(name, parent, callback)
	local Frame = Instance.new("Frame", parent)
	Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
	Frame.Size = UDim2.new(0, 390, 0, 35)
	local Corner = Instance.new("UICorner", Frame)
	Corner.CornerRadius = UDim.new(0, 6)
	
	local Label = Instance.new("TextLabel", Frame)
	Label.BackgroundTransparency = 1
	Label.Position = UDim2.new(0, 15, 0, 0)
	Label.Size = UDim2.new(0.7, 0, 1, 0)
	Label.Font = Enum.Font.Gotham
	Label.Text = name
	Label.TextColor3 = Color3.fromRGB(220, 220, 220)
	Label.TextSize = 13
	Label.TextXAlignment = Enum.TextXAlignment.Left
	
	local Button = Instance.new("TextButton", Frame)
	Button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	Button.Position = UDim2.new(1, -55, 0.5, -10)
	Button.Size = UDim2.new(0, 40, 0, 20)
	Button.Text = ""
	local BtnCorner = Instance.new("UICorner", Button)
	BtnCorner.CornerRadius = UDim.new(1, 0)
	
	local Indicator = Instance.new("Frame", Button)
	Indicator.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
	Indicator.Position = UDim2.new(0, 2, 0, 2)
	Indicator.Size = UDim2.new(0, 16, 0, 16)
	local IndCorner = Instance.new("UICorner", Indicator)
	IndCorner.CornerRadius = UDim.new(1, 0)
	
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
-- DICCIONARIOS Y UTILIDADES
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
		["crossbow"] = "Ballesta", ["munition"] = "Munición", ["ammo"] = "Munición", ["chain"] = "Cadena",
		["hook"] = "Gancho", ["grass"] = "Pasto", ["shovel"] = "Pala", ["code"] = "Código",
		["purpletube"] = "Tubo Morado", ["screwdriver"] = "Destornillador", ["broom"] = "Escoba",
		["scissors"] = "Tijeras", ["carrot"] = "Zanahoria", ["ladder"] = "Escalera", ["smoke"] = "Humo",
		["lens"] = "Lente", ["crowbar"] = "Palanca", ["dynamite"] = "Dinamita", ["rope"] = "Cuerda",
		["keypad"] = "Teclado", ["coin"] = "Moneda"
	}
	for key, clean in pairs(items) do
		if n:find(key) then return clean end
	end
	return nil
end

local function isDoorName(name)
	if not name then return false end
	local n = name:lower()
	local doorKeywords = {"door", "lock", "gate", "padlock", "safe", "plank", "board", "barrier", "exit"}
	for _, kw in pairs(doorKeywords) do
		if n:find(kw) then return true end
	end
	return false
end

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
	
	task.spawn(function()
		while bg.Parent and (Toggles.ESP or Toggles.ESPItems or Toggles.PiggyESP) do
			pcall(function()
				local playerPos = LocalPlayer.Character.HumanoidRootPart.Position
				local dist = math.floor((playerPos - part.Position).Magnitude)
				tl.Text = cleanName .. " [" .. dist .. "]"
			end)
			task.wait(0.2)
		end
	end)
end

-- ==========================================================
-- FUNCIONES: PESTAÑA MAIN (Superviviente)
-- ==========================================================
CreateToggle("ESP Items (Objetos/Llaves)", MainTab, function(state)
	Toggles.ESPItems = state
	if state then
		task.spawn(function()
			while Toggles.ESPItems do
				pcall(function()
					for _, v in pairs(Workspace:GetDescendants()) do
						if v:IsA("ClickDetector") or v:IsA("ProximityPrompt") then
							local cleanName = getCleanItemName(v.Parent.Name)
							if cleanName and v.Parent:IsA("BasePart") then
								addESP(v.Parent, cleanName, Color3.fromRGB(255, 215, 0))
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

CreateToggle("Auto Grab Items (Delay 2s)", MainTab, function(state)
	Toggles.AutoGrab = state
	task.spawn(function()
		while Toggles.AutoGrab do
			local grabbed = false
			pcall(function()
				local pos = LocalPlayer.Character.HumanoidRootPart.Position
				for _, v in pairs(Workspace:GetDescendants()) do
					if v:IsA("ClickDetector") or v:IsA("ProximityPrompt") then
						if getCleanItemName(v.Parent.Name) then
							if (pos - v.Parent.Position).Magnitude <= 12 then 
								if v:IsA("ClickDetector") then fireclickdetector(v) end
								if v:IsA("ProximityPrompt") then fireproximityprompt(v) end
								grabbed = true
								break
							end
						end
					end
				end
			end)
			task.wait(grabbed and 2 or 0.2)
		end
	end)
end)

CreateToggle("Auto Unlock Doors (Físico)", MainTab, function(state)
	Toggles.AutoUnlock = state
	task.spawn(function()
		while Toggles.AutoUnlock do
			pcall(function()
				local char = LocalPlayer.Character
				local tool = char:FindFirstChildOfClass("Tool")
				if tool and tool:FindFirstChild("Handle") then
					local pos = char.HumanoidRootPart.Position
					for _, v in pairs(Workspace:GetDescendants()) do
						if v:IsA("BasePart") and (isDoorName(v.Name) or (v.Parent and isDoorName(v.Parent.Name))) then
							if not getCleanItemName(v.Name) and (pos - v.Position).Magnitude <= 15 then
								firetouchinterest(tool.Handle, v, 0)
								task.wait(0.01)
								firetouchinterest(tool.Handle, v, 1)
							end
						end
					end
				end
			end)
			task.wait(0.5)
		end
	end)
end)

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
		pcall(function() LocalPlayer.Character.Humanoid.WalkSpeed = 16; LocalPlayer.Character.Humanoid.JumpPower = 50 end)
	end)
end)

-- SOLUCIÓN BUG CAÍDA MAPA: Se excluyen las partes centrales del torso.
CreateToggle("Noclip (Atravesar Objetos)", MainTab, function(state)
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

-- ==========================================================
-- FUNCIONES: PESTAÑA PRO (Modo Piggy)
-- ==========================================================
CreateToggle("ESP Jugadores (Solo Supervivientes)", ProTab, function(state)
	Toggles.PiggyESP = state
	if state then
		task.spawn(function()
			while Toggles.PiggyESP do
				pcall(function()
					for _, player in pairs(Players:GetPlayers()) do
						if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
							-- Comprobar si no es Piggy (Piggy suele llevar un bate o arma)
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

CreateToggle("Kill Aura (Auto Atacar Jugadores)", ProTab, function(state)
	Toggles.KillAura = state
	task.spawn(function()
		while Toggles.KillAura do
			pcall(function()
				local char = LocalPlayer.Character
				local tool = char:FindFirstChildOfClass("Tool")
				-- Solo funciona si tienes el arma de Piggy equipada
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

CreateToggle("Expandir Hitboxes (Golpear fácil)", ProTab, function(state)
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
		-- Regresar a la normalidad si se apaga
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

print("JoseAngel_Blox Piggy PRO v3.0 - UI y Modo Piggy Cargados!")
