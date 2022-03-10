import Foundation
import UIKit


protocol StylerViewDelegate: AnyObject{
    func updatingRectangleInfoCompleted()
    func updatingSelectedRectangleViewAlphaRequested(opacity: Int)
    func updatingSelectedRecntagleViewColorRequested()
    func updatingSelectedRectangleViewColorInfoCompleted(newColor: UIColor)
    func clearingSelectedRectangleInfoCompleted()
}
