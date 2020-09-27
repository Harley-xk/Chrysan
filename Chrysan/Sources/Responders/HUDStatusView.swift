//
//  ActivityIndicatorLoadingView.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/6/4.
//  Copyright © 2020 Harley. All rights reserved.
//

import UIKit

public final class HUDStatusView: UIView {
        
    convenience init(backgroundStyle style: UIBlurEffect.Style = .dark) {
        self.init()
        
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
        
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .red
        indicator.isHidden = false
        indicator.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        indicator.setContentHuggingPriority(.defaultHigh, for: .vertical)
        stack.addArrangedSubview(indicator)
        indicator.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        self.indicatorView = indicator
        
        let messageLabel = UILabel()
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
        messageLabel.setContentHuggingPriority(.required, for: .horizontal)
        messageLabel.setContentHuggingPriority(.required, for: .vertical)
        messageLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        messageLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        stack.addArrangedSubview(messageLabel)
        self.messageLabel = messageLabel
    }

    weak var indicatorView: UIActivityIndicatorView?
    weak var messageLabel: UILabel?
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
