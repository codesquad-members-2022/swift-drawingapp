//
//  RandomRectangle.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/02.
//

import UIKit
import os

class RandomRectangleView: UIView {
    private let randomRectangle = RandomRectangleMaker()
    private var rectangle: Rectangle?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func attribute(){
        guard let rectangle = rectangle else {
            return
        }
        
        self.backgroundColor = UIColor(red: rectangle.showColor().redValue(), green: rectangle.showColor().greenValue(), blue: rectangle.showColor().blueValue(), alpha: rectangle.showAlpha().showValue())
        self.restorationIdentifier = rectangle.showId()
    }
    
    private func layout(){
        guard let rectangle = rectangle else {
            return
        }
        
        self.frame = CGRect(x: rectangle.showPoint().xValue(), y: rectangle.showPoint().yValue(), width: rectangle.showSize().widthValue(), height: rectangle.showSize().heightValue())
    }
    
    func makeRectangleView(width: Double, height: Double){
        self.rectangle = randomRectangle.makeRectangle(viewWidth: width, viewHeight: height)
        
        layout()
        attribute()
    }
    
    func giveRectangle() -> Rectangle?{
        return rectangle
    }
}
