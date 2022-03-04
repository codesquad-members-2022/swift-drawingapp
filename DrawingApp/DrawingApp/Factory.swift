import Foundation

class Factory {
    static func createRandomRectangle(name: String) -> RectangleView {
        var  id: String {               // UUID: xxx-xxx-xxx
            var uuid = UUID().uuidString.split(separator: "-").map{String($0)}
            uuid.removeFirst()
            uuid.removeLast()
            var resultArray: [String] = []
            for cell in uuid {
                var temp = cell
                temp.removeLast()
                resultArray.append(temp)
            }
            return resultArray.joined(separator: "-")
        }
        let size = RectangleView.Size()
        var point: RectangleView.Point {
            // 아이패드 앱에서 Safe Area 내에서 화면이 짤리지 않고 보이는 4개의 점이 자리할 수 있는 x와 y값의 범위 지정
            let randomX: Double = Double.random(in: 20...1010)
            let randomY: Double = Double.random(in: 24...680)
            return RectangleView.Point(x: randomX, y: randomY)
        }
        var color: RectangleView.BackgroundColor {
            let randomR: UInt8 = UInt8.random(in: 0...255)
            let randomG: UInt8 = UInt8.random(in: 0...255)
            let randomB: UInt8 = UInt8.random(in: 0...255)
            return RectangleView.BackgroundColor(R: randomR, G: randomG, B: randomB)
        }
        let alpha : RectangleView.Alpha = .random()
        return RectangleView(name: name, id: id, point: point, size: size, color: color, alpha: alpha)
    }
}
