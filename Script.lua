-- Scripts JoseAngel_Blox
-- JUEGO: Kick a Lucky Block | ID: 89469502395769
-- Creador: JoseAngel_Blox | Fecha: 02/06/2026

if game.PlaceId ~= 89469502395769 then
    return
end

local Jugadores = game:GetService("Players")
local AlmacenamientoReplicado = game:GetService("ReplicatedStorage")
local EspacioDeTrabajo = game:GetService("Workspace")
local JugadorLocal = Jugadores.LocalPlayer
local Personaje = JugadorLocal.Character or JugadorLocal.CharacterAdded:Wait()
local Humanoide = Personaje:WaitForChild("Humanoid")

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Scripts JoseAngel_Blox",
    Text = "Cargado correctamente",
    Duration = 3
})

local Configuracion = {
    PatadaAutomatica = false,
    FuerzaMaxima = 999999,
    PatadaPerfecta = true,
    RecoleccionAutomatica = false,
    ComprarMejoras = false,
    RenacimientoAutomatico = false,
    SobrevivirTsunami = false,
    AntiAFK = false
}

local Eventos = AlmacenamientoReplicado:WaitForChild("Events", 15) or AlmacenamientoReplicado
local RemotoPatada = Eventos:WaitForChild("Kick", 10)
local RemotoRecolectar = Eventos:WaitForChild("Collect", 10)
local RemotoComprar = Eventos:WaitForChild("Buy", 10)
local RemotoMejorar = Eventos:WaitForChild("Upgrade", 10)
local RemotoRenacer = Eventos:WaitForChild("Rebirth", 10)

local function PatadaAutomatica()
    while task.wait(0.1) do
        if Configuracion.PatadaAutomatica then
            local Bloque = EspacioDeTrabajo:FindFirstChild("LuckyBlock", true)
            if Bloque and RemotoPatada then
                local Fuerza = Configuracion.PatadaPerfecta and math.random(900000, 999999) or Configuracion.FuerzaMaxima
                pcall(function() RemotoPatada:FireServer(Fuerza) end)
                if Bloque:FindFirstChildOfClass("ClickDetector") then
                    fireclickdetector(Bloque.ClickDetector)
                end
            end
        end
    end
end

local function RecoleccionAutomatica()
    while task.wait(0.2) do
        if Configuracion.RecoleccionAutomatica then
            for _, Objeto in pairs(EspacioDeTrabajo:GetDescendants()) do
                if (Objeto:IsA("Part") or Objeto:IsA("MeshPart")) and Objeto:FindFirstChild("ClickDetector") then
                    if Objeto.Name:lower():find("coin") or Objeto.Name:lower():find("brainrot") or Objeto.Name:lower():find("reward") then
                        fireclickdetector(Objeto.ClickDetector)
                        Personaje.HumanoidRootPart.CFrame = Objeto.CFrame + Vector3.new(0, 2, 0)
                    end
                end
            end
        end
    end
end

local function ComprarMejoras()
    while task.wait(1) do
        if Configuracion.ComprarMejoras then
            pcall(function()
                RemotoComprar:FireServer("Weight")
                RemotoMejorar:FireServer("All")
            end)
        end
    end
end

local function RenacimientoAutomatico()
    while task.wait(2) do
        if Configuracion.RenacimientoAutomatico then
            pcall(function() RemotoRenacer:FireServer() end)
        end
    end
end

local function SobrevivirTsunami()
    while task.wait(0.5) do
        if Configuracion.SobrevivirTsunami then
            local Tsunami = EspacioDeTrabajo:FindFirstChild("Tsunami", true)
            if Tsunami then
                Personaje.HumanoidRootPart.CFrame = CFrame.new(Personaje.Position.X, 150, Personaje.Position.Z)
                Humanoide.Health = 100
                Humanoide.MaxHealth = math.huge
            end
        end
    end
end

local function AntiAFK()
    while task.wait(30) do
        if Configuracion.AntiAFK then
            Humanoide:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end

local Libreria = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Ventana = Libreria.CreateLib("Scripts JoseAngel_Blox", "DarkTheme")

local PestañaPrincipal = Ventana:NewTab("Principal")
local SeccionPatada = PestañaPrincipal:NewSection("Patear Bloque")
SeccionPatada:NewToggle("Patada Automática", function(estado)
    Configuracion.PatadaAutomatica = estado
end)
SeccionPatada:NewToggle("Patada Perfecta", function(estado)
    Configuracion.PatadaPerfecta = estado
end)

local SeccionRecoleccion = PestañaPrincipal:NewSection("Recolección")
SeccionRecoleccion:NewToggle("Recolectar Todo", function(estado)
    Configuracion.RecoleccionAutomatica = estado
end)

local PestañaMejoras = Ventana:NewTab("Mejoras")
local SeccionTienda = PestañaMejoras:NewSection("Tienda")
SeccionTienda:NewToggle("Comprar Pesas y Mejoras", function(estado)
    Configuracion.ComprarMejoras = estado
end)
SeccionTienda:NewToggle("Renacimiento Automático", function(estado)
    Configuracion.RenacimientoAutomatico = estado
end)

local PestañaAjustes = Ventana:NewTab("Ajustes")
local SeccionSeguridad = PestañaAjustes:NewSection("Seguridad")
SeccionSeguridad:NewToggle("Sobrevivir Tsunami", function(estado)
    Configuracion.SobrevivirTsunami = estado
end)
SeccionSeguridad:NewToggle("Anti AFK", function(estado)
    Configuracion.AntiAFK = estado
end)

local PestañaInfo = Ventana:NewTab("Información")
local SeccionInfo = PestañaInfo:NewSection("Datos")
SeccionInfo:NewLabel("Creador: JoseAngel_Blox")
SeccionInfo:NewLabel("Fecha: 02/06/2026")
SeccionInfo:NewLabel("ID: 89469502395769")

task.spawn(PatadaAutomatica)
task.spawn(RecoleccionAutomatica)
task.spawn(ComprarMejoras)
task.spawn(RenacimientoAutomatico)
task.spawn(SobrevivirTsunami)
task.spawn(AntiAFK)
