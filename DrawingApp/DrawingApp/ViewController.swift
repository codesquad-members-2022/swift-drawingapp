import UIKit
import OSLog

class ViewController: UIViewController {

    let factory: SquareFactory = SquareFactory()
    
    var plane: Plane = Plane()
    
    var planeViews: [Square: UIView] = [:]
    
    private var selectedSquare: Square?
    
    private let drawingSection: DrawingSection = {
        let section = DrawingSection()
        section.translatesAutoresizingMaskIntoConstraints = false
        section.backgroundColor = .white
        return section
    }()
    
    private let statusSection: StatusSection = {
        let section = StatusSection()
        section.translatesAutoresizingMaskIntoConstraints = false
        section.backgroundColor = .systemGray4
        section.addStatusTarget(self, backgroundColorAction: #selector(colorChanged(_:)), alphaAction: #selector(stepperValueChanged(_:)), for: .valueChanged)
        return section
    }()
    
    override func loadView() {
        self.view = MainView()
        
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.delegate = self
        self.drawingSection.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.drawingSection)
        self.view.addSubview(self.statusSection)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.drawingSection.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.drawingSection.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.drawingSection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.drawingSection.trailingAnchor.constraint(equalTo: self.statusSection.leadingAnchor),
            
            self.statusSection.widthAnchor.constraint(equalToConstant: 300),
            self.statusSection.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.statusSection.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.statusSection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        for _ in 0..<4 {
            let square = plane.addSquare(frameWidth: self.view.safeAreaLayoutGuide.layoutFrame.width - self.statusSection.frame.width, frameHeight: self.view.safeAreaLayoutGuide.layoutFrame.height)
            let squareView = UIView(frame: CGRect(x: square.point.X, y: square.point.Y, width: square.size.Width, height: square.size.Height))
            squareView.backgroundColor = UIColor(red: CGFloat(square.R)/255, green: CGFloat(square.G)/255, blue: CGFloat(square.B)/255, alpha: CGFloat(square.alpha)/10)
            self.planeViews[square] = squareView
            self.drawingSection.addSquare(square: squareView)
        }
        
        for i in 0..<4 {
            os_log("Rect%@ %@", "\(i)", "\(self.plane[i])")
        }
    }

}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let CGPosition = touch.location(in: self.drawingSection)

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
        self.statusSection.setAlpha(alpha: (squareView.backgroundColor?.cgColor.alpha)! * 10)

        return true
    }
    
    @objc func stepperValueChanged(_ sender: UIStepper) {
        if let square = self.selectedSquare {
            let squareView = self.planeViews[square]!
            let color = squareView.backgroundColor!.rgbFloat
            let r = color.red
            let g = color.green
            let b = color.blue
            squareView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: statusSection.getAlpha() / 10.0)
            square.alpha = Int(statusSection.getAlpha())
        }
    }
    
    @objc func colorChanged(_ sender: UIColorWell) {
        if let square = self.selectedSquare {
            let squareView = planeViews[square]!
            squareView.backgroundColor = self.statusSection.getSelectedColor()
            let color = self.statusSection.getSelectedColor()!.rgbFloat
            square.R = UInt8(color.red * 255.0)
            square.G = UInt8(color.green * 255.0)
            square.B = UInt8(color.blue * 255.0)
        }
    }
}
