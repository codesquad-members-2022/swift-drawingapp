//
//  PlaneDelegate.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/08.
//

protocol PlaneDelegate {
    func didChangeAlpha(to selectedRectangle:Rectangle)
    func didChangeColor(to seletedRectangle:Rectangle)
    func didAddRectangle(rectangle:Rectangle)
    func didFindRectangle(rectrangle:Rectangle)
}
