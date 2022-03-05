//
//  ViewController.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/02/28.
//

import UIKit
import OSLog
class ViewController: UIViewController {
    
    
    private var plane = Plane()
    private let rectangleGenerationButton = RectangleGenerationButton()
    private let panel = PanelView()
    
    let screenWdith = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let buttonWidth: Double = 130
    let buttonHeight: Double = 100
    let panelWidth : Double = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(rectangleGenerationButton)
        view.addSubview(panel)
        
        //rectangleGenerationButton 의 delegate 프로퍼티 에서 옵셔녈로 설정했던 프로토콜 타입을 현재 뷰컨트롤러로 설정해준다. (이때 뷰컨트롤러는 해당프로토콜을 채택하고있어야함).
        rectangleGenerationButton.delegate = self
        plane.delegate = self
        //panel 안에 선언되어 있는 버튼의 델리게이트 선언.
        if let colorRondomizeButton = panel.viewWithTag(1) as? ColorRondomizeButton {
            colorRondomizeButton.delegate = self
        }
        let tapGuestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapTriggered))
        tapGuestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGuestureRecognizer)
        
    }
    
    override func viewWillLayoutSubviews() {
        rectangleGenerationButton.frame = CGRect(x: (screenWdith - panelWidth)/2 - (buttonWidth/2), y: screenHeight - buttonHeight, width: buttonWidth, height: buttonHeight)
        panel.frame = CGRect(x: screenWdith - panelWidth, y: view.safeAreaInsets.top, width: panelWidth, height: screenHeight)
    }
    
    //MARK: 탭한 좌표 에 사각형이 있는지 확인 하고 있을시 사각형 하일라이트. 
    @objc func tapTriggered(sender: UITapGestureRecognizer) {
        let point = sender.location(in: self.view)
        let detectedView = view.hitTest(sender.location(in: self.view), with: nil) as? RectangleView
        let presentedRectViews = view.subviews.compactMap{$0 as? RectangleView}
        detectedView?.delegate = self
        if plane.detectRect(x: point.x, y: point.y) {
            selectHighlight(at: detectedView, on: presentedRectViews)
        }
        
        else {
            dismissSelectHighlight(on: presentedRectViews)
        }
    }
    
    // MARK: 선택한 사각형뷰에 보더 그려주기.
    func selectHighlight(at detectedView: RectangleView?, on presentedRectView : [RectangleView]) {
        if let rectView = detectedView {
            os_log(.debug,"사각형 뷰정보 : \(rectView)")
            for view in presentedRectView{
                if rectView == view {
                    invertSelectConfiguration(rectView)
                }else{
                    view.configure(didSelect: false)
                    view.selected = false
                }
            }
        }
    }
    
    func invertSelectConfiguration (_ rectView: RectangleView){
        if rectView.selected {
            rectView.configure(didSelect: false)
            resetPanel()
        }else{
            rectView.configure(didSelect: true)
        }
        rectView.selected = !rectView.selected
    }
    
    func dismissSelectHighlight(on presentedRectView : [RectangleView]) {
        for view in presentedRectView{
            view.configure(didSelect: false)
            view.selected = false
        }
        resetPanel()
    }

    func resetPanel() {
        if let colorRondomizeButton = panel.viewWithTag(1) as? UIButton {
            colorRondomizeButton.setTitle("", for: .normal)
        }
    }


    //MARK: Panel 의 colorRondomizeButton 에 선택된 RectangleView 이 무슨색인지 hex-code 로 보여준다.
    func writeColorInfo(condition: (Rectangle?) -> (Bool)) {
        for i in 0..<plane.numberOfRect{
            if condition(plane[i]) {
                if let colorRondomizeButton = panel.viewWithTag(1) as? UIButton {
                    colorRondomizeButton.setTitle(plane[i]?.color.tohexString, for: .normal)
                }
            }
        }
    }
    
    //MARK: 선택 되어 있는 RectangleView 의 색상을 업데이트한다.
    func updateRectangleViewColor(to color: Color?) {
        let presentedRectViews = view.subviews.compactMap{$0 as? RectangleView}
        for rectView in presentedRectViews {
            if rectView.selected, let newcolor = color {
                rectView.updateColor(newColor: newcolor)
            }
        }
    }
}

//MARK: Delegates

extension ViewController : GenerateRectangleButtonDelegate {
    //사각형 생성 버튼이 눌리면 함수 정의
    func didTapGenerateButton() {
        do {
            let rect = try ShapeFactory(planeWidth: screenWdith - panelWidth, planeHeight: screenHeight - buttonHeight, shapeSize: Size(width: 130, height: 120)).makeRect()
            os_log(.debug, "\(rect)")
            plane.append(rect)
        }catch{
        }
    }
}

extension ViewController : PlaneDelegate {
    func didAppendRect(rect: Rectangle?) {
        if let appendedRect = rect {
            let rectUI = RectangleView(frame: CGRect(x: appendedRect.point.x.trim, y: appendedRect.point.y.trim, width: appendedRect.size.width, height: appendedRect.size.height))
            rectUI.backgroundColor = UIColor(red: appendedRect.color.red.scaleRGB, green: appendedRect.color.green.scaleRGB, blue: appendedRect.color.blue.scaleRGB, alpha: Double(appendedRect.alpha.rawValue).scaleAlhpa)
            view.addSubview(rectUI)
        }
    }
}

extension ViewController : RectangleViewDelegate {
    func didTouchRectView(rectView: RectangleView) {
        writeColorInfo(){ (rectangleModel) in
            if rectView.frame.minX.trim == rectangleModel?.point.x.trim , rectView.frame.minY.trim == rectangleModel?.point.y.trim {
               return true
            }
            return false
        }
    }
}


extension ViewController : ColorRondomizeButtonDelegate {
    func generateRandomColor(sender: ColorRondomizeButton) {
        let hexColor = sender.currentTitle
        writeColorInfo(){ (rectangleModel) in
            if rectangleModel?.color.tohexString == hexColor {
                rectangleModel?.randomizeColor()
                updateRectangleViewColor(to:rectangleModel?.color)
                return true
            }
            return false
        }
    }
}
