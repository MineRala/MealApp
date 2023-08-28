//
//  String+Extension.swift
//  MealApp
//
//  Created by Mine Rala on 28.08.2023.
//

import Foundation

extension String {
    func getVideoID() -> String {
        let fullString = self
        let searchSubstring = "="
        if let range = fullString.range(of: searchSubstring) {
            let startIndex = range.upperBound
            let subString = String(fullString[startIndex...])
            return subString
        }
        return fullString
    }
}
