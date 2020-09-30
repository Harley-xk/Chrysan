//
//  ActivityIndicatorLoadingView.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/6/4.
//  Copyright © 2020 Harley. All rights reserved.
//

import UIKit

public final class HUDStatusView: UIView {
    
    public struct Options {
        /// 状态指示器的尺寸
        public var indicatorSize: CGSize
        /// 背景的视觉样式，默认为 UIBlurEffect(style: .dark)
        public var hudVisualEffect: UIVisualEffect
        /// HUD 圆角半径，默认 6
        public var hudCornerRadius: CGFloat
        /// 主色调，影响状态指示器和说明文本，默认白色
        public var mainColor: UIColor
        /// 进度条颜色，默认 systemBlue
        public var progressColor: UIColor
        /// 文本标签行数，0 表示无限制，默认 0
        public var messageLines: Int
        /// 文本字体，默认 systemFont(ofSize: 15)
        public var messageFont: UIFont
        /// 文本对齐方式，默认 center
        public var messageAlignment: NSTextAlignment
        
        public init(
            indicatorSize: CGSize = CGSize(width: 40, height: 40),
            hudVisualEffect: UIVisualEffect = UIBlurEffect(style: .dark),
            hudCornerRadius: CGFloat = 6,
            mainColor: UIColor = .white,
            progressColor: UIColor = .white,
            messageLines: Int = 0,
            messageFont: UIFont = .systemFont(ofSize: 15),
            messageAlignment: NSTextAlignment = .center
        ) {
            self.indicatorSize = indicatorSize
            self.hudVisualEffect = hudVisualEffect
            self.hudCornerRadius = hudCornerRadius
            self.mainColor = mainColor
            self.progressColor = progressColor
            self.messageLines = messageLines
            self.messageFont = messageFont
            self.messageAlignment = messageAlignment
        }
    }
    
    public private(set) var indicatorContainer: UIView!
    
    var options: Options = Options()
    
    convenience init(options: Options = Options()) {
        self.init()
                
        self.options = options
        
        let blur = UIVisualEffectView(effect: options.hudVisualEffect)
        addSubview(blur)
        blur.layer.cornerRadius = options.hudCornerRadius
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
        
        let messageLabel = UILabel()
        messageLabel.textColor = options.mainColor
        messageLabel.numberOfLines = options.messageLines
        messageLabel.textAlignment = options.messageAlignment
        messageLabel.font = options.messageFont
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

    public func prepreStatus(for responder: HUDResponder, from: Status, to new: Status) {
        
        let isHidding = from != .idle && new == .idle

        // 隐藏 HUD 时不更新任何内容
        guard !isHidding else {
            return
        }
              
        /// 切换不同的状态，需要重新创建 IndicatorView
        if from != new {
            let indicator = indicatorProvider.retriveIndicator(for: new, in: responder)
            currentIndicatorView?.removeFromSuperview()
            indicatorContainer.addSubview(indicator)
            indicator.snp.remakeConstraints {
                $0.center.equalToSuperview()
                $0.top.bottom.equalToSuperview()
                $0.left.greaterThanOrEqualToSuperview()
                $0.right.lessThanOrEqualToSuperview()
                $0.size.equalTo(options.indicatorSize)
            }
            indicator.setContentHuggingPriority(.required, for: .vertical)
            indicator.setContentHuggingPriority(.required, for: .horizontal)
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
