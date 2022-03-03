import Foundation

class Factory {
    static func createRandomRectangle(name: String) -> RectangleView {
        return RectangleView(name: name)
    }
    struct RectangleView: CustomStringConvertible {
        enum Alpha: Int {
            case one = 1
            case two
            case three
            case four
            case five
            case six
            case seve
            case eight
            case nine
            case ten
            
            func selectRandomAlpha() -> Self {
                let randomInt = Int.random(in: 1...10)
                guard let alpha =  Alpha(rawValue: randomInt) else {
                    //TODO: 나중에 이것은 수정이 되어야할거같다.
                    return Alpha.one
                }
                return alpha
            }
        }
        
        struct BackgroundColor {
            let R: UInt8
            let G: UInt8
            let B: UInt8
        }
        struct Size {
            let width: Double = 150.0
            let height: Double = 120.0
        }
        struct Point {
            let x: Double
            let y: Double
        }

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
        let size = Size()
        var point: Point {
            // 아이패드 앱에서 Safe Area 내에서 화면이 짤리지 않고 보이는 4개의 점이 자리할 수 있는 x와 y값의 범위 지정
            let randomX: Double = Double.random(in: 20...1010)
            let randomY: Double = Double.random(in: 24...680)
            return Point(x: randomX, y: randomY)
        }
        var color: BackgroundColor {
            let randomR: UInt8 = UInt8.random(in: 0...255)
            let randomG: UInt8 = UInt8.random(in: 0...255)
            let randomB: UInt8 = UInt8.random(in: 0...255)
            return BackgroundColor(R: randomR, G: randomG, B: randomB)
        }
        //TODO: 이 부분 어떻게 하면 더 깔끔하게 할 수 있을지 질문하자.
        var alpha: Alpha {
            let randomInt = Int.random(in: 1...10)
            guard let alpha =  Alpha(rawValue: randomInt) else {
                return self.alpha
            }
            return alpha
        }

        var description: String {
            return "(\(self.id)), X:\(self.point.x), Y:\(self.point.y), W\(self.size.width), H\(self.size.height), R\(self.color.R), G\(self.color.G), B\(self.color.B), Alpha: \(self.alpha.rawValue)"
        }
        let name: String
        init(name: String) {
            self.name = name
        }
    }
}
