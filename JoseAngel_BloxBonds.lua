if game.PlaceId ~= 116495829188952 then
    return warn("[JoseAngel_Blox Bonds]: Este script solo funciona en Dead Rails.")
end

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

if pgui:FindFirstChild("JoseAngel_UI") then
    pgui.JoseAngel_UI:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "JoseAngel_UI"
gui.ResetOnSpawn = false
gui.Parent = pgui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 200)
frame.Position = UDim2.new(0.5, -100, 0.4, -100)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(40, 40, 48)
stroke.Thickness = 1.5
stroke.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundTransparency = 1
title.Text = "JoseAngel_Blox Bonds"
title.TextColor3 = Color3.fromRGB(255, 45, 45)
title.TextSize = 14
title.Font = Enum.Font.GothamBold
title.Parent = frame

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 165, 0, 42)
btn.Position = UDim2.new(0.5, -82, 0.55, -21)
btn.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
btn.Text = "💰 Auto-Bonds Farm: OFF"
btn.TextColor3 = Color3.fromRGB(200, 200, 200)
btn.TextSize = 11
btn.Font = Enum.Font.GothamMedium
btn.Parent = frame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 10)
btnCorner.Parent = btn

local farming = false

btn.MouseButton1Click:Connect(function()
    farming = not farming
    if farming then
        btn.Text = "💰 Auto-Bonds Farm: ON"
        btn.TextColor3 = Color3.fromRGB(60, 230, 130)
        btn.BackgroundColor3 = Color3.fromRGB(25, 45, 32)
    else
        btn.Text = "💰 Auto-Bonds Farm: OFF"
        btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        btn.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
    end
end)

task.spawn(function()
    while true do
        task.wait(0.5)
        if farming then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if not farming then break end
                if obj:IsA("ProximityPrompt") and (obj.ObjectText:lower():find("bond") or obj.ActionText:lower():find("bond") or obj.Parent.Name:lower():find("bond")) then
                    fireproximityprompt(obj)
                end
            end
        end
    end
end)
