-- Busca en el PlayerGui elementos que contengan la palabra o textura del botón
local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

for _, gui in ipairs(playerGui:GetDescendants()) do
    if gui:IsA("TextButton") or gui:IsA("ImageButton") then
        -- Puedes filtrar por nombre o si ves que coincide con los botones x2
        if string.find(string.lower(gui.Name), "x2") or string.find(string.lower(gui.Name), "click") or string.find(string.lower(gui.Name), "button") then
            print("Botón encontrado:", gui:GetFullName())
        end
    end
end
