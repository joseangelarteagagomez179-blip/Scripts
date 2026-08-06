-- ==========================================
-- MINI ESPÍA DE REMOTOS PARA DELTA EXECUTOR
-- ==========================================
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local Network = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Packages"):WaitForChild("Network")

for _, remote in pairs(Network:GetChildren()) do
    if remote:IsA("RemoteEvent") then
        -- Interceptamos cuando el juego llama a un RemoteEvent
        local oldFireServer
        oldFireServer = hookfunction(remote.FireServer, function(self, ...)
            local args = {...}
            print("[REMOTE DETECTADO]: " .. tostring(self.Name))
            
            -- Muestra una notificación en tu pantalla de Roblox
            StarterGui:SetCore("SendNotification", {
                Title = "Remoto Activado:",
                Text = tostring(self.Name),
                Duration = 4
            })
            
            return oldFireServer(self, ...)
        end)
    end
end
