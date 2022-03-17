//
//  ViewController.swift
//  DrawingApp
//
//  Created by Selina on 2022/03/02.
//

import UIKit

class ViewController: UIViewController {

    private var selectedRectangle: Rectangle?
    private let canvasView: CanvasView = {
        let view = CanvasView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let sideInspectorView: SideInspectorView = {
        let view = SideInspectorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let x = UIScreen.main.bounds.width
    private let y = UIScreen.main.bounds.height
    private var plane = Plane()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        plane.delegate = self
        sideInspectorView.delegate = self
        canvasView.delegate = self
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
    func sideInspectorViewDidTappedRectangleButton() {
        // VC가 모델에게 사각형 만들라고 시킴
        plane.createRectangle()
    }
    
    func sideInspectorViewDidTappedColorButton(_ sender: UIButton) {
        // 색상 버튼을 누르면 색상 값 랜덤으로 생성
        let rectangleFactory = RectangleFactory()
        let newColorValue = rectangleFactory.createRandomColor().getHexValue()
        sender.setTitle(newColorValue, for: .normal)
        
        
        // Plane에 색상 변경 알림. 사각형이 선택되었을 때만!
        if let rectangle = selectedRectangle {
            plane.backgroundColorDidChanged(color: newColorValue, rectangle: rectangle)
        }
    }
    
    func sideInspectorViewSliderValueDidChanged(_ slider: UISlider) {
        let sliderStringValue =  String(format: "%.1f", slider.value)
        let sliderValue = Float(sliderStringValue)!
        if let rectangle = selectedRectangle {
            plane.alphaValueDidChanged(alpha: sliderValue, rectangle: rectangle)
        }
    }
}


extension ViewController: PlaneDelegate {
    func planeDidAddedRectangle(_ rectangle: Rectangle) {
        // 모델에서 생성한 사각형을 모델에서 VC로 전달하고, 전달 받은 것을 canvasView에 그려주기
        canvasView.drawRectangle(rectangle: rectangle)
        
        // 버튼에 색상 표시
        sideInspectorView.colorButton.setTitle(rectangle.backgroundColor.getHexValue(), for: .normal)
        
        // 슬라이더 투명도 표시
        sideInspectorView.alphaSlider.value = Float(rectangle.alpha.opacity)
        let sliderValue = Int(rectangle.alpha.opacity * 10)
        sideInspectorView.alphaValueLabel.text = "\(sliderValue)"
    }
    
    // 사각형 터치 시, SideInspectorView에 배경색과 투명도 나타내기
    func planeDidTouchedRectangle(_ rectangle: Rectangle) {
        sideInspectorView.colorButton.setTitle(rectangle.backgroundColor.getHexValue(), for: .normal)
        sideInspectorView.alphaSlider.value = Float(rectangle.alpha.opacity)
        
        let sliderValue = Int(rectangle.alpha.opacity * 10)
        sideInspectorView.alphaValueLabel.text = "\(sliderValue)"
    }
    
    // plane의 사각형 속성 바뀐 것을 뷰에 알리기
    func planeDidChangedRectangle(_ rectangle: Rectangle) {
        canvasView.changeRectangle(rectangle)
    }
}


extension ViewController: CanvasViewDelegate {
    // CanvasView로부터 터치된 좌표를 VC에 받아온다.
    func canvasViewDidTouched(x: Double, y: Double) {
        // 여기서 x, y 값이 Plane 좌표의 직사각형을 포함하는지 확인하기
        guard let rectangle = plane.findRectangle(on: (x, y)) else {
            // 사각형이 없는 좌표이므로, 이전에 선택된 사각형이 있을 경우도 고려해야하므로 선택 취소를 해준다.
            canvasView.initializeRectangle()
            selectedRectangle = nil
            return
        }
        
        // 뷰에 터치된 사각형 표시
        selectedRectangle = rectangle
        canvasView.select(rectangle: rectangle)
    }
}
