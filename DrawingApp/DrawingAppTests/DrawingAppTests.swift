//
//  DrawingAppTests.swift
//  DrawingAppTests
//
//  Created by Jihee hwang on 2022/03/03.
//

import XCTest
@testable import DrawingApp

class DrawingAppTests: XCTestCase {
    
    func testId() {
        let factory = Factory()
        let id = factory.createId().count
        
        XCTAssertEqual(11, 11)
    }
    
    func testFactoryArray() {
        let factoryArray = FactoryArray()
        let array = factoryArray.createRectanleArray().count
        
        XCTAssertEqual(4, 4)
    }
    
}
