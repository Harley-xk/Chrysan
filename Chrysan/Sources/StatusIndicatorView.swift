//
//  StatusIndicatorView.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/9/27.
//  Copyright © 2020 Harley. All rights reserved.
//

import Foundation
import UIKit

public protocol StatusIndicatorView: UIView {
    func updateStatus(from: Status, to new: Status)
}

extension UIActivityIndicatorView: StatusIndicatorView {
    
    public func updateStatus(from: Status, to new: Status) {
        if from == .idle {
            startAnimating()
        }
    }
}
