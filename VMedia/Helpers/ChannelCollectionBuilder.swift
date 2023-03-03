//
//  ProgramTimeTableBuilder.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 02.03.23.
//

import Foundation

final class ChannelCollectionBuilder {
    
    private var programs = [TvProgram]()
    private var groupedPrograms = [ProgramId: [TvProgram]]()
    private var sortedPrograms = [ChannelProgramCollection]()
    
    func recieveTvPrograms(programs: [TvProgram]) {
        self.programs = programs
        groupPrograms()
    }
    
    func provideCollection() -> [ChannelProgramCollection] {
        return self.sortedPrograms
    }
}
private extension ChannelCollectionBuilder {
    
    func groupPrograms() {
        let groupByProgramId = Dictionary(grouping: programs) { program in
            return program.recentAirTime.channelID
        }
        groupedPrograms = groupByProgramId
        makeChannelPrograms()
    }
    
    func makeChannelPrograms() {
        groupedPrograms.forEach { (channelID, programs) in
            sortedPrograms.append(ChannelProgramCollection(id: channelID, programs: programs))
        }
    }
}
