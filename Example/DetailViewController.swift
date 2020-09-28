//
//  DetailViewController.swift
//  Example
//
//  Created by Harley-xk on 2020/6/1.
//  Copyright © 2020 Harley. All rights reserved.
//

import UIKit
import Chrysan
import Comet

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
        
        let hudResponder = view.chrysan.responder as? HUDResponder
        hudResponder?.layout.position = .bottom
        hudResponder?.layout.offset = CGPoint(x: 0, y: 20)
    }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            configureView()
        }
    }

    @IBAction func showAction(_ sender: UIButton) {
        let hudResponder = view.chrysan.responder as? HUDResponder
        hudResponder?.indicatorProvider = CurtomIndicatorProvider()
//        hudResponder?.layout.indicatorSize = CGSize(width: 100, height: 100)
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
//            hudResponder?.layout.offset = CGPoint(x: 30, y: 0)
        }
        
//        view.chrysan.changeStatus(to: .loading(message: "正在获取"))

//        DispatchQueue.main.asyncAfter(delay: 2) {
            self.view.chrysan.changeStatus(to: .loading(message: "准备上传"))
//        }
        
        DispatchQueue.main.asyncAfter(delay: 0.5) {
            self.progress = 0
            self.progressTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { _ in
                self.updateProgress()
            })
        }
//        
    }
    
    private var progressTimer: Timer?
    private var progress: Double = 0
    
    func updateProgress() {
        progress += 0.05
        view.chrysan.updateProgress(progress, message: "正在上传")
        
        if progress >= 1 {
            view.chrysan.hide(afterDelay: 1)
            progressTimer?.invalidate()
            progressTimer = nil
        }
    }
    
}

class CurtomIndicatorProvider: HUDIndicatorProvider {
    
    override func makeProgressIndicatorView() -> StatusIndicatorView {
        var options = HUDBarProgressView.Options()
        options.barColor = .systemRed
        return HUDBarProgressView.makeBar(with: options)
    }
}
