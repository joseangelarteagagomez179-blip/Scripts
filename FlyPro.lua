-- ==========================================
-- Script: Fly Utility
-- Creador: JoseAngel_Blox
-- Estilo: Minimalista / Moderno
-- ==========================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

-- GUI Principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ScriptMenu"
ScreenGui.ResetOnSpawn = false
local success = pcall(function() ScreenGui.Parent = CoreGui end)
if not success then ScreenGui.Parent = player:WaitForChild("PlayerGui") end

-- Frame Principal (Más pequeño y elegante)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 160)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -80)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35) -- Gris oscuro
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local MainUICorner = Instance.new("UICorner", MainFrame)
MainUICorner.CornerRadius = UDim.new(0, 10)

-- Título
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "Fly Utility | JoseAngel_Blox"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14

-- Pestañas
local InfoBtn = Instance.new("TextButton", MainFrame)
InfoBtn.Size = UDim2.new(0.45, 0, 0, 25)
InfoBtn.Position = UDim2.new(0.03, 0, 0.25, 0)
InfoBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
InfoBtn.Text = "Info"
InfoBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", InfoBtn).CornerRadius = UDim.new(0, 5)

local MainBtn = Instance.new("TextButton", MainFrame)
MainBtn.Size = UDim2.new(0.45, 0, 0, 25)
MainBtn.Position = UDim2.new(0.52, 0, 0.25, 0)
MainBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
MainBtn.Text = "Main"
MainBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", MainBtn).CornerRadius = UDim.new(0, 5)

-- Contenedores
local InfoPanel = Instance.new("Frame", MainFrame)
InfoPanel.Size = UDim2.new(1, -20, 1, -80)
InfoPanel.Position = UDim2.new(0, 10, 0, 70)
InfoPanel.BackgroundTransparency = 1

local MainPanel = Instance.new("Frame", MainFrame)
MainPanel.Size = UDim2.new(1, -20, 1, -80)
MainPanel.Position = UDim2.new(0, 10, 0, 70)
MainPanel.BackgroundTransparency = 1
MainPanel.Visible = false

-- Info Content
local InfoText = Instance.new("TextLabel", InfoPanel)
InfoText.Size = UDim2.new(1, 0, 1, 0)
InfoText.BackgroundTransparency = 1
InfoText.Text = "Creador: JoseAngel_Blox\nFecha: 14/07/2026\nVersión: 1.2"
InfoText.TextColor3 = Color3.fromRGB(200, 200, 200)
InfoText.TextSize = 12
InfoText.TextXAlignment = Enum.TextXAlignment.Left

-- Main Content (Fly)
local FlySpeed = 50
local isFlying = false
local flyLoop, bodyVelocity, bodyGyro

local FlyBtn = Instance.new("TextButton", MainPanel)
FlyBtn.Size = UDim2.new(1, 0, 0, 30)
FlyBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
FlyBtn.Text = "Fly: OFF"
FlyBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", FlyBtn).CornerRadius = UDim.new(0, 5)

local SpeedFrame = Instance.new("Frame", MainPanel)
SpeedFrame.Size = UDim2.new(1, 0, 0, 30)
SpeedFrame.Position = UDim2.new(0, 0, 0, 40)
SpeedFrame.BackgroundTransparency = 1

local MinusBtn = Instance.new("TextButton", SpeedFrame)
MinusBtn.Size = UDim2.new(0.3, 0, 1, 0)
MinusBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinusBtn.Text = "-"
MinusBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", MinusBtn).CornerRadius = UDim.new(0, 5)

local SpeedLabel = Instance.new("TextLabel", SpeedFrame)
SpeedLabel.Size = UDim2.new(0.4, 0, 1, 0)
SpeedLabel.Position = UDim2.new(0.3, 0, 0, 0)
SpeedLabel.Text = "Speed: " .. FlySpeed
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.TextColor3 = Color3.new(1, 1, 1)

local PlusBtn = Instance.new("TextButton", SpeedFrame)
PlusBtn.Size = UDim2.new(0.3, 0, 1, 0)
PlusBtn.Position = UDim2.new(0.7, 0, 0, 0)
PlusBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
PlusBtn.Text = "+"
PlusBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", PlusBtn).CornerRadius = UDim.new(0, 5)

-- Lógica
InfoBtn.MouseButton1Click:Connect(function()
	InfoPanel.Visible = true; MainPanel.Visible = false
	InfoBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	MainBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
end)

MainBtn.MouseButton1Click:Connect(function()
	InfoPanel.Visible = false; MainPanel.Visible = true
	MainBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	InfoBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
end)

local function startFly()
	local char = player.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end
	isFlying = true
	FlyBtn.Text = "Fly: ON"
	FlyBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
	char.Humanoid.PlatformStand = true
	bodyVelocity = Instance.new("BodyVelocity", char.HumanoidRootPart)
	bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	bodyVelocity.Velocity = Vector3.zero
	bodyGyro = Instance.new("BodyGyro", char.HumanoidRootPart)
	bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
	bodyGyro.P = 10000
	flyLoop = RunService.RenderStepped:Connect(function()
		local cam = workspace.CurrentCamera
		local moveDir = player.Character.Humanoid.MoveDirection
		if moveDir.Magnitude > 0 then
			local vec = cam.CFrame:VectorToObjectSpace(moveDir)
			bodyVelocity.Velocity = ((cam.CFrame.RightVector * vec.X) + (cam.CFrame.LookVector * -vec.Z)).Unit * FlySpeed
		else
			bodyVelocity.Velocity = Vector3.zero
		end
		bodyGyro.CFrame = cam.CFrame
	end)
end

local function stopFly()
	isFlying = false
	FlyBtn.Text = "Fly: OFF"
	FlyBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
	if flyLoop then flyLoop:Disconnect() end
	if bodyVelocity then bodyVelocity:Destroy() end
	if bodyGyro then bodyGyro:Destroy() end
	if player.Character then player.Character.Humanoid.PlatformStand = false end
end

FlyBtn.MouseButton1Click:Connect(function() if isFlying then stopFly() else startFly() end end)
MinusBtn.MouseButton1Click:Connect(function() FlySpeed = math.max(10, FlySpeed - 10); SpeedLabel.Text = "Speed: " .. FlySpeed end)
PlusBtn.MouseButton1Click:Connect(function() FlySpeed = FlySpeed + 10; SpeedLabel.Text = "Speed: " .. FlySpeed end)

-- Arrastrar GUI
local dragging, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true; dragStart = input.Position; startPos = MainFrame.Position
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)
UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
