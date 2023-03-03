//
//  ChannelProgramCollection.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 02.03.23.
//

import UIKit

class ChannelProgramCollection {
    
    let id: ProgramId
    let programs: [TvProgram]
    var arrangedViews: UIStackView {
        return arrangedProgramStack(programs: programs)
    }
    
    init(id: ProgramId, programs: [TvProgram]) {
        self.id = id
        self.programs = programs.sorted {
            $0.startDate < $1.startDate
        }
    }
    
    func arrangedProgramStack(programs: [TvProgram]) -> UIStackView {
        let stack = UIStackView()
        programs.forEach { tvProgram in
            let view = ProgramView()
            view.configure(with: tvProgram)
            stack.addArrangedSubview(view)
        }
        return stack
    }
}
