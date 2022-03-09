//
//  ViewController.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/02/28.
//

import UIKit
import OSLog

class ViewController: UIViewController {
    
    private var presentRectangleView = PresentRectangleView()
    private var sideInspectorView = SideInspectorView()
    private var addRectangleButton = AddRectangleButton()
    
    private var plane = Plane()
    private var rectangleMap = [Rectangle : RectangleView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        plane.delegate = self
        
        setUpViews()
        
        //Add Gesture Recognizer
        let presentRectangleViewTap = UITapGestureRecognizer(target: self, action: #selector(handlePresentRectangleViewTap(_:)))
        presentRectangleView.addGestureRecognizer(presentRectangleViewTap)
    }
    
    //MARK: Set Up Views
    
    func setUpViews() {
        
        view.addSubview(presentRectangleView)
        view.addSubview(sideInspectorView)
        view.addSubview(addRectangleButton)
        
        layoutPresentRectangleView()
        layoutSideInspectorView()
        layoutAddRectangleButton()
    }
}

//MARK: Add Constraints

extension ViewController {
    
    func layoutPresentRectangleView() {
        presentRectangleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        presentRectangleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        presentRectangleView.trailingAnchor.constraint(equalTo: sideInspectorView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        presentRectangleView.bottomAnchor.constraint(equalTo: addRectangleButton.topAnchor).isActive = true
    }
    
    func layoutAddRectangleButton() {
        addRectangleButton.centerXAnchor.constraint(equalTo: presentRectangleView.centerXAnchor).isActive = true
        addRectangleButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        addRectangleButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        addRectangleButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func layoutSideInspectorView() {
        sideInspectorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        sideInspectorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        sideInspectorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        sideInspectorView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
}

//MARK: Actions

extension ViewController {
    @objc func addRectangleButtonTouched() {
        let rectangleViewXBound = presentRectangleView.frame.width - Size.Range.width
        let rectangleViewYBound = presentRectangleView.frame.height - Size.Range.height

        let newRectangle = RandomRectangleFactory.createRandomRectangle(xBound: rectangleViewXBound, yBound: rectangleViewYBound)
        
        plane.append(newRectangle: newRectangle)
    }

    @objc func handlePresentRectangleViewTap(_ tap: UITapGestureRecognizer) {
        guard tap.state == .ended else { return }
        
        let location = tap.location(in: presentRectangleView)
        let coordinate = (Double(location.x), Double(location.y))
        plane.searchRectangle(on: coordinate)
    }
}

//MARK: Delegates

extension ViewController: PlaneDelegate {
    
    func didSelectRectanlge(_ rectangle: Rectangle?) {

        //최근에 선택되었던 사각형이 있다면
        if let recentlySelectedRectangle = plane.recentlySelectedRectangle,
            let recentlySelectedRectangleView = rectangleMap[recentlySelectedRectangle] {
            recentlySelectedRectangleView.clearCorner()
        }
        
        //터치이벤트 발생한 지점에 rectangle이 없거나, 그 rectangle의 value로 연결된 view가 없다면 return
        guard let rectangle = rectangle, let rectangleView = rectangleMap[rectangle] else { return }
        
        plane.updateRecentlySelected(rectangle: rectangle)
        rectangleView.toggleCorner()
        
        
        //TODO: SideInspectorView에 선택된 사각형의 속성값 전달
            // rectangle != nil -> status 전달
            // rectangle == nil -> clear
        
    }
    
    func didCreateRectangle(_ rectangle: Rectangle) {
        let color = RectangleAttributeFactory.createUIColor(by: rectangle)
        let frame = RectangleAttributeFactory.createRectangleFrame(by: rectangle)
        let rectangleView = RectangleView(frame: frame, color: color)
        
        presentRectangleView.addSubview(rectangleView)
        rectangleMap[rectangle] = rectangleView
    }
}
