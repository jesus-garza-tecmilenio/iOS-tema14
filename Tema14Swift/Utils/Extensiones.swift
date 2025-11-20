//
//  Extensiones.swift
//  Tema14Swift
//
//  Created by Jesus Alberto Garza Guerrero on 19/11/25.
//

import Foundation

extension Date {
    func formatoCorto() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
    
    func formatoLargo() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
    
    var esHoy: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    var esManana: Bool {
        Calendar.current.isDateInTomorrow(self)
    }
    
    var diasDesdeAhora: Int {
        Calendar.current.dateComponents([.day], from: Date(), to: self).day ?? 0
    }
}

extension String {
    func truncado(limite: Int) -> String {
        if self.count > limite {
            return String(self.prefix(limite))
        }
        return self
    }
    
    var trimmed: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

