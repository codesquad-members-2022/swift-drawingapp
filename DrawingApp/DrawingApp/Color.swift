import Foundation

struct Color {
    private(set) var red: Int = 0 {
        didSet {
            red = ColorExtension.adjustRange(value: oldValue)
        }
    }
    
    private(set) var green: Int = 0 {
        didSet {
            green = ColorExtension.adjustRange(value: oldValue)
        }
    }
    
    private(set) var blue: Int = 0 {
        didSet {
            blue = ColorExtension.adjustRange(value: oldValue)
        }
    }

    init(red: Int, green: Int, blue: Int) {
        self.red = ColorExtension.adjustRange(value: red)
        self.green = ColorExtension.adjustRange(value: green)
        self.blue = ColorExtension.adjustRange(value: blue)
    }
}

extension Color {
    enum Standard {
        case red
        case green
        case blue
        case white
        case black
        
        var rgb: Color {
            switch self {
            case .red:
                return Color(red: 255, green: 0, blue: 0)
            case .green:
                return Color(red: 0, green: 255, blue: 0)
            case .blue:
                return Color(red: 0, green: 0, blue: 255)
            case .white:
                return Color(red: 255, green: 255, blue: 255)
            case .black:
                return Color(red: 0, green: 0, blue: 0)
            }
        }
    }
}

fileprivate struct ColorExtension {
    static func adjustRange(value: Int) -> Int {
        if value < 0 {
            return 0
        }
        if value > 255 {
            return 255
        }
        return value
    }
}
