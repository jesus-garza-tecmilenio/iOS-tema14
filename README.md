# Sistema de Gestión de Tareas Avanzado - Tema14Swift

## 📋 Descripción

Aplicación iOS completa de gestión de tareas que integra todos los conceptos del Tema 14: Pantallas de Entrada de Información. Desarrollada en SwiftUI con arquitectura MVVM, validación en tiempo real y persistencia de datos.

## ✨ Características Principales

### Funcionalidades Core
- ✅ Crear, editar y eliminar tareas
- ✅ Marcar tareas como completadas
- ✅ Validación en tiempo real de todos los campos
- ✅ Persistencia de datos con UserDefaults
- ✅ Exportación e importación de tareas en JSON

### Filtros y Búsqueda
- 🔍 Búsqueda por título, descripción o notas
- 📊 Filtrado por estado (Todas, Completadas, Pendientes)
- 🎯 Filtrado por prioridad (Baja, Media, Alta, Urgente)
- 📅 Ordenamiento por fecha, prioridad, estado o título

### Interfaz de Usuario
- 🎨 Diseño moderno y profesional
- 🌓 Soporte para tema claro y oscuro
- 📱 Responsive (vertical y horizontal)
- ✨ Animaciones suaves
- ♿️ Soporte para accesibilidad

## 🏗️ Arquitectura

El proyecto sigue el patrón **MVVM (Model-View-ViewModel)** con separación clara de responsabilidades:

```
Tema14Swift/
├── Models/
│   └── Tarea.swift                    # Modelo de datos principal
├── ViewModels/
│   ├── ListaTareasViewModel.swift     # Lógica de la lista
│   └── FormularioTareaViewModel.swift # Lógica del formulario
├── Views/
│   ├── ListaTareasView.swift          # Vista principal
│   ├── FormularioTareaView.swift      # Formulario crear/editar
│   ├── DetallesTareaView.swift        # Vista de detalles
│   └── Components/
│       ├── CeldaTareaView.swift       # Celda de tarea
│       ├── ValidacionView.swift       # Mensajes de error
│       └── ContadorCaracteresView.swift # Contador
├── Services/
│   ├── TareaService.swift             # Gestión de tareas
│   ├── PersistenciaService.swift      # Guardado/carga
│   └── ValidacionService.swift        # Validaciones
├── Protocols/
│   └── TareaDelegate.swift            # Comunicación entre vistas
└── Utils/
    ├── Constantes.swift               # Constantes de la app
    └── Extensiones.swift              # Extensiones útiles
```

## 📱 Pantallas

### 1. Lista de Tareas (ListaTareasView)
- Muestra todas las tareas con redimensionamiento dinámico
- Celdas personalizadas con información completa
- Estadísticas (total, pendientes, completadas)
- Acciones de deslizar para eliminar
- Botón flotante para crear nueva tarea

### 2. Formulario de Tarea (FormularioTareaView)
**Sección 1: Información Básica**
- Título (requerido, máx. 100 caracteres)
- Prioridad (Baja, Media, Alta, Urgente)
- Fecha de vencimiento (no puede ser pasada)

**Sección 2: Descripción y Notas**
- Descripción (máx. 500 caracteres)
- Notas adicionales (máx. 1000 caracteres)
- Contador de caracteres en tiempo real

**Sección 3: Categorización**
- Toggle para marcar como completada
- Sistema de etiquetas personalizado
- Etiquetas predefinidas sugeridas

**Sección 4: Acciones**
- Botón Guardar (deshabilitado si no es válido)
- Botón Cancelar
- Botón Eliminar (solo en edición)

### 3. Detalles de Tarea (DetallesTareaView)
- Vista completa de toda la información
- Estado y prioridad destacados
- Información temporal (días restantes)
- Acciones rápidas desde el menú

## 🎯 Validaciones Implementadas

### Título
- ❌ No puede estar vacío
- ❌ Máximo 100 caracteres
- ✅ Feedback visual en tiempo real

### Descripción
- ❌ Máximo 500 caracteres
- ✅ Contador de caracteres
- ✅ Cambio de color al exceder límite

### Notas
- ❌ Máximo 1000 caracteres
- ✅ Contador de caracteres
- ✅ Cambio de color al exceder límite

### Fecha de Vencimiento
- ❌ No puede ser una fecha pasada
- ✅ Validación al seleccionar
- ✅ Mensaje de error claro

## 🎨 Sistema de Diseño

### Colores por Prioridad
| Prioridad | Color | Hex |
|-----------|-------|-----|
| Baja | 🟢 Verde | #10B981 |
| Media | 🔵 Azul | #0EA5E9 |
| Alta | 🟠 Naranja | #F59E0B |
| Urgente | 🔴 Rojo | #EF4444 |

### Espaciado
- Pequeño: 8px
- Medio: 16px
- Grande: 24px

### Tipografía
- **Título**: 20px, peso 700
- **Subtítulo**: 16px, peso 600
- **Body**: 14px, peso 400
- **Caption**: 12px, peso 400

## 💾 Persistencia de Datos

### Métodos Implementados
- `guardarTareas()`: Guarda todas las tareas en UserDefaults
- `cargarTareas()`: Carga tareas al iniciar la app
- `exportarJSON()`: Exporta tareas a formato JSON
- `importarJSON()`: Importa tareas desde JSON

### Formato de Almacenamiento
Las tareas se guardan como objetos JSON codificados en UserDefaults, permitiendo persistencia entre sesiones de la app.

## 🔧 Requisitos Técnicos

- **iOS**: 15.0 o superior
- **Xcode**: 15.0 o superior
- **Swift**: 5.9 o superior
- **Frameworks**: SwiftUI, Foundation

## 📚 Conceptos de SwiftUI Aplicados

### Formularios y Controles
- ✅ Form con múltiples secciones
- ✅ TextField con validación
- ✅ TextEditor con altura dinámica
- ✅ Picker para selecciones
- ✅ DatePicker con rango personalizado
- ✅ Toggle para estados booleanos

### Gestión de Estado
- ✅ @State para estado local
- ✅ @StateObject para ViewModels
- ✅ @ObservedObject para servicios
- ✅ @Published para propiedades reactivas
- ✅ @Environment para dismiss

### Paso de Datos
- ✅ Protocolos personalizados (TareaDelegate)
- ✅ Closures para callbacks
- ✅ Binding para comunicación bidireccional

### Redimensionamiento Dinámico
- ✅ Celdas que se adaptan al contenido
- ✅ FlowLayout personalizado para etiquetas
- ✅ TextEditor con altura mínima
- ✅ ScrollView para contenido largo

### Animaciones
- ✅ withAnimation() para cambios de estado
- ✅ Transiciones suaves
- ✅ Feedback visual inmediato

## 🧪 Testing

### Casos de Prueba Implementados

1. **Validación de Título**
   - Título vacío → Error mostrado
   - Título > 100 caracteres → Error mostrado
   - Título válido → Sin errores

2. **Validación de Fecha**
   - Fecha pasada → Error mostrado
   - Fecha futura → Sin errores
   - Hoy → Sin errores

3. **Persistencia**
   - Crear tarea → Guardar → Reiniciar app → Tarea existe
   - Editar tarea → Cambios persisten
   - Eliminar tarea → No aparece al reiniciar

4. **Filtros**
   - Filtrar por completadas → Solo muestra completadas
   - Buscar por texto → Resultados correctos
   - Ordenar por prioridad → Orden correcto

## 📖 Cómo Usar la Aplicación

### Crear Nueva Tarea
1. Toca el botón flotante "+" en la lista
2. Completa el título (obligatorio)
3. Selecciona la prioridad
4. Elige la fecha de vencimiento
5. Añade descripción y notas (opcional)
6. Agrega etiquetas (opcional)
7. Toca "Guardar"

### Editar Tarea
1. Toca una tarea en la lista
2. Realiza los cambios necesarios
3. Toca "Guardar"

### Marcar como Completada
- Opción 1: Toca el círculo en la celda
- Opción 2: Usa el menú contextual (mantén presionado)
- Opción 3: Toggle en la vista de edición

### Eliminar Tarea
- Opción 1: Desliza a la izquierda y toca eliminar
- Opción 2: Menú contextual → Eliminar
- Opción 3: Vista de edición → Eliminar

### Filtrar y Buscar
1. Usa la barra de búsqueda para texto
2. Toca el ícono de filtros para filtrar por:
   - Estado (Todas/Completadas/Pendientes)
   - Prioridad (Todas/Baja/Media/Alta/Urgente)
3. Usa el menú de ordenamiento para cambiar el orden

### Exportar Tareas
1. Toca el menú "..." en la barra superior
2. Selecciona "Exportar JSON"
3. Copia el JSON generado

## 🎓 Conceptos de Aprendizaje

Este proyecto demuestra dominio de:

1. **Construcción de formularios complejos** con múltiples controles
2. **Validación de datos en tiempo real** con feedback visual
3. **Paso de datos entre vistas** usando protocolos y closures
4. **Redimensionamiento dinámico** de celdas y vistas
5. **Gestión de estado complejo** en aplicaciones grandes
6. **Patrones de arquitectura** MVVM y delegados
7. **Persistencia de datos** local
8. **Diseño de interfaz** profesional y accesible

## 🚀 Instalación y Ejecución

### Clonar el Repositorio
```bash
git clone https://github.com/jesus-garza-tecmilenio/iOS-tema14.git
cd iOS-tema14
```

### Abrir en Xcode
```bash
open Tema14Swift.xcodeproj
```

### Ejecutar
1. Selecciona un simulador (iPhone 15 recomendado)
2. Presiona `Cmd + R` o haz clic en el botón ▶️
3. La app se compilará y ejecutará en el simulador

### Compilar desde Terminal
```bash
xcodebuild -project Tema14Swift.xcodeproj \
  -scheme Tema14Swift \
  -sdk iphonesimulator \
  build
```

## 📊 Métricas del Proyecto

### Archivos de Código
- **Total de archivos Swift:** 16
- **Líneas de código:** ~2,400+
- **ViewModels:** 2
- **Views:** 3 principales + 3 componentes
- **Services:** 3
- **Models:** 1
- **Protocols:** 1

### Características Técnicas
- **Arquitectura:** MVVM
- **Framework:** SwiftUI
- **iOS mínimo:** 15.0+
- **Persistencia:** UserDefaults + JSON
- **Validación:** Tiempo real
- **Estado:** Combine + @Published

## 🚀 Mejoras Futuras (Opcional)

- [ ] CoreData para persistencia más robusta
- [ ] Notificaciones locales para recordatorios
- [ ] Widgets para la pantalla de inicio
- [ ] Soporte para iCloud sync
- [ ] Gráficos de productividad
- [ ] Temas personalizables
- [ ] Undo/Redo functionality
- [ ] Compartir tareas con otros usuarios

## 👨‍💻 Autor

**Jesús Alberto Garza Guerrero**  
Desarrollo iOS - SwiftUI  
Tema 14: Pantallas de Entrada de Información

## 📄 Licencia

Este proyecto fue desarrollado como parte de mi aprendizaje en desarrollo iOS con SwiftUI.

---

**Versión:** 1.0  
**Última actualización:** Noviembre 2025  
**Desarrollado por:** Jesús Alberto Garza Guerrero

## 📞 Enlaces

- **Repositorio:** https://github.com/jesus-garza-tecmilenio/iOS-tema14
- **Documentación adicional:** Ver archivos `IMPLEMENTACION.md`, `QUICKSTART.md` y `PROYECTO_COMPLETADO.md`
