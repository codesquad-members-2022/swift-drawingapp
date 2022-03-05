import UIKit
import OSLog

class ViewController: UIViewController{
    
    private var logger: Logger = Logger()
    private var canvasView: CanvasView?
    private var stylerView: StylerView?
    private var plane: Plane = Plane()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializePlaneDelegate()
        initializeAllUIViews()
        setGestureRecognizer()
    }
    
    private func initializePlaneDelegate(){
        self.plane.delegate = self
    }
    
    private func initializeAllUIViews(){
        setCanvasView()
        setStylerView()
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
}

extension ViewController: UIGestureRecognizerDelegate, PlaneDelegate{
    
    func addingRectangleCompleted(rectangle: Rectangle) {
        if let canvasView = self.canvasView{
            let rectangleView = UIView(frame: CGRect(x: rectangle.point.x,
                                                     y: rectangle.point.y,
                                                     width: rectangle.size.width,
                                                     height: rectangle.size.height))
            rectangleView.backgroundColor = UIColor(red: rectangle.backgroundColor.r,
                                                    green: rectangle.backgroundColor.g,
                                                    blue: rectangle.backgroundColor.b,
                                                    alpha: CGFloat(rectangle.alpha.opacity))
            canvasView.insertSubview(rectangleView, belowSubview: canvasView.generatingButton)
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        let tappedPoint = touch.location(in: self.canvasView)
        guard let stylerView = self.stylerView else { return false }
        guard let canvasView = self.canvasView else { return false }
        guard let rectangle = plane[tappedPoint.x,tappedPoint.y] else {
            stylerView.clearRectangleInfo()
            canvasView.cancelSelection()
            return false
        }
        guard let rectangleView = canvasView[tappedPoint.x,tappedPoint.y] else { return false }

        let r = rectangle.backgroundColor.r
        let g = rectangle.backgroundColor.g
        let b = rectangle.backgroundColor.b
        let opacity = rectangle.alpha.opacity
        stylerView.updateRectangleInfo(r: r, g: g, b: b, opacity: opacity)
        canvasView.selectTappedRectangle(subView: rectangleView)
        plane.selectRectangle(id: rectangle.id)
        
        return true
    }
}

extension ViewController: CanvasViewDelegate, StylerViewDelegate{
    
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
    
    func changeSelectedRecntagleViewColor(rgb: [Double]){
        guard let canvasView = self.canvasView else { return }
        canvasView.changeSelectedRectangleColor(rgb: rgb)
        changeRectangleModelColor(rgb: rgb)
    }
    
    func changeSelectedRectangleViewAlpha(opacity: Int){
        if let canvasView = self.canvasView{
            canvasView.changeSelectedRectangleOpacity(opacity: opacity)
        }
    }
    
    func changeRectangleModelAlpha(opacity: Int) {
        var opacity = opacity
        guard let selectedRectangleId = plane.selectedRectangleId else { return }
        guard let rectangle = plane[selectedRectangleId] else { return }
        if(opacity == 10){
            opacity = opacity - 1
        }
        rectangle.alpha = Rectangle.Alpha.allCases[opacity]
    }
    
    func changeRectangleModelColor(rgb: [Double]) {
        guard let selectedRectangleId = plane.selectedRectangleId else { return }
        guard let rectangle = plane[selectedRectangleId] else { return }
        rectangle.backgroundColor = Rectangle.Color(r: rgb[0]*255, g: rgb[1]*255, b: rgb[2]*255)
    }
    
    func clearModelSelection() {
        plane.clearModelSelection()
    }
}
