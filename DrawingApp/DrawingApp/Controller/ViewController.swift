import UIKit
import OSLog

class ViewController: UIViewController{
    
    private var logger: Logger = Logger()
    private var canvasView: CanvasView?
    private var stylerView: StylerView?
    private var plane: Plane = Plane()
    private var currentlyTouchedView: RectangleView?
    private var notificationCenter = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeAllUIViews()
        initializeNotificationCenter()
        setGestureRecognizer()
    }

    private func initializeAllUIViews(){
        setCanvasView()
        setStylerView()
    }

    
    private func initializeNotificationCenter(){
        self.notificationCenter.addObserver(self, selector: #selector(rectangleFoundFromPlane(_:)), name: .rectangleFoundFromPlane, object: nil)
        self.notificationCenter.addObserver(self, selector: #selector(rectangleNotFoundFromPlane), name: .rectangleNotFoundFromPlane, object: nil)
        self.notificationCenter.addObserver(self, selector: #selector(addingRectangleCompleted(_:)), name: .rectangleAdded, object: nil)
        self.notificationCenter.addObserver(self, selector: #selector(updateSelectedRecntalgeViewColor(_:)), name: .rectangleColorUpdated , object: nil)
        self.notificationCenter.addObserver(self, selector: #selector(updateSelectedRectangleViewAlpha(_:)), name: .rectangleAlphaUpdated, object: nil)
    }
    
    private func setGestureRecognizer(){
        guard let canvasView = self.canvasView else { return }
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.delegate = self
        canvasView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    private func setCanvasView(){
        let frame = CGRect(x: self.view.frame.minX,
                           y: self.view.frame.minY,
                           width: self.view.frame.width*0.8,
                           height: self.view.frame.height)
        let canvasView = CanvasView(frame: frame,
                                    backGroundColor: .lightGray)
        canvasView.delegate = self
        self.canvasView = canvasView
        self.view.addSubview(canvasView)
    }
    
    private func setStylerView(){
        guard let canvasView = self.canvasView else { return }
        let frame = CGRect(x: canvasView.frame.width,
                           y: self.view.frame.minY,
                           width: self.view.frame.width - canvasView.frame.width,
                           height: self.view.frame.height)
        let stylerView = StylerView(frame: frame, backgroundColor: .white)
        stylerView.delegate = self
        self.stylerView = stylerView
        self.view.addSubview(stylerView)
    }
    
    @objc func addingRectangleCompleted(_ notification: Notification) {
        guard let rectangle = notification.object as? Rectangle else { return }
        guard let canvasView = self.canvasView else { return }
        let rectangleView = RectangleViewFactory.createRectangleView(rectangle: rectangle)
        canvasView.insertSubview(rectangleView, belowSubview: canvasView.generatingButton)
    }
    
    @objc func rectangleFoundFromPlane(_ notification: Notification){
        guard let rectangle = notification.object as? Rectangle else { return }
        self.updateViewWithSelectedRectangleModel(rectangle: rectangle)
    }
    
    private func updateViewWithSelectedRectangleModel(rectangle: Rectangle){
        guard let stylerView = self.stylerView else { return }
        guard let canvasView = self.canvasView else { return }
        guard let rectangleView = self.currentlyTouchedView else { return }

        let r = rectangle.backgroundColor.r
        let g = rectangle.backgroundColor.g
        let b = rectangle.backgroundColor.b
        let opacity = rectangle.alpha.opacity
        let hexString = "#\(String(Int(r*255), radix: 16))\(String(Int(g*255), radix: 16))\(String(Int(b*255), radix: 16))"
        stylerView.updateRectangleInfo(r: r, g: g, b: b, opacity: opacity, hexString: hexString)
        canvasView.updateSelectedRectangleView(subView: rectangleView)
        
    }
    
    @objc func rectangleNotFoundFromPlane(){
        guard let stylerView = self.stylerView else { return }
        guard let canvasView = self.canvasView else { return }
        stylerView.clearSelectedRectangleInfo()
        canvasView.clearRectangleViewSelection()
    }
    
    @objc func updateSelectedRecntalgeViewColor(_ notification: Notification){
        guard let rgb = notification.object as? [Double] else { return }
        guard let stylerView = self.stylerView else { return }
        guard let canvasView = self.canvasView else { return }
        
        let newColor = UIColor(red: rgb[0], green: rgb[1], blue: rgb[2], alpha: 1)
        let newHexString = "#\(String(Int(rgb[0]*255), radix: 16))\(String(Int(rgb[1]*255), radix: 16))\(String(Int(rgb[2]*255), radix: 16))"
        stylerView.updateSelectedRectangleViewColorInfo(newColor: newColor, newHexString: newHexString)
        canvasView.updateSelectedRectangleViewColor(newColor: newColor)
    }
    
    @objc func updateSelectedRectangleViewAlpha(_ notification: Notification){
        guard let opacity = notification.object as? Int else { return }
        guard let canvasView = self.canvasView else { return }
        
        canvasView.updateSelectedRectangleOpacity(opacity: opacity)
    }

}

extension ViewController: UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let touchedView = touch.view as? RectangleView{
            self.currentlyTouchedView = touchedView
        }
        let touchedPoint = touch.location(in: self.canvasView)
        self.plane.findMatchingRectangleModel(x: touchedPoint.x, y: touchedPoint.y)
        return true
    }
}

extension ViewController: CanvasViewDelegate{
    
    func creatingRectangleRequested(){
        guard let canvasView = self.canvasView else { return }
        let rectangle = RectangleFactory.createRenctangle(maxX: canvasView.bounds.maxX - 50,
                                                          maxY: canvasView.bounds.maxY - 250,
                                                          minWidth: 150,
                                                          minHeight: 150,
                                                          maxWidth: 180,
                                                          maxHeight: 180)
        plane.addRectangle(rectangle)
    }

}

extension ViewController: StylerViewDelegate{
    
    func updatingSelectedRectangleColorRequested(){
        let newColor = generateNewColor()
        guard let components = newColor.cgColor.components else { return }
        let rgb = components.map{Double($0)}
        self.plane.updateRectangleColor(rgb: rgb)
    }
    
    private func generateNewColor()-> UIColor{
        return UIColor(red: CGFloat.random(in: 0...1),
                       green: CGFloat.random(in: 0...1),
                       blue: CGFloat.random(in: 0...1),
                       alpha: 1)
    }
    
    func updatingSelectedRectangleAlphaRequested(opacity: Int){
        self.plane.updateRectangleAlpha(opacity: opacity)
    }

}

extension Notification.Name{

    static let rectangleAdded = Notification.Name("rectangleAdded")
    static let rectangleFoundFromPlane = Notification.Name("rectangleFoundFromPlane")
    static let rectangleNotFoundFromPlane = Notification.Name("rectangleNotFoundFromPlane")
    static let rectangleColorUpdated = Notification.Name("rectangleColorUpdated")
    static let rectangleAlphaUpdated = Notification.Name("rectangleAlphaUpdated")
}
