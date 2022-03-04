import XCTest
@testable import DrawingApp

class PlaneTest: XCTestCase {

    
    func testAddingRectangles(){
        var plane = Plane()
        let rectangle = Rectangle(id: Rectangle.Id(), size: Rectangle.Size(width: 200, height: 200), point: Rectangle.Point(x: 100, y: 100), backgroundColor: Rectangle.Color(r: 10, g: 10, b: 10), alpha: Rectangle.Alpha.eight)
        plane.addRectangle(rectangle)
        
        XCTAssertEqual(plane.count, 1)
    }
    
    func testRandomRectangleCorrectlyInTheGivenRange(){
        var plane = Plane()
        let rectangle = Rectangle(id: Rectangle.Id(), size: Rectangle.Size(width: 200, height: 200), point: Rectangle.Point(x: 100, y: 100), backgroundColor: Rectangle.Color(r: 10, g: 10, b: 10), alpha: Rectangle.Alpha.eight)
        plane.addRectangle(rectangle)
        
        XCTAssertNotNil(plane[150,150])
        XCTAssertNil(plane[400,400])
    }
}
