//
//  EndPointTypeProtocol.swift
//  Magic_Tokens
//
//  Created by Jackson Ho on 3/19/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//
// Trying out Protocol Oriented Approach to Networking layer
// Medium Article: https://medium.com/flawless-app-stories/writing-network-layer-in-swift-protocol-oriented-approach-4fa40ef1f908

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
