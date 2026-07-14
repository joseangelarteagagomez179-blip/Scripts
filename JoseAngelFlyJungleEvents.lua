-- ==========================================
-- Nombre: Fly Jungle events obbys
-- Creador: JoseAngel_Blox
-- Compatible: PC y Móvil
-- ==========================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

-- Crear la GUI principal
local JungleGui = Instance.new("ScreenGui")
JungleGui.Name = "JungleEventsObbys"
JungleGui.ResetOnSpawn = false
-- Intentar colocarlo en CoreGui para evitar que otros scripts lo borren (si el ejecutor lo permite)
local success = pcall(function() JungleGui.Parent = CoreGui end)
if not success then JungleGui.Parent = player:WaitForChild("PlayerGui") end

-- Frame Principal (Cuadrado con esquinas redondeadas)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 250)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(34, 56, 34) -- Verde Jungla oscuro
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = JungleGui

local MainUICorner = Instance.new("UICorner")
MainUICorner.CornerRadius = UDim.new(0, 12)
MainUICorner.Parent = MainFrame

-- Título
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "🌴 Fly Jungle events obbys 🌿"
TitleLabel.TextColor3 = Color3.fromRGB(200, 255, 200)
TitleLabel.Font = Enum.Font.FredokaOne
TitleLabel.TextSize = 20
TitleLabel.Parent = MainFrame

-- Subtítulo (Creador)
local CreditLabel = Instance.new("TextLabel")
CreditLabel.Size = UDim2.new(1, 0, 0, 20)
CreditLabel.Position = UDim2.new(0, 0, 0, 35)
CreditLabel.BackgroundTransparency = 1
CreditLabel.Text = "Creado por JoseAngel_Blox"
CreditLabel.TextColor3 = Color3.fromRGB(180, 220, 180)
CreditLabel.Font = Enum.Font.SourceSansItalic
CreditLabel.TextSize = 14
CreditLabel.Parent = MainFrame

-- Contenedor de Pestañas (Botones)
local TabsFrame = Instance.new("Frame")
TabsFrame.Size = UDim2.new(1, -20, 0, 35)
TabsFrame.Position = UDim2.new(0, 10, 0, 60)
TabsFrame.BackgroundTransparency = 1
TabsFrame.Parent = MainFrame

local InfoBtn = Instance.new("TextButton")
InfoBtn.Size = UDim2.new(0.48, 0, 1, 0)
InfoBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 60)
InfoBtn.Text = "1) Info"
InfoBtn.TextColor3 = Color3.new(1, 1, 1)
InfoBtn.Font = Enum.Font.GothamBold
InfoBtn.TextSize = 14
InfoBtn.Parent = TabsFrame
Instance.new("UICorner", InfoBtn).CornerRadius = UDim.new(0, 8)

local MainBtn = Instance.new("TextButton")
MainBtn.Size = UDim2.new(0.48, 0, 1, 0)
MainBtn.Position = UDim2.new(0.52, 0, 0, 0)
MainBtn.BackgroundColor3 = Color3.fromRGB(45, 75, 45)
MainBtn.Text = "2) Main"
MainBtn.TextColor3 = Color3.new(1, 1, 1)
MainBtn.Font = Enum.Font.GothamBold
MainBtn.TextSize = 14
MainBtn.Parent = TabsFrame
Instance.new("UICorner", MainBtn).CornerRadius = UDim.new(0, 8)

-- Paneles de Pestañas
local InfoPanel = Instance.new("Frame")
InfoPanel.Size = UDim2.new(1, -20, 1, -110)
InfoPanel.Position = UDim2.new(0, 10, 0, 100)
InfoPanel.BackgroundColor3 = Color3.fromRGB(25, 40, 25)
InfoPanel.Parent = MainFrame
Instance.new("UICorner", InfoPanel).CornerRadius = UDim.new(0, 8)

local MainPanel = Instance.new("Frame")
MainPanel.Size = UDim2.new(1, -20, 1, -110)
MainPanel.Position = UDim2.new(0, 10, 0, 100)
MainPanel.BackgroundColor3 = Color3.fromRGB(25, 40, 25)
MainPanel.Visible = false
MainPanel.Parent = MainFrame
Instance.new("UICorner", MainPanel).CornerRadius = UDim.new(0, 8)

-- ==================== CONTENIDO DE INFO ====================
local InfoText = Instance.new("TextLabel")
InfoText.Size = UDim2.new(1, -20, 1, -20)
InfoText.Position = UDim2.new(0, 10, 0, 10)
InfoText.BackgroundTransparency = 1
InfoText.Text = "👤 Nombre del Creador: JoseAngel_Blox\n\n📅 Fecha de Actualización: 14/07/2026\n\n⚙️ Versión: 1.2"
InfoText.TextColor3 = Color3.fromRGB(220, 240, 220)
InfoText.Font = Enum.Font.GothamMedium
InfoText.TextSize = 16
InfoText.TextXAlignment = Enum.TextXAlignment.Left
InfoText.TextYAlignment = Enum.TextYAlignment.Top
InfoText.Parent = InfoPanel

-- ==================== CONTENIDO DE MAIN ====================
local FlySpeed = 50
local isFlying = false
local flyLoop

local FlyToggleBtn = Instance.new("TextButton")
FlyToggleBtn.Size = UDim2.new(0.8, 0, 0, 40)
FlyToggleBtn.Position = UDim2.new(0.1, 0, 0.1, 0)
FlyToggleBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
FlyToggleBtn.Text = "Fly: APAGADO"
FlyToggleBtn.TextColor3 = Color3.new(1, 1, 1)
FlyToggleBtn.Font = Enum.Font.GothamBold
FlyToggleBtn.TextSize = 18
FlyToggleBtn.Parent = MainPanel
Instance.new("UICorner", FlyToggleBtn).CornerRadius = UDim.new(0, 8)

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0.4, 0, 0, 30)
SpeedLabel.Position = UDim2.new(0.3, 0, 0.6, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Velocidad: " .. FlySpeed
SpeedLabel.TextColor3 = Color3.new(1, 1, 1)
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.TextSize = 16
SpeedLabel.Parent = MainPanel

local MinusBtn = Instance.new("TextButton")
MinusBtn.Size = UDim2.new(0.2, 0, 0, 30)
MinusBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
MinusBtn.BackgroundColor3 = Color3.fromRGB(80, 120, 80)
MinusBtn.Text = "-"
MinusBtn.TextColor3 = Color3.new(1, 1, 1)
MinusBtn.Font = Enum.Font.GothamBold
MinusBtn.TextSize = 20
MinusBtn.Parent = MainPanel
Instance.new("UICorner", MinusBtn).CornerRadius = UDim.new(0, 8)

local PlusBtn = Instance.new("TextButton")
PlusBtn.Size = UDim2.new(0.2, 0, 0, 30)
PlusBtn.Position = UDim2.new(0.7, 0, 0.6, 0)
PlusBtn.BackgroundColor3 = Color3.fromRGB(80, 120, 80)
PlusBtn.Text = "+"
PlusBtn.TextColor3 = Color3.new(1, 1, 1)
PlusBtn.Font = Enum.Font.GothamBold
PlusBtn.TextSize = 20
PlusBtn.Parent = MainPanel
Instance.new("UICorner", PlusBtn).CornerRadius = UDim.new(0, 8)

-- ==================== LÓGICA DE INTERFAZ ====================
-- Sistema de Pestañas
InfoBtn.MouseButton1Click:Connect(function()
	InfoPanel.Visible = true
	MainPanel.Visible = false
	InfoBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 60)
	MainBtn.BackgroundColor3 = Color3.fromRGB(45, 75, 45)
end)

MainBtn.MouseButton1Click:Connect(function()
	InfoPanel.Visible = false
	MainPanel.Visible = true
	MainBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 60)
	InfoBtn.BackgroundColor3 = Color3.fromRGB(45, 75, 45)
end)

-- Arrastrar la GUI (Soporte para PC y Móvil)
local dragging, dragInput, dragStart, startPos
local function updateDrag(input)
	local delta = input.Position - dragStart
	MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

MainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		updateDrag(input)
	end
end)

-- ==================== LÓGICA DE VUELO (FLY) ====================
local bodyVelocity, bodyGyro

local function stopFly()
	isFlying = false
	FlyToggleBtn.Text = "Fly: APAGADO"
	FlyToggleBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
	
	if flyLoop then flyLoop:Disconnect() end
	if bodyVelocity then bodyVelocity:Destroy() end
	if bodyGyro then bodyGyro:Destroy() end
	
	local char = player.Character
	if char and char:FindFirstChild("Humanoid") then
		char.Humanoid.PlatformStand = false
	end
end

local function startFly()
	local char = player.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Humanoid") then return end
	
	local hrp = char.HumanoidRootPart
	local hum = char.Humanoid
	
	isFlying = true
	FlyToggleBtn.Text = "Fly: ENCENDIDO"
	FlyToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
	
	hum.PlatformStand = true
	
	bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	bodyVelocity.Velocity = Vector3.new(0, 0, 0)
	bodyVelocity.Parent = hrp
	
	bodyGyro = Instance.new("BodyGyro")
	bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
	bodyGyro.P = 10000
	bodyGyro.CFrame = hrp.CFrame
	bodyGyro.Parent = hrp
	
	flyLoop = RunService.RenderStepped:Connect(function()
		if not isFlying then return end
		local cam = workspace.CurrentCamera
		local moveDir = hum.MoveDirection 
		
		-- Lógica adaptada para que funcione perfecto con Joystick (Móvil) y WASD (PC)
		if moveDir.Magnitude > 0 then
			-- Convierte la dirección de movimiento hacia donde mira la cámara
			local moveVector = cam.CFrame:VectorToObjectSpace(moveDir)
			local targetDir = (cam.CFrame.RightVector * moveVector.X) + (cam.CFrame.LookVector * -moveVector.Z)
			bodyVelocity.Velocity = targetDir.Unit * FlySpeed
		else
			bodyVelocity.Velocity = Vector3.new(0, 0, 0)
		end
		
		-- El personaje mirará hacia donde mire la cámara
		bodyGyro.CFrame = cam.CFrame
	end)
end

FlyToggleBtn.MouseButton1Click:Connect(function()
	if isFlying then
		stopFly()
	else
		startFly()
	end
end)

-- Lógica de los botones de velocidad
MinusBtn.MouseButton1Click:Connect(function()
	FlySpeed = math.max(10, FlySpeed - 10) -- Límite mínimo de 10
	SpeedLabel.Text = "Velocidad: " .. FlySpeed
end)

PlusBtn.MouseButton1Click:Connect(function()
	FlySpeed = FlySpeed + 10
	SpeedLabel.Text = "Velocidad: " .. FlySpeed
end)

-- Detener el vuelo si el jugador muere
player.CharacterAdded:Connect(function()
	if isFlying then stopFly() end
end)
