-- Script: JoseAngel_Blox Bonds
-- Autor: JoseAngel_Blox
-- Fecha: 20/08/2026

-- Servicios
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local jugador = Players.LocalPlayer

-- Crear GUI principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "JoseAngel_Blox_GUI"
screenGui.Parent = game.CoreGui

-- Marco principal con esquinas redondeadas
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 500, 0, 350)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.BackgroundTransparency = 0.2
mainFrame.ZIndex = 10
mainFrame.Parent = screenGui

-- CornerRadius para esquinas redondeadas
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

-- Título del script
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 10)
title.Text = "JoseAngel_Blox Bonds"
title.TextColor3 = Color3.fromRGB(255, 0, 0) -- Rojo
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.BackgroundTransparency = 1
title.ZIndex = 10
title.Parent = mainFrame

-- Texto transparente debajo del título
local creatorText = Instance.new("TextLabel")
creatorText.Size = UDim2.new(1, 0, 0, 20)
creatorText.Position = UDim2.new(0, 0, 0, 50)
creatorText.Text = "Creado por JoseAngel_Blox"
creatorText.TextTransparency = 0.5
creatorText.TextColor3 = Color3.fromRGB(255, 255, 255)
creatorText.Font = Enum.Font.Gotham
creatorText.TextScaled = true
creatorText.BackgroundTransparency = 1
creatorText.ZIndex = 10
creatorText.Parent = mainFrame

-- Contenedor de pestañas
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(0, 120, 1, -80)
tabContainer.Position = UDim2.new(0, 10, 0, 80)
tabContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
tabContainer.BorderSizePixel = 0
tabContainer.ZIndex = 10
tabContainer.Parent = mainFrame

-- Botón Info
local infoButton = Instance.new("TextButton")
infoButton.Size = UDim2.new(1, 0, 0, 40)
infoButton.Position = UDim2.new(0, 0, 0, 0)
infoButton.Text = "Info"
infoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
infoButton.Font = Enum.Font.Gotham
infoButton.BackgroundTransparency = 0.5
infoButton.ZIndex = 10
infoButton.Parent = tabContainer

-- Botón Auto Farm
local autoFarmButton = Instance.new("TextButton")
autoFarmButton.Size = UDim2.new(1, 0, 0, 40)
autoFarmButton.Position = UDim2.new(0, 0, 0, 50)
autoFarmButton.Text = "Auto Farm Bonds"
autoFarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
autoFarmButton.Font = Enum.Font.Gotham
autoFarmButton.BackgroundTransparency = 0.5
autoFarmButton.ZIndex = 10
autoFarmButton.Parent = tabContainer

-- Contenido de las pestañas
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -140, 1, -80)
contentFrame.Position = UDim2.new(0, 140, 0, 80)
contentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
contentFrame.BorderSizePixel = 0
contentFrame.ZIndex = 10
contentFrame.Parent = mainFrame

-- Contenido Info
local infoContent = Instance.new("ScrollingFrame")
infoContent.Size = UDim2.new(1, 0, 1, 0)
infoContent.BackgroundTransparency = 1
infoContent.ScrollBarThickness = 5
infoContent.ZIndex = 10
infoContent.Parent = contentFrame

local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, -20, 0, 20)
infoLabel.Position = UDim2.new(0, 10, 0, 10)
infoLabel.Text = "Nombre del Creador: JoseAngel_Blox"
infoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
infoLabel.Font = Enum.Font.Gotham
infoLabel.TextScaled = true
infoLabel.BackgroundTransparency = 1
infoLabel.ZIndex = 10
infoLabel.Parent = infoContent

local releaseDate = infoLabel:Clone()
releaseDate.Text = "Fecha de lanzamiento: 20/08/2026"
releaseDate.Position = UDim2.new(0, 10, 0, 40)
releaseDate.Parent = infoContent

local version = infoLabel:Clone()
version.Text = "Versión: 1.1"
version.Position = UDim2.new(0, 10, 0, 70)
version.Parent = infoContent

local update = infoLabel:Clone()
update.Text = "Update: Bienvenidos y bienvenidas a mi Script. Este script es nuevo, rápido, sin bugs, con mayor compatibilidad. Espero y disfrutes del script. Atentamente, JoseAngel_Blox."
update.Size = UDim2.new(1, -20, 0, 60)
update.Position = UDim2.new(0, 10, 0, 100)
update.TextWrapped = true
update.Parent = infoContent

-- Botones de Like y Dislike
local likeButton = Instance.new("TextButton")
likeButton.Size = UDim2.new(0, 80, 0, 30)
likeButton.Position = UDim2.new(0, 10, 0, 170)
likeButton.Text = "👍 Like"
likeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
likeButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
likeButton.Font = Enum.Font.Gotham
likeButton.ZIndex = 10
likeButton.Parent = infoContent

local dislikeButton = Instance.new("TextButton")
dislikeButton.Size = UDim2.new(0, 80, 0, 30)
dislikeButton.Position = UDim2.new(0, 100, 0, 170)
dislikeButton.Text = "👎 Dislike"
dislikeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
dislikeButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
dislikeButton.Font = Enum.Font.Gotham
dislikeButton.ZIndex = 10
dislikeButton.Parent = infoContent

-- Contador de Likes y Dislikes
local likeCount = Instance.new("TextLabel")
likeCount.Size = UDim2.new(0, 100, 0, 20)
likeCount.Position = UDim2.new(0, 10, 0, 210)
likeCount.Text = "Likes: 0"
likeCount.TextColor3 = Color3.fromRGB(0, 255, 0)
likeCount.Font = Enum.Font.Gotham
likeCount.TextScaled = true
likeCount.BackgroundTransparency = 1
likeCount.ZIndex = 10
likeCount.Parent = infoContent

local dislikeCount = Instance.new("TextLabel")
dislikeCount.Size = UDim2.new(0, 100, 0, 20)
dislikeCount.Position = UDim2.new(0, 10, 0, 240)
dislikeCount.Text = "Dislikes: 0"
dislikeCount.TextColor3 = Color3.fromRGB(255, 0, 0)
dislikeCount.Font = Enum.Font.Gotham
dislikeCount.TextScaled = true
dislikeCount.BackgroundTransparency = 1
dislikeCount.ZIndex = 10
dislikeCount.Parent = infoContent

-- Contenido Auto Farm
local autoFarmContent = Instance.new("Frame")
autoFarmContent.Size = UDim2.new(1, 0, 1, 0)
autoFarmContent.BackgroundTransparency = 1
autoFarmContent.Visible = false
autoFarmContent.ZIndex = 10
autoFarmContent.Parent = contentFrame

local toggleLabel = Instance.new("TextLabel")
toggleLabel.Size = UDim2.new(1, -20, 0, 20)
toggleLabel.Position = UDim2.new(0, 10, 0, 10)
toggleLabel.Text = "Auto Farm Bonds:"
toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleLabel.Font = Enum.Font.Gotham
toggleLabel.TextScaled = true
toggleLabel.BackgroundTransparency = 1
toggleLabel.ZIndex = 10
toggleLabel.Parent = autoFarmContent

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 60, 0, 30)
toggleButton.Position = UDim2.new(0, 10, 0, 40)
toggleButton.Text = "OFF"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
toggleButton.Font = Enum.Font.Gotham
toggleButton.ZIndex = 10
toggleButton.Parent = autoFarmContent

-- Variables para control
local likes = 0
local dislikes = 0
local hasVoted = false

-- Eventos de Like/Dislike
likeButton.MouseButton1Click:Connect(function()
    if not hasVoted then
        likes = likes + 1
        likeCount.Text = "Likes: " .. likes
        hasVoted = true
    end
end)

dislikeButton.MouseButton1Click:Connect(function()
    if not hasVoted then
        dislikes = dislikes + 1
        dislikeCount.Text = "Dislikes: " .. dislikes
        hasVoted = true
    end
end)

-- Control de pestañas
infoButton.MouseButton1Click:Connect(function()
    infoContent.Visible = true
    autoFarmContent.Visible = false
end)

autoFarmButton.MouseButton1Click:Connect(function()
    infoContent.Visible = false
    autoFarmContent.Visible = true
end)

-- Toggle de Auto Farm
local isToggled = false
toggleButton.MouseButton1Click:Connect(function()
    isToggled = not isToggled
    if isToggled then
        toggleButton.Text = "ON"
        toggleButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        -- Aquí va la lógica de Auto Farm Bonds
        spawn(function()
            while isToggled do
                task.wait(1) -- Ajusta según necesites
                -- Lógica para recoger bonos
                print("🔍 Recogiendo bonos automáticamente...")
            end
        end)
    else
        toggleButton.Text = "OFF"
        toggleButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    end
end)

print("🔧 GUI de JoseAngel_Blox Bonds cargada.")
