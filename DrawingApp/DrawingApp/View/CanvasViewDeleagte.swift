import Foundation

protocol CanvasViewDelegate: AnyObject{
    func creatingRectangleRequested()
    func updatingSelectedRectangleViewAlphaCompleted(opacity: Int)
    func updatingSelectedRectangleViewColorCompleted(rgb: [Double])
}
