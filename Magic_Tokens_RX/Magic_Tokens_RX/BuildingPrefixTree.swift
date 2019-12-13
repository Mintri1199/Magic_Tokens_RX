//
//  BuildingPrefixTree.swift
//  Magic_Tokens_RX
//
//  Created by Jackson Ho on 11/22/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation

let premadePrefixTree = PrefixTree()

func formatJSON() {
    if let path = Bundle.main.path(forResource: "histogram", ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let historgram = jsonResult["data"] as? [[Any]] {
                let formatted = historgram.map { value -> (String, Int)? in
                    if let weight = value[1] as? Int, let name = value[0] as? String {
                        return (name, weight)
                    } else {
                        return nil
                    }
                }.compactMap { $0 }
                
                formatted.forEach { (value) in
                    premadePrefixTree.insert(word: value.0, dataBaseWeight: value.1)
                }
            }
        } catch {
            print("What happened here?")
        }
    }
}

func buildPreFixTree(completion: @escaping (PrefixTree) -> Void) {
    if let path = Bundle.main.path(forResource: "histogram", ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let historgram = jsonResult["data"] as? [[Any]] {
                let formatted = historgram.map { value -> (String, Int)? in
                    if let weight = value[1] as? Int, let name = value[0] as? String {
                        return (name, weight)
                    } else {
                        return nil
                    }
                }.compactMap { $0 }
                
                completion(PrefixTree(vocabulary: formatted)) 
            }
        } catch {
            print("What happened here?")
        }
    }
}
