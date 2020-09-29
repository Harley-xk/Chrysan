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
    /// 默认显示格式: String(format: "%.0f%%", progress * 100)
    public var progressText: String? = nil
}


extension Status: Equatable {
    
    public static func == (lhs: Status, rhs: Status) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

// MARK: - Preset Status

extension Status {
    
    /// 预设状态：静默状态
    public static let idle = Status(message: nil)
    
    static let loading: Status = Status(message: nil)
    static let progress = Status(message: nil, progress: 0)
    static let success = Status()

    /// 加载中状态, 所有的 loading 状态都具有相同的 id
    /// - Parameter message: 自定义消息内容
    public static func loading(message: String) -> Status {
        var loading = Status.loading
        loading.message = message
        return loading
    }

    /// 预设状态：带进度的状态，所有的 progress 状态都具有相同的 id
    public static func progress(
        message: String? = nil,
        progress: Double,
        progressText: String? = nil
    ) -> Status {
        var status = Status.progress
        status.progress = progress
        status.message = message
        status.progressText = progressText
        return status
    }
}
