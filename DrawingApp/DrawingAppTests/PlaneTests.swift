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
        (0..<5).forEach { _ in plane.add(layerType: .rectangle) }
        (0..<5).forEach { _ in plane.add(layerType: .photo, data: Data()) }
        (0..<5).forEach { _ in plane.add(layerType: .label) }
        super.setUp()
    }
    
    func testExample() throws {
        let two = 1 + 1
        XCTAssertEqual(two, 2)
    }
    
    func testAddRectangle() throws {
        let plane = Plane()
        plane.add(layerType: .rectangle)
        XCTAssertEqual(plane.rectangleCount, 1)
    }
    
    func testAddPhoto() throws {
        let plane = Plane()
        plane.add(layerType: .photo, data: Data())
        XCTAssertEqual(plane.photoCount, 1)
    }
    
    func testAddLabel() throws {
        let plane = Plane()
        plane.add(layerType: .label)
        XCTAssertEqual(plane.labelCount, 1)
    }
    
    func testSelect() {
        for testIndex in 0..<plane.layerCount {
            guard let testPoint = plane[testIndex]?.center else { return }
            plane.tap(on: testPoint)
            XCTAssertNotNil(plane.selected)
            XCTAssertTrue(plane.selected!.contains(testPoint))
        }
    }
    
    func testUnselect() {
        let emptyPoint = Point(x: Double(0), y: Double(0))
        plane.tap(on: emptyPoint)
        XCTAssertNil(plane.selected)
    }
    
    func testChangeSelectedColor() {
        guard let testPoint = plane[0]?.center else { return }
        plane.tap(on: testPoint)
        
        guard let selected = plane.selected as? ColorMutable else { return }
        
        let color = Color.random()
        plane.changeSelected(toColor: color)
        
        XCTAssertEqual(selected.color.red, color.red)
        XCTAssertEqual(selected.color.green, color.green)
        XCTAssertEqual(selected.color.blue, color.blue)
    }
    
    func testChangeSelectedAlpha() {
        guard let testPoint = plane[0]?.center else { return }
        plane.tap(on: testPoint)
        
        let alpha = Alpha.random()
        plane.changeSelected(toAlpha: alpha)
        
        guard let selected = plane.selected as? AlphaMutable else { return }
        XCTAssertEqual(selected.alpha.value, alpha.value)
    }
    
    func testChangeSelectedOrigin() {
        guard let testPoint = plane[0]?.center else { return }
        plane.tap(on: testPoint)
        
        let origin = Point.random()
        plane.changeSelected(toOrigin: origin)
        
        XCTAssertEqual(plane.selected?.origin.x, origin.x)
        XCTAssertEqual(plane.selected?.origin.y, origin.y)
        
    }
    
    func testChangeSelectedSize() {
        guard let testPoint = plane[0]?.center else { return }
        plane.tap(on: testPoint)
        
        let size = Size.standard()
        plane.changeSelected(toSize: size)
        
        XCTAssertEqual(plane.selected?.size.width, size.width)
        XCTAssertEqual(plane.selected?.size.height, size.height)
    }
    
    func testChangeLayerOrigin() {
        for i in 0..<plane.layerCount {
            let point = Point.random()
            guard let layer = plane[i] else { return }
            plane.change(layer: layer, toOrigin: point)
            XCTAssertEqual(layer.origin.x, point.x)
            XCTAssertEqual(layer.origin.y, point.y)
        }
    }
    
    func testChangeLayerSize() {
        for i in 0..<plane.layerCount {
            let size = Size(width: Double.random(in: 1...300), height: Double.random(in: 1...300))
            guard let layer = plane[i] else { return }
            plane.change(layer: layer, toSize: size)
            XCTAssertEqual(layer.size.width, size.width)
            XCTAssertEqual(layer.size.height, size.height)
        }
    }
    
    func testReorder() {
        let fromIndex = Int.random(in: 0..<plane.layerCount)
        let toIndex = Int.random(in: 0..<plane.layerCount)
        
        let someLayer = plane[fromIndex]
        
        plane.reorderLayer(fromIndex: fromIndex, toIndex: toIndex)
        
        XCTAssertEqual(someLayer, plane[toIndex])
    }
    
    func testReorderCommand() {
        for i in 0..<plane.layerCount {
            for command in Plane.reorderCommand.allCases {
                
                guard let someLayer = plane[i] else { return }
                plane.reorderLayer(someLayer, to: command)
                
                switch command {
                case .bringForward:
                    if i == plane.layerCount-1 {
                        XCTAssertEqual(someLayer, plane[i])
                    } else {
                        XCTAssertEqual(someLayer, plane[i+1])
                    }
                    
                case .bringToFront:
                    XCTAssertEqual(someLayer, plane[plane.layerCount-1])
                    
                case .sendBackward:
                    if i == 0 {
                        XCTAssertEqual(someLayer, plane[i])
                    } else {
                        XCTAssertEqual(someLayer, plane[i-1])
                    }
                    
                case .sendToBack:
                    XCTAssertEqual(someLayer, plane[0])
                }
            }
        }
    }
}
