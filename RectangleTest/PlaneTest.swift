//
//  PlaneTest.swift
//  RectangleTest
//
//  Created by juntaek.oh on 2022/03/02.
//

import XCTest
@testable import DrawingApp

class PlaneTest: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        var plane = Plane()
        let madeRect = Rectangle(id: "ABC", size: MySize(width: 100, height: 100), point: MyPoint(x: 20, y: 20), color: RGBColor(red: 100, green: 100, blue: 100), alpha: Alpha.eight)
        
        plane.addRectangle(rectangle: madeRect)
        let count = plane.count()
        let rect = plane[0]
        let findRect1 = plane.findRectangle(withX: 80, withY: 80)
        let findRect2 = plane.findRectangle(withX: 200, withY: 200)
        let findRect3 = plane.findRectangleIndex(rectangle: madeRect)
        let findRect4 = plane.findRectangleIndex(rectangle: Rectangle(id: "ABC", size: MySize(width: 100, height: 100), point: MyPoint(x: 20, y: 20), color: RGBColor(red: 100, green: 100, blue: 100), alpha: Alpha.eight))
        let findRect5 = plane.findRectangleIndex(rectangle: Rectangle(id: "ABC", size: MySize(width: 100, height: 100), point: MyPoint(x: 10, y: 20), color: RGBColor(red: 100, green: 100, blue: 100), alpha: Alpha.eight))
    }

    func testPerformanceExample() throws {
        self.measure {
        }
    }

}
