//
//  HUDIndicatorProvider.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/9/28.
//  Copyright © 2020 Harley. All rights reserved.
//

import Foundation
import UIKit

/// 默认的状态视图管理器
/// 针对 progress 的状态返回一个 HUDRingProgressView
/// 针对非 progress 的状态返回一个 UIActivityIndicatorView
open class HUDIndicatorProvider: IndicatorProvider {
    
    public init() {}
    
    open func makeProgressIndicatorView(options: HUDStatusView.Options) -> StatusIndicatorView {
        HUDRingProgressView(
            size: options.indicatorSize.height,
            progressColor: options.progressColor,
            textColor: options.mainColor
        )
    }
    
    open func makeNormalIndicatorView(options: HUDStatusView.Options) -> StatusIndicatorView {
        let indicator = SystenIndicatorView(size: options.indicatorSize, color: options.mainColor)
        indicator.snp.makeConstraints {
            $0.size.equalTo(options.indicatorSize)
        }
        return indicator
    }
    
    public weak var indicatorView: StatusIndicatorView?
    public weak var progressView: StatusIndicatorView?
    
    public func retriveIndicator(for status: Status, in responder: StatusResponder) -> StatusIndicatorView {
        let options = (responder as? HUDResponder)?.viewOptions ?? HUDStatusView.Options()
        if status.progress == nil {
            if let indicator = indicatorView {
                return indicator
            }
            let indicator = makeNormalIndicatorView(options: options)
            indicatorView = indicator
            return indicator
        } else {
            if let progress = progressView {
                return progress
            }
            let progress = makeProgressIndicatorView(options: options)
            progressView = progress
            return progress
        }
    }
    
}
