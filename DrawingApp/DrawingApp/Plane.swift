import Foundation
//보낼 메시지를 정의
//3번 전의 준비 과정 - 1
protocol RectangleAddedDelegate {
    // 매개 변수에서 왜 사각형을 보내야 할까요? -> 사각형을 만들었다는 사실을 알리기 위해
    func didMakeRectangle(rectangle: Rectangle)
}
protocol RectangleTouchedDelegate {
    func touchedRectangle(rectangle: Rectangle)
}

protocol PlaneColorChangeDelegate {
    func didChangeColor(rectangle: Rectangle)
}

class Plane {
    private var rectangleArray: [Rectangle] = []
    
    // 델리게이트 등록 - 3번 전의 준비과정 - 2
    // 추후에 이 델리게이트를 "자기"라고 self로 지정하는 녀석이 나타날 때 사용할 속성
    var addedRectangleDelegate :RectangleAddedDelegate?
    var touchedRectangleDelegate : RectangleTouchedDelegate?
    var colorDelegate: PlaneColorChangeDelegate?
    
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
    
    // 나 사각형 만들었어라는 메시지(옵저버 or 델리게이트)(2번 이후에 모델이 일처리를 하는 메서드)
    func addRectangle() {
        let rectangle: Rectangle = Factory.createRandomRectangle()
        rectangleArray.append(rectangle)
        
        //3번 전의 준비 과정 - 3
        addedRectangleDelegate?.didMakeRectangle(rectangle: rectangle)
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
    
    func touchedRectangle(at point: Rectangle.Point) {
        let touchedResult = isTouchedOnRectangle(at: point)
        guard touchedResult.bool == true else {
            return
        }
        touchedRectangleDelegate?.touchedRectangle(rectangle: rectangleArray[touchedResult.index])
    }
    
    func changeColorOfRectangle(_ rectangle: Rectangle) {
        var oldRectangle = rectangle
        let newRectangle = oldRectangle.changeColor()
        self.colorDelegate?.didChangeColor(rectangle: newRectangle)
    }
}
