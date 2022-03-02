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
