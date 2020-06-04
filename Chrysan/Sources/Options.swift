//
//  Options.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/6/3.
//  Copyright © 2020 Harley. All rights reserved.
//

import Foundation
import UIKit

struct Options {
    
    
}

// 布局参数
public struct Layout {
    
    /// 距离锚点的偏移
    /// - Note: 当 position 设置为 fill 时将忽略该参数的值
    public var offset = CGPoint.zero
    
    /// 尺寸, 宽度或者高度任意一个维度设置成0，则不限制该维度下的尺寸
    /// - Note: 当 position 设置为 fill 时将忽略该参数的值
    public var size = CGSize(width: 60, height: 60)
    
    /// 状态视图距离遮罩层边缘的最小距离
    public var padding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    /// 位置，决定状态视图的锚点
    public enum Position {
        /// 居中, 此时锚点为中心点
        case center
        /// 顶部固定，此时锚点为顶部中心
        case top
        /// 底部固定，此时锚点为底部中心
        case bottom
        /// 填满整个遮罩层，此时没有锚点，Loading 视图始终与遮罩层一样大
        case fill
    }
    
    /// 状态视图的位置
    public var position: Position = .center
}
