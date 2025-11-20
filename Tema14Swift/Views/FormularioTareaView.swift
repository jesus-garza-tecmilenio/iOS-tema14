//
//  FormularioTareaView.swift
//  Tema14Swift
//
//  Created by Jesus Alberto Garza Guerrero on 19/11/25.
//

import SwiftUI

struct FormularioTareaView: View {
    @StateObject var viewModel: FormularioTareaViewModel
    @ObservedObject var tareaService: TareaService
    @Environment(\.dismiss) private var dismiss
    @State private var mostrarAlertaEliminar = false
    @FocusState private var campoEnfocado: FormularioTareaViewModel.CampoFormulario?
    
    init(viewModel: FormularioTareaViewModel, tareaService: TareaService) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.tareaService = tareaService
    }
    
    var esEdicion: Bool {
        viewModel.tarea != nil
    }
    
    var body: some View {
        NavigationStack {
            Form {
                // MARK: - Sección 1: Información Básica
                Section {
                    // Título
                    VStack(alignment: .leading, spacing: 8) {
                        TextField("Título de la tarea", text: $viewModel.titulo)
                            .textFieldStyle(.plain)
                            .font(Constantes.Tipografia.body)
                            .focused($campoEnfocado, equals: .titulo)
                            .onChange(of: viewModel.titulo) { _, _ in
                                viewModel.validarCampo(.titulo)
                            }
                        
                        ContadorCaracteresView(
                            caracteresActuales: viewModel.titulo.count,
                            caracteresMaximos: Constantes.maxTituloCaracteres
                        )
                        
                        if let error = viewModel.errorTitulo {
                            ValidacionView(mensaje: error)
                        }
                    }
                    
                    // Prioridad
                    Picker("Prioridad", selection: $viewModel.prioridad) {
                        ForEach(Tarea.Prioridad.allCases, id: \.self) { prioridad in
                            HStack {
                                Circle()
                                    .fill(colorParaPrioridad(prioridad))
                                    .frame(width: 12, height: 12)
                                Text(prioridad.rawValue)
                            }
                            .tag(prioridad)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    // Fecha de Vencimiento
                    VStack(alignment: .leading, spacing: 8) {
                        DatePicker(
                            "Fecha de vencimiento",
                            selection: $viewModel.fechaVencimiento,
                            in: Date()...,
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(.compact)
                        .onChange(of: viewModel.fechaVencimiento) { _, _ in
                            viewModel.validarCampo(.fecha)
                        }
                        
                        if let error = viewModel.errorFecha {
                            ValidacionView(mensaje: error)
                        }
                    }
                } header: {
                    Text("Información Básica")
                        .font(Constantes.Tipografia.subtitulo)
                }
                
                // MARK: - Sección 2: Descripción y Notas
                Section {
                    // Descripción
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Descripción")
                            .font(Constantes.Tipografia.body)
                            .foregroundColor(.secondary)
                        
                        TextEditor(text: $viewModel.descripcion)
                            .frame(minHeight: 100)
                            .focused($campoEnfocado, equals: .descripcion)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        viewModel.errorDescripcion != nil ? Color.red : Color.gray.opacity(0.2),
                                        lineWidth: 1
                                    )
                            )
                            .onChange(of: viewModel.descripcion) { _, _ in
                                viewModel.validarCampo(.descripcion)
                            }
                        
                        ContadorCaracteresView(
                            caracteresActuales: viewModel.descripcion.count,
                            caracteresMaximos: Constantes.maxDescripcionCaracteres
                        )
                        
                        if let error = viewModel.errorDescripcion {
                            ValidacionView(mensaje: error)
                        }
                    }
                    
                    // Notas
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Notas adicionales")
                            .font(Constantes.Tipografia.body)
                            .foregroundColor(.secondary)
                        
                        TextEditor(text: $viewModel.notas)
                            .frame(minHeight: 150)
                            .focused($campoEnfocado, equals: .notas)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        viewModel.errorNotas != nil ? Color.red : Color.gray.opacity(0.2),
                                        lineWidth: 1
                                    )
                            )
                            .onChange(of: viewModel.notas) { _, _ in
                                viewModel.validarCampo(.notas)
                            }
                        
                        ContadorCaracteresView(
                            caracteresActuales: viewModel.notas.count,
                            caracteresMaximos: Constantes.maxNotasCaracteres
                        )
                        
                        if let error = viewModel.errorNotas {
                            ValidacionView(mensaje: error)
                        }
                    }
                } header: {
                    Text("Descripción y Notas")
                        .font(Constantes.Tipografia.subtitulo)
                }
                
                // MARK: - Sección 3: Categorización
                Section {
                    // Toggle completada
                    Toggle("Marcar como completada", isOn: $viewModel.completada)
                    
                    // Etiquetas existentes
                    if !viewModel.etiquetas.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Etiquetas")
                                .font(Constantes.Tipografia.body)
                                .foregroundColor(.secondary)
                            
                            FlowLayout(spacing: 8) {
                                ForEach(viewModel.etiquetas, id: \.self) { etiqueta in
                                    EtiquetaChip(
                                        texto: etiqueta,
                                        onDelete: {
                                            withAnimation {
                                                viewModel.eliminarEtiqueta(etiqueta)
                                            }
                                        }
                                    )
                                }
                            }
                        }
                    }
                    
                    // Agregar etiqueta personalizada
                    HStack {
                        TextField("Nueva etiqueta", text: $viewModel.nuevaEtiqueta)
                            .textFieldStyle(.roundedBorder)
                            .onSubmit {
                                viewModel.agregarEtiqueta()
                            }
                        
                        Button(action: {
                            viewModel.agregarEtiqueta()
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.blue)
                        }
                        .disabled(viewModel.nuevaEtiqueta.trimmed.isEmpty)
                    }
                    
                    // Etiquetas predefinidas
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Etiquetas sugeridas")
                            .font(Constantes.Tipografia.caption)
                            .foregroundColor(.secondary)
                        
                        FlowLayout(spacing: 8) {
                            ForEach(Constantes.etiquetasPredefinidas, id: \.self) { etiqueta in
                                if !viewModel.etiquetas.contains(etiqueta) {
                                    Button(action: {
                                        withAnimation {
                                            viewModel.agregarEtiquetaPredefinida(etiqueta)
                                        }
                                    }) {
                                        Text(etiqueta)
                                            .font(Constantes.Tipografia.caption)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(Color.gray.opacity(0.1))
                                            .foregroundColor(.primary)
                                            .cornerRadius(16)
                                    }
                                }
                            }
                        }
                    }
                } header: {
                    Text("Categorización")
                        .font(Constantes.Tipografia.subtitulo)
                }
                
                // MARK: - Sección 4: Acciones
                if esEdicion {
                    Section {
                        Button(role: .destructive) {
                            mostrarAlertaEliminar = true
                        } label: {
                            HStack {
                                Spacer()
                                Label("Eliminar Tarea", systemImage: "trash")
                                Spacer()
                            }
                        }
                    }
                }
            }
            .navigationTitle(esEdicion ? "Editar Tarea" : "Nueva Tarea")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        guardarTarea()
                    } label: {
                        if viewModel.isGuardando {
                            ProgressView()
                        } else {
                            Text("Guardar")
                                .fontWeight(.semibold)
                        }
                    }
                    .disabled(!viewModel.isFormularioValido || viewModel.isGuardando)
                }
                
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Listo") {
                        campoEnfocado = nil
                    }
                }
            }
            .alert("Eliminar Tarea", isPresented: $mostrarAlertaEliminar) {
                Button("Cancelar", role: .cancel) {}
                Button("Eliminar", role: .destructive) {
                    eliminarTarea()
                }
            } message: {
                Text("¿Estás seguro de que deseas eliminar esta tarea? Esta acción no se puede deshacer.")
            }
        }
    }
    
    // MARK: - Helper Functions
    
    private func colorParaPrioridad(_ prioridad: Tarea.Prioridad) -> Color {
        switch prioridad {
        case .baja: return Constantes.PrioridadColores.baja
        case .media: return Constantes.PrioridadColores.media
        case .alta: return Constantes.PrioridadColores.alta
        case .urgente: return Constantes.PrioridadColores.urgente
        }
    }
    
    private func guardarTarea() {
        viewModel.onSave = { tarea in
            if esEdicion {
                tareaService.actualizarTarea(tarea)
            } else {
                tareaService.crearTarea(tarea)
            }
            dismiss()
        }
        viewModel.guardar()
    }
    
    private func eliminarTarea() {
        if let tarea = viewModel.tarea {
            tareaService.eliminarTarea(tarea.id)
            dismiss()
        }
    }
}

// MARK: - Componentes Auxiliares

struct EtiquetaChip: View {
    let texto: String
    let onDelete: () -> Void
    
    var body: some View {
        HStack(spacing: 4) {
            Text(texto)
                .font(Constantes.Tipografia.caption)
            
            Button(action: onDelete) {
                Image(systemName: "xmark.circle.fill")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(Color.blue.opacity(0.1))
        .foregroundColor(.blue)
        .cornerRadius(16)
    }
}

// MARK: - FlowLayout para etiquetas

struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(
            in: proposal.replacingUnspecifiedDimensions().width,
            subviews: subviews,
            spacing: spacing
        )
        return result.size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(
            in: bounds.width,
            subviews: subviews,
            spacing: spacing
        )
        for (index, subview) in subviews.enumerated() {
            subview.place(at: CGPoint(x: bounds.minX + result.frames[index].minX, y: bounds.minY + result.frames[index].minY), proposal: .unspecified)
        }
    }
    
    struct FlowResult {
        var size: CGSize = .zero
        var frames: [CGRect] = []
        
        init(in maxWidth: CGFloat, subviews: Subviews, spacing: CGFloat) {
            var currentX: CGFloat = 0
            var currentY: CGFloat = 0
            var lineHeight: CGFloat = 0
            
            for subview in subviews {
                let size = subview.sizeThatFits(.unspecified)
                
                if currentX + size.width > maxWidth && currentX > 0 {
                    currentX = 0
                    currentY += lineHeight + spacing
                    lineHeight = 0
                }
                
                frames.append(CGRect(x: currentX, y: currentY, width: size.width, height: size.height))
                lineHeight = max(lineHeight, size.height)
                currentX += size.width + spacing
            }
            
            self.size = CGSize(width: maxWidth, height: currentY + lineHeight)
        }
    }
}

#Preview {
    FormularioTareaView(
        viewModel: FormularioTareaViewModel(),
        tareaService: TareaService()
    )
}
