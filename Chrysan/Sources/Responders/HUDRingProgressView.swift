//
//  HUDProgressView.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/9/28.
//  Copyright © 2020 Harley. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

open class HUDRingProgressView: UIView, StatusIndicatorView {
    
    public let progressView: ProgressIndicatorView = RingProgressView()
    
    public let textLabel = UILabel()
    
    private var textColor: UIColor = .white {
        didSet {
            textLabel.textColor = textColor
        }
    }
    
    private var ringSize: CGFloat = 40
    
    public init(
        size: CGFloat,
        progressColor: UIColor,
        textColor: UIColor = .white
    ) {
        super.init(frame: .zero)
        self.ringSize = size
        self.tintColor = progressColor
        self.textColor = textColor
        self.setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    open override var tintColor: UIColor! {
        didSet {
            progressView.tintColor = tintColor
        }
    }
    
    func setup() {
        addSubview(progressView)
        progressView.snp.makeConstraints {
            $0.size.equalTo(ringSize)
            $0.center.equalToSuperview()
            $0.top.bottom.equalToSuperview()
            $0.left.greaterThanOrEqualToSuperview()
            $0.right.lessThanOrEqualToSuperview()
        }
        
        addSubview(textLabel)
        textLabel.font = .systemFont(ofSize: 11)
        textLabel.textColor = textColor
        textLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    public func updateStatus(from: Status, to new: Status) {
        let progress = CGFloat(new.progress ?? 0)
        progressView.progress = progress
        textLabel.text = new.progressText ?? String(format: "%.0f%%", progress * 100)
    }
}
