//
//  DrawingappTests.swift
//  DrawingappTests
//
//  Created by seongha shin on 2022/02/28.
//

import XCTest
@testable import Drawingapp


class DrawingappTests: XCTestCase, PlaneDelegate {
    let plane = Plane()
    var drawingModel: DrawingModel?
    var selectedModel: DrawingModel?
    
    override func setUp() {
        self.plane.delegate = self
    }
    
    func injectDrawingModelFactory() -> DrawingModelFactory {
        DrawingModelFactory(colorFactory: ColorFactory())
    }
    
    func injectScreenSize() -> Size {
        Size(width: 1000, height: 1000)
    }
    
    func testOriginChanged() {
        expectation(forNotification: Plane.Event.didMakeDrawingModel, object: nil) { notification in
            self.drawingModel = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel
            return true
        }
        
        expectation(forNotification: DrawingModel.Event.updateOrigin, object: nil) { notification in
            self.drawingModel = notification.object as? DrawingModel
            return true
        }
        
        let testPoint = Point(x: 200, y: 200)
        let operation = BlockOperation {
            self.plane.makeRectangleModel(origin: Point(x: 100, y: 100))
            self.drawingModel?.update(origin: testPoint)
        }
        
        operation.start()
        let baseOrigin = self.drawingModel?.origin
        XCTAssertTrue(baseOrigin?.x == testPoint.x && baseOrigin?.y == testPoint.y, "사각형의 위치가 변경되지 않았습니다")
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testSizeChanged() {
        expectation(forNotification: Plane.Event.didMakeDrawingModel, object: nil) { notification in
            self.drawingModel = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel
            return true
        }
        
        expectation(forNotification: DrawingModel.Event.updateSize, object: nil) { notification in
            self.drawingModel = notification.object as? DrawingModel
            return true
        }
        
        let testSize = Size(width: 200, height: 200)
        
        let operation = BlockOperation {
            self.plane.makeRectangleModel(origin: Point(x: 100, y: 100))
            self.drawingModel?.update(size: testSize)
        }
        
        operation.start()
        let baseSize = self.drawingModel?.size
        XCTAssertTrue(baseSize?.width == testSize.width && baseSize?.height == testSize.height, "사각형의 크기가 변경되지 않았습니다")
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testSelectedRectangle() {
        expectation(forNotification: Plane.Event.didMakeDrawingModel, object: nil) { notification in
            self.drawingModel = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel
            return true
        }
        
        expectation(forNotification: Plane.Event.didSelectedDrawingModel, object: nil) { notification in
            self.selectedModel = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel
            return true
        }
        
        let operation = BlockOperation {
            self.plane.makeRectangleModel(origin: Point(x: 100, y: 100))
            self.plane.touchPoint(Point(x: 100, y: 100))
        }
        
        operation.start()
        XCTAssertTrue(self.drawingModel == self.selectedModel, "사각형이 선택되지 않았습니다")
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    //사각형 뷰 생성 테스트
    func testMakeRectangleModel() {
        expectation(forNotification: Plane.Event.didMakeDrawingModel, object: nil) { notification in
            self.drawingModel = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel
            return true
        }
        
        let operation = BlockOperation {
            self.plane.makeRectangleModel(origin: Point(x: 100, y: 100))
        }
        
        operation.start()
        
        XCTAssertTrue(self.drawingModel != nil, "사각형이 생성되지 않았습니다")
        waitForExpectations(timeout: 3, handler: nil)
    }
}
