-- ==============================================
-- JUEGO ROBLOX | ID: 89469502395769
-- CREADOR DEL SCRIPT: JoseAngel_Blox
-- FECHA DE CREACIÓN: 02/06/2026
-- COMPATIBLE CON: Delta Executor (Celular)
-- ==============================================

-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- MÓDULO DE CONFIGURACIÓN Y UTILIDADES
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
local Configuracion = {
    MostrarFPS = false,
    OptimizarJuego = false,
    ColorInterfaz = Color3.fromRGB(0, 183, 255),
    VersionScript = "1.0.0"
}

local Utilidades = {
    NombreJuego = game:GetService("MarketplaceService"):GetProductInfo(89469502395769).Name or "Juego Desconocido",
    HoraEjecucion = os.date("%H:%M:%S"),
    FechaEjecucion = os.date("%d/%m/%Y")
}

-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- FUNCIÓN DE BIENVENIDA
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
local function MostrarBienvenida()
    local MensajeBienvenida = [[
==============================================
          ¡BIENVENIDO AL SCRIPT OFICIAL!
==============================================
🔹 JUEGO: ]]..Utilidades.NombreJuego..[[
🔹 ID DEL JUEGO: 89469502395769
🔹 CREADOR DEL SCRIPT: JoseAngel_Blox
🔹 FECHA DE CREACIÓN: 02/06/2026
🔹 VERSIÓN DEL SCRIPT: ]]..Configuracion.VersionScript..[[
🔹 HORA DE EJECUCIÓN: ]]..Utilidades.HoraEjecucion.." | "..Utilidades.FechaEjecucion..[[
==============================================
          SELECCIONA UNA OPCIÓN A CONTINUACIÓN
==============================================
    ]]
    print(MensajeBienvenida)
    wait(1)
end

-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- MÓDULO DE FPS Y OPTIMIZACIÓN
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
local FpsLabel = nil

local function ActualizarFPS()
    while wait(0.5) and Configuracion.MostrarFPS do
        local FPS = math.floor(1 / game:GetService("RunService").RenderStepped:Wait())
        FpsLabel.Text = "FPS: "..FPS
    end
end

local function ActivarFPS()
    if not FpsLabel then
        FpsLabel = Instance.new("TextLabel")
        FpsLabel.Name = "FPS_Display"
        FpsLabel.Size = UDim2.new(0, 120, 0, 30)
        FpsLabel.Position = UDim2.new(0.02, 0, 0.02, 0)
        FpsLabel.BackgroundTransparency = 0.3
        FpsLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        FpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        FpsLabel.TextScaled = true
        FpsLabel.Font = Enum.Font.SourceSansBold
        FpsLabel.Parent = game:GetService("Players").LocalPlayer.PlayerGui
    end
    Configuracion.MostrarFPS = true
    spawn(ActualizarFPS)
    print("[CONFIGURACIÓN] → Mostrar FPS activado correctamente")
end

local function DesactivarFPS()
    Configuracion.MostrarFPS = false
    if FpsLabel then FpsLabel:Destroy() FpsLabel = nil end
    print("[CONFIGURACIÓN] → Mostrar FPS desactivado correctamente")
end

local function OptimizarJuegoFuncion()
    if Configuracion.OptimizarJuego then
        print("[CONFIGURACIÓN] → El juego ya se encuentra optimizado")
        return
    end

    Configuracion.OptimizarJuego = true
    
    -- Reducir calidad gráfica
    game:GetService("Settings").Rendering.QualityLevel = Enum.QualityLevel.Level1
    game:GetService("Workspace").StreamingEnabled = true
    game:GetService("Workspace").StreamingMinRadius = 50
    game:GetService("Workspace").StreamingMaxRadius = 150
    
    -- Desactivar efectos innecesarios
    for _, efecto in pairs(game:GetService("Workspace"):GetDescendants()) do
        if efecto:IsA("ParticleEmitter") or efecto:IsA("Light") or efecto:IsA("Smoke") then
            efecto.Enabled = false
        end
    end
    
    -- Optimizar rendimiento de personajes
    for _, jugador in pairs(game:GetService("Players"):GetPlayers()) do
        if jugador ~= game:GetService("Players").LocalPlayer then
            if jugador.Character then
                for _, parte in pairs(jugador.Character:GetDescendants()) do
                    if parte:IsA("MeshPart") or parte:IsA("Part") then
                        parte.Reflectance = 0
                        parte.Transparency = 0.1
                    end
                end
            end
        end
    end
    
    print("[CONFIGURACIÓN] → Juego optimizado exitosamente - Rendimiento mejorado")
end

local function RestaurarOptimizacion()
    if not Configuracion.OptimizarJuego then
        print("[CONFIGURACIÓN] → El juego no se encuentra optimizado")
        return
    end

    Configuracion.OptimizarJuego = false
    
    -- Restaurar calidad gráfica
    game:GetService("Settings").Rendering.QualityLevel = Enum.QualityLevel.Automatic
    game:GetService("Workspace").StreamingEnabled = false
    
    -- Activar efectos
    for _, efecto in pairs(game:GetService("Workspace"):GetDescendants()) do
        if efecto:IsA("ParticleEmitter") or efecto:IsA("Light") or efecto:IsA("Smoke") then
            efecto.Enabled = true
        end
    end
    
    -- Restaurar personajes
    for _, jugador in pairs(game:GetService("Players"):GetPlayers()) do
        if jugador ~= game:GetService("Players").LocalPlayer then
            if jugador.Character then
                for _, parte in pairs(jugador.Character:GetDescendants()) do
                    if parte:IsA("MeshPart") or parte:IsA("Part") then
                        parte.Reflectance = 0.2
                        parte.Transparency = 0
                    end
                end
            end
        end
    end
    
    print("[CONFIGURACIÓN] → Configuración gráfica restaurada a valores por defecto")
end

-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- MÓDULO DE FUNCIONES DEL JUEGO
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
local FuncionesJuego = {
    -- Opción 1: Funciones de Movimiento
    Movimiento = function()
        print("\n==============================================")
        print("               OPCIÓN: MOVIMIENTO              ")
        print("==============================================")
        print("🔹 Funciones disponibles:")
        print("   1. Velocidad aumentada (x2)")
        print("   2. Salto aumentado (x3)")
        print("   3. Desactivar funciones de movimiento")
        print("==============================================")
        
        local Personaje = game:GetService("Players").LocalPlayer.Character or game:GetService("Players").LocalPlayer.CharacterAdded:Wait()
        local Humanoide = Personaje:WaitForChild("Humanoid")
        
        local function ActivarVelocidad()
            Humanoide.WalkSpeed = 32
            print("[MOVIMIENTO] → Velocidad aumentada a x2")
        end
        
        local function ActivarSalto()
            Humanoide.JumpPower = 75
            print("[MOVIMIENTO] → Salto aumentado a x3")
        end
        
        local function RestaurarMovimiento()
            Humanoide.WalkSpeed = 16
            Humanoide.JumpPower = 25
            print("[MOVIMIENTO] → Funciones de movimiento restauradas")
        end
        
        ActivarVelocidad()
        ActivarSalto()
        wait(5) -- Mantener activado por defecto 5 segundos (opcional)
        RestaurarMovimiento()
    end,

    -- Opción 2: Funciones de Interacción
    Interaccion = function()
        print("\n==============================================")
        print("              OPCIÓN: INTERACCIÓN              ")
        print("==============================================")
        print("🔹 Funciones disponibles:")
        print("   1. Recoger objetos cercanos automáticamente")
        print("   2. Activar todos los botones/interruptores")
        print("   3. Desactivar funciones de interacción")
        print("==============================================")
        
        local JugadorLocal = game:GetService("Players").LocalPlayer
        local Personaje = JugadorLocal.Character or JugadorLocal.CharacterAdded:Wait()
        local HumanoideRootPart = Personaje:WaitForChild("HumanoidRootPart")
        
        local InteraccionActiva = true

        local function RecogerObjetos()
            while InteraccionActiva do
                wait(1)
                for _, objeto in pairs(game:GetService("Workspace"):GetDescendants()) do
                    if objeto:IsA("Part") and objeto.Name:lower():find("objeto") or objeto.Name:lower():find("item") then
                        local Distancia = (HumanoideRootPart.Position - objeto.Position).Magnitude
                        if Distancia <= 20 then
                            objeto.Position = HumanoideRootPart.Position + Vector3.new(0, 2, 0)
                            print("[INTERACCIÓN] → Objeto recogido: "..objeto.Name)
                        end
                    end
                end
            end
        end

        local function ActivarBotones()
            for _, boton in pairs(game:GetService("Workspace"):GetDescendants()) do
                if boton:IsA("ClickDetector") or boton:IsA("ProximityPrompt") then
                    if boton:IsA("ClickDetector") then
                        fireclickdetector(boton)
                    else
                        fireproximityprompt(boton)
                    end
                    print("[INTERACCIÓN] → Botón/Interruptor activado: "..boton.Parent.Name)
                end
            end
        end

        spawn(RecogerObjetos)
        ActivarBotones()
        wait(10) -- Mantener activado por defecto 10 segundos
        InteraccionActiva = false
        print("[INTERACCIÓN] → Funciones de interacción desactivadas")
    end,

    -- Opción 3: Configuración del Script
    ConfiguracionScript = function()
        print("\n==============================================")
        print("            OPCIÓN: CONFIGURACIÓN             ")
        print("==============================================")
        print("🔹 Opciones disponibles:")
        print("   1. Mostrar/Ocultar FPS")
        print("   2. Optimizar/Restaurar juego")
        print("   3. Ver información del script")
        print("==============================================")
        
        -- Alternar FPS
        if not Configuracion.MostrarFPS then
            ActivarFPS()
        else
            DesactivarFPS()
        end
        
        wait(2)
        
        -- Alternar optimización
        if not Configuracion.OptimizarJuego then
            OptimizarJuegoFuncion()
        else
            RestaurarOptimizacion()
        end
        
        wait(2)
        
        -- Mostrar info del script
        local InfoScript = [[
==============================================
            INFORMACIÓN COMPLETA DEL SCRIPT
==============================================
🔹 Nombre del juego: ]]..Utilidades.NombreJuego..[[
🔹 ID del juego: 89469502395769
🔹 Creador del script: JoseAngel_Blox
🔹 Fecha de creación: 02/06/2026
🔹 Versión del script: ]]..Configuracion.VersionScript..[[
🔹 Compatible con: Delta Executor (Celular)
🔹 Estado actual - Mostrar FPS: ]]..tostring(Configuracion.MostrarFPS)..[[
🔹 Estado actual - Optimizar juego: ]]..tostring(Configuracion.OptimizarJuego)..[[
==============================================
        ]]
        print(InfoScript)
    end,

    -- Opción 4: Salir del Script
    Salir = function()
        print("\n==============================================")
        print("                OPCIÓN: SALIR                 ")
        print("==============================================")
        print("🔹 Gracias por usar el script oficial!")
        print("🔹 Creador: JoseAngel_Blox")
        print("🔹 ¡Hasta la próxima!")
        print("==============================================")
        
        -- Limpiar elementos creados
        if FpsLabel then FpsLabel:Destroy() end
        Configuracion.MostrarFPS = false
        if Configuracion.OptimizarJuego then RestaurarOptimizacion() end
        
        -- Finalizar script
        wait(2)
        return
    end
}

-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- MENÚ PRINCIPAL DEL SCRIPT
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
local function MostrarMenu()
    while true do
        print("\n==============================================")
        print("                  MENÚ PRINCIPAL               ")
        print("==============================================")
        print("🔹 SELECCIONA UNA OPCIÓN:")
        print("   1. Funciones de Movimiento")
        print("   2. Funciones de Interacción")
        print("   3. Configuración del Script")
        print("   4. Salir del Script")
        print("==============================================")
        
        -- Simular selección de opción (adaptable a entrada del executor)
        print("\n🔹 Escribe el número de la opción deseada:")
        
        -- Para celulares con Delta Executor, se puede usar la función de entrada o seleccionar por defecto
        -- Aquí se ejecutan las opciones en orden para demostración, pero en uso real se adapta a la entrada del usuario
        FuncionesJuego.Movimiento()
        wait(3)
        FuncionesJuego.Interaccion()
        wait(3)
        FuncionesJuego.ConfiguracionScript()
        wait(3)
        FuncionesJuego.Salir()
        break
    end
end

-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- EJECUCIÓN PRINCIPAL DEL SCRIPT
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
local function EjecutarScript()
    -- Verificar que el juego sea el correcto
    if game.PlaceId ~= 89469502395769 then
        print("[ERROR] → Este script solo es compatible con el juego ID: 89469502395769")
        return
    end

    -- Mostrar bienvenida y menú
    MostrarBienvenida()
    MostrarMenu()
end

-- Iniciar script
EjecutarScript()
