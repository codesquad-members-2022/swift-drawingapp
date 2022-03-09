//
//  RectangleTest.swift
//  RectangleTest
//
//  Created by juntaek.oh on 2022/02/28.
//

import XCTest
@testable import DrawingApp

class RectangleTest: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        let rectangle = Rectangle(id: "abcd", size: MySize(width: 100, height: 100), point: MyPoint(x: 10, y: 10), color: RGBColor(red: 100/255, green: 100/255, blue: 100/255), alpha: Alpha.five)
        
        let id = rectangle.id
        let point = rectangle.point
        let size = rectangle.size
        let alpha = rectangle.alpha
        let color = rectangle.color
        let description = rectangle.description
    }

    func testPerformanceExample() throws {
        measure {
        }
    }

}
