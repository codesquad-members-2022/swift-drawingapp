//
//  DrawingAppTests.swift
//  DrawingAppTests
//
//  Created by jsj on 2022/03/02.
//

import XCTest
@testable import DrawingApp

class DrawingAppTests: XCTestCase {
    // MARK:- Color
    func testRectangle_colorInitial() throws {
        let color = Color(red:0, green: 0, blue: 0)
        XCTAssertEqual(color.red, 0)
        XCTAssertEqual(color.green, 0)
        XCTAssertEqual(color.blue, 0)
    }

    func testRectangle_colorInitial_overflow() throws {
        let color = Color(red:256, green: 256, blue: 300)
        XCTAssertEqual(color.red, 255)
        XCTAssertEqual(color.green, 255)
        XCTAssertEqual(color.blue, 255)
    }

    func testRectangle_colorInitial_underflow() throws {
        let color = Color(red:-1, green: -2, blue: -100)
        XCTAssertEqual(color.red, 0)
        XCTAssertEqual(color.green, 0)
        XCTAssertEqual(color.blue, 0)
    }
    
    // MARK:- UniqueID
    func testUniqueID_generatedStringCount() throws {
        let splitDash = 3
        let stringCount = 4
        let separator = "-"
        
        let uniqueID = UniqueID.generate(split: splitDash, stringCount: stringCount, separatedBy: separator)
        let separatedUID = uniqueID.components(separatedBy: separator)
        XCTAssertEqual(separatedUID.count, splitDash)
        XCTAssertEqual(separatedUID[0].count, 4)
    }
    
    // MARK:- Plane
    func testPlane_createRectangleCount() throws {
        let plane = Plane()
        plane.createRect()
        let count = plane.countRect()
        XCTAssertEqual(count, 1)
    }
}
