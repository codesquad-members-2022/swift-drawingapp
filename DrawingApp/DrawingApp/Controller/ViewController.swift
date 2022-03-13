//
//  ViewController.swift
//  DrawingApp
//
//  Created by Selina on 2022/03/02.
//

import UIKit

class ViewController: UIViewController {
    var delegate: TotalViewDelegate?
    let totalView: TotalView = {
        let view = TotalView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let x = UIScreen.main.bounds.width
    let y = UIScreen.main.bounds.height
    let button = UIButton(type: .system) as UIButton
    var plane = Plane()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalView.delegate = self
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
extension ViewController: TotalViewDelegate {
    func totalViewDidTouched(_ totalView: TotalView) -> Rectangle? {
        let factory = RectangleFactory()
        let rectangle = factory.createRectangle()
        return rectangle
    }
}
