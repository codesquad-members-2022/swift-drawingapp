//
//  RectangleButton.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/08.
//

import UIKit

//button을 정의하는 코드가 너무 길어져서 ViewController에서 Button을 분리해서 선언했습니다.
final class RectangleButton:UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        configureRectangleButton()
        configureRectangleButtonTapped()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.frame = frame
        configureRectangleButton()
        configureRectangleButtonTapped()
    }
    
    
    //사각형 추가 버튼
    private func configureRectangleButton() {
        self.tintColor = .black
        
        var configuration = UIButton.Configuration.plain()
        configuration.title = "사각형"
        
        configuration.imagePlacement = .top
        configuration.imagePadding = 20
        
        configuration.background.backgroundColor = .secondarySystemBackground
        configuration.background.cornerRadius = 10
        
        self.configuration = configuration
    }
    
    
    //버튼 액션 - highLigted
    private func configureRectangleButtonTapped() {
        let squareImage = UIImage(systemName: "square")
        let highlightedImage = UIImage(systemName: "square.fill")
        
        //사각형 버튼 터치시 변화를 보여주기 위해 선언함.
        self.configurationUpdateHandler = { button in
            var configuration = button.configuration
            configuration?.image = button.isHighlighted ? highlightedImage : squareImage
            button.configuration = configuration
        }
    }
}
