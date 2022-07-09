import UIKit

class DrawingSection: UIView {
    
    var delegate: DrawingSectionDelegate?

    var selectedSquare: String?
    
    var square: [String: UIView] = [:]

    private let drawingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    private let addSquareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 20
        button.setImage(UIImage(named: "addSquare.png"), for: .normal)
        button.addTarget(self, action: #selector(buttonTouched), for: .touchDown)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    func setUpView() {
        self.addSubview(drawingView)
        self.addSubview(addSquareButton)
        
        NSLayoutConstraint.activate([
            self.drawingView.topAnchor.constraint(equalTo: self.topAnchor),
            self.drawingView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.drawingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            self.drawingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            self.addSquareButton.widthAnchor.constraint(equalToConstant: 100),
            self.addSquareButton.heightAnchor.constraint(equalToConstant: 100),
            self.addSquareButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.addSquareButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }

    func addSquare(id: String, squareView: UIView) {
        self.square[id] = squareView
        self.drawingView.addSubview(squareView)
    }
    
    func setSquareBorder(state: BorderState) {
        switch state {
        case .selected:
            self.square[selectedSquare!]!.layer.borderWidth = CGFloat(5.0)
            self.square[selectedSquare!]!.layer.borderColor = CGColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
        case .unselected:
            self.square[selectedSquare!]!.layer.borderWidth = CGFloat(0.0)
        }
    }

    func setSquareColor(id: String, color: UIColor?) {
        square[id]?.backgroundColor = color?.withAlphaComponent(square[id]?.backgroundColor?.alphaFloat ?? 1.0)
    }

    func setSquareAlpha(id: String, alpha: Double) {
        let color = self.square[id]!.backgroundColor!.rgbFloat
        let r = color.red
        let g = color.green
        let b = color.blue
        self.square[id]!.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: alpha / 10.0)
    }

    func getSquareColor(id: String) -> UIColor? {
        return self.square[id]?.backgroundColor
    }

    @objc func buttonTouched() {
        self.delegate?.squareDidAdd()
    }
}
