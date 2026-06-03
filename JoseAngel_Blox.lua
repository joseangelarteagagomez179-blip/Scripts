-- JoseAngel_Blox Bonds

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
                task.wait(0.15)
                local jugador = game.Players.LocalPlayer
                if not jugador.Character then continue end
                local HRP = jugador.Character:FindFirstChild("HumanoidRootPart")
                if not HRP then continue end

                -- Busca y recoge bonos
                for _, objeto in pairs(workspace:GetDescendants()) do
                    if objeto.Name == "Bond" and (objeto:IsA("Part") or objeto:IsA("Model")) then
                        local parte = objeto:IsA("Model") and objeto.PrimaryPart or objeto
                        if parte then
                            HRP.CFrame = parte.CFrame
                            task.wait(0.05)
                            if objeto:FindFirstChildOfClass("ClickDetector") then
                                fireclickdetector(objeto:FindFirstChildOfClass("ClickDetector"))
                            end
                        end
                    end
                end

                -- Enviar al servidor
                local remoto = game.ReplicatedStorage:FindFirstChild("Remotes", true)
                if remoto and remoto:FindFirstChild("Collect") then
                    for _, objeto in pairs(workspace:GetDescendants()) do
                        if objeto.Name == "Bond" then
                            remoto.Collect:FireServer(objeto)
                        end
                    end
                end
            end
        end)()
    end
end)

-- Mensaje de confirmación en pantalla
Interfaz:MakeNotification({
    Title = "JoseAngel_Blox Bonds",
    Text = "Script cargado correctamente ✅",
    Duration = 3
})
