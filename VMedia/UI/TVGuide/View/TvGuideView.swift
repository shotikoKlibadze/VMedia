//
//  TvGuideView.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 01.03.23.
//

import Foundation

protocol TvGuidView: Presentable {
    func channelViews(views: [ChannelView])
    func programCollection(collection: [ChannelProgramCollection])
    func tvProgramSchedule(schedule: [TvSchedule])
}

//To easily switch between UI Options
extension TvGuidView {
    func channelViews(views: [ChannelView]) {}
    func programCollection(collection: [ChannelProgramCollection]) {}
    func tvProgramSchedule(schedule: [TvSchedule]) {}
}

protocol TvGuideViewOutput: AnyObject {
    func viewDidLoad()
}
