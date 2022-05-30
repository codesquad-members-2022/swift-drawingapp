import UIKit
import OSLog

class ViewController: UIViewController {

    let factory: SquareFactory = SquareFactory()
    
    var plane: Plane = Plane()
    
    var selectedSquare: Square?

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.imageView)
        
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        
        self.view.addGestureRecognizer(recognizer)
        
        for i in 1..<5 {
            self.plane.addSquare(square: factory.createSquare(size: Size(width: Double(i * 50), height: Double(i * 100)), point: Point(X: Double(i * 200), Y: Double(i * 50)), R: UInt8(Int.random(in: 0..<255)), G: UInt8(Int.random(in: 0..<255)), B: UInt8(Int.random(in: 0..<255)), alpha: 10))
        }
        
        for i in 0..<4 {
            os_log("Rect%@ %@", "\(i)", "\(self.plane[i])")
        }
        
        self.drawPlane()
    }

    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        let point = Point(X: sender.location(in: self.view).x, Y: sender.location(in: self.view).y)
        self.selectedSquare = self.plane[point]

        drawPlane()
    }
}

extension ViewController {
    func drawPlane() {
        UIGraphicsBeginImageContext(self.view.frame.size)
        let context = UIGraphicsGetCurrentContext()!
        context.setLineWidth(2.0)
        context.setStrokeColor(UIColor.systemBlue.cgColor)
        
        for s in self.plane.square {
            context.setFillColor(red: CGFloat(s.R)/255.0, green: CGFloat(s.G)/255.0, blue: CGFloat(s.B)/255.0, alpha: CGFloat(s.alpha)/10.0)
            
            let x = s.point.X
            let y = s.point.Y
            let w = s.size.Width
            let h = s.size.Height
            
            context.move(to: CGPoint(x: x, y: y))
            context.addLine(to: CGPoint(x: x + w, y: y))
            context.addLine(to: CGPoint(x: x + w, y: y + h))
            context.addLine(to: CGPoint(x: x, y: y + h))
            context.addLine(to: CGPoint(x: x, y: y))
            context.closePath()
            
            if s == self.selectedSquare {
                context.drawPath(using: .fillStroke)
            } else {
                context.fillPath()
            }
            //context.strokePath()
        }

        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
}
