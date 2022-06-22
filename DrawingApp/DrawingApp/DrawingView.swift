import UIKit

class DrawingSection: UIView {
    
    var delegate: DrawingSectionDelegate?

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

    func addSquare(square: UIView) {
        self.drawingView.addSubview(square)
    }
    
    func drawSquare(square: Square) -> UIView {
        let squareView = UIView(frame: CGRect(x: square.point.X, y: square.point.Y, width: square.size.Width, height: square.size.Height))
        squareView.backgroundColor = UIColor(red: CGFloat(square.R)/255, green: CGFloat(square.G)/255, blue: CGFloat(square.B)/255, alpha: CGFloat(square.alpha)/10)
        self.drawingView.addSubview(squareView)
        return squareView
    }

    func clearSquare() {
        self.drawingView.subviews.forEach({ $0.removeFromSuperview() })
    }

    @objc func buttonTouched() {
        self.delegate?.squareDidAdd()
    }
}
