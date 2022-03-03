import UIKit
import OSLog

class ViewController: UIViewController {
    var rectangleArray: [Factory.RectangleView] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        for index in 1...4 {
            let rect = Factory.createRandomRectangle(name: "Rect\(index)")
            rectangleArray.append(rect)
        }
        for rectangle in rectangleArray {
            os_log("\(rectangle.description)")
        }
    }
}
