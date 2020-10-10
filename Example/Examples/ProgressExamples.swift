//
//  ProgressExamples.swift
//  Example
//
//  Created by Harley-xk on 2020/10/4.
//  Copyright © 2020 Harley. All rights reserved.
//

import Foundation
import UIKit
import Chrysan

class ProgressExample: AnyChyrsanExample {
    
    var name: String = "Progress Example"
    var timer: Timer!
    
    func startProgress() {
        progress = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (_) in
            self.updateProgress()
            self.progress += Double.random(in: 0 ... 0.2)
        })
    }
    
    private var progress: Double = 0
    
    func updateProgress() {
        host?.chrysan.showHUD(progress: progress, message: "正在下载")
//        host?.chrysan.changeStatus(to: .progress(message: "正在下载", progress: progress))
        if progress > 1 {
            timer.invalidate()
            timer = nil
            DispatchQueue.main.async {
                self.progresFinished()
            }
        }
    }
    
    weak var host: UIViewController?
    
    func show(in viewController: UIViewController) {
        host = viewController
        viewController.chrysan.changeStatus(to: .loading(message: "准备下载"))
        DispatchQueue.main.asyncAfter(seconds: 1) {
            self.startProgress()
        }
    }
    
    func progresFinished() {
        host?.chrysan.changeStatus(to: .loading(message: "正在保存"))
        DispatchQueue.main.asyncAfter(seconds: 1) {
            self.host?.chrysan.changeStatus(to: .success(message: "保存成功"))
            self.host?.chrysan.hide(afterDelay: 1)
        }
    }
}

class RingProgressExample: ProgressExample {
    
    override init() {
        super.init()
        name = "Ring Progress Example"
    }

    override func show(in viewController: UIViewController) {
        viewController.chrysan.hudResponder?.register(.ringProgress, for: .progress)
        super.show(in: viewController)
    }
}

class BarProgressExample: ProgressExample {
    
    override init() {
        super.init()
        name = "Bar Progress Example"
    }

    override func show(in viewController: UIViewController) {
        viewController.chrysan.hudResponder?.register(.barProgress(textColor: .white), for: .progress)
        super.show(in: viewController)
    }
}

