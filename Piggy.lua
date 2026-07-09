-- ==========================================================
-- Nombre del Creador: JoseAngel_Blox
-- Fecha de Lanzamiento: 09/07/2026
-- Versión: 4.0 - Definitive Edition (Fixes Reales)
-- Juego: Piggy (Libro 1 & Libro 2)
-- ==========================================================
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- ==========================================================
-- INTERFAZ DE USUARIO (GUI) - DISEÑO PREMIUM
-- ==========================================================
local PiggyHub = Instance.new("ScreenGui")
PiggyHub.Name = "JoseAngel_Blox_Piggy_PRO_V4"

local success, err = pcall(function() PiggyHub.Parent = CoreGui end)
if not success then PiggyHub.Parent = LocalPlayer:WaitForChild("PlayerGui") end

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
TitleLabel.Text = "JoseAngel_Blox Piggy PRO v4.0"
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
InfoText.Text = "Creador: JoseAngel_Blox\nVersión: 4.0 FINAL\n\n✨ Escáner profundo de Ítems añadido.\n⚡ Auto Unlock SEGURO (Ignora láseres).\n🚀 Noclip Clásico Reparado (Evita agacharte)."
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
			Indicator:TweenPosition(UDim2.new(1, -19, 0, 3), "Out", "Quad", 0.15, true)
			Indicator.BackgroundColor3 = Color3.fromRGB(70, 240, 70)
		else
			Indicator:TweenPosition(UDim2.new(0, 3, 0, 3), "Out", "Quad", 0.15, true)
			Indicator.BackgroundColor3 = Color3.fromRGB(240, 70, 70)
		end
		callback(toggled)
	end)
end

-- ==========================================================
-- SISTEMA DE ESCANEO PROFUNDO (Arregla ESP y Auto Grab)
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
		["lens"] = "Lente", ["crowbar"] = "Palanca", ["dynamite"] = "Dinamita", ["rope"] = "Cuerda", ["bone"] = "Hueso"
	}
	for key, clean in pairs(items) do
		if n:find(key) then return clean end
	end
	return nil
end

-- Busca el nombre del ítem hasta en 3 capas de profundidad de carpetas
local function identifyItem(obj)
	local current = obj
	for i = 1, 3 do
		if not current then break end
		local name = getCleanItemName(current.Name)
		if name then return name, current end
		current = current.Parent
	end
	return nil, nil
end

local function addESP(part, cleanName, color)
	if part:FindFirstChild("ProESP") then return end
	local bg = Instance.new("BillboardGui", part)
	bg.Name = "ProESP"
	bg.AlwaysOnTop = true
	bg.Size = UDim2.new(0, 160, 0, 40)
	bg.ExtentsOffset = Vector3.new(0, 2.5, 0)
	local tl = Instance.new("TextLabel", bg)
	tl.BackgroundTransparency = 1
	tl.Size = UDim2.new(1, 0, 1, 0)
	tl.Font = Enum.Font.GothamBold
	tl.Text = cleanName
	tl.TextColor3 = color
	tl.TextSize = 12
	tl.TextStrokeTransparency = 0.4
	
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
-- FUNCIONES: MAIN (SUPERVIVIENTE)
-- ==========================================================

-- 1. ESP Items (REPARADO: Ahora busca en profundidad)
CreateToggle("ESP Items (Objetos/Llaves)", MainTab, function(state)
	Toggles.ESPItems = state
	if state then
		task.spawn(function()
			while Toggles.ESPItems do
				pcall(function()
					for _, v in pairs(Workspace:GetDescendants()) do
						if v:IsA("ClickDetector") or v:IsA("ProximityPrompt") then
							local cleanName, targetPart = identifyItem(v.Parent)
							if cleanName and targetPart:IsA("BasePart") then
								addESP(targetPart, cleanName, Color3.fromRGB(255, 215, 0))
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

-- 2. Auto Grab (REPARADO: Verifica estrictamente que sea un ítem válido)
CreateToggle("Auto Grab Items (Delay 2s)", MainTab, function(state)
	Toggles.AutoGrab = state
	task.spawn(function()
		while Toggles.AutoGrab do
			local grabbed = false
			pcall(function()
				local char = LocalPlayer.Character
				if not char or not char:FindFirstChild("HumanoidRootPart") then return end
				local pos = char.HumanoidRootPart.Position
				
				for _, v in pairs(Workspace:GetDescendants()) do
					if v:IsA("ClickDetector") or v:IsA("ProximityPrompt") then
						-- Solo se activa si el escáner confirma que es un ítem y no una trampa
						local cleanName, itemPart = identifyItem(v.Parent)
						if cleanName and itemPart then
							if (pos - itemPart.Position).Magnitude <= 12 then 
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

-- 3. Auto Unlock Doors (REPARADO: Cero Láseres, Solo Candados Reales)
CreateToggle("Auto Unlock Doors (Global)", MainTab, function(state)
	Toggles.AutoUnlock = state
	task.spawn(function()
		while Toggles.AutoUnlock do
			pcall(function()
				local char = LocalPlayer.Character
				local tool = char and char:FindFirstChildOfClass("Tool")
				
				if tool and tool:FindFirstChild("Handle") then
					for _, v in pairs(Workspace:GetDescendants()) do
						-- Solo ataca piezas que contengan un ClickDetector (Cerraduras reales, nunca láseres)
						if v:IsA("ClickDetector") or v:IsA("ProximityPrompt") then
							local pName = (v.Parent.Name):lower()
							local gpName = (v.Parent.Parent and v.Parent.Parent.Name:lower()) or ""
							
							-- Verificamos que se llame candado o puerta, y nos aseguramos de que no sea un ítem de recoger
							if (pName:find("lock") or gpName:find("lock") or pName:find("door") or gpName:find("door")) then
								if not identifyItem(v.Parent) then
									local targetPart = v.Parent
									if targetPart:IsA("BasePart") then
										firetouchinterest(tool.Handle, targetPart, 0)
										task.wait(0.01)
										firetouchinterest(tool.Handle, targetPart, 1)
									end
								end
							end
						end
					end
				end
			end)
			task.wait(0.5)
		end
	end)
end)

-- 4. Speed + Jump
CreateToggle("Speed + Jump", MainTab, function(state)
	Toggles.SpeedJump = state
	task.spawn(function()
		while Toggles.SpeedJump do
			pcall(function()
				local human = LocalPlayer.Character.Humanoid
				human.WalkSpeed = 35; human.JumpPower = 65; human.UseJumpPower = true
			end)
			task.wait(0.5)
		end
		pcall(function() LocalPlayer.Character.Humanoid.WalkSpeed = 16; LocalPlayer.Character.Humanoid.JumpPower = 50 end)
	end)
end)

-- 5. Noclip Clásico Reparado
CreateToggle("Noclip (Atravesar Objetos)", MainTab, function(state)
	Toggles.Noclip = state
end)
RunService.Stepped:Connect(function()
	if Toggles.Noclip and LocalPlayer.Character then
		-- Desactiva las colisiones de todo el cuerpo (Motor Clásico y más estable)
		for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end
end)

-- 6. Infinite Stamina
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

-- 7. ESP Jugadores (Azul/Rojo)
CreateToggle("ESP (Jugadores = Azul, Bots = Rojo)", MainTab, function(state)
	Toggles.ESP = state
	if state then
		task.spawn(function()
			while Toggles.ESP do
				pcall(function()
					for _, v in pairs(Workspace:GetDescendants()) do
						if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v.Name ~= LocalPlayer.Name then
							local isPlayer = Players:GetPlayerFromCharacter(v)
							local color = isPlayer and Color3.fromRGB(50, 150, 255) or Color3.fromRGB(255, 50, 50)
							addESP(v.HumanoidRootPart, isPlayer and v.Name or "BOT / PIGGY", color)
						end
					end
				end)
				task.wait(2)
			end
			for _, v in pairs(Workspace:GetDescendants()) do
				if v.Name == "ProESP" and (v.TextLabel.TextColor3 == Color3.fromRGB(50,150,255) or v.TextLabel.TextColor3 == Color3.fromRGB(255,50,50)) then v:Destroy() end
			end
		end)
	end
end)

-- 8. Godmode Clásico
CreateToggle("Godmode (Invencible)", MainTab, function(state)
	Toggles.Godmode = state
	task.spawn(function()
		while Toggles.Godmode do
			pcall(function()
				for _, bot in pairs(Workspace:GetDescendants()) do
					if bot:IsA("Model") and bot.Name ~= LocalPlayer.Name and (bot:FindFirstChild("HumanoidRootPart") or bot.Name:lower():find("piggy") or bot.Name:lower():find("bot")) then
						for _, weapon in pairs(bot:GetDescendants()) do
							if weapon:IsA("TouchTransmitter") then weapon:Destroy() end
						end
					end
				end
			end)
			task.wait(0.5)
		end
	end)
end)

-- ==========================================================
-- FUNCIONES: PRO (PIGGY)
-- ==========================================================
CreateToggle("ESP Jugadores (Solo Supervivientes)", ProTab, function(state)
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

CreateToggle("Kill Aura (Auto Atacar Jugadores)", ProTab, function(state)
	Toggles.KillAura = state
	task.spawn(function()
		while Toggles.KillAura do
			pcall(function()
				local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
				if tool and tool:FindFirstChild("Handle") then
					local pos = LocalPlayer.Character.HumanoidRootPart.Position
					for _, target in pairs(Players:GetPlayers()) do
						if target ~= LocalPlayer and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
							local tPart = target.Character.HumanoidRootPart
							if (pos - tPart.Position).Magnitude <= 18 then
								firetouchinterest(tool.Handle, tPart, 0); task.wait(0.01); firetouchinterest(tool.Handle, tPart, 1)
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
						hrp.Size = Vector3.new(15, 15, 15); hrp.Transparency = 0.6; hrp.BrickColor = BrickColor.new("Bright red"); hrp.CanCollide = false
					end
				end
			end)
			task.wait(1)
		end
		pcall(function()
			for _, player in pairs(Players:GetPlayers()) do
				if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
					player.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1); player.Character.HumanoidRootPart.Transparency = 1
				end
			end
		end)
	end)
end)

print("✅ JoseAngel_Blox Piggy PRO v4.0 FINAL - Motores Completamente Reparados")
