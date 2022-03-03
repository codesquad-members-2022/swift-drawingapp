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
        
        size = Size(width: 31.5, height: 30.5)
        XCTAssertEqual(size.width, 31.5)
        XCTAssertEqual(size.height, 30.5)
    }
    
    func testPoint() {
        var point = Point(x: 0, y: 10)
        XCTAssertEqual(point.x, 0)
        XCTAssertEqual(point.y, 10)
        
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
        
        color = .red
        XCTAssertEqual(color.red, 255.0)
    }
    
    func testAlpha() {
        var alpha = Alpha(rawValue: 5)
        XCTAssertNotNil(alpha)
        XCTAssertEqual(alpha, .five)
        
        alpha = Alpha(rawValue: 0)
        XCTAssertNil(alpha)
    }
    
    func testRectangle() {
        let rect = RectangleFactory.makeRectangle()
        XCTAssertEqual(rect.backgroundColor, .white)
        XCTAssertEqual(rect.alpha, .opaque)
        XCTAssertEqual(rect.point.x, 0)
        XCTAssertEqual(rect.point.x, 0)
        XCTAssertEqual(rect.size.width, 30)
        XCTAssertEqual(rect.size.height, 30)
        
        let secondRect = RectangleFactory.makeRectangle(x: 50.5, y: 75.1, width: 100.3, height: 150.4)
        XCTAssertEqual(secondRect.backgroundColor, .white)
        XCTAssertEqual(secondRect.alpha, .opaque)
        XCTAssertEqual(secondRect.point.x, 50.5)
        XCTAssertEqual(secondRect.point.y, 75.1)
        XCTAssertEqual(secondRect.size.width, 100.3)
        XCTAssertEqual(secondRect.size.height, 150.4)
        
        XCTAssertNotEqual(rect.id, secondRect.id)
    }
    
    func testPlane() {
        var plane = Plane()
        XCTAssertEqual(plane.countItems, 0)
        XCTAssertNil(plane.findItemBy(point: Point(x: 1, y: 1)))
        
        let rect = RectangleFactory.makeRectangle(x: 100, y: 100, width: 50, height: 50)
        plane.append(item: rect)
        XCTAssertEqual(plane.countItems, 1)
        XCTAssertEqual(plane[0], rect)
        
        let secondRect = RectangleFactory.makeRectangle(x: 0, y: 0, width: 50, height: 50)
        plane.append(item: secondRect)
        XCTAssertEqual(plane.findItemBy(point: Point(x: 30, y: 10)), secondRect)
    }
}
