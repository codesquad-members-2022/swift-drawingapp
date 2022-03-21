import Foundation

protocol StylerViewControllerDelegate: AnyObject{
    func updatingSelectedRectangleColorRequested()
    func updatingSelectedRectangleAlphaRequested(opacity: Int)
}
