//
//  ViewController.swift
//  DrawingApp
//
//  Created by Selina on 2022/03/02.
//

import UIKit

class ViewController: UIViewController {
    var delegate: SideInspectorViewDelegate?
    let sideInspectorView: SideInspectorView = {
        let view = SideInspectorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let x = UIScreen.main.bounds.width
    let y = UIScreen.main.bounds.height
    let button = UIButton(type: .system) as UIButton
    let factory = RectangleFactory()
    var plane = Plane()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideInspectorView.delegate = self
        
        setInspectorView()
    }
    
    private func setInspectorView() {
        view.addSubview(sideInspectorView)
        
        NSLayoutConstraint.activate([
            sideInspectorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            sideInspectorView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            sideInspectorView.widthAnchor.constraint(equalToConstant: 200),
            sideInspectorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ])
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        
    }
}



extension ViewController: SideInspectorViewDelegate {
    // TODO: SideInspectorView의 영역을 제외한 부분에 사각형 그려지도록 하기
    func sideInspectorView(_ sideInspectorView: SideInspectorView, buttonDidTapped: UIButton) {
        let rectangle = factory.createRectangle()
        plane.addRectangle(rectangle)
        
        let myView = UIView(frame: CGRect(x: rectangle.point.x, y: rectangle.point.y, width: rectangle.size.width, height: rectangle.size.height))
        myView.backgroundColor = UIColor(hex: rectangle.backgroundColor.getHexValue())
        view.addSubview(myView)
        
    }
}
