//
//  ShapeView.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/9/29.
//  Copyright © 2020 Harley. All rights reserved.
//

import UIKit

public class AnimatedPathView: UIView {

    public typealias Path = [CGPoint]

    var paths: [Path] = []
    var color: UIColor = .white
    
    /// create an AnimatedPathView from path array
    /// - Parameter paths: vector point arrays form 0 ~ 1
    public convenience init(paths: [Path], color: UIColor) {
        self.init()
        backgroundColor = .clear
        self.paths = paths
        self.color = color
    }
    
    public override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    var shapeLayer: CAShapeLayer {
        return layer as! CAShapeLayer
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let path = UIBezierPath()
        
        for lines in paths {
            guard lines.count > 1 else {
                break
            }
            let first = lines.first!
            path.move(to: CGPoint(
                x: first.x * bounds.width,
                y: first.y * bounds.height
            ))
            for index in 1 ..< lines.count {
                let point = lines[index]
                path.addLine(
                    to: CGPoint(
                        x: point.x * bounds.width,
                        y: point.y * bounds.height
                    )
                )
            }
        }

        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.lineCap = .round
        shapeLayer.lineJoin = .round
        shapeLayer.path = path.cgPath
    }
    
    public func startAnimation() {
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 0.3
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = true
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        shapeLayer.add(animation, forKey: nil)
    }
    
}
