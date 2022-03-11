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
    
    override func setUp() {
        self.plane.delegate = self
    }
    
    func getDrawingModelFactory() -> DrawingModelFactory {
        DrawingModelFactory(colorFactory: ColorFactory())
    }
    
    func testSizeChanged() {
        let testSize = Size(width: 200, height: 200)
        NotificationCenter.default.addObserver(forName: Plane.NotifiName.didMakeDrawingModel, object: nil, queue: nil) { notification in
            
            guard let model = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel else {
                XCTFail("사각형이 선택되지 않았습니다")
                return
            }
            model.update(size: testSize)
        }
        
        NotificationCenter.default.addObserver(forName: DrawingModel.NotifiName.updateSize, object: nil, queue: nil) { notification in
            
            guard let size = notification.userInfo?[DrawingModel.ParamKey.size] as? Size else {
                return
            }
            XCTAssertTrue(size.width == testSize.width && size.height == testSize.height, "크기가 다릅니다")
        }
        
        
        plane.makeRectangleModel(origin: Point(x: 100, y: 100))
    }
    
    func testSelectedRectangle() {
        NotificationCenter.default.addObserver(forName: Plane.NotifiName.didMakeDrawingModel, object: nil, queue: nil) { notification in
            
            let model = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel
            XCTAssertTrue(model != nil, "사각형이 생성되지 않았습니다")
            
            self.plane.touchPoint(Point(x: 100, y: 100))
        }
        
        NotificationCenter.default.addObserver(forName: Plane.NotifiName.didSelectedDrawingModel, object: nil, queue: nil) { notification in
            guard let model = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel else {
                XCTFail("사각형이 선택되지 않았습니다")
                return
            }
            XCTAssertTrue(true)
        }
        plane.makeRectangleModel(origin: Point(x: 100, y: 100))
    }
    
    //사각형 뷰 생성 테스트
    func testMakeRectangleModel() {
        NotificationCenter.default.addObserver(forName: Plane.NotifiName.didMakeDrawingModel, object: nil, queue: nil) { notification in
            
            let model = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel
            XCTAssertTrue(model != nil, "사각형이 생성되지 않았습니다")
        }
        plane.makeRectangleModel(origin: Point(x: 100, y: 100))
    }
}
