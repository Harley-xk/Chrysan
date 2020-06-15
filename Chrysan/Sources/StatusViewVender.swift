//
//  LoadingFactory.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/6/11.
//  Copyright © 2020 Harley. All rights reserved.
//

import Foundation
import UIKit

public typealias StatusView = (UIView & StatusResponsable)

public protocol StatusViewVender {
    func shoudChangeView(from previousStatus: Status, to newStatus: Status) -> Bool
    
    func layoutView(in chrysan: Chrysan, for status: Status, message: String?) -> StatusView
}

open class HUDViewVender: StatusViewVender {
    public func shoudChangeView(from previousStatus: Status, to newStatus: Status) -> Bool {
        return false
    }

    public func layoutView(in chrysan: Chrysan, for status: Status, message: String?) -> StatusView {
        let view = ActivityIndicatorLoadingView(backgroundStyle: .dark)
        chrysan.addSubview(view)
        view.snp.removeConstraints()
        view.snp.makeConstraints {
            $0.left.top.greaterThanOrEqualToSuperview().inset(20)
            $0.size.greaterThanOrEqualTo(80)
            $0.center.equalToSuperview()
        }
        return view
    }

}
