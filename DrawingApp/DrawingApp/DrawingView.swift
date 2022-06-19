import UIKit

class DrawingSection: UIView {

    private let drawingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(drawingView)
        
        NSLayoutConstraint.activate([
            self.drawingView.topAnchor.constraint(equalTo: self.topAnchor),
            self.drawingView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.drawingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            self.drawingView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func addSquare(square: UIView) {
        self.drawingView.addSubview(square)
    }
}
