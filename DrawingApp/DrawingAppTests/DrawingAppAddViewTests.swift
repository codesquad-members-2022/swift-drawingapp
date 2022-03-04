//
//  DrawingAppAddViewTests.swift
//  DrawingAppAddViewTests
//
//  Created by 백상휘 on 2022/02/28.
//

import XCTest
@testable import DrawingApp

class DrawingAppAddViewTests: XCTestCase {
    
    let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
    
    func testDrawViewExceeded() throws {
        
        let factory = FactoryViewRandomProperty()
        let vc = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        vc.loadView()
        
        if let vc = vc as? MasterViewDelegate {
            factory.delegate = vc
        } else {
            XCTFail("MainViewController not implementing MasterViewDelegate")
        }
        
        for i in 1...100 {
            if factory.makeRandomView(as: "RandomView #\(i)") == nil {
                XCTFail()
                break
            }
        }
        
        guard let testModel = factory.makeRandomView(as: "Test") else {
            XCTFail()
            return
        }
        
        XCTAssertFalse(testModel.setPoint(RectPoint(x: -1, y: -1)), "Model set point negative value not execute intentionally.")
        XCTAssertTrue(testModel.setPoint(RectPoint(x: 1, y: 1)), "Model set point positive value not execute intentionally.")
        
        XCTAssertFalse(testModel.setSize(RectSize(width: -1, height: -1)), "Model set size negative value not execute intentionally.")
        XCTAssertTrue(testModel.setSize(RectSize(width: 1, height: 1)), "Model set size positive value not execute intentionally.")
        
        XCTAssertFalse(testModel.setAlpha(-1), "Model set alpha negative value not execute intentionally.")
        XCTAssertTrue(testModel.setAlpha(1), "Model set alpha positive value not execute intentionally.")
        
        LoggerUtil.debugLog(model: testModel)
    }
}
