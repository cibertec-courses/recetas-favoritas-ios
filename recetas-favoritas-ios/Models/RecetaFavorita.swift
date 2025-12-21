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
    var categoria: String
    var pais: String
    var instrucciones: String
    var imagen: String
    var fechaAgregada: Date
    
    init (id: String = UUID().uuidString, idMeal:String, nombre: String, imagen:String, categoria: String = "", pais:String = "", instrucciones: String = "", fechaAgregada: Date = Date()){
        self.id = id
        self.idMeal = idMeal
        self.nombre = nombre
        self.imagen = imagen
        self.categoria = categoria
        self.pais = pais
        self.instrucciones = instrucciones
        self.fechaAgregada = fechaAgregada
    }
    
}

