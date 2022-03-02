//
//  RandomRectangleMaker.swift
//  RectangleTest
//
//  Created by juntaek.oh on 2022/03/02.
//

import XCTest
@testable import DrawingApp

class RandomRectangleMakerTest: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        let randomRectangle = RandomRectangleMaker()
        randomRectangle.makeRectangle(viewWidth: 500, viewHeight: 500)
    }

    func testPerformanceExample() throws {
        self.measure {
        }
    }

}
