import Foundation

struct Plane {

    let factory: SquareFactory = SquareFactory()

    var square: [String: Square] = [:]

    mutating func addSquare(frameWidth: Double, frameHeight: Double) {
        let square = self.factory.createRandomSquare(frameWidth: frameWidth, frameHeight: frameHeight)
        self.square[square.id] = square
        var userInfo: [AnyHashable : Any]? = [:]
        print(square)
        userInfo?["id"] = square.id
        userInfo?["rectangle"] = square.rectangle

        NotificationCenter.default.post(name: Notification.Name("UpdatePlane"), object: nil, userInfo: userInfo)
    }

    var totalSquareCount: Int {
        get {
            return self.square.count
        }
    }

    func setSquareColor(id: String, R: UInt8, G: UInt8, B: UInt8) {
        square[id]?.R = R
        square[id]?.G = G
        square[id]?.B = B
        print(square[id]!)
    }

    func setSquareAlpha(id: String, alpha: Double) {
        square[id]?.alpha = Int(alpha)
    }

    subscript(position: Point) -> String? {
        for (_, value) in self.square.reversed() {
            if value.isPointIncluded(position: position) == true {
                return value.id
            }
        }
        return nil
    }
}
