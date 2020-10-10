//
//  GIFIndicatorExample.swift
//  Example
//
//  Created by Harley-xk on 2020/10/9.
//  Copyright © 2020 Harley. All rights reserved.
//

import Foundation
import UIKit
import Chrysan

struct GIFIndicatorExample: AnyChyrsanExample {
    
    let name = "GIF Animating Indicator"
    
    func show(in viewController: UIViewController) {
        let asset = NSDataAsset(name: "infinity-red")!
//        let asset = NSDataAsset(name: "ripple")!
//        let asset = NSDataAsset(name: "double-ring")!
        let indicator = HUDIndicatorFactory.gifIndicator(data: asset.data)
        viewController.chrysan.hudResponder?.register(indicator, for: .loading)
        viewController.chrysan.changeStatus(to: .loading(message: "Using GIF"))
        viewController.chrysan.hide(afterDelay: 6)
    }
}
