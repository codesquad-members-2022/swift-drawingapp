import UIKit
import OSLog

class ViewController: UIViewController{
    
    private var logger: Logger = Logger()
    private var canvasView: CanvasView?
    private var stylerView: StylerView?
    private var plane: Plane = Plane()
    private var currentlyTouchedView: RectangleView?
    
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
    
    private func updateViewWithSelectedRectangleModel(rectangle: Rectangle){
        guard let stylerView = self.stylerView else { return }
        let r = rectangle.backgroundColor.r
        let g = rectangle.backgroundColor.g
        let b = rectangle.backgroundColor.b
        let opacity = rectangle.alpha.opacity
        stylerView.updateRectangleInfo(r: r, g: g, b: b, opacity: opacity)
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

extension ViewController: PlaneDelegate{
    
    func addingRectangleCompleted(rectangle: Rectangle) {
        guard let canvasView = self.canvasView else { return }
        let rectangleView = RectangleView(frame: CGRect(x: rectangle.point.x,
                                                 y: rectangle.point.y,
                                                 width: rectangle.size.width,
                                                 height: rectangle.size.height))
        rectangleView.backgroundColor = UIColor(red: rectangle.backgroundColor.r,
                                                green: rectangle.backgroundColor.g,
                                                blue: rectangle.backgroundColor.b,
                                                alpha: CGFloat(rectangle.alpha.opacity))
        canvasView.insertSubview(rectangleView, belowSubview: canvasView.generatingButton)
    }
    
    func rectangleFoundFromPlane(rectangle: Rectangle){
        self.updateViewWithSelectedRectangleModel(rectangle: rectangle)
    }
    
    func rectangleNotFoundFromPlane(){
        guard let stylerView = self.stylerView else { return }
        stylerView.clearSelectedRectangleInfo()
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
    
    func updatingSelectedRectangleViewAlphaCompleted(opacity: Int) {
        var opacity = opacity
        guard let selectedRectangleId = plane.selectedRectangleId else { return }
        guard let rectangle = plane[selectedRectangleId] else { return }
        if(opacity == 10){
            opacity = opacity - 1
        }
        rectangle.alpha = Rectangle.Alpha.allCases[opacity]
    }
    
    func updatingSelectedRectangleViewColorCompleted(rgb: [Double]) {
        guard let selectedRectangleId = plane.selectedRectangleId else { return }
        guard let rectangle = plane[selectedRectangleId] else { return }
        rectangle.backgroundColor = Rectangle.Color(r: rgb[0]*255, g: rgb[1]*255, b: rgb[2]*255)
    }
}

extension ViewController: StylerViewDelegate{
    
    func updatingRectangleInfoCompleted() {
        guard let canvasView = self.canvasView else { return }
        guard let rectangleView = self.currentlyTouchedView else { return }
        canvasView.updateSelectedRectangleView(subView: rectangleView)
    }
    
    func updatingSelectedRecntagleViewColorRequested(){
        guard let stylerView = self.stylerView else { return }
        guard let rgb = generateNewColor() else { return }
        stylerView.updateSelectedRectangleViewColorInfo(rgb: rgb)
    }
    
    private func generateNewColor()-> [Double]?{
        let newColor = UIColor(red: CGFloat.random(in: 0...1),
                               green: CGFloat.random(in: 0...1),
                               blue: CGFloat.random(in: 0...1),
                               alpha: 1)
        var rgb:[Double]?
        if let components = newColor.cgColor.components{
            rgb = components.map{ Double($0) }
        }
        return rgb
    }
    
    func updatingSelectedRectangleViewColorInfoCompleted(rgb: [Double]) {
        guard let canvasView = self.canvasView else { return }
        canvasView.changeSelectedRectangleViewColor(rgb: rgb)
    }
    
    func updatingSelectedRectangleViewAlphaRequested(opacity: Int){
        guard let canvasView = self.canvasView else { return }
        canvasView.updateSelectedRectangleOpacity(opacity: opacity)
    }

    func clearingSelectedRectangleInfoCompleted() {
        guard let canvasView = self.canvasView else { return }
        canvasView.clearRectangleViewSelection()
    }

}
