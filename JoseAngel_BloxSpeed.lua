local Library = loadstring(game:HttpGet("https://githubusercontent.com"))()
local Window = Library.CreateLib("Lucky Block 'kickready' Bypass 🌊", "Midnight")
local Tab = Window:NewTab("Auto-Safe")
local Section = Tab:NewSection("Vuelo Directo a kickready")

-- SERVICIOS
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

-- VELOCIDAD AJUSTABLE (Muy rápida para ganarle a la ola)
local VelocidadVuelo = 200 

-- FUNCIÓN PRINCIPAL DE DESPLAZAMIENTO TERRESTRE
local function VolarAKickReady()
    local character = localPlayer.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    
    if not rootPart then 
        warn("¡Error! No se encontró el cuerpo de tu personaje.")
        return 
    end

    -- BUSCADOR AUTOMÁTICO DEL MAPA: Busca el objeto llamado kickready
    local targetZone = game.Workspace:FindFirstChild("kickready", true) 
    
    if targetZone and (targetZone:IsA("BasePart") or targetZone:IsA("Model")) then
        -- Obtener posición del objeto
        local destinoPos = targetZone:IsA("Model") and targetZone:GetPivot().Position or targetZone.Position
        
        -- Ajustamos la altura para ir pegados al piso (Evita traspasar el mapa)
        local destinoAjustado = Vector3.new(destinoPos.X, rootPart.Position.Y, destinoPos.Z)
        
        -- Calculamos duración según la distancia para que la velocidad sea constante
        local distancia = (rootPart.Position - destinoAjustado).Magnitude
        local duracion = distancia / VelocidadVuelo
        
        -- Configuración física del movimiento lineal
        local infoTween = TweenInfo.new(duracion, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local objetivos = {CFrame = CFrame.new(destinoAjustado) * CFrame.Angles(0, rootPart.Rotation.Y, 0)}
        
        local tween = TweenService:Create(rootPart, infoTween, objetivos)
        
        -- CREACIÓN DE ANTIGRAVEDAD (Bypass de velocidad para que el juego no te regrese)
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(500000, 500000, 500000)
        bodyVelocity.Parent = rootPart
        
        -- Desactivar temporalmente la caída
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Physics) end
        
        -- Empezar a volar a ras de suelo
        tween:Play()
        print("🚀 Volando directo a kickready sobre el suelo...")
        
        -- Al llegar a kickready, te devuelve tus físicas normales para que cobres
        tween.Completed:Connect(function()
            bodyVelocity:Destroy()
            if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end
            print("¡Llegaste a kickready sano y salvo! Brainrots asegurados.")
        end)
    else
        warn("No se pudo encontrar el objeto 'kickready' en el mapa. Revisa si está escrito exactamente así.")
    end
end

-- INTERFAZ DE USUARIO PARA DELTA EXECUTOR
Section:NewButton("⚡ Volar a kickready (Salvarse)", "Te desliza súper rápido por el piso hasta la base", function()
    VolarAKickReady()
end)

Section:NewSlider("Ajustar Velocidad de Desplazamiento", "Cambia qué tan rápido te arrastras", 400, 100, function(v)
    VelocidadVuelo = v
end)
