import UIKit
import OSLog

class ViewController: UIViewController {
    var plane: Plane = Plane()
    var viewDictionary: [Rectangle : UIView] = [:]
    var selectedView: UIView?
    
    @IBOutlet weak var alphaSlider: UISlider!
    @IBAction func draggedAlphaSlider(_ sender: UISlider) {
        guard let view = selectedView else {
            return
        }
        let value = Int(sender.value)
        for (rect, rectView) in viewDictionary {
            if rectView === view {
                plane.changeAlpha(rect, value)
                return
            }
        }
    }
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
        
        plane.addedRectangleDelegate = self
        plane.touchedRectangleDelegate = self
        plane.colorDelegate = self
        plane.alphaDelegate = self
        BackgroundViewTouched()
        colorButton.setTitle("#FFFFFF", for: .normal)
        alphaSlider.minimumValue = 1
        alphaSlider.maximumValue = 10
        alphaSlider.value = 5
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
            alphaSlider.value = Float(rect.getAlpha().rawValue)
        }
    }
}

extension ViewController: RectangleColorChangeDelegate {
    func changeColorAndAlpha(_ rectangle: Rectangle) {
        if let view = viewDictionary[rectangle] {
            view.backgroundColor = UIColor(red: CGFloat(rectangle.getColor().R)/255.0, green: CGFloat(rectangle.getColor().G)/255.0, blue: CGFloat(rectangle.getColor().B)/255.0, alpha: CGFloat(rectangle.getAlpha().rawValue)/10.0)
            self.viewDictionary.updateValue(view, forKey: rectangle)
        }
    }
    func didChangeColor(rectangle: Rectangle) {
        changeColorAndAlpha(rectangle)
        colorButton.setTitle("#\(rectangle.getColor().showRGBVlaue())", for: .normal)
    }
}
extension ViewController : RectangleAlaphaChangeDelegate {
    func didChangeAlpha(rectangle: Rectangle) {
        changeColorAndAlpha(rectangle)
        alphaSlider.value = Float(rectangle.getAlpha().rawValue)
    }
}
