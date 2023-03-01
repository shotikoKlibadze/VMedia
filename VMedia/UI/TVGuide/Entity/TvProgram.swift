//
//  TvProgram.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 01.03.23.
//

import Foundation

struct TvProgram {
    let startTime: String
    let recentAirTime: RecentAirTime
    let length: Int
    let name: String
    
    init(with response: TvProgramResponse) {
        self.startTime = response.startTime
        self.recentAirTime = RecentAirTime(with: response.recentAirTime)
        self.length = response.length
        self.name = response.name
    }
}

struct RecentAirTime: Codable {
    let id: Int
    let channelID: Int
    
    init(with response: RecentAirTimeResponse) {
        self.id = response.id
        self.channelID = response.channelID
    }
}
