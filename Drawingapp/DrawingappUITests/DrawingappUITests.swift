//
//  DrawingappUITests.swift
//  DrawingappUITests
//
//  Created by seongha shin on 2022/02/28.
//

import XCTest
import Drawingapp

class DrawingappUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }
    
    func testCreateSquare() {
        let newSquare = Square.make()
        print(newSquare)
    }
}
