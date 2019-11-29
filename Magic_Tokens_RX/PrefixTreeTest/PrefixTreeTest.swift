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

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
