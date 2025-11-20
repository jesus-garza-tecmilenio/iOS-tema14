//
//  DetallesTareaView.swift
//  Tema14Swift
//
//  Created by Jesus Alberto Garza Guerrero on 19/11/25.
//

import SwiftUI

struct DetallesTareaView: View {
    let tarea: Tarea
    let onEditar: () -> Void
    let onEliminar: () -> Void
    let onToggleCompletada: () -> Void
    @Environment(\.dismiss) private var dismiss
    @State private var mostrarAlertaEliminar = false
    
    var prioridadColor: Color {
        switch tarea.prioridadEnum {
        case .baja: return Constantes.PrioridadColores.baja
        case .media: return Constantes.PrioridadColores.media
        case .alta: return Constantes.PrioridadColores.alta
        case .urgente: return Constantes.PrioridadColores.urgente
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Constantes.Espaciado.grande) {
                // MARK: - Header
                VStack(alignment: .leading, spacing: Constantes.Espaciado.medio) {
                    // Estado y Prioridad
                    HStack {
                        // Estado
                        Button(action: onToggleCompletada) {
                            HStack(spacing: 8) {
                                Image(systemName: tarea.completada ? "checkmark.circle.fill" : "circle")
                                Text(tarea.completada ? "Completada" : "Pendiente")
                                    .font(Constantes.Tipografia.body)
                            }
                            .foregroundColor(tarea.completada ? .green : .orange)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(
                                (tarea.completada ? Color.green : Color.orange).opacity(0.1)
                            )
                            .cornerRadius(20)
                        }
                        
                        Spacer()
                        
                        // Prioridad
                        HStack(spacing: 8) {
                            Circle()
                                .fill(prioridadColor)
                                .frame(width: 12, height: 12)
                            Text(tarea.prioridadEnum.rawValue)
                                .font(Constantes.Tipografia.body)
                                .foregroundColor(prioridadColor)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(prioridadColor.opacity(0.1))
                        .cornerRadius(20)
                    }
                    
                    // Título
                    Text(tarea.titulo)
                        .font(Constantes.Tipografia.titulo)
                        .foregroundColor(.primary)
                        .strikethrough(tarea.completada)
                }
                .padding(.horizontal)
                .padding(.top)
                
                Divider()
                
                // MARK: - Información
                VStack(alignment: .leading, spacing: Constantes.Espaciado.grande) {
                    // Fecha de Vencimiento
                    InfoRow(
                        icono: "calendar",
                        titulo: "Fecha de vencimiento",
                        valor: tarea.fechaVencimiento.formatoLargo(),
                        color: diasHastaVencimiento() < 0 ? .red : .primary
                    )
                    
                    // Días restantes
                    if !tarea.completada {
                        let dias = diasHastaVencimiento()
                        InfoRow(
                            icono: "clock",
                            titulo: "Tiempo restante",
                            valor: dias < 0 ? "Vencida" : (dias == 0 ? "Hoy" : "\(dias) días"),
                            color: dias < 0 ? .red : (dias <= 2 ? .orange : .primary)
                        )
                    }
                    
                    // Fecha de Creación
                    InfoRow(
                        icono: "plus.circle",
                        titulo: "Creada el",
                        valor: tarea.fechaCreacion.formatoLargo(),
                        color: .secondary
                    )
                }
                .padding(.horizontal)
                
                if !tarea.descripcion.isEmpty {
                    Divider()
                    
                    // MARK: - Descripción
                    VStack(alignment: .leading, spacing: Constantes.Espaciado.medio) {
                        Label("Descripción", systemImage: "text.alignleft")
                            .font(Constantes.Tipografia.subtitulo)
                            .foregroundColor(.secondary)
                        
                        Text(tarea.descripcion)
                            .font(Constantes.Tipografia.body)
                            .foregroundColor(.primary)
                    }
                    .padding(.horizontal)
                }
                
                if !tarea.notas.isEmpty {
                    Divider()
                    
                    // MARK: - Notas
                    VStack(alignment: .leading, spacing: Constantes.Espaciado.medio) {
                        Label("Notas", systemImage: "note.text")
                            .font(Constantes.Tipografia.subtitulo)
                            .foregroundColor(.secondary)
                        
                        Text(tarea.notas)
                            .font(Constantes.Tipografia.body)
                            .foregroundColor(.primary)
                    }
                    .padding(.horizontal)
                }
                
                if !tarea.etiquetas.isEmpty {
                    Divider()
                    
                    // MARK: - Etiquetas
                    VStack(alignment: .leading, spacing: Constantes.Espaciado.medio) {
                        Label("Etiquetas", systemImage: "tag")
                            .font(Constantes.Tipografia.subtitulo)
                            .foregroundColor(.secondary)
                        
                        FlowLayout(spacing: 8) {
                            ForEach(tarea.etiquetas, id: \.self) { etiqueta in
                                Text(etiqueta)
                                    .font(Constantes.Tipografia.caption)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.blue.opacity(0.1))
                                    .foregroundColor(.blue)
                                    .cornerRadius(16)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .padding(.bottom)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button {
                        onEditar()
                    } label: {
                        Label("Editar", systemImage: "pencil")
                    }
                    
                    Button {
                        onToggleCompletada()
                    } label: {
                        Label(
                            tarea.completada ? "Marcar pendiente" : "Marcar completada",
                            systemImage: tarea.completada ? "circle" : "checkmark.circle"
                        )
                    }
                    
                    Divider()
                    
                    Button(role: .destructive) {
                        mostrarAlertaEliminar = true
                    } label: {
                        Label("Eliminar", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        .alert("Eliminar Tarea", isPresented: $mostrarAlertaEliminar) {
            Button("Cancelar", role: .cancel) {}
            Button("Eliminar", role: .destructive) {
                onEliminar()
                dismiss()
            }
        } message: {
            Text("¿Estás seguro de que deseas eliminar esta tarea?")
        }
    }
    
    private func diasHastaVencimiento() -> Int {
        tarea.fechaVencimiento.diasDesdeAhora
    }
}

// MARK: - Info Row Component

struct InfoRow: View {
    let icono: String
    let titulo: String
    let valor: String
    let color: Color
    
    var body: some View {
        HStack(spacing: Constantes.Espaciado.medio) {
            Image(systemName: icono)
                .font(.title3)
                .foregroundColor(color)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(titulo)
                    .font(Constantes.Tipografia.caption)
                    .foregroundColor(.secondary)
                Text(valor)
                    .font(Constantes.Tipografia.body)
                    .foregroundColor(color)
            }
            
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        DetallesTareaView(
            tarea: Tarea(
                titulo: "Tarea de ejemplo",
                descripcion: "Esta es una descripción detallada de la tarea con mucho contenido para ver cómo se ve en la vista de detalles.",
                prioridad: .alta,
                fechaVencimiento: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
                completada: false,
                etiquetas: ["Trabajo", "Urgente", "Importante"],
                notas: "Estas son algunas notas adicionales sobre la tarea que pueden ser muy útiles para recordar detalles importantes."
            ),
            onEditar: {},
            onEliminar: {},
            onToggleCompletada: {}
        )
    }
}
