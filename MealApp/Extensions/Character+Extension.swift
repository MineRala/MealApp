//
//  Character+Extension.swift
//  MealApp
//
//  Created by Mine Rala on 27.08.2023.
//

import Foundation

extension Character {
   static func randomCharacter() -> Character {
        let letters = "abcdefghijklmnoprstvwy"
        let randomIndex = Int.random(in: 0..<letters.count)
        let randomCharacter = letters[letters.index(letters.startIndex, offsetBy: randomIndex)]
        return randomCharacter
    }
}
