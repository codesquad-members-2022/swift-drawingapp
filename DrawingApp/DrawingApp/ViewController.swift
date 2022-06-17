import UIKit
import OSLog

class ViewController: UIViewController {

    let factory: SquareFactory = SquareFactory()
    
    var plane: Plane = Plane()
    
    var planeViews: [Square: UIView] = [:]
    
    private var selectedSquare: Square?

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
        self.drawingView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.drawingView)
        self.view.addSubview(self.statusView)
        self.view.addSubview(self.backgroundTitle)
        self.view.addSubview(self.backgroundColorStatus)
        self.view.addSubview(self.alphaTitle)
        self.view.addSubview(self.alphaStatus)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.drawingView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.drawingView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.drawingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.drawingView.trailingAnchor.constraint(equalTo: self.statusView.leadingAnchor),
            
            self.statusView.widthAnchor.constraint(equalToConstant: 300),
            self.statusView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.statusView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        for _ in 0..<4 {
            let square = plane.addSquare(frameWidth: self.view.safeAreaLayoutGuide.layoutFrame.width - self.statusView.frame.width, frameHeight: self.view.safeAreaLayoutGuide.layoutFrame.height)
            let squareView = UIView(frame: CGRect(x: square.point.X, y: square.point.Y, width: square.size.Width, height: square.size.Height))
            squareView.backgroundColor = UIColor(red: CGFloat(square.R)/255, green: CGFloat(square.G)/255, blue: CGFloat(square.B)/255, alpha: CGFloat(square.alpha)/10)
            self.planeViews[square] = squareView
            self.drawingView.addSubview(squareView)
        }
        
        for i in 0..<4 {
            os_log("Rect%@ %@", "\(i)", "\(self.plane[i])")
        }
    }

}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let CGPosition = touch.location(in: self.drawingView)

        if selectedSquare != nil {
            self.planeViews[selectedSquare!]!.layer.borderWidth = CGFloat(0.0)
        }

        guard let square = self.plane[Point(X: CGPosition.x, Y: CGPosition.y)] else {
            self.selectedSquare = nil
            return false
        }
        
        self.selectedSquare = square
        let squareView = self.planeViews[square]!
        
        squareView.layer.borderWidth = CGFloat(5.0)
        squareView.layer.borderColor = CGColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
        self.alphaStatus.value = (squareView.backgroundColor?.cgColor.alpha)! * 10

        return true
    }
    
    @objc func stepperValueChanged(_ sender: UIStepper) {
        if let square = self.selectedSquare {
            let squareView = self.planeViews[square]!
            let color = squareView.backgroundColor!.rgbFloat
            let r = color.red
            let g = color.green
            let b = color.blue
            squareView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: alphaStatus.value / 10.0)
            square.alpha = Int(alphaStatus.value)
        }
    }
    
    @objc func colorChanged(_ sender: UIColorWell) {
        if let square = self.selectedSquare {
            let squareView = planeViews[square]!
            squareView.backgroundColor = self.backgroundColorStatus.selectedColor
            let color = self.backgroundColorStatus.selectedColor!.rgbFloat
            square.R = UInt8(color.red * 255.0)
            square.G = UInt8(color.green * 255.0)
            square.B = UInt8(color.blue * 255.0)
        }
    }
}
