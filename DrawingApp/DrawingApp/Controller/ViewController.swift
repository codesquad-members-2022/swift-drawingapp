//
//  ViewController.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/02/28.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties for View
    @IBOutlet weak var controlPanelView: ControlPanelView!
    @IBOutlet weak var planeView: PlaneView!
    
    /**
     선택된 View 에 변화를 주는 것은 컨트롤러의 역할이므로 해당 View 의 참조를 컨트롤러의 속성으로 저장하였습니다.
     선택된 View 객체 정보는 컨트롤러의 상태정보에 해당한다고 생각하였기 때문입니다.
     */
    
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
    
    func setObservers() {
        
    }
}

// MARK: - PlaneView To ViewController
extension ViewController: PlaneViewDelegate {
    func planeViewDidTapped() {
        // TODO: 사각현 선택해제
    }
    
    func planeViewDidTapRectangleView(_ sender: UITapGestureRecognizer) {
        // TODO: 사각형 뷰 선택
    }
    
    func planeViewDidPressRectangleAddButton() {
        let rectangle = RectangleFactory.makeRandomRectangle()
        plane.append(item: rectangle)
    }
}

// MARK: - ControlPanelView To ViewController
extension ViewController: ControlPanelViewDelegate {
    func controlPanelDidPressColorButton() {
        let color = UIColor.random()
        
        // TODO: 현재 선택된 사각형 모델의 배경색 변경
    }
    
    func controlPanelDidPressAlphaStepper(_ sender: UIStepper) {
        let alpha = sender.value
        
        // TODO: 선택된 사각형 모델의 Alpha 값 변경
    }
}

// MARK: - Rectangle To ViewController
extension ViewController {
    
}
