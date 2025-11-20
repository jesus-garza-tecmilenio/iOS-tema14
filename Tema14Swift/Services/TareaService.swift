//
//  TareaService.swift
//  Tema14Swift
//
//  Created by Jesus Alberto Garza Guerrero on 19/11/25.
//

import Foundation
import Combine

class TareaService: ObservableObject {
    @Published var tareas: [Tarea] = []
    
    private let persistencia = PersistenciaService.shared
    
    init() {
        cargarTareas()
    }
    
    // MARK: - CRUD Operations
    
    func crearTarea(_ tarea: Tarea) {
        tareas.append(tarea)
        guardar()
    }
    
    func actualizarTarea(_ tarea: Tarea) {
        if let index = tareas.firstIndex(where: { $0.id == tarea.id }) {
            tareas[index] = tarea
            guardar()
        }
    }
    
    func eliminarTarea(_ id: UUID) {
        tareas.removeAll { $0.id == id }
        guardar()
    }
    
    func eliminarTarea(at offsets: IndexSet, from filteredTareas: [Tarea]) {
        for index in offsets {
            let tarea = filteredTareas[index]
            eliminarTarea(tarea.id)
        }
    }
    
    func toggleCompletada(_ tarea: Tarea) {
        if let index = tareas.firstIndex(where: { $0.id == tarea.id }) {
            tareas[index].completada.toggle()
            guardar()
        }
    }
    
    // MARK: - Filtrado y Búsqueda
    
    enum FiltroEstado {
        case todas
        case completadas
        case pendientes
    }
    
    func filtrarTareas(por estado: FiltroEstado) -> [Tarea] {
        switch estado {
        case .todas:
            return tareas
        case .completadas:
            return tareas.filter { $0.completada }
        case .pendientes:
            return tareas.filter { !$0.completada }
        }
    }
    
    func filtrarPorPrioridad(_ prioridad: Tarea.Prioridad?) -> [Tarea] {
        guard let prioridad = prioridad else { return tareas }
        return tareas.filter { $0.prioridadEnum == prioridad }
    }
    
    func buscarTareas(por texto: String) -> [Tarea] {
        if texto.isEmpty {
            return tareas
        }
        
        let textoLower = texto.lowercased()
        return tareas.filter {
            $0.titulo.lowercased().contains(textoLower) ||
            $0.descripcion.lowercased().contains(textoLower) ||
            $0.notas.lowercased().contains(textoLower)
        }
    }
    
    // MARK: - Ordenamiento
    
    enum OrdenCriterio {
        case fecha
        case prioridad
        case estado
        case titulo
    }
    
    func ordenarTareas(_ tareas: [Tarea], por criterio: OrdenCriterio) -> [Tarea] {
        switch criterio {
        case .fecha:
            return tareas.sorted { $0.fechaVencimiento < $1.fechaVencimiento }
        case .prioridad:
            let orden: [Tarea.Prioridad: Int] = [.urgente: 0, .alta: 1, .media: 2, .baja: 3]
            return tareas.sorted { (orden[$0.prioridadEnum] ?? 99) < (orden[$1.prioridadEnum] ?? 99) }
        case .estado:
            return tareas.sorted { !$0.completada && $1.completada }
        case .titulo:
            return tareas.sorted { $0.titulo < $1.titulo }
        }
    }
    
    // MARK: - Persistencia
    
    private func guardar() {
        persistencia.guardarTareas(tareas)
    }
    
    private func cargarTareas() {
        tareas = persistencia.cargarTareas()
    }
    
    func exportarJSON() -> String? {
        persistencia.exportarJSON(tareas: tareas)
    }
    
    func importarJSON(_ json: String) -> Bool {
        guard let tareasImportadas = persistencia.importarJSON(json) else {
            return false
        }
        tareas = tareasImportadas
        guardar()
        return true
    }
}
