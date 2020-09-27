//
//  HUDResponder.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/9/25.
//  Copyright © 2020 Harley. All rights reserved.
//

import Foundation
import UIKit

/// HUD 风格的状态响应器
open class HUDResponder: StatusResponder {
    
    public init() {}
    
    /// 宿主 chrysan 视图
    public private(set) weak var host: Chrysan?
        
    /// 宿主 chrysan 视图
    public private(set) var animator: UIViewPropertyAnimator?

    /// 显示状态的视图
    public private(set) var statusView: HUDStatusView?
        
    open func changeStatus(
        from current: Status,
        to new: Status,
        for host: Chrysan,
        finished: @escaping () -> ()
    ) {
        if new != .idle, statusView == nil {
            layoutStatusView(in: host)
        }
        
        // 准备执行动画，设置相关视图的起始状态
        prepareAnimation(for: host, from: current, to: new)

        let timming = UISpringTimingParameters(dampingRatio: 0.5)
        let animator = UIViewPropertyAnimator(duration: 0.25, timingParameters: timming)
        animator.addAnimations {
            self.runAnimation(for: host, from: current, to: new)
        }
        animator.addCompletion { (position) in
            if position == .end {
                finished()
            }
        }
        animator.startAnimation()
    }
    
    // MARK: - Layout
    /// 布局属性，修改后从下一次显示 HUD 开始生效
    open var layout = HUDLayout() {
        didSet {
            // 修改布局属性，移除 HUD
            if let view = statusView {
                view.removeFromSuperview()
                statusView = nil
            }
        }
    }
    
    open func layoutStatusView(in chrysan: Chrysan) {
        let view = HUDStatusView(backgroundStyle: .dark)
        chrysan.addSubview(view)
        view.snp.removeConstraints()
        view.snp.makeConstraints {
            switch layout.position {
            case .center:
                $0.centerX.equalToSuperview().offset(layout.offset.x)
                $0.centerY.equalToSuperview().offset(layout.offset.y)
            case .top:
                $0.centerX.equalToSuperview().offset(layout.offset.x)
                $0.top.equalTo(chrysan.safeAreaLayoutGuide.snp.top).offset(layout.offset.y)
            case .bottom:
                $0.centerX.equalToSuperview().offset(layout.offset.x)
                $0.bottom.equalTo(chrysan.safeAreaLayoutGuide.snp.bottom).inset(layout.offset.y)
            }

            $0.left
                .greaterThanOrEqualTo(chrysan.safeAreaLayoutGuide.snp.left)
                .inset(layout.padding.left)
            $0.right
                .lessThanOrEqualTo(chrysan.safeAreaLayoutGuide.snp.right)
                .inset(layout.padding.right)
            $0.top
                .greaterThanOrEqualTo(chrysan.safeAreaLayoutGuide.snp.top)
                .inset(layout.padding.top)
            $0.bottom
                .lessThanOrEqualTo(chrysan.safeAreaLayoutGuide.snp.bottom)
                .inset(layout.padding.bottom)
            
            $0.width.greaterThanOrEqualTo(layout.minSize.width)
            $0.height.greaterThanOrEqualTo(layout.minSize.height)
        }
        statusView = view
    }

    // MARK: - Animations
    
    /// 动画控制器，控制动画的准备、执行和销毁
    open var hudAnimator = HUDAnimator()

    open func prepareAnimation(for chrysan: Chrysan, from: Status, to new: Status) {
        if from == .idle {
            chrysan.backgroundColor = UIColor.black.withAlphaComponent(0)
            statusView?.alpha = 0
            statusView?.transform = CGAffineTransform(scaleX: 0, y: 0)
        }
    }
    
    open func runAnimation(for chrysan: Chrysan, from: Status, to new: Status) {
        if from == .idle {
            chrysan.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            statusView?.alpha = 1
            statusView?.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.statusView?.messageLabel?.text = new.message
            self.statusView?.indicatorView?.startAnimating()
        } else if new == .idle {
            chrysan.backgroundColor = UIColor.black.withAlphaComponent(0)
            statusView?.alpha = 0
            statusView?.transform = CGAffineTransform(scaleX: 0, y: 0)
        } else {
        }
    }
}
