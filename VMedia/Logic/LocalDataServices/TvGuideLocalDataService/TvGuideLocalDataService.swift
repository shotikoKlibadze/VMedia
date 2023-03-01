//
//  TvGuideLocalDataService.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 01.03.23.
//

import Foundation

protocol TvGuideLocalDataService {
    func cache(channels: [TvChannel], date: Date, completion: @escaping (Error?) -> Void)
    func cache(programs: [TvProgram], date: Date, completion: @escaping (Error?) -> Void)
    func fetchChannels(completion: @escaping (Result<CachedChannels,Error>) -> Void)
    func fetchPrograms(completion: @escaping (Result<CachedPrograms,Error>) -> Void)
    func deleteCachedData(completion: @escaping (Error?) -> Void)
}

enum CachedPrograms {
    case empty
    case found(date: Date, programs: [TvProgram])
}

enum CachedChannels {
    case empty
    case found(date: Date, programs: [TvChannel])
}
