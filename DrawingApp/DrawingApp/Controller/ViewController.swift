//
//  ViewController.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/02/28.
//

import UIKit
import OSLog

class ViewController: UIViewController {
    private var presentRectangleView = PresentRectangleView()
    private var sideInspectorView = SideInspectorView()
    private var addRectangleButton = AddRectangleButton()
    
    private var plane = Plane()
    private var rectangleMap = [Rectangle : UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        
    }
    
    //MARK: Set Up Views
    
    func setUpViews() {
        
        view.addSubview(presentRectangleView)
        view.addSubview(sideInspectorView)
        view.addSubview(addRectangleButton)
        
        layoutPresentRectangleView()
        layoutSideInspectorView()
        layoutAddRectangleButton()
    }
}

//TODO: 사각형 선택시 배경색 정보 띄우기 (16진수), 버튼 누를 때 마다 랜덤하게 색 변경
//TODO: 사각형 선택시 알파 띄우기 + 조절 기능


//MARK: Add Constraints

extension ViewController {
    
    func layoutPresentRectangleView() {
        presentRectangleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        presentRectangleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        presentRectangleView.trailingAnchor.constraint(equalTo: sideInspectorView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        presentRectangleView.bottomAnchor.constraint(equalTo: addRectangleButton.topAnchor).isActive = true
    }
    
    func layoutAddRectangleButton() {
        addRectangleButton.centerXAnchor.constraint(equalTo: presentRectangleView.centerXAnchor).isActive = true
        addRectangleButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        addRectangleButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        addRectangleButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func layoutSideInspectorView() {
        sideInspectorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        sideInspectorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        sideInspectorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        sideInspectorView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
}

//MARK: Actions

extension ViewController {
    @objc func addRectangleButtonTouched() {
        let rectangleViewXBound = self.presentRectangleView.frame.width - Size.Range.width
        let rectangleViewYBound = self.presentRectangleView.frame.height - Size.Range.height

        let newRectangle = RandomRectangleFactory.createRandomRectangle(xBound: rectangleViewXBound, yBound: rectangleViewYBound)
        
        plane.append(newRectangle: newRectangle)
    }

    @objc func handleRectangleViewTap(_ tap: UITapGestureRecognizer) {
        guard tap.state == .ended else { return }
        //TODO: 제스처 액션 추가하기
    }
}

//MARK: Delegates

extension ViewController: PlaneDelegate {
    
    func didCreateRectangle(_ rectangle: Rectangle) {
        let color = RectangleAttributeFactory.createUIColor(by: rectangle)
        let frame = RectangleAttributeFactory.createRectangleFrame(by: rectangle)
        let rectangleView = RectangleView(frame: frame, color: color)
        
        self.presentRectangleView.addSubview(rectangleView)
    }
}
