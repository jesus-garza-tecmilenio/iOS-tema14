# 🚀 Guía de Inicio Rápido - Tema14Swift

## Ejecutar el Proyecto

### Opción 1: Usando Xcode
```bash
cd /Users/jesusgarza/Dev/ReposClases/Tema14Swift
open Tema14Swift.xcodeproj
```
Luego presiona `Cmd + R` para ejecutar.

### Opción 2: Desde Terminal
```bash
cd /Users/jesusgarza/Dev/ReposClases/Tema14Swift
xcodebuild -project Tema14Swift.xcodeproj -scheme Tema14Swift -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 17' build
```

---

## 📱 Funcionalidades Principales

### 1. Crear Nueva Tarea
1. Toca el botón **+** flotante (esquina inferior derecha)
2. Completa los campos:
   - **Título** (obligatorio, máx. 100 caracteres)
   - **Prioridad** (Baja, Media, Alta, Urgente)
   - **Fecha de Vencimiento**
   - **Descripción** (opcional, máx. 500 caracteres)
   - **Notas** (opcional, máx. 1000 caracteres)
   - **Etiquetas** (opcional)
3. Toca **Guardar**

### 2. Editar Tarea
- Toca cualquier tarea en la lista
- Modifica los campos deseados
- Toca **Guardar**

### 3. Marcar como Completada
- Toca el círculo a la izquierda de la tarea
- El estado cambia inmediatamente

### 4. Eliminar Tarea
- **Opción A:** Desliza la tarea hacia la izquierda
- **Opción B:** Mantén presionada la tarea → **Eliminar**
- **Opción C:** Edita la tarea → **Eliminar Tarea**

### 5. Buscar Tareas
- Escribe en la barra de búsqueda superior
- La lista se filtra en tiempo real
- Busca por: título, descripción o notas

### 6. Filtrar Tareas
Toca el ícono **⚙️ Filtros** en la barra superior:
- **Por Estado:** Todas, Completadas, Pendientes
- **Por Prioridad:** Todas, Baja, Media, Alta, Urgente

### 7. Ordenar Tareas
Toca el ícono **•••** en la barra superior → **Ordenar por:**
- Fecha de vencimiento
- Prioridad
- Estado (completada/pendiente)
- Título (alfabético)

### 8. Exportar Tareas
1. Toca el ícono **•••** en la barra superior
2. Selecciona **Exportar JSON**
3. Copia el JSON generado

---

## 🎨 Colores de Prioridad

| Prioridad | Color | Cuándo Usar |
|-----------|-------|-------------|
| 🟢 **Baja** | Verde | Tareas no urgentes, pueden esperar |
| 🔵 **Media** | Azul | Tareas importantes pero sin prisa |
| 🟠 **Alta** | Naranja | Tareas que requieren atención pronto |
| 🔴 **Urgente** | Rojo | Tareas críticas, hacer HOY |

---

## ⚠️ Validaciones Implementadas

### Título
- ❌ No puede estar vacío
- ❌ Máximo 100 caracteres
- ✅ Se muestra contador en tiempo real

### Descripción
- ❌ Máximo 500 caracteres
- ✅ Contador cambia a rojo al exceder límite
- ✅ Borde rojo si hay error

### Notas
- ❌ Máximo 1000 caracteres
- ✅ Contador cambia a rojo al exceder límite
- ✅ Borde rojo si hay error

### Fecha de Vencimiento
- ❌ No puede ser una fecha pasada
- ✅ Se muestra mensaje de error claro
- ✅ Por defecto: mañana

---

## 📊 Estadísticas

En la parte superior de la lista verás tres tarjetas:
- **Total:** Todas las tareas creadas
- **Pendientes:** Tareas sin completar
- **Completadas:** Tareas marcadas como completadas

Se actualizan automáticamente al crear, editar o eliminar tareas.

---

## 🏷️ Sistema de Etiquetas

### Etiquetas Predefinidas
Al crear/editar una tarea, verás estas sugerencias:
- Trabajo
- Personal
- Urgente
- Familia
- Estudios
- Salud
- Compras
- Hogar

### Agregar Etiqueta Personalizada
1. En el formulario, ve a la sección **Categorización**
2. Escribe el nombre de la etiqueta
3. Toca el botón **+** o presiona Enter

### Eliminar Etiqueta
- Toca la **X** en la etiqueta que deseas eliminar

---

## 💾 Persistencia

### Guardado Automático
- Todas las tareas se guardan automáticamente
- No necesitas hacer nada especial
- Los datos persisten incluso si cierras la app

### Exportar Datos
1. Menú **•••** → **Exportar JSON**
2. Copia el texto generado
3. Guárdalo donde prefieras

### Importar Datos (Futuro)
Próximamente podrás importar tareas desde JSON.

---

## 🎯 Tips y Trucos

### 1. Acceso Rápido a Acciones
Mantén presionada cualquier tarea para ver un menú contextual con:
- Editar
- Marcar como completada/pendiente
- Eliminar

### 2. Vista de Detalles
Toca una tarea para ver todos sus detalles:
- Información completa
- Tiempo restante
- Todas las etiquetas
- Notas completas

### 3. Combinar Filtros
Puedes combinar:
- Búsqueda de texto
- Filtro por estado
- Filtro por prioridad
- Ordenamiento

Ejemplo: Buscar "reunión" + Filtrar por "Pendientes" + Ordenar por "Fecha"

### 4. Estadísticas Visuales
Las tarjetas de estadísticas te dan un vistazo rápido:
- **Azul:** Total de tareas
- **Naranja:** Tareas pendientes (necesitan atención)
- **Verde:** Tareas completadas (bien hecho!)

---

## 🐛 Solución de Problemas

### La app no inicia
```bash
# Limpiar build
cd /Users/jesusgarza/Dev/ReposClases/Tema14Swift
xcodebuild clean
# Volver a construir
xcodebuild -project Tema14Swift.xcodeproj -scheme Tema14Swift build
```

### No se guardan las tareas
- Verifica que tienes permisos de escritura
- Las tareas se guardan en UserDefaults automáticamente
- Reinicia la app para verificar persistencia

### Errores de compilación
```bash
# Verificar errores
xcodebuild -project Tema14Swift.xcodeproj -scheme Tema14Swift build 2>&1 | grep error
```

---

## 📚 Estructura del Proyecto

```
Tema14Swift/
├── Models/               # Modelo de datos (Tarea)
├── ViewModels/           # Lógica de negocio (MVVM)
├── Views/                # Interfaces de usuario
│   ├── ListaTareasView           → Vista principal
│   ├── FormularioTareaView       → Crear/Editar
│   ├── DetallesTareaView         → Ver detalles
│   └── Components/               → Componentes reutilizables
├── Services/             # Servicios (CRUD, Validación, Persistencia)
├── Protocols/            # Protocolos personalizados
└── Utils/                # Utilidades (Constantes, Extensiones)
```

---

## 🎓 Aprendizaje

Este proyecto demuestra:
1. **MVVM** - Arquitectura profesional
2. **Validación en Tiempo Real** - UX mejorada
3. **Persistencia** - Datos que perduran
4. **SwiftUI Avanzado** - Forms, Sheets, Bindings
5. **Gestión de Estado** - @Published, @StateObject
6. **Paso de Datos** - Protocolos y Closures

---

## 📞 Recursos Adicionales

- **Documentación Completa:** `README.md`
- **Resumen de Implementación:** `IMPLEMENTACION.md`
- **Apple SwiftUI:** https://developer.apple.com/swiftui/
- **WWDC Sessions:** https://developer.apple.com/wwdc/

---

## 🎉 ¡Listo!

Ya puedes empezar a usar la app para gestionar tus tareas. 

**Consejo:** Empieza creando algunas tareas de prueba para familiarizarte con todas las funcionalidades.

---

**Versión:** 1.0  
**Última actualización:** 19 de Noviembre, 2025  
**Autor:** Jesús Alberto Garza Guerrero
