import UIKit
import OSLog

class ViewController: UIViewController {
    var plane: Plane = Plane()
    var viewDictionary: [Rectangle : UIView] = [:]
    var selectedView: UIView?
    
    @IBOutlet weak var colorButton: UIButton!
    
    @IBAction func colorButtonTouched(_ sender: UIButton) {
        guard let thisRectView = self.selectedView else {
            return
        }
        var willBeChangedRectangle: Rectangle
        for (key, value) in viewDictionary {
            if value === thisRectView {
                willBeChangedRectangle = key
                plane.changeColorOfRectangle(willBeChangedRectangle)
                return
            }
        }
    }
    
    @IBAction func rectangleButtonTouched(_ sender: Any) {
        self.plane.addRectangle()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.colorButton.layer.borderWidth = 1.0
        self.colorButton.layer.borderColor = UIColor.darkGray.cgColor
        // 플레인의 대행 처리는 뷰컨트롤러가 맡겠다.
        plane.addedRectangleDelegate = self
        plane.touchedRectangleDelegate = self
        plane.colorDelegate = self
        BackgroundViewTouched()
        colorButton.setTitle("#FFFFFF", for: .normal)
    }
}

extension ViewController: UIGestureRecognizerDelegate {
        func BackgroundViewTouched() {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            self.view.addGestureRecognizer(tap)
        }
        
        @objc func handleTap(_ sender: UITapGestureRecognizer) {
            let viewPoint: CGPoint = sender.location(in: self.view)
            let rectPoint: Rectangle.Point = Rectangle.Point(x: viewPoint.x, y: viewPoint.y)
            plane.touchedRectangle(at: rectPoint)
        }
}

extension ViewController: RectangleAddedDelegate {
    func didMakeRectangle(rectangle: Rectangle) {
        let rectView = UIView(frame: CGRect(x: rectangle.getPoint().x, y: rectangle.getPoint().y, width: rectangle.getSize().width, height: rectangle.getSize().height))
        rectView.backgroundColor = UIColor(red: CGFloat(rectangle.getColor().R)/255.0, green: CGFloat(rectangle.getColor().G)/255.0, blue: CGFloat(rectangle.getColor().B)/255.0, alpha: CGFloat(rectangle.getAlpha().rawValue)/10.0)
        self.viewDictionary[rectangle] = rectView
        self.view.addSubview(rectView)
    }
}

extension ViewController: RectangleTouchedDelegate {
    func touchedRectangle(rectangle: Rectangle) {
        if let view = self.selectedView {
            view.layer.borderWidth = .zero
        }
        let touchedView = self.viewDictionary[rectangle]
        touchedView?.layer.borderWidth = 3.0
        touchedView?.layer.borderColor = UIColor.blue.cgColor
        self.selectedView = touchedView
        
        var rectangle : Rectangle?
        for (key, value) in viewDictionary {
            if touchedView === value {
                rectangle = key
            }
        }
        if let rect = rectangle {
            colorButton.setTitle("#\(rect.getColor().showRGBVlaue())", for: .normal)

        }
    }
}

extension ViewController: PlaneColorChangeDelegate {
    func didChangeColor(rectangle: Rectangle) {
        if let view = viewDictionary[rectangle] {
            view.backgroundColor = UIColor(red: CGFloat(rectangle.getColor().R)/255.0, green: CGFloat(rectangle.getColor().G)/255.0, blue: CGFloat(rectangle.getColor().B)/255.0, alpha: CGFloat(rectangle.getAlpha().rawValue)/10.0)
            self.viewDictionary.updateValue(view, forKey: rectangle)
        }
        colorButton.setTitle("#\(rectangle.getColor().showRGBVlaue())", for: .normal)
    }
}
