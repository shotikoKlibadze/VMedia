//
//  DateInfoView.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 05.03.23.
//

import UIKit

class DateInfoView: UICollectionReusableView {

    @IBOutlet private weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("awaken")
    }
}
