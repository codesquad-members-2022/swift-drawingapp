import UIKit
import OSLog

class ViewController: UIViewController {
    var rectangleArray: [Rectangle] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        for index in 1...4 {
            let rect = Factory.createRandomRectangle(name: "Rect\(index)")
            rectangleArray.append(rect)
        }
        for rectangle in rectangleArray {
            os_log("\(rectangle.description)")
        }
        for rect in rectangleArray {
            let view: UIView = UIView(frame: CGRect(x: rect.point.x, y: rect.point.y, width: rect.size.width, height: rect.size.height))
            view.backgroundColor = UIColor(displayP3Red: CGFloat(rect.color.R)/255, green: CGFloat(rect.color.G)/255, blue: CGFloat(rect.color.B)/255, alpha: CGFloat(rect.alpha.rawValue))
            self.view.addSubview(view)
        }
    }
}
