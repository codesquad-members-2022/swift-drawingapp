
//  DrawingApp
//
//  Created by Jihee hwang on 2022/03/10.
//

import Foundation
import UIKit

struct Convert {
    
    static func toUIColor(color: Color, alpha: Alpha) -> UIColor {
        return UIColor(red: color.r / 255, green: color.g / 255, blue: color.b / 255, alpha: alpha.value)
    }
    
    static func toCGSize(size: Size) -> CGSize {
        return CGSize(width: size.width, height: size.height)
    }
    
    static func toCGPoint(point: Point) -> CGPoint {
        return CGPoint(x: point.x, y: point.y)
    }
    
}

extension UIColor {
    
    func toHex() -> String? {
        guard let components = cgColor.components, components.count >= 3 else {
            return nil // components가 [CGFloat]? 여서 옵셔널 바인딩, 최소 3개 이상
        }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        
        return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255)) // 
    }
    
}
