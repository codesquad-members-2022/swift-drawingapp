//
//  drawingAppTests.swift
//  drawingAppTests
//
//  Created by Kai Kim on 2022/02/28.
//

import XCTest
@testable import drawingApp

class drawingAppTests: XCTestCase {

    private var sut : RectangleFactory!
    
    override func setUpWithError() throws {
        sut = RectangleFactory(screenWidth: 151, screenHeight: 141)
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    
    func testRandomPoint() throws {
        let rect2 = RectangleFactory(screenWidth: 0, screenHeight: 0)
        XCTAssertThrowsError(try rect2.generateRandomPoint())
       
        let rect3 = RectangleFactory(screenWidth: 150, screenHeight: 141)
        XCTAssertThrowsError(try rect3.generateRandomPoint())
        
        let rect4 = RectangleFactory(screenWidth: 151, screenHeight: 141)
        XCTAssertNoThrow(try rect4.generateRandomPoint())
    }
    
    func testmakeRect() throws {
        let rect = sut.makeRect()
        XCTAssertTrue(rect != nil, "사각형 생성 에러!")
    }
    
    
 

}
