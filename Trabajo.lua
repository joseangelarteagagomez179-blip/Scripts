-- MINI SCRIPT DE PRUEBA: Auto-Click X2
local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

print("Iniciando prueba de auto-click x2...")

task.spawn(function()
    while true do
        task.wait(0.5) -- Velocidad de prueba (medio segundo)
        
        for _, obj in ipairs(playerGui:GetDescendants()) do
            if obj:IsA("TextButton") or obj:IsA("ImageButton") then
                -- Busca si el nombre o algún texto hijo contiene "x2"
                local nombre = string.lower(obj.Name)
                if string.find(nombre, "x2") then
                    print("¡Botón x2 encontrado!", obj:GetFullName())
                    
                    -- Dispara el evento del botón de forma forzada
                    pcall(function()
                        for _, conn in ipairs(getconnections(obj.Activated)) do
                            conn:Fire()
                        end
                    end)
                end
            end
        end
    end
end)
