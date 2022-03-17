import XCTest
@testable import DrawingApp

class PlaneTest: XCTestCase {

    
    func testAddingRectangles(){
        let plane = Plane()
        let rectangle = Rectangle(id: Id(), size: Size(width: 200, height: 200), point: Point(x: 100, y: 100), alpha: Alpha(opacity: Int.random(in: 0...9)))
        plane.addRectangle(rectangle)
        
        XCTAssertEqual(plane.count, 1)
    }
    
    func testRandomRectangleCorrectlyInTheGivenRange(){
        let plane = Plane()
        let rectangle = Rectangle(id: Id(), size: Size(width: 200, height: 200), point: Point(x: 100, y: 100), alpha: Alpha(opacity: Int.random(in: 0...9)))
        plane.addRectangle(rectangle)
        
        XCTAssertNotNil(plane[150,150])
        XCTAssertNil(plane[400,400])
    }
}
