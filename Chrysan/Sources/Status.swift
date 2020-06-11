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
    
    /// 预设状态，警告
    public static let info: Status = .named("com.chrysan.status.info")

}

public protocol StatusResponsable {
    /// chrysan 进入某个状态的事件， progress 状态会重复调用该方法
    func chrysan(_ chrysan: Chrysan, changeTo status: Status, message: String?)
    /// chrysan 结束某个状态的事件, 完成UI更新后必须调用 finished
    func chrysan(_ chrysan: Chrysan, willEnd status: Status, finished: @escaping () -> ())
}
