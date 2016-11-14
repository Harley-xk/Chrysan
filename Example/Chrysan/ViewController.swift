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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        hud = ChrysanView.chrysan(withView: view)
        
        chrysan.hudStyle = .light
        chrysan.color = .black
        chrysan.chrysanStyle = .gray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAction(_ sender: Any) {

        chrysan.show(.plain, message:"GitHub is how people build software\nWe’re supporting a community where more than 18 million people learn, share, and work together to build software.\nCome help us make collaboration even better. We’ve built a company we truly love working for, and we think you will too.\nDevelopers from all around the world are building amazing things together. Their story is our story.\nLearn about the latest company info, new features, and general goings-on at GitHub.\nWe continuously monitor the status of github.com and all its related services. If there are any interruptions in service, a note will be posted here.", hideAfterSeconds: 5)
    }
    
    @IBAction func showMessageAction(_ sender: Any) {
        chrysan.show(message: "正在加载")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.chrysan.show(.succeed, message: "处理完毕", hideAfterSeconds: 1)
        })

    }

    @IBAction func changeStyleAction(_ sender: Any) {
        if chrysan.hudStyle == .dark {
            chrysan.hudStyle = .light
            chrysan.color = .black
            chrysan.chrysanStyle = .gray
            chrysan.show(.plain, message:"Changed to Light", hideAfterSeconds:1)
        }else {
            chrysan.hudStyle = .dark
            chrysan.color = .white
            chrysan.chrysanStyle = .whiteLarge
            chrysan.show(.plain, message:"Changed to Dark", hideAfterSeconds:1)
        }
    }

    @IBAction func showProgressAction(_ sender: Any) {
        updateProgress(progress: 0)
    }
    
    func updateProgress(progress: CGFloat) {
        
        if progress > 1 {
            self.chrysan.show(.succeed, message: "下载完毕", hideAfterSeconds: 1)
        } else {
            chrysan.show(progress: progress, message: "下载中...")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                self.updateProgress(progress: progress + 0.002)
            })
        }
        
    }

}

