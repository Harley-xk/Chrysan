//
//  ActivityIndicatorLoadingView.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/6/4.
//  Copyright © 2020 Harley. All rights reserved.
//

import UIKit

public final class HUDStatusView: UIView {
    
    public private(set) var indicatorSize = CGSize(width: 40, height: 40)
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
        
        indicatorContainer = UIView()
        stack.addArrangedSubview(indicatorContainer)
        indicatorContainer.snp.makeConstraints {
            $0.height.equalTo(indicatorSize)
        }

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

    var indicatorProvider: IndicatorProvider = HUDIndicatorProvider()
    
    private weak var currentIndicatorView: StatusIndicatorView?
    
    weak var messageLabel: UILabel?

    public func prepreStatus(for chrysan: Chrysan, from: Status, to new: Status) {
        
        let isHidding = from != .idle && new == .idle

        // 隐藏 HUD 时不更新任何内容
        guard !isHidding else {
            return
        }
        
        let indicator = indicatorProvider.retriveIndicator(for: new)
        if currentIndicatorView !== indicator {
            currentIndicatorView?.removeFromSuperview()
            indicatorContainer.addSubview(indicator)
            indicator.snp.remakeConstraints {
                $0.edges.equalToSuperview()
//                $0.center.top.bottom.equalToSuperview()
//                $0.left.greaterThanOrEqualToSuperview()
//                $0.right.greaterThanOrEqualToSuperview()
            }
            currentIndicatorView = indicator
        }
    }
    
    public func updateStatus(for chrysan: Chrysan, from: Status, to new: Status) {
        
        let isHidding = from != .idle && new == .idle

        // 隐藏 HUD 时不更新任何内容
        guard !isHidding else {
            return
        }

        currentIndicatorView?.updateStatus(from: from, to: new)
        
        messageLabel?.text = new.message
    }
}
