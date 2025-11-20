//
//  Constantes.swift
//  Tema14Swift
//
//  Created by Jesus Alberto Garza Guerrero on 19/11/25.
//

import SwiftUI

struct Constantes {
    
    // MARK: - Límites de Caracteres
    static let maxTituloCaracteres = 100
    static let maxDescripcionCaracteres = 500
    static let maxNotasCaracteres = 1000
    
    // MARK: - Colores por Prioridad
    struct PrioridadColores {
        static let baja = Color(hex: "10B981")
        static let media = Color(hex: "0EA5E9")
        static let alta = Color(hex: "F59E0B")
        static let urgente = Color(hex: "EF4444")
    }
    
    // MARK: - Espaciado
    struct Espaciado {
        static let pequeno: CGFloat = 8
        static let medio: CGFloat = 16
        static let grande: CGFloat = 24
    }
    
    // MARK: - Tipografía
    struct Tipografia {
        static let titulo: Font = .system(size: 20, weight: .bold)
        static let subtitulo: Font = .system(size: 16, weight: .semibold)
        static let body: Font = .system(size: 14, weight: .regular)
        static let caption: Font = .system(size: 12, weight: .regular)
    }
    
    // MARK: - Etiquetas Predefinidas
    static let etiquetasPredefinidas = [
        "Trabajo",
        "Personal",
        "Urgente",
        "Familia",
        "Estudios",
        "Salud",
        "Compras",
        "Hogar"
    ]
}

// MARK: - Extension Color para Hex
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
