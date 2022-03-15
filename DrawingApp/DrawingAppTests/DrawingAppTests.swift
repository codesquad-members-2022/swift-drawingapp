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

        let testRectangle = PlaneRectangle(id: id, origin: point, size: size, rgb: rgb, alpha: alpha)
        sut.addRectangle(creator: RectangleFactory())
        sut.findSeletedRectangle(x: round(testRectangle.origin.x), y: round(testRectangle.origin.y), size: size)
        
        let testAlpha = Alpha(2.3)
        sut.change(alpha: testAlpha)

        XCTAssertEqual(testRectangle.alpha, testAlpha)
    }

    
    
    func testChangeColor() {
        let testRectangle = sut.addRectangle(creator: RectangleFactory())
        
        sut.findSeletedRectangle(x: round(testRectangle.origin.x), y: round(testRectangle.origin.y), size: testRectangle.size)
        
        let testRGB = RGB(red: 10, green: 11, blue: 12)
        sut.change(color: testRGB)
        
        XCTAssertEqual(testRectangle.rgb, testRGB)
    }
    
    func testAddRectangle() {
        sut.addRectangle(creator: RectangleFactory())
        XCTAssertTrue(sut.count == 1)
    }
    
    
    func testFindSelectedRectangle() {
        
        let willSeletedRectangle = sut.addRectangle(creator: RectangleFactory())
        let TestRaectangle = sut.addRectangle(creator: RectangleFactory())
        
        let x = round(willSeletedRectangle.origin.x)
        let y = round(willSeletedRectangle.origin.y)
        let size = willSeletedRectangle.size
        
        let correctKey = Point(x: x, y: y)

        sut.findSeletedRectangle(x: correctKey.x, y: correctKey.y, size: size)
        
        sut.change(alpha:Alpha(0.7))
        
        XCTAssertEqual(willSeletedRectangle.alpha, Alpha(0.7))
    }
    
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

}
