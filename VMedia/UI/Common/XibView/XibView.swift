//
//  XibView.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 02.03.23.
//

import UIKit

class XibView: UIView {
    
    @IBOutlet private weak var contentView: UIView!
    
    // MARK: - Initialization and logic
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    public func setupView() {
        let bundle = Bundle(for: classForCoder)
        let coderClass = String(describing: classForCoder)
        bundle.loadNibNamed(coderClass, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
