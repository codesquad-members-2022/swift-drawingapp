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
    
    var plane: Plane = Plane()

    var selectedSquare: String?

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
        let userInfo = notification.userInfo!
        let id = userInfo["id"] as! String
        let frame = userInfo["frame"] as! Frame
        os_log("Frame %@", "\(frame)")
        let squareView = UIView(frame: CGRect(x: frame.point.X, y: frame.point.Y, width: frame.size.Width, height: frame.size.Height))
        squareView.backgroundColor = UIColor(red: CGFloat(frame.R)/255, green: CGFloat(frame.G)/255, blue: CGFloat(frame.B)/255, alpha: CGFloat(frame.alpha)/10)
        self.drawingSection.addSquare(id: id, squareView: squareView)
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let CGPosition = touch.location(in: self.drawingSection)

        if self.selectedSquare != nil {
            self.drawingSection.setSquareBorder(selectedSquare: self.selectedSquare!, state: BorderState.unselected)
        }

        guard let square = self.plane[Point(X: CGPosition.x, Y: CGPosition.y)] else {
            self.selectedSquare = nil
            return false
        }

        self.selectedSquare = square
        self.drawingSection.setSquareBorder(selectedSquare: self.selectedSquare!, state: BorderState.selected)
        self.statusSection.setAlpha(alpha: (self.drawingSection.getSquareColor(id: square)?.cgColor.alpha)! * 10)
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
            self.drawingSection.setSquareColor(id: square, color: color)
            let rgbColor = color!.rgbFloat
            self.plane.setSquareColor(id: square, R: UInt8(rgbColor.red * 255.0), G: UInt8(rgbColor.green * 255.0), B: UInt8(rgbColor.blue * 255.0))
        }
    }

    func alphaDidChanged(alpha: Double) {
        if let square = self.selectedSquare {
            self.drawingSection.setSquareAlpha(id: square, alpha: alpha)
            self.plane.setSquareAlpha(id: square, alpha: alpha)
        }
    }
}
