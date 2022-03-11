//
//  ViewController.swift
//  DrawingApp
//
//  Created by Selina on 2022/03/02.
//

import UIKit

class ViewController: UIViewController {
    var delegate: SideInspectorViewDelegate?
    let totalView: TotalView = {
        let view = TotalView()
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
        
        totalView.sideInspectorView.delegate = self
        
        setTotalView()
    }
    
    
    private func setTotalView() {
        view.addSubview(totalView)
        
        NSLayoutConstraint.activate([
            totalView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            totalView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            totalView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            totalView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ])
    }
}


// TODO: SideInspectorView의 영역을 제외한 부분에 사각형 그려지도록 하기
// TODO: 입력을 처리하는 곳에서는 뷰 -> 뷰컨트롤러 -> 모델로 들어가는 입력 흐름만 처리                                                           
// TODO: 아래 뷰를 생성하는 출력 흐름 분리해야함! 모델에서 뷰 컨트롤러를 거쳐서 다시 뷰를 추가하는 흐름. 모델 -> 뷰컨트롤러 -> 뷰 를 만들기
extension ViewController: SideInspectorViewDelegate {
    func sideInspectorView(_ sideInspectorView: SideInspectorView, buttonDidTapped: UIButton) {
            let rectangle = factory.createRectangle()
            plane.addRectangle(rectangle)

            let myView = UIView(frame: CGRect(x: rectangle.point.x, y: rectangle.point.y, width: rectangle.size.width, height: rectangle.size.height))
            myView.backgroundColor = UIColor(hex: rectangle.backgroundColor.getHexValue())
            view.addSubview(myView)
        
    }
}
