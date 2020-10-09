//
//  HUDLayout.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/6/3.
//  Copyright © 2020 Harley. All rights reserved.
//

import Foundation
import UIKit

// 布局参数
public struct HUDLayout {
    
    /// 位置，决定状态视图的锚点
    public enum Position {
        /// 居中, 此时锚点为中心点
        case center
        /// 顶部固定，此时锚点为顶部中心
        case top
        /// 底部固定，此时锚点为底部中心
        case bottom
    }
    
    /// 状态视图的位置
    public var position: Position = .center
    
    /// 距离锚点的偏移
    /// - Note: 当 position == .bottom 时，offset 在 y 轴的偏移方向为**自下向上**
    public var offset = CGPoint.zero
        
    /// 状态视图距离遮罩层边缘的最小距离
    public var padding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

}
