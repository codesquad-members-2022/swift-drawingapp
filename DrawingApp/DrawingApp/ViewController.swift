import UIKit
import OSLog

class ViewController: UIViewController {
    var plane: Plane = Plane()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0..<4 {
            self.plane.addRectangle()
        }
        for index in 0..<plane.rectangleCount {
            let rectangle = plane[index]
            let rectView = UIView(frame: CGRect(x: rectangle.getPoint().x, y: rectangle.getPoint().y, width: rectangle.getSize().width, height: rectangle.getSize().height))
            rectView.backgroundColor = UIColor(red: CGFloat(rectangle.getColor().R)/255.0, green: CGFloat(rectangle.getColor().G)/255.0, blue: CGFloat(rectangle.getColor().B)/255.0, alpha: CGFloat(rectangle.getAlpha().rawValue)/10.0)
            self.view.addSubview(rectView)
        }
    }
}
