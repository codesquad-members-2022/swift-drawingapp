//
//  DrawingAppTests.swift
//  DrawingAppTests
//
//  Created by 안상희 on 2022/03/08.
//

import XCTest
@testable import DrawingApp

class DrawingAppTests: XCTestCase {
    var sut: RectangleFactory!
    var sut2: Plane!

    override func setUpWithError() throws {
        sut = RectangleFactory()
        sut2 = Plane()
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        sut2 = nil
        try super.tearDownWithError()
    }
    
    func testRectangleFactoryIsInitialized() {
        let rectangle = sut.createRectangle()
        XCTAssertNotNil(rectangle)
    }
    
    func testRectangleIsAddedToPlane() {
        let rectangle = sut.createRectangle()
        sut2.createRectangle()
        XCTAssertEqual(sut2.rectangleCount, 1)
    }
    
    
    func testPlaneSubscript() {
        let rectangle = sut2.createRectangle()
        XCTAssertEqual(sut2.rectangles.first!, sut2[0])
    }
}
