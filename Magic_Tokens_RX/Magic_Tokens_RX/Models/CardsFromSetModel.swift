//
//  CardsFromSetModel.swift
//  Magic_Tokens_RX
//
//  Created by Jackson Ho on 11/23/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation

var allCreatures = Set<String>()

struct CardFromSetModel: Codable {
    enum CodingKeys: String, CodingKey {
        case hasMore = "has_more"
        case data
    }
    
    let hasMore: Bool
    var data: [Datum]
    
    mutating func filterCreature() {
        data = data.filter { $0.typeLine.contains("Creature") && !$0.typeLine.contains("//")}
    }
}

// MARK: - Datum
struct Datum: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case typeLine = "type_line"
    }
    
    let name: String
    let typeLine: String
}
