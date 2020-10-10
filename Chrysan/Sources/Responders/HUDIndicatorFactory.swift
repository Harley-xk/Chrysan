//
//  HUDIndicatorProvider.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/9/28.
//  Copyright © 2020 Harley. All rights reserved.
//

import Foundation
import UIKit

/// 状态视图工厂，自定义状态视图入口
public struct HUDIndicatorFactory {
    
    public typealias Make = (HUDStatusView.Options) -> StatusIndicatorView

    var make: Make
    
    /// 使用自定义闭包创建一个工厂
    public init(_ make: @escaping Make) {
        self.make = make
    }
    
    /// 环形 Loading 视图，带旋转伸缩动画效果，默认设置
    public static let ringIndicator = HUDIndicatorFactory {
        var ringOptions = RingIndicatorView.Options()
        ringOptions.size = $0.indicatorSize
        ringOptions.color = $0.mainColor
        let indicator = RingIndicatorView(options: ringOptions)
        return indicator
    }
    
    /// 圆形点阵 Loading 图，带旋转缩放动画
    public static let circleDots = HUDIndicatorFactory {
        var options = CircleDotsLoadingView.Options()
        options.color = $0.mainColor
        options.size = $0.indicatorSize
        return CircleDotsLoadingView(options: options)
    }
    
    /// 系统风格的 Loading 图，即 UIActivityIndicatorView
    public static let systemIndicator = HUDIndicatorFactory {
        SystemActivityIndicatorView(size: $0.indicatorSize, color: $0.mainColor)
    }
    
    /// 使用静态图片的状态指示器
    public static func imageIndicator(image: UIImage) -> HUDIndicatorFactory {
        return HUDIndicatorFactory {
            let imageView = UIImageView(image: image)
            imageView.tintColor = $0.mainColor
            return imageView
        }
    }
    
    /// 使用 GIF 动图的状态指示器
    public static func gifIndicator(data: Data, repeatCount: AnimatedImageView.RepeatCount = .infinite) -> HUDIndicatorFactory {
        return HUDIndicatorFactory { _ in
            let imageView = AnimatedImageView(data: data, repeatCount: repeatCount)
            return imageView
        }
    }
    
    /// 使用系统图标的静态图片指示器，支持 iOS 13+
    @available(iOS 13.0, *)
    public static func imageIndicator(systemName: String, withConfiguration configuration: UIImage.Configuration? = nil) -> HUDIndicatorFactory {
        return HUDIndicatorFactory {
            let image = UIImage(systemName: systemName, withConfiguration: configuration)
            let imageView = UIImageView(image: image)
            imageView.tintColor = $0.mainColor
            return imageView
        }
    }
    
    /// 环形进度条，默认设置
    public static let ringProgress = HUDIndicatorFactory {
        HUDRingProgressView(
            size: $0.indicatorSize.height,
            progressColor: $0.mainColor,
            textColor: $0.textColor
        )
    }
    
    /// 成功打勾视图，带动画，默认设置
    public static let successPath = HUDIndicatorFactory {
        AnimatedPathIndicatorView.successView(size: $0.indicatorSize, color: $0.mainColor)
    }
    
    /// 错误打叉视图，带动画，默认设置
    public static let failurePath = HUDIndicatorFactory {
        AnimatedPathIndicatorView.failureView(size: $0.indicatorSize, color: $0.mainColor)
    }
    
    /// 横向条形进度条, 可以定制尺寸
    /// - Parameters:
    ///   - size: 进度条尺寸
    ///   - textColor: 进度条文本颜色，默认使用 StatusView.Options.textColor
    public static func barProgress(
        size: CGSize = CGSize(width: 150, height: 16),
        textColor: UIColor? = nil
    ) -> HUDIndicatorFactory {
        return HUDIndicatorFactory {
            var options = HUDBarProgressView.Options()
            options.textColor = textColor ?? $0.textColor
            options.barColor = $0.mainColor
            options.barBackgroundColor = $0.mainColor.withAlphaComponent(0.2)
            options.barSize = size
            return HUDBarProgressView.makeBar(with: options)
        }
    }
}
