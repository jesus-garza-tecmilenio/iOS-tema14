//
//  FormularioTareaViewModel.swift
//  Tema14Swift
//
//  Created by Jesus Alberto Garza Guerrero on 19/11/25.
//

import Foundation
import SwiftUI
import Combine

class FormularioTareaViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var titulo: String = ""
    @Published var descripcion: String = ""
    @Published var notas: String = ""
    @Published var prioridad: Tarea.Prioridad = .media
    @Published var fechaVencimiento: Date = Date()
    @Published var completada: Bool = false
    @Published var etiquetas: [String] = []
    @Published var nuevaEtiqueta: String = ""
    
    // MARK: - Validation Errors
    @Published var errorTitulo: String?
    @Published var errorDescripcion: String?
    @Published var errorNotas: String?
    @Published var errorFecha: String?
    
    // MARK: - State
    @Published var isGuardando: Bool = false
    
    let tarea: Tarea?
    weak var delegate: TareaDelegate?
    var onSave: ((Tarea) -> Void)?
    var onCancel: (() -> Void)?
    
    // MARK: - Initialization
    
    init(tarea: Tarea? = nil) {
        self.tarea = tarea
        
        if let tarea = tarea {
            cargarDatos(de: tarea)
        } else {
            // Nueva tarea: fecha por defecto mañana
            fechaVencimiento = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
        }
    }
    
    private func cargarDatos(de tarea: Tarea) {
        titulo = tarea.titulo
        descripcion = tarea.descripcion
        notas = tarea.notas
        prioridad = tarea.prioridadEnum
        fechaVencimiento = tarea.fechaVencimiento
        completada = tarea.completada
        etiquetas = tarea.etiquetas
    }
    
    // MARK: - Validation
    
    func validarCampo(_ campo: CampoFormulario) {
        switch campo {
        case .titulo:
            let resultado = ValidacionService.validarTitulo(titulo)
            errorTitulo = resultado.isValid ? nil : resultado.error
            
        case .descripcion:
            let resultado = ValidacionService.validarDescripcion(descripcion)
            errorDescripcion = resultado.isValid ? nil : resultado.error
            
        case .notas:
            let resultado = ValidacionService.validarNotas(notas)
            errorNotas = resultado.isValid ? nil : resultado.error
            
        case .fecha:
            let resultado = ValidacionService.validarFecha(fechaVencimiento)
            errorFecha = resultado.isValid ? nil : resultado.error
        }
    }
    
    func validarTodo() {
        validarCampo(.titulo)
        validarCampo(.descripcion)
        validarCampo(.notas)
        validarCampo(.fecha)
    }
    
    var isFormularioValido: Bool {
        errorTitulo == nil &&
        errorDescripcion == nil &&
        errorNotas == nil &&
        errorFecha == nil &&
        !titulo.trimmed.isEmpty
    }
    
    var errores: [String] {
        ValidacionService.validarFormulario(
            titulo: titulo,
            descripcion: descripcion,
            notas: notas,
            fechaVencimiento: fechaVencimiento
        )
    }
    
    // MARK: - Etiquetas
    
    func agregarEtiqueta() {
        let etiquetaTrimmed = nuevaEtiqueta.trimmed
        if !etiquetaTrimmed.isEmpty && !etiquetas.contains(etiquetaTrimmed) {
            etiquetas.append(etiquetaTrimmed)
            nuevaEtiqueta = ""
        }
    }
    
    func agregarEtiquetaPredefinida(_ etiqueta: String) {
        if !etiquetas.contains(etiqueta) {
            etiquetas.append(etiqueta)
        }
    }
    
    func eliminarEtiqueta(_ etiqueta: String) {
        etiquetas.removeAll { $0 == etiqueta }
    }
    
    // MARK: - Actions
    
    func guardar() {
        validarTodo()
        
        guard isFormularioValido else { return }
        
        isGuardando = true
        
        let tareaActualizada = Tarea(
            id: tarea?.id ?? UUID(),
            titulo: titulo.trimmed,
            descripcion: descripcion.trimmed,
            prioridad: prioridad,
            fechaVencimiento: fechaVencimiento,
            completada: completada,
            etiquetas: etiquetas,
            notas: notas.trimmed,
            fechaCreacion: tarea?.fechaCreacion ?? Date()
        )
        
        // Simular delay de guardado
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            
            if self.tarea != nil {
                self.delegate?.tareaActualizada(tareaActualizada)
            } else {
                self.delegate?.tareaGuardada(tareaActualizada)
            }
            
            self.onSave?(tareaActualizada)
            self.isGuardando = false
        }
    }
    
    func cancelar() {
        onCancel?()
    }
    
    func eliminar() {
        guard let tarea = tarea else { return }
        delegate?.tareaEliminada(tarea.id)
    }
    
    // MARK: - Enums
    
    enum CampoFormulario {
        case titulo, descripcion, notas, fecha
    }
}
