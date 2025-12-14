//
//  Meal.swift
//  recetas-favoritas-ios
//
//  Created by DamII on 14/12/25.
//

import Foundation


struct MealResponse: Codable {
    let meals: [Meal]?
}

struct Meal: Codable, Identifiable{
    var id: String { idMeal }
    
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
}
