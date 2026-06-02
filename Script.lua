--[[
    SCRIPT CREADO POR: JOSEANGEL_BLOX
    JUEGO: KICK A LUCKY BLOCK (89469502395769)
    FECHA: 01/06/2026
--]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualInput = game:GetService("VirtualInputManager")
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local walkSpeedValue = 50
local flySpeedValue = 80
local invisible = false
local fpsBoost = false
local autoFarmActive = false
local autoClickActive = false
local autoCollectActive = false
local flying = false
local bodyVelocity = nil

function notify(text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "JOSEANGEL_BLOX | KICK LUCKY",
        Text = text,
        Duration = 2
    })
end

function optimizeGame()
    if fpsBoost then
        settings().Rendering.QualityLevel = 1
        game:GetService("Workspace").StreamingEnabled = true
        game:GetService("Lighting").GlobalShadows = false
        game:GetService("Lighting").Technology = Enum.Technology.Compatibility
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
                v.Enabled = false
            end
        end
        notify("Optimizacion activada")
    else
        settings().Rendering.QualityLevel = 10
    end
end

function startAutoFarm()
    while autoFarmActive and task.wait(0.3) do
        local luckyBlock = nil
        local distancia = 20
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and (obj.Name:lower():find("lucky") or obj.Name:lower():find("block")) then
                local blockPart = obj:FindFirstChild("Handle") or obj:FindFirstChild("Part") or obj:FindFirstChildWhichIsA("BasePart")
                if blockPart and rootPart then
                    local dist = (rootPart.Position - blockPart.Position).Magnitude
                    if dist < distancia then
                        distancia = dist
                        luckyBlock = blockPart
                    end
                end
            end
        end
        if luckyBlock then
            rootPart.CFrame = CFrame.new(rootPart.Position, luckyBlock.Position)
            task.wait(0.1)
            VirtualInput:SendKeyEvent(true, Enum.KeyCode.E, false, game)
            task.wait(0.1)
            VirtualInput:SendKeyEvent(false, Enum.KeyCode.E, false, game)
            notify("Pateando Lucky Block...")
            task.wait(0.5)
        else
            task.wait(1)
        end
    end
end

function startAutoClick()
    while autoClickActive and task.wait(0.1) do
        mouse1press()
        task.wait(0.05)
        mouse1release()
    end
end

function startAutoCollect()
    while autoCollectActive and task.wait(0.2) do
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Parent ~= character then
                local name = obj.Name:lower()
                if name:find("coin") or name:find("money") or name:find("cash") or name:find("gem") or name:find("diamond") or name:find("drop") then
                    if rootPart and obj.Position then
                        rootPart.CFrame = CFrame.new(obj.Position + Vector3.new(0,2,0))
                        task.wait(0.05)
                    end
                end
            end
        end
        task.wait(0.5)
    end
end

function startFly()
    if flying then
        if bodyVelocity then bodyVelocity:Destroy() end
        flying = false
        if humanoid then humanoid.PlatformStand = false end
        notify("Vuelo desactivado")
    else
        flying = true
        if humanoid then humanoid.PlatformStand = true end
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(1e5,1e5,1e5)
        bodyVelocity.Velocity = Vector3.new(0, flySpeedValue, 0)
        bodyVelocity.Parent = rootPart
        RunService.RenderStepped:Connect(function()
            if flying and bodyVelocity and rootPart then
                local move = Vector3.new()
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + Vector3.new(0,0,-flySpeedValue) end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move + Vector3.new(0,0,flySpeedValue) end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move + Vector3.new(-flySpeedValue,0,0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + Vector3.new(flySpeedValue,0,0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,flySpeedValue,0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move = move + Vector3.new(0,-flySpeedValue,0) end
                bodyVelocity.Velocity = move
            end
        end)
        notify("Vuelo activado | Velocidad: " .. flySpeedValue)
    end
end

function setWalkSpeed(speed)
    if humanoid then
        humanoid.WalkSpeed = speed
        notify("Velocidad cambiada a: " .. speed)
    end
end

function setInvisible(state)
    if state then
        for _, v in pairs(character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Transparency = 1
            end
        end
        notify("Invisible activado")
    else
        for _, v in pairs(character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Transparency = 0
            end
        end
        notify("Invisible desactivado")
    end
end

local fpsLabel = nil
function toggleFPS()
    fpsBoost = not fpsBoost
    if fpsBoost then
        if not fpsLabel then
            fpsLabel = Instance.new("TextLabel")
            fpsLabel.Size = UDim2.new(0, 80, 0, 30)
            fpsLabel.Position = UDim2.new(1, -90, 0, 10)
            fpsLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
            fpsLabel.BackgroundTransparency = 0.5
            fpsLabel.TextColor3 = Color3.fromRGB(0,255,0)
            fpsLabel.Font = Enum.Font.Code
            fpsLabel.Parent = player.PlayerGui
        end
        fpsLabel.Visible = true
        RunService.RenderStepped:Connect(function()
            if fpsBoost and fpsLabel then
                local fps = math.floor(1 / task.wait())
                fpsLabel.Text = "FPS: " .. fps
            end
        end)
    else
        if fpsLabel then fpsLabel.Visible = false end
    end
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "JoseAngelKickLucky"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 450, 0, 550)
frame.Position = UDim2.new(0.5, -225, 0.5, -275)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.15
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local hackerBg = Instance.new("Frame")
hackerBg.Size = UDim2.new(1, 0, 1, 0)
hackerBg.BackgroundColor3 = Color3.fromRGB(0, 10, 0)
hackerBg.BackgroundTransparency = 0.3
hackerBg.Parent = frame

for i = 1, 15 do
    local line = Instance.new("TextLabel")
    line.Size = UDim2.new(1, 0, 0, 25)
    line.Position = UDim2.new(0, 0, 0, i * 35)
    line.BackgroundTransparency = 1
    line.TextColor3 = Color3.fromRGB(0, 255, 0)
    line.Text = "> KICK LUCKY BLOCK " .. string.rep("01001001 00100000 01101100 01101111 01110110 01100101", 2)
    line.TextXAlignment = Enum.TextXAlignment.Left
    line.Font = Enum.Font.Code
    line.TextSize = 12
    line.Parent = hackerBg
end

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundColor3 = Color3.fromRGB(0, 50, 0)
title.Text = "JOSEANGEL_BLOX | KICK LUCKY"
title.TextColor3 = Color3.fromRGB(0, 255, 0)
title.Font = Enum.Font.Code
title.TextSize = 18
title.Parent = frame

local tabs = {}
local function createTab(name)
    local tab = Instance.new("ScrollingFrame")
    tab.Size = UDim2.new(1, -10, 1, -60)
    tab.Position = UDim2.new(0, 5, 0, 50)
    tab.BackgroundColor3 = Color3.fromRGB(0,0,0)
    tab.BackgroundTransparency = 0.4
    tab.BorderSizePixel = 0
    tab.Visible = false
    tab.Parent = frame
    tabs[name] = tab
    return tab
end

local infoTab = createTab("INFO")
local mainTab = createTab("MAIN")
local playerTab = createTab("PLAYER")
local configTab = createTab("CONFIG")

local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, 0, 0, 120)
infoLabel.Position = UDim2.new(0, 0, 0, 20)
infoLabel.BackgroundTransparency = 1
infoLabel.Text = "◤ CREADOR: JOSEANGEL_BLOX\n◤ FECHA: 01/06/2026\n◤ JUEGO: KICK A LUCKY BLOCK\n◤ ID: 89469502395769\n◤ VERSION: HACKER EDITION"
infoLabel.TextColor3 = Color3.fromRGB(0,255,0)
infoLabel.Font = Enum.Font.Code
infoLabel.TextSize = 14
infoLabel.TextXAlignment = Enum.TextXAlignment.Left
infoLabel.Parent = infoTab

local autoFarmBtn = Instance.new("TextButton")
autoFarmBtn.Size = UDim2.new(0, 200, 0, 40)
autoFarmBtn.Position = UDim2.new(0, 10, 0, 10)
autoFarmBtn.Text = "🤖 AUTO FARM: OFF"
autoFarmBtn.BackgroundColor3 = Color3.fromRGB(0,80,0)
autoFarmBtn.TextColor3 = Color3.fromRGB(0,255,0)
autoFarmBtn.Parent = mainTab
autoFarmBtn.MouseButton1Click:Connect(function()
    autoFarmActive = not autoFarmActive
    autoFarmBtn.Text = autoFarmActive and "🤖 AUTO FARM: ON" or "🤖 AUTO FARM: OFF"
    if autoFarmActive then startAutoFarm() end
end)

local autoClickBtn = Instance.new("TextButton")
autoClickBtn.Size = UDim2.new(0, 200, 0, 40)
autoClickBtn.Position = UDim2.new(0, 10, 0, 60)
autoClickBtn.Text = "🖱️ AUTO CLICK X2: OFF"
autoClickBtn.Parent = mainTab
autoClickBtn.MouseButton1Click:Connect(function()
    autoClickActive = not autoClickActive
    autoClickBtn.Text = autoClickActive and "🖱️ AUTO CLICK X2: ON" or "🖱️ AUTO CLICK X2: OFF"
    if autoClickActive then startAutoClick() end
end)

local autoCollectBtn = Instance.new("TextButton")
autoCollectBtn.Size = UDim2.new(0, 200, 0, 40)
autoCollectBtn.Position = UDim2.new(0, 10, 0, 110)
autoCollectBtn.Text = "💰 AUTO COLLECT: OFF"
autoCollectBtn.Parent = mainTab
autoCollectBtn.MouseButton1Click:Connect(function()
    autoCollectActive = not autoCollectActive
    autoCollectBtn.Text = autoCollectActive and "💰 AUTO COLLECT: ON" or "💰 AUTO COLLECT: OFF"
    if autoCollectActive then startAutoCollect() end
end)

local walkSpeedSlider = Instance.new("TextBox")
walkSpeedSlider.Size = UDim2.new(0, 200, 0, 40)
walkSpeedSlider.Position = UDim2.new(0, 10, 0, 160)
walkSpeedSlider.PlaceholderText = "Velocidad personalizable"
walkSpeedSlider.Text = "50"
walkSpeedSlider.BackgroundColor3 = Color3.fromRGB(0,50,0)
walkSpeedSlider.TextColor3 = Color3.fromRGB(0,255,0)
walkSpeedSlider.Parent = mainTab
walkSpeedSlider.FocusLost:Connect(function()
    local speed = tonumber(walkSpeedSlider.Text)
    if speed then
        walkSpeedValue = speed
        setWalkSpeed(speed)
    end
end)

local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(0, 200, 0, 40)
flyBtn.Position = UDim2.new(0, 10, 0, 10)
flyBtn.Text = "🕊️ FLY: OFF"
flyBtn.Parent = playerTab
flyBtn.MouseButton1Click:Connect(function()
    startFly()
    flyBtn.Text = flying and "🕊️ FLY: ON" or "🕊️ FLY: OFF"
end)

local flySpeedBox = Instance.new("TextBox")
flySpeedBox.Size = UDim2.new(0, 200, 0, 40)
flySpeedBox.Position = UDim2.new(0, 10, 0, 60)
flySpeedBox.PlaceholderText = "Velocidad de vuelo"
flySpeedBox.Text = "80"
flySpeedBox.Parent = playerTab
flySpeedBox.FocusLost:Connect(function()
    flySpeedValue = tonumber(flySpeedBox.Text) or 80
end)

local walkBox = Instance.new("TextBox")
walkBox.Size = UDim2.new(0, 200, 0, 40)
walkBox.Position = UDim2.new(0, 10, 0, 110)
walkBox.PlaceholderText = "WalkSpeed infinito"
walkBox.Text = "50"
walkBox.Parent = playerTab
walkBox.FocusLost:Connect(function()
    local sp = tonumber(walkBox.Text) or 50
    setWalkSpeed(sp)
end)

local invisibleBtn = Instance.new("TextButton")
invisibleBtn.Size = UDim2.new(0, 200, 0, 40)
invisibleBtn.Position = UDim2.new(0, 10, 0, 160)
invisibleBtn.Text = "👻 INVISIBLE: OFF"
invisibleBtn.Parent = playerTab
invisibleBtn.MouseButton1Click:Connect(function()
    invisible = not invisible
    setInvisible(invisible)
    invisibleBtn.Text = invisible and "👻 INVISIBLE: ON" or "👻 INVISIBLE: OFF"
end)

local fpsBtn = Instance.new("TextButton")
fpsBtn.Size = UDim2.new(0, 200, 0, 40)
fpsBtn.Position = UDim2.new(0, 10, 0, 10)
fpsBtn.Text = "📊 FPS BOOST: OFF"
fpsBtn.Parent = configTab
fpsBtn.MouseButton1Click:Connect(function()
    toggleFPS()
    fpsBtn.Text = fpsBoost and "📊 FPS BOOST: ON" or "📊 FPS BOOST: OFF"
end)

local optimizeBtn = Instance.new("TextButton")
optimizeBtn.Size = UDim2.new(0, 200, 0, 40)
optimizeBtn.Position = UDim2.new(0, 10, 0, 60)
optimizeBtn.Text = "⚡ OPTIMIZAR (NO LAG)"
optimizeBtn.Parent = configTab
optimizeBtn.MouseButton1Click:Connect(function()
    fpsBoost = true
    optimizeGame()
end)

local navNames = {"INFO", "MAIN", "PLAYER", "CONFIG"}
local startX = 5
for i, name in ipairs(navNames) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 105, 0, 35)
    btn.Position = UDim2.new(0, startX + (i-1)*110, 0, 5)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(0,100,0)
    btn.TextColor3 = Color3.fromRGB(0,255,0)
    btn.Font = Enum.Font.Code
    btn.Parent = frame
    btn.MouseButton1Click:Connect(function()
        for _, tab in pairs(tabs) do tab.Visible = false end
        tabs[name].Visible = true
    end)
end

infoTab.Visible = true
notify("✅ SCRIPT CARGADO | AUTO CLICK X2 ACTIVABLE")
