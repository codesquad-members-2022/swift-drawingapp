import Foundation

extension Point : Hashable {
    static func ==(lhs: Point, rhs: Point) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.x)
        hasher.combine(self.y)
    }
}

struct Point {
    var x: Double = 0.0
    var y: Double = 0.0
    
    mutating func random() {
        let randomX: Double = Double.random(in: 20...738)
        let randomY: Double = Double.random(in: 24...680)
        self.x = randomX
        self.y = randomY
    }
    
    init() {
        random()
    }
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}
