//
//  TvProgramResponse.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 01.03.23.
//

import Foundation  

struct TvProgramResponse: Codable {
    let startTime: String
    let recentAirTime: RecentAirTimeResponse
    let length: Int
    let name: String
}

struct RecentAirTimeResponse: Codable {
    let id: Int
    let channelID: Int
}
