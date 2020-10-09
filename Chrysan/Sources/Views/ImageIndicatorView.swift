//
//  ImageIndicatorView.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/10/4.
//  Copyright © 2020 Harley. All rights reserved.
//

import UIKit
import ImageIO

extension UIImageView: StatusIndicatorView {
    
    public func updateStatus(from: Status, to new: Status) {
        if !isAnimating, new != .idle {
            startAnimating()
        }
    }
}
