//
//  ActivityIndicatorLoadingView.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/6/4.
//  Copyright © 2020 Harley. All rights reserved.
//

import UIKit

public typealias LoadingtCompatiableView = UIView & LoadingCompatiable

open class LoadingViewFactory {
    
    open var layout = Layout()
    
    public var view: LoadingtCompatiableView?
    
    open func makeLoadingView() -> LoadingtCompatiableView {
        if view == nil {
            view = ActivityIndicatorLoadingView()
        }
        return view!
    }
}

public final class ActivityIndicatorLoadingView: LoadingtCompatiableView {
    
    private weak var indicatorView: UIActivityIndicatorView?
    
    public func beginLoading() {
        indicatorView?.startAnimating()
    }
    
    public func endLoading() {
        indicatorView?.stopAnimating()
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
