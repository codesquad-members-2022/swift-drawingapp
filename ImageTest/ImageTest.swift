//
//  ImageTest.swift
//  RectangleTest
//
//  Created by juntaek.oh on 2022/03/08.
//

import XCTest
@testable import DrawingApp

class ImageTest: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        guard let namedImage = UIImage(named: "010") else{
            return
        }
        
        let image = Image(image: MyImage(image: namedImage), size: MySize(width: 100, height: 100), point: MyPoint(x: 15, y: 15), alpha: Alpha.seven)
        let description = image.description
        let myImage = image.image
        let size = image.size
        let point = image.point
        let alpha = image.alpha
        
        image.changeAlpha(alpha: .one)
        let modifiedAlpha = image.alpha
        
        let findedLocationTrue = image.findLocationRange(xPoint: 30, yPoint: 30)
        let findedLocationFalse = image.findLocationRange(xPoint: 200, yPoint: 200)
    }

    func testPerformanceExample() throws {
        self.measure {
        }
    }

}
