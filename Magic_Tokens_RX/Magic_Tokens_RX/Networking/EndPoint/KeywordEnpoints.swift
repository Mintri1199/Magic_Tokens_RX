//
//  KeywordEnpoints.swift
//  Magic_Tokens
//
//  Created by Jackson Ho on 3/20/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum KeywordAPI {
    case keywords
}

extension KeywordAPI: EndPointType {
    
    var environmentBaseURl: String {
        switch NetworkManager.environment {
        case .production: return "https://magickeywordapi.herokuapp.com"
        case .qa: return "https://magickeywordapi.herokuapp.com"
        case .staging: return ""
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURl) else { fatalError("baseURl could not be configure") }
        return url
    }
    
    var path: String {
        switch self {
        case .keywords:
            return "/api"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .keywords:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
