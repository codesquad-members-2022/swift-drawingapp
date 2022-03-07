//
//  PlaneTests.swift
//  DrawingAppTests
//
//  Created by 김한솔 on 2022/03/07.
//

import XCTest
@testable import DrawingApp

class PlaneTests: XCTestCase {
    
    var plane: Plane?

    override func setUpWithError() throws {
        self.plane = Plane()
    }

    override func tearDownWithError() throws {
        self.plane = nil
    }

    func testAddRectangle() throws {
        let size = Size(width: 150, height: 120)
        plane?.addNewRectangle(in: (width: 500, height: 500))
        
        XCTAssertEqual(plane?.count, 1)
        XCTAssertEqual(plane?[0].size, size)
        
        let newID = ID()
        guard let backgroundColor = BackgroundColor(r: 0, g: 0, b: 0) else {
            throw PlaneError.backgroundColorError
        }
        guard let alpha = Alpha(opacityLevel: 10) else {
            throw PlaneError.alphaError
        }
        let newRectangle = Rectangle(id: newID, width: 100, height: 150, x: 0, y: 0, backgroundColor: backgroundColor, alpha: alpha)
        
        plane?.addSpecificRectangle(newRectangle)
        
        XCTAssertEqual(plane?[1].id, newID)
    }
    
    func testSpecifyRectangle() throws {
        let newID = ID()
        guard let backgroundColor = BackgroundColor(r: 0, g: 0, b: 0) else {
            throw PlaneError.backgroundColorError
        }
        guard let alpha = Alpha(opacityLevel: 10) else {
            throw PlaneError.alphaError
        }
        let newRectangle = Rectangle(id: newID, width: 100, height: 150, x: 0, y: 0, backgroundColor: backgroundColor, alpha: alpha)
        
        plane?.addSpecificRectangle(newRectangle)
        
        guard let specifiedRectangle = plane?.specifyRectangle(point: Point(x: 50, y: 75)) else {
            throw PlaneError.specifyingError
        }
        XCTAssertEqual(specifiedRectangle, newRectangle)
        
    }
    
    func testChangeBackgroundColorOfRectangle() throws {
        let newID = ID()
        guard let previousColor = BackgroundColor(r: 0, g: 0, b: 0),
              let changingColor = BackgroundColor(r: 10, g: 10, b: 100) else {
            throw PlaneError.backgroundColorError
        }
        guard let alpha = Alpha(opacityLevel: 10) else {
            throw PlaneError.alphaError
        }
        let newRectangle = Rectangle(id: newID, width: 100, height: 150, x: 0, y: 0, backgroundColor: previousColor, alpha: alpha)
        
        plane?.addSpecificRectangle(newRectangle)
        
        guard let backgroundColorChangedRectangle = plane?.changeBackGroundColorOfRectangle(id: newID, to: changingColor) else {
            throw PlaneError.backgroundColorChangingError
        }
        
        XCTAssertEqual(backgroundColorChangedRectangle.backgroundColor, changingColor)
        XCTAssertNotEqual(backgroundColorChangedRectangle.backgroundColor, previousColor)
    }
    
    func testChangeAlphaOfRectangle() throws {
        let newID = ID()
        guard let backgroundColor = BackgroundColor(r: 0, g: 0, b: 0) else {
            throw PlaneError.backgroundColorError
        }
        guard let previousAlpha = Alpha(opacityLevel: 10),
        let changingAlpha = Alpha(opacityLevel: 1) else {
            throw PlaneError.alphaError
        }
        let newRectangle = Rectangle(id: newID, width: 100, height: 150, x: 0, y: 0, backgroundColor: backgroundColor, alpha: previousAlpha)
        
        plane?.addSpecificRectangle(newRectangle)
        
        guard let alphaChangedRectangle = plane?.changeAlphaValueOfRectangle(id: newID, to: changingAlpha) else {
            throw PlaneError.alphaChangingError
        }
        
        XCTAssertEqual(alphaChangedRectangle.alpha, changingAlpha)
        XCTAssertNotEqual(alphaChangedRectangle.alpha, previousAlpha)
    }


}

enum PlaneError: Error {
    case backgroundColorError
    case alphaError
    case specifyingError
    case backgroundColorChangingError
    case alphaChangingError
}
