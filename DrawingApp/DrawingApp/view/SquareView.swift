//
//  SquareView.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/02/28.
//

import Foundation
import UIKit

class SquareView: UIView{
    private var uniqueId: String = ""
    private let squareViewState: SquareViewState
    override var description: String {
        return squareViewState.description
    }
    
    init(squareViewState: SquareViewState){
        self.squareViewState = squareViewState
        super.init(frame: CGRect(x: squareViewState.x, y: squareViewState.y, width: squareViewState.width, height: squareViewState.height))
        self.uniqueId = squareViewState.uniqueId
        setupProperty()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupProperty(){
        let red = CGFloat(squareViewState.red)/255
        let green = CGFloat(squareViewState.green)/255
        let blue = CGFloat(squareViewState.blue)/255
        backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: CGFloat(squareViewState.alpha))
    }
}

