//
//  PersistenciaService.swift
//  Tema14Swift
//
//  Created by Jesus Alberto Garza Guerrero on 19/11/25.
//

import Foundation

class PersistenciaService {
    static let shared = PersistenciaService()
    
    private let userDefaults = UserDefaults.standard
    private let tareasKey = "tareas_guardadas"
    
    private init() {}
    
    // MARK: - Guardar Tareas
    func guardarTareas(_ tareas: [Tarea]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(tareas.map { TareaDTO(from: $0) })
            userDefaults.set(data, forKey: tareasKey)
        } catch {
            print("Error al guardar tareas: \(error)")
        }
    }
    
    // MARK: - Cargar Tareas
    func cargarTareas() -> [Tarea] {
        guard let data = userDefaults.data(forKey: tareasKey) else {
            return []
        }
        
        do {
            let decoder = JSONDecoder()
            let tareasDTO = try decoder.decode([TareaDTO].self, from: data)
            return tareasDTO.map { $0.toTarea() }
        } catch {
            print("Error al cargar tareas: \(error)")
            return []
        }
    }
    
    // MARK: - Exportar JSON
    func exportarJSON(tareas: [Tarea]) -> String? {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(tareas.map { TareaDTO(from: $0) })
            return String(data: data, encoding: .utf8)
        } catch {
            print("Error al exportar JSON: \(error)")
            return nil
        }
    }
    
    // MARK: - Importar JSON
    func importarJSON(_ json: String) -> [Tarea]? {
        guard let data = json.data(using: .utf8) else { return nil }
        
        do {
            let decoder = JSONDecoder()
            let tareasDTO = try decoder.decode([TareaDTO].self, from: data)
            return tareasDTO.map { $0.toTarea() }
        } catch {
            print("Error al importar JSON: \(error)")
            return nil
        }
    }
}

// MARK: - DTO para Codificación
struct TareaDTO: Codable {
    let id: UUID
    let titulo: String
    let descripcion: String
    let prioridad: String
    let fechaVencimiento: Date
    let completada: Bool
    let etiquetas: [String]
    let notas: String
    let fechaCreacion: Date
    
    init(from tarea: Tarea) {
        self.id = tarea.id
        self.titulo = tarea.titulo
        self.descripcion = tarea.descripcion
        self.prioridad = tarea.prioridad
        self.fechaVencimiento = tarea.fechaVencimiento
        self.completada = tarea.completada
        self.etiquetas = tarea.etiquetas
        self.notas = tarea.notas
        self.fechaCreacion = tarea.fechaCreacion
    }
    
    func toTarea() -> Tarea {
        Tarea(
            id: id,
            titulo: titulo,
            descripcion: descripcion,
            prioridad: Tarea.Prioridad(rawValue: prioridad) ?? .media,
            fechaVencimiento: fechaVencimiento,
            completada: completada,
            etiquetas: etiquetas,
            notas: notas,
            fechaCreacion: fechaCreacion
        )
    }
}
