--!strict
-- ==============================================
-- NOMBRE DEL SCRIPT: JoseAngel_Blox Fly
-- ==============================================
-- ⚙️ INFORMACIÓN DEL SCRIPT
-- Creador: JoseAngel_Blox
-- Fecha de lanzamiento: 06/07/2026
-- Versión: 1.2
-- ==============================================

-- ==============================================
-- 📖 MANUAL DE USO
-- ==============================================
local function MostrarInformacion()
    local mensaje = [[
📢 JOSEANGEL_BLOX FLY - VERSIÓN 1.2

✅ ¿Cómo usarlo?
🖥️ EN PC:
  - Toca la pieza azul para ACTIVAR/DESACTIVAR vuelo
  - W A S D = moverte
  - ESPACIO = subir
  - MAYÚSCULAS = bajar
  - Tecla G = aumentar velocidad
  - Tecla F = disminuir velocidad
  ✅ Incluye Noclip automático

📱 EN MÓVIL:
  - Toca la pieza azul para ACTIVAR/DESACTIVAR
  - Joystick = moverte
  - Botón de salto = subir
  - Botón de agacharse = bajar
  ✅ Incluye Noclip automático

📌 Creado por: JoseAngel_Blox
📅 Lanzamiento: 06/07/2026
]]
    print("\n" .. mensaje .. "\n")
end

MostrarInformacion()

-- ==============================================
-- PASO 1: Crear pieza activadora
-- ==============================================
local pieza = Instance.new("Part")
pieza.Name = "ActivadorVuelo"
pieza.Shape = Enum.PartType.Block
pieza.Size = Vector3.new(4, 4, 0.5)
pieza.Position = Vector3.new(0, 5, 0)
pieza.CornerRadius = 0.8
pieza.BrickColor = BrickColor.new("Bright blue")
pieza.Material = Enum.Material.Plastic
pieza.Anchored = true
pieza.CanCollide = true
pieza.Parent = workspace

-- ==============================================
-- 🚀 PASO 4: MAIN - SISTEMA DE VUELO + NOCLIP
-- ==============================================
-- Variables de control
local vueloActivo = false
local velocidadVuelo = 50
local velocidadMaxima = 200
local velocidadMinima = 10
local conexionVuelo: RBXScriptConnection? = nil

-- Función principal de vuelo
local function ActivarVuelo(jugador: Player)
    if vueloActivo then return end
    vueloActivo = true

    local personaje = jugador.Character
    if not personaje then return end
    local humanoide = personaje:FindFirstChildOfClass("Humanoid")
    local raiz = personaje:FindFirstChild("HumanoidRootPart") :: BasePart?
    if not humanoide or not raiz then return end

    -- Configuración inicial
    humanoide.PlatformStand = true
    raiz.Velocity = Vector3.new(0, 0, 0)

    -- Bucle de vuelo + Noclip automático
    conexionVuelo = game:GetService("RunService").RenderStepped:Connect(function()
        if not vueloActivo or not raiz or not humanoide then return end

        -- 🚫 NOCLIP: desactivar colisiones mientras vuela
        for _, parte in ipairs(personaje:GetChildren()) do
            if parte:IsA("BasePart") then
                parte.CanCollide = false
            end
        end

        -- Capturar controles
        local camara = workspace.CurrentCamera
        local direccion = Vector3.new()
        local ejes = game:GetService("UserInputService")

        -- Movimiento adelante / atrás / lados
        if ejes:IsKeyDown(Enum.KeyCode.W) then direccion += camara.CFrame.LookVector end
        if ejes:IsKeyDown(Enum.KeyCode.S) then direccion -= camara.CFrame.LookVector end
        if ejes:IsKeyDown(Enum.KeyCode.A) then direccion -= camara.CFrame.RightVector end
        if ejes:IsKeyDown(Enum.KeyCode.D) then direccion += camara.CFrame.RightVector end

        -- Subir / Bajar
        if ejes:IsKeyDown(Enum.KeyCode.Space) then direccion += Vector3.new(0, 1, 0) end
        if ejes:IsKeyDown(Enum.KeyCode.LeftShift) then direccion -= Vector3.new(0, 1, 0) end

        -- Ajustar velocidad
        direccion = direccion.Unit * velocidadVuelo
        raiz.Velocity = direccion

        -- Cambiar velocidad con teclas
        if ejes:IsKeyDown(Enum.KeyCode.G) then
            velocidadVuelo = math.min(velocidadVuelo + 2, velocidadMaxima)
        end
        if ejes:IsKeyDown(Enum.KeyCode.F) then
            velocidadVuelo = math.max(velocidadVuelo - 2, velocidadMinima)
        end
    end)

    print("✅ VUELO ACTIVADO | Velocidad: " .. velocidadVuelo .. " | Noclip activo")
end

-- Función para desactivar vuelo
local function DesactivarVuelo(jugador: Player)
    if not vueloActivo then return end
    vueloActivo = false

    if conexionVuelo then
        conexionVuelo:Disconnect()
        conexionVuelo = nil
    end

    local personaje = jugador.Character
    if personaje then
        local humanoide = personaje:FindFirstChildOfClass("Humanoid")
        if humanoide then
            humanoide.PlatformStand = false
        end
        -- Restaurar colisiones
        for _, parte in ipairs(personaje:GetChildren()) do
            if parte:IsA("BasePart") then
                parte.CanCollide = true
            end
        end
    end

    print("❌ VUELO DESACTIVADO | Colisiones restauradas")
end

-- Función interruptor TOGGLE al tocar la pieza
local function AlTocarPieza(hit: BasePart)
    local personaje = hit.Parent
    local jugador = game.Players:GetPlayerFromCharacter(personaje)
    if not jugador then return end

    if vueloActivo then
        DesactivarVuelo(jugador)
    else
        ActivarVuelo(jugador)
    end
end

-- Conectar el evento de toque
pieza.Touched:Connect(AlTocarPieza)

print("✅ Paso 4 completado: Sistema de vuelo con Noclip incluido listo")
