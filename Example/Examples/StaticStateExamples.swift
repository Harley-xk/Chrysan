//
//  StaticStateExamples.swift
//  Example
//
//  Created by Harley-xk on 2020/10/4.
//  Copyright © 2020 Harley. All rights reserved.
//

import Foundation
import Chrysan
import UIKit

struct SuccessStateExample: AnyChyrsanExample {
    
    let name = "Success State"
    
    func show(in viewController: UIViewController) {
        viewController.chrysan.changeStatus(to: .success(message: "保存成功"))
        viewController.chrysan.hide(afterDelay: 1)
    }
}

struct FailureStateExample: AnyChyrsanExample {
    
    let name = "Failure State"
    
    func show(in viewController: UIViewController) {
        viewController.chrysan.changeStatus(to: .failure(message: "保存成功"))
        viewController.chrysan.hide(afterDelay: 1)
    }
}
