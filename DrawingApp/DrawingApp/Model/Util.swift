
//  DrawingApp
//
//  Created by Jihee hwang on 2022/03/10.
//

import Foundation
import UIKit

struct Util {
    private(set) var color: Color
    private(set) var alpha: Alpha
    
    func getUIColor() -> UIColor {
        let red = color.r / 255
        let green = color.g / 255
        let blue = color.b / 255
        let alpha = alpha.value
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
