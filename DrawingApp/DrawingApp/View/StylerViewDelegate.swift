import Foundation


protocol StylerViewDelegate: AnyObject{
    func changeSelectedRectangleViewAlpha(opacity: Int)
    func changeSelectedRecntagleViewColor(rgb: [Double])
}
