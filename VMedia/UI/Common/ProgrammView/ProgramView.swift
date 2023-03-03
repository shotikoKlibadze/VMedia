//
//  ProgramView.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 02.03.23.
//

import UIKit

class ProgramView: XibView {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var programNameLabel: UILabel!
    
    func configure(with program: TvProgram) {
        programNameLabel.text = program.name
        let relativeTimePercentage = program.length / Defaults.halfHour
        containerView.widthAnchor.constraint(equalToConstant: Defaults.timeTableWidth * CGFloat(relativeTimePercentage)).isActive = true
//        containerView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
}
