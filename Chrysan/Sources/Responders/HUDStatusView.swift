//
//  ActivityIndicatorLoadingView.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/6/4.
//  Copyright © 2020 Harley. All rights reserved.
//

import UIKit

public final class HUDStatusView: UIView {
    
    public class Options {
        /// 状态指示器的尺寸
        public var indicatorSize: CGSize
        /// 背景的视觉样式，默认为 UIBlurEffect(style: .dark)
        public var hudVisualEffect: UIVisualEffect
        /// HUD 圆角半径，默认 6
        public var hudCornerRadius: CGFloat
        /// 主色调，影响状态指示器、进度条颜色，默认白色
        public var mainColor: UIColor
        /// 背景遮罩层颜色
        public var maskColor: UIColor
        /// 文本颜色，影响说明文字、进度条文本等文字的颜色
        /// 留空时使用 mainColor
        public var textColor: UIColor {
            return _textColor ?? mainColor
        }
        /// 重新执行 TextColor，可以指定为 nil 以使用 mainColor
        public func setTextColor(_ color: UIColor?) {
            _textColor = color
        }
        /// 文本标签行数，0 表示无限制，默认 0
        public var messageLines: Int
        /// 文本字体，默认 systemFont(ofSize: 15)
        public var messageFont: UIFont
        /// 文本对齐方式，默认 center
        public var messageAlignment: NSTextAlignment
        
        private var _textColor: UIColor?
        
        public init(
            indicatorSize: CGSize = CGSize(width: 40, height: 40),
            hudVisualEffect: UIVisualEffect = UIBlurEffect(style: .dark),
            hudCornerRadius: CGFloat = 6,
            mainColor: UIColor = .white,
            maskColor: UIColor = .clear,
            textColor: UIColor? = nil,
            messageLines: Int = 0,
            messageFont: UIFont = .systemFont(ofSize: 15),
            messageAlignment: NSTextAlignment = .center
        ) {
            self.indicatorSize = indicatorSize
            self.hudVisualEffect = hudVisualEffect
            self.hudCornerRadius = hudCornerRadius
            self.mainColor = mainColor
            self.maskColor = maskColor
            self._textColor = textColor
            self.messageLines = messageLines
            self.messageFont = messageFont
            self.messageAlignment = messageAlignment
        }
    }
    
    public private(set) var indicatorContainer: UIView!
    private weak var messageLabel: UILabel?
    
    var options: Options = Options()
    
    convenience init(options: Options) {
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
        messageLabel.textColor = options.textColor
        messageLabel.numberOfLines = options.messageLines
        messageLabel.textAlignment = options.messageAlignment
        messageLabel.font = options.messageFont
        messageLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        messageLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        messageLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        messageLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        stack.addArrangedSubview(messageLabel)
        self.messageLabel = messageLabel        
    }
}


// MARK: - Status
extension HUDStatusView {
    
    public var currentIndicatorView: StatusIndicatorView? {
        return indicatorContainer.subviews.first as? StatusIndicatorView
    }
    
    public func prepreStatus(for responder: HUDResponder, from: Status, to new: Status) {
        
        let isHidding = from != .idle && new == .idle
        
        // 隐藏 HUD 时不更新任何内容
        guard !isHidding else {
            return
        }
        
        /// 切换不同的状态，且目标状态不是纯文本，需要重新创建 IndicatorView
        if from != new, new.id != .plain {
            indicatorContainer.isHidden = false
            let factory = responder.factories[new.id] ?? .ringIndicator
            let indicator = factory.make(options)
            currentIndicatorView?.removeFromSuperview()
            indicatorContainer.addSubview(indicator)
            indicator.snp.remakeConstraints {
                $0.center.equalToSuperview()
                $0.top.bottom.equalToSuperview()
                $0.left.greaterThanOrEqualToSuperview().priority(.high)
                $0.right.lessThanOrEqualToSuperview().priority(.high)
                $0.size.equalTo(options.indicatorSize).priority(.high)
            }
            indicator.setContentHuggingPriority(.required, for: .vertical)
            indicator.setContentHuggingPriority(.required, for: .horizontal)
        } else if new.id == .plain {
            indicatorContainer.isHidden = true
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
