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
    
    public typealias ID = String
    
    /// 状态唯一标识
    public let id: ID
    
    /// 显示该状态时展示的消息
    public var message: String?
    
    /// 进度状态对应的进度值，没有进度的状态为空
    public var progress: Double? = nil
    
    /// 进度值文本，如果进度条支持进度文本，指定后将会显示该值
    /// 默认显示格式: String(format: "%.0f%%", progress * 100)
    public var progressText: String? = nil
    
    public init(
        id: ID,
        message: String? = nil,
        progress: Double? = nil,
        progressText: String? = nil
    ) {
        self.id = id
        self.message = message
        self.progress = progress
        self.progressText = progressText
    }
}


extension Status: Equatable {
    
    public static func == (lhs: Status, rhs: Status) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Preset Status

public extension Status {
    
    /// 预设状态：静默状态
    static let idle = Status(id: .idle)
    
    /// 纯文本的状态，此时一般只显示文本内容
    /// - Parameter message: 文本内容，支持多行
    static func plain(message: String) -> Status {
        return Status(id: .plain, message: message)
    }

    /// 加载中状态, 所有的 loading 状态都具有相同的 id
    /// - Parameter message: 自定义消息内容
    static func loading(message: String? = nil) -> Status {
        return Status(id: .loading, message: message)
    }

    /// 预设状态：带进度的状态，所有的 progress 状态都具有相同的 id
    static func progress(
        message: String? = nil,
        progress: Double,
        progressText: String? = nil
    ) -> Status {
        return Status(
            id: .progress,
            message: message,
            progress: progress,
            progressText: progressText
        )
    }
    
    /// 预设状态：成功
    static func success(message: String? = nil) -> Status {
        return Status(id: .success, message: message)
    }
    
    /// 预设状态：失败
    static func failure(message: String? = nil) -> Status {
        return Status(id: .failure, message: message)
    }
}

public extension Status.ID {
    static let idle = "chrysan.status.idle"
    static let plain = "chrysan.status.plain"
    static let loading = "chrysan.status.loading"
    static let progress = "chrysan.status.progress"
    static let success = "chrysan.status.success"
    static let failure = "chrysan.status.failure"
}
