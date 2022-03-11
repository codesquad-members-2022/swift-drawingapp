//
//  PlaneView.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/08.
//

import UIKit

protocol PlaneViewDelegate {
    func planeViewDidTapped(_ sender: UITapGestureRecognizer)
    func planeViewDidPressRectangleAddButton()
    func planeViewDidPressImageAddButton()
}

class PlaneView: UIView {
    var delegate: PlaneViewDelegate?
    
    private let rectangleAddButton: RoundedButton = {
        let button = RoundedButton(title: "사각형 추가")
        button.setImage(UIImage(systemName: "rectangle"), for: .normal, on: .top, with: 12)
        button.setCorners([.topLeft, .bottomLeft], radius: 10)
        
        return button
    }()
    
    private let imageAddButton: RoundedButton = {
        let button = RoundedButton(title: "이미지 추가")
        button.setImage(UIImage(systemName: "photo"), for: .normal, on: .top, with: 12)
        button.setCorners([.topRight, .bottomRight], radius: 10)
        
        return button
    }()
    
    // MARK: - Initialisers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureUI()
    }
    
    // MARK: - Configuration
    private func configureUI() {
        self.configureGesture()
        self.configureActions()
        self.configureButtonPosition()
        self.addSubview(self.rectangleAddButton)
        self.addSubview(self.imageAddButton)
    }
    
    private func configureGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleOnTapPlaneView))
        self.addGestureRecognizer(tap)
    }
    
    private func configureButtonPosition() {
        self.rectangleAddButton.center.x = self.center.x - 60
        self.rectangleAddButton.center.y = self.frame.height - self.rectangleAddButton.frame.height
        self.imageAddButton.center.x = self.center.x + 60
        self.imageAddButton.center.y = self.frame.height - self.rectangleAddButton.frame.height
    }
    
    private func configureActions() {
        self.rectangleAddButton.addTarget(self, action: #selector(PlaneView.handleOnPressRectangleAddButton), for: .touchUpInside)
        self.imageAddButton.addTarget(self, action: #selector(PlaneView.handleOnPressImageAddButton), for: .touchUpInside)
    }
    
    // MARK: - Action Methods
    @objc private func handleOnPressRectangleAddButton(_ sender: RoundedButton) {
        self.delegate?.planeViewDidPressRectangleAddButton()
    }
    
    @objc private func handleOnTapPlaneView(_ sender: UITapGestureRecognizer) {
        guard sender.state == .ended else { return }
        self.delegate?.planeViewDidTapped(sender)
    }
    
    @objc private func handleOnPressImageAddButton(_ sender: RoundedButton) {
        self.delegate?.planeViewDidPressRectangleAddButton()
    }
}
