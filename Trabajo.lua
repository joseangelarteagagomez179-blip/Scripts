-- ==========================================
-- KICK A LUCKY BLOCK - SCRIPT PERSONALIZADO
-- Estado: 100% Visible y No Obfuscado
-- ==========================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer

-- Configuración de Opciones (Modifica los valores a tu gusto)
getgenv().Config = {
    AutoClickX2 = true,    -- Activa o desactiva el auto click duplicado
    AutoTrain = true,     -- Simula el entrenamiento de piernas/pesas
    ClickInterval = 0.05, -- Velocidad de ejecución en segundos
    Range = 25            -- Distancia máxima para detectar los bloques
}

-- Función de Auto Click / Patada x2
local function runAutoClick()
    local character = localPlayer.Character
    if not character then return end
    
    local tool = character:FindFirstChildOfClass("Tool")
    
    -- Si tienes una herramienta equipada, la activa dos veces (x2)
    if tool and getgenv().Config.AutoClickX2 then
        for i = 1, 2 do
            pcall(function()
                tool:Activate()
            end)
            task.wait(0.01)
        end
    else
        -- Búsqueda alternativa por proximidad a los Lucky Blocks
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _, obj in ipairs(Workspace:GetChildren()) do
                if obj.Name:lower():find("lucky block") then
                    local part = obj:IsA("BasePart") and obj or obj.PrimaryPart
                    if part and (hrp.Position - part.Position).Magnitude <= getgenv().Config.Range then
                        for i = 1, 2 do
                            pcall(function()
                                firetouchinterest(hrp, part, 0)
                                task.wait()
                                firetouchinterest(hrp, part, 1)
                            end)
                        end
                    end
                end
            end
        end
    end
end

-- Función para automatizar el entrenamiento (comprar o usar pesas si el juego lo permite)
local function runAutoTrain()
    if not getgenv().Config.AutoTrain then return end
    
    -- Nota: Si el juego utiliza RemoteEvents para entrenar, puedes colocarlos aquí.
    -- Ejemplo genérico de llamada a Remotes si los descubres en el ReplicatedStorage:
    -- local remote = game:GetService("ReplicatedStorage"):FindFirstChild("TrainEvent", true)
    -- if remote then remote:FireServer() end
end

-- Bucle principal del script corriendo en segundo plano
task.spawn(function()
    while true do
        if getgenv().Config.AutoClickX2 then
            runAutoClick()
        end
        if getgenv().Config.AutoTrain then
            runAutoTrain()
        end
        task.wait(getgenv().Config.Divider or getgenv().Config.ClickInterval)
    end
end)

print("¡Script transparente de Kick a Lucky Block ejecutado con éxito!")
