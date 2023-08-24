//
//  CustomErrors.swift
//  MealApp
//
//  Created by Mine Rala on 21.08.2023.
//

import Foundation

enum CustomError: String, Error {
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case invalidURLLink = "Invalid link. Please check the link."
    case invalidURL = "Invalid URL."
    case checkingError = "Data couldn't be checked"
    case coreDataError = "There is a core data error, please check."
}
