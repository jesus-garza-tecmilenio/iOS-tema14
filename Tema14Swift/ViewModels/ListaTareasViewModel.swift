//
//  ListaTareasViewModel.swift
//  Tema14Swift
//
//  Created by Jesus Alberto Garza Guerrero on 19/11/25.
//

import Foundation
import SwiftUI
import Combine

class ListaTareasViewModel: ObservableObject {
    @Published var tareaService: TareaService
    @Published var filtroEstado: TareaService.FiltroEstado = .todas
    @Published var filtroPrioridad: Tarea.Prioridad?
    @Published var textoBusqueda: String = ""
    @Published var ordenCriterio: TareaService.OrdenCriterio = .fecha
    @Published var mostrarFormulario = false
    @Published var tareaSeleccionada: Tarea?
    
    init(tareaService: TareaService = TareaService()) {
        self.tareaService = tareaService
    }
    
    // MARK: - Computed Properties
    
    var tareasFiltradas: [Tarea] {
        var tareas = tareaService.filtrarTareas(por: filtroEstado)
        
        if let prioridad = filtroPrioridad {
            tareas = tareas.filter { $0.prioridadEnum == prioridad }
        }
        
        if !textoBusqueda.isEmpty {
            tareas = tareaService.buscarTareas(por: textoBusqueda).filter { tareas.contains($0) }
        }
        
        return tareaService.ordenarTareas(tareas, por: ordenCriterio)
    }
    
    var estadisticas: (total: Int, completadas: Int, pendientes: Int) {
        let total = tareaService.tareas.count
        let completadas = tareaService.tareas.filter { $0.completada }.count
        let pendientes = total - completadas
        return (total, completadas, pendientes)
    }
    
    // MARK: - Actions
    
    func toggleCompletada(_ tarea: Tarea) {
        tareaService.toggleCompletada(tarea)
    }
    
    func eliminarTarea(_ id: UUID) {
        tareaService.eliminarTarea(id)
    }
    
    func eliminarTareas(at offsets: IndexSet) {
        tareaService.eliminarTarea(at: offsets, from: tareasFiltradas)
    }
    
    func crearNuevaTarea() {
        tareaSeleccionada = nil
        mostrarFormulario = true
    }
    
    func editarTarea(_ tarea: Tarea) {
        tareaSeleccionada = tarea
        mostrarFormulario = true
    }
    
    func exportarTareas() -> String? {
        tareaService.exportarJSON()
    }
    
    func importarTareas(_ json: String) -> Bool {
        tareaService.importarJSON(json)
    }
}
