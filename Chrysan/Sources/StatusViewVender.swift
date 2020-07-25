//
//  LoadingFactory.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/6/11.
//  Copyright © 2020 Harley. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

public typealias StatusView = (UIView & StatusResponsable)

public protocol StatusViewVender {
    func layoutView(in chrysan: Chrysan, for status: Status, message: String?, animator: UIViewPropertyAnimator?) -> StatusView
}

open class HUDViewVender: StatusViewVender {
    
    open func layoutView(in chrysan: Chrysan, for status: Status, message: String?, animator: UIViewPropertyAnimator?) -> StatusView {
        let view = HUDStatusView(backgroundStyle: .dark)
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
