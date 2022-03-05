//
//  DetailViewController.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/04.
//

import UIKit

class DetailView: UIView {
    
    //배경색
    var backgroundColorLabel:UILabel {
        let lable = UILabel(frame: CGRect(x: 20, y: 20, width: 200, height: 50))
        lable.text = "배경색"
        lable.textColor = .black
        lable.font = .systemFont(ofSize: 18)
        return lable
    }
    
    //배경색 rgb정보
    var backgroundColorButton:UIButton {
        let button = UIButton(frame: CGRect(x: 20, y: 70, width: 150, height: 50))
        button.setTitle("########", for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(.black, for: .normal)
        return button
    }
    
    //투명도 label
    var alphaLabel:UILabel {
        let lable = UILabel(frame: CGRect(x: 20, y: 160, width: 180, height: 50))
        lable.text = "투명도"
        lable.textColor = .black
        lable.font = .systemFont(ofSize: 18)
        return lable
    }
    
    //투명도 Slider
    var alphaSlider:UISlider {
        let slider = UISlider(frame: CGRect(x: 20, y: 200, width: 150, height: 50))
        slider.minimumValue = Alpha.minValue
        slider.maximumValue = Alpha.maxValue
        slider.isContinuous = false
        slider.tintColor = .black

        slider.addTarget(
            self,
            action: #selector(sliderValueChange(_ :)),
            for: .valueChanged
        )

        return slider
    }
    
    
   //TODO: Change Alpha
    @objc func sliderValueChange(_ sender:UISlider) {
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    
    private func setupView() {
        self.backgroundColor = .secondarySystemBackground
        [backgroundColorLabel, backgroundColorButton, alphaLabel, alphaSlider].forEach {
            self.addSubview($0)
        }
        

    }
}
