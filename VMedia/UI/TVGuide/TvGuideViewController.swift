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
        addTimeStack()
    }
    
    func addTimeStack() {
        let timeStack = UIStackView()
        timeStack.axis = .horizontal
        for _ in 0...47 {
            let view = UIView()
            view.backgroundColor = .yellow
            view.translatesAutoresizingMaskIntoConstraints = false
            view.widthAnchor.constraint(equalToConstant: 150).isActive = true
            view.heightAnchor.constraint(equalToConstant: 50).isActive = true
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.green.cgColor
            timeStack.addArrangedSubview(view)
        }
        tvProgramsStackView.insertArrangedSubview(timeStack, at: 0)
        view.layoutIfNeeded()
    }
}
