//
//  NetworkManager.swift
//  MealApp
//
//  Created by Mine Rala on 21.08.2023.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
    func makeRequest<T: Decodable>(endpoint: Endpoint, method: NetworkMethod, type: T.Type) async -> Result<T,CustomError>
}

final class NetworkManager: NetworkManagerProtocol {
    static let shared: NetworkManagerProtocol = NetworkManager()
    
    func makeRequest<T>(endpoint: Endpoint, method: NetworkMethod, type: T.Type) async -> Result<T, CustomError> where T : Decodable {
        let request = AF.request(endpoint.url, method: method.toAlamofire()).validate().serializingDecodable(T.self)
        let result = await request.response
        guard let value = result.value else {
            return .failure(.invalidData)
        }
        return .success(value)
    }
}
