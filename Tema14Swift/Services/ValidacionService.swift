//
//  ValidacionService.swift
//  Tema14Swift
//
//  Created by Jesus Alberto Garza Guerrero on 19/11/25.
//

import Foundation

struct ValidacionService {
    
    // MARK: - Validación de Título
    static func validarTitulo(_ titulo: String) -> (isValid: Bool, error: String?) {
        let trimmed = titulo.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmed.isEmpty {
            return (false, "El título es requerido")
        }
        
        if trimmed.count > 100 {
            return (false, "El título no puede exceder 100 caracteres")
        }
        
        return (true, nil)
    }
    
    // MARK: - Validación de Descripción
    static func validarDescripcion(_ descripcion: String) -> (isValid: Bool, error: String?) {
        if descripcion.count > 500 {
            return (false, "La descripción no puede exceder 500 caracteres")
        }
        return (true, nil)
    }
    
    // MARK: - Validación de Notas
    static func validarNotas(_ notas: String) -> (isValid: Bool, error: String?) {
        if notas.count > 1000 {
            return (false, "Las notas no pueden exceder 1000 caracteres")
        }
        return (true, nil)
    }
    
    // MARK: - Validación de Fecha
    static func validarFecha(_ fecha: Date) -> (isValid: Bool, error: String?) {
        let calendar = Calendar.current
        let hoy = calendar.startOfDay(for: Date())
        let fechaSeleccionada = calendar.startOfDay(for: fecha)
        
        if fechaSeleccionada < hoy {
            return (false, "La fecha no puede ser pasada")
        }
        
        return (true, nil)
    }
    
    // MARK: - Validación de Formulario Completo
    static func validarFormulario(
        titulo: String,
        descripcion: String,
        notas: String,
        fechaVencimiento: Date
    ) -> [String] {
        var errores: [String] = []
        
        let tituloValidacion = validarTitulo(titulo)
        if !tituloValidacion.isValid, let error = tituloValidacion.error {
            errores.append(error)
        }
        
        let descripcionValidacion = validarDescripcion(descripcion)
        if !descripcionValidacion.isValid, let error = descripcionValidacion.error {
            errores.append(error)
        }
        
        let notasValidacion = validarNotas(notas)
        if !notasValidacion.isValid, let error = notasValidacion.error {
            errores.append(error)
        }
        
        let fechaValidacion = validarFecha(fechaVencimiento)
        if !fechaValidacion.isValid, let error = fechaValidacion.error {
            errores.append(error)
        }
        
        return errores
    }
}
