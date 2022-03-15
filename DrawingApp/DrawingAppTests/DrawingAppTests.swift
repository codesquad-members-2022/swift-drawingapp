//
//  DrawingAppTests.swift
//  DrawingAppTests
//
//  Created by 김상혁 on 2022/03/15.
//

import XCTest
@testable import DrawingApp

class DrawingAppTests: XCTestCase {
    
    private func createShapeForTest() -> BasicShape {
        let shapeID = RandomRectangleFactory.generateRandomIdentifier()
        let shapePoint = RandomRectangleFactory.generateRandomPoint(xBound: Point.Range.lower,
                                                                    yBound: Point.Range.lower)
        let shape = BasicShape(identifier: shapeID, point: shapePoint)
        
        return shape
    }
    
    func testAddRectangle() {
        let plane = Plane()
        
        let countBeforeAddRectangle = plane.count
        plane.addRectangle(bound: (Point.Range.lower, Point.Range.lower), by: RandomRectangleFactory.self)
        let countAfterAddRectangle = plane.count
        
        XCTAssertEqual(countBeforeAddRectangle + 1, countAfterAddRectangle)
    }

    func testUpdateSelected() {
        let plane = Plane()

        let selectedBeforeUpdateSelected = plane.selected

        let shape = createShapeForTest()
        plane.updateSelected(shape: shape)

        let selectedAfterUpdateSelected = plane.selected
        XCTAssertNotEqual(selectedBeforeUpdateSelected, selectedAfterUpdateSelected)
    }

    func testClearSelected() {
        let plane = Plane()

        let shape = createShapeForTest()
        plane.updateSelected(shape: shape)

        let selectedBeforeClearSelected = plane.selected
        XCTAssertNotNil(selectedBeforeClearSelected)

        plane.clearSelected()

        let selectedAfterClearSelected = plane.selected
        XCTAssertNil(selectedAfterClearSelected)
    }
}
