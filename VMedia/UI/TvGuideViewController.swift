//
//  TvGuideViewController.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 28.02.23.
//

import UIKit

class TvGuideViewController: UIViewController, StoryboardLoadable, TvGuidView {
    
    @IBOutlet private weak var channelsView: UIView!
    @IBOutlet private weak var channelsStackView: UIStackView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var programsStackView: UIStackView!
    
    var isScrollingVertically = true
    var previousYOffset: CGFloat = 0
    var previousXOffset: CGFloat = 0
    
    let colors: [UIColor] = [.black, .blue, .brown, .cyan, .gray, .green, .yellow, .systemPink, .purple, .lightGray, .darkGray]
    
    weak var output: TvGuideViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TvGuide"
        output?.viewDidLoad()
        temporarySetup()
    }
    
    func temporarySetup() {
        configureChannelViews()
        configureProgramsViews()
        setupScrollView()
    }
    
    func setupScrollView() {
        scrollView.delegate = self
    }
    
    func configureChannelViews() {
        for _ in 0...30 {
            let view = UIView()
            view.backgroundColor = colors.randomElement()
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.red.cgColor
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(equalToConstant: 50).isActive = true
            channelsStackView.addArrangedSubview(view)
        }
    }
    
    func configureProgramsViews() {
        for _ in 0...30 {
            var stackView = UIStackView()
            stackView.axis = .horizontal
            for _ in 0...10 {
                let view = UIView()
                view.backgroundColor = colors.randomElement()
                view.layer.borderWidth = 1
                view.layer.borderColor = UIColor.red.cgColor
                view.translatesAutoresizingMaskIntoConstraints = false
                view.widthAnchor.constraint(equalToConstant: 300).isActive = true
                stackView.addArrangedSubview(view)
            }
            programsStackView.addArrangedSubview(stackView)
        }
    }
    
    func scrollViewScrolledVertically(scrollView: UIScrollView) {
       // scrollView.contentOffset = CGPoint(x: 0, y:scrollView.contentOffset.y)
    }
    
    func scrollViewScrolledHorizontally(scrollView: UIScrollView) {
       // scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y:0)
    }
}

extension TvGuideViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        isScrollingVertically ? scrollViewScrolledVertically(scrollView: scrollView) : scrollViewScrolledHorizontally(scrollView: scrollView)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let verticalOffset = scrollView.contentOffset.y
        let horizontalOffset = scrollView.contentOffset.x
        isScrollingVertically = verticalOffset >= horizontalOffset
//        print("vert,",verticalOffset)
//        print("hor,",horizontalOffset)
        print(isScrollingVertically)
    }
   
}
