//
//  SystemActivityIndicatorView.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/9/29.
//  Copyright © 2020 Harley. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

public class SystemActivityIndicatorView: UIView, StatusIndicatorView {
    
    public private(set) weak var indicator: UIActivityIndicatorView!
    
    public convenience init(size: CGSize, color: UIColor) {
        self.init()
        let indicator: UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            indicator = UIActivityIndicatorView(style: .large)
            indicator.color = color
        } else {
            indicator = UIActivityIndicatorView(style: .whiteLarge)
        }
        addSubview(indicator)
        indicator.snp.makeConstraints {
            $0.size.equalTo(size)
            $0.center.equalToSuperview()
            $0.top.bottom.equalToSuperview()
            $0.left.greaterThanOrEqualToSuperview()
            $0.right.lessThanOrEqualToSuperview()
        }
        self.indicator = indicator
    }
    
    public func updateStatus(from: Status, to new: Status) {
        if new != .idle, !indicator.isAnimating {
            indicator.startAnimating()
        }
    }

}
