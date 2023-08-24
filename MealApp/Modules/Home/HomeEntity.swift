//
//  HomeEntity.swift
//  MealApp
//
//  Created by Mine Rala on 17.08.2023.
//

import Foundation

struct AllMeals: Decodable {
    let meals: [Meal]
}

struct Meal: Decodable {
    let id: String
    let title: String
    let category: String
    let image: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case title = "strMeal"
        case category = "strCategory"
        case image = "strMealThumb"
    }
}
