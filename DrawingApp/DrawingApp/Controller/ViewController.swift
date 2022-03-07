//
//  ViewController.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/02/28.
//

import UIKit
import OSLog

class ViewController: UIViewController {
    lazy var rectangleViewXBound = self.presentRectangleView.frame.width - Size.Range.width
    lazy var rectangleViewYBound = self.presentRectangleView.frame.height - Size.Range.height
    lazy var rectangleFactory = RandomRectangleFactory()
    lazy var plane = Plane()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        
        self.addRectangleButton.addTarget(self, action: #selector(addRectangleButtonTouched), for: .touchUpInside)
    }
    
    //MARK: Set Up Views
    
    func setUpViews() {
        view.addSubview(addRectangleButton)
        view.addSubview(sideInspectorView)
        view.addSubview(presentRectangleView)
        
        layoutAddRectangleButton()
        layoutSideInspectorView()
        layoutPresentRectangleView()
        layoutBackgroundMenuStackView()
        layoutAlphaMenuStackView()
    }
    
    //MARK: Configure Components
    
    private let presentRectangleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let addRectangleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray6
        button.setTitle("사각형", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray6.cgColor
        return button
    }()
    
    private let sideInspectorView: UIView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemGray6
        return stackView
    }()
    
    private let backgroundMenuStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    private let alphaMenuStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    private let backgroundColorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "배경색"
        return label
    }()
    
    private let backgroundColorValueButton: UIButton = {
        let button = UIButton()
        button.setTitle("#000000", for: .normal)
        button.backgroundColor = .systemGray2
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray3.cgColor
        return button
    }()
    
    private let alphaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "투명도"
        return label
    }()
    
    private let alphaSlider: UISlider = {
        let slider = UISlider()
        return slider
    }()
}


//TODO: 사각형 선택시 배경색 정보 띄우기 (16진수), 버튼 누를 때 마다 랜덤하게 색 변경
//TODO: 사각형 선택시 알파 띄우기 + 조절 기능


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
    
    func layoutBackgroundColorValueButton() {
        backgroundColorValueButton.leadingAnchor.constraint(equalTo: backgroundMenuStackView.leadingAnchor).isActive = true
        backgroundColorValueButton.trailingAnchor.constraint(equalTo: backgroundMenuStackView.trailingAnchor).isActive = true
        backgroundColorValueButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func layoutAlphaSlider() {
        alphaSlider.leadingAnchor.constraint(equalTo: alphaMenuStackView.leadingAnchor).isActive = true
        alphaSlider.trailingAnchor.constraint(equalTo: alphaMenuStackView.trailingAnchor).isActive = true
    }
    
    func layoutSideInspectorView() {
        sideInspectorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        sideInspectorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        sideInspectorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        sideInspectorView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func layoutBackgroundMenuStackView() {
        sideInspectorView.addSubview(backgroundMenuStackView)
        
        backgroundMenuStackView.topAnchor.constraint(equalTo: sideInspectorView.topAnchor, constant: 30).isActive = true
        backgroundMenuStackView.leadingAnchor.constraint(equalTo: sideInspectorView.leadingAnchor, constant: 30).isActive = true
        backgroundMenuStackView.trailingAnchor.constraint(equalTo: sideInspectorView.trailingAnchor, constant: -30).isActive = true
        
        backgroundMenuStackView.addArrangedSubview(backgroundColorLabel)
        
        backgroundMenuStackView.addArrangedSubview(backgroundColorValueButton)
        layoutBackgroundColorValueButton()
    }
    
    func layoutAlphaMenuStackView() {
        sideInspectorView.addSubview(alphaMenuStackView)
        
        alphaMenuStackView.topAnchor.constraint(equalTo: backgroundMenuStackView.bottomAnchor, constant: 30).isActive = true
        alphaMenuStackView.leadingAnchor.constraint(equalTo: sideInspectorView.leadingAnchor, constant: 30).isActive = true
        alphaMenuStackView.trailingAnchor.constraint(equalTo: sideInspectorView.trailingAnchor, constant: -30).isActive = true
        
        alphaMenuStackView.addArrangedSubview(alphaLabel)
        
        alphaMenuStackView.addArrangedSubview(alphaSlider)
        layoutAlphaSlider()
    }
}

//MARK: Actions

extension ViewController {
    @objc func addRectangleButtonTouched() {
        plane.delegate = self
        let newRectangle = rectangleFactory.createRandomRectangle(xBound: rectangleViewXBound,
                                                                  yBound: rectangleViewYBound)
        plane.append(newRectangle: newRectangle)
    }
}

//MARK: Delegates

extension ViewController: PlaneDelegate {
    func rectangleDidCreated(_ rectangle: Rectangle) {
        let rectangleView = RectangleViewFactory.createRectangleView(by: rectangle)
        
        rectangleView.translatesAutoresizingMaskIntoConstraints = false
        self.presentRectangleView.addSubview(rectangleView)
    }
}
