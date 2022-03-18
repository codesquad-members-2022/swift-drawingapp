//
//  DetailViewDelgate.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/05.
//

import UIKit

protocol DetailViewDelegate:AnyObject {
    func sliderViewEndEditing(sender:UISlider)
    func colorButtonTouched(sender:UIButton)
}
