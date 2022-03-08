import Foundation


class Plane {
    private var rectangleArray: [Rectangle] = []
    var rectangleCount: Int {
        return rectangleArray.count
    }
    var boundsOfRectangles: [Rectangle.Bound] {
        var bounds: [Rectangle.Bound] = []
        for rectangle in rectangleArray {
            bounds.append(rectangle.rangeOfPoint())
        }
        return bounds
    }
    
    func addRectangle() {
        let rectangle: Rectangle = Factory.createRandomRectangle()
        rectangleArray.append(rectangle)
    }
    
    subscript(index: Int) -> Rectangle {
        return rectangleArray[index]
    }
    
    func isTouchedOnRectangle(at point: Rectangle.Point) -> Bool {
        for bound in boundsOfRectangles {
            if bound.rangeOfX.contains(point.x) && bound.rangeOfY.contains(point.y) {
                return true
            }
        }
        return false
    }
    
    func TouchedRectangle(at point: Rectangle.Point) -> Rectangle? {
        guard isTouchedOnRectangle(at: point) else {
            return nil
        }
        
        return rectangleArray[0]
    }
}
