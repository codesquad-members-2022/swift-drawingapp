//
//  DrawingappTests.swift
//  DrawingappTests
//
//  Created by seongha shin on 2022/02/28.
//

import XCTest
@testable import Drawingapp

class DrawingappTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    let plane = Plane()
    
    class TestView: PlaneOutput {
        var drawSquare: Rectangle?
        var selectSquare: Rectangle?
        
        func didDisSelectedSquare(to square: Rectangle?) {
        }
        
        func didSelectedSquare(to square: Rectangle?) {
            self.selectSquare = square
        }
        
        func drawSquare(to square: Rectangle) {
            self.drawSquare = square
        }
        
        func updateSquare(to square: Rectangle) {
        }
        func update(to id: String, color: Color) {
        }
        
        func update(to id: String, point: Point) {
        }
        
        func update(to id: String, size: Size) {
        }
        
        func update(to id: String, alpha: Alpha) {
        }
    }
    
    class testRandomColorGenerator: RandomColorValueGenerator {
        var ramdomValue: [Int] = []
        func next() -> [Int] {
            ramdomValue = (0..<3).map{ _ in Int.random(in: 0...255) }
            return ramdomValue
        }
    }
    
    func testRandomColor() {
        let randomGenerator = testRandomColorGenerator()
        let color = ColorFactory.make(using: randomGenerator)
        
        XCTAssertEqual(randomGenerator.ramdomValue[0], color.r)
        XCTAssertEqual(randomGenerator.ramdomValue[1], color.g)
        XCTAssertEqual(randomGenerator.ramdomValue[2], color.b)
    }
    
    //사각형을 하나 만들고, 터치 action에 사각형 좌표X에 200을 더해 선택되지 않음을 확인
    func testNotSelectSquare() {
        let testView = TestView()
        plane.delegate = testView
        
        plane.makeSquareButtonTapped()
        XCTAssertTrue(testView.drawSquare != nil, "사각형이 생성되지 않았습니다")
        
        guard let square = testView.drawSquare else {
            return
        }
        
        plane.drawingBoardTapped(where: Point(x: square.point.x + 200.0, y: square.point.y))
        XCTAssertTrue(testView.selectSquare == nil, "사각형이 선택되었습니다")
    }
    
    //사각형을 하나 만들고, 터치 action에 사각형 좌표를 보내 선택되는지 확인
    func testSelectSquare() {
        let testView = TestView()
        plane.delegate = testView
        
        plane.makeSquareButtonTapped()
        XCTAssertTrue(testView.drawSquare != nil, "사각형이 생성되지 않았습니다")
        
        guard let square = testView.drawSquare else {
            return
        }
        
        plane.drawingBoardTapped(where: Point(x: square.point.x, y: square.point.y))
        XCTAssertTrue(testView.selectSquare != nil, "사각형이 선택되지 않았습니다")
    }
}
