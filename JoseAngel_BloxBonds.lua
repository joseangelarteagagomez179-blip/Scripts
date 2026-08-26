-- ============================================
--   JoseAngel_Blox Bonds
--   Creado por JoseAngel_Blox
--   Auto Farm Bonds para Dead Rails
-- ============================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")

-- ============================================
--   VARIABLES
-- ============================================
local Cooldown = 0.1
local TrackCount = 1
local BondCount = 0
local TrackPassed = false
local FoundLobby = false
local Farming = false

-- ============================================
--   GUI
-- ============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngelGui"
ScreenGui.Parent = gethui() or game:GetService("CoreGui")

-- Fondo principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 250, 0, 180)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -90)
MainFrame.BackgroundColor3 = Color3.fromRGB(180, 0, 0) -- Rojo oscuro
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Redondear bordes
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Título (nombre rojo brillante)
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Position = UDim2.new(0, 0, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "JoseAngel_Blox Bonds"
Title.TextColor3 = Color3.fromRGB(255, 0, 0) -- Rojo brillante
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- Línea separadora
local Line = Instance.new("Frame")
Line.Size = UDim2.new(0.8, 0, 0, 2)
Line.Position = UDim2.new(0.1, 0, 0, 42)
Line.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
Line.Parent = MainFrame

-- Subtítulo "Creado por JoseAngel_Blox"
local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, 0, 0, 20)
SubTitle.Position = UDim2.new(0, 0, 0, 48)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Creado por JoseAngel_Blox"
SubTitle.TextColor3 = Color3.fromRGB(255, 200, 200)
SubTitle.TextScaled = true
SubTitle.Font = Enum.Font.Gotham
SubTitle.Parent = MainFrame

-- Botón: Auto Farm Bonds
local FarmButton = Instance.new("TextButton")
FarmButton.Size = UDim2.new(0.8, 0, 0, 40)
FarmButton.Position = UDim2.new(0.1, 0, 0, 80)
FarmButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
FarmButton.Text = "Auto Farm Bonds"
FarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmButton.TextScaled = true
FarmButton.Font = Enum.Font.GothamBold
FarmButton.Parent = MainFrame

-- Redondear botón
local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 5)
ButtonCorner.Parent = FarmButton

-- Estado del farm
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Position = UDim2.new(0, 0, 0, 130)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "❌ Inactivo"
StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
StatusLabel.TextScaled = true
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Parent = MainFrame

-- Contador de Bonds
local BondCounter = Instance.new("TextLabel")
BondCounter.Size = UDim2.new(1, 0, 0, 20)
BondCounter.Position = UDim2.new(0, 0, 0, 152)
BondCounter.BackgroundTransparency = 1
BondCounter.Text = "Bonds: 0"
BondCounter.TextColor3 = Color3.fromRGB(255, 255, 255)
BondCounter.TextScaled = true
BondCounter.Font = Enum.Font.Gotham
BondCounter.Parent = MainFrame

-- ============================================
--   FUNCIÓN AUTO FARM BONDS
-- ============================================
local function AutoFarmBonds()
    if Farming then
        Farming = false
        StatusLabel.Text = "❌ Inactivo"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        FarmButton.Text = "Auto Farm Bonds"
        print("Auto Farm desactivado")
        return
    end
    
    Farming = true
    StatusLabel.Text = "✅ Activo"
    StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    FarmButton.Text = "⏹ Detener"
    print("Auto Farm iniciado")
    
    -- Resetear variables
    TrackCount = 1
    BondCount = 0
    TrackPassed = false
    FoundLobby = false
    
    -- Obtener referencias
    local HPP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not HPP then
        print("Esperando personaje...")
        LocalPlayer.CharacterAdded:Wait()
        HPP = LocalPlayer.Character.HumanoidRootPart
    end
    
    local CreateParty = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("CreatePartyClient")
    
    -- Iniciar loop principal
    spawn(function()
        while Farming do
            task.wait(Cooldown)
            
            -- ============================================
            --   CÓDIGO DE LA IMAGEN 1: FIND LOBBY
            -- ============================================
            if game.PlaceId == 116495829189052 then
                if not FoundLobby then
                    print("Buscando lobby...")
                    for i, v in pairs(Workspace.TeleportZones:GetChildren()) do
                        if v.Name == "TeleportZone" and v.BillboardGui.StateLabel.Text == "Waiting for players..." then
                            print("¡Lobby encontrado!")
                            HPP.CFrame = v.ZoneContainer.CFrame
                            FoundLobby = true
                            task.wait(1)
                            CreateParty:FireServer({["maxPlayers"] = 1})
                        end
                    end
                end
            
            -- ============================================
            --   CÓDIGO DE LA IMAGEN 2: RECOLECTAR BONDS
            -- ============================================
            elseif game.PlaceId == 70876832253163 then
                local StartingTrack = Workspace.RailSegments:FindFirstChild("RailSegment")
                local CollectBond = ReplicatedStorage:FindFirstChild("Packages") and ReplicatedStorage.Packages:FindFirstChild("ActivatedObjectClient")
                local Items = Workspace.RuntimeItems
                
                if not CollectBond then
                    CollectBond = ReplicatedStorage:FindFirstChild("Packages"):FindFirstChild("ActivatedObjectClient")
                end
                
                HPP.Anchored = true
                
                if not TrackPassed then
                    print("Teleportando al track", TrackCount)
                    TrackPassed = true
                end
                
                HPP.CFrame = StartingTrack.Guide.CFrame + Vector3.new(0, 250, 0)
                
                if StartingTrack.NextTrack.Value ~= nil then
                    StartingTrack = StartingTrack.NextTrack.Value
                    TrackCount = TrackCount + 1
                else
                    TeleportService:Teleport(116495829189052, LocalPlayer)
                end
                
                -- Recolectar Bonds
                for i, v in pairs(Items:GetChildren()) do
                    if v.Name == "Bond" or v.Name == "BondCalculated" then
                        spawn(function()
                            for i = 1, 1000 do
                                pcall(function()
                                    v.Part.CFrame = HPP.CFrame
                                end)
                            end
                            if CollectBond then
                                CollectBond:FireServer(v)
                            end
                        end)
                        
                        if v.Name == "Bond" then
                            BondCount = BondCount + 1
                            BondCounter.Text = "Bonds: " .. BondCount
                            print("Bonds obtenidos:", BondCount)
                            v.Name = "BondCalculated"
                        end
                    end
                    task.wait()
                end
                
                if Items:FindFirstChild("Bond") == nil then
                    TrackPassed = false
                end
            end
        end
    end)
end

-- ============================================
--   BOTÓN
-- ============================================
FarmButton.MouseButton1Click:Connect(AutoFarmBonds)

-- ============================================
--   INICIO
-- ============================================
print("=== JoseAngel_Blox Bonds CARGADO ===")
print("Creado por JoseAngel_Blox")
print("Presiona el botón para iniciar Auto Farm")
