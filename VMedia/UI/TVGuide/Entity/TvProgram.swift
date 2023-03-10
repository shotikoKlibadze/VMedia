//
//  TvProgram.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 01.03.23.
//

import Foundation

struct TvProgram: Hashable {
    
    let startTime: String
    let recentAirTime: RecentAirTime
    let length: Int
    let name: String
    var startDate: Date {
        return startTime.toDate()
    }
    var id: Int {
        return recentAirTime.id
    }
    
    init(with response: TvProgramResponse) {
        self.startTime = response.startTime
        self.recentAirTime = RecentAirTime(with: response.recentAirTime)
        self.length = response.length
        self.name = response.name
    }
    
    init(startTime: String, recentAirTime: RecentAirTime, length: Int, name: String) {
        self.startTime = startTime
        self.recentAirTime = recentAirTime
        self.length = length
        self.name = name
    }
}

extension TvProgram {
    
    static func == (lhs: TvProgram, rhs: TvProgram) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct RecentAirTime: Codable {
    
    let id: Int
    let channelID: Int
    
    init(with response: RecentAirTimeResponse) {
        self.id = response.id
        self.channelID = response.channelID
    }
    
    init(id: Int, channelID: Int) {
        self.id = id
        self.channelID = channelID
    }
}
