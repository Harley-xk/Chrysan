//
//  ConcorencyExamples.swift
//  Example
//
//  Created by Harley-xk on 2022/6/16.
//  Copyright © 2022 Harley. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 13.0.0, *)
struct AutoTaskExample: AnyChyrsanExample {

    var name: String {
        return "Auto show & hide with async task"
    }

    func show(in viewController: UIViewController) {
        viewController.chrysan.loading("doing some long time tasks") {
            await veryLongTimeTask()
        }
    }


    func veryLongTimeTask() async {
        sleep(8)
    }
}
