import UIKit
import OSLog

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    var plane: Plane = Plane()
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        print(sender.location(in: self.view))
    }
    
    func shouldRectanglesBeTouched() {
        for view in self.view.subviews {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            view.addGestureRecognizer(tap)
        }
    }
    
    func addRectangles() {
        for _ in 0..<4 {
            self.plane.addRectangle()
        }
    }
    
    func showRectangleViews() {
        for index in 0..<plane.rectangleCount {
            let rectangle = plane[index]
            let rectView = UIView(frame: CGRect(x: rectangle.getPoint().x, y: rectangle.getPoint().y, width: rectangle.getSize().width, height: rectangle.getSize().height))
            rectView.backgroundColor = UIColor(red: CGFloat(rectangle.getColor().R)/255.0, green: CGFloat(rectangle.getColor().G)/255.0, blue: CGFloat(rectangle.getColor().B)/255.0, alpha: CGFloat(rectangle.getAlpha().rawValue)/10.0)
            print(rectangle.getAlpha().rawValue)
            self.view.addSubview(rectView)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRectangles()
        showRectangleViews()
        shouldRectanglesBeTouched()
    }
}
