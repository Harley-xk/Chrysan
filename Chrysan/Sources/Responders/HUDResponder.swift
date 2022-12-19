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
public class HUDResponder: StatusResponder {
    
    /// 全局响应器
    public static let global: HUDResponder = HUDResponder()
    
    /// HUD 样式配置项，修改全局响应器的样式，可以全局生效
    public var viewOptions: HUDStatusView.Options
    
    public init(viewOptions: HUDStatusView.Options = .init()) {
        self.viewOptions = viewOptions
        
        // register default factories
        register(.ringIndicator, for: .loading)
        register(.ringProgress, for: .progress)
        register(.successPath, for: .success)
        register(.failurePath, for: .failure)
    }
    
    /// 宿主 chrysan 视图
    public private(set) weak var host: Chrysan?
        
    /// 动画属性配置器
    public var animatorProvider: AnimatorProvider = CubicAnimatorProvider()
    
    // MARK: Status View Pool
    
    /// 状态视图缓存池
    private(set) var statusViewPool: [UUID: HUDStatusView] = [:]
        
    /// 获取指定宿主的状态指示器视图，如果指示器不存在则自动创建
    /// - Parameters:
    ///   - chrysan: 目标宿主
    func fetchStatusView(
        for chrysan: Chrysan,
        createIfNotExists: Bool = true
    ) -> HUDStatusView {
        var statusView = statusViewPool[chrysan.id]
        if statusView == nil {
            statusView = layoutStatusView(in: chrysan)
            statusViewPool[chrysan.id] = statusView
        }
        return statusView!
    }
    
    /// 释放状态指示器
    func releaseStatusView(for chrysan: Chrysan) {
        guard let statusView = statusViewPool[chrysan.id] else {
            return
        }
        statusView.removeFromSuperview()
        statusViewPool[chrysan.id] = nil
    }
    
    // MARK: - Indicator Factories
    
    /// 已注册的状态视图工厂缓存，每次显示新的状态时都会通过已注册的工厂方法创建新的视图
    public private(set) var factories: [Status.ID: HUDIndicatorFactory] = [:]
    
    /// 为指定的状态 ID 注册一个工厂
    /// - Note: 统一额 ID 只能注册一个工厂方法，后注册的会覆盖之前注册的方法
    public func register(_ factory: HUDIndicatorFactory, for statusId: Status.ID) {
        factories[statusId] = factory
    }
    
    /// 为指定的状态 ID 注册一个工厂方法
    /// - Note: 统一额 ID 只能注册一个工厂方法，后注册的会覆盖之前注册的方法
    public func registerIndicator(for statusId: Status.ID, factory: @escaping HUDIndicatorFactory.Make) {
        factories[statusId] = HUDIndicatorFactory(factory)
    }
    
    // last running animator
    private weak var lastAnimator: UIViewPropertyAnimator?
    
    public func changeStatus(
        from current: Status,
        to new: Status,
        for host: Chrysan,
        finished: @escaping () -> ()
    ) {
        // if the last status transforming is not finished, force to stop
        if let last = lastAnimator, last.isRunning {
            last.stopAnimation(false)
            last.finishAnimation(at: .end)
        }
        
        // 准备执行动画，设置相关视图的起始状态
        prepareAnimation(for: host, from: current, to: new)
        
        let animator = animatorProvider.makeAnimator()
        animator.addAnimations {
            self.runAnimation(for: host, from: current, to: new)
        }
        animator.addCompletion { [weak self] (position) in
            if position == .end {
                finished()
                self?.animationFinished(for: host, from: current, to: new)
            }
        }
        animator.startAnimation()
        lastAnimator = animator
    }
    
    public func remove(from chrysan: Chrysan) {
        releaseStatusView(for: chrysan)
        factories.removeAll()
    }
    
    // MARK: - Layout
    
    /// 布局属性，修改后从下一次显示 HUD 开始生效
    public var layout = HUDLayout()
    
    private func layoutStatusView(in chrysan: Chrysan) -> HUDStatusView {
        let view = HUDStatusView(options: viewOptions)
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
        }
        return view
    }

    // MARK: - Animations
    
    private func prepareAnimation(for chrysan: Chrysan, from: Status, to new: Status) {
        let statusView = fetchStatusView(for: chrysan)
        statusView.prepreStatus(for: self, from: from, to: new)
        if from == .idle {
            chrysan.backgroundColor = UIColor.black.withAlphaComponent(0)
            statusView.alpha = 0
            statusView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }
    }
    
    private func runAnimation(for chrysan: Chrysan, from: Status, to new: Status) {
        
        let isShowing = from == .idle && new != .idle
        let isHidding = from != .idle && new == .idle
        
        let statusView = fetchStatusView(for: chrysan)

        if isShowing {
            chrysan.backgroundColor = viewOptions.maskColor
            statusView.alpha = 1
            statusView.transform = .identity
        } else if isHidding {
            chrysan.backgroundColor = viewOptions.maskColor.withAlphaComponent(0)
            statusView.alpha = 0
            statusView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }
        
        statusView.updateStatus(for: chrysan, from: from, to: new)
    }
    
    private func animationFinished(for chrysan: Chrysan, from: Status, to new: Status) {
        let isHidden = from != .idle && new == .idle

        if isHidden {
            releaseStatusView(for: chrysan)
        }
        
        lastAnimator = nil
    }
}
