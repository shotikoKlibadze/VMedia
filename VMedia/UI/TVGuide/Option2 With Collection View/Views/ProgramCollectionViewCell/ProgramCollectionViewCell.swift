//
//  ProgramCollectionViewCell.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 03.03.23.
//

import UIKit

final class ProgramCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var programNameLabel: UILabel!
    
    func configure(with program: TvProgram) {
        programNameLabel.text = program.name
    }
}
