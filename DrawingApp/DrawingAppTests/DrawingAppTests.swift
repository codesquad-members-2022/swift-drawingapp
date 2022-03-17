//
//  DrawingAppTests.swift
//  DrawingAppTests
//
//  Created by 박진섭 on 2022/03/09.
//

import XCTest
@testable import DrawingApp

class DrawingAppTests: XCTestCase {

    var sut:Plane!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Plane()
    }

    func testChangeAlpha() {
        let testRectangle = sut.addRectangle()
        let point = testRectangle.origin
        sut.findSeletedRectangle(point: point)
        
        let testAlpha = Alpha(2.3)
        sut.change(alpha: testAlpha)

        XCTAssertEqual(testRectangle.alpha, testAlpha)
    }

    
    
    func testChangeColor() {
        let testRectangle = sut.addRectangle()
        let point = testRectangle.origin
        
        sut.findSeletedRectangle(point: point)
        
        let testRGB = RGB(red: 10, green: 11, blue: 12)
        sut.change(color: testRGB)
        
        XCTAssertEqual(testRectangle.rgb, testRGB)
    }
    
    func testAddRectangle() {
        sut.addRectangle()
        XCTAssertTrue(sut.count == 1)
    }
    
    
    func testFindSelectedRectangle() {
        
        let willSelectedRectangle = sut.addRectangle()
        let willNotSelectedRectangle = sut.addRectangle()
        
        let x = willSelectedRectangle.origin.x
        let y = willSelectedRectangle.origin.y
        let imutableAlpha = willNotSelectedRectangle.alpha
        
        sut.findSeletedRectangle(point: Point(x: x, y: y))
        sut.change(alpha:Alpha(0.7))
        
        XCTAssertEqual(willSelectedRectangle.alpha, Alpha(0.7))
        XCTAssertEqual(willNotSelectedRectangle.alpha, imutableAlpha)
    }
    
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

}
