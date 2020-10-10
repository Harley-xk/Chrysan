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
    open var lineWidth: CGFloat = 3 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// 圆环的前景色
    open override var tintColor: UIColor! {
        didSet {
            background.strokeColor = tintColor.withAlphaComponent(0.2).cgColor
            setNeedsDisplay()
        }
    }
    
    private let progressLayer = CAShapeLayer()
    private let background = CAShapeLayer()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
    
    private func setupLayers() {
        
        backgroundColor = .clear

        tintColor = .systemBlue
        background.lineWidth = lineWidth
        background.fillColor = nil
        layer.addSublayer(background)

        progressLayer.lineWidth = lineWidth
        progressLayer.fillColor = nil
        layer.addSublayer(progressLayer)
        layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi / 2), 0, 0, -1)
    }

    open override func draw(_ rect: CGRect) {
        let circlePath = UIBezierPath(
            ovalIn: rect.insetBy(dx: lineWidth / 2, dy: lineWidth / 2)
        )
        background.path = circlePath.cgPath

        progressLayer.path = circlePath.cgPath
        progressLayer.lineCap = .round
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = progress
        progressLayer.strokeColor = tintColor.cgColor
    }
}
