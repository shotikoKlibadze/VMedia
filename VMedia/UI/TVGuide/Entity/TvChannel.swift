//
//  TvChannel.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 01.03.23.
//

import Foundation

struct TvChannel: Hashable {
    
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
    
    init(orderNum: Int, accessNum: Int, callSign: String, id: Int) {
        self.orderNum = orderNum
        self.accessNum = accessNum
        self.callSign = callSign
        self.id = id
    }
}
