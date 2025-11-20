//
//  ValidacionView.swift
//  Tema14Swift
//
//  Created by Jesus Alberto Garza Guerrero on 19/11/25.
//

import SwiftUI

struct ValidacionView: View {
    let mensaje: String?
    
    var body: some View {
        if let mensaje = mensaje, !mensaje.isEmpty {
            HStack(spacing: Constantes.Espaciado.pequeno) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.red)
                    .font(.caption)
                
                Text(mensaje)
                    .font(Constantes.Tipografia.caption)
                    .foregroundColor(.red)
                
                Spacer()
            }
            .padding(Constantes.Espaciado.pequeno)
            .background(Color.red.opacity(0.1))
            .cornerRadius(8)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        ValidacionView(mensaje: "El título es requerido")
        ValidacionView(mensaje: "La fecha no puede ser pasada")
        ValidacionView(mensaje: nil)
    }
    .padding()
}
