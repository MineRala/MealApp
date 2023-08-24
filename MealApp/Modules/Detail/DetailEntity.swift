//
//  DetailEntity.swift
//  MealApp
//
//  Created by Mine Rala on 17.08.2023.
//

import Foundation

struct MealDetails: Decodable {
    let title: String
    let category: String
    let area: String
    let instructions: String
    let image: String
    let tags: String?
    let youtubeUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case title = "strMeal"
        case category = "strCategory"
        case area = "strArea"
        case instructions = "strInstructions"
        case image = "strMealThumb"
        case tags = "strTags"
        case youtubeUrl = "strYoutube"
    }
}
