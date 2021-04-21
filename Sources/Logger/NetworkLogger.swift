//
//  File.swift
//  
//
//  Created by Nicolò Pasini on 21/04/21.
//

import OSLogger
import Foundation

public class NetworkLogger {

    static let logger = Logger()

    public static func infoLog(message: String, access: LogAccessLevel = LogAccessLevel.private, fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) {
        logger.log(category: LogCategory.network.rawValue, message: message, access: access, type: .info, fileName: fileName, functionName: functionName, lineNumber: lineNumber)
    }

    public static func debugLog(message: String, access: LogAccessLevel = LogAccessLevel.private, fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) {
        logger.log(category: LogCategory.network.rawValue, message: message, access: access, type: .debug, fileName: fileName, functionName: functionName, lineNumber: lineNumber)
    }

    public static func errorLog(message: String, access: LogAccessLevel = LogAccessLevel.private, fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) {
        logger.log(category: LogCategory.network.rawValue, message: message, access: access, type: .error, fileName: fileName, functionName: functionName, lineNumber: lineNumber)
    }

    public static func faultLog(message: String, access: LogAccessLevel = LogAccessLevel.private, fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) {
        logger.log(category: LogCategory.network.rawValue, message: message, access: access, type: .fault, fileName: fileName, functionName: functionName, lineNumber: lineNumber)
    }

    public static func defaultLog(message: String, access: LogAccessLevel = LogAccessLevel.private, fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) {
        logger.log(category: LogCategory.network.rawValue, message: message, access: access, type: .default, fileName: fileName, functionName: functionName, lineNumber: lineNumber)
    }
}
