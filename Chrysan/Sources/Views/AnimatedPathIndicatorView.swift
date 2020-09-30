//
//  AnimatedPathIndicatorView.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/9/29.
//  Copyright © 2020 Harley. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

public class AnimatedPathIndicatorView: UIView, StatusIndicatorView {
    
    public class func successView(size: CGSize, color: UIColor) -> AnimatedPathIndicatorView {
        let successPaths = [
            [CGPoint(x: 0.04, y: 0.52), CGPoint(x: 0.32, y: 0.81), CGPoint(x: 0.95, y: 0.18)]
        ]
        return AnimatedPathIndicatorView(size: size, color: color, paths: successPaths)
    }
    
    public class func failureView(size: CGSize, color: UIColor) -> AnimatedPathIndicatorView {
        let failurePaths = [
            [CGPoint(x: 0.18, y: 0.18), CGPoint(x: 0.82, y: 0.82)],
            [CGPoint(x: 0.82, y: 0.18), CGPoint(x: 0.18, y: 0.82)],
        ]
        return AnimatedPathIndicatorView(size: size, color: color, paths: failurePaths)
    }

    weak var pathView: AnimatedPathView!
    
    public convenience init(
        size: CGSize,
        color: UIColor,
        paths: [AnimatedPathView.Path]
    ) {
        self.init()
        
        let pathView = AnimatedPathView(paths: paths, color: color)
        addSubview(pathView)
        pathView.snp.makeConstraints {
            $0.size.equalTo(size)
            $0.center.equalToSuperview()
            $0.top.bottom.equalToSuperview()
            $0.left.greaterThanOrEqualToSuperview()
            $0.right.lessThanOrEqualToSuperview()
        }
        self.pathView = pathView
    }
    
    public func updateStatus(from: Status, to new: Status) {
        pathView.startAnimation()
    }
}
