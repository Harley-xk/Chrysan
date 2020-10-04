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

struct PlainTextExample: AnyChyrsanExample {
    
    var name: String
    
    var message: String
    
    init(name: String, message: String) {
        self.name = name
        self.message = message
    }
    
    func show(in viewController: UIViewController) {
        viewController.chrysan.changeStatus(to: .plain(message: message))
        viewController.chrysan.hide(afterDelay: 1)
    }
    
    static let shortExample = PlainTextExample(name: "Short Plain Text", message: "This is a short plain message")
    static let longExample = PlainTextExample(name: "Long Plain Text", message: """
                Documentation, guides, and help topics for software developers, designers, and project managers. Covers using Git, pull requests, issues, wikis, gists, and everything you need to make the most of GitHub for development.
                """)
}
