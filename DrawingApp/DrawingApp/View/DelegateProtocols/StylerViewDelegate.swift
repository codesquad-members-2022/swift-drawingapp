import Foundation
import UIKit


protocol StylerViewDelegate: AnyObject{
    func updatingSelectedRectangleAlphaRequested(opacity: Int)
    func updatingSelectedRectangleColorRequested()
}
