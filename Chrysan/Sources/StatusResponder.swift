//
//  StatusResponder.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/9/25.
//  Copyright © 2020 Harley. All rights reserved.
//

import Foundation

/// 状态响应器，响应器需要自行维护相关状态的视图布局和动画效果
public protocol StatusResponder {
    
    /// Chrsan 即将变更状态的通知
    /// - Parameters:
    ///   - current: 当前即将改变的状态
    ///   - new: 改变后的状态，改变后的状态可能依然是之前的状态，只是 message 或者 progress 发生了变化
    ///   - host: 宿主 chrysan
    ///   - finished: 结束状态更新后的回调，responder 必须在状态变换动画执行完毕后调用该回调，以便 chrysan 执行后续操作
    func changeStatus(
        from current: Status,
        to new: Status,
        for host: Chrysan,
        finished: @escaping () -> ()
    )
    
    /// 从指定的 Chrysan 移除响应器
    /// - Note: 给 Chrysan 指定新的响应器时，旧的响应器的该方法会被触发
    ///         此时应该移除所有相关视图并清除占用的资源
    func remove(from chrysan: Chrysan)
}
