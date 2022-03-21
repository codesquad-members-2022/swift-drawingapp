import Foundation
import UIKit


protocol StylerViewDelegate: AnyObject{
    func updatingSelectedRectangleAlphaRequested(opacity: Int)
    func updatingSelectedRectangleColorRequested()
    func updatingSelectedRectanglePointXRequested(increase: Bool)
    func updatingSelectedRectanglePointYRequested(increase: Bool)
}
