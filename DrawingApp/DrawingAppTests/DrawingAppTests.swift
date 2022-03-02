//
//  DrawingAppTests.swift
//  DrawingAppTests
//
//  Created by 송태환 on 2022/03/01.
//

import XCTest

class DrawingAppTests: XCTestCase {
    func testSize() {
        var size = Size(width: 30, height: 30)
        XCTAssertEqual(size.width, 30)
        XCTAssertEqual(size.height, 30)
        
        size.width = 100
        XCTAssertEqual(size.width, 100)
        
        size.height = 100
        XCTAssertEqual(size.height, 100)
        
        size = Size(width: 31.5, height: 30.5)
        XCTAssertEqual(size.width, 31.5)
        XCTAssertEqual(size.height, 30.5)
    }
    
    func testPoint() {
        var point = Point(x: 0, y: 10)
        XCTAssertEqual(point.x, 0)
        XCTAssertEqual(point.y, 10)
        
        point.x = 10
        XCTAssertEqual(point.x, 10)
        
        point.y = 30
        XCTAssertEqual(point.y, 30)
        
        point = Point(x: 15.5, y: 27.5)
        XCTAssertEqual(point.x, 15.5)
        XCTAssertEqual(point.y, 27.5)
    }
    
    func testColor() {
        var color = Color(red: 0, green: 100, blue: 0)
        XCTAssertNotEqual(color, Color.white)
        XCTAssertEqual(color.red, 0)
        XCTAssertEqual(color.green, 100)
        XCTAssertEqual(color.blue, 0)
        
        color.green = 0
        XCTAssertEqual(color.green, 0)
        XCTAssertEqual(color, Color.white)
    }
    
    func testAlpha() {
        var alpha = Alpha(raw: 5)
        XCTAssertEqual(alpha, .five)
        
        alpha = Alpha(value: -1)
        XCTAssertEqual(alpha, .ten)
        
        alpha = Alpha(value: 0)
        XCTAssertEqual(alpha, .ten)
        
        alpha = Alpha(value: 100)
        XCTAssertEqual(alpha, .ten)
    }
    
    func testRectangle() {
        let id = ShapeFactory.generateIdentifier()
        XCTAssertEqual(id.count, 11)
        
        let rect = ShapeFactory.makeRectangle()
        XCTAssertEqual(rect.backgroundColor, .white)
        XCTAssertEqual(rect.alpha, .ten)
        XCTAssertEqual(rect.point.x, 0)
        XCTAssertEqual(rect.point.x, 0)
        XCTAssertEqual(rect.size.width, 30)
        XCTAssertEqual(rect.size.height, 30)
        
        let secondRect = ShapeFactory.makeRectangle(x: 50.5, y: 75.1, width: 100.3, height: 150.4)
        XCTAssertEqual(secondRect.backgroundColor, .white)
        XCTAssertEqual(secondRect.alpha, .ten)
        XCTAssertEqual(secondRect.point.x, 50.5)
        XCTAssertEqual(secondRect.point.y, 75.1)
        XCTAssertEqual(secondRect.size.width, 100.3)
        XCTAssertEqual(secondRect.size.height, 150.4)
        
        XCTAssertNotEqual(rect.id, secondRect.id)
    }
}
