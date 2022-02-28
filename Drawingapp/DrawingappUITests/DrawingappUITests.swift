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
    let plane = Plane()
    
    func testNotSelectSquare() {
        plane.state.selectedSquare = { square in
            XCTAssertTrue(square == nil, "사각형이 선택되었습니다")
        }
        
        //사각형의 기본 생성위치
        //0, 0, 150, 120
        plane.action.makeSquareButtonTapped()
        plane.action.onScreenTouched(Point(x: 151, y: 121))
    }
    
    func testSelectSquare() {
        plane.state.selectedSquare = { square in
            XCTAssertTrue(square != nil, "사각형이 선택되지 않았습니다")
        }
        
        //사각형의 기본 생성위치
        //0, 0, 150, 120
        plane.action.makeSquareButtonTapped()
        plane.action.onScreenTouched(Point(x: 150, y: 120))
    }
    
    func testCreateSquare() {
        let newSquare = factory.makeSquare()
        print(newSquare)
    }
}
