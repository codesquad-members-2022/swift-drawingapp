//
//  PlaneView.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/08.
//

import UIKit

protocol PlaneViewDelegate {
    func planeViewDidTapped()
    func planeViewDidTapRectangleView()
    func planeViewDidPressRectangleAddButton()
}

class PlaneView: UIView {
    var delegate: PlaneViewDelegate?
    
    let rectangleAddButton: RoundedButton = {
        let button = RoundedButton(type: .system)
        button.frame.size = CGSize(width: 120, height: 80)
        button.autoresizingMask = [ .flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleRightMargin]
        button.setTitle("사각형 추가", for: .normal)
        button.addTarget(self, action: #selector(PlaneView.handleOnPressAddRectangle), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Initialisers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    // MARK: - Configuration
    func configureView() {
        self.configureGesture()
        self.configureButtonPosition()
        self.addSubview(self.rectangleAddButton)
    }
    
    func configureGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleOnTapPlaneView))
        self.addGestureRecognizer(tap)
    }
    
    func configureButtonPosition() {
        self.rectangleAddButton.center.x = self.center.x
        self.rectangleAddButton.center.y = self.frame.height - self.rectangleAddButton.frame.height
    }
    
    // MARK: - Action Methods
    @objc func handleOnPressAddRectangle(_ sender: RoundedButton) {
        self.delegate?.planeViewDidPressRectangleAddButton()
    }
    
    @objc func handleOnTapPlaneView(_ sender: UITapGestureRecognizer) {
        guard sender.state == .ended else { return }
        self.delegate?.planeViewDidTapped()
    }
    
    @objc func handleOnTapRectangleView(_ sender: UITapGestureRecognizer) {
        guard sender.state == .ended else { return }
        self.delegate?.planeViewDidTapRectangleView()
    }
}
