//
//  MealService.swift
//  recetas-favoritas-ios
//
//  Created by DamII on 14/12/25.
//

import Foundation

class MealService{
    
    static let shared = MealService()
    
    private let baseURL = "https://www.themealdb.com/api/json/v1/1"
    
    private init(){}
    
    
    func buscarRecetas (nombre: String) async  throws -> [Meal]{
        let urlString = "\(baseURL)/search.php?s=\(nombre)"
        
        guard let url = URL (string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let response = try JSONDecoder().decode(MealResponse.self, from: data)
        
        return response.meals ?? []
        
    }
    
    func obtenerPorCategoria(categoria: String) async throws -> [Meal] {
        let urlString = "\(baseURL)/filter.php?c=\(categoria)"
        guard let url = URL (string: urlString) else {
            throw URLError(.badURL)
        }
        
        let(data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(MealResponse.self, from: data)
                                                        
        return response.meals ?? []
    }
    
    
}
