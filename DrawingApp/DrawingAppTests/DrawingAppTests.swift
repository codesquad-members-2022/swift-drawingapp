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

    override func setUpWithError() throws {
        sut = RectangleFactory()
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testRectangleFactoryIsInitialized() {
        sut.createRectangle()
    }
}
