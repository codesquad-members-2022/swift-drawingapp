//
//  ViewController.swift
//  DrawingApp
//
//  Created by Selina on 2022/03/02.
//

import UIKit

class ViewController: UIViewController {
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
    
    
    @objc func createRectangleButtonTapped(_ sender: UIButton) {
        let rectangle = factory.createRectangle()
        plane.addRectangle(rectangle)
        
        let myView = UIView(frame: CGRect(x: rectangle.point.x, y: rectangle.point.y, width: rectangle.size.width, height: rectangle.size.height))
        myView.backgroundColor = UIColor(hex: rectangle.backgroundColor.hexValue)
        view.addSubview(myView)
    }
    
    
    func createRectangleButton() {
        self.button.frame = CGRect(x: x - 250, y: y - 150, width: 150, height: 75)
        self.button.backgroundColor = UIColor.systemCyan
        self.button.setTitle("사각형 생성", for: .normal)
        self.button.tintColor = .white
        self.button.addTarget(self, action: #selector(createRectangleButtonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createRectangleButton()
        
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
}
