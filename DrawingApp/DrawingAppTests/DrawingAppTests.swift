//
//  DrawingAppTests.swift
//  DrawingAppTests
//
//  Created by 송태환 on 2022/03/01.
//

import XCTest

class DrawingAppTests: XCTestCase {
    // MARK: - RectangleFactory
    func testRectangleFactory() {
        let rect = RectangleFactory.makeShape()
        
        XCTAssertEqual(rect.backgroundColor, .white)
        XCTAssertEqual(rect.alpha, .opaque)
        XCTAssertEqual(rect.origin.x, 0)
        XCTAssertEqual(rect.origin.x, 0)
        XCTAssertEqual(rect.size.width, 30)
        XCTAssertEqual(rect.size.height, 30)
        XCTAssertNil(type(of: rect) as? ImageRectangle.Type)
        
        let secondRect = RectangleFactory.makeRectangle(x: 50.5, y: 75.1, width: 100.3, height: 150.4)
        XCTAssertEqual(secondRect.backgroundColor, .white)
        XCTAssertEqual(secondRect.alpha, .opaque)
        XCTAssertEqual(secondRect.origin.x, 50.5)
        XCTAssertEqual(secondRect.origin.y, 75.1)
        XCTAssertEqual(secondRect.size.width, 100.3)
        XCTAssertEqual(secondRect.size.height, 150.4)
        
        XCTAssertNotEqual(rect.id, secondRect.id)
        
        let rectangle = RectangleFactory.makeRandomRectangle(with: URL(fileURLWithPath: "12345"))
        XCTAssertEqual(rectangle.backgroundColor, .white)
        XCTAssertEqual(rectangle.alpha, .opaque)
        XCTAssertEqual(rectangle.size.width, 150)
        XCTAssertEqual(rectangle.size.height, 120)
        XCTAssertNotNil(type(of: rectangle) as? ImageRectangle.Type)
    }
    
    // MARK: - ShapeFactoryCluster
    func testShapeFactoryCluster() {
        let rect = ShapeFactoryCluster.makeShape(with: Rectangle.self)
        XCTAssertNotNil(rect)
        XCTAssertNotNil(rect as? Rectangle)
        
        let round = ShapeFactoryCluster.makeShape(with: Round.self)
        XCTAssertNil(round)
    }
    
    // MARK: - Size Factory
    func testSizeFactory() {
        let range = 30.0...100.0
        let size = SizeFactory.makeTypeRandomly()
        XCTAssertTrue(range.contains(size.width))
        XCTAssertTrue(range.contains(size.height))
        XCTAssertEqual(size.width.toFixed(digits: 2), Double(size.width).toFixed(digits: 2))
        XCTAssertEqual(size.height.toFixed(digits: 2), Double(size.height).toFixed(digits: 2))
    }
    
    // MARK: - Size
    func testSize() {
        var size = Size(width: 30, height: 30)
        XCTAssertEqual(size.width, 30)
        XCTAssertEqual(size.height, 30)
        
        size = Size(width: 31.5, height: 30.5)
        XCTAssertEqual(size.width, 31.5)
        XCTAssertEqual(size.height, 30.5)
    }
    
    func testSizeConversion() {
        let size = Size(width: 30, height: 30)
        let result = size.convert(using: CGSize.self)
        XCTAssertEqual(size.width, result.width)
        XCTAssertEqual(size.height, result.height)
    }
    
    // MARK: - Point
    func testPoint() {
        var point = Point(x: 0, y: 10)
        XCTAssertEqual(point.x, 0)
        XCTAssertEqual(point.y, 10)
        
        point = Point(x: 15.5, y: 27.5)
        XCTAssertEqual(point.x, 15.5)
        XCTAssertEqual(point.y, 27.5)
    }
    
    func testPointConversion() {
        let point = Point(x: 10, y: 10)
        let result = point.convert(using: CGPoint.self)
        XCTAssertEqual(point.x, result.x)
    }
    
    func testPointComparison() {
        let point1 = Point(x: 0, y: 10)
        let point2 = Point(x: 0, y: 10)
        
        XCTAssertEqual(point1, point2)
        
        let point3 = Point(x: 0, y: 20)
        XCTAssertGreaterThan(point3, point2)
        
        let point4 = Point(x: 10, y: 20)
        XCTAssertGreaterThan(point4, point3)
    }
    
    // MARK: - Color
    func testColor() {
        var color = Color(red: 0, green: 100, blue: 0)
        XCTAssertNotEqual(color, Color.white)
        XCTAssertEqual(color.red, 0)
        XCTAssertEqual(color.green, 100)
        XCTAssertEqual(color.blue, 0)
        
        color = .red
        XCTAssertEqual(color.red, 255.0)
    }
    
    // MARK: - Alpha
    func testAlpha() {
        var alpha = Alpha(rawValue: 0.5)
        XCTAssertNotNil(alpha)
        XCTAssertEqual(alpha, .five)
        
        print(alpha!.description)
        
        alpha = Alpha(rawValue: 0)
        XCTAssertNil(alpha)
        
        alpha = Alpha(rawValue: 1.1)
        XCTAssertNil(alpha)
    }
    
    func testAlphaConversion() {
        let alpha = Alpha.five
        let result = alpha.convert(using: CGFloat.self)
        XCTAssertEqual(CGFloat(alpha.rawValue), result)
    }
    
    func testAlphaRandomElement() {
        let alpha = Alpha.randomElement()
        let cgFloat = alpha.convert(using: CGFloat.self)
        let result = Alpha(rawValue: Float(cgFloat))
        XCTAssertEqual(alpha, result)
    }
    
    // MARK: - CGPoint
    func testCGPoint() {
        let point = Point(x: 100, y: 100)
        let result = CGPoint(with: point).convert(using: Point.self)
        XCTAssertEqual(point, result)
    }
    
    // MARK: - CGRect
    func testCGRect() {
        let rect = RectangleFactory.makeRandomRectangle()
        let cgRect = CGRect(with: rect)
        XCTAssertEqual(cgRect.size, rect.size.convert(using: CGSize.self))
    }
    
    // MARK: - CGSize
    func testCGSize() {
        let size = Size(width: 100, height: 100)
        let cgSize = CGSize(with: size)
        let result = cgSize.convert(using: Size.self)
        XCTAssertEqual(size, result)
    }
    
    // MARK: - Float
    func testFloat() {
        let singleDigitFloat = Float(0.111).toFixed(digits: 1)
        XCTAssertEqual(singleDigitFloat, 0.1)
    }
    
    // MARK: - Rectangle
    func testRectangle() {
        let rect = Rectangle(id: IdentifierFactory.makeTypeRandomly(), x: 0, y: 0, width: 100, height: 100)
        XCTAssertEqual(Point(x: 100, y: 100), rect.diagonalPoint)
        
        rect.setBackgroundColor(.blue)
        XCTAssertEqual(rect.backgroundColor, .blue)
        
        rect.setAlpha(.nine)
        XCTAssertEqual(rect.alpha, .nine)
    }
    
    func testRectangleConversion() {
        let rect = Rectangle(id: IdentifierFactory.makeTypeRandomly(), x: 0, y: 0, width: 100, height: 100)
        let result = rect.convert(using: CGRect.self)
        let counterpart = CGRect(with: rect)
        XCTAssertEqual(result, counterpart)
    }
    
    func testRectangleIsHashable() {
        var dictionary = [Rectangle: String]()
        let rect = RectangleFactory.makeRandomRectangle()
        dictionary.updateValue(rect.id, forKey: rect)
        XCTAssertEqual(dictionary[rect], rect.id)
    }
    
    // MARK: - ImageRectangle
    func testImageRectangle() {
        let rect = ImageRectangle(id: IdentifierFactory.makeTypeRandomly(), x: 0, y: 0, width: 100, height: 100, image: nil)
        XCTAssertNil(rect.image)
        
        let url = URL(fileURLWithPath: "123")
        rect.setImage(with: url)
        XCTAssertEqual(rect.image, url)
    }
    
    func testImageRectangleNotification() {
        let rect = ImageRectangle(id: IdentifierFactory.makeTypeRandomly(), x: 0, y: 0, width: 100, height: 100, image: nil)
        
        NotificationCenter.default.addObserver(forName: .ImageRectangleModelDidCreated, object: rect, queue: .main) { notification in
            let object = notification.object
            XCTAssertEqual(object as? ImageRectangle, rect)
        }
        
        rect.notifyDidCreated()
    }
    
    // MARK: - Plane
    func testPlane() {
        let plane = Plane()
        XCTAssertEqual(plane.count, 0)
        XCTAssertNil(plane.findItemBy(point: Point(x: 1, y: 1)))
        
        let rect = RectangleFactory.makeRectangle(x: 100, y: 100, width: 50, height: 50)
        plane.append(item: rect)
        XCTAssertEqual(plane.count, 1)
        XCTAssertNotNil(plane[id: rect.id])
        XCTAssertNotNil(plane[id: rect.id] as? Rectangle)
        XCTAssertEqual(plane[id: rect.id] as! Rectangle, rect)
        
        let secondRect = RectangleFactory.makeRectangle(x: 0, y: 0, width: 50, height: 50)
        plane.append(item: secondRect)
        XCTAssertNotNil(plane.findItemBy(point: Point(x: 30, y: 10)) as? Rectangle)
        
        print(plane)
    }
    
    func testPlaneRectangleSelectionManagement() {
        let plane = Plane()
        let rect = RectangleFactory.makeRectangle(x: 0, y: 0, width: 50, height: 50)
        plane.append(item: rect)
        
        plane.selectItem(id: "12345")
        XCTAssertNil(plane.currentItem)
        
        plane.selectItem(id: rect.id)
        XCTAssertNotNil(plane.currentItem as? Rectangle)
        XCTAssertEqual(plane.currentItem as! Rectangle, rect)
        
        plane.unselectItem()
        XCTAssertNil(plane.currentItem)
    }
    
    // MARK: - UIColor
    func testUIColor() {
        let color = UIColor(with: .white, alpha: .opaque)
        let (red, green, blue, alpha) = color.getRGBA()
        XCTAssertEqual(red, 1)
        XCTAssertEqual(green, 1)
        XCTAssertEqual(blue, 1)
        XCTAssertEqual(alpha, 1)
        
        XCTAssertEqual(color.toHexString(), "#FFFFFF")
    }
    
    func testRandomeUIColor() {
        let color = UIColor.random()
        let (red, green, blue, alpha) = color.getRGBA()
        let range: ClosedRange<CGFloat> = 0...1
        XCTAssertTrue(range.contains(red))
        XCTAssertTrue(range.contains(green))
        XCTAssertTrue(range.contains(blue))
        XCTAssertEqual(alpha, 1)
    }
}

class Round: Shapable {
    var id: String
    var size: Size
    var alpha: Alpha
    var origin: Point
    var backgroundColor: Color
    func setBackgroundColor(_ color: Color) {
        return
    }
    
    func setAlpha(_ alpha: Alpha) {
        return
    }
    
    var description: String {
        return ""
    }
    
    init() {
        self.id = IdentifierFactory.makeTypeRandomly()
        self.size = SizeFactory.makeTypeRandomly()
        self.alpha = Alpha.randomElement()
        self.origin = PointFactory.makeTypeRandomly()
        self.backgroundColor = .blue
    }
}
