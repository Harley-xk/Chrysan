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
public enum Status: Hashable {
    /// 无状态，此时隐藏
    case idle
    /// 命名状态，单一固定状态，不同的名称表示不同的状态
    case named(String)
    /// 进度状态
    case progress(Double)
    
    /// 预设状态，加载中
    public static let loading: Status = .named("com.chrysan.status.loading")
    
    /// 预设状态，成功
    public static let success: Status = .named("com.chrysan.status.success")
    
    /// 预设状态，出错
    public static let error: Status = .named("com.chrysan.status.error")
    
    /// 预设状态，警告
    public static let warning: Status = .named("com.chrysan.status.warning")
    
    /// 预设状态，信息
    public static let info: Status = .named("com.chrysan.status.info")

}

public protocol StatusResponsable {
        
    /// 是否可以响应指定的状态
    /// - Parameters:
    ///   - status: 目标状态
    ///   - chrysan: 宿主 chrysan
    func shouldResponse(to status: Status, for chrysan: Chrysan) -> Bool
    
    /// chrysan 即将改变状态
    /// - Parameters:
    ///   - chrysan: 当前 chrysan
    ///   - status: 目标状态
    ///   - message: 目标信息
    ///   - animator: 转换状态时 chrysan 将通过 animator 执行预设动画，
    ///               可以向 animator 添加 hud 自己的动画以同步执行
    func chrysan(
        _ chrysan: Chrysan,
        willChangeTo status: Status,
        message: String?,
        animator: UIViewPropertyAnimator?
    )    
}
