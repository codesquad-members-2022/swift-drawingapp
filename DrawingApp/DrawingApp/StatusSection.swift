import UIKit

class StatusSection: UIView {

    private let backgroundColorTitle: UILabel = {
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
        return stepper
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(backgroundColorTitle)
        self.addSubview(backgroundColorStatus)
        self.addSubview(alphaTitle)
        self.addSubview(alphaStatus)
        
        NSLayoutConstraint.activate([
            self.backgroundColorTitle.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundColorTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroundColorTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.backgroundColorStatus.topAnchor.constraint(equalTo: self.backgroundColorTitle.bottomAnchor),
            self.backgroundColorStatus.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroundColorStatus.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.alphaTitle.topAnchor.constraint(equalTo: self.backgroundColorStatus.bottomAnchor),
            self.alphaTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.alphaTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.alphaStatus.topAnchor.constraint(equalTo: self.alphaTitle.bottomAnchor),
            self.alphaStatus.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.alphaStatus.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func getAlpha() -> Double {
        return self.alphaStatus.value
    }

    func setAlpha(alpha: Double) {
        self.alphaStatus.value = alpha
    }

    func getSelectedColor() -> UIColor? {
        return self.backgroundColorStatus.selectedColor
    }

    func addStatusTarget(_ target: Any?, backgroundColorAction: Selector, alphaAction: Selector, for controlEvents: UIControl.Event) {
        self.backgroundColorStatus.addTarget(target, action: backgroundColorAction, for: controlEvents)
        self.alphaStatus.addTarget(target, action: alphaAction, for: controlEvents)
    }
}
