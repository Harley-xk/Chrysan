//
//  ViewController.swift
//  Chrysan
//
//  Created by Harley on 11/11/2016.
//  Copyright (c) 2016 Harley. All rights reserved.
//

import UIKit
import Chrysan

class ViewController: UIViewController {

//    var hud: ChrysanView!
    
    private var configs: [ChrysanConfig] = []
    private var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ChrysanConfig.default().color = .red
        configs.append(ChrysanConfig.default())
        
        let lightConfig = ChrysanConfig(name: "Light")
        lightConfig.hudStyle = .light
        lightConfig.color = .black
        lightConfig.chrysanStyle = .grayIndicator
        lightConfig.maskColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
        configs.append(lightConfig)

        let darkConfig = ChrysanConfig(name: "Dark")
        darkConfig.hudStyle = .dark
        darkConfig.color = .white
        darkConfig.chrysanStyle = .whiteLargeIndicator
        darkConfig.maskColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        configs.append(darkConfig)

        let animationConfig = ChrysanConfig(name: "Animation")

        var images: [UIImage] = []
        for i in 1 ... 9 {
            images.append(UIImage(named: "ani_\(i)")!)
        }
        animationConfig.hudStyle = .dark
        animationConfig.color = #colorLiteral(red: 0.07058823529, green: 0.5882352941, blue: 0.8588235294, alpha: 1)
        animationConfig.chrysanStyle = .animationImages(images)
        animationConfig.frameDuration = 0.06
        configs.append(animationConfig)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAction(_ sender: Any) {

        chrysan.show(.plain,
                     message:"GitHub is how people build software\nWe’re supporting a community where more than 18 million people learn, share, and work together to build software.\nCome help us make collaboration even better. We’ve built a company we truly love working for, and we think you will too.\nDevelopers from all around the world are building amazing things together. Their story is our story.",
                     hideDelay: 1)
    }
    
    @IBAction func showMessageAction(_ sender: Any) {
        chrysan.show(message: "正在加载")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.chrysan.show(.succeed, message: "处理完毕", hideDelay: 1)
        })
    }

    @IBAction func changeStyleAction(_ sender: Any) {
        index += 1
        if index >= configs.count {
            index = 0
        }
        let config = configs[index]
        chrysan.config = config
        chrysan.show(.plain, message:"Changed to \(config.name!)", hideDelay:1)
    }

    @IBAction func showProgressAction(_ sender: Any) {
        updateProgress(progress: 0)
    }
    
    func updateProgress(progress: CGFloat) {
        
        if progress > 1 {
            self.chrysan.show(.succeed, message: "下载完毕", hideDelay: 1)
        } else {
            let pString = String(format: "%.0f", progress * 100)
            chrysan.show(progress: progress, message: "下载中...", progressText: pString)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                self.updateProgress(progress: progress + 0.002)
            })
        }
    }
    
    @IBAction func showProgressWithCustomText() {
        updateCount(finished: 0)
    }

    func updateCount(finished: Int) {
        
        if finished > 10 {
            self.chrysan.show(.succeed, message: "处理完毕", hideDelay: 1)
        } else {
            let progress = CGFloat(finished) / 10
            chrysan.show(progress: progress, message: "正在处理", progressText: "\(finished)/10")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.updateCount(finished: finished + 1)
            })
        }
    }

}

public extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}

