//
//  ViewController.swift
//  DrawingApp
//
//  Created by Selina on 2022/03/02.
//

import UIKit

class ViewController: UIViewController {
//    typealias RectangleView = UIView
//    private var rectangles = [Rectangle: RectangleView]()
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
    
    /// 입력 (VC -> Model)
    /// 모델에게 알리고, 모델에게 랜덤 색상 생성하라고 시키기.
    func sideInspectorViewDidTappedColorButton() {
        plane.changeBackgroundColor()
    }
    
    func sideInspectorViewSliderValueDidChanged(_ slider: UISlider) {
        let sliderValue = round(slider.value * 10) / 10.0
        if let rectangle = selectedRectangle {
            plane.alphaValueDidChanged(alpha: sliderValue, rectangle: rectangle)
        }
    }
}


extension ViewController: PlaneDelegate {
    func planeDidAddRectangle(_ rectangle: Rectangle) {
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
    // CanvasView에도 선택되었다고 표시하기 (Plane -> VC -> View)
    func planeDidTouchedRectangle(_ rectangle: Rectangle) {
        sideInspectorView.colorButton.setTitle(rectangle.backgroundColor.getHexValue(), for: .normal)
        sideInspectorView.alphaSlider.value = Float(rectangle.alpha.opacity)
        
        let sliderValue = Int(rectangle.alpha.opacity * 10)
        sideInspectorView.alphaValueLabel.text = "\(sliderValue)"
        
        canvasView.select(rectangle: rectangle)
    }
    
    /// 출력: Plane에서 빈 공간이 터치된 것을 View에게 전달 (VC -> View)
    func planeDidTouchedEmptySpace() {
        canvasView.unselectRectangle()
    }
    
    // plane이 색상 변경한 것을 SideInspectorView에 알리기 VC -> SideInspectorView (출력: 색상 변경 뷰에게 알림)
    // plane이 색상 변경한 것을 CanvasView에 알리기
    func planeDidChangedColor(of rectangle: Rectangle) {
        sideInspectorView.changeColorString(rectangle.backgroundColor)
        canvasView.changeColor(of: rectangle, color: rectangle.backgroundColor)
    }
}


extension ViewController: CanvasViewDelegate {
    // CanvasView로부터 터치된 좌표를 VC에 받아오고, Plane에게 단순하게 터치된 좌표를 알리기. (CanvasView -> VC -> Model)
    func canvasViewDidTouched(on point: (x: Double, y: Double)) {
        plane.didTouched(on: point)
    }
}
