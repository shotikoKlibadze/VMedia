//
//  TopLeftDecorationView.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 03.03.23.
//

import UIKit

final class TimeInfoView: UICollectionReusableView {
    
    @IBOutlet private weak var infoLabel: UILabel!
    
    func configure(with info: String) {
        infoLabel.text = info
    }
}
