//
//  ViewController.swift
//  DrawingApp
//
//  Created by Selina on 2022/03/02.
//

import UIKit

class ViewController: UIViewController {
    typealias RectangleView = UIView
    typealias CanvasView = UIView
    
    private var rectangles = [Rectangle: RectangleView]()
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
        
        sideInspectorView.delegate = self
        setLayout()
        setTapGesture()
        
        subscribeObserver()
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
    
    // 받은 직사각형을 CanvasView에 그려주기 (VC -> View)
    private func drawRectangle(rectangle: Rectangle) {
        let rectangleView = RectangleView(frame: CGRect(x: rectangle.point.x,
                                                        y: rectangle.point.y,
                                                        width: rectangle.size.width,
                                                        height: rectangle.size.height))
        rectangleView.backgroundColor = UIColor(hex: rectangle.backgroundColor.getHexValue())
        rectangleView.alpha = rectangle.alpha.opacity
        canvasView.addSubview(rectangleView)
        rectangles[rectangle] = rectangleView
    }
    
    private func select(rectangle: Rectangle) {
        unselectRectangle()
        rectangles[rectangle]?.layer.borderWidth = 3
        rectangles[rectangle]?.layer.borderColor = UIColor.blue.cgColor
        
        selectedRectangle = rectangle
    }

    private func unselectRectangle() {
        for (_, value) in rectangles {
            value.layer.borderWidth = 0
        }
    }
    
    private func setTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        tapGesture.delegate = self
        canvasView.addGestureRecognizer(tapGesture)
    }
    
    private func subscribeObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didCreateRectangle(_:)),
                                               name: .PlaneDidCreateRectangle,
                                               object: plane)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didTouchRectangle(_:)),
                                               name: .PlaneDidTouchRectangle,
                                               object: plane)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didTouchEmptyView(_:)),
                                               name: .PlaneDidTouchEmptyView,
                                               object: plane)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didChangeColor(_:)),
                                               name: .PlaneDidChangeColor,
                                               object: plane)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didChangeAlpha(_:)),
                                               name: .PlaneDidChangeAlpha,
                                               object: plane)
    }
    
    // 사각형 생성 시 뷰에 알리기
    @objc func didCreateRectangle(_ notification: Notification) {
        if let rectangle = notification.userInfo?[UserInfoKeys.rectangle] as? Rectangle {
            drawRectangle(rectangle: rectangle) // 모델에서 생성한 사각형을 모델에서 VC로 전달하고, 전달 받은 것을 canvasView에 그려주기
            
            sideInspectorView.colorButton.setTitle(rectangle.backgroundColor.getHexValue(), for: .normal) // 버튼에 색상 표시
            sideInspectorView.alphaSlider.value = Float(rectangle.alpha.opacity) // 슬라이더 투명도 표시
            
            let sliderValue = Int(rectangle.alpha.opacity * 10)
            sideInspectorView.alphaValueLabel.text = "\(sliderValue)"
        }
    }
    
    // 사각형 터치 시, SideInspectorView에 배경색과 투명도 나타내기
    @objc func didTouchRectangle(_ notification: Notification) {
        if let rectangle = notification.userInfo?[UserInfoKeys.rectangle] as? Rectangle {
            sideInspectorView.colorButton.setTitle(rectangle.backgroundColor.getHexValue(), for: .normal)
            sideInspectorView.alphaSlider.value = Float(rectangle.alpha.opacity)
            
            let sliderValue = Int(rectangle.alpha.opacity * 10)
            sideInspectorView.alphaValueLabel.text = "\(sliderValue)"
            
            select(rectangle: rectangle)
        }
    }
    
    // Plane에서 빈 공간이 터치된 것을 View에게 전달 (VC -> View)
    @objc func didTouchEmptyView(_ notification: Notification) {
        unselectRectangle()
    }
    
    // plane이 색상 변경한 것을 CanvasView에 알리기
    @objc func didChangeColor(_ notification: Notification) {
        if let selectedRectangle = selectedRectangle {
            if let color = notification.userInfo?[UserInfoKeys.color] as? Color {
                sideInspectorView.changeColorString(color)
                rectangles[selectedRectangle]?.backgroundColor = UIColor(hex: color.getHexValue())
            }
        }
    }
    
    // Plane에서 변경된 투명도를 SideInspector과 CanvasView에 알리기 (VC -> View)
    @objc func didChangeAlpha(_ notification: Notification) {
        if let selectedRectangle = selectedRectangle {
            if let alpha = notification.userInfo?[UserInfoKeys.alpha] as? Alpha {
                sideInspectorView.changeAlpha(alpha)
                rectangles[selectedRectangle]?.alpha = alpha.opacity
            }
        }
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
    
    /// 입력 (VC -> Model)
    ///  모델에게 변경된 값 알림
    func sideInspectorViewSliderValueDidChanged(_ value: Float) {
        let sliderValue = round(value * 10) / 10.0
        plane.changeAlphaValue(alpha: sliderValue)
    }
}


extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let touchedView = gestureRecognizer.location(in: gestureRecognizer.view) // 터치되는 좌표
        plane.didTouched(on: (touchedView.x, touchedView.y))
        return true
    }
}
