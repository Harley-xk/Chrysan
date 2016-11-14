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

        chrysan.show(.plain, message:"阿道夫啊的身份阿道夫安德森安德森啊的身份啊的身份安德森啊的身份啊的身份安德森阿瑟费阿萨德发水淀粉啊的身份啊水淀粉啊的身份啊水淀粉啊水淀粉安德森分啊的身份啊的身份啊水淀粉啊的身份啊的身份啊水淀粉啊的身份啊水淀粉安德森", hideAfterSeconds: 1)
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
        }else {
            chrysan.hudStyle = .dark
            chrysan.color = .white
            chrysan.chrysanStyle = .whiteLarge

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

