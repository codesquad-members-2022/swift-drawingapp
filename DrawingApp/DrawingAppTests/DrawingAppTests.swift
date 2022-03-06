//
//  DrawingAppTests.swift
//  DrawingAppTests
//
//  Created by 김동준 on 2022/03/04.
//

import XCTest
import os
@testable import DrawingApp

class DrawingAppTests: XCTestCase {
    func testAddRectangle() throws {
        var plane = Plane()
        plane.addRectangle()
        XCTAssertEqual(plane.rectangleCount(), 1)
    }
    
    func testChangedColor(){
        var plane = Plane()
        plane.addRectangle()
        let beforeColor = plane.selectedRectangleColor()
        plane.changeColor()
        let afterColor = plane.selectedRectangleColor()
        XCTAssertTrue(afterColor != beforeColor)
    }
    
    func testChangedAlpha(){
        var plane = Plane()
        plane.addRectangle()
        
        let beforeAlpha = plane.selectedRectangleAlpha()
        XCTAssertTrue(beforeAlpha == 1.0)
        
        plane.minusAlpha()
        let minusAlpha = plane.selectedRectangleAlpha()
        XCTAssertTrue(minusAlpha == 0.9)
        
        plane.plusAlpha()
        let plusAlpha = plane.selectedRectangleAlpha()
        XCTAssertTrue(plusAlpha == 1.0)
    }
}
