import Foundation
import UIKit

protocol CanvasViewDelegate: AnyObject{
    func creatingRectangleRequested()
    func updatingSelectedRectangleViewAlphaCompleted(opacity: Int)
    func updatingSelectedRectangleViewColorCompleted(newColor: UIColor)
}
