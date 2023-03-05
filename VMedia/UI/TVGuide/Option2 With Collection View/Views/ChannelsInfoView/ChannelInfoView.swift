//
//  ChannelReusableView.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 03.03.23.
//

import UIKit

final class ChannelInfoView: UICollectionReusableView {
    
    @IBOutlet weak var channelNumberLabel: UILabel!
    @IBOutlet private weak var channelLabel: UILabel!
    
    func configure(with channel: TvChannel) {
        channelLabel.text = channel.callSign
        channelNumberLabel.text = String(channel.orderNum)
    }
}
