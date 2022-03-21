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
    
    /// 색상 버튼이 탭 됨을 단순하게 VC에게 알린다. (SideInspectorView -> VC)
    func sideInspectorViewDidTappedColorButton()

    /// 슬라이더 값 변경 알림
    func sideInspectorViewSliderValueDidChanged(_ value: Float)
}
