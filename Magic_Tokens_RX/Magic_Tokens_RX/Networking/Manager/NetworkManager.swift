//
//  NetworkManager.swift
//  Magic_Tokens
//
//  Created by Jackson Ho on 3/20/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation
import UIKit

struct NetworkManager {
    static let environment: NetworkEnvironment = .production
    private let scryfallRouter = Router<ScryfallAPI>()
    
    enum NetworkReponse: String, Error {
        case authenticationError = "You need to be authenticated first."
        case badRequest = "Bad Request"
        case outdated = "The url you requested is outdated."
        case failed = "Network request failed."
        case noData = "Response returned with no data to decode."
        case unableToDecode = "We could not decode the response."
    }
    
    fileprivate func handleNetworkResponse( _ response: HTTPURLResponse) -> Result<String, NetworkReponse> {
        switch response.statusCode {
        case 200...299: return Result.success("Success")
        case 401...500: return Result.failure(.authenticationError)
        case 501...599: return Result.failure(.badRequest)
        case 600: return Result.failure(.outdated)
        default: return Result.failure(.failed)
        }
    }
    
    func getAllSets(completion: @escaping (Result<FilteredSetModel, NetworkReponse>) -> Void) {
        scryfallRouter.request(.sets) { (data, response, error) in
            if error != nil {
                print("Check your network connection")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data  else { completion(.failure(.noData)); return }
                    
                    do {
                        var model = try JSONDecoder().decode(FilteredSetModel.self, from: responseData)
                        model.filterSets()
                        completion(.success(model))
                    } catch {
                        completion(.failure(.unableToDecode))
                    }
                case .failure(let networkFailureError):
                    completion(.failure(networkFailureError))
                }
            }
        }
    }
}
