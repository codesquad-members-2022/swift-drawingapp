import Foundation
import UIKit


protocol StylerViewDelegate: AnyObject{
    func updatingSelectedRectangleAlphaRequested(opacity: Int)
    func updatingSelectedRectangleColorRequested()
    func updatingSelectedRectanglePointXRequested(increase: Bool)
    func updatingSelectedRectanglePointYRequested(increase: Bool)
    func updatingSelectedRectangleWidthRequested(increase: Bool)
    func updatingSelectedRectangleHeightRequested(increase: Bool)
}
