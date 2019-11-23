//
//  ListObject.swift
//  Magic_Tokens_RX
//
//  Created by Jackson Ho on 11/22/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation

struct FilteredSetModel: Codable {
    var data: [SetObject]
    private let fobbidenCodes: Set = ["phel", "gs1", "dd", "fnm", "po3", "tdag", "tddi", "tfth", "thp1", "thp2", "thp3", "te01"]
    
    mutating func filterSets() {
        data = data.filter{ !fobbidenCodes.contains($0.code) && $0.setType == "token"}
    }
}

// Set Object
struct SetObject: Codable {
    let code, name, setType: String
    
    
    enum CodingKeys: String, CodingKey {
        case setType = "set_type"
        case name
        case code
    }
}
