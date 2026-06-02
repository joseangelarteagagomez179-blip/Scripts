# 🎮 Kick a Lucky Block - Script Completo
[![Roblox](https://img.shields.io/badge/Platform-Roblox-red.svg)](https://www.roblox.com)
[![Executor](https://img.shields.io/badge/Executor-Delta-blue.svg)](https://delta-executor.com)
[![Version](https://img.shields.io/badge/Version-1.0-green.svg)]()

Script completo, optimizado y organizado para el juego **Kick a Lucky Block** de Roblox. Diseñado especialmente para dispositivos móviles y compatible con el ejecutor **Delta**.

> ⚠️ **Advertencia**: El uso de scripts puede violar los Términos de Servicio de Roblox. Este proyecto es **solo con fines educativos**. Úsalo bajo tu propia responsabilidad.

---

## 📋 Información General
- **👤 Creador:** JoseAngel_Blox
- **📅 Fecha de creación:** 02/06/2026
- **🎯 Juego:** [Kick a Lucky Block](https://www.roblox.com/es/games/89469502395769/Kick-a-Lucky-Block)
- **📱 Compatibilidad:** Android / Móvil
- **⚙️ Ejecutor:** Delta (Recomendado), Fluxus, Hydrogen
- **🧠 Lenguaje:** Lua

---

## ✨ Funciones Principales

### 🤖 Auto Farm
- ✅ **Pateo Perfecto:** Timing exacto automático para siempre dar "Perfect Kick".
- ✅ **Recolección:** Recoge automáticamente el ítem `Brainrot` al caer.
- ✅ **Regreso Seguro:** Vuelve automáticamente a la zona segura tras cada acción.
- ✅ **Velocidad Personalizada:** Aumenta velocidad solo cuando está activado.
- ✅ **Control:** Tecla `F` o botón táctil para activar/desactivar.

### ⚖️ Auto Weight
- ✅ Equipa las pesas automáticamente.
- ✅ Botón táctil visible y personalizable.
- ✅ Compatible con la función *Enable Move*.

### 💰 Auto Collect Money
- ✅ Detecta dinero acumulado automáticamente.
- ✅ Se mueve al punto de recolección y lo recoge.
- ✅ Velocidad y tiempo de espera configurables.

### 🏃 Enable Move
- ✅ **Anula el bloqueo:** Permite caminar libremente mientras llevas pesas (el juego normalmente lo bloquea).
- ✅ Velocidad de movimiento ajustable.
- ✅ Vuelve al comportamiento original al desactivar.

### ✈️ Fly (Volar)
- ✅ Gravedad cero, vuelo libre.
- ✅ **Controles táctiles:**
  - Mover palanca = dirección de la cámara.
  - Deslizar 2 dedos = Subir / Bajar.
- ✅ **Slider de velocidad:** Ajustable en tiempo real (16 - 250).
- ✅ Totalmente personalizable (colores, posición, tamaño).

### ⚡ WalkSpeed Infinito
- ✅ Velocidad extrema (100 - 1000+).
- ✅ Anula límites de velocidad del juego.
- ✅ Control deslizante en pantalla.
- ✅ Restauración automática al desactivar.

### 👻 Invisible
- ✅ Personaje 100% invisible.
- ✅ Oculta cuerpo, sombras, efectos y rótulos.
- ✅ Se reaplica automáticamente al reaparecer.
- ✅ Sin errores visuales ni lag.

### 📊 Configuraciones y Optimización
- ✅ **Mostrar FPS:** Contador en tiempo real, posición y color personalizable.
- ✅ **Optimización Extrema:** Consume <1% de CPU, sin retrasos, actualización inteligente.

---

## ⚙️ Configuración
Todas las opciones editables están al inicio del archivo, dentro de la tabla `Config`:

```lua
local Config = {
    -- Auto Farm
    AutoFarm_Key = Enum.KeyCode.F,
    AutoFarm_WalkSpeed = 50,
    AutoFarm_WaitTime = 2,

    -- Auto Weight
    AutoWeight_Pos = {X = 50, Y = 150},
    AutoWeight_Size = {W = 120, H = 50},

    -- Fly
    Fly_SliderMin = 16,
    Fly_SliderMax = 250,
    
    -- ... y muchas más
}
