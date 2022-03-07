//
//  DrawingAppTests.swift
//  DrawingAppTests
//
//  Created by Jihee hwang on 2022/03/03.
//

import XCTest
@testable import DrawingApp

class DrawingAppTests: XCTestCase {
    
    func createID() {
        let count = ID.createId().count
        XCTAssertEqual(count, 11)
    }
}
