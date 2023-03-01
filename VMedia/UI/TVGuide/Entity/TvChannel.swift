//
//  TvChannel.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 01.03.23.
//

import Foundation

struct TvChannel {
    let orderNum: Int
    let accessNum: Int
    let callSign: String
    let id: Int
    
    init(with response: TvChannelResponse) {
        self.orderNum = response.orderNum
        self.accessNum = response.accessNum
        self.callSign = response.callSign
        self.id = response.id
    }
}
