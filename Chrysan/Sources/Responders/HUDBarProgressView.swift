//
//  HUDBarProgressView.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/9/28.
//  Copyright © 2020 Harley. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

public class HUDBarProgressView: UIView, StatusIndicatorView {
    
    public struct Options {
        public init() {}
        public var barSize = CGSize(width: 200, height: 15)
        public var barColor = UIColor.systemBlue
        public var barBackgroundColor = UIColor.darkGray
        public var textColor = UIColor.white
        public var textFont = UIFont.systemFont(ofSize: 11)
    }
    
    public class func makeBar(with options: Options) -> HUDBarProgressView {
        let barView = HUDBarProgressView(options: options)
        return barView
    }
    
    public let progressView: ProgressIndicatorView = HorizontalProgressBar()
    
    public let textLabel = UILabel()
    
    init(options: Options) {
        super.init(frame: CGRect(origin: .zero, size: options.barSize))
        self.options = options
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private var options: Options = Options()
    
    private func setup() {
        addSubview(progressView)
        progressView.snp.makeConstraints {
//            $0.center.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(10)
            $0.size.equalTo(options.barSize)
        }
        
        addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        updateOptions()
    }
    
    func updateOptions() {
        progressView.tintColor = options.barColor
        progressView.backgroundColor = options.barBackgroundColor
        textLabel.font = options.textFont
        textLabel.textColor = options.textColor
        setNeedsDisplay()
    }
    
    public func updateStatus(from: Status, to new: Status) {
        let progress = CGFloat(new.progress ?? 0)
        progressView.progress = progress
        textLabel.text = new.progressText ?? String(format: "%.0f%%", progress * 100)
    }
}
