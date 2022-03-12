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
        let id = IDFactory.makeRandomID()
        let size = Size(width: 150, height: 120)
        let point = Point.random()
        let rgb = RGB.random()
        let alpha = Alpha(1.2)

        let testRectangle = Rectangle(id: id, origin: point, size: size, backGroundColor: rgb, alpha: alpha)
        sut.addRectangle(rectangle: testRectangle)
        sut.findSeletedRectangle(x: round(testRectangle.origin.x), y: round(testRectangle.origin.y))
        
        let testAlpha = Alpha(2.3)
        sut.change(alpha: testAlpha)

        XCTAssertEqual(testRectangle.alpha, testAlpha)
    }

    
    
    func testChangeColor() {
        let id = IDFactory.makeRandomID()
        let size = Size(width: 150, height: 120)
        let point = Point.random()
        let rgb = RGB(red: 10, green: 10, blue: 10)
        let alpha = Alpha.random()
        
        let testRectangle = Rectangle(id: id, origin: point, size: size, backGroundColor: rgb, alpha: alpha)
        sut.addRectangle(rectangle: testRectangle)
        sut.findSeletedRectangle(x: round(testRectangle.origin.x), y: round(testRectangle.origin.y))
        
        let testRGB = RGB(red: 10, green: 11, blue: 12)
        sut.change(color: testRGB)
        
        XCTAssertEqual(testRectangle.rgb, testRGB)
    }
    
    func testAddRectangle() {
        let id = IDFactory.makeRandomID()
        let size = Size(width: 150, height: 120)
        let point = Point.random()
        let rgb = RGB.random()
        let alpha = Alpha.random()
        
        let testRectangle = Rectangle(id: id, origin: point, size: size, backGroundColor: rgb, alpha: alpha)
        
        sut.addRectangle(rectangle: testRectangle)
        
        XCTAssertTrue(sut.count == 1)
    }
    
    
    func testFindSeletedRectangle() {
        let id = IDFactory.makeRandomID()
        let size = Size(width: 150, height: 120)
        let point = Point(x: 10.0, y: 10.0)
        let rgb = RGB.random()
        let alpha = Alpha(0.5)

        let testRectangle = Rectangle(id: id, origin: point, size: size, backGroundColor: rgb, alpha: alpha)
        let x = round(testRectangle.origin.x)
        let y = round(testRectangle.origin.y)

        sut.addRectangle(rectangle: testRectangle)
        
        let correctKey = Point(x: x, y: y)
        let inCorrectKey = Point(x: 12.456, y: 15.234)

        sut.findSeletedRectangle(x: correctKey.x, y: correctKey.y)
        sut.change(alpha: Alpha(0.1))
        
        XCTAssertTrue(testRectangle.alpha == Alpha(0.1))
        
        sut.findSeletedRectangle(x: inCorrectKey.x, y: inCorrectKey.y)
        sut.change(alpha: Alpha(0.7))
        
        XCTAssertFalse(testRectangle.alpha == Alpha(0.7))
    }
    
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

}
