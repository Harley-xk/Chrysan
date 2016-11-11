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

    var hud: ChrysanView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        hud = ChrysanView.chrysan(withView: view)
        
//        chrysan.show(message: "Running")
//        
//        chrysan.show(.plain, message: "Running")
//        
//        chrysan.show(.running, message: "Progress", hideAfterSeconds: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAction(_ sender: Any) {
        hud.show(hideAfterSeconds: 1)
        
    }
    @IBAction func showMessageAction(_ sender: Any) {
    }
    @IBOutlet weak var showProgressAction: UIButton!
}

