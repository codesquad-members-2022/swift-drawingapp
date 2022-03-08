//
//  RectangleFactoryTest.swift
//  RectangleTest
//
//  Created by juntaek.oh on 2022/02/28.
//

import XCTest
@testable import DrawingApp

class RectangleFactoryTest: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        guard let namedImage = UIImage(named: "010") else{
            return
        }
        
        let rectangleFactory = RectangleFactory()
        
        let randomSize = rectangleFactory.makeSize()
        let randomPoint = rectangleFactory.makePoint(viewWidth: 500, viewHeight: 500)
        let randomColor = rectangleFactory.makeColor()
        let randomAlpha = rectangleFactory.makeAlpha()
        
        let wrongRandomPoint = rectangleFactory.makePoint(viewWidth: 100, viewHeight: 100)
        let rectangle = rectangleFactory.makeRandomRectangle(viewWidth: 200, viewHeight: 200)
        let imageRectangle = rectangleFactory.makeRandomImageRectangle(image: MyImage(image: namedImage), viewWidth: 100, viewHeight: 100)
    }

    func testPerformanceExample() throws {
        self.measure {
        }
    }

}
