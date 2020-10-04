//
//  ChrysanExample.swift
//  Example
//
//  Created by Harley-xk on 2020/9/30.
//  Copyright © 2020 Harley. All rights reserved.
//

import Foundation
import Chrysan
import UIKit

struct SystemIndicatorExample: AnyChyrsanExample {
    let name = "System UIActivityIndicator"
    
    func show(in viewController: UIViewController) {
        let responder = viewController.chrysan.hudResponder
        responder?.register(.systemIndicator, for: .loading)
        viewController.chrysan.changeStatus(to: .loading(message: "正在加载"))
        viewController.chrysan.hide(afterDelay: 2)
    }
    
}

struct RingIndicatorExample: AnyChyrsanExample {
    
    var name: String
    
    private var stretch = true
    
    init(stretch: Bool) {
        self.stretch = stretch
        name = stretch ? "Ring Indicator with Stretching Animation" : "Ring Indicator"
    }
    
    var factory: HUDIndicatorFactory {
        return HUDIndicatorFactory {
            var ringOptions = RingIndicatorView.Options()
            ringOptions.size = $0.indicatorSize
            ringOptions.color = $0.mainColor
            ringOptions.stretchAnimation = stretch
            let indicator = RingIndicatorView(options: ringOptions)
            return indicator
        }
    }

    func show(in viewController: UIViewController) {
        let responder = viewController.chrysan.hudResponder
        responder?.register(factory, for: .loading)
        viewController.chrysan.changeStatus(to: .loading(message: "正在加载"))
        viewController.chrysan.hide(afterDelay: 4)
    }
}

struct CircleDotsIndicatorExample: AnyChyrsanExample {
    let name = "Circle Dots Indicator"
    
    func show(in viewController: UIViewController) {
        let responder = viewController.chrysan.hudResponder
        responder?.register(.circleDots, for: .loading)
        viewController.chrysan.changeStatus(to: .loading(message: "正在加载"))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            viewController.chrysan.changeStatus(to: .loading(message: "正在处理"))
        }
        
        viewController.chrysan.hide(afterDelay: 4)
    }
}
