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
