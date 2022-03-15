//
//  GusturePoint.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/15.
//

import Foundation

protocol GusturePoint {
    func tapGusturePoint(_ point: Point)
    func beganDragPoint(_ point: Point)
    func changedDragPoint(_ point: Point)
    func endedDragPoint(_ point: Point)
}
