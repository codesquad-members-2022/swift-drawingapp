import Foundation

protocol StylerViewControllerDelegate: AnyObject{
    func updatingSelectedRectangleColorRequested()
    func updatingSelectedRectangleAlphaRequested(opacity: Int)
    func updatingSelectedRectanglePointXRequested(increase: Bool)
    func updatingSelectedRectanglePointYRequested(increase: Bool)
}
