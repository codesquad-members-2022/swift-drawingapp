import Foundation

struct Plane {

    let factory: SquareFactory = SquareFactory()

    var square: [Square] = []

    mutating func addSquare(frameWidth: Double, frameHeight: Double) {
        let square = self.factory.createRandomSquare(frameWidth: frameWidth, frameHeight: frameHeight)
        self.square.append(square)
        NotificationCenter.default.post(name: Notification.Name("UpdatePlane"), object: square)
    }
    
    var totalSquareCount: Int {
        get {
            return self.square.count
        }
    }

    subscript(index: Int) -> Square {
        return square[index]
    }

    subscript(position: Point) -> Square? {
        for s in self.square.reversed() {
            if s.isPointIncluded(position: position) == true {
                return s
            }
        }
        return nil
    }
}
