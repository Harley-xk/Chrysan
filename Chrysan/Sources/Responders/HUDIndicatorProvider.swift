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
open class HUDIndicatorProvider: IndicatorProvider {
    
    public typealias IndicatorFactory = (HUDStatusView.Options) -> StatusIndicatorView
    
    public private(set) var factories: [Status.ID: IndicatorFactory] = [:]
    
    public init() {
        registerFactory(factory: makeLoadingIndicatorView, for: .loading)
        registerFactory(factory: makeProgressIndicatorView, for: .progress)
    }
    
    open func registerFactory(factory: @escaping IndicatorFactory, for statusId: Status.ID) {
        factories[statusId] = factory
    }
    
    open func makeProgressIndicatorView(options: HUDStatusView.Options) -> StatusIndicatorView {
        HUDRingProgressView(
            size: options.indicatorSize.height,
            progressColor: options.progressColor,
            textColor: options.mainColor
        )
    }
    
    open func makeLoadingIndicatorView(options: HUDStatusView.Options) -> StatusIndicatorView {
        let indicator = SystemActivityIndicatorView(size: options.indicatorSize, color: options.mainColor)
        indicator.snp.makeConstraints {
            $0.size.equalTo(options.indicatorSize)
        }
        return indicator
    }
    
    open func makeIndicatorView(for status: Status, with options: HUDStatusView.Options) -> StatusIndicatorView {
        let indicator: StatusIndicatorView
        if let factory = factories[status.id] {
            indicator = factory(options)
        } else {
            indicator = makeLoadingIndicatorView(options: options)
        }
        indicatorPool[status.id] = indicator
        return indicator
    }

    public private(set) var indicatorPool: [Status.ID: StatusIndicatorView] = [:]
    
    public func retriveIndicator(for status: Status, in responder: StatusResponder) -> StatusIndicatorView {
        let options = (responder as? HUDResponder)?.viewOptions ?? HUDStatusView.Options()
        if let indicator = indicatorPool[status.id] {
            return indicator
        } else {
            return makeIndicatorView(for: status, with: options)
        }
    }
    
}
