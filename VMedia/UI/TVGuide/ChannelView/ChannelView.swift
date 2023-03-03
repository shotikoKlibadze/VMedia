//
//  ChannelView.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 02.03.23.
//

import UIKit

class ChannelView: XibView {

    @IBOutlet weak var channelCallSignLabel: UILabel!
    @IBOutlet weak var channelNumberLabel: UILabel!
    
    func configure(with channel: TvChannel) {
        channelCallSignLabel.text = channel.callSign
        channelNumberLabel.text = String(channel.orderNum)
    }
}
