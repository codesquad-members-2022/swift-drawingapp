//
//  DrawingAppTests.swift
//  DrawingAppTests
//
//  Created by Bumgeun Song on 2022/02/28.
//

import XCTest
@testable import DrawingApp

class PlaneTests: XCTestCase {
    
    private var plane = Plane()
    
    override func setUp() {
        (0..<5).forEach { _ in plane.addRectangle() }
        (0..<5).forEach { _ in plane.addPhoto(data: Data()) }
        (0..<5).forEach { _ in plane.addLabel() }
        super.setUp()
    }
    
    func testExample() throws {
        let two = 1 + 1
        XCTAssertEqual(two, 2)
    }
    
    func testAddRectangle() throws {
        let plane = Plane()
        plane.addRectangle()
        XCTAssertEqual(plane.rectangleCount, 1)
    }
    
    func testAddPhoto() throws {
        let plane = Plane()
        plane.addPhoto(data: Data())
        XCTAssertEqual(plane.photoCount, 1)
    }
    
    func testAddLabel() throws {
        let plane = Plane()
        plane.addLabel()
        XCTAssertEqual(plane.labelCount, 1)
    }
    
    func testSelect() {
        setUp()
        
        for testIndex in 0..<plane.viewModelCount {
            guard let testPoint = plane[testIndex]?.center else { return }
            plane.tap(on: testPoint)
            XCTAssertNotNil(plane.selected)
            XCTAssertTrue(plane.selected!.contains(testPoint))
        }
    }
    
    func testUnselect() {
        setUp()
        
        let emptyPoint = Point(x: Double(0), y: Double(0))
        plane.tap(on: emptyPoint)
        XCTAssertNil(plane.selected)
    }
    
    func testSetSelectedColor() {
        setUp()
        
        guard let testPoint = plane[0]?.center else { return }
        plane.tap(on: testPoint)
        
        guard let selected = plane.selected as? ColorMutable else { return }
        
        let color = Color.random()
        plane.setSelected(to: color)
        
        XCTAssertEqual(selected.color.red, color.red)
        XCTAssertEqual(selected.color.green, color.green)
        XCTAssertEqual(selected.color.blue, color.blue)
    }
    
    func testSetSelectedAlpha() {
        setUp()
        
        guard let testPoint = plane[0]?.center else { return }
        plane.tap(on: testPoint)
        
        let alpha = Alpha.random()
        plane.setSelected(to: alpha)
        
        guard let selected = plane.selected as? AlphaMutable else { return }
        XCTAssertEqual(selected.alpha.value, alpha.value)
    }
    
    func testSetSelectedOrigin() {
        setUp()
        
        guard let testPoint = plane[0]?.center else { return }
        plane.tap(on: testPoint)
        
        let origin = Point.random()
        plane.setSelected(to: origin)
        
        XCTAssertEqual(plane.selected?.origin.x, origin.x)
        XCTAssertEqual(plane.selected?.origin.y, origin.y)
        
    }
    
    func testSetSelectedSize() {
        setUp()
        
        guard let testPoint = plane[0]?.center else { return }
        plane.tap(on: testPoint)
        
        let size = Size.standard()
        plane.setSelected(to: size)
        
        XCTAssertEqual(plane.selected?.size.width, size.width)
        XCTAssertEqual(plane.selected?.size.height, size.height)
    }
    
    func testSetViewModelOrigin() {
        setUp()
        
        for i in 0..<plane.viewModelCount {
            let point = Point.random()
            guard let viewModel = plane[i] else { return }
            plane.set(viewModel: viewModel, to: point)
            XCTAssertEqual(viewModel.origin.x, point.x)
            XCTAssertEqual(viewModel.origin.y, point.y)
        }
    }
    
    func testSetViewModelSize() {
        setUp()
        
        for i in 0..<plane.viewModelCount {
            let point = Point.random()
            guard let viewModel = plane[i] else { return }
            plane.set(viewModel: viewModel, to: point)
            XCTAssertEqual(viewModel.origin.x, point.x)
            XCTAssertEqual(viewModel.origin.y, point.y)
        }
    }
}
