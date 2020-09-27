//
//  HUDAnimator.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/9/27.
//  Copyright © 2020 Harley. All rights reserved.
//

import Foundation
import UIKit

public protocol AnimatorProvider {
    var duraction: TimeInterval { get }
    func makeAnimator() -> UIViewPropertyAnimator
}

public struct SpringAnimatorProvider: AnimatorProvider {
    
    public var duraction: TimeInterval = 0.25
    public var dampingRatio: CGFloat = 0.5
    
    public func makeAnimator() -> UIViewPropertyAnimator {
        let timingParameters = UISpringTimingParameters(dampingRatio: dampingRatio)
        return UIViewPropertyAnimator(duration: duraction, timingParameters: timingParameters)
    }
}

public struct CubicAnimatorProvider: AnimatorProvider {
    
    public enum Curve {
        case animationCurve(UIView.AnimationCurve)
        case controlPoint(CGPoint, CGPoint)
    }
    
    public var curveStyle = Curve.animationCurve(.easeInOut)
    public var duraction: TimeInterval = 0.25

    public func makeAnimator() -> UIViewPropertyAnimator {
        let timingParameters: UICubicTimingParameters
        switch curveStyle {
        case .animationCurve(let curve):
            timingParameters = UICubicTimingParameters(animationCurve: curve)
        case let .controlPoint(p1, p2):
            timingParameters = UICubicTimingParameters(controlPoint1: p1, controlPoint2: p2)
        }
        
        return UIViewPropertyAnimator(duration: duraction, timingParameters: timingParameters)
    }
}

