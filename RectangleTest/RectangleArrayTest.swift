//
//  RectangleArray.swift
//  RectangleTest
//
//  Created by juntaek.oh on 2022/02/28.
//

import XCTest
@testable import DrawingApp

class RectangleArrayTest: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        let rectangleArray = RectangleArray()
        
        rectangleArray.makeRectangle(viewWidth: 400, viewHeight: 400)
        let madeRectangle = rectangleArray.nowMadeRectangle()
        
        let rectangle = Rectangle(id: "abcd", size: MySize(width: 100, height: 100), point: MyPoint(x: 10, y: 10), color: RGBColor(red: 100/255, green: 100/255, blue: 100/255), alpha: Alpha.five)
        
        rectangleArray.appendRectangle(rectangle: rectangle)
        let madeRectangle2 = rectangleArray.nowMadeRectangle()
        
        rectangleArray.makeRectangle(viewWidth: 700, viewHeight: 700)
        let madeRectangle3 = rectangleArray.nowMadeRectangle()
    }

    func testPerformanceExample() throws {
        self.measure {
        }
    }

}
