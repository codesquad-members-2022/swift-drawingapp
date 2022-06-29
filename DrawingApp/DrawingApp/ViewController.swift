import UIKit
import OSLog

protocol DrawingSectionDelegate {
    func squareDidAdd()
}

protocol StatusSectionDelegate {
    func colorDidChanged(color: UIColor?)
    func alphaDidChanged(alpha: Double)
}

class ViewController: UIViewController {

    let factory: SquareFactory = SquareFactory()
    
    var plane: Plane = Plane()
    
    var planeViews: [Square: UIView] = [:]
    
    private var selectedSquare: Square?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
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
        return section
    }()
    
    override func loadView() {
        self.view = MainView()
        
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.delegate = self
        self.drawingSection.addGestureRecognizer(tapGestureRecognizer)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.drawingSection)
        self.view.addSubview(self.statusSection)
        
        self.drawingSection.delegate = self
        self.statusSection.delegate = self
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(squareDidDraw(_:)),
            name: Notification.Name("UpdatePlane"),
            object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("UpdatePlane"), object: nil)
    }

    @objc func squareDidDraw(_ notification: Notification) {
        let square = notification.object as! Square
        os_log("Rect %@", "\(square)")
        self.planeViews[square] = self.drawingSection.drawSquare(square: square)
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
}

extension ViewController: DrawingSectionDelegate {
    func squareDidAdd() {
        plane.addSquare(frameWidth: self.view.safeAreaLayoutGuide.layoutFrame.width - self.statusSection.frame.width, frameHeight: self.view.safeAreaLayoutGuide.layoutFrame.height)
    }
}

extension ViewController: StatusSectionDelegate {
    func colorDidChanged(color: UIColor?) {
        if let square = self.selectedSquare {
            let squareView = planeViews[square]!
            squareView.backgroundColor = color?.withAlphaComponent(squareView.backgroundColor?.alphaFloat ?? 1.0)
            let rgbColor = color!.rgbFloat
            square.R = UInt8(rgbColor.red * 255.0)
            square.G = UInt8(rgbColor.green * 255.0)
            square.B = UInt8(rgbColor.blue * 255.0)
        }
    }

    func alphaDidChanged(alpha: Double) {
        if let square = self.selectedSquare {
            let squareView = self.planeViews[square]!
            let color = squareView.backgroundColor!.rgbFloat
            let r = color.red
            let g = color.green
            let b = color.blue
            squareView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: alpha / 10.0)
            square.alpha = Int(alpha)
        }
    }
}
