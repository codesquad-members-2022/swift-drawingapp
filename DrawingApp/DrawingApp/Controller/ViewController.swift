//
//  ViewController.swift
//  DrawingApp
//
//  Created by Selina on 2022/03/02.
//

import UIKit

class ViewController: UIViewController {
    var sideInspectorViewDelegate: SideInspectorViewDelegate?
    
    let canvasView: CanvasView = {
        let view = CanvasView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let sideInspectorView: SideInspectorView = {
        let view = SideInspectorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let x = UIScreen.main.bounds.width
    let y = UIScreen.main.bounds.height
    let button = UIButton(type: .system) as UIButton
    var plane = Plane()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        plane.delegate = self
        sideInspectorView.delegate = self
        setLayout()
    }
    
    
    private func setLayout() {
        view.addSubview(canvasView)
        view.addSubview(sideInspectorView)
        
        NSLayoutConstraint.activate([
            sideInspectorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            sideInspectorView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            sideInspectorView.widthAnchor.constraint(equalToConstant: 200),
            sideInspectorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            
            canvasView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            canvasView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            canvasView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            canvasView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -200)
        ])
    }
}


// TODO: SideInspectorView의 영역을 제외한 부분에 사각형 그려지도록 하기
// TODO: 입력을 처리하는 곳에서는 뷰 -> 뷰컨트롤러 -> 모델로 들어가는 입력 흐름만 처리                                                           
// TODO: 아래 뷰를 생성하는 출력 흐름 분리해야함! 모델에서 뷰 컨트롤러를 거쳐서 다시 뷰를 추가하는 흐름. 모델 -> 뷰컨트롤러 -> 뷰 를 만들기
extension ViewController: SideInspectorViewDelegate {
    func sideInspectorViewDidTappedButton() {
        // VC가 모델에게 사각형 만들라고 시킴
        plane.createRectangle()
    }
    
}

extension ViewController: PlaneDelegate {
    func planeDidAddedRectangle(_ rectangle: Rectangle) {
        // 모델에서 생성한 사각형을 모델에서 VC로 전달하고, 전달 받은 것을 canvasView에 그려주기
        canvasView.drawRectangle(rectangle: rectangle)
    }
}
