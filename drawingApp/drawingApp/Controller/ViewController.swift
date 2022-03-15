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
    private var plane : Plane?
    
    //Views
    private let rectangleGenerationButton = UIButton()
    private var panelView = PanelView()
    
    //ViewFactory
    private var viewFactory : ViewProducible?
  
    //View Constants
    let screenWdith = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let buttonWidth: Double = 130
    let buttonHeight: Double = 100
    let panelWidth : Double = 200
    
    
    //[Model : View]
    private var rectangleList : [Model : RectangleView] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.plane = Plane(modelFactory: ModelFactory(referecePoint: Point(x: 0, y:20), boarderSize: Size(width: screenWdith - panelWidth, height: screenHeight - buttonHeight)))
        
        setupSubViews()
        setupHandlers()
        setupLayout()
        addObservers()
        setupFactory(viewFactory: ViewFactory())
    }
    
    
    func setupSubViews() {
        view.addSubview(rectangleGenerationButton)
        view.addSubview(panelView)
    }

    func setupHandlers() {
        rectangleGenerationButton.addTarget(self, action: #selector(createRectangleModel), for:.touchUpInside)
        let tapGuestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapTriggered))
        tapGuestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGuestureRecognizer)
        panelView.colorRondomizeButton.addTarget(target, action: #selector(didTabColorRondomizeButton), for: .touchUpInside)
        panelView.alphaStepper.addTarget(target, action: #selector(didTabAlphaStepper), for: .valueChanged)
    }

    func setupLayout(){
        rectangleGenerationButton.frame = CGRect(x: (screenWdith - panelWidth)/2 - (buttonWidth/2), y: screenHeight - buttonHeight, width: buttonWidth, height: buttonHeight)
        rectangleGenerationButton.layer.cornerRadius = 10
        rectangleGenerationButton.backgroundColor = .lightGray
        rectangleGenerationButton.setTitle("사각형", for: .normal)
        panelView.frame = CGRect(x: screenWdith - panelWidth, y: view.safeAreaInsets.top, width: panelWidth, height: screenHeight)
    }
   
    func setupFactory(viewFactory : ViewProducible) {
        self.viewFactory = viewFactory
    }
    
    //MARK: 사용자가 사각형 버튼을 누르면 plane 구역안에 뷰를 생성 시켜줄 팩토리 를 이용하여 모델생성 및 plane 에 추가.
    @objc func createRectangleModel() {
        plane?.addModel()
    }
    

    //MARK: 사용자가 ViewController 를 터치했을때 좌표를 기준으로 사각형을 찾음.
    @objc func tapTriggered(sender: UITapGestureRecognizer) {
        let tappedPoint = sender.location(in: self.view)
        plane?.selectModel(tapCoordinate : Point(x: tappedPoint.x, y: tappedPoint.y))
    }
    
    @objc func didTabColorRondomizeButton(sender: UIButton) {
        plane?.randomizeColorOnSelectedModel()
        
    }
    
    @objc func didTabAlphaStepper(sender: UIStepper) {
        plane?.changeAlphaOnSelectedModel(to: Alpha(rawValue: Int(sender.value)))
    }
    



    
    //MARK: Add Observers
    func addObservers () {
        //Plane 에서 오는 post 를 받을 옵저버 생성 및 액션 지정.
        NotificationCenter.default.addObserver(self, selector: #selector(createModelView), name: .DidMakeModel, object: plane
        )
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateSelectedModel), name: .DidSelectModel, object: plane
        )
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateModelView), name: .DidChangeColor, object: plane
        )
        NotificationCenter.default.addObserver(self, selector: #selector(updatePanelView), name: .DidChangeColor, object: plane
        )
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateModelView), name: .DidChangeAlpha, object: plane
        )
        NotificationCenter.default.addObserver(self, selector: #selector(updatePanelView), name: .DidChangeAlpha, object: plane
        )
        
        

    }
    
    
    @objc func createModelView(notification: Notification) {
        guard let newModel = notification.userInfo?[UserInfo.model] else {return}
        guard let model = newModel as? Model else {return}
        if let modelView = viewFactory?.make(model: model) as? RectangleView {
            rectangleList.updateValue(modelView, forKey: model)
            view.addSubview(modelView)
        }
    }
    
    @objc func updateSelectedModel(notification: Notification) {
        guard let currentlySelectedModel = notification.userInfo?[UserInfo.currentModel] as? Model else {
            if let previouslySelectedModel = notification.userInfo?[UserInfo.previousModel] as? Model {
                updateHighlight(from: previouslySelectedModel)
            }
            panelView.setDefaultPanelValues()
            return
        }
            
        if let previouslySelectedModel = notification.userInfo?[UserInfo.previousModel] as? Model {
            updateHighlight(from: previouslySelectedModel)
        }
        updateHighlight(from: currentlySelectedModel)
        updatePanel(from: currentlySelectedModel)
    }
    
    
    @objc func updateModelView(notification: Notification) {
        guard let modifiedModel = notification.userInfo?[UserInfo.model] as? Model else {return}
        guard let modelView = rectangleList[modifiedModel] else {return}
        let colorChanged = notification.name == .DidChangeColor
        if colorChanged {
          modelView.updateColor(with: modifiedModel)
        }else{
          modelView.updateAlpha(newAlpha: modifiedModel.alpha.value)
        }
    }
    
    @objc func updatePanelView(notification: Notification) {
        guard let modifiedModel = notification.userInfo?[UserInfo.model] as? Model else {return}
        let colorChanged = notification.name == .DidChangeColor
        if colorChanged {
            panelView.updateRomdomizeColorButton(newColor: modifiedModel.color.tohexString)
        }else{
            panelView.updateAlpha(newAlphaValue: modifiedModel.alpha.value)
        }
    }
        

    //MARK: 사각형 뷰 선택에 따른 테두리 및 패널 뷰처리 함수.
    private func updateHighlight(from model: Model) {
        guard let modelView = rectangleList[model] else {return}
        modelView.configure(isSelected: model.selectedStatus())
    }
  
    
    private func updatePanel(from model: Model) {
        if model.selectedStatus() {
            panelView.updateAlpha(newAlphaValue: model.alpha.value)
            panelView.updateRomdomizeColorButton(newColor: model.color.tohexString)
        }
        else{
            panelView.setDefaultPanelValues()
        }
    }
    
    //MARK: 색상, 알파 수정에 대한 뷰처리 함수.
    private func manageAmendingViews(by model: Model, operation : (Model) -> ()){
        return operation(model)
    }
    
}
