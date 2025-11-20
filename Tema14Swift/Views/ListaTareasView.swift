//
//  ListaTareasView.swift
//  Tema14Swift
//
//  Created by Jesus Alberto Garza Guerrero on 19/11/25.
//

import SwiftUI

struct ListaTareasView: View {
    @StateObject private var viewModel = ListaTareasViewModel()
    @State private var mostrarFiltros = false
    @State private var mostrarExportacion = false
    @State private var jsonExportado = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Lista de tareas
                ScrollView {
                    LazyVStack(spacing: Constantes.Espaciado.medio) {
                        // Estadísticas
                        estadisticasView
                        
                        // Lista de tareas
                        if viewModel.tareasFiltradas.isEmpty {
                            emptyStateView
                        } else {
                            ForEach(viewModel.tareasFiltradas) { tarea in
                                CeldaTareaView(
                                    tarea: tarea,
                                    onToggleCompletada: {
                                        withAnimation {
                                            viewModel.toggleCompletada(tarea)
                                        }
                                    }
                                )
                                .onTapGesture {
                                    viewModel.editarTarea(tarea)
                                }
                                .contextMenu {
                                    Button {
                                        viewModel.editarTarea(tarea)
                                    } label: {
                                        Label("Editar", systemImage: "pencil")
                                    }
                                    
                                    Button {
                                        viewModel.toggleCompletada(tarea)
                                    } label: {
                                        Label(
                                            tarea.completada ? "Marcar pendiente" : "Marcar completada",
                                            systemImage: tarea.completada ? "circle" : "checkmark.circle"
                                        )
                                    }
                                    
                                    Divider()
                                    
                                    Button(role: .destructive) {
                                        withAnimation {
                                            viewModel.eliminarTarea(tarea.id)
                                        }
                                    } label: {
                                        Label("Eliminar", systemImage: "trash")
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                
                // Botón flotante
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            viewModel.crearNuevaTarea()
                        }) {
                            Image(systemName: "plus")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(Color.blue)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Mis Tareas")
            .searchable(text: $viewModel.textoBusqueda, prompt: "Buscar tareas...")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        Section("Estado") {
                            Button {
                                viewModel.filtroEstado = .todas
                            } label: {
                                Label("Todas", systemImage: viewModel.filtroEstado == .todas ? "checkmark" : "")
                            }
                            Button {
                                viewModel.filtroEstado = .pendientes
                            } label: {
                                Label("Pendientes", systemImage: viewModel.filtroEstado == .pendientes ? "checkmark" : "")
                            }
                            Button {
                                viewModel.filtroEstado = .completadas
                            } label: {
                                Label("Completadas", systemImage: viewModel.filtroEstado == .completadas ? "checkmark" : "")
                            }
                        }
                        
                        Section("Prioridad") {
                            Button {
                                viewModel.filtroPrioridad = nil
                            } label: {
                                Label("Todas", systemImage: viewModel.filtroPrioridad == nil ? "checkmark" : "")
                            }
                            ForEach(Tarea.Prioridad.allCases, id: \.self) { prioridad in
                                Button {
                                    viewModel.filtroPrioridad = prioridad
                                } label: {
                                    Label(prioridad.rawValue, systemImage: viewModel.filtroPrioridad == prioridad ? "checkmark" : "")
                                }
                            }
                        }
                    } label: {
                        Label("Filtros", systemImage: "line.3.horizontal.decrease.circle")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Section("Ordenar por") {
                            Button {
                                viewModel.ordenCriterio = .fecha
                            } label: {
                                Label("Fecha", systemImage: viewModel.ordenCriterio == .fecha ? "checkmark" : "calendar")
                            }
                            Button {
                                viewModel.ordenCriterio = .prioridad
                            } label: {
                                Label("Prioridad", systemImage: viewModel.ordenCriterio == .prioridad ? "checkmark" : "exclamationmark.circle")
                            }
                            Button {
                                viewModel.ordenCriterio = .estado
                            } label: {
                                Label("Estado", systemImage: viewModel.ordenCriterio == .estado ? "checkmark" : "checkmark.circle")
                            }
                            Button {
                                viewModel.ordenCriterio = .titulo
                            } label: {
                                Label("Título", systemImage: viewModel.ordenCriterio == .titulo ? "checkmark" : "textformat")
                            }
                        }
                        
                        Section {
                            Button {
                                exportarTareas()
                            } label: {
                                Label("Exportar JSON", systemImage: "square.and.arrow.up")
                            }
                        }
                    } label: {
                        Label("Más", systemImage: "ellipsis.circle")
                    }
                }
            }
            .sheet(isPresented: $viewModel.mostrarFormulario) {
                FormularioTareaView(
                    viewModel: FormularioTareaViewModel(tarea: viewModel.tareaSeleccionada),
                    tareaService: viewModel.tareaService
                )
            }
            .sheet(isPresented: $mostrarExportacion) {
                ExportacionView(json: jsonExportado)
            }
        }
    }
    
    // MARK: - Subviews
    
    private var estadisticasView: some View {
        HStack(spacing: Constantes.Espaciado.medio) {
            estadisticaCard(titulo: "Total", valor: viewModel.estadisticas.total, color: .blue)
            estadisticaCard(titulo: "Pendientes", valor: viewModel.estadisticas.pendientes, color: .orange)
            estadisticaCard(titulo: "Completadas", valor: viewModel.estadisticas.completadas, color: .green)
        }
        .padding(.bottom, Constantes.Espaciado.pequeno)
    }
    
    private func estadisticaCard(titulo: String, valor: Int, color: Color) -> some View {
        VStack(spacing: 4) {
            Text("\(valor)")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(color)
            Text(titulo)
                .font(Constantes.Tipografia.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(12)
    }
    
    private var emptyStateView: some View {
        VStack(spacing: Constantes.Espaciado.medio) {
            Image(systemName: "checkmark.circle")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("No hay tareas")
                .font(Constantes.Tipografia.titulo)
                .foregroundColor(.primary)
            
            Text("Toca el botón + para crear una nueva tarea")
                .font(Constantes.Tipografia.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .padding(.top, 50)
    }
    
    // MARK: - Actions
    
    private func exportarTareas() {
        if let json = viewModel.exportarTareas() {
            jsonExportado = json
            mostrarExportacion = true
        }
    }
}

// MARK: - Exportación View

struct ExportacionView: View {
    let json: String
    @Environment(\.dismiss) private var dismiss
    @State private var mostrarCompartir = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text(json)
                    .font(.system(.caption, design: .monospaced))
                    .padding()
            }
            .navigationTitle("Exportar Tareas")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cerrar") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        UIPasteboard.general.string = json
                    } label: {
                        Label("Copiar", systemImage: "doc.on.doc")
                    }
                }
            }
        }
    }
}

#Preview {
    ListaTareasView()
}
