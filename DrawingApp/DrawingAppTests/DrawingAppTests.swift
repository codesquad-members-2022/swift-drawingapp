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
        let alpha = Alpha.random()
        
        let testRectangle = Rectangle(id: id, origin: point, size: size, backGroundColor: rgb, alpha: alpha)
        
        sut.selectedRectangle = testRectangle
        let testAlpha = Alpha(2.3)
        
        sut.change(alpha: testAlpha)
        
        XCTAssertEqual(sut.selectedRectangle!.alpha, testAlpha)
    }
    
    func testChangeColor() {
        let id = IDFactory.makeRandomID()
        let size = Size(width: 150, height: 120)
        let point = Point.random()
        let rgb = RGB.random()
        let alpha = Alpha.random()
        
        let testRectangle = Rectangle(id: id, origin: point, size: size, backGroundColor: rgb, alpha: alpha)
        
        sut.selectedRectangle = testRectangle
        let testRGB = RGB(red: 10, green: 11, blue: 12)
        
        sut.change(color: testRGB)
        
        XCTAssertEqual(sut.selectedRectangle!.rgb, testRGB)
    }
    
    func testAddRectangle() {
        let id = IDFactory.makeRandomID()
        let size = Size(width: 150, height: 120)
        let point = Point.random()
        let rgb = RGB.random()
        let alpha = Alpha.random()
        
        let testRectangle = Rectangle(id: id, origin: point, size: size, backGroundColor: rgb, alpha: alpha)
        
        sut.addRectangle(rectangle: testRectangle)
        
        XCTAssertTrue(sut.rectangles.count == 1)
    }
    
    
    func testFindSeletedRectangle() {
        let id = IDFactory.makeRandomID()
        let size = Size(width: 150, height: 120)
        let point = Point.random()
        let rgb = RGB.random()
        let alpha = Alpha.random()
        
        let testRectangle = Rectangle(id: id, origin: point, size: size, backGroundColor: rgb, alpha: alpha)
        let x = round(testRectangle.origin.x)
        let y = round(testRectangle.origin.y)
        
        let correctKey = Point(x: x, y: y)
        let inCorrectKey = Point(x: 12.456, y: 15.234)
        
        sut.rectangles[correctKey] = testRectangle
        sut.findSeletedRectangle(x: x, y: y)
        
        let shouldTrue = sut.selectedRectangle == sut.rectangles[correctKey]
        let shouldFalse = sut.selectedRectangle == sut.rectangles[inCorrectKey]
        
        XCTAssertTrue(shouldTrue)
        XCTAssertFalse(shouldFalse)
    }
    
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

}
