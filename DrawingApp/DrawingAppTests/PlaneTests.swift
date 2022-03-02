//
//  DrawingAppTests.swift
//  DrawingAppTests
//
//  Created by Bumgeun Song on 2022/02/28.
//

import XCTest
@testable import DrawingApp

class PlaneTests: XCTestCase {

    func testExample() throws {
        let two = 1 + 1
        XCTAssertEqual(two, 2)
    }
    
    func testInitialSetup() throws {
        let plane = Plane()
        plane.setUpInitialModels()
        XCTAssertEqual(plane.rectangleCount, 4)
    }
    
    func testAddRectangle() throws {
        let plane = Plane()
        plane.addRectangle()
        XCTAssertEqual(plane.rectangleCount, 1)
    }
    
    func testSelectedWhenTapped() {
        let plane = Plane()
        plane.setUpInitialModels()
        
        for testIndex in 0..<plane.rectangleCount {
            let testPoint = plane[testIndex].center
            plane.tap(on: testPoint)
            XCTAssertNotNil(plane.selected)
            XCTAssertTrue(plane.selected!.contains(testPoint))
        }
    }
    
    func testSelectedWhenEmptyTapped() {
        let plane = Plane()
        plane.setUpInitialModels()
        
        let emptyPoint = Point(x: Double(0), y: Double(0))
        plane.tap(on: emptyPoint)
        XCTAssertNil(plane.selected)
    }
}
