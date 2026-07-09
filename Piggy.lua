-- Piggy ESP Script

local RunService = game:GetService('RunService')
local Players = game:GetService('Players')
local Camera = game:GetService('Workspace').CurrentCamera

-- Function to create a box for ESP
local function createESP(player)
    local espBox = Instance.new('BoxHandleAdornment')
    espBox.Size = Vector3.new(2, 5, 2)
    espBox.Color3 = Color3.new(1, 0, 0)
    espBox.Transparency = 0.5
    espBox.AlwaysOnTop = true
    espBox.Adornee = player.Character.HumanoidRootPart
    espBox.Parent = player.Character.HumanoidRootPart
end

-- Function to enable ESP for all players
local function enableESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer and player.Character and player.Character:FindFirstChild('HumanoidRootPart') then
            createESP(player)
        end
    end
end

-- Run ESP every time a new player is added
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function() 
        createESP(player)
    end)
end)

-- Initial call to enable ESP for existing players
enableESP()

-- Heartbeat function to update ESP positions
RunService.Heartbeat:Connect(function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild('HumanoidRootPart') then
            local espBox = player.Character.HumanoidRootPart:FindFirstChildOfClass('BoxHandleAdornment')
            if espBox then
                espBox.Adornee = player.Character.HumanoidRootPart
            end
        end
    end
end)
