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
    
    let factory = Factory()
    
    func testCreateSquare() {
        let newSquare = factory.makeSquare()
        print(newSquare)
    }
}
