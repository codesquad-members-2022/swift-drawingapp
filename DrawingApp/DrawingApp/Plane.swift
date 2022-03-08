import Foundation
//보낼 메시지를 정의 - 1
protocol PlaneDelegate {
    // 매개 변수에서 왜 사각형을 보내야 할까요? -> 사각형을 만들었다는 사실을 알리기 위해
    func didMakeRectangle(rectangle: Rectangle)
}

class Plane {
    private var rectangleArray: [Rectangle] = []
    
    // 델리게이트 등록 - 2
    var delegate :PlaneDelegate?
    
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
    
    // 나 사각형 만들었어라는 메시지(옵저버 or 델리게이트)
    func addRectangle() {
        let rectangle: Rectangle = Factory.createRandomRectangle()
        rectangleArray.append(rectangle)
        
        delegate?.didMakeRectangle(rectangle: rectangle)
    }
    
    subscript(index: Int) -> Rectangle {
        return rectangleArray[index]
    }
    
    func isTouchedOnRectangle(at point: Rectangle.Point) -> (bool: Bool, index: Int) {
        var index = 0
        for bound in boundsOfRectangles {
            if bound.rangeOfX.contains(point.x) && bound.rangeOfY.contains(point.y) {
                return (true, index)
            } else {
                index += 1
            }
        }
        // true일 때만 index 값을 활용해서 "99999"를 집어넣음
        return (false,99999)
    }
    
    func TouchedRectangle(at point: Rectangle.Point) -> Rectangle? {
        let touchedResult = isTouchedOnRectangle(at: point)
        guard touchedResult.bool == true else {
            return nil
        }
        return rectangleArray[touchedResult.index]
    }
}
