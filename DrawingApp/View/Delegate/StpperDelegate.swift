//
//  StpperDelegate.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/16.
//

import Foundation

protocol StepperDelegate{
    func xPositionValueDidChange()
    func yPositionValueDidChange()
    func widthValueDidChange()
    func heightValueDidChange()
}
