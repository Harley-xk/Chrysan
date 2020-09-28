//
//  ActivityIndicatorLoadingView.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/6/4.
//  Copyright © 2020 Harley. All rights reserved.
//

import UIKit

public final class HUDStatusView: UIView {
    
    public var indicatorSize = CGSize(width: 40, height: 40)
    public private(set) var indicatorContainer: UIView!
    
    convenience init(
        backgroundStyle style: UIBlurEffect.Style = .dark,
        indicatorSize: CGSize
    ) {
        self.init()
        
        self.indicatorSize = indicatorSize
        
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: style))
        addSubview(blur)
        blur.layer.cornerRadius = 6
        blur.clipsToBounds = true
        blur.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        addSubview(stack)
        stack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(15)
        }
        
        let indicatorContainer = UIView()
        stack.addArrangedSubview(indicatorContainer)
        indicatorContainer.snp.makeConstraints {
            $0.height.equalTo(indicatorSize).priority(.high)
        }

        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .red
        indicator.isHidden = false
        indicatorContainer.addSubview(indicator)
        indicator.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.indicatorView = indicator
        
        let progressView = RingProgressView()
        indicatorContainer.addSubview(progressView)
        progressView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(indicatorSize)
            $0.top.bottom.equalToSuperview()
            $0.left.greaterThanOrEqualTo(indicatorContainer.snp.left)
            $0.right.lessThanOrEqualTo(indicatorContainer.snp.right)
        }
        self.progressView = progressView

        let messageLabel = UILabel()
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.setContentHuggingPriority(.required, for: .horizontal)
        messageLabel.setContentHuggingPriority(.required, for: .vertical)
        messageLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        messageLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        stack.addArrangedSubview(messageLabel)
        self.messageLabel = messageLabel
    }

    weak var indicatorView: StatusIndicatorView?
    weak var progressView: StatusIndicatorView?
    
    weak var messageLabel: UILabel?

    public func updateStatus(for chrysan: Chrysan, from: Status, to new: Status) {
        
//        let isShowing = from == .idle && new != .idle
        let isHidding = from != .idle && new == .idle

        // 隐藏 HUD 时不更新任何内容
        guard !isHidding else {
            return
        }
        
        let hasProgress = new.progress != nil
        progressView?.isHidden = !hasProgress
        indicatorView?.isHidden = hasProgress
        
        if hasProgress {
            progressView?.updateStatus(from: from, to: new)
        } else {
            indicatorView?.updateStatus(from: from, to: new)
        }
        
        messageLabel?.text = new.message
    }
}
