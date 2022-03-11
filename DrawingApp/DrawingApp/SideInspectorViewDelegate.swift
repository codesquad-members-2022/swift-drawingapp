//
//  SideInspectorViewDelegate.swift
//  DrawingApp
//
//  Created by 안상희 on 2022/03/10.
//

import Foundation
import UIKit

protocol SideInspectorViewDelegate {
    /// 사각형 버튼이 탭되면 사각형 뷰 생성
    func sideInspectorView(_ sideInspectorView: SideInspectorView, buttonDidTapped: UIButton)
}
