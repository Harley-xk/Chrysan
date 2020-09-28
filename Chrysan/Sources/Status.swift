//
//  Status.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/6/4.
//  Copyright © 2020 Harley. All rights reserved.
//

import Foundation
import UIKit

/// HUD 状态
public struct Status {
    
    /// 状态唯一标识
    let identifier = UUID()
    
    /// 显示该状态时展示的消息
    public var message: String?
    
    /// 进度状态对应的进度值，没有进度的状态为空
    public var progress: Double? = nil
    
    /// 进度值文本，如果进度条支持进度文本，指定后将会显示该值
    public var progressText: String?
    
    /// 预设状态：静默状态
    public static let idle = Status(message: nil)
    
    /// 预设状态，加载中
    public static let loading: Status = Status(message: nil)
    
    /// 指定消息内容的加载中状态
    /// - Parameter message: 自定义消息内容
    public static func loading(message: String) -> Status {
        var loading = Status.loading
        loading.message = message
        return loading
    }

    static let progress = Status(message: nil, progress: 0)
    
    /// 预设状态：带进度的状态
    public static func progress(message: String? = nil, progress: Double) -> Status {
        var status = Status.progress
        status.progress = progress
        status.message = message
        return status
    }
}

extension Status: Equatable {
    
    public static func == (lhs: Status, rhs: Status) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
