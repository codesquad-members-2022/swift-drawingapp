import UIKit
import OSLog

class ViewController: UIViewController {

    let factory: SquareFactory = SquareFactory()
    
    var plane: Plane = Plane()
    
    var planeViews: [Square: UIView] = [:]
    
    private var selectedSquare: UIView?

    private let drawingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    private let statusView = StatusView()
    
    override func loadView() {
        self.view = MainView()
        
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.drawingView)
        self.view.addSubview(self.statusView)
        
        NSLayoutConstraint.activate([
            self.drawingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.drawingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.drawingView.trailingAnchor.constraint(equalTo: self.statusView.leadingAnchor),
            self.drawingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.statusView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.statusView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.statusView.widthAnchor.constraint(equalToConstant: 300),
            self.statusView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        for _ in 0..<4 {
            let frameWidth = self.view.frame.width - 300
            let frameHeight = self.view.frame.height
            var width, height, x, y: Double
            var r, g, b: Int

            repeat {
                width = Double(Int.random(in: 1..<Int(frameWidth)))
                height = Double(Int.random(in: 1..<Int(frameHeight)))
                x = Double(Int.random(in: 0..<Int(frameWidth)))
                y = Double(Int.random(in: 0..<Int(frameHeight)))
            } while !((x + width < Double(frameWidth)) && (y + height < Double(frameHeight)))
            
            r = Int.random(in: 0..<255)
            g = Int.random(in: 0..<255)
            b = Int.random(in: 0..<255)
            let square = factory.createSquare(size: Size(width: width, height: height), point: Point(X: x, Y: y), R: UInt8(r), G: UInt8(g), B: UInt8(b), alpha: 10)
            let squareView = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
            squareView.backgroundColor = UIColor(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 10)
            self.planeViews[square] = squareView
            self.drawingView.addSubview(squareView)
            self.plane.addSquare(square: square)
        }
        
        for i in 0..<4 {
            os_log("Rect%@ %@", "\(i)", "\(self.plane[i])")
        }
    }
}

extension ViewController: UIGestureRecognizerDelegate, UITextFieldDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let hitView = self.view.hitTest(touch.location(in: self.view), with: nil)
        
        self.selectedSquare?.layer.borderWidth = CGFloat(0.0)
        self.selectedSquare = (hitView == self.view) ? nil : hitView
        
        self.selectedSquare?.layer.borderWidth = CGFloat(5.0)
        self.selectedSquare?.layer.borderColor = CGColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1)

        return true
    }

}
