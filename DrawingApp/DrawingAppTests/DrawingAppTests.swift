//
//  DrawingAppTests.swift
//  DrawingAppTests
//
//  Created by Jihee hwang on 2022/03/03.
//

import XCTest
@testable import DrawingApp

class DrawingAppTests: XCTestCase {
    
    func testCreateID() {
        let count = ID.createId().count
        XCTAssertEqual(count, 11)
    }
    
    func testCountingRectangle() {
        let plane = Plane()
        plane.addRectangle()
        let count = plane.countingRectangle()
        
        XCTAssertEqual(count, 1)
    }
    
    func testExist() {
        let plane = Plane()
        let rectangle = plane.addRectangle()
        let point = rectangle.point
        let exist = plane.isExist(point: point)
        
        XCTAssertEqual(rectangle, exist)
    }
}
