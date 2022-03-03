import UIKit
import OSLog

class ViewController: UIViewController {
    
    private var logger: Logger = Logger()
    private var canvasView: CanvasView?
    private var stylerView: StylerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeAllUIViews()
    }
    
    private func initializeAllUIViews(){
        setCanvasView()
        setStylerView()
    }
    
    private func setCanvasView(){
        let frame = CGRect(x: self.view.frame.minX, y: self.view.frame.minY, width: self.view.frame.width*0.8, height: self.view.frame.height)
        let canvasView = CanvasView(frame: frame, backGroundColor: .lightGray, buttonActionClosure: {
            print("closure")
        })
        self.canvasView = canvasView
        self.view.addSubview(canvasView)
    }
    
    private func setStylerView(){
        guard let canvasView = self.canvasView else { return }
        let frame = CGRect(x: canvasView.frame.width, y: self.view.frame.minY, width: self.view.frame.width - canvasView.frame.width, height: self.view.frame.height)
        let stylerView = StylerView(frame: frame, backgroundColor: .white)
        self.stylerView = stylerView
        self.view.addSubview(stylerView)
    }

}

