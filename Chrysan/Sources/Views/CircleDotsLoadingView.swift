//
//  CircleDotsLoadingView.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/9/30.
//  Copyright © 2020 Harley. All rights reserved.
//

import UIKit

public class CircleDotsLoadingView: UIView, StatusIndicatorView {

    /// 外观选项
    public struct Options {
        /// 视图尺寸，默认与 Chrysan 配置同步
        public var size: CGSize = .zero
        /// Dots 颜色，默认与 Chrysan mainColor 同步
        public var color: UIColor = .white
        /// 每个点的大小，默认 5x5
        public var dotSize: CGFloat = 5
        /// 圆点数量，默认 5
        public var dotCount: Int = 12
        /// 旋转一圈的周期，默认 1s
        public var duraction: TimeInterval = 1
        
        public init() {}
    }
    
    public override class var layerClass: AnyClass {
        return CAReplicatorLayer.self
    }
    
    var options: Options = Options()
    var replicatorLayer: CAReplicatorLayer {
        return layer as! CAReplicatorLayer
    }
    
    weak var dotLayer: CALayer!
    
    public convenience init(options: Options) {
        self.init()

        self.options = options
        let dotSize = options.dotSize
        
        let dot = CALayer()
        dot.bounds = CGRect(x: 0, y: 0, width: dotSize, height: dotSize)
        dot.position = CGPoint(x: options.size.width / 2, y: dotSize / 2)
        dot.cornerRadius = dotSize / 2
        dot.backgroundColor = options.color.cgColor
        layer.addSublayer(dot)
        dotLayer = dot
        
        replicatorLayer.instanceCount = options.dotCount
        let angle = CGFloat.pi * 2 / CGFloat(options.dotCount)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        replicatorLayer.instanceDelay = options.duraction / Double(options.dotCount)
    }
    
    public func updateStatus(from: Status, to new: Status) {
        if new != .idle, !isAnimating {
            startAnimating()
        }
    }
    
    public private(set) var isAnimating = false
    
    public func startAnimating() {
        dotLayer.transform = CATransform3DMakeScale(0.2, 0.2, 1)

        let scale = CABasicAnimation(keyPath: "transform.scale")
        scale.fromValue = 1
        scale.toValue = 0.1
        scale.duration = options.duraction
        scale.repeatCount = .infinity
        dotLayer.add(scale, forKey: nil)
        
        isAnimating = true
    }
    
}
