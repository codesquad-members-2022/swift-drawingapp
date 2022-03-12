import Foundation
import UIKit

protocol CanvasViewDelegate: AnyObject{
    func creatingRectangleRequested()
    func pickingImageRequested()
}
