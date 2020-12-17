//
//  Chrysan.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/6/1.
//  Copyright © 2020 Harley. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

public class Chrysan: UIView {
    
    /// 全局响应器，如果创建 Chrysan 时没有特别指定响应器，则缺省使用全局响应器
    static var responder: StatusResponder = HUDResponder.global
    
    // MARK: - Initialize
    
    /// 为指定的视图创建一个状态指示器 Chrysan
    /// - Parameters:
    ///   - targetView: 宿主视图
    ///   - responder: 可以自定义的状态响应器
    public static func make(
        for targetView: UIView,
        responder: StatusResponder? = nil
    ) -> Chrysan {
        let view = Chrysan()
        view.responder = responder ?? Chrysan.responder
        view.fill(in: targetView)
        view.isHidden = true
        return view
    }
    
    // MARK: - Status
    
    /// 当前状态
    public var status: Status = .idle
    
    /// 活跃状态，HUD 可见
    public var isActive: Bool {
        return !isHidden
    }
    
    /// 状态响应器，负责响应不同的状态，控制内容显示和布局
    /// - Note: Chrysan 本身只是一个空白的透明视图，只负责状态的切换和分发，你可以实现自己的 StatusResponder 来实现完全自定义的状态响应风格
    public private(set) var responder: StatusResponder! {
        didSet {
            oldValue?.remove(from: self)
        }
    }
    
    /// 尝试获取默认的 HUDResponder，不存在返回空
    public var hudResponder: HUDResponder? {
        return responder as? HUDResponder
    }
    
    /// 更新 Status
    /// - Parameter newStatus: 新的状态
    public func changeStatus(to newStatus: Status) {

        guard let _ = superview else {
            return
        }
        
        if newStatus != .idle, isHidden {
            isHidden = false
            superview?.bringSubviewToFront(self)
        }
        
        responder.changeStatus(from: status, to: newStatus, for: self) {
            self.didChangeStatus(to: newStatus)
        }
    }
    
    /// Chrysan 完成状态转换，会在动画完成后被调用
    public func didChangeStatus(to newStatus: Status) {
        self.status = newStatus
        
        if newStatus == .idle {
            self.isHidden = true
        }
    }
    
    /// 隐藏 Chrysan
    /// - Parameter delay: 延迟时间，单位：秒。在指定延迟之后隐藏，默认为 0，不延迟
    public func hide(afterDelay delay: TimeInterval = 0) {
        if delay > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(delay * 1000))) { [weak self] in
                self?.changeStatus(to: .idle)
            }
        } else {
            changeStatus(to: .idle)
        }
    }
    
    public func updateProgress(
        _ progress: Double,
        message: String? = nil,
        progressText: String? = nil
    ) {
        changeStatus(to: .progress(message: message, progress: progress, progressText: progressText))
    }
}

// MARK: - Layout
extension Chrysan {
    
    func fill(in target: UIView) {
        if #available(iOS 13.0, *) {
            let layoutGuide = UILayoutGuide()
            target.addLayoutGuide(layoutGuide)
            target.addSubview(self)
            self.snp.makeConstraints {
                $0.left.equalTo(layoutGuide.snp.left)
                $0.top.equalTo(layoutGuide.snp.top)
                $0.size.equalToSuperview()
            }
        } else {
            if let scroll = target as? UIScrollView, let superview = scroll.superview {
                superview.addSubview(self)
            } else {
                target.addSubview(self)
            }
            self.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }
}

// MARK: - Short Cuts

public extension Chrysan {
    
    private func forceHUD() {
        guard hudResponder != nil else {
            responder = HUDResponder()
            return
        }
    }
    
    /// show HUD for speciffied status
    /// - Parameters:
    ///   - status: target status
    ///   - delay: auto hide hud after delay seconds if set
    func showHUD(_ status: Status, hideAfterDelay delay: TimeInterval? = nil) {
        forceHUD()
        
        changeStatus(to: status)
        
        if let delay = delay {
            hide(afterDelay: delay)
        }
    }
    
    /// show HUD for progress ststus
    /// - Parameters:
    ///   - progress: complete fraction for current task
    ///   - message: message for current status
    func showHUD(progress: Double, message: String? = nil, progressText: String? = nil) {
        forceHUD()
        changeStatus(to: .progress(message: message, progress: progress, progressText: progressText))
    }
}

public extension UIView {
    
    var chrysan: Chrysan {
        // DO NOT try to get Chrysan from it's self!
        if self is Chrysan {
            fatalError("DO NOT try to get Chrysan from its self!")
        }
        
        if #available(iOS 13.0, *) {
        } else if self is UIScrollView, let superview = self.superview {
            return superview.chrysan
        }
        
        if let chrysan = subviews.first(where: { $0 is Chrysan }) as? Chrysan {
            return chrysan
        } else {
            return Chrysan.make(for: self)
        }
    }
}

public extension UIViewController {
    var chrysan: Chrysan {
        return view.chrysan
    }
}
