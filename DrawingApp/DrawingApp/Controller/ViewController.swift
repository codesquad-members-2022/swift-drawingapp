//
//  ViewController.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/02/28.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var colorButton: UIButton!
    @IBOutlet weak var alphaSlider: UISlider!
    @IBOutlet weak var planeView: UIView!
    @IBOutlet weak var stepper: UIStepper!
    
    private var plane = Plane()
    
    /**
     선택된 View 에 변화를 주는 것은 컨트롤러의 역할이므로 해당 View 의 참조를 컨트롤러의 속성으로 저장하였습니다.
     선택된 View 객체 정보는 컨트롤러의 상태정보에 해당한다고 생각하였기 때문입니다.
     */
    private weak var selectedRectangleView: RectangleView?
    
    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    // MARK: - UI Configuration Methods
    func configureUI() {
        self.configurePlane()
        self.configureButtons()
        self.configureStepper()
        self.alphaSlider.isEnabled = false
    }
    
    func configureStepper() {
        self.stepper.value = 5
        self.stepper.isEnabled = false
        self.stepper.addTarget(self, action: #selector(self.handleOnChangeStep), for: .valueChanged)
    }
    
    func configurePlane() {
        let touchRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.clearSelectedRectangle))
        self.planeView.addGestureRecognizer(touchRecognizer)
    }
    
    func configureButtons() {
        let fontColor = UIColor(named: "Font")
        let borderColor = UIColor(named: "Border")
        
        self.addButton.tintColor = fontColor
        self.addButton.setBorder(width: 1, radius: 10, color: borderColor)
        self.addButton.addTarget(self, action: #selector(self.handleOnPressAddButton), for: .touchUpInside)
        
        self.colorButton.tintColor = fontColor
        self.colorButton.setBorder(width: 1, radius: 10, color: borderColor)
        self.colorButton.addTarget(self, action: #selector(self.handleOnPressColorButton), for: .touchUpInside)
        
        let color = UIColor.random()
        self.colorButton.setTitle(color.toHexString(), for: .normal)
    }
    
    // MARK: - Action Methods
    @objc func handleOnChangeStep(_ sender: UIStepper) {
        self.alphaSlider.value = Float(sender.value)
        
        guard let rectangleView = self.selectedRectangleView else { return }
        
        rectangleView.setBackgroundColor(with: CGFloat(self.alphaSlider.value) / 10)
    }
    
    @objc func clearSelectedRectangle(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.stepper.isEnabled = false
            self.revertRectangleChange()
        }
    }
    
    @objc func handleOnPressAddButton(_ sender: UIButton) {
        let rectangle = RectangleFactory.makeRandomRectangle()
        plane.append(item: rectangle)
        
        let frame = rectangle.convert(using: CGRect.self)
        let rectangleView = RectangleView(frame: frame)

        rectangleView.setBackgroundColor(color: rectangle.backgroundColor, alpha: rectangle.alpha)
        rectangleView.accessibilityIdentifier = rectangle.id
        
        let touchRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapRectangle))
        rectangleView.addGestureRecognizer(touchRecognizer)
        
        self.planeView.addSubview(rectangleView)
    }
    
    @objc func tapRectangle(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.stepper.isEnabled = true
            self.revertRectangleChange()
            
            guard let rectangleView = sender.view as? RectangleView else { return }
            
            rectangleView.setBorder(width: 2, color: .blue)
            rectangleView.setBackgroundColor(with: CGFloat(self.alphaSlider.value) / 10)
            
            self.planeView.bringSubviewToFront(rectangleView)
            self.selectedRectangleView = rectangleView
        }
    }
    
    @objc func handleOnPressColorButton(_ sender: UIButton) {
        let randomColor = UIColor.random()
        self.colorButton.setTitle(randomColor.toHexString(), for: .normal)
        
        guard let selectedRectangleView = selectedRectangleView else {
            return
        }

        selectedRectangleView.backgroundColor = randomColor.withAlphaComponent(CGFloat(self.alphaSlider.value) / 10)
    }
    
    // MARK: - Methods
    func revertRectangleChange() {
        guard let rectangleView = self.selectedRectangleView else { return }
        guard let id = rectangleView.accessibilityIdentifier else { return }
        guard let rectangle = self.plane[id: id] else { return }
        
        rectangleView.removeBorder()
        rectangleView.setBackgroundColor(color: rectangle.backgroundColor, alpha: rectangle.alpha)
    }
}
