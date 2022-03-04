import Foundation


protocol ViewMutable: AnyObject{
    func changeSelectedRectangleViewAlpha(opacity: Int)
    func changeSelectedRecntagleViewColor(rgb: [Double])
}
