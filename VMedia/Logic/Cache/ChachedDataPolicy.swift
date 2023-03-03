//
//  ChachedDataPolicy.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 02.03.23.
//

import Foundation

final class CachedDataPolicy {
    
    private static let calendar = Calendar(identifier: .gregorian)
    
    private static var maxCacheAgeInDays : Int {
        return 2
    }
    
    private init() {}
    
    static func validate(_ timeStamp: Date, against date: Date) -> Bool {
        guard let maxAge = calendar.date(byAdding: .day, value: maxCacheAgeInDays, to: timeStamp) else { return false }
        return date < maxAge
    }
}
