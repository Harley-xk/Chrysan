//
//  RingProgressView.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/6/5.
//  Copyright © 2020 Harley. All rights reserved.
//

import UIKit

open class RingProgressView: UIView, ProgressIndicatorView {
    
    /// 进度值，0～1
    open var progress: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// 圆环宽度，默认 3
    open var ringWidth: CGFloat = 3 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// 圆环的前景色
    open override var tintColor: UIColor! {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private let progressLayer = CAShapeLayer()
    private let backgroundMask = CAShapeLayer()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
    
    private func setupLayers() {
        
        if backgroundColor == nil {
            backgroundColor = UIColor.darkGray
        }
        
        tintColor = .systemBlue
        backgroundMask.lineWidth = ringWidth
        backgroundMask.fillColor = nil
        backgroundMask.strokeColor = UIColor.black.cgColor
        layer.mask = backgroundMask

        progressLayer.lineWidth = ringWidth
        progressLayer.fillColor = nil
        layer.addSublayer(progressLayer)
        layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi / 2), 0, 0, -1)
    }

    open override func draw(_ rect: CGRect) {
        let circlePath = UIBezierPath(ovalIn: rect.insetBy(dx: ringWidth / 2, dy: ringWidth / 2))
        backgroundMask.path = circlePath.cgPath

        progressLayer.path = circlePath.cgPath
        progressLayer.lineCap = .round
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = progress
        progressLayer.strokeColor = tintColor.cgColor
    }
}
