-- ═══════════════════════════════════════════
--           JoseAngel_Blox Bonds
-- ═══════════════════════════════════════════

local Interfaz = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Ventana = Interfaz.CreateLib("JoseAngel_Blox Bonds", "DarkTheme")

local Pestaña = Ventana:NewTab("Principal")

local SeccionInfo = Pestaña:NewSection("Información")
SeccionInfo:NewLabel("Nombre del creador: JoseAngel_Blox")
SeccionInfo:NewLabel("Fecha de creación: 03/06/2026")

local SeccionFarm = Pestaña:NewSection("Auto Farm")
SeccionFarm:NewToggle("Auto Farm Bonds", "Recoge bonos automáticamente", function(estado)
    _G.ActivarFarm = estado
    if estado then
        coroutine.wrap(function()
            while _G.ActivarFarm do
                task.wait(0.2)
                for _, objeto in pairs(workspace:GetDescendants()) do
                    if objeto.Name == "Bond" and objeto:IsA("Part") then
                        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = objeto.CFrame
                            task.wait(0.1)
                        end
                    end
                end
                if game.ReplicatedStorage:FindFirstChild("Remotes") and game.ReplicatedStorage.Remotes:FindFirstChild("Collect") then
                    for _, objeto in pairs(workspace:GetDescendants()) do
                        if objeto.Name == "Bond" then
                            game.ReplicatedStorage.Remotes.Collect:FireServer(objeto)
                        end
                    end
                end
            end
        end)()
    end
end)
