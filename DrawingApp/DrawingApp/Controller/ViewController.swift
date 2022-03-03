import UIKit
import OSLog

class ViewController: UIViewController {
    
    private var logger: Logger = Logger()
    private var canvasView: CanvasView?
    private var stylerView: StylerView?
    private var rectangleFactory: RectangleFactory = RectangleFactory()
    private var plane: Plane = Plane()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeAllUIViews()
    }
    
    private func initializeAllUIViews(){
        setCanvasView()
        setStylerView()
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
        logger.debug("\(self.plane)")
    }

}

