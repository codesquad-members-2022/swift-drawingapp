
//  DrawingApp
//
//  Created by Jihee hwang on 2022/03/10.
//

import Foundation
import UIKit

struct Convert {
    
    static func getUIColor(color: Color, alpha: Alpha) -> UIColor {
        return UIColor(red: color.r / 255, green: color.g / 255, blue: color.b / 255, alpha: alpha.value)
    }
    
    static func getCGSize(size: Size) -> CGSize {
        return CGSize(width: size.width, height: size.height)
    }
    
    static func getCGPoint(point: Point) -> CGPoint {
        return CGPoint(x: point.x, y: point.y)
    }
    
}
