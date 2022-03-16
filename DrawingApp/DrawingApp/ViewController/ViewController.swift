import UIKit
import OSLog

class ViewController: UIViewController {
    private var plane: Plane = Plane()
    private var rectangleAndViewContainer: [Rectangle : UIView] = [:]
    private var selectedView: UIView?
    
    @IBOutlet weak var alphaSlider: UISlider!
    @IBOutlet weak var colorButton: UIButton!

    @IBAction func draggedAlphaSlider(_ sender: UISlider) {
        guard let view = selectedView else {
            return
        }
        let value = Int(sender.value)
        for (rect, rectView) in rectangleAndViewContainer {
            if rectView === view {
                plane.changeAlpha(rect, value)
                return
            }
        }
    }
    
    @IBAction func colorButtonTouched(_ sender: UIButton) {
        guard let thisRectView = self.selectedView else {
            return
        }
        var willBeChangedRectangle: Rectangle
        for (key, value) in rectangleAndViewContainer {
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
    
    private func activateNotificationObservers() {
        // add rectangle
        notificationCenter.addObserver(self, selector: #selector(made(rectangleNoti: )), name: Notification.Name.addRectangleView, object: nil)
        
        // rectangle tapped
        notificationCenter.addObserver(self, selector: #selector(touched(rectangleNoti:)), name: Notification.Name.tappedRectangleView, object: nil)
        
        // color changed
        notificationCenter.addObserver(self, selector: #selector(didChangeColor(rectangleNoti:)), name: Notification.Name.colorChange, object: nil)
        
        // alpha changed
        notificationCenter.addObserver(self, selector: #selector(didChangeAlpha(rectangleNoti: )), name: Notification.Name.alphaChange, object: nil)
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

        activateNotificationObservers()
        initDetailView()
        activateBackgroundTappable()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        notificationCenter.removeObserver(self)
    }
}

extension ViewController: UIGestureRecognizerDelegate {
        func activateBackgroundTappable() {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            self.view.addGestureRecognizer(tap)
        }
        
        @objc func handleTap(_ sender: UITapGestureRecognizer) {
            let viewPoint: CGPoint = sender.location(in: self.view)
            let rectPoint: Point = Point(x: viewPoint.x, y: viewPoint.y)
            plane.touchedRectangle(at: rectPoint)
        }
}

extension ViewController {
    @objc func made(rectangleNoti : Notification) {
        guard let rectangle = rectangleNoti.userInfo?[NotificationKey.addedRectangle] as? Rectangle else {
            return
        }
        let rectView = UIView(frame: CGRect(x: rectangle.point.x, y: rectangle.point.y, width: rectangle.size.width, height: rectangle.size.height))
        rectView.backgroundColor = UIColor(red: CGFloat(rectangle.color.R)/255.0, green: CGFloat(rectangle.color.G)/255.0, blue: CGFloat(rectangle.color.B)/255.0, alpha: CGFloat(rectangle.alpha.rawValue)/10.0)
        self.rectangleAndViewContainer[rectangle] = rectView
        self.view.addSubview(rectView)
    }
}
//
extension ViewController {
    private func paintBorder(_ rectangle: Rectangle) {
        let touchedView = self.rectangleAndViewContainer[rectangle]
        touchedView?.layer.borderWidth = 3.0
        touchedView?.layer.borderColor = UIColor.blue.cgColor
        self.selectedView = touchedView
    }
    
    private func showDetailOfColorAndAlpha() {
        var rectangle : Rectangle?
        for (key, value) in rectangleAndViewContainer {
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
    
    @objc func touched(rectangleNoti: Notification) {
        guard let rectangle = rectangleNoti.userInfo?[NotificationKey.tappedRectangle] as? Rectangle else {
            return
        }
        if let view = self.selectedView {
            view.layer.borderWidth = .zero
        }
        paintBorder(rectangle)
        showDetailOfColorAndAlpha()
    }
}

extension ViewController {
    func changeColorAndAlpha(_ rectangle: Rectangle) {
        let viewValue = rectangleAndViewContainer.removeValue(forKey: rectangle)
        rectangleAndViewContainer[rectangle] = viewValue
        if let view = rectangleAndViewContainer[rectangle] {
            view.backgroundColor = UIColor(red: CGFloat(rectangle.color.R)/255.0, green: CGFloat(rectangle.color.G)/255.0, blue: CGFloat(rectangle.color.B)/255.0, alpha: CGFloat(rectangle.alpha.rawValue)/10.0)
            self.rectangleAndViewContainer.updateValue(view, forKey: rectangle)
        }
    }
    
    @objc func didChangeColor(rectangleNoti: Notification) {
        guard let rectangle = rectangleNoti.userInfo?[NotificationKey.color] as? Rectangle else {
            return
        }
        changeColorAndAlpha(rectangle)
        colorButton.setTitle("#\(rectangle.color.showRGBVlaue())", for: .normal)
    }
}

extension ViewController  {
    @objc func didChangeAlpha(rectangleNoti: Notification) {
        guard let rectangle = rectangleNoti.userInfo?[NotificationKey.alpha] as? Rectangle else {
            return
        }
        changeColorAndAlpha(rectangle)
        alphaSlider.value = Float(rectangle.alpha.rawValue)
    }
}
