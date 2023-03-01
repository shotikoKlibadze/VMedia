//
//  Presentable.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 01.03.23.
//

import UIKit

protocol Presentable: AnyObject {

    func toPresent() -> UIViewController?
}

// MARK: - UIViewController
extension UIViewController: Presentable {

    func toPresent() -> UIViewController? {
        return self
    }
}
