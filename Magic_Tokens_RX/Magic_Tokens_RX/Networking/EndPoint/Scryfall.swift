//
//  Scryfall.swift
//  Magic_Tokens
//
//  Created by Jackson Ho on 3/20/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation

public enum ScryfallAPI {
    case sets
    case picturesInSets
    case allRelatedCards(name: String, set: String)
}

extension ScryfallAPI: EndPointType {
    
    var environmentBaseURL: String {
        switch NetworkManager.environment {
        case .production: return "https://api.scryfall.com"
        case .qa: return ""
        case .staging: return ""
            
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configure") }
        return url
    }
    
    var path: String {
        switch self {
        case .sets: return "/sets"
        case .picturesInSets: return ""
        case .allRelatedCards: return "/cards/collection"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .allRelatedCards(name: _, set: _):
            return .post
        default:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .sets:
            return .request
        case .picturesInSets:
            return .request
        case .allRelatedCards(name: let name, set: let set):
            return .requestParameter(bodyParameters: ["identifiers": [["name": name, "set": set]]], urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
