//
//  DetailViewController.swift
//  Example
//
//  Created by Harley-xk on 2020/6/1.
//  Copyright © 2020 Harley. All rights reserved.
//

import UIKit
import Chrysan

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if #available(iOS 13.0, *) {
            let color: UIColor = .systemTeal
            view.chrysan.hudResponder?.viewOptions.mainColor = color
            view.chrysan.hudResponder?.viewOptions.progressColor = color
        } else {
            // Fallback on earlier versions
        }

        let hudResponder = view.chrysan.hudResponder
        hudResponder?.layout.position = .bottom
        hudResponder?.layout.offset = CGPoint(x: 0, y: 20)
        
//        hudResponder?.indicatorProvider = CustomIndicatorProvider()
    }

    @IBAction func showAction(_ sender: UIButton) {
        let hudResponder = view.chrysan.hudResponder
        switch sender.tag {
        case 0:
            hudResponder?.layout.position = .top
            hudResponder?.layout.offset = CGPoint(x: 0, y: 20)
        case 2:
            hudResponder?.layout.position = .bottom
            hudResponder?.layout.offset = CGPoint(x: 0, y: 20)
        default:
            hudResponder?.layout.position = .center
            hudResponder?.layout.offset = .zero
        }

        self.view.chrysan.changeStatus(to: .loading(message: "准备上传"))
        
        excute(after: 0.5) {
            self.progress = 0
            self.progressTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { _ in
                self.updateProgress()
                self.progress += Double.random(in: 0 ... 0.1)
            })
        }
    }
    
    private var progressTimer: Timer?
    private var progress: Double = 0
    
    func updateProgress() {
//        let text = String(format: "%.0f", progress * 10000) + "/10000"
//        view.chrysan.updateProgress(progress, message: "正在上传", progressText: text)
        view.chrysan.updateProgress(progress, message: "正在上传")
        if progress >= 1 {
            progressTimer?.invalidate()
            progressTimer = nil
            finishAndHideChrysan()
        }
    }
    
    func finishAndHideChrysan() {
        view.chrysan.changeStatus(to: .success(message: "上传成功"))
        
        excute(after: 1) {
            self.view.chrysan.changeStatus(to: .failure(message: "上传失败"))
        }
        
        view.chrysan.hide(afterDelay: 2)
    }
    
    func excute(after seconds: TimeInterval, task: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(seconds * 1000))) {
            task()
        }
    }
    
}

class CustomIndicatorProvider: HUDIndicatorProvider {
    
    override func makeProgressIndicatorView(options: HUDStatusView.Options) -> StatusIndicatorView {
        var barOptions = HUDBarProgressView.Options()
        barOptions.textColor = .white
        barOptions.barColor = options.progressColor
        barOptions.barSize = CGSize(width: 150, height: 16)
        return HUDBarProgressView.makeBar(with: barOptions)
    }
}
