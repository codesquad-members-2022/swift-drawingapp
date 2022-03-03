//
//  RectangleGenerationButton.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/03.
//

import UIKit
//View 에 action handling 로직을 직접적으로 코딩하지 않기 위해 프로토콜을 사용하여 viewController 에 action 에 대한 로직구현을 할수있게 한다.
protocol GenerateRectangleButtonDelegate {
    func didTapGenerateButton()
}

class RectangleGenerationButton: UIButton {
    
    //delegate 타입 프로퍼티 선언
    var delegate : GenerateRectangleButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        self.layer.cornerRadius = 10
        self.backgroundColor = .lightGray
        self.setTitle("사각형", for: .normal)
        self.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    //버튼이 탭 되면 didTapGenerateButton 이 호출된다.
    //didTapGenerateButton 에 대한 로직은 viewController 에 쓴다. 
    @objc func didTapButton () {
        delegate?.didTapGenerateButton()
    }
}


