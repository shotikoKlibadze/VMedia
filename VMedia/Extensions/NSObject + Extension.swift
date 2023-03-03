//
//  NSObject + Extension.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 02.03.23.
//

import Foundation

extension NSObject {
    static func getClassName() -> String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

