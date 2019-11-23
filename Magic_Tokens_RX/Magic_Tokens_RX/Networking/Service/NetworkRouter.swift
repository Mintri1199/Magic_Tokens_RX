//
//  NetworkRouter.swift
//  Magic_Tokens
//
//  Created by Jackson Ho on 3/19/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func  request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
