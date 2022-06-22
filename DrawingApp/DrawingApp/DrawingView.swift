import UIKit

class DrawingSection: UIView {
    
    var delegate: DrawingSectionDelegate?

    private let addSquareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 20
        button.setImage(UIImage(named: "addSquare.png"), for: .normal)
        button.addTarget(self, action: #selector(buttonTouched), for: .touchDown)
        return button
    }()
    
    @objc func buttonTouched() {
        self.delegate?.squareDidAdded()
    }

    private let drawingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
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
}
