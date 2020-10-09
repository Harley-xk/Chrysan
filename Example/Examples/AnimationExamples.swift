//
//  SpringAnimationExample.swift
//  Example
//
//  Created by Harley-xk on 2020/9/30.
//  Copyright © 2020 Harley. All rights reserved.
//

import Foundation
import Chrysan
import UIKit

struct SpringAnimationExample: AnyChyrsanExample {
    
    let name = "Spring Animations"
    
    func show(in viewController: UIViewController) {
        let responder = viewController.chrysan.hudResponder
        responder?.animatorProvider = SpringAnimatorProvider(
            duraction: 0.25,
            dampingRatio: 0.5
        )
        viewController.chrysan.showHUD(.success(message: "Animation Changed!"), hideAfterDelay: 1)
    }
}

struct CubicAnimationExample: AnyChyrsanExample {
    
    let name = "Cubic Animations"
    
    func show(in viewController: UIViewController) {
        let responder = viewController.chrysan.hudResponder
        responder?.animatorProvider = CubicAnimatorProvider()
        viewController.chrysan.changeStatus(to: .success(message: "Animation Changed!"))
        viewController.chrysan.hide(afterDelay: 1)
    }
}

