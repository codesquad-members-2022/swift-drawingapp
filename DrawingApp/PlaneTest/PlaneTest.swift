//
//  PlaneTest.swift
//  PlaneTest
//
//  Created by 최예주 on 2022/03/07.
//

import XCTest
@testable import DrawingApp

class PlaneTest: XCTestCase {

    var plane: Plane!
    var rect: Rectangle!
//    var fectory = RectangleFactory!
    var factory: RectangleFactory!
    
    override func setUpWithError() throws {
        plane = Plane()
        factory = RectangleFactory()
        rect = factory.createRandomRectangle()
        
    }

    override func tearDownWithError() throws {
    }

    func testAdd() throws {
        plane.add(rectangle: rect)
        XCTAssertEqual(plane.count(), 1, "Plane 객체에 사각형이 추가되지 않았습니다. ")
    }
    
    func testGetRectangle() throws {
        plane.add(rectangle: rect)
        XCTAssertTrue(plane.getRectangle(index: 0) === rect, "getRectangle error")
    }
    
    
    func testCGPointToDoublePoint() throws {
        let cgpoint = CGPoint(x: 100.0, y: 100.0)
        CGPointToDoublePoint(cgpoint)
        XCTAssertFalse(CGPointToDoublePoint(cgpoint), Point(x: 100.0, y: 100.0))
    }
    
    func testisExsit() throws{
        // 특정 좌표를 받아 Double로 변환 -> 따로 구현
        // plane.Rectangles 안에 포함되는 좌표가 있는지 확인 -> 따로 구현
        // XCTassetTrue
        let point = CGPoint(x: 100.0, y: 100.0)
//        let point: Point = CGPointToDoublePoint(point: CGPoint(x: 100.0, y: 100.0))
        let existTestRectangle = factory.createRectangle(size: Size(width: 100.0, height: 100.0), position: Point(x: 100.0, y: 100.0))
        plane.add(rectangle: existTestRectangle)
        XCTAssertFalse(isExist(point, in plane.rectangles), "\(point)을 포함하는 사각형이 존재하지 않음")
    }
    
    
    
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
