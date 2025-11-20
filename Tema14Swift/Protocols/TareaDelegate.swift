//
//  TareaDelegate.swift
//  Tema14Swift
//
//  Created by Jesus Alberto Garza Guerrero on 19/11/25.
//

import Foundation

protocol TareaDelegate: AnyObject {
    func tareaGuardada(_ tarea: Tarea)
    func tareaEliminada(_ id: UUID)
    func tareaActualizada(_ tarea: Tarea)
}
