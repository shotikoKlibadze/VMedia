//
//  TvChannelResponse.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 01.03.23.
//

import Foundation

struct TvChannelResponse: Codable {
    
    let orderNum: Int
    let accessNum: Int
    let callSign: String
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case orderNum, accessNum
        case callSign = "CallSign"
        case id
    }
}
