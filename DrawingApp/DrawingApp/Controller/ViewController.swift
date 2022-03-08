//
//  ViewController.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/02/28.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties for View
    @IBOutlet weak var planeView: PlaneView!
    @IBOutlet weak var controlPanelView: ControlPanelView!
    
    /**
     선택된 View 에 변화를 주는 것은 컨트롤러의 역할이므로 해당 View 의 참조를 컨트롤러의 속성으로 저장하였습니다.
     선택된 View 객체 정보는 컨트롤러의 상태정보에 해당한다고 생각하였기 때문입니다.
     */
    private weak var selectedRectangleView: RectangleView?
    
    // MARK: - Property for Model
    private var plane = Plane()
    
    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDelegate()
    }
    
    // MARK: - UI Configuration Methods
    func configureDelegate() {
        self.planeView.delegate = self
        self.controlPanelView.delegate = self
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

extension ViewController: PlaneViewDelegate {
    func planeViewDidTapped() {
        self.revertRectangleChange()
    }
    
    func planeViewDidTapRectangleView(_ sender: UITapGestureRecognizer) {
        // TODO: Model 업데이트 & 리펙토링
        guard sender.state == .ended else { return }
        
        self.revertRectangleChange()
        
        guard let rectangleView = sender.view as? RectangleView else { return }
        
        rectangleView.setBorder(width: 2, color: .blue)
        rectangleView.setBackgroundColor(with: 1)
        
        self.planeView.bringSubviewToFront(rectangleView)
        self.selectedRectangleView = rectangleView
    }
    
    func planeViewDidPressRectangleAddButton() {
        // TODO: Model 업데이트 & 터치 시 선택 처리
        let rectangle = RectangleFactory.makeRandomRectangle()
        plane.append(item: rectangle)
        
        let frame = rectangle.convert(using: CGRect.self)
        let rectangleView = RectangleView(frame: frame)
        
        rectangleView.setBackgroundColor(color: rectangle.backgroundColor, alpha: rectangle.alpha)
        rectangleView.accessibilityIdentifier = rectangle.id
        
        self.planeView.addSubview(rectangleView)
    }
}

extension ViewController: ControlPanelViewDelegate {
    func controlPanelDidPressColorButton(sender: RoundedButton, color: UIColor) {
        // TODO: Model 업데이트
        guard let selectedRectangleView = selectedRectangleView else { return }
        selectedRectangleView.backgroundColor = color.withAlphaComponent(1)
    }
    
    func controlPanelDidPressAlphaStepper(_ sender: AlphaStepper) {
        guard let rectangleView = self.selectedRectangleView else { return }
        // TODO: Model 업데이트
        rectangleView.setBackgroundColor(with: 1)
    }
}
