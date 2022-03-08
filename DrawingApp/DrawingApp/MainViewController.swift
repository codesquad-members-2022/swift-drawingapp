//
//  ViewController.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/02/28.
//

import UIKit
import OSLog

class MainViewController: UIViewController{

    //model
    var plane = Plane()
    //view
    var detailView = DetailView()
    var rectangleView = RectangleView()
    
    //버튼 외형 설정
    var button:UIButton = {
        let button = UIButton()
        
        let width = 150.0
        let height = 100.0
        let x = (Point.maxX / 2) - (width / 2)
        let y = (Point.maxY - height) - 30
        
        button.frame = CGRect(x: x, y: y, width: width, height: height)
        button.tintColor = .black
        
        var configuration = UIButton.Configuration.plain()
        configuration.title = "사각형"
        
        configuration.imagePlacement = .top
        configuration.imagePadding = 20
        
        configuration.background.backgroundColor = .secondarySystemBackground
        configuration.background.cornerRadius = 10
        
        button.configuration = configuration
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.delegate = self
        
        setupViews()
        configureTapGesture()
        configureDeatailView()
        configureRectangleButtonTapped()
        
    }
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
    }
    
    
    private func configureDeatailView() {
        detailView.frame = CGRect(
            x: self.view.frame.maxX - 200,
            y: 0,
            width: 200,
            height: self.view.frame.height
        )
    }
    
    
    //버튼에 액션 추가
    private func configureRectangleButtonTapped() {
        let squareImage = UIImage(systemName: "square")
        let highlightedImage = UIImage(systemName: "square.fill")
        
        button.addAction(makeRectangleAction(), for: .touchUpInside)
        
        //사각형 버튼 터치시 변화를 보여주기 위해 선언함.
        button.configurationUpdateHandler = { button in
            var configuration = button.configuration
            configuration?.image = button.isHighlighted ? highlightedImage : squareImage
            button.configuration = configuration
        }
    }
    
    //버튼 액션정의
    private func makeRectangleAction() -> UIAction {
        let action = UIAction {_ in
            
            let id = IDFactory.makeRandomID()
            let size = Size(width: 150, height: 120)
            let point = Point.random()
            let rgb = RGB.random()
            let alpha = Alpha.random()
            
            let rect = Rectangle(id: id, origin: point, size: size, backGroundColor: rgb, alpha: alpha)
            let rectView = UIView(rect: rect, rgb: rgb, alpha: alpha)
            
            rectView.clipsToBounds = true
            self.plane.rectangles.append(rect)                                  //모델에 rectangle을 추가
            self.rectangleView.views.append(rectView)                           //view에 retangleView를 추가
            
            
            self.view.addSubview(rectView)
        }
        return action
    }
    
    private func setupViews() {
        view.addSubview(button)
        view.addSubview(detailView)
    }
}

//MARK: -- UIGesture 처리
extension MainViewController:UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        let touchedView = self.view.hitTest(touch.location(in: self.view), with: nil)
        //터치한 곳의 View에 사각형의 id가 있다면 사각형입니다.
        if touchedView?.accessibilityIdentifier != nil {
            //기존에 seletedRectanlge이 있다면 테두리를 원상복구 시키고 새롭게 선택된 rectangle의 테두리를 검게 칠합니다.
            self.rectangleView.selectedView.layer.borderWidth = 0.0
            
            touchedView?.layer.borderWidth = 2.0
            touchedView?.layer.borderColor = UIColor.black.cgColor
            
            changeBackgroundButtonTitle(view: touchedView)
            
            plane.selectedRectangle = plane.rectangles.first{ $0.id.description == touchedView?.accessibilityIdentifier }
        
            self.rectangleView.selectedView = touchedView ?? UIView()
            
            //detailView를 클릭했을시에도 테두리가 사라지지 않게 하기위해 빈화면크기의 View를 클릭했을 시에만 테두리를 없앱니다.
        } else if touchedView?.frame.size == CGSize(width: 1180, height: 820){
            self.rectangleView.selectedView.layer.borderWidth = 0.0
        }
        
        return true
    }
    
    //현재 touch된 view의 id를 비교해서 RGB값을 가져오고 hex값으로 변환시켜 버튼title에 넣는다.
    private func changeBackgroundButtonTitle(view:UIView?) {
        let currentRectangle = plane.rectangles.first { $0.id.description == view?.accessibilityIdentifier }
        let currentBackgroundColor = currentRectangle?.rgb.hexValue ?? " "
        
        self.detailView.backgroundColorButton.setTitle("\(currentBackgroundColor)", for: .normal)
    }
}

//MARK: -- Delegate메소드 실제 구현

//슬라이더를 움직일때 마다 현재 클릭한 사각형의 alpha값을 바꾼다.
extension MainViewController:DetailViewDelgate {
    func sliderViewEndEditing(sender: UISlider) {
        let currentSliderValue = sender.value                                           //silder에서 넘어온 값
        
        let currentRectangle = plane.selectedRectangle                                   //현재 선택한 사각형 모델
        let currentRectangleView = rectangleView.selectedView                            //현재 선택한 사각형 뷰
        
        currentRectangle?.alpha = Alpha(sender.value)                                    //모델의 값을 바꾼다
        currentRectangleView.alpha = CGFloat(currentRectangle?.alpha.value ?? 0.0)       //바꾼 모델의 값을 View에 적용시킨다.
        
        self.detailView.alphaLabel.text = "투명도 \(currentSliderValue)"
    }
    
    
    //랜덤한 RGB값을 설정하고 현재 선택된 뷰의 배경색을 변경한다
    func colorButtonTouched(sender:UIButton) {
        let randomRGB = RGB.random()
        guard let currentRectangle = plane.selectedRectangle  else { return }                                   //현재 선택한 사각형 모델
        let currentRectangleView = rectangleView.selectedView                                                   //현재 선택한 사각형 뷰
        
        currentRectangle.rgb = randomRGB                                                                        //모델의 값을 바꾼다.
        
        currentRectangleView.backgroundColor = UIColor(rgb: currentRectangle.rgb, alpha: currentRectangle.alpha)  //바꾼 모델의 값을 View에 적용한다.
        
        sender.setTitle("\(randomRGB.hexValue)", for: .normal)                                                  //text를 바꾼다.
    }
}
