//
//  SideInspectorViewDelegate.swift
//  DrawingApp
//
//  Created by 안상희 on 2022/03/10.
//

import Foundation
import UIKit

protocol SideInspectorViewDelegate {
    /// 사각형 버튼이 탭 되는 것을 알리기 (SideInspectorView -> VC)
    func sideInspectorViewDidTappedRectangleButton()
    
    /// 색상 버튼이 탭 됨을 알림 (SideInspectorView -> VC)
    func sideInspectorViewDidTappedColorButton(_ sender: UIButton)
}
