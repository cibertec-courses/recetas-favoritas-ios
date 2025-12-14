//
//  RecetaFavorita.swift
//  recetas-favoritas-ios
//
//  Created by DamII on 14/12/25.
//

import Foundation
struct RecetaFavorita : Identifiable, Codable {
    var id: String
    var idMeal: String
    var nombre: String
    var imagen: String
    var fechaAgregada: Date
    
    init (id: String = UUID().uuidString, idMeal:String, nombre: String, imagen:String, fechaAgregada: Date = Date()){
        self.id = id
        self.idMeal = idMeal
        self.nombre = nombre
        self.imagen = imagen
        self.fechaAgregada = fechaAgregada
    }
    
}

