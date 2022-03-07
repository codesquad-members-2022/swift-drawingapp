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
    
    func testPlaneCountRectangle() {
        let plane = Plane()
        var number = 0
        let screenSize = (Double(ViewController().view.safeAreaLayoutGuide.layoutFrame.size.width), Double(ViewController().view.safeAreaLayoutGuide.layoutFrame.size.height))
        guard let rect1 = RectangleFactory(screenSize: screenSize).makeRandomRectangle() else {return}
        XCTAssertEqual(plane.rectangleCount, number)
        plane.addRectangle(rectangle: rect1)
        number += 1
        XCTAssertEqual(plane.rectangleCount, number)
    }
    
    func testPlaneReturnIndexedRectangle() {
        let plane = Plane()
        XCTAssertNil(plane[0])
        let screenSize = (Double(ViewController().view.safeAreaLayoutGuide.layoutFrame.size.width), Double(ViewController().view.safeAreaLayoutGuide.layoutFrame.size.height))
        guard let rect1 = RectangleFactory(screenSize: screenSize).makeRandomRectangle() else {return}
        plane.addRectangle(rectangle: rect1)
        guard let indexedRectangle = plane[0] else {return}
        XCTAssertEqual(indexedRectangle, rect1)
    }
    
    func testPlaneIsRectangleAtPosition() {
        let plane = Plane()
        let rectangleSize = Size(width: 150, height: 120)
        let rectanglePosition = Position(x: 300, y: 300)
        guard let rectangleColor = Color(red: 255, green: 255, blue: 255) else {return}
        guard let rectangleAlpha = Alpha(transparency: 10) else  {return}
        let rectangle = Rectangle(size: rectangleSize, position: rectanglePosition, color: rectangleColor, alpha: rectangleAlpha )
        plane.addRectangle(rectangle: rectangle)
        XCTAssertEqual(plane[0], rectangle)
        XCTAssertEqual(plane.isRectangle(at: Position(x: 400, y: 400)), rectangle)
    }
}
