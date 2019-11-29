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
    case UnableToFindDefaultWeightWord
    case UnableToFindUserWeightWord
}

enum AutoCompletePurpose {
    case allStrings( word: String)
    case allNodes( node: PrefixTreeNode)
}

class PrefixTreeNode {
    var data: String?
    var weight: Int = 0
    var userWeight: Int?
    var children: [PrefixTreeNode?] = Array(repeating: nil, count: 26)
    
    func isEmpty() -> Bool {
        return self.numberOfChildren() == 0
    }
    
    func numberOfChildren() -> Int {
        // Return the number of non nil children in the array
        return children.reduce(0, { result, child in return child == nil ? result : result + 1 })
    }
    
    private func hasChild(_ char: Character) -> Bool {
        // Return a bool whether the node has a child for the given character
        if char.isLetter {
            let value = self.charToInt(char)
            return self.children[value - 65] != nil
        } else {
            return false
        }
    }
    
    func getChild(_ char: Character) -> PrefixTreeNode? {
        // Return the child node for the given character
        return self.hasChild(char) ? self.children[self.charToInt(char) - 65] : nil
    }
    
    func addChild(_ char: Character, childNode: PrefixTreeNode) {
        if !self.hasChild(char) && char.isLetter {
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
    
    init(vocabulary: [(String, Int)]=[]) {
        for word in vocabulary {
            self.initialInsert(word: word.0, dataBaseWeight: word.1)
        }
    }
    
    private func initialInsert(word: String, dataBaseWeight: Int) {
        // Insert the given word and weight from the database into the trie initially
        
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
    
    func updateUserWeight(word: String) {
        // Add or update the user weight on the used word
        if let usedWord = self.findNode(word: word) {
            if let currentWeight = usedWord.userWeight {
                usedWord.userWeight = currentWeight + 1
            } else {
                usedWord.userWeight = 1
            }
        }
    }
    
    func findNode(word: String) -> PrefixTreeNode? {
        // Search the tree with the given word and return the end node is it exist
        var currentNode: PrefixTreeNode = self.root
        
        for char in word.uppercased() {
            if !char.isLetter {
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
    
    func autoCompleteOne(currentString: String, completion: (Result<String, AutoCompleteError>) -> Void) {
        // Return a complete word based on their database weight or user weight if exist
        
        // Find the node of the current String
        if let currentNode = self.findNode(word: currentString) {
            
            var allTerminalNodes: [PrefixTreeNode] = []
            // Traverse the subtree and gather all terminal nodes
            self.traversePreOrderForOne(node: currentNode, visit: { allTerminalNodes.append($0) })
            
            // Create an array with all the nodes that contains a user weight
            let userWeightedWords = allTerminalNodes.filter { $0.userWeight != nil }
            
            // return the highest weighted string in a closure. Change base whether there are user weighted words are not.
            if userWeightedWords.isEmpty {
                if let completedWord = allTerminalNodes.reduce(allTerminalNodes[0] as PrefixTreeNode, { $0.weight < $1.weight ? $1 : $0 }).data {
                    completion(.success(completedWord))
                } else {
                    #if DEBUG
                    print("Unable to find default weighted word from: \(currentString)")
                    #endif
                    completion(.failure(.UnableToFindDefaultWeightWord))
                }
            } else {
                let highestUserWeightNode = userWeightedWords.reduce(userWeightedWords[0]) { (currentNode, value) in
                    if let weightOne = currentNode.userWeight, let weightTwo = value.userWeight {
                        return weightOne < weightTwo ? value : currentNode
                    } else {
                        #if DEBUG
                        print("There are something fucky going on")
                        #endif
                        return currentNode
                    }
                }
                
                if let completedWord = highestUserWeightNode.data {
                    completion(.success(completedWord))
                } else {
                    #if DEBUG
                    print("Unable to find the user weighted word from: \(currentString)")
                    #endif
                    completion(.failure(.UnableToFindUserWeightWord))
                }
            }
        } else {
            #if DEBUG
            print("Unable to autocomplete from: \(currentString)")
            #endif
            completion(.failure(.MissingWord))
        }
    }
    
    private func traversePreOrderForOne(node: PrefixTreeNode, visit: (PrefixTreeNode) -> Void) {
        // Traverse the tree pre-order recursively
        if node.data != nil {
            visit(node)
        }
        
        for child in node.children {
            if let child = child {
                self.traversePreOrderForOne(node: child, visit: visit)
            }
        }
    }
    
    private func traversePreOrder(node: PrefixTreeNode, visit: (String) -> Void) {
        // Notes: This is traversing method
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
