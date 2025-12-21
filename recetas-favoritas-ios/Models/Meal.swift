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
    
    var idMeal: String
    var strMeal: String
    var strMealThumb: String
    var strCategory: String?
    var strArea: String?
    var strInstructions: String?
}
