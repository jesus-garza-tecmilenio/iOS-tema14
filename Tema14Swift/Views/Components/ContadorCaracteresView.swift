//
//  ContadorCaracteresView.swift
//  Tema14Swift
//
//  Created by Jesus Alberto Garza Guerrero on 19/11/25.
//

import SwiftUI

struct ContadorCaracteresView: View {
    let caracteresActuales: Int
    let caracteresMaximos: Int
    
    var porcentaje: Double {
        Double(caracteresActuales) / Double(caracteresMaximos)
    }
    
    var color: Color {
        if caracteresActuales > caracteresMaximos {
            return .red
        } else if porcentaje > 0.9 {
            return .orange
        } else {
            return .secondary
        }
    }
    
    var body: some View {
        HStack {
            Spacer()
            Text("\(caracteresActuales) / \(caracteresMaximos)")
                .font(Constantes.Tipografia.caption)
                .foregroundColor(color)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        ContadorCaracteresView(caracteresActuales: 50, caracteresMaximos: 100)
        ContadorCaracteresView(caracteresActuales: 95, caracteresMaximos: 100)
        ContadorCaracteresView(caracteresActuales: 110, caracteresMaximos: 100)
    }
    .padding()
}
