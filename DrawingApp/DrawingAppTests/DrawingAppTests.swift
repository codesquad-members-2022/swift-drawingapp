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
        var plane = Plane(rectangleFactory: CustomViewFactory())
        plane.addRandomRectangle()
        XCTAssertEqual(plane.rectangleCount(), 1)
    }
    
    func testChangedColor(){
        var plane = Plane(rectangleFactory: CustomViewFactory())
        plane.addRandomRectangle()
        let beforeColor = plane.selectedRectangle?.color
        plane.changeRectangleRandomColor()
        let afterColor = plane.selectedRectangle?.color
        XCTAssertTrue(afterColor != beforeColor)
    }
    
    func testChangedAlpha(){
        var plane = Plane(rectangleFactory: CustomViewFactory())
        plane.addRandomRectangle()
        
        let beforeAlpha = plane.selectedRectangle?.alpha
        XCTAssertTrue(beforeAlpha == 1.0)
        
        plane.minusAlpha()
        let minusAlpha = plane.selectedRectangle?.alpha
        XCTAssertTrue(minusAlpha == 0.9)
        
        plane.plusAlpha()
        let plusAlpha = plane.selectedRectangle?.alpha
        XCTAssertTrue(plusAlpha == 1.0)
    }
}
