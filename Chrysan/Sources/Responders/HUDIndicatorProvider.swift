//
//  HUDIndicatorProvider.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/9/28.
//  Copyright © 2020 Harley. All rights reserved.
//

import Foundation
import UIKit

/// 默认的状态视图管理器
/// 针对 progress 的状态返回一个 HUDRingProgressView
/// 针对非 progress 的状态返回一个 UIActivityIndicatorView
open class HUDIndicatorProvider: IndicatorProvider {
        
    public init() {}
    
    open func makeProgressIndicatorView() -> StatusIndicatorView {
        return HUDRingProgressView()
    }
    
    open func makeNormalIndicatorView() -> StatusIndicatorView {
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
//        indicator.color = .red
        return indicator
    }
    
    public var indicatorView: StatusIndicatorView?
    public var progressView: StatusIndicatorView?
    
    public func retriveIndicator(for status: Status) -> StatusIndicatorView {
        if status.progress == nil {
            if indicatorView == nil { indicatorView = makeNormalIndicatorView() }
            return indicatorView!
        } else {
            if progressView == nil { progressView = makeProgressIndicatorView() }
            return progressView!
        }
    }
    
}
