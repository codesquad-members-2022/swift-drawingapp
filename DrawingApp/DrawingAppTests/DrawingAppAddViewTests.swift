//
//  DrawingAppAddViewTests.swift
//  DrawingAppAddViewTests
//
//  Created by 백상휘 on 2022/02/28.
//

import XCTest
@testable import DrawingApp

class DrawingAppAddViewTests: XCTestCase {

    func testDrawViewExceeded() throws {
        for _ in 1...100 {
            let view = ViewController().view!
            let model = FactoryViewRandomProperty(name: "random", superview: view).make()
            
            if model.isExceeded(superView: view) {
                print(model)
                XCTFail()
            }
        }
    }
}
