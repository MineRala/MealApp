//
//  Endpoint.swift
//  MealApp
//
//  Created by Mine Rala on 21.08.2023.
//

import Foundation

enum Endpoint {
    private enum Constant {
        static let baseURL = "https://www.themealdb.com/api/json/v1/1"
    }
    
    case allMeals
    case mealDetails(id: String)
    
    var url: String {
        switch self {
        case .allMeals:
            return "\(Constant.baseURL)/search.php?f=\(Character.randomCharacter())"
        case .mealDetails(let id):
            return "\(Constant.baseURL)/lookup.php?i=\(id)"
        }
    }
}
