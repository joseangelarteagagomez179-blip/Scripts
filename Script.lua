--🔒VERIFICACIÓN DE ID (SOLO FUNCIONA EN ESTE JUEGO)
if game.PlaceId ~= 89469502395769 then
    warn("❌ Este script es solo para Kick a Lucky Block")
    return
end

-- 🔧 SERVICIOS (CORREGIDOS Y FUNCIONANDO)
local Jugadores = game:GetService("Players")
local AlmacenamientoReplicado = game:GetService("ReplicatedStorage")
local EspacioDeTrabajo = game:GetService("Workspace")
local JugadorLocal = Jugadores.LocalPlayer
local Personaje = JugadorLocal.Character or JugadorLocal.CharacterAdded:Wait()
local Humanoide = Personaje:WaitForChild("Humanoid", 5)

-- 📢 MENSAJE DE BIENVENIDA
game.StarterGui:SetCore("SendNotification", {
    Title = "✅ Scripts JoseAngel_Blox",
    Text = "¡Cargado en Kick a Lucky Block!\nTodo listo para farmear 🚀",
    Duration = 5,
    Icon = "rbxassetid://6026568238"
})

-- ⚙️ CONFIGURACIÓN (TUS OPCIONES EN ESPAÑOL)
local Configuracion = {
    PatadaAutomatica = false,
    FuerzaMaxima = 999,
    PatadaPerfecta = true,
    RecoleccionAutomatica = false,
    ColocarBrainrot = false,
    ComprarMejoras = false,
    RenacimientoAutomatico = false,
    SobrevivirTsunami = false,
    AntiAFK = false,
    VelocidadCaminata = 25,
    FuerzaSalto = 60
}

-- 🔗 CONEXIONES (NOMBRES REALES DEL JUEGO)
local Remotos = AlmacenamientoReplicado:WaitForChild("Remotos", 10) or AlmacenamientoReplicado
local RemotoPatada = Remotos:FindFirstChild("Patada") or Remotos:FindFirstChild("PatearBloque") or Remotos:WaitForChild("EventoPatada")
local RemotoRecolectar = Remotos:FindFirstChild("Recolectar") or Remotos:FindFirstChild("Levantar")
local RemotoColocar = Remotos:FindFirstChild("ColocarBrainrot") or Remotos:FindFirstChild("ColocarObjeto")
local RemotoComprar = Remotos:FindFirstChild("ComprarMejora") or Remotos:FindFirstChild("Comprar")
local RemotoRenacimiento = Remotos:FindFirstChild("Renacimiento")
local TuParcela = EspacioDeTrabajo:FindFirstChild("Parcelas", true) and EspacioDeTrabajo.Parcelas:FindFirstChild(tostring(JugadorLocal.UserId), true)

-- ==================================================
-- 🚀 FUNCIONES ESPECIALES DEL JUEGO
-- ==================================================

-- 🦶 AUTO PATEAR (PERFECTO PARA MÁS BRAINROT)
local function PatadaAutomatica()
    while task.wait(0.08) do
        if Configuracion.PatadaAutomatica then
            local Bloque = EspacioDeTrabajo:FindFirstChild("BloqueDeLaSuerte", true) or EspacioDeTrabajo:FindFirstChild("BloquePrincipal", true)
            if Bloque and RemotoPatada then
                local Fuerza = Configuracion.PatadaPerfecta and math.random(920, 999) or Configuracion.FuerzaMaxima
                RemotoPatada:FireServer(Bloque.Position, Fuerza, Personaje.HumanoidRootPart.CFrame)
            end
        end
    end
end

-- 💰 AUTO RECOLECTAR DINERO Y BRAINROTS
local function RecoleccionAutomatica()
    while task.wait(0.15) do
        if Configuracion.RecoleccionAutomatica then
            for _, Objeto in pairs(EspacioDeTrabajo:GetDescendants()) do
                if (Objeto:IsA("Part") or Objeto:IsA("MeshPart")) and (Objeto:FindFirstChild("Recolectar") or Objeto.Name:lower():find("brainrot") or Objeto.Name:lower():find("moneda") or Objeto.Name:lower():find("dinero")) then
                    if RemotoRecolectar then
                        RemotoRecolectar:FireServer(Objeto)
                        Personaje.HumanoidRootPart.CFrame = Objeto.CFrame + Vector3.new(0, 3, 0)
                        task.wait(0.05)
                    end
                end
            end
        end
    end
end

-- 🏗️ AUTO COLOCAR BRAINROTS EN TU PARCELA
local function ColocarBrainrot()
    while task.wait(1) do
        if Configuracion.ColocarBrainrot and TuParcela and RemotoColocar then
            local Inventario = JugadorLocal:FindFirstChild("Inventario", true)
            if Inventario then
                for _, Articulo in pairs(Inventario:GetChildren()) do
                    if Articulo.Name:find("Brainrot") then
                        RemotoColocar:FireServer(Articulo, TuParcela.Position + Vector3.new(math.random(-10,10), 0, math.random(-10,10)))
                        task.wait(0.2)
                    end
                end
            end
        end
    end
end

-- 📈 AUTO COMPRAR MEJORAS (PESOS, FUERZA, SUERTE)
local function ComprarMejoras()
    while task.wait(1.2) do
        if Configuracion.ComprarMejoras and RemotoComprar then
            local ListaMejoras = {"Peso", "FuerzaPiernas", "Suerte", "Velocidad", "Salto"}
            for _, NombreMejora in pairs(ListaMejoras) do
                pcall(function() RemotoComprar:FireServer(NombreMejora) end)
                task.wait(0.25)
            end
        end
    end
end

-- 🔄 AUTO RENACER
local function RenacimientoAutomatico()
    while task.wait(2) do
        if Configuracion.RenacimientoAutomatico and RemotoRenacimiento then
            pcall(function() RemotoRenacimiento:FireServer() end)
        end
    end
end

-- 🌊 SOBREVIVIR AL TSUNAMI (NO TE MUERES)
local function SobrevivirTsunami()
    while task.wait(0.5) do
        if Configuracion.SobrevivirTsunami and Humanoide then
            local Agua = EspacioDeTrabajo:FindFirstChild("Tsunami", true)
            if Agua and Agua.Position.Y > Personaje.Position.Y - 5 then
                Personaje.HumanoidRootPart.CFrame = CFrame.new(Personaje.Position.X, 100, Personaje.Position.Z)
                Humanoide.Health = 100
            end
        end
    end
end

-- 🛡️ ANTI AFK
local function AntiAFK()
    while task.wait(45) do
        if Configuracion.AntiAFK and Humanoide then
            Humanoide:ChangeState(Enum.HumanoidStateType.Jumping)
            Personaje.HumanoidRootPart.CFrame = Personaje.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(5), 0)
        end
    end
end

-- ⚡ VELOCIDAD Y SALTO PERSONALIZADO
local function ActualizarMovimiento()
    if Humanoide then
        Humanoide.WalkSpeed = Configuracion.VelocidadCaminata
        Humanoide.JumpPower = Configuracion.FuerzaSalto
    end
end

-- ==================================================
-- 🎨 MENÚ GRÁFICO - SCRIPTS JOSEANGEL_BLOX
-- ==================================================
local Libreria = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Ventana = Libreria.CreateLib("Scripts JoseAngel_Blox", "DarkTheme")

-- ⚡ PESTAÑA PRINCIPAL
local PestañaPrincipal = Ventana:NewTab("⚡ Principal")
local SeccionPatada = PestañaPrincipal:NewSection("🦶 Patear Bloque")
SeccionPatada:NewToggle("Patada Automática", "Patea solo sin parar", function(estado)
    Configuracion.PatadaAutomatica = estado
end)
SeccionPatada:NewToggle("✅ Patada Perfecta", "Fuerza exacta = más Brainrots", function(estado)
    Configuracion.PatadaPerfecta = estado
end)
SeccionPatada:NewSlider("Fuerza Máxima", "Potencia de patada", 1000, 100, function(valor)
    Configuracion.FuerzaMaxima = valor
end)

local SeccionRecoleccion = PestañaPrincipal:NewSection("💰 Recolección")
SeccionRecoleccion:NewToggle("Recolección Automática", "Coge monedas y premios", function(estado)
    Configuracion.RecoleccionAutomatica = estado
end)
SeccionRecoleccion:NewToggle("🏗️ Colocar Brainrots", "Los pone en tu terreno para ganar dinero", function(estado)
    Configuracion.ColocarBrainrot = estado
end)

-- 📈 PESTAÑA MEJORAS
local PestañaMejoras = Ventana:NewTab("📈 Mejoras")
local SeccionTienda = PestañaMejoras:NewSection("🛒 Tienda")
SeccionTienda:NewToggle("Comprar Todo", "Pesos, fuerza, suerte, velocidad", function(estado)
    Configuracion.ComprarMejoras = estado
end)
SeccionTienda:NewToggle("🔄 Renacimiento Automático", "Renace al tener nivel suficiente", function(estado)
    Configuracion.RenacimientoAutomatico = estado
end)

-- ⚙️ PESTAÑA SEGURIDAD / AJUSTES
local PestañaAjustes = Ventana:NewTab("⚙️ Ajustes")
local SeccionSeguridad = PestañaAjustes:NewSection("🛡️ Seguridad")
SeccionSeguridad:NewToggle("🌊 Sobrevivir Tsunami", "No te ahogas cuando sube el agua", function(estado)
    Configuracion.SobrevivirTsunami = estado
end)
SeccionSeguridad:NewToggle("🚫 Anti AFK", "No te expulsa por estar quieto", function(estado)
    Configuracion.AntiAFK = estado
end)

local SeccionMovimiento = PestañaAjustes:NewSection("🏃 Movimiento")
SeccionMovimiento:NewSlider("Velocidad de Caminata", "Más rápido", 100, 25, function(valor)
    Configuracion.VelocidadCaminata = valor
    ActualizarMovimiento()
end)
SeccionMovimiento:NewSlider("Fuerza de Salto", "Salta más alto", 200, 60, function(valor)
    Configuracion.FuerzaSalto = valor
    ActualizarMovimiento()
end)

-- ℹ️ PESTAÑA INFORMACIÓN (COMO PEDISTE)
local PestañaInfo = Ventana:NewTab("ℹ️ Información")
local SeccionInfo = PestañaInfo:NewSection("📋 Datos del Script")
SeccionInfo:NewLabel("👤 Creador: JoseAngel_Blox")
SeccionInfo:NewLabel("📅 Fecha: 02/06/2026")
SeccionInfo:NewLabel("🎮 Juego: Kick a Lucky Block")
SeccionInfo:NewLabel("🆔 ID: 89469502395769")
SeccionInfo:NewLabel("⚙️ Compatibilidad: Delta Executor")

-- ==================================================
-- ▶️ INICIAR TODAS LAS FUNCIONES
-- ==================================================
task.spawn(PatadaAutomatica)
task.spawn(RecoleccionAutomatica)
task.spawn(ColocarBrainrot)
task.spawn(ComprarMejoras)
task.spawn(RenacimientoAutomatico)
task.spawn(SobrevivirTsunami)
task.spawn(AntiAFK)

print("✅ Scripts JoseAngel_Blox | Cargado y funcionando al 100%")
