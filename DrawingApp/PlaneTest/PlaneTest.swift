//
//  PlaneTest.swift
//  PlaneTest
//
//  Created by dale on 2022/03/03.
//

import XCTest
@testable import DrawingApp

class PlaneTest: XCTestCase {
    
    func testPlaneInitiallize() {
        let plane = Plane()
        XCTAssertEqual(plane.rectangleCount, 0)
    }
    
    func testPlaneAddAndCountRectangle() {
        let plane = Plane()
        var number = 0
        let screenSize = (Double(ViewController().view.safeAreaLayoutGuide.layoutFrame.size.width), Double(ViewController().view.safeAreaLayoutGuide.layoutFrame.size.height))
        let rect1 = RectangleFactory(screenSize: screenSize).makeRandomRectangle()
        XCTAssertEqual(plane.rectangleCount, number)
        plane.addRectangle(rectangle: rect1)
        number += 1
        XCTAssertEqual(plane.rectangleCount, number)
    }
    
    func testPlaneReturnIndexedRectangle() {
        let plane = Plane()
        XCTAssertNil(plane[0])
        let screenSize = (Double(ViewController().view.safeAreaLayoutGuide.layoutFrame.size.width), Double(ViewController().view.safeAreaLayoutGuide.layoutFrame.size.height))
        let rect1 = RectangleFactory(screenSize: screenSize).makeRandomRectangle()
        plane.addRectangle(rectangle: rect1)
        guard let indexedRectangle = plane[0] else {return}
        XCTAssertEqual(indexedRectangle, rect1)
    }
    
    func testPlaneIsRectangleAtPosition() {
        let plane = Plane()
        let rectangle = Rectangle(size: Size(width: 150, height: 120), position: Position(x: 300, y: 300), color: Color(red: 255, green: 255, blue: 255), alpha: Alpha(transparency: 10))
        plane.addRectangle(rectangle: rectangle)
        XCTAssertEqual(plane[0], rectangle)
        XCTAssertEqual(plane.isRectangle(at: Position(x: 400, y: 400)), true)
    }
}
