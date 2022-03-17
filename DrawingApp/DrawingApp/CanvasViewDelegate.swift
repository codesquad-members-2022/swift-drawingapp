//
//  CanvasViewDelegate.swift
//  DrawingApp
//
//  Created by 안상희 on 2022/03/16.
//

import Foundation

protocol CanvasViewDelegate {
    /// CanvasView가 터치되면 해당 좌표를 VC에 넘김
    func canvasViewDidTouched(x: Double, y: Double)
}
