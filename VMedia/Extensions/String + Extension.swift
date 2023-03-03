//
//  String + Extension.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 02.03.23.
//

import Foundation

extension String {
    
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: self)!
        return date
    }
}
