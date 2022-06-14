import UIKit

extension UIColor {
    var rgbFloat: (red: CGFloat, green: CGFloat, blue: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue)
    }
    
    var rgb16String: String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return "#" + String(format: "%02X", Int(red * 255)) + String(format: "%02X", Int(green * 255)) + String(format: "%02X", Int(blue * 255))
    }
}
