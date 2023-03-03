//
//  TvGuideViewController.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 28.02.23.
//

import UIKit

class TvGuideViewController: UIViewController, StoryboardLoadable, TvGuidView {

    @IBOutlet private weak var tvProgramsStackView: UIStackView!
    @IBOutlet private weak var channelsStackView: UIStackView!

    weak var output: TvGuideViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TvGuide"
        output?.viewDidLoad()
    }
    
    func channelViews(views: [ChannelView]) {
        views.forEach { view in
            channelsStackView.addArrangedSubview(view)
        }
        channelsStackView.insertArrangedSubview(UIView(), at: 0)
    }
        
    func programCollection(collection: [ChannelProgramCollection]) {
        collection.forEach { collection in
            tvProgramsStackView.addArrangedSubview(collection.arrangedViews)
        }
    }
}
