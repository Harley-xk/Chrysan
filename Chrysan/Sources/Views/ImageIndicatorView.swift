//
//  ImageIndicatorView.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/10/4.
//  Copyright © 2020 Harley. All rights reserved.
//

import UIKit
import ImageIO

extension UIImageView: StatusIndicatorView {
    
    public func updateStatus(from: Status, to new: Status) {
        if !isAnimating, new != .idle {
            startAnimating()
        }
    }
    
    public func displayGIF(from data: Data, duraction: TimeInterval? = nil) {
        
        let info: [String: Any] = [
            kCGImageSourceShouldCache as String: true,
        ]
        
        guard let imageSource = CGImageSourceCreateWithData(data as CFData, info as CFDictionary) else {
            return
        }

        let frameCount = CGImageSourceGetCount(imageSource)
        var images = [UIImage]()
        
        for i in 0 ..< frameCount {
            guard let imageRef = CGImageSourceCreateImageAtIndex(imageSource, i, info as CFDictionary) else {
                return
            }
            images.append(UIImage(cgImage: imageRef, scale: contentScaleFactor, orientation: .up))
        }
        animationImages = images
        image = images.first

        if let duraction = duraction {
            self.animationDuration = duraction
        }        
    }
}

