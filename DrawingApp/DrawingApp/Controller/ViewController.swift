import UIKit
import OSLog

class ViewController: UIViewController {
    
    private var logger: Logger = Logger()
    private var canvasView: CanvasView?
    private var stylerView: StylerView?
    private var rectangleFactory: RectangleFactory = RectangleFactory()
    private var plane: Plane = Plane()
    var gestureRecognizer = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeAllUIViews()
        setGestureRecognizer()
    }
    
    private func initializeAllUIViews(){
        setCanvasView()
        setStylerView()
    }
    
    private func setGestureRecognizer(){
        guard let canvasView = self.canvasView else { return }
        self.gestureRecognizer.delegate = self
        canvasView.addGestureRecognizer(self.gestureRecognizer)
    }
    
    private func setCanvasView(){
        let frame = CGRect(x: self.view.frame.minX,
                           y: self.view.frame.minY,
                           width: self.view.frame.width*0.8,
                           height: self.view.frame.height)
        let canvasView = CanvasView(frame: frame,
                                    backGroundColor: .lightGray,
                                    buttonActionClosure: self.drawRectangle)
        self.canvasView = canvasView
        self.view.addSubview(canvasView)
    }
    
    private func setStylerView(){
        guard let canvasView = self.canvasView else { return }
        let frame = CGRect(x: canvasView.frame.width,
                           y: self.view.frame.minY,
                           width: self.view.frame.width - canvasView.frame.width,
                           height: self.view.frame.height)
        let stylerView = StylerView(frame: frame,
                                    backgroundColor: .white)
        self.stylerView = stylerView
        self.view.addSubview(stylerView)
    }
    
    func drawRectangle(){
        guard let canvasView = self.canvasView else { return }
        let rectangle = rectangleFactory.createRenctangle(maxX: canvasView.bounds.maxX - 50,
                                                          maxY: canvasView.bounds.maxY - 250,
                                                          minWidth: 150,
                                                          minHeight: 150,
                                                          maxWidth: 180,
                                                          maxHeight: 180)
        let rectangleView = UIView(frame: CGRect(x: rectangle.point.x,
                                                 y: rectangle.point.y,
                                                 width: rectangle.size.width,
                                                 height: rectangle.size.height))
        rectangleView.backgroundColor = UIColor(red: rectangle.backgroundColor.r,
                                                green: rectangle.backgroundColor.g,
                                                blue: rectangle.backgroundColor.b,
                                                alpha: CGFloat(rectangle.alpha.opacity))
        
        plane.addRectangle(rectangle)
        canvasView.insertSubview(rectangleView, belowSubview: canvasView.generatingButton)
    }

}

extension ViewController: UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        let tappedPoint = touch.location(in: self.canvasView)
        guard let rectangle = self.plane[tappedPoint.x,tappedPoint.y] else { return true }
        guard let stylerView = self.stylerView else { return true }
        
        let r = rectangle.backgroundColor.r
        let g = rectangle.backgroundColor.g
        let b = rectangle.backgroundColor.b
        let opacity = rectangle.alpha.opacity
        stylerView.updateRectangleInfo(r: r, g: g, b: b, opacity: opacity)
        
        return true
    }
}

