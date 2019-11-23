//
//  PrefixTree.swift
//  Magic_Tokens_RX
//
//  Created by Jackson Ho on 11/21/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation

enum AutoCompleteError: Error {
    case MissingWord
}

class PrefixTreeNode {
    var data: String?
    var children: [PrefixTreeNode?] = Array(repeating: nil, count: 26)
    
    func isEmpty() -> Bool {
        return self.numberOfChildren() == 0
    }
    
    func numberOfChildren() -> Int {
        // Return the number of non nil children in the array
        return children.reduce(0, { result, child in return child == nil ? result : result + 1 })
    }
    
    func hasChild(_ char: Character) -> Bool {
        // Return a bool to indicate the node has a child or not
        let value = self.charToInt(char)
        if value > 97 || value < 65 {
            return false
        }
        return self.children[value - 65] != nil
    }
    
    func getChild(_ char: Character) -> PrefixTreeNode? {
        return self.hasChild(char) ? self.children[self.charToInt(char) - 65] : nil
    }
    
    func addChild(_ char: Character, childNode: PrefixTreeNode) {
        if !self.hasChild(char) {
            self.children[self.charToInt(char) - 65] = childNode
        }
    }
    
    private func charToInt(_ char: Character) -> Int {
        if let value = char.asciiValue {
            return Int(value)
        } else {
            return -1
        }
    }
}

class PrefixTree {
    private let root: PrefixTreeNode = PrefixTreeNode()
    var size: Int = 0
    init(vocabulary: [String]=[]) {
        for word in vocabulary {
            self.insert(word: word)
        }
    }
    
    func insert(word: String) {
        // Start with the root node
        var node = self.root
        
        // Loop through the word character by character
        for char in word.uppercased() {
            // Skip any non letter character
            if !char.isLetter {
                continue
            }
            
            // Check if the current node has a child of the current character
            if let childrenNode = node.getChild(char) {
                // Replace the current node with the child node
                node = childrenNode
            } else {
                // Create a new prefix tree node and add it to the current node children
                let childNode = PrefixTreeNode()
                node.addChild(char, childNode: childNode)
                node = childNode
            }
        }
        
        if node.data == nil {
            node.data = word
        }
    }
    
    func isEmpty() -> Bool {
        return self.root.isEmpty()
    }
    
    func contains(word: String) -> Bool {
        // Returns a boolean value to show whether the tree contains a word.
        if word.isEmpty {
            return true
        }
        
        if let node = self.findNode(word: word) {
            return node.data != nil
        } else {
            return false
        }
    }
    
    func findNode(word: String) -> PrefixTreeNode? {
        // Traverse the tree with the given word and return the end node is it exist
        var currentNode: PrefixTreeNode = self.root
        
        for char in word.uppercased() {
            if char == "-" {
                continue
            }
            if let childrenNode = currentNode.getChild(char) {
                currentNode = childrenNode
            } else {
                return nil
            }
        }
        return currentNode
    }
    
    func autoCompleteAll(word: String, completion: @escaping (Result<[String], AutoCompleteError>) -> Void) {
        if let currentNode = self.findNode(word: word) {
            var result: [String] = []
            
            self.traversePreOrder(node: currentNode, visit: { result.append($0) })
            
            completion(.success(result))
            return
        }
        completion(.failure(.MissingWord))
    }
    
    private func traversePreOrder(node: PrefixTreeNode, visit: (String) -> Void) {
        // Notes: This is traversing method doesn't use weights
        // Traverse the tree pre-order recursively
        
        if let data = node.data {
            visit(data)
        }
        
        for child in node.children {
            if let child = child {
                self.traversePreOrder(node: child, visit: visit)
            }
        }
    }
}
