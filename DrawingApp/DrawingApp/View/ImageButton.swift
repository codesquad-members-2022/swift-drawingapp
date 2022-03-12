//
//  ImageButton.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/11.
//

import UIKit

//button을 정의하는 코드가 너무 길어져서 ViewController에서 Button을 분리해서 선언했습니다.
final class ImageButton:UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        configureImageButton()
        configureImageButtonTapped()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.frame = frame
        configureImageButton()
        configureImageButtonTapped()
    }
    
    
    //사각형 추가 버튼
    private func configureImageButton() {
        self.tintColor = .black
        
        var configuration = UIButton.Configuration.plain()
        configuration.title = "사진"
        
        configuration.imagePlacement = .top
        configuration.imagePadding = 20
        
        configuration.background.backgroundColor = .secondarySystemBackground
        configuration.background.cornerRadius = 10
        configuration.background.strokeWidth = 1.0
        configuration.background.strokeColor = .lightGray
        
        self.configuration = configuration
    }
    
    
    //버튼 액션 - highLigted
    private func configureImageButtonTapped() {
        let squareImage = UIImage(systemName: "photo")
        let highlightedImage = UIImage(systemName: "photo.fill")
        
        //사각형 버튼 터치시 변화를 보여주기 위해 선언함.
        self.configurationUpdateHandler = { button in
            var configuration = button.configuration
            configuration?.image = button.isHighlighted ? highlightedImage : squareImage
            button.configuration = configuration
        }
    }
}
