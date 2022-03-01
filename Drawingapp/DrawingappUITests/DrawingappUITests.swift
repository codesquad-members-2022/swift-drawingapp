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
    
    //사각형을 하나 만들고, 터치 action에 사각형 좌표X에 200을 더해 선택되지 않음을 확인
    func testNotSelectSquare() {
        plane.state.selectedSquare = { square in
            XCTAssertTrue(square == nil, "사각형이 선택되었습니다")
        }
        
        plane.state.renderSquare = { square in
            self.plane.action.onScreenTouched(Point(x: square.point.x + 200, y: square.point.y))
        }
        
        plane.action.makeSquareButtonTapped()
    }
    
    //사각형을 하나 만들고, 터치 action에 사각형 좌표를 보내 선택되는지 확인
    func testSelectSquare() {
        plane.state.selectedSquare = { square in
            XCTAssertTrue(square != nil, "사각형이 선택되지 않았습니다")
        }
        
        plane.state.renderSquare = { square in
            self.plane.action.onScreenTouched(square.point)
        }
        
        plane.action.makeSquareButtonTapped()
    }
}
