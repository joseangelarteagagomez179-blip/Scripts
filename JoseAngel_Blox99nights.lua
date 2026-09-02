-- ============================================
-- SCRIPT: JoseAngel_Blox 99 Nights (FULL HUB)
-- ============================================

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local TitleLabel = Instance.new("TextLabel")
local SubtitleLabel = Instance.new("TextLabel")

local CoreGui = game:GetService("CoreGui")
if not pcall(function() ScreenGui.Parent = CoreGui end) then
    ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

ScreenGui.Name = "JoseAngel_Blox_UI"
ScreenGui.ResetOnSpawn = false

-- 1. Marco Principal
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 330, 0, 320)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 20, 45)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.CornerRadius = UDim.new(0, 20)
UICorner.Parent = MainFrame

-- Título y Subtítulo
TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 0, 0, 8)
TitleLabel.Size = UDim2.new(1, 0, 0, 22)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Text = "JoseAngel_Blox 99 Nights"
TitleLabel.TextColor3 = Color3.fromRGB(0, 150, 255)
TitleLabel.TextSize = 20

SubtitleLabel.Name = "SubtitleLabel"
SubtitleLabel.Parent = MainFrame
SubtitleLabel.BackgroundTransparency = 1
SubtitleLabel.Position = UDim2.new(0, 0, 0, 30)
SubtitleLabel.Size = UDim2.new(1, 0, 0, 16)
SubtitleLabel.Font = Enum.Font.SourceSansItalic
SubtitleLabel.Text = "Creado por JoseAngel_Blox"
SubtitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SubtitleLabel.TextTransparency = 0.5
SubtitleLabel.TextSize = 12

-- Panel Izquierdo (Pestañas)
local TabHolder = Instance.new("Frame")
TabHolder.Name = "TabHolder"
TabHolder.Parent = MainFrame
TabHolder.Position = UDim2.new(0, 10, 0, 52)
TabHolder.Size = UDim2.new(0, 85, 0, 255)
TabHolder.BackgroundColor3 = Color3.fromRGB(15, 28, 60)
TabHolder.BorderSizePixel = 0

local TabHolderCorner = Instance.new("UICorner")
TabHolderCorner.CornerRadius = UDim.new(0, 12)
TabHolderCorner.Parent = TabHolder

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Parent = TabHolder
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 4)

local TabPadding = Instance.new("UIPadding")
TabPadding.Parent = TabHolder
TabPadding.PaddingTop = UDim.new(0, 6)
TabPadding.PaddingLeft = UDim.new(0, 4)
TabPadding.PaddingRight = UDim.new(0, 4)

-- Panel Derecho (Contenido)
local ContentHolder = Instance.new("Frame")
ContentHolder.Name = "ContentHolder"
ContentHolder.Parent = MainFrame
ContentHolder.Position = UDim2.new(0, 102, 0, 52)
ContentHolder.Size = UDim2.new(0, 218, 0, 255)
ContentHolder.BackgroundColor3 = Color3.fromRGB(15, 28, 60)
ContentHolder.BorderSizePixel = 0

local ContentHolderCorner = Instance.new("UICorner")
ContentHolderCorner.CornerRadius = UDim.new(0, 12)
ContentHolderCorner.Parent = ContentHolder

-- --------------------------------------------
-- SISTEMA DE PESTAÑAS
-- --------------------------------------------

local InfoPage = Instance.new("ScrollingFrame")
local MainPage = Instance.new("ScrollingFrame")
local TeleportPage = Instance.new("ScrollingFrame")
local AutoPage = Instance.new("ScrollingFrame")
local PlayerPage = Instance.new("ScrollingFrame")

local function SwitchTab(activePage)
    InfoPage.Visible = (activePage == InfoPage)
    MainPage.Visible = (activePage == MainPage)
    TeleportPage.Visible = (activePage == TeleportPage)
    AutoPage.Visible = (activePage == AutoPage)
    PlayerPage.Visible = (activePage == PlayerPage)
end

local function CreateTabBtn(text)
    local btn = Instance.new("TextButton")
    btn.Parent = TabHolder
    btn.Size = UDim2.new(1, 0, 0, 26)
    btn.BackgroundColor3 = Color3.fromRGB(25, 45, 90)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 12

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    return btn
end

local InfoTabBtn = CreateTabBtn("Info")
local MainTabBtn = CreateTabBtn("Main")
local TeleportTabBtn = CreateTabBtn("Teleport")
local AutoTabBtn = CreateTabBtn("Auto")
local PlayerTabBtn = CreateTabBtn("Player")

local function SetupPage(page, canvasHeight)
    page.Parent = ContentHolder
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.CanvasSize = UDim2.new(0, 0, 0, canvasHeight)
    page.Visible = false

    local layout = Instance.new("UIListLayout")
    layout.Parent = page
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)

    local padding = Instance.new("UIPadding")
    padding.Parent = page
    padding.PaddingLeft = UDim.new(0, 8)
    padding.PaddingRight = UDim.new(0, 8)
    padding.PaddingTop = UDim.new(0, 8)
end

SetupPage(InfoPage, 260)
SetupPage(MainPage, 1750)
SetupPage(TeleportPage, 200)
SetupPage(AutoPage, 220)
SetupPage(PlayerPage, 320)

InfoPage.Visible = true

InfoTabBtn.MouseButton1Click:Connect(function() SwitchTab(InfoPage) end)
MainTabBtn.MouseButton1Click:Connect(function() SwitchTab(MainPage) end)
TeleportTabBtn.MouseButton1Click:Connect(function() SwitchTab(TeleportPage) end)
AutoTabBtn.MouseButton1Click:Connect(function() SwitchTab(AutoPage) end)
PlayerTabBtn.MouseButton1Click:Connect(function() SwitchTab(PlayerPage) end)

-- --- PESTAÑA 1: INFO ---
local function AddInfoItem(titulo, contenido)
    local titleLbl = Instance.new("TextLabel")
    titleLbl.Parent = InfoPage
    titleLbl.Size = UDim2.new(1, 0, 0, 16)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Font = Enum.Font.SourceSansBold
    titleLbl.Text = titulo
    titleLbl.TextColor3 = Color3.fromRGB(0, 180, 255)
    titleLbl.TextSize = 13
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left

    local contentLbl = Instance.new("TextLabel")
    contentLbl.Parent = InfoPage
    contentLbl.Size = UDim2.new(1, 0, 0, 0)
    contentLbl.AutomaticSize = Enum.AutomaticSize.Y
    contentLbl.BackgroundTransparency = 1
    contentLbl.Font = Enum.Font.SourceSans
    contentLbl.Text = contenido
    contentLbl.TextColor3 = Color3.fromRGB(220, 220, 220)
    contentLbl.TextSize = 12
    contentLbl.TextWrapped = true
    contentLbl.TextXAlignment = Enum.TextXAlignment.Left
end

AddInfoItem("Nombre del creador:", "JoseAngel_Blox")
AddInfoItem("Fecha de lanzamiento:", "02/09/2026")
AddInfoItem("Versión:", "1.5")
AddInfoItem("UPDATE:", "Pestañas completas: Main, Teleport, Auto y Player.")

-- ============================================
-- FUNCIONES AUXILIARES
-- ============================================

local function GetRescueZoneCFrame()
    local rescueZone = workspace:FindFirstChild("Map")
        and workspace.Map:FindFirstChild("Campground")
        and workspace.Map.Campground:FindFirstChild("NPCWaypoints")
        and workspace.Map.Campground.NPCWaypoints:FindFirstChild("RescueZone")

    if not rescueZone then
        rescueZone = workspace:FindFirstChild("RescueZone", true)
    end

    if rescueZone then
        if rescueZone:IsA("BasePart") then
            return rescueZone.CFrame + Vector3.new(0, 3, 0)
        elseif rescueZone:IsA("Model") then
            return rescueZone:GetPivot() + Vector3.new(0, 3, 0)
        end
    end
    return nil
end

local function GetScrapperCFrame()
    local scrapper = workspace:FindFirstChild("Map")
        and workspace.Map:FindFirstChild("Campground")
        and workspace.Map.Campground:FindFirstChild("Scrapper")

    if not scrapper then
        scrapper = workspace:FindFirstChild("Scrapper", true)
    end

    if scrapper then
        if scrapper:IsA("BasePart") then
            return scrapper.CFrame + Vector3.new(0, 3, 0)
        elseif scrapper:IsA("Model") then
            return scrapper:GetPivot() + Vector3.new(0, 3, 0)
        end
    end
    return nil
end

-- ============================================
-- PESTAÑA 2: MAIN (FUEL, ITEMS, METAL, FOOD, TOOLS, GUNS)
-- ============================================

local function CreateSection(parent, titleText, options, btnText, bringFunction)
    local header = Instance.new("TextLabel")
    header.Parent = parent
    header.Size = UDim2.new(1, 0, 0, 18)
    header.BackgroundTransparency = 1
    header.Font = Enum.Font.SourceSansBold
    header.Text = titleText
    header.TextColor3 = Color3.fromRGB(255, 255, 255)
    header.TextSize = 15

    local selectedValue = "Select All"

    local dropBtn = Instance.new("TextButton")
    dropBtn.Parent = parent
    dropBtn.Size = UDim2.new(1, 0, 0, 26)
    dropBtn.BackgroundColor3 = Color3.fromRGB(20, 35, 70)
    dropBtn.Font = Enum.Font.SourceSans
    dropBtn.Text = "Select " .. titleText .. ": Select All ▼"
    dropBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropBtn.TextSize = 12

    local dropCorner = Instance.new("UICorner")
    dropCorner.CornerRadius = UDim.new(0, 6)
    dropCorner.Parent = dropBtn

    local dropList = Instance.new("Frame")
    dropList.Parent = parent
    dropList.Size = UDim2.new(1, 0, 0, 0)
    dropList.AutomaticSize = Enum.AutomaticSize.Y
    dropList.BackgroundColor3 = Color3.fromRGB(12, 22, 48)
    dropList.Visible = false

    local listCorner = Instance.new("UICorner")
    listCorner.CornerRadius = UDim.new(0, 6)
    listCorner.Parent = dropList

    local listLayout = Instance.new("UIListLayout")
    listLayout.Parent = dropList

    for _, option in ipairs(options) do
        local optBtn = Instance.new("TextButton")
        optBtn.Parent = dropList
        optBtn.Size = UDim2.new(1, 0, 0, 22)
        optBtn.BackgroundTransparency = 1
        optBtn.Font = Enum.Font.SourceSans
        optBtn.Text = option
        optBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        optBtn.TextSize = 12

        optBtn.MouseButton1Click:Connect(function()
            selectedValue = option
            dropBtn.Text = "Select " .. titleText .. ": " .. option .. " ▼"
            dropList.Visible = false
        end)
    end

    dropBtn.MouseButton1Click:Connect(function()
        dropList.Visible = not dropList.Visible
    end)

    local actionBtn = Instance.new("TextButton")
    actionBtn.Parent = parent
    actionBtn.Size = UDim2.new(1, 0, 0, 26)
    actionBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    actionBtn.Font = Enum.Font.SourceSansBold
    actionBtn.Text = btnText
    actionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    actionBtn.TextSize = 13

    local actionCorner = Instance.new("UICorner")
    actionCorner.CornerRadius = UDim.new(0, 6)
    actionCorner.Parent = actionBtn

    actionBtn.MouseButton1Click:Connect(function()
        bringFunction(selectedValue, options)
    end)
end

local function GenericBring(selectedValue, optionsList)
    local char = game.Players.LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local targetCF = char.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("Model") then
            local name = obj.Name
            local isMatch = false

            if selectedValue == "Select All" then
                for _, item in ipairs(optionsList) do
                    if item ~= "Select All" and string.find(string.lower(name), string.lower(item)) then
                        isMatch = true
                        break
                    end
                end
            elseif string.find(string.lower(name), string.lower(selectedValue)) then
                isMatch = true
            end

            if isMatch then
                if obj:IsA("Model") then obj:PivotTo(targetCF) else obj.CFrame = targetCF end
            end
        end
    end
end

CreateSection(MainPage, "Fuel", {"Select All", "Biofuel", "Coal", "Fuel Canister", "Oil Barrel"}, "Bring Fuel", GenericBring)
CreateSection(MainPage, "Items", {"Select All", "Alien", "Chair", "Crossbow Cultist", "Cultist", "Diamond", "Hologram Emitter", "Log", "Sapling"}, "Bring Items", GenericBring)
CreateSection(MainPage, "Metal", {"Select All", "Bolt", "Broken Fan", "Broken Microwave", "Cultist Gem", "Gem of the Forest Fragment", "Metal Chair", "Old Car Engine", "Old Radio", "Sheet Metal"}, "Bring Metal", GenericBring)
CreateSection(MainPage, "Food", {"Select All", "Berry", "Cake", "Carrot", "Chilli", "Cooked Morsel", "Cooked Steak", "Corn", "Meat? Sandwich", "Morsel", "Pumpkin", "Steak", "Stew"}, "Bring Food", GenericBring)
CreateSection(MainPage, "Tools", {"Select All", "Bandage", "Bear Trap Blueprint", "Chainsaw", "Cultist King Mace", "Defense Blueprint", "Dino Kid's Lunchbox", "Giant Sack", "Good Axe", "Good Sack", "Infernal Sack", "Kraken Kid's Lunchbox", "Kunai", "Lava Mine Blueprint", "MedKit", "Morningstar", "Obsidiron Body", "Obsidiron Boots", "Obsidiron Hammer", "Old Flashlight", "Poison Spear", "Spear", "Squid Kid's Lunchbox", "Strong Axe", "Strong Flashlight", "Thorn Body", "Wildfire"}, "Bring Tools", GenericBring)
CreateSection(MainPage, "Guns", {"Select All", "Alien Amour", "Crossbow", "Infernal Crossbow", "Iron Body", "Laser Canon", "Leather Body", "Raygun", "Revolver", "Revolver Ammo", "Rifle", "Rifle Ammo", "Tactical Shotgun"}, "Bring Guns", GenericBring)

-- ============================================
-- PESTAÑA 3: TELEPORT
-- ============================================

local TpHeader = Instance.new("TextLabel")
TpHeader.Parent = TeleportPage
TpHeader.Size = UDim2.new(1, 0, 0, 20)
TpHeader.BackgroundTransparency = 1
TpHeader.Font = Enum.Font.SourceSansBold
TpHeader.Text = "Teleport Zone"
TpHeader.TextColor3 = Color3.fromRGB(255, 255, 255)
TpHeader.TextSize = 15

local function CreateTpBtn(text, onClick)
    local btn = Instance.new("TextButton")
    btn.Parent = TeleportPage
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(onClick)
end

CreateTpBtn("Tp al campamento", function()
    local char = game.Players.LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local targetCF = GetRescueZoneCFrame()
    if targetCF then char.HumanoidRootPart.CFrame = targetCF end
end)

CreateTpBtn("Tp a Stronghold", function()
    local char = game.Players.LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    local stronghold = workspace:FindFirstChild("Stronghold", true)
        or (workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Stronghold", true))

    if stronghold then
        if stronghold:IsA("BasePart") then
            char.HumanoidRootPart.CFrame = stronghold.CFrame + Vector3.new(0, 3, 0)
        elseif stronghold:IsA("Model") then
            char:PivotTo(stronghold:GetPivot() + Vector3.new(0, 3, 0))
        end
    end
end)

-- ============================================
-- PESTAÑA 4: AUTOMATICALLY
-- ============================================

local AutoHeader = Instance.new("TextLabel")
AutoHeader.Parent = AutoPage
AutoHeader.Size = UDim2.new(1, 0, 0, 20)
AutoHeader.BackgroundTransparency = 1
AutoHeader.Font = Enum.Font.SourceSansBold
AutoHeader.Text = "Automation Settings"
AutoHeader.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoHeader.TextSize = 15

local function CreateToggleBtn(parent, text, globalVarName)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = text .. ": OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    _G[globalVarName] = false

    btn.MouseButton1Click:Connect(function()
        _G[globalVarName] = not _G[globalVarName]
        if _G[globalVarName] then
            btn.Text = text .. ": ON"
            btn.BackgroundColor3 = Color3.fromRGB(40, 180, 80)
        else
            btn.Text = text .. ": OFF"
            btn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        end
    end)
    return btn
end

CreateToggleBtn(AutoPage, "Kill Aura", "KillAura")
CreateToggleBtn(AutoPage, "Auto Fuel", "AutoFuel")
CreateToggleBtn(AutoPage, "Auto Scrapper", "AutoScrapper")

-- Loops de automatización
task.spawn(function()
    while task.wait(0.1) do
        if _G.KillAura then
            pcall(function()
                local player = game.Players.LocalPlayer
                local char = player.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local myPos = char.HumanoidRootPart.Position
                    for _, v in ipairs(workspace:GetDescendants()) do
                        if v:IsA("Model") and v ~= char and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            if v.Humanoid.Health > 0 and not game.Players:GetPlayerFromCharacter(v) then
                                local dist = (v.HumanoidRootPart.Position - myPos).Magnitude
                                if dist <= 25 then
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

task.spawn(function()
    while task.wait(1) do
        if _G.AutoFuel then
            pcall(function()
                local targetCF = GetRescueZoneCFrame()
                if targetCF then
                    local fuelItems = {"Biofuel", "Coal", "Fuel Canister", "Oil Barrel"}
                    for _, obj in ipairs(workspace:GetDescendants()) do
                        if obj:IsA("BasePart") or obj:IsA("Model") then
                            for _, f in ipairs(fuelItems) do
                                if string.find(string.lower(obj.Name), string.lower(f)) then
                                    if obj:IsA("Model") then obj:PivotTo(targetCF) else obj.CFrame = targetCF end
                                    break
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if _G.AutoScrapper then
            pcall(function()
                local targetCF = GetScrapperCFrame()
                if targetCF then
                    local metalItems = {"Bolt", "Broken Fan", "Broken Microwave", "Cultist Gem", "Gem of the Forest Fragment", "Metal Chair", "Old Car Engine", "Old Radio", "Sheet Metal"}
                    for _, obj in ipairs(workspace:GetDescendants()) do
                        if obj:IsA("BasePart") or obj:IsA("Model") then
                            for _, m in ipairs(metalItems) do
                                if string.find(string.lower(obj.Name), string.lower(m)) then
                                    if obj:IsA("Model") then obj:PivotTo(targetCF) else obj.CFrame = targetCF end
                                    break
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-
