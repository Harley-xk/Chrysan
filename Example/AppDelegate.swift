//
//  AppDelegate.swift
//  Example
//
//  Created by Harley-xk on 2020/6/1.
//  Copyright © 2020 Harley. All rights reserved.
//

import UIKit
import Chrysan

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let options = HUDResponder.global.viewOptions
        options.mainColor = .systemRed
        options.maskColor = UIColor.label.withAlphaComponent(0.2)
        options.hudVisualEffect = UIBlurEffect(style: .prominent)
        options.hudCornerRadius = 10
        
        HUDResponder.global.register(.circleDots, for: .loading)

        return true
    }

}

