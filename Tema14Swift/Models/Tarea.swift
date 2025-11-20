//
//  Tarea.swift
//  Tema14Swift
//
//  Created by Jesus Alberto Garza Guerrero on 19/11/25.
//

import Foundation
import SwiftData

@Model
final class Tarea {
    var id: UUID
    var titulo: String
    var descripcion: String
    var prioridad: String // Stored as String for SwiftData compatibility
    var fechaVencimiento: Date
    var completada: Bool
    var etiquetas: [String]
    var notas: String
    var fechaCreacion: Date
    
    init(
        id: UUID = UUID(),
        titulo: String,
        descripcion: String,
        prioridad: Prioridad,
        fechaVencimiento: Date,
        completada: Bool = false,
        etiquetas: [String] = [],
        notas: String = "",
        fechaCreacion: Date = Date()
    ) {
        self.id = id
        self.titulo = titulo
        self.descripcion = descripcion
        self.prioridad = prioridad.rawValue
        self.fechaVencimiento = fechaVencimiento
        self.completada = completada
        self.etiquetas = etiquetas
        self.notas = notas
        self.fechaCreacion = fechaCreacion
    }
    
    enum Prioridad: String, CaseIterable, Codable {
        case baja = "Baja"
        case media = "Media"
        case alta = "Alta"
        case urgente = "Urgente"
        
        var color: String {
            switch self {
            case .baja: return "green"
            case .media: return "blue"
            case .alta: return "orange"
            case .urgente: return "red"
            }
        }
    }
    
    var prioridadEnum: Prioridad {
        get { Prioridad(rawValue: prioridad) ?? .media }
        set { prioridad = newValue.rawValue }
    }
}
