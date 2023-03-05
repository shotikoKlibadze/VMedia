//
//  TvProgramBuilder.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 03.03.23.
//

import Foundation


struct TvSchedule {
    
    let tvChannel: TvChannel
    let programs: [TvProgram]
    
    init(tvChannel: TvChannel, programs: [TvProgram]) {
        self.tvChannel = tvChannel
        self.programs = programs.sorted(by: { $0.startDate < $1.startDate})
    }
}

final class TvProgramScheduleBuilder {
    
    private var programs: [TvProgram] = []
    private var channels: [TvChannel] = []
    private var tvProgramSchedule: [TvSchedule] = []
    
    var programSchedule: (([TvSchedule]) -> Void)?
    
    func recievePrograms(programs: [TvProgram]) {
        self.programs = programs
        buildProgram()
    }
    
    func recieveChannels(channels: [TvChannel]) {
        self.channels = channels
        buildProgram()
    }
    
    func buildProgram() {
        guard !programs.isEmpty && !channels.isEmpty else { return }
        for chanel in channels {
            var programs = [TvProgram]()
            programs = self.programs.filter({$0.recentAirTime.channelID == chanel.id})
            let schedule = TvSchedule(tvChannel: chanel, programs: programs)
            self.tvProgramSchedule.append(schedule)
        }
        programSchedule?(tvProgramSchedule)
    }
}
