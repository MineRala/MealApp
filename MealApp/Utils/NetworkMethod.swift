//
//  NetworkType.swift
//  MealApp
//
//  Created by Mine Rala on 21.08.2023.
//

import Alamofire

enum NetworkMethod {
    case get
    case post
    case put
    case delete
}

extension NetworkMethod {
    func toAlamofire() -> HTTPMethod {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        case .put:
            return .put
        case .delete:
            return .delete
        }
    }
}
