//
//  LoggerUtil.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/02.
//

import Foundation
import os.log

// debug를 제외한 로그는 Console.app에 남습니다.
class LoggerUtil {
    
    static let subsystem = Bundle.main.bundleIdentifier!
    
    static func debugLog(message: String) {
        Logger(subsystem: subsystem, category: "DrawingApp").debug("\(message)")
    }
    
    static func debugLog(model: ViewRandomProperty) {
        Logger(subsystem: subsystem, category: "DrawingApp").debug("\(model)")
    }
    
    static func errorLog(message: String) {
        Logger(subsystem: subsystem, category: "DrawingApp").error("\(message)")
    }
    
    static func errorLog(model: ViewRandomProperty) {
        Logger(subsystem: subsystem, category: "DrawingApp").error("\(model)")
    }
    
    static func faultLog(message: String) {
        Logger(subsystem: subsystem, category: "DrawingApp").fault("\(message)")
    }
    
    static func faultLog(model: ViewRandomProperty) {
        Logger(subsystem: subsystem, category: "DrawingApp").fault("\(model)")
    }
}
