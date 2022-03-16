//
//  LoggerUtil.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/02.
//

import Foundation
import os.log

// debug 외 제외한 로그는 Console 앱에 남습니다.
class LoggerUtil {
    
    static let subsystem = Bundle.main.bundleIdentifier!
    
    static func debugLog(message: String) {
        Logger(subsystem: subsystem, category: "DrawingApp").debug("\(message)")
    }
    
    static func debugLog(model: ColoredRectangleProperty) {
        Logger(subsystem: subsystem, category: "DrawingApp").debug("\(model)")
    }
    
    static func debugLog(model: ImageRectangleProperty) {
        Logger(subsystem: subsystem, category: "DrawingApp").debug("\(model)")
    }
    
    static func errorLog(message: String) {
        Logger(subsystem: subsystem, category: "DrawingApp").error("\(message)")
    }
    
    static func errorLog(model: ColoredRectangleProperty) {
        Logger(subsystem: subsystem, category: "DrawingApp").error("\(model)")
    }
    
    static func errorLog(model: ImageRectangleProperty) {
        Logger(subsystem: subsystem, category: "DrawingApp").error("\(model)")
    }
    
    static func faultLog(message: String) {
        Logger(subsystem: subsystem, category: "DrawingApp").fault("\(message)")
    }
    
    static func faultLog(model: ColoredRectangleProperty) {
        Logger(subsystem: subsystem, category: "DrawingApp").fault("\(model)")
    }
    
    static func faultLog(model: ImageRectangleProperty) {
        Logger(subsystem: subsystem, category: "DrawingApp").fault("\(model)")
    }
}
