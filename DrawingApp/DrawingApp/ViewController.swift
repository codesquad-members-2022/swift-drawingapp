import UIKit
import OSLog

class ViewController: UIViewController {

    let factory: SquareFactory = SquareFactory()
    
    var plane: Plane = Plane()
    
    var planeViews: [UIView: Square] = [:]
    
    private var selectedSquareView: UIView?

    private let drawingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    private let statusView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        return view
    }()
    
    private let backgroundTitle: UILabel = {
        let label = UILabel()
        label.text = "배경색"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let alphaTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "투명도"
        return label
    }()
    
    private let backgroundColorStatus: UIColorWell = {
        let colorWell = UIColorWell()
        colorWell.translatesAutoresizingMaskIntoConstraints = false
        colorWell.supportsAlpha = false
        colorWell.addTarget(self, action: #selector(colorChanged(_:)), for: .valueChanged)
        
        return colorWell
    }()

    private let alphaStatus: UIStepper = {
        let stepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.maximumValue = 10
        stepper.minimumValue = 0
        stepper.value = 0
        stepper.wraps = false
        stepper.autorepeat = true
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        
        return stepper
    }()
    
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
        self.view.addSubview(self.backgroundTitle)
        self.view.addSubview(self.backgroundColorStatus)
        self.view.addSubview(self.alphaTitle)
        self.view.addSubview(self.alphaStatus)
        
        NSLayoutConstraint.activate([
            self.drawingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.drawingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.drawingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.drawingView.trailingAnchor.constraint(equalTo: self.statusView.leadingAnchor),
            
            self.statusView.widthAnchor.constraint(equalToConstant: 300),
            self.statusView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.statusView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.statusView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            self.backgroundTitle.topAnchor.constraint(equalTo: self.statusView.topAnchor),
            self.backgroundTitle.leadingAnchor.constraint(equalTo: self.statusView.leadingAnchor),
            self.backgroundTitle.trailingAnchor.constraint(equalTo: self.statusView.trailingAnchor),
            
            self.backgroundColorStatus.topAnchor.constraint(equalTo: self.backgroundTitle.bottomAnchor),
            self.backgroundColorStatus.leadingAnchor.constraint(equalTo: self.statusView.leadingAnchor),
            self.backgroundColorStatus.trailingAnchor.constraint(equalTo: self.statusView.trailingAnchor),
            
            self.alphaTitle.topAnchor.constraint(equalTo: self.backgroundColorStatus.bottomAnchor),
            self.alphaTitle.leadingAnchor.constraint(equalTo: self.statusView.leadingAnchor),
            self.alphaTitle.trailingAnchor.constraint(equalTo: self.statusView.trailingAnchor),
            
            self.alphaStatus.topAnchor.constraint(equalTo: self.alphaTitle.bottomAnchor),
            self.alphaStatus.leadingAnchor.constraint(equalTo: self.statusView.leadingAnchor),
            self.alphaStatus.trailingAnchor.constraint(equalTo: self.statusView.trailingAnchor)
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
            squareView.backgroundColor = UIColor(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 10/10)
            self.planeViews[squareView] = square
            self.drawingView.addSubview(squareView)
            self.plane.addSquare(square: square)
        }
        
        for i in 0..<4 {
            os_log("Rect%@ %@", "\(i)", "\(self.plane[i])")
        }
    }

}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let hitView = self.view.hitTest(touch.location(in: self.drawingView), with: nil)
        
        if hitView == self.drawingView {
            self.selectedSquareView?.layer.borderWidth = CGFloat(0.0)
            self.selectedSquareView = nil
            return true
        }
        
        for (key, _) in self.planeViews {
            if key === hitView {
                self.selectedSquareView?.layer.borderWidth = CGFloat(0.0)
                self.selectedSquareView = hitView
                self.selectedSquareView?.layer.borderWidth = CGFloat(5.0)
                self.selectedSquareView?.layer.borderColor = CGColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
                self.alphaStatus.value = (self.selectedSquareView!.backgroundColor?.cgColor.alpha)! * 10
                
                break
            }
        }

        return true
    }
    
    @objc func stepperValueChanged(_ sender: UIStepper) {
        if self.selectedSquareView != nil {
            let color = self.selectedSquareView!.backgroundColor!.rgbFloat
            let r = color.red
            let g = color.green
            let b = color.blue
            self.selectedSquareView?.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: alphaStatus.value / 10.0)
            self.planeViews[selectedSquareView!]!.alpha = Int(alphaStatus.value)
        }
    }
    
    @objc func colorChanged(_ sender: UIColorWell) {
        if self.selectedSquareView != nil {
            self.selectedSquareView?.backgroundColor = self.backgroundColorStatus.selectedColor
            let color = self.backgroundColorStatus.selectedColor!.rgbFloat
            self.planeViews[selectedSquareView!]!.R = UInt8(color.red * 255.0)
            self.planeViews[selectedSquareView!]!.G = UInt8(color.green * 255.0)
            self.planeViews[selectedSquareView!]!.B = UInt8(color.blue * 255.0)
        }
    }
}
