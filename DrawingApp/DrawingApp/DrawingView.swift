import UIKit

class DrawingView: UIView {

    private let board: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .blue
        
        self.addSubview(board)
        
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        NSLayoutConstraint.activate([
            self.board.topAnchor.constraint(equalTo: self.topAnchor),
            self.board.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.board.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.board.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func addSquareView(squareView: UIView) {
        self.board.addSubview(squareView)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)

        if hitView == board {
            return nil
        }
        
        return hitView
    }
}
