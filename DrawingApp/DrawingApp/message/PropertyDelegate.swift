//
//  PropertyDelegate.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/03.
//

import Foundation

protocol PropertyDelegate{
    func propertyAction(action: PropertyViewAction)
}

enum PropertyViewAction{
    case colorChangedTapped
    case alphaPlusTapped
    case alphaMinusTapped
}
