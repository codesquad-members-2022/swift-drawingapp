//
//  ViewController.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/02/28.
//

import UIKit
import OSLog
class ViewController: UIViewController {
    
    //Model
    private var plane = Plane()
    
    //Views
    private let rectangleGenerationButton = RectangleGenerationButton()
    private let panel = PanelView()
    let colorRondomizeButton = ColorRondomizeButton()

    //View Constants
    let screenWdith = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let buttonWidth: Double = 130
    let buttonHeight: Double = 100
    let panelWidth : Double = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        setupGestureRecognizer()
        setupDelegates()
    }
    
    override func viewWillLayoutSubviews() {
        setupLayout()
    }
    
    
    func setupSubViews() {
        view.addSubview(rectangleGenerationButton)
        view.addSubview(panel)
        view.addSubview(colorRondomizeButton)

    }

    func setupGestureRecognizer() {
        let tapGuestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapTriggered))
        tapGuestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGuestureRecognizer)
    }
    
    func setupDelegates(){
        rectangleGenerationButton.delegate = self
        plane.delegate = self
        colorRondomizeButton.delegate = self
    }
    
    func setupLayout(){
        rectangleGenerationButton.frame = CGRect(x: (screenWdith - panelWidth)/2 - (buttonWidth/2), y: screenHeight - buttonHeight, width: buttonWidth, height: buttonHeight)
        panel.frame = CGRect(x: screenWdith - panelWidth, y: view.safeAreaInsets.top, width: panelWidth, height: screenHeight)
        colorRondomizeButton.frame = CGRect(x: (screenWdith - panelWidth) + 20, y: view.safeAreaInsets.top + 70.0, width: 160, height: 50)

    }
    
    //MARK: 탭 제스쳐 메소드
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
    
    // MARK: 선택한 사각형뷰 Highlight 메소드.
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
        colorRondomizeButton.setTitle("", for: .normal)
    }


    //MARK: Panel 의 colorRondomizeButton 에 선택된 RectangleView 이 무슨색인지 hex-code 로 보여주기.
    func displayColorInfo(condition: (Rectangle?) -> (Bool)) {
        for i in 0..<plane.numberOfRect{
            if condition(plane[i]) {
                colorRondomizeButton.setTitle(plane[i]?.color.tohexString, for: .normal)
            }
        }
    }
    
    //MARK: 선택 되어 있는 RectangleView 의 색상을 업데이트하기.
    func updateRectangleViewColor(with model: Rectangle?) {
        let presentedRectViews = view.subviews.compactMap{$0 as? RectangleView}
        for rectView in presentedRectViews {
            if rectView.selected, let rectModel = model {
                rectView.updateColor(with: rectModel)
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
            let rectView = RectangleView(frame: CGRect(x: appendedRect.point.x.trim, y: appendedRect.point.y.trim, width: appendedRect.size.width, height: appendedRect.size.height))
            rectView.backgroundColor = UIColor(red: appendedRect.color.red.scaleRGB, green: appendedRect.color.green.scaleRGB, blue: appendedRect.color.blue.scaleRGB, alpha: appendedRect.alpha.value)
            view.addSubview(rectView)
        }
    }
}

extension ViewController : RectangleViewDelegate {
    func didTouchRectView(rectView: RectangleView) {
        displayColorInfo(){ (rectangleModel) in
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
        displayColorInfo(){ (rectangleModel) in
            if rectangleModel?.color.tohexString == hexColor {
                rectangleModel?.randomizeColor()
                updateRectangleViewColor(with:rectangleModel)
                return true
            }
            return false
        }
    }
}
