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

public class Chrysan {
    
    // MARK: - Initialize
    
    /// 为指定的视图创建菊花
    public static func make(for targetView: UIView) -> Chrysan {
        let mask = ChrysanMaskView()
        mask.fill(in: targetView)
        return Chrysan(mask: mask)
    }
    
    private init(mask: ChrysanMaskView) {
        maskView = mask
        maskView?.manager = self
    }
    
    /// 移动到新的 target 视图
    public func move(to newTarget: UIView) {
        let mask = maskView
        mask?.removeFromSuperview()
        mask?.fill(in: newTarget)
    }
    
    // MARK: - Mask View
    internal weak var maskView: ChrysanMaskView?

    // MARK: - Status
    
    public internal(set) var status: Status = .idle
    
    // MARK: - Loading View
        
    /// 注册 LoadingView 的工厂方法，用来返回显示 Loading 状态的 View，默认返回 ActivityIndicatorLoadingView
    public var loadingViewFactory: LoadingViewFactory = LoadingViewFactory()
    
    // MARK: - Progress View
    
    private var progressView: ProgressCompatiableView?
    private var progressViewFactory: () -> ProgressCompatiableView = { RingProgressView() }
    
    /// 注册 ProgressView 的工厂方法，用来返回显示 Progress 状态的 View，默认为 RingProgressView
    public func registerProgressViewFactory(factory: @escaping ()-> ProgressCompatiableView) {
        progressViewFactory = factory
    }
    
    // MARK: - StateView
    
    private var stateView: StateCompatiableView?
    private var stateViewFactory: () -> StateCompatiableView = { IconStateView() }
    
    /// 注册 ProgressView 的工厂方法，用来返回显示 Progress 状态的 View，默认为 RingProgressView
    public func registerStateViewFactory(factory: @escaping ()-> StateCompatiableView) {
        stateViewFactory = factory
    }
    
}

public extension UIView {
    
    var chrysan: Chrysan {
        // DO NOT try to get Chrysan from it's self!
        if self is ChrysanMaskView {
            fatalError("DO NOT try to get Chrysan from it's self!")
        }
        
        if let mask = subviews.first(where: { $0 is ChrysanMaskView }) as? ChrysanMaskView {
            return mask.manager!
        } else {
            return Chrysan.make(for: self)
        }
    }
}
