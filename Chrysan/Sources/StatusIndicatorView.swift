//
//  StatusIndicatorView.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/9/27.
//  Copyright © 2020 Harley. All rights reserved.
//

import Foundation
import UIKit

public protocol StatusIndicatorView: UIView {
    func updateStatus(from: Status, to new: Status)
}

public extension StatusIndicatorView {
    func updateStatus(from: Status, to new: Status) {}
}

/// 进度条视图协议
public protocol ProgressIndicatorView: UIView {
    
    /// 进度值，范围 0~1
    var progress: CGFloat { get set }
}

/// Indicator 管理器
public protocol IndicatorProvider {
    func retriveIndicator(for status: Status, in responder: StatusResponder) -> StatusIndicatorView
}

