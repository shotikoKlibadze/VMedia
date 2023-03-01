//
//  TvGuideInteractorProtocol.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 01.03.23.
//

import Foundation

protocol TvGuideInteractor: AnyObject {
    func fetchTvPrograms() async
    func fetchTvChannels() async
}

protocol TvGuideInteractorOutput: AnyObject {
    func didFetchTvChannels(tvChannels: [TvChannel])
    func didFetchTvProgramms(tvProgramms: [TvProgram])
    func errorFetchingTvProgramms(error: VMError)
    func errorFetchingTvChannels(error: VMError)
}
