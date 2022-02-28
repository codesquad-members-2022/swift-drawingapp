//
//  Log.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation
import OSLog

enum Log {
    static func info(_ message: String) {
        printLog(logType: .info, message: message)
    }
    static func debug(_ message: String) {
        printLog(logType: .debug, message: message)
    }
    static func fault(_ message: String) {
        printLog(logType: .fault, message: message)
    }
    static func print(_ message: String) {
        printLog(logType: .default, message: message)
    }
    static func error(_ message: String) {
        printLog(logType: .error, message: message)
    }
    
    private static func printLog(logType: OSLogType, message: String) {
        os_log(logType, log: .default, "\(message)")
    }
}
