//
//  CeldaTareaView.swift
//  Tema14Swift
//
//  Created by Jesus Alberto Garza Guerrero on 19/11/25.
//

import SwiftUI

struct CeldaTareaView: View {
    let tarea: Tarea
    let onToggleCompletada: () -> Void
    
    var prioridadColor: Color {
        switch tarea.prioridadEnum {
        case .baja: return Constantes.PrioridadColores.baja
        case .media: return Constantes.PrioridadColores.media
        case .alta: return Constantes.PrioridadColores.alta
        case .urgente: return Constantes.PrioridadColores.urgente
        }
    }
    
    var fechaTexto: String {
        if tarea.fechaVencimiento.esHoy {
            return "Hoy"
        } else if tarea.fechaVencimiento.esManana {
            return "Mañana"
        } else {
            let dias = tarea.fechaVencimiento.diasDesdeAhora
            if dias < 0 {
                return "Vencida"
            } else if dias <= 7 {
                return "En \(dias) días"
            } else {
                return tarea.fechaVencimiento.formatoCorto()
            }
        }
    }
    
    var fechaColor: Color {
        let dias = tarea.fechaVencimiento.diasDesdeAhora
        if dias < 0 {
            return .red
        } else if dias <= 2 {
            return .orange
        } else {
            return .secondary
        }
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: Constantes.Espaciado.medio) {
            // Checkbox
            Button(action: onToggleCompletada) {
                Image(systemName: tarea.completada ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundColor(tarea.completada ? .green : .gray)
            }
            .buttonStyle(PlainButtonStyle())
            
            VStack(alignment: .leading, spacing: Constantes.Espaciado.pequeno) {
                // Título
                Text(tarea.titulo)
                    .font(Constantes.Tipografia.subtitulo)
                    .foregroundColor(tarea.completada ? .secondary : .primary)
                    .strikethrough(tarea.completada)
                    .lineLimit(2)
                
                // Descripción
                if !tarea.descripcion.isEmpty {
                    Text(tarea.descripcion)
                        .font(Constantes.Tipografia.body)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                // Metadata Row
                HStack(spacing: Constantes.Espaciado.medio) {
                    // Prioridad
                    HStack(spacing: 4) {
                        Circle()
                            .fill(prioridadColor)
                            .frame(width: 8, height: 8)
                        Text(tarea.prioridadEnum.rawValue)
                            .font(Constantes.Tipografia.caption)
                            .foregroundColor(prioridadColor)
                    }
                    
                    // Fecha
                    HStack(spacing: 4) {
                        Image(systemName: "calendar")
                            .font(.caption)
                        Text(fechaTexto)
                            .font(Constantes.Tipografia.caption)
                    }
                    .foregroundColor(fechaColor)
                    
                    Spacer()
                }
                
                // Etiquetas
                if !tarea.etiquetas.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: Constantes.Espaciado.pequeno) {
                            ForEach(tarea.etiquetas, id: \.self) { etiqueta in
                                Text(etiqueta)
                                    .font(Constantes.Tipografia.caption)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.blue.opacity(0.1))
                                    .foregroundColor(.blue)
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(Constantes.Espaciado.medio)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(prioridadColor.opacity(0.3), lineWidth: 1)
        )
    }
}

#Preview {
    VStack(spacing: 16) {
        CeldaTareaView(
            tarea: Tarea(
                titulo: "Tarea de ejemplo",
                descripcion: "Esta es una descripción de la tarea",
                prioridad: .alta,
                fechaVencimiento: Date(),
                completada: false,
                etiquetas: ["Trabajo", "Urgente"]
            ),
            onToggleCompletada: {}
        )
        
        CeldaTareaView(
            tarea: Tarea(
                titulo: "Tarea completada",
                descripcion: "Esta tarea ya está completada",
                prioridad: .baja,
                fechaVencimiento: Date(),
                completada: true
            ),
            onToggleCompletada: {}
        )
    }
    .padding()
}
