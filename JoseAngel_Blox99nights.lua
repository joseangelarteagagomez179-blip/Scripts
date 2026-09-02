-- FoxStyle Hub - Versión Simplificada (Sin errores)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local uiParent = game:GetService("CoreGui")
if uiParent:FindFirstChild("FoxStyleHub") then uiParent.FoxStyleHub:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "FoxStyleHub"
gui.Parent = uiParent

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 300, 0, 400)
frame.Position = UDim2.new(0.5, -150, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(10, 15, 30)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "🦊 FoxStyle Hub (Lite)"
title.TextColor3 = Color3.fromRGB(255, 170, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20

-- Botón Kill Aura
local btn1 = Instance.new("TextButton")
btn1.Parent = frame
btn1.Position = UDim2.new(0, 10, 0, 50)
btn1.Size = UDim2.new(1, -20, 0, 35)
btn1.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
btn1.Text = "Kill Aura: OFF"
btn1.TextColor3 = Color3.fromRGB(255, 255, 255)
btn1.Font = Enum.Font.SourceSansBold
btn1.TextSize = 14

local killAura = false
btn1.MouseButton1Click:Connect(function()
    killAura = not killAura
    btn1.Text = "Kill Aura: " .. (killAura and "ON" or "OFF")
    btn1.BackgroundColor3 = killAura and Color3.fromRGB(40, 180, 80) or Color3.fromRGB(180, 40, 40)
end)

-- Botón Fly
local btn2 = Instance.new("TextButton")
btn2.Parent = frame
btn2.Position = UDim2.new(0, 10, 0, 95)
btn2.Size = UDim2.new(1, -20, 0, 35)
btn2.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
btn2.Text = "Fly: OFF"
btn2.TextColor3 = Color3.fromRGB(255, 255, 255)
btn2.Font = Enum.Font.SourceSansBold
btn2.TextSize = 14

local flyEnabled = false
local bv, bg, conn
btn2.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    btn2.Text = "Fly: " .. (flyEnabled and "ON" or "OFF")
    btn2.BackgroundColor3 = flyEnabled and Color3.fromRGB(40, 180, 80) or Color3.fromRGB(180, 40, 40)
end)

-- Botón TP al Campamento
local btn3 = Instance.new("TextButton")
btn3.Parent = frame
btn3.Position = UDim2.new(0, 10, 0, 140)
btn3.Size = UDim2.new(1, -20, 0, 35)
btn3.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
btn3.Text = "TP al Campamento"
btn3.TextColor3 = Color3.fromRGB(255, 255, 255)
btn3.Font = Enum.Font.SourceSansBold
btn3.TextSize = 14

btn3.MouseButton1Click:Connect(function()
    pcall(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local rescue = workspace:FindFirstChild("RescueZone", true)
            if rescue then
                char.HumanoidRootPart.CFrame = rescue.CFrame + Vector3.new(0, 3, 0)
            end
        end
    end)
end)

-- Bucle Kill Aura
task.spawn(function()
    while task.wait(0.1) do
        if killAura then
            pcall(function()
                local char = LocalPlayer.Character
                if not char then return end
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                for _, v in ipairs(workspace:GetDescendants()) do
                    if v:IsA("Model") and v ~= char then
                        local enemyHrp = v:FindFirstChild("HumanoidRootPart")
                        local enemyHum = v:FindFirstChild("Humanoid")
                        if enemyHrp and enemyHum and enemyHum.Health > 0 then
                            if not Players:GetPlayerFromCharacter(v) then
                                if (enemyHrp.Position - hrp.Position).Magnitude <= 25 then
                                    local tool = char:FindFirstChildOfClass("Tool")
                                    if tool then tool:Activate() end
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- Bucle Fly
task.spawn(function()
    while task.wait(0.1) do
        if flyEnabled then
            local char = LocalPlayer.Character
            if not char then continue end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then continue end
            if not bv then
                bv = Instance.new("BodyVelocity")
                bg = Instance.new("BodyGyro")
                bv.Parent = hrp
                bg.Parent = hrp
                bv.MaxForce = Vector3.new(4000, 4000, 4000)
                bg.MaxTorque = Vector3.new(4000, 4000, 4000)
                conn = RunService.Heartbeat:Connect(function()
                    if not flyEnabled then
                        bv:Destroy(); bg:Destroy(); conn:Disconnect()
                        bv = nil; bg = nil; conn = nil
                        return
                    end
                    local mv = Vector3.new(0, 0, 0)
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then mv = mv + Vector3.new(0, 0, -50) end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then mv = mv + Vector3.new(0, 0, 50) end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then mv = mv + Vector3.new(-50, 0, 0) end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then mv = mv + Vector3.new(50, 0, 0) end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then mv = mv + Vector3.new(0, 50, 0) end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then mv = mv + Vector3.new(0, -50, 0) end
                    bv.Velocity = hrp.CFrame:VectorToWorldSpace(mv)
                    bg.CFrame = hrp.CFrame
                end)
            end
        else
            if bv then bv:Destroy(); bg:Destroy(); conn:Disconnect() end
            bv = nil; bg = nil; conn = nil
        end
    end
end)

print("✅ FoxStyle Hub Lite cargado!")
