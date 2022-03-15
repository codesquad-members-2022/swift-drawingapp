import UIKit
import OSLog

class ViewController: UIViewController {
    var plane: Plane = Plane()
    var views: [Rectangle : UIView] = [:]
    var selectedView: UIView?
    
    @IBOutlet weak var alphaSlider: UISlider!
    
    @IBAction func draggedAlphaSlider(_ sender: UISlider) {
        guard let view = selectedView else {
            return
        }
        let value = Int(sender.value)
        for (rect, rectView) in views {
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
        for (key, value) in views {
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
    
    private func declareDelegates() {
        plane.addedRectangleDelegate = self
        plane.rectangleTapDelegate = self
        plane.colorDelegate = self
        plane.alphaDelegate = self
    }
    
    private func initDetailView() {
        self.colorButton.layer.borderWidth = 1.0
        self.colorButton.layer.borderColor = UIColor.darkGray.cgColor
        colorButton.setTitle("#FFFFFF", for: .normal)
        alphaSlider.minimumValue = 1
        alphaSlider.maximumValue = 10
        alphaSlider.value = 5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        declareDelegates()
        initDetailView()
        BackgroundViewTouched()
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
    func made(rectangle: Rectangle) {
        let rectView = UIView(frame: CGRect(x: rectangle.point.x, y: rectangle.point.y, width: rectangle.size.width, height: rectangle.size.height))
        rectView.backgroundColor = UIColor(red: CGFloat(rectangle.color.R)/255.0, green: CGFloat(rectangle.color.G)/255.0, blue: CGFloat(rectangle.color.B)/255.0, alpha: CGFloat(rectangle.alpha.rawValue)/10.0)
        self.views[rectangle] = rectView
        self.view.addSubview(rectView)
    }
}

extension ViewController: RectangleTouchedDelegate {
    private func paintBorder(_ rectangle: Rectangle) {
        let touchedView = self.views[rectangle]
        touchedView?.layer.borderWidth = 3.0
        touchedView?.layer.borderColor = UIColor.blue.cgColor
        self.selectedView = touchedView
    }
    
    private func showDetailOfColorAndAlpha() {
        var rectangle : Rectangle?
        for (key, value) in views {
            if self.selectedView === value {
                rectangle = key
                break
            }
        }
        if let rect = rectangle {
            colorButton.setTitle("#\(rect.color.showRGBVlaue())", for: .normal)
            alphaSlider.value = Float(rect.alpha.rawValue)
        }
    }
    func touched(rectangle: Rectangle) {
        if let view = self.selectedView {
            view.layer.borderWidth = .zero
        }
        paintBorder(rectangle)
        showDetailOfColorAndAlpha()
    }
}

extension ViewController: RectangleColorChangeDelegate {
    func changeColorAndAlpha(_ rectangle: Rectangle) {
        let viewValue = views[rectangle]
        views.removeValue(forKey: rectangle)
        views[rectangle] = viewValue
        if let view = views[rectangle] {
            view.backgroundColor = UIColor(red: CGFloat(rectangle.color.R)/255.0, green: CGFloat(rectangle.color.G)/255.0, blue: CGFloat(rectangle.color.B)/255.0, alpha: CGFloat(rectangle.alpha.rawValue)/10.0)
            self.views.updateValue(view, forKey: rectangle)
        }
    }
    
    func didChangeColor(rectangle: Rectangle) {
        changeColorAndAlpha(rectangle)
        colorButton.setTitle("#\(rectangle.color.showRGBVlaue())", for: .normal)
    }
}

extension ViewController : RectangleAlaphaChangeDelegate {
    func didChangeAlpha(rectangle: Rectangle) {
        changeColorAndAlpha(rectangle)
        alphaSlider.value = Float(rectangle.alpha.rawValue)
    }
}
