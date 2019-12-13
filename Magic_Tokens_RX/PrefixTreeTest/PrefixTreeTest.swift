//
//  PrefixTreeTest.swift
//  PrefixTreeTest
//
//  Created by Jackson Ho on 11/29/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import XCTest
@testable import Magic_Tokens_RX

class PrefixTreeTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPrefixTreeNodeInit() {
        let node = PrefixTreeNode()
        XCTAssertNil(node.userWeight, "There shouldn't be any user weight when initialize")
        XCTAssertTrue(node.data == nil, "There shouldn't be a string when initialize")
        XCTAssertTrue(node.weight == 0, "The default should be 0 when initialize")
        XCTAssertTrue(node.children.count == 26, "The array should be 26 for all alphabetical characters")
        let emptyList = node.children.filter { $0 != nil }
        XCTAssertTrue(emptyList.isEmpty, "The children array should be all nil")
    }
    
    func testPrefixTreeNodeMethods() {
        let nodeA = PrefixTreeNode()
        XCTAssertTrue(nodeA.numberOfChildren() == 0, "Should be 0 children when initialize")
        XCTAssertTrue(nodeA.isEmpty(), "Should be empty when initalize")
        XCTAssertNil(nodeA.getChild(Character("B")), "Shouldn't have any child to begin with")
        
        let nodeB = PrefixTreeNode()
        nodeA.addChild(Character("B"), childNode: nodeB)
        let fetchedNode = nodeA.getChild(Character("B"))
        XCTAssertTrue(nodeA.numberOfChildren() == 1, "There should be one child")
        XCTAssertNotNil(fetchedNode, "Should not return nil")
        XCTAssertTrue(fetchedNode === nodeB, "The returned node should be the same on in memory")
        
        let invalidNode = PrefixTreeNode()
        nodeA.addChild(Character("-"), childNode: invalidNode)
        XCTAssertTrue(nodeA.numberOfChildren() == 1, "NodeA shouldn't add any non-alpha characters")
        XCTAssertNil(nodeA.getChild(Character("-")), "Invalid character node shouldn't exist in nodeA")
    }
    
    func testPrefixTreeInit() {
        let emptyTrie = PrefixTree()
        XCTAssertTrue(type(of: emptyTrie.root) == PrefixTreeNode.self)
        XCTAssertTrue(type(of: emptyTrie.size) == Int.self)
        XCTAssertTrue(emptyTrie.root.isEmpty())
        XCTAssertNil(emptyTrie.root.data)
        XCTAssertTrue(emptyTrie.size == 0)
        XCTAssertTrue(emptyTrie.isEmpty())
    }
    
    func testPrefixTreeInitWithValues() {
        let trie = PrefixTree(vocabulary: [("A", 1)])
        // Verify root node
        XCTAssertFalse(trie.root.isEmpty())
        XCTAssertTrue(trie.root.numberOfChildren() == 1)
        // Verify node A
        let rootChild = trie.root.getChild(Character("A"))
        XCTAssertNotNil(rootChild)
        XCTAssertTrue(type(of: rootChild!) == PrefixTreeNode.self)
        XCTAssertNotNil(rootChild?.data)
        XCTAssertTrue(rootChild?.data == "A")
        XCTAssertTrue(rootChild?.numberOfChildren() == 0)
    }
    
    func testPrefixTreeInsertMethod() {
        let trie = PrefixTree()
        
        // Verify root node
        trie.insert(word: "AB", dataBaseWeight: 1)
        XCTAssertNil(trie.root.data)
        XCTAssertTrue(trie.root.weight == 0)
        XCTAssertTrue(trie.root.numberOfChildren() == 1)
        XCTAssertNotNil(trie.root.getChild("A"))
        
        // Verify node A
        let nodeA = trie.root.getChild("A")
        XCTAssertNil(nodeA!.data)
        XCTAssertTrue(nodeA!.weight == 0)
        XCTAssertTrue(nodeA!.numberOfChildren() == 1)
        XCTAssertNotNil(nodeA!.getChild("B"))
        
        // Verify node B
        let nodeB = nodeA?.getChild("B")
        XCTAssertNotNil(nodeB!.data)
        XCTAssertTrue(nodeB!.data == "AB")
        XCTAssertTrue(nodeB!.weight == 1)
        XCTAssertTrue(nodeB!.isEmpty())
        XCTAssertNotNil(nodeA!.getChild("B"))
    }
    
    func testSizeAndIsEmpty(){
        let trie = PrefixTree()
        // Verify size after initializing tree
        XCTAssertTrue(trie.size == 0)
        XCTAssertTrue(trie.isEmpty())
        
        // Verify size after first insert
        trie.insert(word: "A", dataBaseWeight: 1)
        XCTAssertTrue(trie.size == 1)
        XCTAssertFalse(trie.isEmpty())
        
        // Verify size after second insert
        trie.insert(word: "ABC", dataBaseWeight: 1)
        XCTAssertTrue(trie.size == 2)
        XCTAssertFalse(trie.isEmpty())
        // Verify size after third insert
        trie.insert(word: "ABD", dataBaseWeight: 1)
        XCTAssertTrue(trie.size == 3)
        XCTAssertFalse(trie.isEmpty())
        // Verify size after fourth insert
        trie.insert(word: "XYZ", dataBaseWeight: 1)
        XCTAssertTrue(trie.size == 4)
        XCTAssertFalse(trie.isEmpty())
    }
    
    func testSizeWithRepeatedInsert() {
        let trie = PrefixTree()
        // Verify size after initializing tree
        XCTAssertTrue(trie.size == 0)
        XCTAssertTrue(trie.isEmpty())
        
        // Verify size after first insert
        trie.insert(word: "A", dataBaseWeight: 1)
        XCTAssertTrue(trie.size == 1)
        XCTAssertFalse(trie.isEmpty())
        
        // Verify size after repeating first insert
        trie.insert(word: "A", dataBaseWeight: 3)
        XCTAssertTrue(trie.size == 1)
        let nodeA = trie.root.getChild("A")
        // Verify that the repeated insert doesn't change the weight of the node
        XCTAssertNotNil(nodeA)
        XCTAssertTrue(nodeA?.weight == 1)
        XCTAssertFalse(trie.isEmpty())
        
        // Verify size after second insert
        trie.insert(word: "ABC", dataBaseWeight: 1)
        XCTAssertTrue(trie.size == 2)
        
        // Verify size after repeating second insert
        trie.insert(word: "ABC", dataBaseWeight: 1)
        XCTAssertTrue(trie.size == 2)
        
        // Verify size after third insert
        trie.insert(word: "ABD", dataBaseWeight: 1)
        XCTAssertTrue(trie.size == 3)
        
        // Verify size after repeating third insert
        trie.insert(word: "ABD", dataBaseWeight: 1)
        XCTAssertTrue(trie.size == 3)
        
        // Verify size after fourth insert
        trie.insert(word: "XYZ", dataBaseWeight: 1)
        XCTAssertTrue(trie.size == 4)
        
        // Verify size after repeating fourth insert
        trie.insert(word: "XYZ", dataBaseWeight: 1)
        XCTAssertTrue(trie.size == 4)
    }
    
    func testContains() {
        let testData: [(String, Int)] = [("ABC", 1), ("A", 2), ("ABA", 10), ("ABZ", 100)]
        let trie = PrefixTree(vocabulary: testData)
        
        XCTAssertTrue(trie.contains(word: "ABC"))
        XCTAssertTrue(trie.contains(word: "ABA"))
        XCTAssertTrue(trie.contains(word: "A"))
        XCTAssertTrue(trie.contains(word: "ABZ"))
        XCTAssertFalse(trie.contains(word: "AB"))
        XCTAssertFalse(trie.contains(word: "BC"))
        XCTAssertFalse(trie.contains(word: "BA"))
        XCTAssertFalse(trie.contains(word: "B"))
        XCTAssertFalse(trie.contains(word: "C"))
        XCTAssertFalse(trie.contains(word: "BZ"))
        XCTAssertFalse(trie.contains(word: "Z"))
    }
    
    func testAutoCompleteAllString() {
        let testData: [(String, Int)] = [("ABC", 1), ("A", 2), ("ABA", 10), ("ABZ", 100)]
        
        let trie = PrefixTree(vocabulary: testData)
        
        let textData = testData.map { $0.0 }
        
        var result: Result<[String], AutoCompleteError>?
        
        trie.autoCompleteAll { result = $0 }
        do {
            let searchResult = try result?.get()
            let autocompleteResult = searchResult?.compactMap { $0 }
            
            if let result = autocompleteResult {
                XCTAssertFalse(result.isEmpty)
                XCTAssertTrue(result.count == 4)
                for stringResult in result {
                    XCTAssertTrue(textData.contains(stringResult))
                }
            }
        } catch {
            #if DEBUG
            print(result)
            #endif
        }
    }
    
    func testAutoCompleteAllWithSubString() {
        let testData: [(String, Int)] = [("ABC", 1), ("A", 2), ("ABA", 10), ("ABZ", 100)]
        
        let trie = PrefixTree(vocabulary: testData)
        
        // This result should have only one string
        var result: Result<[String], AutoCompleteError>?
        // This result should have three strings
        var secondResult: Result<[String], AutoCompleteError>?
        var emptyResult: Result<[String], AutoCompleteError>?
        trie.autoCompleteAll(word: "ABC") { result = $0 }
        trie.autoCompleteAll(word: "AB") { secondResult = $0 }
        trie.autoCompleteAll(word: "BC") { emptyResult = $0 }
        
        switch emptyResult {
        case .success(let none):
            XCTAssertNil(none)
        case .failure(let error):
            XCTAssertNotNil(error)
        case .none:
            #if DEBUG
            print("UWU what this?! >M<")
            #endif
        }
        
        do {
            let oneResult = try result?.get()
            let twoResult = try secondResult?.get()
            
            let oneString = oneResult?.compactMap { $0 }
            let threeStrings = twoResult?.compactMap { $0 }
            
            if let result = oneString {
                XCTAssertFalse(result.isEmpty)
                XCTAssertTrue(result.count == 1)
                XCTAssertTrue(result == ["ABC"])
            }
            
            if let result = threeStrings {
                XCTAssertFalse(result.isEmpty)
                XCTAssertTrue(result.count == 3)
                for text in ["ABC", "ABA", "ABZ"] {
                    XCTAssertTrue(result.contains(text))
                }
            }
        } catch {
            #if DEBUG
            print(result)
            #endif
        }
    }
    
    func testCompleteOneWithDefaultWeight() {
        let testData: [(String, Int)] = [("ABC", 1), ("A", 200), ("ABA", 10), ("ABZ", 100)]
        
        let trie = PrefixTree(vocabulary: testData)
        
        var result: Result<String, AutoCompleteError>?
        var secondResult: Result<String, AutoCompleteError>?
        var emptyResult: Result<String, AutoCompleteError>?
        trie.autoCompleteOne(currentString: "") { result = $0 }
        trie.autoCompleteOne(currentString: "AB") { secondResult = $0 }
        trie.autoCompleteOne(currentString: "B") { emptyResult = $0 }
        
        switch emptyResult {
            case .success(let none):
                XCTAssertNil(none)
            case .failure(let error):
                XCTAssertNotNil(error)
            case .none:
                #if DEBUG
                print("UWU what this?! >M<")
                #endif
        }
        
        do {
            let oneResult = try result?.get()
            let twoResult = try secondResult?.get()
            
            let aString = oneResult?.compactMap { $0 }
            let ABZString = twoResult?.compactMap { $0 }
            
            // Should return A since it has the highest weight
            if let result = aString {
                XCTAssertTrue(String(result) == "A")
            }
            
            // Should return ABZ since it has the most weight and contains AB
            if let result = ABZString {
                XCTAssertTrue(String(result) == "ABZ")
            }
        } catch {
            #if DEBUG
            print(result)
            #endif
        }
    }
    
    func testUserWeightUpdateMethod() {
        let testData: [(String, Int)] = [("ABC", 1), ("A", 200), ("ABA", 10), ("ABZ", 100)]
        let trie = PrefixTree(vocabulary: testData)
        
        var initialResult: Result<String, AutoCompleteError>?
        var updatedResult: Result<String, AutoCompleteError>?
        var multipleUserWeightedResult: Result<String, AutoCompleteError>?
        
        trie.autoCompleteOne(currentString: "") { initialResult = $0 }
        trie.updateUserWeight(word: "ABC")
        trie.autoCompleteOne(currentString: "") { updatedResult = $0 }
        trie.updateUserWeight(word: "ABA")
        trie.updateUserWeight(word: "ABA")
        trie.autoCompleteOne(currentString: "") { multipleUserWeightedResult = $0 }
        
        // Verify node has been updated
        let updatedNode = trie.findNode(word: "ABC")
        let anotherUpdatedNode = trie.findNode(word: "ABA")
        
        XCTAssertNotNil(updatedNode)
        XCTAssertNotNil(updatedNode?.userWeight)
        XCTAssertTrue(updatedNode?.userWeight! == 1)
        
        XCTAssertNotNil(anotherUpdatedNode)
        XCTAssertNotNil(anotherUpdatedNode?.userWeight)
        XCTAssertTrue(anotherUpdatedNode?.userWeight! == 2)
        
        do {
            let initial = try initialResult?.get()
            let updated = try updatedResult?.get()
            let anotherOne = try multipleUserWeightedResult?.get()
            
            // Should return A since it has the highest default weight
            if let result = initial {
                XCTAssertTrue(result == "A")
            }
            
            // Should return ABC since it has a user weight despite low default weight
            if let result = updated {
                XCTAssertTrue(result == "ABC")
            }
            
            // Should return ABA since it has the highest user weight after updating
            if let result = anotherOne {
                XCTAssertTrue(result == "ABA")
            }
        } catch {
            #if DEBUG
            print("UWU what is going on?")
            #endif
        }
    }
}
