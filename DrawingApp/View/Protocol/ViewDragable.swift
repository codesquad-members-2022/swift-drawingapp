//
//  ViewDragable.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/14.
//

import Foundation

protocol ViewDragable{
    func movingCenterPosition(x: Double, y: Double)
    func changeCenterPositon(x: Double, y: Double)
}
