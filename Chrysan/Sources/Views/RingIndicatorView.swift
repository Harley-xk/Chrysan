//
//  RingIndicatorView.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/9/30.
//  Copyright © 2020 Harley. All rights reserved.
//

import UIKit
import SnapKit

/// 环形 Loading 图
public class RingIndicatorView: UIView, StatusIndicatorView {
    
    /// Loading 图可配置属性
    public struct Options {
        /// 尺寸
        public var size: CGSize = .zero
        /// 颜色
        public var color: UIColor = .white
        /// 线宽
        public var lineWidth: CGFloat = 3
        /// 最短比例
        public var percent: CGFloat = 0.6
        /// 是否执行伸缩动画
        public var stretchAnimation = true
        /// 转一圈需要的时间
        public var duraction: TimeInterval = 1
        
        public init() {}
    }
    
    var shapeLayer = CAShapeLayer()
    
    var options: Options = Options()
    
    public convenience init(options: Options) {
        self.init()
        
        self.options = options
        
        shapeLayer.strokeColor = options.color.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = options.lineWidth
        shapeLayer.strokeEnd = options.percent
        
        let path = UIBezierPath(ovalIn: CGRect(origin: .zero, size: options.size))
        shapeLayer.path = path.cgPath
        shapeLayer.lineCap = .round
        
        layer.addSublayer(shapeLayer)
    }
    
    public func updateStatus(from: Status, to new: Status) {
        if new != .idle, !isAnimating {
            startAnimating()
        }
    }
    
    public private(set) var isAnimating = false

    public func startAnimating() {
        
        // stretchAnimation needs a longer duraction
        let duraction = options.duraction * (options.stretchAnimation ? 1.5 : 1)
        
        let rotate = CABasicAnimation(keyPath: "transform.rotation")
        rotate.duration = duraction
        rotate.fromValue = 0
        rotate.toValue = CGFloat.pi * 2
        rotate.repeatCount = .infinity
        layer.add(rotate, forKey: nil)
        
        if options.stretchAnimation {
            let startAnimate = CABasicAnimation(keyPath: "strokeStart")
            startAnimate.fromValue = -0.5
            startAnimate.toValue = 1
            
            let endAnimate = CABasicAnimation(keyPath: "strokeEnd")
            endAnimate.fromValue = 0.0
            endAnimate.toValue = options.percent * 2
            
            let strokeAnimateGroup = CAAnimationGroup()
            strokeAnimateGroup.duration = duraction
            strokeAnimateGroup.repeatCount = .infinity
            strokeAnimateGroup.animations = [startAnimate, endAnimate]
            shapeLayer.add(strokeAnimateGroup, forKey: nil)
        }
        
        isAnimating = true
    }
}
