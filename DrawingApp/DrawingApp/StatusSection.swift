import UIKit

class StatusSection: UIView {
    
    var delegate: StatusSectionDelegate?

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
        colorWell.addTarget(self, action: #selector(colorWellValueChanged), for: .valueChanged)
        return colorWell
    }()

    private let alphaStatus: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.maximumValue = 10
        slider.minimumValue = 0
        slider.isContinuous = true
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        slider.value = 0
        return slider
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
    
    func setAlpha(alpha: Float) {
        self.alphaStatus.value = alpha * 10
    }

    @objc func colorWellValueChanged(_ sender: UIColorWell!) {
        delegate?.colorDidChanged(color: sender.selectedColor)
    }
    
    @objc func sliderValueChanged(_ sender: UISlider!) {
        delegate?.alphaDidChanged(alpha: Float(Int(sender.value)))
    }
}
