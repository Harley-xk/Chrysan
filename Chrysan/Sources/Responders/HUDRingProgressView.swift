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
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    open override var tintColor: UIColor! {
        didSet {
            textLabel.textColor = tintColor
            progressView.tintColor = tintColor
        }
    }
    
    func setup() {
        addSubview(progressView)
        progressView.snp.makeConstraints {
            $0.edges.equalToSuperview().priority(.high)
            $0.width.equalTo(self.snp.height)
            $0.center.equalToSuperview()
        }
        
        addSubview(textLabel)
        textLabel.font = .systemFont(ofSize: 11)
        textLabel.textColor = tintColor
        textLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    public func updateStatus(from: Status, to new: Status) {
        progressView.progress = CGFloat(new.progress ?? 0)
        textLabel.text = String(format: "%.0f%%", (new.progress ?? 0) * 100)
    }
}
