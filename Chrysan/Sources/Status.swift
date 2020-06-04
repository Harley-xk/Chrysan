//
//  Status.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/6/4.
//  Copyright © 2020 Harley. All rights reserved.
//

import Foundation
import UIKit

/// 状态
public enum Status {
    /// 加载中，无进度
    case loading
    /// 加载中，有进度
    case progress(Double)
    /// 单一固定状态
    case state(State)
    /// 无状态，此时隐藏
    case idle
}

/// 单一静态状态
public struct State {
    public init(uuid: UUID = .init()) {
        id = uuid
    }
    /// 标识符，没有实际意义，只是用来区分不同的状态
    internal var id: UUID
}

public protocol ChrysanCompatiable {
    
}

/// 加载状态协议
public protocol LoadingCompatiable: ChrysanCompatiable {
    /// 开始加载状态
    func beginLoading()
    /// 结束加载状态
    func endLoading()
}

/// 加载进度协议
public protocol ProgressConmpatiable: ChrysanCompatiable {
    /// 通过百分比更新状态
    func update(percent: Double)
}

/// 静态状态协议
public protocol StateCompatiable: ChrysanCompatiable {
    func update(state: State)
}

public extension Chrysan {
    
    func showLoading(message: String? = nil) {
        
        let loadingView = loadingViewFactory.makeLoadingView()
        maskView?.addSubview(loadingView)
        
        
    }
    
    func showProgress(percent: Double, message: String? = nil) {
        
    }
    
    func showState(_ state: State, message: String? = nil) {
        
    }
    
    func hide() {
        guard case .idle = status else {
            return
        }
        maskView?.subviews.forEach { $0.removeFromSuperview() }
        maskView?.isHidden = true
    }
}
